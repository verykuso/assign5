PImage bg1,bg2,fighter,hp,treasure,start1,start2,end1,end2,shoot,enemy;
int enemyCount = 8;
int enemy_shape,game_state,game_start=0,game_run=1,game_end=2,score = 0;
float fighterX,fighterY,treasureX,treasureY,bg1X=640,bg2X=0,hpRate=4,enemy_space,yy;
int[] enemyX = new int[enemyCount];
int[] enemyY = new int[enemyCount];
boolean goUp = false;
boolean goDown = false;
boolean goLeft = false;
boolean goRight = false;
boolean[] fire = new boolean[5];
float[] shootX = new float[5];
float[] shootY = new float[5];
PFont word;
boolean isHit(float ax,float ay,float aw,float ah,float bx,float by,float bw,float bh)
{
 if(((ax>=bx&&ax<=bx+bw&&ay>=by&&ay<=by+bh)||(ax+aw>=bx&&ax+aw<=bx+bw&&ay+ah>=by&&ay+ah<=by+bh)) &&(bx != -1 || by != -1))
  return true;
 else return false;
 }
void scoreChange(int value)
{
score+=value;
}
void setup () {
  size(640, 480) ;
  word = createFont("Arial",25);
  textFont(word);
  enemy = loadImage("img/enemy.png");
  start1=loadImage("img/start1.png");
  start2=loadImage("img/start2.png");
  bg1=loadImage("img/bg1.png");
  bg2=loadImage("img/bg2.png");
  treasure=loadImage("img/treasure.png");
  fighter=loadImage("img/fighter.png");
  shoot=loadImage("img/shoot.png");
  hp=loadImage("img/hp.png");  
  end1=loadImage("img/end1.png");
  end2=loadImage("img/end2.png");
  enemy_shape = 1;
  addEnemy(0);
  fighterX=width-50;
  fighterY=random(20,height-20);
  treasureX=random(50,width-50);
  treasureY=random(40,height-40);
  game_state = 0;
  //enemy_shape = 0;
  score = 0;
  //enemyY[0]=random(50,400);
  
}

void draw()
{
  background(0);
  
 switch(game_state){
    case 0://game_state case 0
     image(start2,0,0);
    if(mouseX>=207&&mouseX<=454&&mouseY>=378&&mouseY<=413) image(start1,0,0);
    
    if(mousePressed)
    if(mouseX>=207&&mouseX<=454&&mouseY>=378&&mouseY<=413)
      game_state = game_run;
      break;
    // end of game_state case 0  
      
   
   case 1:
  image(bg1,bg1X-640,0);
        bg1X+=3;
        bg1X%=1280;
        image(bg2,bg2X-640,0);
        bg2X+=3;
        bg2X%=1280;
  fill(255);text("Score: "+score,20,440);
  //fighter appears
      image(fighter,fighterX,fighterY);
      //fighter can not move beyond the area
   
     if(fighterX<=0) fighterX = 0;
     if(fighterX>=width-51) fighterX=width-51;
     if(fighterY<=0) fighterY=0;
     if(fighterY>=height-51) fighterY = height-51;
      // key-controlling the fighter 
      if(goUp) fighterY-=2;
      if(goDown) fighterY +=2;
      if(goLeft) fighterX -=2;
      if(goRight) fighterX +=2;
      //end of fighter controlling
      //HP bar appears
        fill(255,0,0);if(hpRate<=0) game_state = 2;
        rect(41,23,200*hpRate/10,20);
        image(hp,30,20);
     //end of HP    
      
      //TREASURE
    //treasure appears
       image(treasure,treasureX,treasureY);
  
  if((enemyX[4]>=width)&&(enemy_shape == 1))
    {
       addEnemy(1);
       enemy_shape = 2;}
   if((enemyX[4]>=width)&&(enemy_shape == 2)) 
   
     {
       addEnemy(2);
       enemy_shape = 0;}  
     if((enemyX[7]>=width)&&(enemy_shape == 0)) 
   
     {
       addEnemy(0);
       enemy_shape = 1;}  
       
       
       
  for (int i = 0; i < enemyCount; ++i) {
    if (enemyX[i] != -1 || enemyY[i] != -1) {
      image(enemy, enemyX[i], enemyY[i]);
      enemyX[i]+=5;
    }
  }
 for(int i=0;i<8;i++)
  if(isHit(fighterX,fighterY,fighter.width,fighter.height,enemyX[i],enemyY[i],enemy.width,enemy.height))
   {
   enemyX[i] = -999;
   enemyY[i] = -999;
   hpRate -=2;
   
    }
    
   if(isHit(fighterX,fighterY,fighter.width,fighter.height,treasureX,treasureY,treasure.width,treasure.height))  
{
 hpRate++;if(hpRate>=10) hpRate=10;
 treasureX=random(50,width-50);
  treasureY=random(40,height-40);
} 


   //FIRING    
    //發射子彈，如果出現值為true則出現並前進，如果越過邊界則出現值為false而消失，此時可再發射一顆子彈
 
   if(fire[0]==true){
   image(shoot,shootX[0]-=3,shootY[0]);
   if(shootX[0]<=-31){
    fire[0]=false;shootY[0]=-99;
   }
   }
   if(fire[1]==true){
   image(shoot,shootX[1]-=3,shootY[1]);
   if(shootX[1]<=-31){
   fire[1]=false;shootY[1]=-99;
   }
   }
   if(fire[2]==true){
   image(shoot,shootX[2]-=3,shootY[2]);
   if(shootX[2]<=-31){
   fire[2]=false;shootY[2]=-99;
   }
   }
   if(fire[3]==true){
   image(shoot,shootX[3]-=3,shootY[3]);
   if(shootX[3]<=-31){
   fire[3]=false;shootY[3]=-99;
   }
   }
   if(fire[4]==true){
   image(shoot,shootX[4]-=3,shootY[4]);
   if(shootX[4]<=-31){
   fire[4]=false;shootY[4]=-99;
   }
   }
   //end of FIRING   
 for(int j=0;j<8;j++)  
 for(int i=0;i<5;i++){
 
  if(isHit(shootX[i],shootY[i],shoot.width,shoot.height,enemyX[j],enemyY[j],enemy.width,enemy.height))
  {
  scoreChange(20);
  fire[i]=false;
  shootX[i]=-9999;shootY[i]=-9999;
  enemyX[j] = 9999;
   enemyY[j] = 9999;
  }
     else if(fire[i]==true&&shootX[i]<0) {fire[i]=false;shootX[i]=99999;}
 }
  break;
  
  case 2:
   image(end2,0,0);
   
   
    hpRate=4;//if not recovering here, game will be over soon.
    score = 0;
      addEnemy(0);   
            
          for(int i=0;i<5;i++) fire[i] = false;//let bullet all disappear
        if(205<mouseX&&mouseX<440&&305<mouseY&&mouseY<350)
        image(end1,0,0);
        
        if(205<mouseX&&mouseX<440&&305<mouseY&&mouseY<350&&mousePressed)
        {           
         game_state = game_run;
         //enemy_shape = 0;//if not set back to 0, it would keep the same shape as it ended
        }
  break;//end of case 2
 }//end of swithc(game_state) 
}

// 0 - straight, 1-slope, 2-dimond
void addEnemy(int type)
{  
  for (int i = 0; i < enemyCount; ++i) {
    enemyX[i] = -1;
    enemyY[i] = -1;
  }
  switch (type) {
    case 0:
      addStraightEnemy();
      break;
    case 1:
      addSlopeEnemy();
      break;
    case 2:
      addDiamondEnemy();
      break;
  }
}

void addStraightEnemy()
{
  float t = random(height - enemy.height);
  int h = int(t);
  for (int i = 0; i < 5; ++i) {

    enemyX[i] = (i+1)*-80;
    enemyY[i] = h;
  }
}
void addSlopeEnemy()
{
  float t = random(height - enemy.height * 5);
  int h = int(t);
  for (int i = 0; i < 5; ++i) {

    enemyX[i] = (i+1)*-80;
    enemyY[i] = h + i * 40;
  }
}
void addDiamondEnemy()
{
  float t = random( enemy.height * 3 ,height - enemy.height * 3);
  int h = int(t);
  int x_axis = 1;
  for (int i = 0; i < 8; ++i) {
    if (i == 0 || i == 7) {
      enemyX[i] = x_axis*-80;
      enemyY[i] = h;
      x_axis++;
    }
    else if (i == 1 || i == 5){
      enemyX[i] = x_axis*-80;
      enemyY[i] = h + 1 * 40;
      enemyX[i+1] = x_axis*-80;
      enemyY[i+1] = h - 1 * 40;
      i++;
      x_axis++;
      
    }
    else {
      enemyX[i] = x_axis*-80;
      enemyY[i] = h + 2 * 40;
      enemyX[i+1] = x_axis*-80;
      enemyY[i+1] = h - 2 * 40;
      i++;
      x_axis++;
    }
  }
}



void keyPressed(){
  //controlling the fighters
  if(key==CODED){
    switch(keyCode){
      case UP:
        goUp= true;
        break;
      case DOWN:
        goDown= true;
        break;
       case LEFT:
        goLeft= true;
        break;
      case RIGHT:
        goRight= true;
        break;
      
    }
  }
  //end of controlling 
  
  //FIRING
  //fire the bullet when press spacebar, when press the spacebar, if fire[i] is false the do the job and let fire[i] becomes to true, if fire[i] is still true then ignore it and go to the next fire[i]
  
  if(key==' '){
  if(fire[0]==false)
    {
      shootX[0]=fighterX;
      shootY[0]=fighterY;
      fire[0]=true;
    }
    else if(fire[1]==false)
     {
      shootX[1]=fighterX;
      shootY[1]=fighterY;
      fire[1]=true;
    }
     else if(fire[2]==false)
     {
      shootX[2]=fighterX;
      shootY[2]=fighterY;
      fire[2]=true;
    }
     else if(fire[3]==false)
     {
      shootX[3]=fighterX;
      shootY[3]=fighterY;
      fire[3]=true;
    }
     else if(fire[4]==false)
     {
      shootX[4]=fighterX;
      shootY[4]=fighterY;
      fire[4]=true;
    }
  }
  //end of firing
  
  
  
}


void keyReleased(){
  
  //controlling the fighters
  if(key==CODED){
    switch(keyCode){
      case UP:
        goUp= false;
        break;
      case DOWN:
        goDown= false;
        break;
       case LEFT:
        goLeft= false;
        break;
      case RIGHT:
        goRight= false;
        break;
    }
  }
  //end of controlling
  
  
}


void mouseClicked(){
  if(mouseX>=207&&mouseX<=454&&mouseY>=378&&mouseY<=413)
      game_state = game_run;
  
}

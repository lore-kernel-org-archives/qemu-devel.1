Received: from eggs.gnu.org ([2001:4830:134:3::10]:34627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1t-0001U9-VC
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1q-0004Yk-AD
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1q-0004Xr-0n
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AA817AE95
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:21 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:17:47 +0200
Message-Id: <20170504071811.3547-7-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 06/30] audio: remove Y8950 configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Juan Quintela <quintela@redhat.com>

Include file has never been on qemu and it has been undefined from the very beginning.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-id: 20170425223739.6703-3-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.h       |  20 -------
 hw/audio/fmopl.c       | 146 -------------------------------------------------
 hw/audio/Makefile.objs |   2 -
 3 files changed, 168 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index fdda7f9f51..96d958ac72 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -4,7 +4,6 @@
 /* --- select emulation chips --- */
 #define BUILD_YM3812 (HAS_YM3812)
 //#define BUILD_YM3526 (HAS_YM3526)
-//#define BUILD_Y8950  (HAS_Y8950)
 
 /* --- system optimize --- */
 /* select bit size of output : 8 or 16 */
@@ -28,11 +27,6 @@ typedef INT16 OPLSAMPLE;
 typedef unsigned char  OPLSAMPLE;
 #endif
 
-
-#if BUILD_Y8950
-#include "ymdeltat.h"
-#endif
-
 typedef void (*OPL_TIMERHANDLER)(int channel,double interval_Sec);
 typedef void (*OPL_IRQHANDLER)(int param,int irq);
 typedef void (*OPL_UPDATEHANDLER)(int param,int min_interval_us);
@@ -112,13 +106,6 @@ typedef struct fm_opl_f {
 	int	max_ch;			/* maximum channel                   */
 	/* Rhythm sention */
 	UINT8 rhythm;		/* Rhythm mode , key flag */
-#if BUILD_Y8950
-	/* Delta-T ADPCM unit (Y8950) */
-	YM_DELTAT *deltat;			/* DELTA-T ADPCM       */
-#endif
-	/* Keyboard / I/O interface unit (Y8950) */
-	UINT8 portDirection;
-	UINT8 portLatch;
 	OPL_PORTHANDLER_R porthandler_r;
 	OPL_PORTHANDLER_W porthandler_w;
 	int port_param;
@@ -150,16 +137,12 @@ typedef struct fm_opl_f {
 /* ---------- Generic interface section ---------- */
 #define OPL_TYPE_YM3526 (0)
 #define OPL_TYPE_YM3812 (OPL_TYPE_WAVESEL)
-#define OPL_TYPE_Y8950  (OPL_TYPE_ADPCM|OPL_TYPE_KEYBOARD|OPL_TYPE_IO)
 
 FM_OPL *OPLCreate(int type, int clock, int rate);
 void OPLDestroy(FM_OPL *OPL);
 void OPLSetTimerHandler(FM_OPL *OPL,OPL_TIMERHANDLER TimerHandler,int channelOffset);
 void OPLSetIRQHandler(FM_OPL *OPL,OPL_IRQHANDLER IRQHandler,int param);
 void OPLSetUpdateHandler(FM_OPL *OPL,OPL_UPDATEHANDLER UpdateHandler,int param);
-/* Y8950 port handlers */
-void OPLSetPortHandler(FM_OPL *OPL,OPL_PORTHANDLER_W PortHandler_w,OPL_PORTHANDLER_R PortHandler_r,int param);
-void OPLSetKeyboardHandler(FM_OPL *OPL,OPL_PORTHANDLER_W KeyboardHandler_w,OPL_PORTHANDLER_R KeyboardHandler_r,int param);
 
 void OPLResetChip(FM_OPL *OPL);
 int OPLWrite(FM_OPL *OPL,int a,int v);
@@ -168,7 +151,4 @@ int OPLTimerOver(FM_OPL *OPL,int c);
 
 /* YM3626/YM3812 local section */
 void YM3812UpdateOne(FM_OPL *OPL, INT16 *buffer, int length);
-
-void Y8950UpdateOne(FM_OPL *OPL, INT16 *buffer, int length);
-
 #endif
diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 731110fe86..29f6d3c5a4 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -812,57 +812,6 @@ static void OPLWriteReg(FM_OPL *OPL, int r, int v)
 				}
 			}
 			return;
-#if BUILD_Y8950
-		case 0x06:		/* Key Board OUT */
-			if(OPL->type&OPL_TYPE_KEYBOARD)
-			{
-				if(OPL->keyboardhandler_w)
-					OPL->keyboardhandler_w(OPL->keyboard_param,v);
-				else
-					LOG(LOG_WAR,("OPL:write unmapped KEYBOARD port\n"));
-			}
-			return;
-		case 0x07:	/* DELTA-T control : START,REC,MEMDATA,REPT,SPOFF,x,x,RST */
-			if(OPL->type&OPL_TYPE_ADPCM)
-				YM_DELTAT_ADPCM_Write(OPL->deltat,r-0x07,v);
-			return;
-		case 0x08:	/* MODE,DELTA-T : CSM,NOTESEL,x,x,smpl,da/ad,64k,rom */
-			OPL->mode = v;
-			v&=0x1f;	/* for DELTA-T unit */
-		case 0x09:		/* START ADD */
-		case 0x0a:
-		case 0x0b:		/* STOP ADD  */
-		case 0x0c:
-		case 0x0d:		/* PRESCALE   */
-		case 0x0e:
-		case 0x0f:		/* ADPCM data */
-		case 0x10: 		/* DELTA-N    */
-		case 0x11: 		/* DELTA-N    */
-		case 0x12: 		/* EG-CTRL    */
-			if(OPL->type&OPL_TYPE_ADPCM)
-				YM_DELTAT_ADPCM_Write(OPL->deltat,r-0x07,v);
-			return;
-#if 0
-		case 0x15:		/* DAC data    */
-		case 0x16:
-		case 0x17:		/* SHIFT    */
-			return;
-		case 0x18:		/* I/O CTRL (Direction) */
-			if(OPL->type&OPL_TYPE_IO)
-				OPL->portDirection = v&0x0f;
-			return;
-		case 0x19:		/* I/O DATA */
-			if(OPL->type&OPL_TYPE_IO)
-			{
-				OPL->portLatch = v;
-				if(OPL->porthandler_w)
-					OPL->porthandler_w(OPL->port_param,v&OPL->portDirection);
-			}
-			return;
-		case 0x1a:		/* PCM data */
-			return;
-#endif
-#endif
 		}
 		break;
 	case 0x20:	/* am,vib,ksr,eg type,mul */
@@ -1097,68 +1046,6 @@ void YM3812UpdateOne(FM_OPL *OPL, INT16 *buffer, int length)
 }
 #endif /* (BUILD_YM3812 || BUILD_YM3526) */
 
-#if BUILD_Y8950
-
-void Y8950UpdateOne(FM_OPL *OPL, INT16 *buffer, int length)
-{
-    int i;
-	int data;
-	OPLSAMPLE *buf = buffer;
-	UINT32 amsCnt  = OPL->amsCnt;
-	UINT32 vibCnt  = OPL->vibCnt;
-	UINT8 rhythm = OPL->rhythm&0x20;
-	OPL_CH *CH,*R_CH;
-	YM_DELTAT *DELTAT = OPL->deltat;
-
-	/* setup DELTA-T unit */
-	YM_DELTAT_DECODE_PRESET(DELTAT);
-
-	if( (void *)OPL != cur_chip ){
-		cur_chip = (void *)OPL;
-		/* channel pointers */
-		S_CH = OPL->P_CH;
-		E_CH = &S_CH[9];
-		/* rhythm slot */
-		SLOT7_1 = &S_CH[7].SLOT[SLOT1];
-		SLOT7_2 = &S_CH[7].SLOT[SLOT2];
-		SLOT8_1 = &S_CH[8].SLOT[SLOT1];
-		SLOT8_2 = &S_CH[8].SLOT[SLOT2];
-		/* LFO state */
-		amsIncr = OPL->amsIncr;
-		vibIncr = OPL->vibIncr;
-		ams_table = OPL->ams_table;
-		vib_table = OPL->vib_table;
-	}
-	R_CH = rhythm ? &S_CH[6] : E_CH;
-    for( i=0; i < length ; i++ )
-	{
-		/*            channel A         channel B         channel C      */
-		/* LFO */
-		ams = ams_table[(amsCnt+=amsIncr)>>AMS_SHIFT];
-		vib = vib_table[(vibCnt+=vibIncr)>>VIB_SHIFT];
-		outd[0] = 0;
-		/* deltaT ADPCM */
-		if( DELTAT->portstate )
-			YM_DELTAT_ADPCM_CALC(DELTAT);
-		/* FM part */
-		for(CH=S_CH ; CH < R_CH ; CH++)
-			OPL_CALC_CH(CH);
-		/* Rythn part */
-		if(rhythm)
-			OPL_CALC_RH(S_CH);
-		/* limit check */
-		data = Limit( outd[0] , OPL_MAXOUT, OPL_MINOUT );
-		/* store to sound buffer */
-		buf[i] = data >> OPL_OUTSB;
-	}
-	OPL->amsCnt = amsCnt;
-	OPL->vibCnt = vibCnt;
-	/* deltaT START flag */
-	if( !DELTAT->portstate )
-		OPL->status &= 0xfe;
-}
-#endif
-
 /* ---------- reset one of chip ---------- */
 void OPLResetChip(FM_OPL *OPL)
 {
@@ -1189,18 +1076,6 @@ void OPLResetChip(FM_OPL *OPL)
 			CH->SLOT[s].evs = 0;
 		}
 	}
-#if BUILD_Y8950
-	if(OPL->type&OPL_TYPE_ADPCM)
-	{
-		YM_DELTAT *DELTAT = OPL->deltat;
-
-		DELTAT->freqbase = OPL->freqbase;
-		DELTAT->output_pointer = outd;
-		DELTAT->portshift = 5;
-		DELTAT->output_range = DELTAT_MIXING_LEVEL<<TL_BITS;
-		YM_DELTAT_ADPCM_Reset(DELTAT,0);
-	}
-#endif
 }
 
 /* ----------  Create one of vietual YM3812 ----------       */
@@ -1216,9 +1091,6 @@ FM_OPL *OPLCreate(int type, int clock, int rate)
 	/* allocate OPL state space */
 	state_size  = sizeof(FM_OPL);
 	state_size += sizeof(OPL_CH)*max_ch;
-#if BUILD_Y8950
-	if(type&OPL_TYPE_ADPCM) state_size+= sizeof(YM_DELTAT);
-#endif
 	/* allocate memory block */
 	ptr = malloc(state_size);
 	if(ptr==NULL) return NULL;
@@ -1226,9 +1098,6 @@ FM_OPL *OPLCreate(int type, int clock, int rate)
 	memset(ptr,0,state_size);
 	OPL        = (FM_OPL *)ptr; ptr+=sizeof(FM_OPL);
 	OPL->P_CH  = (OPL_CH *)ptr; ptr+=sizeof(OPL_CH)*max_ch;
-#if BUILD_Y8950
-	if(type&OPL_TYPE_ADPCM) OPL->deltat = (YM_DELTAT *)ptr; ptr+=sizeof(YM_DELTAT);
-#endif
 	/* set channel state pointer */
 	OPL->type  = type;
 	OPL->clock = clock;
@@ -1290,21 +1159,6 @@ void OPLSetUpdateHandler(FM_OPL *OPL,OPL_UPDATEHANDLER UpdateHandler,int param)
 	OPL->UpdateHandler = UpdateHandler;
 	OPL->UpdateParam = param;
 }
-#if BUILD_Y8950
-void OPLSetPortHandler(FM_OPL *OPL,OPL_PORTHANDLER_W PortHandler_w,OPL_PORTHANDLER_R PortHandler_r,int param)
-{
-	OPL->porthandler_w = PortHandler_w;
-	OPL->porthandler_r = PortHandler_r;
-	OPL->port_param = param;
-}
-
-void OPLSetKeyboardHandler(FM_OPL *OPL,OPL_PORTHANDLER_W KeyboardHandler_w,OPL_PORTHANDLER_R KeyboardHandler_r,int param)
-{
-	OPL->keyboardhandler_w = KeyboardHandler_w;
-	OPL->keyboardhandler_r = KeyboardHandler_r;
-	OPL->keyboard_param = param;
-}
-#endif
 /* ---------- YM3812 I/O interface ---------- */
 int OPLWrite(FM_OPL *OPL,int a,int v)
 {
diff --git a/hw/audio/Makefile.objs b/hw/audio/Makefile.objs
index 7ce85a2e88..bb6f07a91e 100644
--- a/hw/audio/Makefile.objs
+++ b/hw/audio/Makefile.objs
@@ -14,5 +14,3 @@ common-obj-$(CONFIG_PL041) += pl041.o lm4549.o
 common-obj-$(CONFIG_CS4231) += cs4231.o
 common-obj-$(CONFIG_MARVELL_88W8618) += marvell_88w8618.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-ac97.o
-
-$(obj)/adlib.o $(obj)/fmopl.o: QEMU_CFLAGS += -DBUILD_Y8950=0
-- 
2.9.3

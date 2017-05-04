Received: from eggs.gnu.org ([2001:4830:134:3::10]:34679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1v-0001UU-1G
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1r-0004aP-Sz
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1r-0004ZQ-KW
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ACB484E047
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:22 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:17:58 +0200
Message-Id: <20170504071811.3547-18-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 17/30] audio: Remove type field
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

It was not used anymore as now there is only one type of devices.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-id: 20170425223739.6703-14-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.h |  7 +------
 hw/audio/adlib.c |  2 +-
 hw/audio/fmopl.c | 20 ++++++++------------
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index 8ef0b3e3c3..df790a0b7d 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -11,8 +11,6 @@ typedef unsigned char (*OPL_PORTHANDLER_R)(int param);
 
 /* !!!!! here is private section , do not access there member direct !!!!! */
 
-#define OPL_TYPE_WAVESEL   0x01  /* waveform select    */
-
 /* Saving is necessary for member of the 'R' mark for suspend/resume */
 /* ---------- OPL one of slot  ---------- */
 typedef struct fm_opl_slot {
@@ -62,7 +60,6 @@ typedef struct fm_opl_channel {
 
 /* OPL state */
 typedef struct fm_opl_f {
-	uint8_t type;			/* chip type                         */
 	int clock;			/* master clock  (Hz)                */
 	int rate;			/* sampling rate (Hz)                */
 	double freqbase;	/* frequency base                    */
@@ -108,9 +105,7 @@ typedef struct fm_opl_f {
 } FM_OPL;
 
 /* ---------- Generic interface section ---------- */
-#define OPL_TYPE_YM3812 (OPL_TYPE_WAVESEL)
-
-FM_OPL *OPLCreate(int type, int clock, int rate);
+FM_OPL *OPLCreate(int clock, int rate);
 void OPLDestroy(FM_OPL *OPL);
 void OPLSetTimerHandler(FM_OPL *OPL,OPL_TIMERHANDLER TimerHandler,int channelOffset);
 void OPLSetIRQHandler(FM_OPL *OPL,OPL_IRQHANDLER IRQHandler,int param);
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index f9adcd709a..09b8248cda 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -265,7 +265,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
     }
     glob_adlib = s;
 
-    s->opl = OPLCreate (OPL_TYPE_YM3812, 3579545, s->freq);
+    s->opl = OPLCreate (3579545, s->freq);
     if (!s->opl) {
         error_setg (errp, "OPLCreate %d failed", s->freq);
         return;
diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 9171001030..48db828a49 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -761,18 +761,15 @@ static void OPLWriteReg(FM_OPL *OPL, int r, int v)
 		{
 		case 0x01:
 			/* wave selector enable */
-			if(OPL->type&OPL_TYPE_WAVESEL)
+			OPL->wavesel = v&0x20;
+                        if(!OPL->wavesel)
 			{
-				OPL->wavesel = v&0x20;
-				if(!OPL->wavesel)
+				/* preset compatible mode */
+				int c;
+				for(c=0;c<OPL->max_ch;c++)
 				{
-					/* preset compatible mode */
-					int c;
-					for(c=0;c<OPL->max_ch;c++)
-					{
-						OPL->P_CH[c].SLOT[SLOT1].wavetable = &SIN_TABLE[0];
-						OPL->P_CH[c].SLOT[SLOT2].wavetable = &SIN_TABLE[0];
-					}
+					OPL->P_CH[c].SLOT[SLOT1].wavetable = &SIN_TABLE[0];
+					OPL->P_CH[c].SLOT[SLOT2].wavetable = &SIN_TABLE[0];
 				}
 			}
 			return;
@@ -1076,7 +1073,7 @@ void OPLResetChip(FM_OPL *OPL)
 
 /* ----------  Create one of vietual YM3812 ----------       */
 /* 'rate'  is sampling rate and 'bufsiz' is the size of the  */
-FM_OPL *OPLCreate(int type, int clock, int rate)
+FM_OPL *OPLCreate(int clock, int rate)
 {
 	char *ptr;
 	FM_OPL *OPL;
@@ -1095,7 +1092,6 @@ FM_OPL *OPLCreate(int type, int clock, int rate)
 	OPL        = (FM_OPL *)ptr; ptr+=sizeof(FM_OPL);
 	OPL->P_CH  = (OPL_CH *)ptr; ptr+=sizeof(OPL_CH)*max_ch;
 	/* set channel state pointer */
-	OPL->type  = type;
 	OPL->clock = clock;
 	OPL->rate  = rate;
 	OPL->max_ch = max_ch;
-- 
2.9.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:34851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1y-0001Wa-8s
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1t-0004d8-9V
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1t-0004bP-0N
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D50D61D05
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:24 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:18:00 +0200
Message-Id: <20170504071811.3547-20-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 19/30] audio: GUSbyte is uint8_t
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-id: 20170425223739.6703-16-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/gusemu.h       |  6 ++---
 hw/audio/gusemu_hal.c   | 58 ++++++++++++++++++++++++-------------------------
 hw/audio/gusemu_mixer.c |  4 ++--
 3 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/hw/audio/gusemu.h b/hw/audio/gusemu.h
index 9aec7bf8e7..3a69222281 100644
--- a/hw/audio/gusemu.h
+++ b/hw/audio/gusemu.h
@@ -28,14 +28,12 @@
 /* data types (need to be adjusted if neither a VC6 nor a C99 compatible compiler is used) */
 
 #if defined _WIN32 && defined _MSC_VER /* doesn't support other win32 compilers yet, do it yourself... */
- typedef unsigned char GUSbyte;
  typedef unsigned short GUSword;
  typedef unsigned int GUSdword;
  typedef signed char GUSchar;
  typedef signed short GUSsample;
 #else
  typedef int8_t GUSchar;
- typedef uint8_t GUSbyte;
  typedef uint16_t GUSword;
  typedef uint32_t GUSdword;
  typedef int16_t GUSsample;
@@ -43,8 +41,8 @@
 
 typedef struct _GUSEmuState
 {
- GUSbyte *himemaddr; /* 1024*1024 bytes used for storing uploaded samples (+32 additional bytes for read padding) */
- GUSbyte *gusdatapos; /* (gusdataend-gusdata) bytes used for storing emulated GF1/mixer register states (32*32+4 bytes in initial GUSemu32 version) */
+ uint8_t *himemaddr; /* 1024*1024 bytes used for storing uploaded samples (+32 additional bytes for read padding) */
+ uint8_t *gusdatapos; /* (gusdataend-gusdata) bytes used for storing emulated GF1/mixer register states (32*32+4 bytes in initial GUSemu32 version) */
  uint32_t gusirq;
  uint32_t gusdma;
  unsigned int timer1fraction;
diff --git a/hw/audio/gusemu_hal.c b/hw/audio/gusemu_hal.c
index 973d6b9f4f..444a2bbb22 100644
--- a/hw/audio/gusemu_hal.c
+++ b/hw/audio/gusemu_hal.c
@@ -39,7 +39,7 @@ unsigned int gus_read(GUSEmuState * state, int port, int size)
 {
     int             value_read = 0;
 
-    GUSbyte        *gusptr;
+    uint8_t        *gusptr;
     gusptr = state->gusdatapos;
     GUSregd(portaccesses)++;
 
@@ -125,7 +125,7 @@ unsigned int gus_read(GUSEmuState * state, int port, int size)
                 if (!GUSregb(IRQStatReg2x6))
                     GUS_irqclear(state, state->gusirq);
             }
-            return (GUSbyte) value_read;
+            return (uint8_t) value_read;
             /* DramDMAmemPosReg */
             /* case 0x42: value_read=GUSregw(GUS42DMAStart); break;*/
             /* 43h+44h write only */
@@ -178,7 +178,7 @@ unsigned int gus_read(GUSEmuState * state, int port, int size)
         /*  return 0xff; */ /* Pre 3.6 boards, ICS mixer NOT present */
     case 0x307:                                     /* DRAMaccess */
         {
-            GUSbyte        *adr;
+            uint8_t        *adr;
             adr = state->himemaddr + (GUSregd(GUSDRAMPOS24bit) & 0xfffff);
             return *adr;
         }
@@ -189,14 +189,14 @@ unsigned int gus_read(GUSEmuState * state, int port, int size)
 
 void gus_write(GUSEmuState * state, int port, int size, unsigned int data)
 {
-    GUSbyte        *gusptr;
+    uint8_t        *gusptr;
     gusptr = state->gusdatapos;
     GUSregd(portaccesses)++;
 
     switch (port & 0xff0f)
     {
     case 0x200:                 /* MixerCtrlReg */
-        GUSregb(MixerCtrlReg2x0) = (GUSbyte) data;
+        GUSregb(MixerCtrlReg2x0) = (uint8_t) data;
         break;
     case 0x206:                 /* IRQstatReg / SB2x6IRQ */
         if (GUSregb(GUS45TimerCtrl) & 0x20) /* SB IRQ enabled? -> set 2x6IRQ bit */
@@ -208,7 +208,7 @@ void gus_write(GUSEmuState * state, int port, int size, unsigned int data)
         break;
     case 0x308:                /* AdLib 388h */
     case 0x208:                /* AdLibCommandReg */
-        GUSregb(AdLibCommand2xA) = (GUSbyte) data;
+        GUSregb(AdLibCommand2xA) = (uint8_t) data;
         break;
     case 0x309:                /* AdLib 389h */
     case 0x209:                /* AdLibDataReg */
@@ -217,11 +217,11 @@ void gus_write(GUSEmuState * state, int port, int size, unsigned int data)
             if (data & 0x80)
                 GUSregb(TimerStatus2x8) &= 0x1f; /* AdLib IRQ reset? -> clear maskable adl. timer int regs */
             else
-                GUSregb(TimerDataReg2x9) = (GUSbyte) data;
+                GUSregb(TimerDataReg2x9) = (uint8_t) data;
         }
         else
         {
-            GUSregb(AdLibData2x9) = (GUSbyte) data;
+            GUSregb(AdLibData2x9) = (uint8_t) data;
             if (GUSregb(GUS45TimerCtrl) & 0x02)
             {
                 GUSregb(TimerStatus2x8) |= 0x01;
@@ -231,16 +231,16 @@ void gus_write(GUSEmuState * state, int port, int size, unsigned int data)
         }
         break;
     case 0x20A:
-        GUSregb(AdLibStatus2x8) = (GUSbyte) data;
+        GUSregb(AdLibStatus2x8) = (uint8_t) data;
         break;                 /* AdLibStatus2x8 */
     case 0x20B:                /* GUS hidden registers */
         switch (GUSregb(RegCtrl_2xF) & 0x7)
         {
         case 0:
             if (GUSregb(MixerCtrlReg2x0) & 0x40)
-                GUSregb(IRQ_2xB) = (GUSbyte) data; /* control register select bit */
+                GUSregb(IRQ_2xB) = (uint8_t) data; /* control register select bit */
             else
-                GUSregb(DMA_2xB) = (GUSbyte) data;
+                GUSregb(DMA_2xB) = (uint8_t) data;
             break;
             /* case 1-4: general purpose emulation regs */
         case 5:                                    /* clear stat reg 2xF */
@@ -249,7 +249,7 @@ void gus_write(GUSEmuState * state, int port, int size, unsigned int data)
                 GUS_irqclear(state, state->gusirq);
             break;
         case 6:                                    /* Jumper reg (Joystick/MIDI enable) */
-            GUSregb(Jumper_2xB) = (GUSbyte) data;
+            GUSregb(Jumper_2xB) = (uint8_t) data;
             break;
         default:;
         }
@@ -262,20 +262,20 @@ void gus_write(GUSEmuState * state, int port, int size, unsigned int data)
             GUS_irqrequest(state, state->gusirq, 1);
         }
     case 0x20D:                /* SB2xCd no IRQ */
-        GUSregb(SB2xCd) = (GUSbyte) data;
+        GUSregb(SB2xCd) = (uint8_t) data;
         break;
     case 0x20E:                /* SB2xE */
-        GUSregb(SB2xE) = (GUSbyte) data;
+        GUSregb(SB2xE) = (uint8_t) data;
         break;
     case 0x20F:
-        GUSregb(RegCtrl_2xF) = (GUSbyte) data;
+        GUSregb(RegCtrl_2xF) = (uint8_t) data;
         break;                 /* CtrlReg2xF */
     case 0x302:                /* VoiceSelReg */
-        GUSregb(VoiceSelReg3x2) = (GUSbyte) data;
+        GUSregb(VoiceSelReg3x2) = (uint8_t) data;
         break;
     case 0x303:                /* FunkSelReg */
-        GUSregb(FunkSelReg3x3) = (GUSbyte) data;
-        if ((GUSbyte) data == 0x8f) /* set irqstatreg, get voicereg and clear IRQ */
+        GUSregb(FunkSelReg3x3) = (uint8_t) data;
+        if ((uint8_t) data == 0x8f) /* set irqstatreg, get voicereg and clear IRQ */
         {
             int             voice;
             if (GUSregd(voicewavetableirq)) /* WavetableIRQ */
@@ -358,12 +358,12 @@ void gus_write(GUSEmuState * state, int port, int size, unsigned int data)
                 break;
                 /* voice unspecific functions */
             case 0x0e:         /* NumVoices */
-                GUSregb(NumVoices) = (GUSbyte) data;
+                GUSregb(NumVoices) = (uint8_t) data;
                 break;
             /* case 0x0f:      */ /* read only */
                 /* common functions */
             case 0x41:         /* DramDMAContrReg */
-                GUSregb(GUS41DMACtrl) = (GUSbyte) data;
+                GUSregb(GUS41DMACtrl) = (uint8_t) data;
                 if (data & 0x01)
                     GUS_dmarequest(state);
                 break;
@@ -380,7 +380,7 @@ void gus_write(GUSEmuState * state, int port, int size, unsigned int data)
                     (GUSregd(GUSDRAMPOS24bit) & 0xffff) | ((data & 0x0f) << 16);
                 break;
             case 0x45:         /* TCtrlReg */
-                GUSregb(GUS45TimerCtrl) = (GUSbyte) data;
+                GUSregb(GUS45TimerCtrl) = (uint8_t) data;
                 if (!(data & 0x20))
                     GUSregb(TimerStatus2x8) &= 0xe7;    /* sb IRQ dis? -> clear 2x8/2xC sb IRQ flags */
                 if (!(data & 0x02))
@@ -434,18 +434,18 @@ void gus_write(GUSEmuState * state, int port, int size, unsigned int data)
                     GUS_irqclear(state, state->gusirq);
                 break;
             case 0x46:          /* Counter1 */
-                GUSregb(GUS46Counter1) = (GUSbyte) data;
+                GUSregb(GUS46Counter1) = (uint8_t) data;
                 break;
             case 0x47:          /* Counter2 */
-                GUSregb(GUS47Counter2) = (GUSbyte) data;
+                GUSregb(GUS47Counter2) = (uint8_t) data;
                 break;
             /* case 0x48:       */ /* sampling freq reg not emulated (same as interwave) */
             case 0x49:          /* SampCtrlReg */
-                GUSregb(GUS49SampCtrl) = (GUSbyte) data;
+                GUSregb(GUS49SampCtrl) = (uint8_t) data;
                 break;
             /* case 0x4b:       */ /* joystick trim not emulated */
             case 0x4c:          /* GUSreset */
-                GUSregb(GUS4cReset) = (GUSbyte) data;
+                GUSregb(GUS4cReset) = (uint8_t) data;
                 if (!(GUSregb(GUS4cReset) & 1)) /* reset... */
                 {
                     GUSregd(voicewavetableirq) = 0;
@@ -471,9 +471,9 @@ void gus_write(GUSEmuState * state, int port, int size, unsigned int data)
         break;
     case 0x307:                /* DRAMaccess */
         {
-            GUSbyte        *adr;
+            uint8_t        *adr;
             adr = state->himemaddr + (GUSregd(GUSDRAMPOS24bit) & 0xfffff);
-            *adr = (GUSbyte) data;
+            *adr = (uint8_t) data;
         }
         break;
     }
@@ -510,7 +510,7 @@ void gus_dma_transferdata(GUSEmuState * state, char *dma_addr, unsigned int coun
     char           *srcaddr;
     char           *destaddr;
     char            msbmask = 0;
-    GUSbyte        *gusptr;
+    uint8_t        *gusptr;
     gusptr = state->gusdatapos;
 
     srcaddr = dma_addr; /* system memory address */
@@ -522,7 +522,7 @@ void gus_dma_transferdata(GUSEmuState * state, char *dma_addr, unsigned int coun
     }
 
     GUSregw(GUS42DMAStart) += (GUSword)  (count >> 4);                           /* ToDo: add 16bit GUS page limit? */
-    GUSregb(GUS50DMAHigh)   = (GUSbyte) ((count + GUSregb(GUS50DMAHigh)) & 0xf); /* ToDo: add 16bit GUS page limit? */
+    GUSregb(GUS50DMAHigh)   = (uint8_t) ((count + GUSregb(GUS50DMAHigh)) & 0xf); /* ToDo: add 16bit GUS page limit? */
 
     if (GUSregb(GUS41DMACtrl) & 0x02)   /* direction, 0 := sysram->gusram */
     {
diff --git a/hw/audio/gusemu_mixer.c b/hw/audio/gusemu_mixer.c
index 701e8fb0ed..d255ac821d 100644
--- a/hw/audio/gusemu_mixer.c
+++ b/hw/audio/gusemu_mixer.c
@@ -37,7 +37,7 @@ void gus_mixvoices(GUSEmuState * state, unsigned int playback_freq, unsigned int
                    GUSsample *bufferpos)
 {
     /* note that byte registers are stored in the upper half of each voice register! */
-    GUSbyte        *gusptr;
+    uint8_t        *gusptr;
     int             Voice;
     GUSword        *voiceptr;
 
@@ -187,7 +187,7 @@ void gus_irqgen(GUSEmuState * state, unsigned int elapsed_time)
 /* time given in microseconds */
 {
     int             requestedIRQs = 0;
-    GUSbyte        *gusptr;
+    uint8_t        *gusptr;
     gusptr = state->gusdatapos;
     if (GUSregb(TimerDataReg2x9) & 1) /* start timer 1 (80us decrement rate) */
     {
-- 
2.9.3

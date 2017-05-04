Received: from eggs.gnu.org ([2001:4830:134:3::10]:34761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1w-0001Ur-Dl
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1t-0004cy-6d
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1s-0004bE-Ty
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E928F80C1B
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:18:03 +0200
Message-Id: <20170504071811.3547-23-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 22/30] audio: GUSword is uint16_t
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
Message-id: 20170425223739.6703-19-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/gusemu_hal.c   | 14 +++++++-------
 hw/audio/gusemu_mixer.c |  8 ++++----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/audio/gusemu_hal.c b/hw/audio/gusemu_hal.c
index 444a2bbb22..3dd7239a4b 100644
--- a/hw/audio/gusemu_hal.c
+++ b/hw/audio/gusemu_hal.c
@@ -31,7 +31,7 @@
 #include "gusemu.h"
 
 #define GUSregb(position) (*            (gusptr+(position)))
-#define GUSregw(position) (*(GUSword *) (gusptr+(position)))
+#define GUSregw(position) (*(uint16_t *) (gusptr+(position)))
 #define GUSregd(position) (*(GUSdword *)(gusptr+(position)))
 
 /* size given in bytes */
@@ -173,7 +173,7 @@ unsigned int gus_read(GUSEmuState * state, int port, int size)
                 value_read = value_read >> 8;
             value_read &= 0xff;
         }
-        return (GUSword) value_read;
+        return (uint16_t) value_read;
     /* case 0x306:                                  */ /* Mixer/Version info */
         /*  return 0xff; */ /* Pre 3.6 boards, ICS mixer NOT present */
     case 0x307:                                     /* DRAMaccess */
@@ -318,15 +318,15 @@ void gus_write(GUSEmuState * state, int port, int size, unsigned int data)
     case 0x304:
     case 0x305:
         {
-            GUSword         writedata = (GUSword) data;
-            GUSword         readmask = 0x0000;
+            uint16_t         writedata = (uint16_t) data;
+            uint16_t         readmask = 0x0000;
             if (size == 1)
             {
                 readmask = 0xff00;
                 writedata &= 0xff;
                 if ((port & 0xff0f) == 0x305)
                 {
-                    writedata = (GUSword) (writedata << 8);
+                    writedata = (uint16_t) (writedata << 8);
                     readmask = 0x00ff;
                 }
             }
@@ -353,7 +353,7 @@ void gus_write(GUSEmuState * state, int port, int size, unsigned int data)
                         break;  /* reset flag active? */
                     offset = 2 * (GUSregb(FunkSelReg3x3) & 0x0f);
                     offset += (GUSregb(VoiceSelReg3x2) & 0x1f) << 5; /*  = Voice*32 + Funktion*2 */
-                    GUSregw(offset) = (GUSword) ((GUSregw(offset) & readmask) | writedata);
+                    GUSregw(offset) = (uint16_t) ((GUSregw(offset) & readmask) | writedata);
                 }
                 break;
                 /* voice unspecific functions */
@@ -521,7 +521,7 @@ void gus_dma_transferdata(GUSEmuState * state, char *dma_addr, unsigned int coun
         destaddr = (char *) state->himemaddr + offset; /* wavetable RAM address */
     }
 
-    GUSregw(GUS42DMAStart) += (GUSword)  (count >> 4);                           /* ToDo: add 16bit GUS page limit? */
+    GUSregw(GUS42DMAStart) += (uint16_t)  (count >> 4);                           /* ToDo: add 16bit GUS page limit? */
     GUSregb(GUS50DMAHigh)   = (uint8_t) ((count + GUSregb(GUS50DMAHigh)) & 0xf); /* ToDo: add 16bit GUS page limit? */
 
     if (GUSregb(GUS41DMACtrl) & 0x02)   /* direction, 0 := sysram->gusram */
diff --git a/hw/audio/gusemu_mixer.c b/hw/audio/gusemu_mixer.c
index b189db990c..981a9ae0d4 100644
--- a/hw/audio/gusemu_mixer.c
+++ b/hw/audio/gusemu_mixer.c
@@ -27,10 +27,10 @@
 #include "gustate.h"
 
 #define GUSregb(position)  (*            (gusptr+(position)))
-#define GUSregw(position)  (*(GUSword *) (gusptr+(position)))
+#define GUSregw(position)  (*(uint16_t *) (gusptr+(position)))
 #define GUSregd(position)  (*(GUSdword *)(gusptr+(position)))
 
-#define GUSvoice(position) (*(GUSword *)(voiceptr+(position)))
+#define GUSvoice(position) (*(uint16_t *)(voiceptr+(position)))
 
 /* samples are always 16bit stereo (4 bytes each, first right then left interleaved) */
 void gus_mixvoices(GUSEmuState * state, unsigned int playback_freq, unsigned int numsamples,
@@ -39,14 +39,14 @@ void gus_mixvoices(GUSEmuState * state, unsigned int playback_freq, unsigned int
     /* note that byte registers are stored in the upper half of each voice register! */
     uint8_t        *gusptr;
     int             Voice;
-    GUSword        *voiceptr;
+    uint16_t       *voiceptr;
 
     unsigned int    count;
     for (count = 0; count < numsamples * 2; count++)
         *(bufferpos + count) = 0;       /* clear */
 
     gusptr = state->gusdatapos;
-    voiceptr = (GUSword *) gusptr;
+    voiceptr = (uint16_t *) gusptr;
     if (!(GUSregb(GUS4cReset) & 0x01))  /* reset flag active? */
         return;
 
-- 
2.9.3

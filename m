Received: from eggs.gnu.org ([2001:4830:134:3::10]:36329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d396I-0000UL-VM
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d396H-0002Xl-UP
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d396H-0002Xa-LJ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:38:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9018D80482
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:38:24 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:37:31 +0200
Message-Id: <20170425223739.6703-19-quintela@redhat.com>
In-Reply-To: <20170425223739.6703-1-quintela@redhat.com>
References: <20170425223739.6703-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 18/26] audio: GUSword is uint16_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/audio/gusemu_hal.c   | 14 +++++++-------
 hw/audio/gusemu_mixer.c |  8 ++++----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/audio/gusemu_hal.c b/hw/audio/gusemu_hal.c
index 444a2bb..3dd7239 100644
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
index b189db9..981a9ae 100644
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

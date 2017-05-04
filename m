Received: from eggs.gnu.org ([2001:4830:134:3::10]:34758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1w-0001Uq-98
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1s-0004bj-Fn
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1s-0004a1-7D
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42C5361BA5
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:18:04 +0200
Message-Id: <20170504071811.3547-24-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 23/30] audio: GUSsample is int16_t
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
Message-id: 20170425223739.6703-20-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/gusemu.h       | 12 +-----------
 hw/audio/gus.c          |  2 +-
 hw/audio/gusemu_hal.c   |  2 +-
 hw/audio/gusemu_mixer.c |  8 ++++----
 4 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/hw/audio/gusemu.h b/hw/audio/gusemu.h
index 69dadef24d..ab591eefb7 100644
--- a/hw/audio/gusemu.h
+++ b/hw/audio/gusemu.h
@@ -25,16 +25,6 @@
 #ifndef GUSEMU_H
 #define GUSEMU_H
 
-/* data types (need to be adjusted if neither a VC6 nor a C99 compatible compiler is used) */
-
-#if defined _WIN32 && defined _MSC_VER /* doesn't support other win32 compilers yet, do it yourself... */
- typedef unsigned int GUSdword;
- typedef signed short GUSsample;
-#else
- typedef uint32_t GUSdword;
- typedef int16_t GUSsample;
-#endif
-
 typedef struct _GUSEmuState
 {
  uint8_t *himemaddr; /* 1024*1024 bytes used for storing uploaded samples (+32 additional bytes for read padding) */
@@ -86,7 +76,7 @@ void gus_dma_transferdata(GUSEmuState *state, char *dma_addr, unsigned int count
 /* If the interrupts are asynchronous, it may be needed to use a separate thread mixing into a temporary */
 /* audio buffer in order to avoid quality loss caused by large numsamples and elapsed_time values. */
 
-void gus_mixvoices(GUSEmuState *state, unsigned int playback_freq, unsigned int numsamples, GUSsample *bufferpos);
+void gus_mixvoices(GUSEmuState *state, unsigned int playback_freq, unsigned int numsamples, int16_t *bufferpos);
 /* recommended range: 10 < numsamples < 100 */
 /* lower values may result in increased rounding error, higher values often cause audible timing delays */
 
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 3d08a6576a..ec103a4db9 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -53,7 +53,7 @@ typedef struct GUSState {
     uint32_t freq;
     uint32_t port;
     int pos, left, shift, irqs;
-    GUSsample *mixbuf;
+    int16_t *mixbuf;
     uint8_t himem[1024 * 1024 + 32 + 4096];
     int samples;
     SWVoiceOut *voice;
diff --git a/hw/audio/gusemu_hal.c b/hw/audio/gusemu_hal.c
index 3dd7239a4b..1150fc4426 100644
--- a/hw/audio/gusemu_hal.c
+++ b/hw/audio/gusemu_hal.c
@@ -32,7 +32,7 @@
 
 #define GUSregb(position) (*            (gusptr+(position)))
 #define GUSregw(position) (*(uint16_t *) (gusptr+(position)))
-#define GUSregd(position) (*(GUSdword *)(gusptr+(position)))
+#define GUSregd(position) (*(uint16_t *)(gusptr+(position)))
 
 /* size given in bytes */
 unsigned int gus_read(GUSEmuState * state, int port, int size)
diff --git a/hw/audio/gusemu_mixer.c b/hw/audio/gusemu_mixer.c
index 981a9ae0d4..00b9861b92 100644
--- a/hw/audio/gusemu_mixer.c
+++ b/hw/audio/gusemu_mixer.c
@@ -28,13 +28,13 @@
 
 #define GUSregb(position)  (*            (gusptr+(position)))
 #define GUSregw(position)  (*(uint16_t *) (gusptr+(position)))
-#define GUSregd(position)  (*(GUSdword *)(gusptr+(position)))
+#define GUSregd(position)  (*(uint16_t *)(gusptr+(position)))
 
 #define GUSvoice(position) (*(uint16_t *)(voiceptr+(position)))
 
 /* samples are always 16bit stereo (4 bytes each, first right then left interleaved) */
 void gus_mixvoices(GUSEmuState * state, unsigned int playback_freq, unsigned int numsamples,
-                   GUSsample *bufferpos)
+                   int16_t *bufferpos)
 {
     /* note that byte registers are stored in the upper half of each voice register! */
     uint8_t        *gusptr;
@@ -171,8 +171,8 @@ void gus_mixvoices(GUSEmuState * state, unsigned int playback_freq, unsigned int
                 }
 
                 /* mix samples into buffer */
-                *(bufferpos + 2 * sample)     += (GUSsample) ((sample1 * PanningPos) >> 4);        /* right */
-                *(bufferpos + 2 * sample + 1) += (GUSsample) ((sample1 * (15 - PanningPos)) >> 4); /* left */
+                *(bufferpos + 2 * sample)     += (int16_t) ((sample1 * PanningPos) >> 4);        /* right */
+                *(bufferpos + 2 * sample + 1) += (int16_t) ((sample1 * (15 - PanningPos)) >> 4); /* left */
             }
             /* write back voice and volume */
             GUSvoice(wVSRCurrVol)   = Volume32 / 32;
-- 
2.9.3

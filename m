Received: from eggs.gnu.org ([2001:4830:134:3::10]:51781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHC-000226-Dj
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHB-0007CA-58
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:10 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fXrHA-00079F-Rw
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:09 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrH9-00004z-8T
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:57:07 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:56:36 +0100
Message-Id: <20180626165658.31394-11-peter.maydell@linaro.org>
In-Reply-To: <20180626165658.31394-1-peter.maydell@linaro.org>
References: <20180626165658.31394-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/32] hw/dma/omap_dma: Use
 qemu_log_mask(GUEST_ERROR) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20180624040609.17572-5-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/omap_dma.c | 64 +++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index ab3a1b04515..cbb920f31d3 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -879,15 +879,18 @@ static int omap_dma_ch_reg_write(struct omap_dma_s *s,
         ch->burst[0] = (value & 0x0180) >> 7;
         ch->pack[0] = (value & 0x0040) >> 6;
         ch->port[0] = (enum omap_dma_port) ((value & 0x003c) >> 2);
-        if (ch->port[0] >= __omap_dma_port_last)
-            printf("%s: invalid DMA port %i\n", __func__,
-                            ch->port[0]);
-        if (ch->port[1] >= __omap_dma_port_last)
-            printf("%s: invalid DMA port %i\n", __func__,
-                            ch->port[1]);
+        if (ch->port[0] >= __omap_dma_port_last) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid DMA port %i\n",
+                          __func__, ch->port[0]);
+        }
+        if (ch->port[1] >= __omap_dma_port_last) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid DMA port %i\n",
+                          __func__, ch->port[1]);
+        }
         ch->data_type = 1 << (value & 3);
         if ((value & 3) == 3) {
-            printf("%s: bad data_type for DMA channel\n", __func__);
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: bad data_type for DMA channel\n", __func__);
             ch->data_type >>= 1;
         }
         break;
@@ -1899,14 +1902,18 @@ static void omap_dma4_write(void *opaque, hwaddr addr,
         if (value & 2)						/* SOFTRESET */
             omap_dma_reset(s->dma);
         s->ocp = value & 0x3321;
-        if (((s->ocp >> 12) & 3) == 3)				/* MIDLEMODE */
-            fprintf(stderr, "%s: invalid DMA power mode\n", __func__);
+        if (((s->ocp >> 12) & 3) == 3) { /* MIDLEMODE */
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid DMA power mode\n",
+                          __func__);
+        }
         return;
 
     case 0x78:	/* DMA4_GCR */
         s->gcr = value & 0x00ff00ff;
-	if ((value & 0xff) == 0x00)		/* MAX_CHANNEL_FIFO_DEPTH */
-            fprintf(stderr, "%s: wrong FIFO depth in GCR\n", __func__);
+        if ((value & 0xff) == 0x00) { /* MAX_CHANNEL_FIFO_DEPTH */
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: wrong FIFO depth in GCR\n",
+                          __func__);
+        }
         return;
 
     case 0x80 ... 0xfff:
@@ -1935,9 +1942,11 @@ static void omap_dma4_write(void *opaque, hwaddr addr,
     case 0x00:	/* DMA4_CCR */
         ch->buf_disable = (value >> 25) & 1;
         ch->src_sync = (value >> 24) & 1;	/* XXX For CamDMA must be 1 */
-        if (ch->buf_disable && !ch->src_sync)
-            fprintf(stderr, "%s: Buffering disable is not allowed in "
-                            "destination synchronised mode\n", __func__);
+        if (ch->buf_disable && !ch->src_sync) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Buffering disable is not allowed in "
+                          "destination synchronised mode\n", __func__);
+        }
         ch->prefetch = (value >> 23) & 1;
         ch->bs = (value >> 18) & 1;
         ch->transparent_copy = (value >> 17) & 1;
@@ -1947,9 +1956,11 @@ static void omap_dma4_write(void *opaque, hwaddr addr,
         ch->suspend = (value & 0x0100) >> 8;
         ch->priority = (value & 0x0040) >> 6;
         ch->fs = (value & 0x0020) >> 5;
-        if (ch->fs && ch->bs && ch->mode[0] && ch->mode[1])
-            fprintf(stderr, "%s: For a packet transfer at least one port "
-                            "must be constant-addressed\n", __func__);
+        if (ch->fs && ch->bs && ch->mode[0] && ch->mode[1]) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: For a packet transfer at least one port "
+                          "must be constant-addressed\n", __func__);
+        }
         ch->sync = (value & 0x001f) | ((value >> 14) & 0x0060);
         /* XXX must be 0x01 for CamDMA */
 
@@ -1978,9 +1989,11 @@ static void omap_dma4_write(void *opaque, hwaddr addr,
         ch->endian_lock[0] =(value >> 20) & 1;
         ch->endian[1] =(value >> 19) & 1;
         ch->endian_lock[1] =(value >> 18) & 1;
-        if (ch->endian[0] != ch->endian[1])
-            fprintf(stderr, "%s: DMA endianness conversion enable attempt\n",
-                            __func__);
+        if (ch->endian[0] != ch->endian[1]) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: DMA endianness conversion enable attempt\n",
+                          __func__);
+        }
         ch->write_mode = (value >> 16) & 3;
         ch->burst[1] = (value & 0xc000) >> 14;
         ch->pack[1] = (value & 0x2000) >> 13;
@@ -1988,12 +2001,15 @@ static void omap_dma4_write(void *opaque, hwaddr addr,
         ch->burst[0] = (value & 0x0180) >> 7;
         ch->pack[0] = (value & 0x0040) >> 6;
         ch->translate[0] = (value & 0x003c) >> 2;
-        if (ch->translate[0] | ch->translate[1])
-            fprintf(stderr, "%s: bad MReqAddressTranslate sideband signal\n",
-                            __func__);
+        if (ch->translate[0] | ch->translate[1]) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: bad MReqAddressTranslate sideband signal\n",
+                          __func__);
+        }
         ch->data_type = 1 << (value & 3);
         if ((value & 3) == 3) {
-            printf("%s: bad data_type for DMA channel\n", __func__);
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: bad data_type for DMA channel\n", __func__);
             ch->data_type >>= 1;
         }
         break;
-- 
2.17.1

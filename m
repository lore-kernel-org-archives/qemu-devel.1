Received: from eggs.gnu.org ([2001:4830:134:3::10]:41575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUt-0000qq-CU
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUs-0006Ux-7v
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:11 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fOOUr-0006SF-Vg
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:10 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUm-0002rF-F8
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:04 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 15:23:40 +0100
Message-Id: <20180531142357.904-9-peter.maydell@linaro.org>
In-Reply-To: <20180531142357.904-1-peter.maydell@linaro.org>
References: <20180531142357.904-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/25] xlnx-zdma: Correct mem leaks and memset
 to zero on desc unaligned errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Francisco Iglesias <frasse.iglesias@gmail.com>

Coverity found that the string return by 'object_get_canonical_path' was not
being freed at two locations in the model (CID 1391294 and CID 1391293) and
also that a memset was being called with a value greater than the max of a byte
on the second argument (CID 1391286). This patch corrects this by adding the
freeing of the strings and also changing to memset to zero instead on
descriptor unaligned errors.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180528184859.3530-1-frasse.iglesias@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xlnx-zdma.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 14d86c254b..8eea757aff 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -302,7 +302,7 @@ static bool zdma_load_descriptor(XlnxZDMA *s, uint64_t addr, void *buf)
         qemu_log_mask(LOG_GUEST_ERROR,
                       "zdma: unaligned descriptor at %" PRIx64,
                       addr);
-        memset(buf, 0xdeadbeef, sizeof(XlnxZDMADescr));
+        memset(buf, 0x0, sizeof(XlnxZDMADescr));
         s->error = true;
         return false;
     }
@@ -707,9 +707,11 @@ static uint64_t zdma_read(void *opaque, hwaddr addr, unsigned size)
     RegisterInfo *r = &s->regs_info[addr / 4];
 
     if (!r->data) {
+        gchar *path = object_get_canonical_path(OBJECT(s));
         qemu_log("%s: Decode error: read from %" HWADDR_PRIx "\n",
-                 object_get_canonical_path(OBJECT(s)),
+                 path,
                  addr);
+        g_free(path);
         ARRAY_FIELD_DP32(s->regs, ZDMA_CH_ISR, INV_APB, true);
         zdma_ch_imr_update_irq(s);
         return 0;
@@ -724,9 +726,11 @@ static void zdma_write(void *opaque, hwaddr addr, uint64_t value,
     RegisterInfo *r = &s->regs_info[addr / 4];
 
     if (!r->data) {
+        gchar *path = object_get_canonical_path(OBJECT(s));
         qemu_log("%s: Decode error: write to %" HWADDR_PRIx "=%" PRIx64 "\n",
-                 object_get_canonical_path(OBJECT(s)),
+                 path,
                  addr, value);
+        g_free(path);
         ARRAY_FIELD_DP32(s->regs, ZDMA_CH_ISR, INV_APB, true);
         zdma_ch_imr_update_irq(s);
         return;
-- 
2.17.1

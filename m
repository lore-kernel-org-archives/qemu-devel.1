Received: from eggs.gnu.org ([2001:4830:134:3::10]:37222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUN-000417-LV
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUM-0005f4-Mj
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:47 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1frhUM-0005ec-FA
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:46 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUL-0003EB-IY
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:32:45 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 11:32:08 +0100
Message-Id: <20180820103212.2810-22-peter.maydell@linaro.org>
In-Reply-To: <20180820103212.2810-1-peter.maydell@linaro.org>
References: <20180820103212.2810-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/25] hw/dma/pl080: Support all three interrupt
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The PL080 and PL081 have three outgoing interrupt lines:
 * DMACINTERR signals DMA errors
 * DMACINTTC is the DMA count interrupt
 * DMACINTR is a combined interrupt, the logical OR of the other two

We currently only implement DMACINTR, because that's all the
realview and versatile boards needed, but the instances of the
PL081 in the MPS2 firmware images use all three interrupt lines.
Implement the missing DMACINTERR and DMACINTTC.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/dma/pl080.h |  6 +++++-
 hw/dma/pl080.c         | 13 ++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/hw/dma/pl080.h b/include/hw/dma/pl080.h
index 7deb46c8578..7c6a4184833 100644
--- a/include/hw/dma/pl080.h
+++ b/include/hw/dma/pl080.h
@@ -17,7 +17,9 @@
  * http://infocenter.arm.com/help/topic/com.arm.doc.ddi0218e/DDI0218.pdf
  *
  * QEMU interface:
- * + sysbus IRQ: DMACINTR combined interrupt line
+ * + sysbus IRQ 0: DMACINTR combined interrupt line
+ * + sysbus IRQ 1: DMACINTERR error interrupt request
+ * + sysbus IRQ 2: DMACINTTC count interrupt request
  * + sysbus MMIO region 0: MemoryRegion for the device's registers
  */
 
@@ -57,6 +59,8 @@ typedef struct PL080State {
     /* Flag to avoid recursive DMA invocations.  */
     int running;
     qemu_irq irq;
+    qemu_irq interr;
+    qemu_irq inttc;
 } PL080State;
 
 #endif
diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 0f79c2d8a6c..301030dd118 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -75,11 +75,12 @@ static const unsigned char pl081_id[] =
 
 static void pl080_update(PL080State *s)
 {
-    if ((s->tc_int & s->tc_mask)
-            || (s->err_int & s->err_mask))
-        qemu_irq_raise(s->irq);
-    else
-        qemu_irq_lower(s->irq);
+    bool tclevel = (s->tc_int & s->tc_mask);
+    bool errlevel = (s->err_int & s->err_mask);
+
+    qemu_set_irq(s->interr, errlevel);
+    qemu_set_irq(s->inttc, tclevel);
+    qemu_set_irq(s->irq, errlevel || tclevel);
 }
 
 static void pl080_run(PL080State *s)
@@ -352,6 +353,8 @@ static void pl080_init(Object *obj)
     memory_region_init_io(&s->iomem, OBJECT(s), &pl080_ops, s, "pl080", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
+    sysbus_init_irq(sbd, &s->interr);
+    sysbus_init_irq(sbd, &s->inttc);
     s->nchannels = 8;
 }
 
-- 
2.18.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSP0-0004vH-4b
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOw-0008HM-AY
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:48 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSOu-00071P-Cn
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:44 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOB-0007LK-R0
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:59 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:34 +0000
Message-Id: <20181213145445.17935-27-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 26/37] hw/arm: versal: Use IRQs 111 - 118 for
 virtio-mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Use IRQs 111 - 118 for virtio-mmio. The interrupts we're currently
using 160+ are not available in the Versal GIC.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20181129163655.20370-4-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h | 6 +++---
 hw/arm/xlnx-versal-virt.c    | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 9da621e4b68..76fb9de3918 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -75,9 +75,9 @@ typedef struct Versal {
 #define VERSAL_GEM1_IRQ_0          58
 #define VERSAL_GEM1_WAKE_IRQ_0     59
 
-/* Architecturally eserved IRQs suitable for virtualization.  */
-#define VERSAL_RSVD_HIGH_IRQ_FIRST 160
-#define VERSAL_RSVD_HIGH_IRQ_LAST  255
+/* Architecturally reserved IRQs suitable for virtualization.  */
+#define VERSAL_RSVD_IRQ_FIRST 111
+#define VERSAL_RSVD_IRQ_LAST  118
 
 #define MM_TOP_RSVD                 0xa0000000U
 #define MM_TOP_RSVD_SIZE            0x4000000
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 2ed6ee9934d..c6feeac532f 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -351,7 +351,7 @@ static void create_virtio_regions(VersalVirt *s)
     for (i = 0; i < NUM_VIRTIO_TRANSPORT; i++) {
         char *name = g_strdup_printf("virtio%d", i);;
         hwaddr base = MM_TOP_RSVD + i * virtio_mmio_size;
-        int irq = VERSAL_RSVD_HIGH_IRQ_FIRST + i;
+        int irq = VERSAL_RSVD_IRQ_FIRST + i;
         MemoryRegion *mr;
         DeviceState *dev;
         qemu_irq pic_irq;
@@ -368,7 +368,7 @@ static void create_virtio_regions(VersalVirt *s)
 
     for (i = 0; i < NUM_VIRTIO_TRANSPORT; i++) {
         hwaddr base = MM_TOP_RSVD + i * virtio_mmio_size;
-        int irq = VERSAL_RSVD_HIGH_IRQ_FIRST + i;
+        int irq = VERSAL_RSVD_IRQ_FIRST + i;
         char *name = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
 
         qemu_fdt_add_subnode(s->fdt, name);
-- 
2.19.2

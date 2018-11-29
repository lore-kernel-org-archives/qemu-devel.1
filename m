Received: from eggs.gnu.org ([2001:4830:134:3::10]:37088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gSPJK-0006qw-7j
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gSPJJ-0007Hy-Bd
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:37:06 -0500
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 29 Nov 2018 17:36:54 +0100
Message-Id: <20181129163655.20370-4-edgar.iglesias@gmail.com>
In-Reply-To: <20181129163655.20370-1-edgar.iglesias@gmail.com>
References: <20181129163655.20370-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 3/4] hw/arm: versal: Use IRQs 111 - 118 for
 virtio-mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, muhammad_bilal@mentor.com, frederic.konrad@adacore.com, alistair@alistair23.me, luc.michel@greensocs.com, philmd@redhat.com, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Use IRQs 111 - 118 for virtio-mmio. The interrupts we're currently
using 160+ are not available in the Versal GIC.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-versal-virt.c    | 4 ++--
 include/hw/arm/xlnx-versal.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 2ed6ee9934..c6feeac532 100644
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
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 9da621e4b6..76fb9de391 100644
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
-- 
2.17.1

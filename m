Received: from eggs.gnu.org ([2001:4830:134:3::10]:59203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cboDz-0002c0-Fn
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cboDy-0007QS-GS
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:53:23 -0500
From: Alexander Graf <agraf@suse.de>
Date: Thu,  9 Feb 2017 13:53:27 +0100
Message-Id: <1486644810-33181-2-git-send-email-agraf@suse.de>
In-Reply-To: <1486644810-33181-1-git-send-email-agraf@suse.de>
References: <1486644810-33181-1-git-send-email-agraf@suse.de>
Subject: [Qemu-devel] [PATCH v2 1/4] target-arm: Declare virtio-mmio as
 dma-coherent in dt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mst@redhat.com, Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

QEMU emulated hardware is always dma coherent with its guest. We do
annotate that correctly on the PCI host controller, but left out
virtio-mmio.

Recent kernels have started to interpret that flag rather than take
dma coherency as granted with virtio-mmio. While that is considered
a kernel bug, as it breaks previously working systems, it showed that
our dt description is incomplete.

This patch adds the respective marker that allows guest OSs to evaluate
that our virtio-mmio devices are indeed cache coherent.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 hw/arm/vexpress.c | 1 +
 hw/arm/virt.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 58760f4..e057568 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -452,6 +452,7 @@ static int add_virtio_mmio_node(void *fdt, uint32_t acells, uint32_t scells,
                                        acells, addr, scells, size);
     qemu_fdt_setprop_cells(fdt, nodename, "interrupt-parent", intc);
     qemu_fdt_setprop_cells(fdt, nodename, "interrupts", 0, irq, 1);
+    qemu_fdt_setprop(fdt, nodename, "dma-coherent", NULL, 0);
     g_free(nodename);
     if (rc) {
         return -1;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1f216cf..14881fa 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -797,6 +797,7 @@ static void create_virtio_devices(const VirtMachineState *vms, qemu_irq *pic)
         qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
                                GIC_FDT_IRQ_TYPE_SPI, irq,
                                GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
+        qemu_fdt_setprop(vms->fdt, nodename, "dma-coherent", NULL, 0);
         g_free(nodename);
     }
 }
-- 
2.10.0

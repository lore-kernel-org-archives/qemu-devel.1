Received: from eggs.gnu.org ([2001:4830:134:3::10]:49573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc8-00021a-BO
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc7-0003wq-FZ
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:08 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ccFc7-0003vW-89
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:07 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc6-0007cL-Do
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 18:08:06 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 18:07:55 +0000
Message-Id: <1486750082-12324-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
References: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 05/12] target-arm: Declare virtio-mmio as
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

From: Alexander Graf <agraf@suse.de>

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
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Message-id: 1486644810-33181-2-git-send-email-agraf@suse.de
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index 8eef143..d20e627 100644
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
2.7.4

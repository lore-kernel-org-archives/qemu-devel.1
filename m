Received: from eggs.gnu.org ([208.118.235.92]:42466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gfN1A-0003tU-CB
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:47:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gfN18-0000B9-N4
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:47:56 -0500
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri,  4 Jan 2019 11:47:49 +0100
Message-Id: <20190104104749.5314-2-edgar.iglesias@gmail.com>
In-Reply-To: <20190104104749.5314-1-edgar.iglesias@gmail.com>
References: <20190104104749.5314-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 1/1] hw/arm: versal: Plug memory leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, luc.michel@greensocs.com, philmd@redhat.com, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Plug a couple of "board creation time" memory leaks.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-versal-virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index c6feeac532..f95fde2309 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -130,6 +130,7 @@ static void fdt_add_gic_nodes(VersalVirt *s)
                                  2, MM_GIC_APU_REDIST_0_SIZE);
     qemu_fdt_setprop_cell(s->fdt, nodename, "#interrupt-cells", 3);
     qemu_fdt_setprop_string(s->fdt, nodename, "compatible", "arm,gic-v3");
+    g_free(nodename);
 }
 
 static void fdt_add_timer_nodes(VersalVirt *s)
@@ -364,6 +365,7 @@ static void create_virtio_regions(VersalVirt *s)
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic_irq);
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
         memory_region_add_subregion(&s->soc.mr_ps, base, mr);
+        g_free(name);
     }
 
     for (i = 0; i < NUM_VIRTIO_TRANSPORT; i++) {
-- 
2.17.1

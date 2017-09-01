Received: from eggs.gnu.org ([2001:4830:134:3::10]:37546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpfn-0006Ut-An
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpfj-0003rs-D0
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:24:03 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  1 Sep 2017 19:21:17 +0200
Message-Id: <1504286483-23327-15-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v7 14/20] hw/arm/virt: Store the PCI host
 controller dt phandle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com, alex.williamson@redhat.com
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mohun106@gmail.com, tcain@qti.qualcomm.com, bharat.bhushan@nxp.com, tn@semihalf.com, mst@redhat.com, will.deacon@arm.com, jean-philippe.brucker@arm.com, robin.murphy@arm.com, peterx@redhat.com, edgar.iglesias@gmail.com, wtownsen@redhat.com

Let's allocate a phandle for the PCI host controller dt
node and store this latter in the Virt Machine State. This
will simplify fdt operations when we bind smmu and PCI host
controller.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c         | 5 ++++-
 include/hw/arm/virt.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6b7a0fe..39886c1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -991,7 +991,7 @@ static void create_pcie_irq_map(const VirtMachineState *vms,
                            0x7           /* PCI irq */);
 }
 
-static void create_pcie(const VirtMachineState *vms, qemu_irq *pic)
+static void create_pcie(VirtMachineState *vms, qemu_irq *pic)
 {
     hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
     hwaddr size_mmio = vms->memmap[VIRT_PCIE_MMIO].size;
@@ -1100,8 +1100,11 @@ static void create_pcie(const VirtMachineState *vms, qemu_irq *pic)
                                      2, base_mmio, 2, size_mmio);
     }
 
+    vms->pcihost_phandle = qemu_fdt_alloc_phandle(vms->fdt);
+
     qemu_fdt_setprop_cell(vms->fdt, nodename, "#interrupt-cells", 1);
     create_pcie_irq_map(vms, vms->gic_phandle, irq, nodename);
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle", vms->pcihost_phandle);
 
     g_free(nodename);
 }
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 33b0ff3..ae2bf2c 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -105,6 +105,7 @@ typedef struct {
     uint32_t clock_phandle;
     uint32_t gic_phandle;
     uint32_t msi_phandle;
+    uint32_t pcihost_phandle;
     int psci_conduit;
 } VirtMachineState;
 
-- 
2.5.5

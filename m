Received: from eggs.gnu.org ([2001:4830:134:3::10]:58909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dUJCN-0002Hw-Gg
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dUJCM-000650-Ti
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:52:59 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Sun,  9 Jul 2017 22:51:31 +0200
Message-Id: <1499633493-19865-7-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1499633493-19865-1-git-send-email-eric.auger@redhat.com>
References: <1499633493-19865-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v5 6/8] hw/arm/virt: Add tlbi-on-map property to
 the smmuv3 node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, alex.williamson@redhat.com, prem.mallappa@gmail.com
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mohun106@gmail.com, tcain@qti.qualcomm.com, bharat.bhushan@nxp.com, tn@semihalf.com, mst@redhat.com, will.deacon@arm.com, jean-philippe.brucker@arm.com, robin.murphy@arm.com, peterx@redhat.com, edgar.iglesias@gmail.com

For VFIO integration we need to update physical IOMMU mappings
each time the guest updates the vIOMMU translation structures.
For that, we rely on a special smmuv3 option, "tlbi-on-map"
which forces TLB invalidations on map (this mode is similar to
the Intel VTD caching Mode). The smmuv3 driver then sends
SMMU_CMD_TLBI_NH_VA commands, upon which we will update the physical
mappings.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3651e41..9b72e8a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1034,6 +1034,7 @@ static void create_smmu(const VirtMachineState *vms, qemu_irq *pic)
     qemu_fdt_setprop_cell(vms->fdt, smmu, "clocks", vms->clock_phandle);
     qemu_fdt_setprop_string(vms->fdt, smmu, "clock-names", "apb_pclk");
     qemu_fdt_setprop(vms->fdt, smmu, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop(vms->fdt, smmu, "tlbi-on-map", NULL, 0);
 
     qemu_fdt_setprop_cell(vms->fdt, smmu, "#iommu-cells", 1);
 
-- 
2.5.5

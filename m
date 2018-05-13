Received: from eggs.gnu.org ([2001:4830:134:3::10]:53983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fHs68-0008Aq-2z
	for qemu-devel@nongnu.org; Sun, 13 May 2018 10:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fHs67-0006U6-AO
	for qemu-devel@nongnu.org; Sun, 13 May 2018 10:35:40 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Sun, 13 May 2018 16:35:14 +0200
Message-Id: <1526222114-5324-8-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1526222114-5324-1-git-send-email-eric.auger@redhat.com>
References: <1526222114-5324-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v2 7/7] hw/arm/virt: Register two redistributor
 regions when necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: zhaoshenglong@huawei.com, christoffer.dall@arm.com, marc.zyngier@arm.com, drjones@redhat.com, wei@redhat.com

With a VGICv3 KVM device, if the number of vcpus exceeds the
capacity of the legacy redistributor region (123 redistributors),
we now attempt to register the second redistributor region. This
extends the number of vcpus to 512 assuming the host kernel supports:
- up to 512 vcpus
- VGICv3 KVM device group/attribute:
  KVM_DEV_ARM_VGIC_GRP_ADDR/KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION

In case the host kernel does not support the registration of several
redistributor regions, the GICv3 device initialization fails
with a proper error message and qemu exits.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f35962a..8d43c51 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -531,6 +531,7 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
     SysBusDevice *gicbusdev;
     const char *gictype;
     int type = vms->gic_version, i;
+    uint32_t nb_redist_regions = 0;
 
     gictype = (type == 3) ? gicv3_class_name() : gic_class_name();
 
@@ -546,15 +547,26 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
     }
 
     if (type == 3) {
-        qdev_prop_set_uint32(gicdev, "len-redist-region-count", 1);
+        nb_redist_regions = virt_gicv3_redist_region_count(vms);
+
+        qdev_prop_set_uint32(gicdev, "len-redist-region-count",
+                             nb_redist_regions);
         qdev_prop_set_uint32(gicdev , "redist-region-count[0]",
                              vms->memmap[VIRT_GIC_REDIST].size / 0x20000);
+
+        if (nb_redist_regions == 2) {
+            qdev_prop_set_uint32(gicdev , "redist-region-count[1]",
+                                 vms->memmap[VIRT_GIC_REDIST2].size / 0x20000);
+        }
     }
     qdev_init_nofail(gicdev);
     gicbusdev = SYS_BUS_DEVICE(gicdev);
     sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
     if (type == 3) {
         sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_REDIST].base);
+        if (nb_redist_regions == 2) {
+            sysbus_mmio_map(gicbusdev, 2, vms->memmap[VIRT_GIC_REDIST2].base);
+        }
     } else {
         sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_CPU].base);
     }
@@ -1346,6 +1358,7 @@ static void machvirt_init(MachineState *machine)
      */
     if (vms->gic_version == 3) {
         virt_max_cpus = vms->memmap[VIRT_GIC_REDIST].size / 0x20000;
+        virt_max_cpus += vms->memmap[VIRT_GIC_REDIST2].size / 0x20000;
     } else {
         virt_max_cpus = GIC_NCPU;
     }
-- 
2.5.5

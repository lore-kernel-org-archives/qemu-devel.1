Received: from eggs.gnu.org ([2001:4830:134:3::10]:49795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcx-0003Pm-PA
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcw-00054Y-Pu
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:23 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWLcw-00051P-H4
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:22 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcu-0003tS-Tw
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:57:20 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:56:55 +0100
Message-Id: <20180622125713.15303-11-peter.maydell@linaro.org>
In-Reply-To: <20180622125713.15303-1-peter.maydell@linaro.org>
References: <20180622125713.15303-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 10/28] hw/arm/virt: Register two redistributor
 regions when necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

With a VGICv3 KVM device, if the number of vcpus exceeds the
capacity of the legacy redistributor region (123 redistributors),
we now attempt to register a second redistributor region. Up to
512 redistributors can fit in this latter on top of the 123 allowed
by the legacy redistributor region.

Registering this second redistributor region is possible if the
host kernel supports the following VGICv3 KVM device group/attribute:
KVM_DEV_ARM_VGIC_GRP_ADDR/KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION.

In case the host kernel does not support the registration of several
redistributor regions and the requested number of vcpus exceeds the
capacity of the legacy redistributor region, the GICv3 device
initialization fails with a proper error message and qemu exits.

At the moment the max number of vcpus still is capped by the
virt machine class max_cpus.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 1529072910-16156-8-git-send-email-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e5e7606946f..9b9bc5091e3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -529,6 +529,7 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
     SysBusDevice *gicbusdev;
     const char *gictype;
     int type = vms->gic_version, i;
+    uint32_t nb_redist_regions = 0;
 
     gictype = (type == 3) ? gicv3_class_name() : gic_class_name();
 
@@ -548,14 +549,28 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
                     vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
         uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
 
-        qdev_prop_set_uint32(gicdev, "len-redist-region-count", 1);
+        nb_redist_regions = virt_gicv3_redist_region_count(vms);
+
+        qdev_prop_set_uint32(gicdev, "len-redist-region-count",
+                             nb_redist_regions);
         qdev_prop_set_uint32(gicdev, "redist-region-count[0]", redist0_count);
+
+        if (nb_redist_regions == 2) {
+            uint32_t redist1_capacity =
+                        vms->memmap[VIRT_GIC_REDIST2].size / GICV3_REDIST_SIZE;
+
+            qdev_prop_set_uint32(gicdev, "redist-region-count[1]",
+                MIN(smp_cpus - redist0_count, redist1_capacity));
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
@@ -1351,6 +1366,7 @@ static void machvirt_init(MachineState *machine)
      */
     if (vms->gic_version == 3) {
         virt_max_cpus = vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
+        virt_max_cpus += vms->memmap[VIRT_GIC_REDIST2].size / GICV3_REDIST_SIZE;
     } else {
         virt_max_cpus = GIC_NCPU;
     }
-- 
2.17.1

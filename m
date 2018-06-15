Received: from eggs.gnu.org ([2001:4830:134:3::10]:34882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTpiq-0004ma-OV
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTpip-0001OE-Nw
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:29:04 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 15 Jun 2018 16:28:30 +0200
Message-Id: <1529072910-16156-12-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1529072910-16156-1-git-send-email-eric.auger@redhat.com>
References: <1529072910-16156-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/11] hw/arm/virt: Increase max_cpus to 512
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: drjones@redhat.com, wei@redhat.com, zhaoshenglong@huawei.com, lersek@redhat.com, ard.biesheuvel@linaro.org, christoffer.dall@arm.com, marc.zyngier@arm.com

virt 3.0 now allows up to 512 vcpus whereas for earlier machine
types, max_cpus was set to 255 and any attempt to start the
machine with vcpus > 255 was rejected at a very early stage,
in vl.c/main level.

512 is the max supported by KVM. Anyway the actual vcpu count
that can be achieved depends on other parameters such as the
acceleration mode, the vgic version, the host kernel version.
Those are discovered later on.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 5a16e6c..e899475 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1705,11 +1705,11 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
     mc->init = machvirt_init;
-    /* Start max_cpus at the maximum QEMU supports. We'll further restrict
-     * it later in machvirt_init, where we have more information about the
+    /* Start with max_cpus set to 512, which is the maximum supported by KVM.
+     * The value may be reduced later when we have more information about the
      * configuration of the particular instance.
      */
-    mc->max_cpus = 255;
+    mc->max_cpus = 512;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_CALXEDA_XGMAC);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
     mc->block_default_type = IF_VIRTIO;
@@ -1835,6 +1835,7 @@ static void virt_machine_2_12_options(MachineClass *mc)
     virt_machine_3_0_options(mc);
     SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_12);
     vmc->no_highmem_ecam = true;
+    mc->max_cpus = 255;
 }
 DEFINE_VIRT_MACHINE(2, 12)
 
-- 
2.5.5

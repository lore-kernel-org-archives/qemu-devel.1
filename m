Received: from eggs.gnu.org ([2001:4830:134:3::10]:49873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd0-0003Rv-GT
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcz-0005CC-Cx
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:26 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWLcz-00055S-51
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:25 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcx-0003uv-Pr
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:57:23 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:56:59 +0100
Message-Id: <20180622125713.15303-15-peter.maydell@linaro.org>
In-Reply-To: <20180622125713.15303-1-peter.maydell@linaro.org>
References: <20180622125713.15303-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 14/28] hw/arm/virt: Increase max_cpus to 512
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
Message-id: 1529072910-16156-12-git-send-email-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0f8bfa57d7e..742f68afca2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1706,11 +1706,11 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
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
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
@@ -1837,6 +1837,7 @@ static void virt_machine_2_12_options(MachineClass *mc)
     virt_machine_3_0_options(mc);
     SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_12);
     vmc->no_highmem_ecam = true;
+    mc->max_cpus = 255;
 }
 DEFINE_VIRT_MACHINE(2, 12)
 
-- 
2.17.1

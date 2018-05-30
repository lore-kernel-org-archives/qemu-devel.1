Received: from eggs.gnu.org ([2001:4830:134:3::10]:49441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNzYa-00053m-3s
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNzYZ-0005Pe-5L
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:46:20 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 30 May 2018 13:45:41 +0200
Message-Id: <1527680741-2725-9-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1527680741-2725-1-git-send-email-eric.auger@redhat.com>
References: <1527680741-2725-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v3 8/8] hw/arm/virt: Add virt-3.0 machine type
 supporting up to 512 vcpus
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

Add virt-3.0 machine type.

This machine type allows up to 512 vcpus whereas for
earlier machine types, max_cpus was set to 255 and
any attempt to start the machine with vcpus > 255
was rejected at vl.c/main level.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c00f47d..a9fc24b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1697,11 +1697,13 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
     mc->init = machvirt_init;
-    /* Start max_cpus at the maximum QEMU supports. We'll further restrict
-     * it later in machvirt_init, where we have more information about the
-     * configuration of the particular instance.
+    /* Start with max_cpus set to 512. This value is chosen since achievable
+     * in accelerated mode with GICv3 and recent host supporting up to 512 vcpus
+     * and multiple redistributor region registration.
+     * This value will be refined later on once we collect more information
+     * about the configuration of the particular instance.
      */
-    mc->max_cpus = 255;
+    mc->max_cpus = 512;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_CALXEDA_XGMAC);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
     mc->block_default_type = IF_VIRTIO;
@@ -1737,7 +1739,7 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
-static void virt_2_12_instance_init(Object *obj)
+static void virt_3_0_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
@@ -1805,10 +1807,26 @@ static void virt_2_12_instance_init(Object *obj)
     vms->irqmap = a15irqmap;
 }
 
-static void virt_machine_2_12_options(MachineClass *mc)
+static void virt_machine_3_0_options(MachineClass *mc)
 {
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(2, 12)
+DEFINE_VIRT_MACHINE_AS_LATEST(3, 0)
+
+#define VIRT_COMPAT_2_12 \
+    HW_COMPAT_2_12
+
+static void virt_2_12_instance_init(Object *obj)
+{
+    virt_3_0_instance_init(obj);
+}
+
+static void virt_machine_2_12_options(MachineClass *mc)
+{
+    virt_machine_3_0_options(mc);
+    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_12);
+    mc->max_cpus = 255;
+}
+DEFINE_VIRT_MACHINE(2, 12)
 
 #define VIRT_COMPAT_2_11 \
     HW_COMPAT_2_11
-- 
2.5.5

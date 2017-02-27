Received: from eggs.gnu.org ([2001:4830:134:3::10]:52131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfi-0002PA-HS
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPff-0001vS-PK
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:18 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ciPff-0001rj-EK
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:15 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfV-0002Ls-Cj
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:05:05 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 18:04:39 +0000
Message-Id: <1488218699-31035-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
References: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 10/30] hw/arm/virt: Add a user option to
 disallow ITS instantiation
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

In 2.9 ITS will block save/restore and migration use cases. As such,
let's introduce a user option that allows to turn its instantiation
off, along with GICv3. With the "its" option turned false, migration
will be possible, obviously at the expense of MSI support (with GICv3).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-id: 1487681108-14452-1-git-send-email-eric.auger@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h |  1 +
 hw/arm/virt.c         | 31 +++++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 58ce74e..33b0ff3 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -93,6 +93,7 @@ typedef struct {
     FWCfgState *fw_cfg;
     bool secure;
     bool highmem;
+    bool its;
     bool virt;
     int32_t gic_version;
     struct arm_boot_info bootinfo;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0c270b8..5f62a03 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -535,7 +535,6 @@ static void create_v2m(VirtMachineState *vms, qemu_irq *pic)
 static void create_gic(VirtMachineState *vms, qemu_irq *pic)
 {
     /* We create a standalone GIC */
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     DeviceState *gicdev;
     SysBusDevice *gicbusdev;
     const char *gictype;
@@ -605,7 +604,7 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
 
     fdt_add_gic_node(vms);
 
-    if (type == 3 && !vmc->no_its) {
+    if (type == 3 && vms->its) {
         create_its(vms, gicdev);
     } else if (type == 2) {
         create_v2m(vms, pic);
@@ -1481,6 +1480,20 @@ static void virt_set_highmem(Object *obj, bool value, Error **errp)
     vms->highmem = value;
 }
 
+static bool virt_get_its(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->its;
+}
+
+static void virt_set_its(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->its = value;
+}
+
 static char *virt_get_gic_version(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -1541,6 +1554,7 @@ type_init(machvirt_machine_init);
 static void virt_2_9_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
 
     /* EL3 is disabled by default on virt: this makes us consistent
      * between KVM and TCG for this board, and it also allows us to
@@ -1580,6 +1594,19 @@ static void virt_2_9_instance_init(Object *obj)
                                     "Set GIC version. "
                                     "Valid values are 2, 3 and host", NULL);
 
+    if (vmc->no_its) {
+        vms->its = false;
+    } else {
+        /* Default allows ITS instantiation */
+        vms->its = true;
+        object_property_add_bool(obj, "its", virt_get_its,
+                                 virt_set_its, NULL);
+        object_property_set_description(obj, "its",
+                                        "Set on/off to enable/disable "
+                                        "ITS instantiation",
+                                        NULL);
+    }
+
     vms->memmap = a15memmap;
     vms->irqmap = a15irqmap;
 }
-- 
2.7.4

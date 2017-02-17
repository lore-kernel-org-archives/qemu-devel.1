Received: from eggs.gnu.org ([2001:4830:134:3::10]:41297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ceiyl-0001w9-P8
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ceiyk-0003yw-NP
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:53:43 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 17 Feb 2017 14:53:19 +0100
Message-Id: <1487339599-20910-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/arm/virt: Add a user option to disallow ITS
 instantiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: vijay.kilari@gmail.com, drjones@redhat.com

In 2.9 ITS will block save/restore and migration use cases. As
such let's introduce a user option that disallows its instantiation
along with the GICv3. With no-its option turned true, migration will
be possible, obviously at the expense of MSI support (with GICv3).

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

With this patch the option also is added in virt 2.8. I don't know
if it is acceptable.
---
 hw/arm/virt.c         | 28 +++++++++++++++++++++++++++-
 include/hw/arm/virt.h |  1 +
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f3440f2..702a392 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -605,7 +605,7 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
 
     fdt_add_gic_node(vms);
 
-    if (type == 3 && !vmc->no_its) {
+    if (type == 3 && !vmc->no_its && !vms->no_its) {
         create_its(vms, gicdev);
     } else if (type == 2) {
         create_v2m(vms, pic);
@@ -1480,6 +1480,21 @@ static void virt_set_highmem(Object *obj, bool value, Error **errp)
     vms->highmem = value;
 }
 
+static bool virt_get_no_its(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->no_its;
+}
+
+static void virt_set_no_its(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->no_its = value;
+}
+
+
 static char *virt_get_gic_version(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -1540,6 +1555,7 @@ type_init(machvirt_machine_init);
 static void virt_2_9_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
 
     /* EL3 is disabled by default on virt: this makes us consistent
      * between KVM and TCG for this board, and it also allows us to
@@ -1579,6 +1595,16 @@ static void virt_2_9_instance_init(Object *obj)
                                     "Set GIC version. "
                                     "Valid values are 2, 3 and host", NULL);
 
+    /* Default allows ITS instantiation */
+    if (!vmc->no_its) {
+        object_property_add_bool(obj, "no-its", virt_get_no_its,
+                                 virt_set_no_its, NULL);
+        vms->no_its = false;
+        object_property_set_description(obj, "no-its",
+                                        "Disallow the ITS instantiation"
+                                        NULL);
+    }
+
     vms->memmap = a15memmap;
     vms->irqmap = a15irqmap;
 }
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 58ce74e..5e73be9 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -93,6 +93,7 @@ typedef struct {
     FWCfgState *fw_cfg;
     bool secure;
     bool highmem;
+    bool no_its;
     bool virt;
     int32_t gic_version;
     struct arm_boot_info bootinfo;
-- 
2.5.5

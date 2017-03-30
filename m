Received: from eggs.gnu.org ([2001:4830:134:3::10]:40065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ctfyB-0003Qj-30
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 15:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ctfy9-0007J7-Vb
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 15:42:55 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 30 Mar 2017 21:42:18 +0200
Message-Id: <1490902938-9009-6-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1490902938-9009-1-git-send-email-eric.auger@redhat.com>
References: <1490902938-9009-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v3 5/5] hw/arm/virt: Add 2.10 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, edgar.iglesias@gmail.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com

The new machine type allows smmuv3 instantiation. A new option
is introduced to turn the feature on/off (off by default).

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

Another alternative would be to use the -device option as
done on x86. As the smmu is a sysbus device, we would need to
use the platform bus framework. This would work fine
for the dt generation. However the feasibility needs to be
studied for ACPI table generation.

a Veuillez saisir le message de validation pour vos modifications. Les lignes
---
 hw/arm/virt.c         | 51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 include/hw/arm/virt.h |  1 +
 include/hw/compat.h   |  3 +++
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c00efb2..71ea707 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1496,6 +1496,20 @@ static void machvirt_init(MachineState *machine)
     create_platform_bus(vms, pic);
 }
 
+static bool virt_get_smmu(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->smmu;
+}
+
+static void virt_set_smmu(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->smmu = value;
+}
+
 static bool virt_get_secure(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -1609,7 +1623,7 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
-static void virt_2_9_instance_init(Object *obj)
+static void virt_2_10_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
@@ -1665,14 +1679,47 @@ static void virt_2_9_instance_init(Object *obj)
                                         NULL);
     }
 
+    if (vmc->no_smmu) {
+        vms->smmu = false;
+    } else {
+        /* Default disallows smmu instantiation */
+        vms->smmu = false;
+        object_property_add_bool(obj, "smmu", virt_get_smmu,
+                                 virt_set_smmu, NULL);
+        object_property_set_description(obj, "smmu",
+                                        "Set on/off to enable/disable "
+                                        "smmu instantiation (default off)",
+                                        NULL);
+    }
+
     vms->memmap = a15memmap;
     vms->irqmap = a15irqmap;
 }
 
+static void virt_machine_2_10_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(2, 10)
+
+#define VIRT_COMPAT_2_9 \
+    HW_COMPAT_2_9
+
+static void virt_2_9_instance_init(Object *obj)
+{
+    virt_2_10_instance_init(obj);
+}
+
 static void virt_machine_2_9_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
+    virt_machine_2_10_options(mc);
+    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_9);
+
+    vmc->no_smmu = true;
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(2, 9)
+DEFINE_VIRT_MACHINE(2, 9)
+
 
 #define VIRT_COMPAT_2_8 \
     HW_COMPAT_2_8
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 164a531..cd2c82e 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -86,6 +86,7 @@ typedef struct {
     bool disallow_affinity_adjustment;
     bool no_its;
     bool no_pmu;
+    bool no_smmu;
     bool claim_edge_triggered_timers;
 } VirtMachineClass;
 
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 5d5be91..846b90e 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,6 +1,9 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
 
+#define HW_COMPAT_2_9 \
+    /* empty */
+
 #define HW_COMPAT_2_8 \
     {\
         .driver   = "fw_cfg_mem",\
-- 
2.5.5

Received: from eggs.gnu.org ([2001:4830:134:3::10]:34660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dgArc-0000kI-Oa
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dgArb-0002PC-EE
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:24:36 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 11 Aug 2017 16:22:29 +0200
Message-Id: <1502461354-11327-5-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1502461354-11327-1-git-send-email-eric.auger@redhat.com>
References: <1502461354-11327-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v6 4/9] hw/arm/virt: Add 2.11 machine type
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

The new machine type allows smmuv3 instantiation. A new option
is introduced to turn the feature on/off (off by default).

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v5 -> v6: machine 2_11

Another alternative would be to use the -device option as
done on x86. As the smmu is a sysbus device, we would need to
use the platform bus framework.
---
 hw/arm/virt.c         | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 include/hw/arm/virt.h |  1 +
 include/hw/compat.h   |  3 +++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b9246b9..b758173 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1543,6 +1543,20 @@ static void machvirt_init(MachineState *machine)
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
@@ -1698,7 +1712,7 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
-static void virt_2_10_instance_init(Object *obj)
+static void virt_2_11_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
@@ -1754,14 +1768,46 @@ static void virt_2_10_instance_init(Object *obj)
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
 
+static void virt_machine_2_11_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(2, 11)
+
+#define VIRT_COMPAT_2_10 \
+    HW_COMPAT_2_10
+
+static void virt_2_10_instance_init(Object *obj)
+{
+    virt_2_11_instance_init(obj);
+}
+
 static void virt_machine_2_10_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
+    virt_machine_2_11_options(mc);
+    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_10);
+
+    vmc->no_smmu = true;
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(2, 10)
+DEFINE_VIRT_MACHINE(2, 10)
 
 #define VIRT_COMPAT_2_9 \
     HW_COMPAT_2_9
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
index 08f3600..3e101f8 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,6 +1,9 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
 
+#define HW_COMPAT_2_10 \
+    /* empty */
+
 #define HW_COMPAT_2_9 \
     {\
         .driver   = "pci-bridge",\
-- 
2.5.5

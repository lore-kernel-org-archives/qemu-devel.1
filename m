Received: from eggs.gnu.org ([2001:4830:134:3::10]:43340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fLWF1-0002zk-Aa
	for qemu-devel@nongnu.org; Wed, 23 May 2018 12:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fLWF0-0004Eg-Bb
	for qemu-devel@nongnu.org; Wed, 23 May 2018 12:03:55 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 23 May 2018 18:03:38 +0200
Message-Id: <1527091418-11874-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1527091418-11874-1-git-send-email-eric.auger@redhat.com>
References: <1527091418-11874-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 2/2] hw/arm/virt: Add virt-3.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: drjones@redhat.com, wei@redhat.com, zhaoshenglong@huawei.com, lersek@redhat.com, ard.biesheuvel@linaro.org

Add virt-3.0 machine type.

This machine type supports highmem 256MB ECAM by default.
This feature is disabled for earlier machine types and
if highmem is off.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c         | 27 ++++++++++++++++++++++++---
 include/hw/arm/virt.h |  1 +
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a35550b..c24c306 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1520,6 +1520,7 @@ static void virt_set_highmem(Object *obj, bool value, Error **errp)
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
     vms->highmem = value;
+    vms->highmem_ecam &= value;
 }
 
 static bool virt_get_its(Object *obj, Error **errp)
@@ -1697,7 +1698,7 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
-static void virt_2_12_instance_init(Object *obj)
+static void virt_3_0_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
@@ -1740,6 +1741,8 @@ static void virt_2_12_instance_init(Object *obj)
                                     "Set GIC version. "
                                     "Valid values are 2, 3 and host", NULL);
 
+    vms->highmem_ecam = vmc->no_highmem_ecam ? false : true;
+
     if (vmc->no_its) {
         vms->its = false;
     } else {
@@ -1765,10 +1768,28 @@ static void virt_2_12_instance_init(Object *obj)
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
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
+    virt_machine_3_0_options(mc);
+    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_12);
+    vmc->no_highmem_ecam = true;
+}
+DEFINE_VIRT_MACHINE(2, 12)
 
 #define VIRT_COMPAT_2_11 \
     HW_COMPAT_2_11
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index e9423a7..10a5c71 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -95,6 +95,7 @@ typedef struct {
     bool no_pmu;
     bool claim_edge_triggered_timers;
     bool smbios_old_sys_ver;
+    bool no_highmem_ecam;
 } VirtMachineClass;
 
 typedef struct {
-- 
2.5.5

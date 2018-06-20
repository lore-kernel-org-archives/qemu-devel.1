Received: from eggs.gnu.org ([2001:4830:134:3::10]:51068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fVcqB-0004aH-7Y
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fVcqA-0005lM-9a
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:08:03 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 20 Jun 2018 15:07:33 +0200
Message-Id: <1529500053-21704-7-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1529500053-21704-1-git-send-email-eric.auger@redhat.com>
References: <1529500053-21704-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 6/6] hw/arm/virt: handle max_vm_phys_shift
 conflicts on migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: dgilbert@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, drjones@redhat.com, wei@redhat.com, suzuki.poulose@arm.com

When migrating a VM, we must make sure the destination host
supports as many IPA bits as the source. Otherwise the migration
must fail.

We add a VMState infrastructure to machvirt. On pre_save(),
the current source max_vm_phys_shift is saved.

On destination, we cannot use this information when creating the
VM. The VM is created using the max value reported by the
destination host - or the kvm_type inherited value -. However on
post_load() we can check that this value is compatible with the
source saved value.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c         | 37 +++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1700556..667f754 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1258,6 +1258,40 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
     return arm_cpu_mp_affinity(idx, clustersz);
 }
 
+static int virt_post_load(void *opaque, int version_id)
+{
+    VirtMachineState *vms = (VirtMachineState *)opaque;
+
+    if (vms->max_vm_phys_shift < vms->source_max_vm_phys_shift) {
+        error_report("This host kernel only supports %d IPA bits whereas "
+                     "the guest requires %d GPA bits", vms->max_vm_phys_shift,
+                     vms->source_max_vm_phys_shift);
+        return -1;
+    }
+    return 0;
+}
+
+static int virt_pre_save(void *opaque)
+{
+    VirtMachineState *vms = (VirtMachineState *)opaque;
+
+    vms->source_max_vm_phys_shift = vms->max_vm_phys_shift;
+    return 0;
+}
+
+static const VMStateDescription vmstate_virt = {
+    .name = "virt",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = virt_post_load,
+    .pre_save = virt_pre_save,
+    .fields = (VMStateField[]) {
+        VMSTATE_INT32(source_max_vm_phys_shift, VirtMachineState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
@@ -1473,6 +1507,7 @@ static void machvirt_init(MachineState *machine)
 
     vms->machine_done.notify = virt_machine_done;
     qemu_add_machine_init_done_notifier(&vms->machine_done);
+    vmstate_register(NULL, 0, &vmstate_virt, vms);
 }
 
 static bool virt_get_secure(Object *obj, Error **errp)
@@ -1663,6 +1698,7 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
 
 static int virt_kvm_type(MachineState *ms, const char *type_str)
 {
+    VirtMachineState *vms = VIRT_MACHINE(ms);
     int max_vm_phys_shift, ret = 0;
     uint64_t type;
 
@@ -1683,6 +1719,7 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
     }
     ret = max_vm_phys_shift;
 out:
+    vms->max_vm_phys_shift = (max_vm_phys_shift > 0) ? ret : 40;
     return ret;
 }
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 2674ce7..600d96d 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -119,6 +119,8 @@ typedef struct {
     uint32_t iommu_phandle;
     int psci_conduit;
     char *kvm_type;
+    int32_t max_vm_phys_shift;
+    int32_t source_max_vm_phys_shift;
 } VirtMachineState;
 
 #define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("virt")
-- 
2.5.5

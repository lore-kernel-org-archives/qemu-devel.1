Received: from eggs.gnu.org ([2001:4830:134:3::10]:45688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fa2Xs-00007H-Vq
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fa2Xn-0006Xc-Ui
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:23:24 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  2 Jul 2018 19:22:31 +0200
Message-Id: <1530552162-15533-5-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1530552162-15533-1-git-send-email-eric.auger@redhat.com>
References: <1530552162-15533-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v2 04/15] hw/arm/virt: support kvm_type property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, drjones@redhat.com, wei@redhat.com

The kvm-type property currently is used to pass
a user parameter to KVM_CREATE_VM. This matches
the way KVM/ARM expects to pass the max_vm_phys_shift
parameter.

This patch adds the support or the kvm-type property in
machvirt and also implements the machine class kvm_type()
callback so that it either returns the kvm-type value
provided by the user or returns the max_vm_phys_shift
exposed by KVM.

for instance, the usespace can use the following option to
instantiate a 42b IPA guest: -machine kvm-type=42

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c         | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h |  1 +
 2 files changed, 45 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 281ddcd..04a32de 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1649,6 +1649,21 @@ static void virt_set_iommu(Object *obj, const char *value, Error **errp)
     }
 }
 
+static char *virt_get_kvm_type(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return g_strdup(vms->kvm_type);
+}
+
+static void virt_set_kvm_type(Object *obj, const char *value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    g_free(vms->kvm_type);
+    vms->kvm_type = g_strdup(value);
+}
+
 static CpuInstanceProperties
 virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 {
@@ -1710,6 +1725,31 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
+static int virt_kvm_type(MachineState *ms, const char *type_str)
+{
+    int max_vm_phys_shift, ret = 0;
+    uint64_t type;
+
+    if (!type_str) {
+        max_vm_phys_shift = kvm_arm_get_max_vm_phys_shift(ms);
+        if (max_vm_phys_shift < 0) {
+            goto out;
+        }
+    } else {
+        type = g_ascii_strtoll(type_str, NULL, 0);
+        type &= 0xFF;
+        max_vm_phys_shift = (int)type;
+        if (max_vm_phys_shift < 40 || max_vm_phys_shift > 52) {
+            warn_report("valid kvm-type type values are within [40, 52]:"
+                        " option is ignored and VM is created with 40b IPA");
+            goto out;
+        }
+    }
+    ret = max_vm_phys_shift;
+out:
+    return ret;
+}
+
 static void virt_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1733,6 +1773,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
+    mc->kvm_type = virt_kvm_type;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
     hc->plug = virt_machine_device_plug_cb;
@@ -1826,6 +1867,9 @@ static void virt_3_0_instance_init(Object *obj)
                                     "Valid values are none and smmuv3",
                                     NULL);
 
+    object_property_add_str(obj, "kvm-type",
+                            virt_get_kvm_type, virt_set_kvm_type, NULL);
+
     vms->memmap = a15memmap;
     vms->irqmap = a15irqmap;
 }
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 9a870cc..1a90ffc 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -124,6 +124,7 @@ typedef struct {
     uint32_t msi_phandle;
     uint32_t iommu_phandle;
     int psci_conduit;
+    char *kvm_type;
 } VirtMachineState;
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_PCIE_ECAM_HIGH : VIRT_PCIE_ECAM)
-- 
2.5.5

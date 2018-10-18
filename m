Received: from eggs.gnu.org ([2001:4830:134:3::10]:36238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gD9L0-0005wU-FD
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gD9Kz-0007NL-Ai
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:31:46 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 18 Oct 2018 16:30:33 +0200
Message-Id: <20181018143042.29588-8-eric.auger@redhat.com>
In-Reply-To: <20181018143042.29588-1-eric.auger@redhat.com>
References: <20181018143042.29588-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v4 07/16] hw/arm/virt: Implement kvm_type
 function for 3.2 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, imammedo@redhat.com, david@redhat.com
Cc: drjones@redhat.com, dgilbert@redhat.com, Suzuki.Poulose@arm.com

This patch computes the requested IPA bits according to
the requested maxram value.

The machine class kvm_type() callback is implemented and
fills the kvm_type[7-0] bits with the computed max IPA shift
(0 default value corresponds to 40b IPA). The kvm_type is
passed to the KVM_CREATE_VM ioctl.

The max IPA address shift is computed assuming the top of the
address space is occuped by device memory starting at 2TB and
of size maxram_size - ramsize.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

The approach to have an IPA range depending on the machine memory
attributes is preferred here against having an IPA range based
on the max capability of the host (which would be simpler). This
latter would sometimes lead to having additional useless translation
levels at stage2 as this may downgrade the guest performance.
---
 hw/arm/virt.c         | 48 ++++++++++++++++++++++++++++++++++++++++++-
 include/hw/arm/virt.h |  1 +
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f920ef247b..21718c250e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -108,8 +108,12 @@
  * of a terabyte of RAM will be doing it on a host with more than a
  * terabyte of physical address space.)
  */
+#define SZ_1G (1024ULL * 1024 * 1024)
 #define RAMLIMIT_GB 255
-#define RAMLIMIT_BYTES (RAMLIMIT_GB * 1024ULL * 1024 * 1024)
+#define RAMLIMIT_BYTES (RAMLIMIT_GB * SZ_1G)
+
+/* device memory starts at 2TB */
+#define DEVICE_MEM_BASE (2048 * SZ_1G)
 
 /* Addresses and sizes of our components.
  * 0..128MB is space for a flash device so we can run bootrom code such as UEFI.
@@ -1748,6 +1752,38 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
+/*
+ * for arm64 kvm_type [7-0] encodes the IPA size shift
+ */
+static inline int virt_kvm_type(MachineState *ms, const char *type_str)
+{
+    int max_vm_phys_shift = kvm_arm_get_max_vm_phys_shift(ms);
+    ram_addr_t device_mem_size = ms->maxram_size - ms->ram_size;
+    uint8_t requested_vm_phys_shift;
+
+    if (!device_mem_size) {
+        return 0; /* default 40b IPA */
+    }
+
+    /* we need at least 42b IPA to fit device memory at 2TB*/
+    if (max_vm_phys_shift < 42) {
+        error_report("This host does not support 42b IPA: "
+                     "maxram/slots options not usable");
+        exit(1);
+    }
+
+    requested_vm_phys_shift = 64 - clz64(DEVICE_MEM_BASE + device_mem_size);
+
+    if (requested_vm_phys_shift > max_vm_phys_shift) {
+        error_report("maxmem option value too large. Max supported value "
+                     "for this host is 0x%"PRIx64,
+                     (ram_addr_t)((1ULL << max_vm_phys_shift) - DEVICE_MEM_BASE));
+       exit(1);
+    }
+
+    return requested_vm_phys_shift;
+}
+
 static void virt_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1772,6 +1808,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
+    mc->kvm_type = virt_kvm_type;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
     hc->plug = virt_machine_device_plug_cb;
@@ -1878,7 +1915,16 @@ static void virt_3_1_instance_init(Object *obj)
 
 static void virt_machine_3_1_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_3_2_options(mc);
+
+    /*
+     * Device memory and capability to set the max IPA address shift
+     * are enabled from 3.2 onwards
+     */
+    vmc->no_device_memory = true;
+    mc->kvm_type = NULL;
 }
 DEFINE_VIRT_MACHINE(3, 1)
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 4cc57a7ef6..f57e4c1890 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -101,6 +101,7 @@ typedef struct {
     bool claim_edge_triggered_timers;
     bool smbios_old_sys_ver;
     bool no_highmem_ecam;
+    bool no_device_memory;
 } VirtMachineClass;
 
 typedef struct {
-- 
2.17.1

Received: from eggs.gnu.org ([209.51.188.92]:36156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hBCUi-000891-TA
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hBCPd-0001aZ-BC
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 01:56:46 -0400
From: Like Xu <like.xu@linux.intel.com>
Date: Tue,  2 Apr 2019 13:55:37 +0800
Message-Id: <1554184537-35011-1-git-send-email-like.xu@linux.intel.com>
Subject: [Qemu-devel] [PATCH] vl.c: make current_machine as non-global
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, like.xu@linux.intel.com

This patch makes the remaining dozen or so uses of the global
current_machine outside vl.c use qdev_get_machine() instead,
and then make current_machine local to vl.c instead of global.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 accel/kvm/kvm-all.c | 6 ++++--
 device-hotplug.c    | 3 ++-
 device_tree.c       | 3 ++-
 exec.c              | 6 ++++--
 hw/ppc/spapr_rtas.c | 3 ++-
 include/hw/boards.h | 1 -
 migration/savevm.c  | 9 ++++++---
 qmp.c               | 3 ++-
 target/i386/kvm.c   | 3 ++-
 target/ppc/kvm.c    | 3 ++-
 vl.c                | 4 ++--
 11 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 241db49..d103de2 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -140,7 +140,8 @@ static const KVMCapabilityInfo kvm_required_capabilites[] = {
 
 int kvm_get_max_memslots(void)
 {
-    KVMState *s = KVM_STATE(current_machine->accelerator);
+    MachineState *ms = MACHINE(qdev_get_machine());
+    KVMState *s = KVM_STATE(ms->accelerator);
 
     return s->nr_slots;
 }
@@ -1519,7 +1520,8 @@ static int kvm_max_vcpu_id(KVMState *s)
 
 bool kvm_vcpu_id_is_valid(int vcpu_id)
 {
-    KVMState *s = KVM_STATE(current_machine->accelerator);
+    MachineState *ms = MACHINE(qdev_get_machine());
+    KVMState *s = KVM_STATE(ms->accelerator);
     return vcpu_id >= 0 && vcpu_id < kvm_max_vcpu_id(s);
 }
 
diff --git a/device-hotplug.c b/device-hotplug.c
index 6090d5f..3d033f5 100644
--- a/device-hotplug.c
+++ b/device-hotplug.c
@@ -37,6 +37,7 @@
 
 static DriveInfo *add_init_drive(const char *optstr)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     Error *err = NULL;
     DriveInfo *dinfo;
     QemuOpts *opts;
@@ -46,7 +47,7 @@ static DriveInfo *add_init_drive(const char *optstr)
     if (!opts)
         return NULL;
 
-    mc = MACHINE_GET_CLASS(current_machine);
+    mc = MACHINE_GET_CLASS(ms);
     dinfo = drive_new(opts, mc->block_default_type, &err);
     if (!dinfo) {
         error_report_err(err);
diff --git a/device_tree.c b/device_tree.c
index 296278e..370b74e 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -455,6 +455,7 @@ int qemu_fdt_setprop_phandle(void *fdt, const char *node_path,
 
 uint32_t qemu_fdt_alloc_phandle(void *fdt)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     static int phandle = 0x0;
 
     /*
@@ -462,7 +463,7 @@ uint32_t qemu_fdt_alloc_phandle(void *fdt)
      * which phandle id to start allocating phandles.
      */
     if (!phandle) {
-        phandle = machine_phandle_start(current_machine);
+        phandle = machine_phandle_start(ms);
     }
 
     if (!phandle) {
diff --git a/exec.c b/exec.c
index 6ab62f4..15ff2b1 100644
--- a/exec.c
+++ b/exec.c
@@ -1969,10 +1969,11 @@ static unsigned long last_ram_page(void)
 
 static void qemu_ram_setup_dump(void *addr, ram_addr_t size)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     int ret;
 
     /* Use MADV_DONTDUMP, if user doesn't want the guest memory in the core */
-    if (!machine_dump_guest_core(current_machine)) {
+    if (!machine_dump_guest_core(ms)) {
         ret = qemu_madvise(addr, size, QEMU_MADV_DONTDUMP);
         if (ret) {
             perror("qemu_madvise");
@@ -2094,7 +2095,8 @@ size_t qemu_ram_pagesize_largest(void)
 
 static int memory_try_enable_merging(void *addr, size_t len)
 {
-    if (!machine_mem_merge(current_machine)) {
+    MachineState *ms = MACHINE(qdev_get_machine());
+    if (!machine_mem_merge(ms)) {
         /* disabled by the user */
         return 0;
     }
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 24c45b1..51e320d 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -231,6 +231,7 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
                                           target_ulong args,
                                           uint32_t nret, target_ulong rets)
 {
+    MachineState *ms = MACHINE(spapr);
     target_ulong parameter = rtas_ld(args, 0);
     target_ulong buffer = rtas_ld(args, 1);
     target_ulong length = rtas_ld(args, 2);
@@ -243,7 +244,7 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
                                           "DesProcs=%d,"
                                           "MaxPlatProcs=%d",
                                           max_cpus,
-                                          current_machine->ram_size / MiB,
+                                          ms->ram_size / MiB,
                                           smp_cpus,
                                           max_cpus);
         ret = sysparm_st(buffer, length, param_val, strlen(param_val) + 1);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index e231860..1d598c8 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -58,7 +58,6 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
     OBJECT_CLASS_CHECK(MachineClass, (klass), TYPE_MACHINE)
 
 MachineClass *find_default_machine(void);
-extern MachineState *current_machine;
 
 void machine_run_board_init(MachineState *machine);
 bool machine_usb(MachineState *machine);
diff --git a/migration/savevm.c b/migration/savevm.c
index 1415001..8077ac5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -286,8 +286,9 @@ static uint32_t get_validatable_capabilities_count(void)
 
 static int configuration_pre_save(void *opaque)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     SaveState *state = opaque;
-    const char *current_name = MACHINE_GET_CLASS(current_machine)->name;
+    const char *current_name = MACHINE_GET_CLASS(ms)->name;
     MigrationState *s = migrate_get_current();
     int i, j;
 
@@ -355,8 +356,9 @@ static bool configuration_validate_capabilities(SaveState *state)
 
 static int configuration_post_load(void *opaque, int version_id)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     SaveState *state = opaque;
-    const char *current_name = MACHINE_GET_CLASS(current_machine)->name;
+    const char *current_name = MACHINE_GET_CLASS(ms)->name;
 
     if (strncmp(state->name, current_name, state->len) != 0) {
         error_report("Machine type received is '%.*s' and local is '%s'",
@@ -566,9 +568,10 @@ static void dump_vmstate_vmsd(FILE *out_file,
 
 static void dump_machine_type(FILE *out_file)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     MachineClass *mc;
 
-    mc = MACHINE_GET_CLASS(current_machine);
+    mc = MACHINE_GET_CLASS(ms);
 
     fprintf(out_file, "  \"vmschkmachine\": {\n");
     fprintf(out_file, "    \"Name\": \"%s\"\n", mc->name);
diff --git a/qmp.c b/qmp.c
index b92d62c..f2a5473 100644
--- a/qmp.c
+++ b/qmp.c
@@ -119,9 +119,10 @@ void qmp_system_powerdown(Error **erp)
 
 void qmp_cpu_add(int64_t id, Error **errp)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     MachineClass *mc;
 
-    mc = MACHINE_GET_CLASS(current_machine);
+    mc = MACHINE_GET_CLASS(ms);
     if (mc->hot_add_cpu) {
         mc->hot_add_cpu(id, errp);
     } else {
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 3b29ce5..b25d766 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -134,7 +134,8 @@ bool kvm_allows_irq0_override(void)
 
 static bool kvm_x2apic_api_set_flags(uint64_t flags)
 {
-    KVMState *s = KVM_STATE(current_machine->accelerator);
+    MachineState *ms = MACHINE(qdev_get_machine());
+    KVMState *s = KVM_STATE(ms->accelerator);
 
     return !kvm_vm_enable_cap(s, KVM_CAP_X2APIC_API, 0, flags);
 }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 2427c8e..c3bea37 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -276,7 +276,8 @@ static void kvm_get_smmu_info(struct kvm_ppc_smmu_info *info, Error **errp)
 
 struct ppc_radix_page_info *kvm_get_radix_page_info(void)
 {
-    KVMState *s = KVM_STATE(current_machine->accelerator);
+    MachineState *ms = MACHINE(qdev_get_machine());
+    KVMState *s = KVM_STATE(ms->accelerator);
     struct ppc_radix_page_info *radix_page_info;
     struct kvm_ppc_rmmu_info rmmu_info;
     int i;
diff --git a/vl.c b/vl.c
index d61d560..98d1e1e1f 100644
--- a/vl.c
+++ b/vl.c
@@ -1265,6 +1265,8 @@ static QemuOptsList qemu_smp_opts = {
     },
 };
 
+MachineState *current_machine;
+
 static void smp_parse(QemuOpts *opts)
 {
     if (opts) {
@@ -1462,8 +1464,6 @@ static int usb_parse(const char *cmdline)
 /***********************************************************/
 /* machine registration */
 
-MachineState *current_machine;
-
 static MachineClass *find_machine(const char *name)
 {
     GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
-- 
1.8.3.1

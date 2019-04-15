Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC4AC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 08:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A225520652
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 08:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A225520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46360 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFwbA-0002Rv-Tn
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 04:04:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hFwXu-0000gM-Ky
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hFwXs-0001Sy-UA
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:00:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:40828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1hFwXp-0001PK-0w; Mon, 15 Apr 2019 04:00:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	15 Apr 2019 01:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,352,1549958400"; d="scan'208";a="140739279"
Received: from xulike-server.sh.intel.com ([10.239.48.134])
	by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2019 01:00:44 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-trivial@nongnu.org
Date: Mon, 15 Apr 2019 15:59:44 +0800
Message-Id: <1555315185-16414-2-git-send-email-like.xu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555315185-16414-1-git-send-email-like.xu@linux.intel.com>
References: <1555315185-16414-1-git-send-email-like.xu@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.24
Subject: [Qemu-devel] [PATCH v3 1/2] vl.c: refactor current_machine as
 non-global variable
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>, like.xu@intel.com,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415075944.mfMSnAU8b-0p_rXPDVBOPf0OjttH3qqj9vmCa6gdzVg@z>

This patch makes the remaining dozen or so uses of the global
current_machine outside vl.c use qdev_get_machine() instead,
and then make current_machine local to vl.c instead of global.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
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
index 6153259..d31c1f8 100644
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
     if (err) {
         error_report_err(err);
diff --git a/device_tree.c b/device_tree.c
index f8b46b3..3294ef6 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -459,6 +459,7 @@ int qemu_fdt_setprop_phandle(void *fdt, const char *node_path,
 
 uint32_t qemu_fdt_alloc_phandle(void *fdt)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     static int phandle = 0x0;
 
     /*
@@ -466,7 +467,7 @@ uint32_t qemu_fdt_alloc_phandle(void *fdt)
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
index 34bcad3..4261061 100644
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
index c696ad2..a1a8b24 100644
--- a/vl.c
+++ b/vl.c
@@ -1266,6 +1266,8 @@ static QemuOptsList qemu_smp_opts = {
     },
 };
 
+static MachineState *current_machine;
+
 static void smp_parse(QemuOpts *opts)
 {
     if (opts) {
@@ -1463,8 +1465,6 @@ static int usb_parse(const char *cmdline)
 /***********************************************************/
 /* machine registration */
 
-MachineState *current_machine;
-
 static MachineClass *find_machine(const char *name)
 {
     GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
-- 
1.8.3.1



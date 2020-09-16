Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FA6C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:38:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2351C2064E
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2351C2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISxf-0006yv-8k
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kISwZ-0005kD-4h
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:37:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:47313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kISwU-00078f-JK
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:37:34 -0400
IronPort-SDR: xmjTz4eujF6EUs7WaWv9IPZ4zIIhXkSCwAMa7TjjlhE2hQgaNVvjw6ymI/CBzAzZucAa+ds+D+
 kQghNS3ChDUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="158705907"
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; d="scan'208";a="158705907"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2020 01:37:26 -0700
IronPort-SDR: UfUGURLDNXZjmli5whk5TzqUrU+1IDoGAl1SOqKY4/nNjHNEdpFZ0Nwpme4pqFl8HIwlx4hV+I
 430/UIpmcC5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; d="scan'208";a="306959077"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by orsmga006.jf.intel.com with ESMTP; 16 Sep 2020 01:37:23 -0700
From: Robert Hoo <robert.hu@linux.intel.com>
To: ehabkost@redhat.com, eblake@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net, armbru@redhat.com
Subject: [PATCH v3 1/2] Introduce (x86) CPU model deprecation API
Date: Wed, 16 Sep 2020 16:37:13 +0800
Message-Id: <1600245434-63021-1-git-send-email-robert.hu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: none client-ip=192.55.52.115;
 envelope-from=robert.hu@linux.intel.com; helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 04:37:26
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: robert.hu@intel.com, qemu-devel@nongnu.org,
 Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Complement versioned CPU model framework with the ability of marking some
versions deprecated. When that CPU model is chosen, get some warning. The
warning message is customized, e.g. telling in which future QEMU version will
it be obsoleted.
The deprecation message will also appear by x86_cpu_list_entry(), e.g. '-cpu
help'.
QMP 'query-cpu-definitions' will also return a bool value indicating the
deprecation status.

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
Changelog
v3:
Make the deprecation implementation CPUClass generic.

v2:
Move deprecation check from parse_cpu_option() to machine_run_board_init(), so
that it can cover implicit cpu_type assignment cases.
Add qapi new member documentation. Thanks Eric for comment and guidance on qapi.

 hw/core/machine.c        | 12 ++++++++++--
 include/hw/core/cpu.h    |  6 ++++++
 qapi/machine-target.json |  7 ++++++-
 target/i386/cpu.c        | 29 +++++++++++++++++++++++------
 4 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index ea26d61..b41f88d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1095,6 +1095,8 @@ MemoryRegion *machine_consume_memdev(MachineState *machine,
 void machine_run_board_init(MachineState *machine)
 {
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
+    ObjectClass *oc = object_class_by_name(machine->cpu_type);
+    CPUClass *cc;
 
     if (machine->ram_memdev_id) {
         Object *o;
@@ -1114,11 +1116,10 @@ void machine_run_board_init(MachineState *machine)
      * specified a CPU with -cpu check here that the user CPU is supported.
      */
     if (machine_class->valid_cpu_types && machine->cpu_type) {
-        ObjectClass *class = object_class_by_name(machine->cpu_type);
         int i;
 
         for (i = 0; machine_class->valid_cpu_types[i]; i++) {
-            if (object_class_dynamic_cast(class,
+            if (object_class_dynamic_cast(oc,
                                           machine_class->valid_cpu_types[i])) {
                 /* The user specificed CPU is in the valid field, we are
                  * good to go.
@@ -1141,6 +1142,13 @@ void machine_run_board_init(MachineState *machine)
         }
     }
 
+    /* Check if CPU type is deprecated and warn if so */
+    cc = CPU_CLASS(oc);
+    if (cc->deprecated) {
+        warn_report("CPU model %s is deprecated -- %s", machine->cpu_type,
+                    cc->deprecation_note);
+    }
+
     machine_class->init(machine);
 }
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 99dc33f..c4b17c8 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -155,6 +155,10 @@ struct TranslationBlock;
  * @disas_set_info: Setup architecture specific components of disassembly info
  * @adjust_watchpoint_address: Perform a target-specific adjustment to an
  * address before attempting to match it against watchpoints.
+ * @deprecated: True if this CPU model is deprecated (going to be removed in
+ *              near future).
+ * @deprecation_note: Message about the deprecation. e.g. Since which version
+ *                    will it be obsoleted.
  *
  * Represents a CPU family or model.
  */
@@ -221,6 +225,8 @@ struct CPUClass {
     vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr, int len);
     void (*tcg_initialize)(void);
 
+    bool deprecated;
+    const char *deprecation_note;
     /* Keep non-pointer data at the end to minimize holes.  */
     int gdb_num_core_regs;
     bool gdb_stop_before_watchpoint;
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 698850c..fec3bb8 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -286,6 +286,10 @@
 #            in the VM configuration, because aliases may stop being
 #            migration-safe in the future (since 4.1)
 #
+# @deprecated: If true, this CPU model is deprecated and may be removed in
+#              in some future version of QEMU according to the QEMU deprecation
+#              policy. (since 5.2)
+#
 # @unavailable-features is a list of QOM property names that
 # represent CPU model attributes that prevent the CPU from running.
 # If the QOM property is read-only, that means there's no known
@@ -310,7 +314,8 @@
             'static': 'bool',
             '*unavailable-features': [ 'str' ],
             'typename': 'str',
-            '*alias-of' : 'str' },
+            '*alias-of' : 'str',
+            'deprecated' : 'bool' },
   'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
 
 ##
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 49d8958..9cb82b7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1716,6 +1716,7 @@ typedef struct X86CPUVersionDefinition {
     const char *alias;
     const char *note;
     PropValue *props;
+    bool       deprecated;
 } X86CPUVersionDefinition;
 
 /* Base definition for a CPU model */
@@ -1751,6 +1752,11 @@ struct X86CPUModel {
      * This matters only for "-cpu help" and query-cpu-definitions
      */
     bool is_alias;
+    /*
+     * If true, this model is deprecated, and may be removed in the future.
+     * Trying to use it now will cause a warning.
+     */
+    bool deprecated;
 };
 
 /* Get full model name for CPU version */
@@ -5096,6 +5102,7 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
     info->migration_safe = cc->migration_safe;
     info->has_migration_safe = true;
     info->q_static = cc->static_model;
+    info->deprecated = cc->model ? cc->model->deprecated : false;
     /*
      * Old machine types won't report aliases, so that alias translation
      * doesn't break compatibility with previous QEMU versions.
@@ -5486,9 +5493,12 @@ static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
 {
     X86CPUModel *model = data;
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
+    CPUClass *cc = CPU_CLASS(oc);
 
     xcc->model = model;
     xcc->migration_safe = true;
+    cc->deprecated = model->deprecated;
+    cc->deprecation_note = g_strdup(model->note);
 }
 
 static void x86_register_cpu_model_type(const char *name, X86CPUModel *model)
@@ -5524,21 +5534,28 @@ static void x86_register_cpudef_types(X86CPUDefinition *def)
     x86_register_cpu_model_type(def->name, m);
 
     /* Versioned models: */
-
     for (vdef = x86_cpu_def_get_versions(def); vdef->version; vdef++) {
-        X86CPUModel *m = g_new0(X86CPUModel, 1);
+        X86CPUModel *vm = g_new0(X86CPUModel, 1);
         g_autofree char *name =
             x86_cpu_versioned_model_name(def, vdef->version);
-        m->cpudef = def;
-        m->version = vdef->version;
-        m->note = vdef->note;
-        x86_register_cpu_model_type(name, m);
+        vm->cpudef = def;
+        vm->version = vdef->version;
+        vm->note = vdef->note;
+        vm->deprecated = vdef->deprecated;
+        /* If Model-v1 is deprecated, Model is deprecated. */
+        if (vdef->version == 1 && vdef->deprecated == true) {
+            m->deprecated = true;
+            m->note = vdef->note;
+        }
+        x86_register_cpu_model_type(name, vm);
 
         if (vdef->alias) {
             X86CPUModel *am = g_new0(X86CPUModel, 1);
             am->cpudef = def;
             am->version = vdef->version;
             am->is_alias = true;
+            am->note = vdef->note;
+            am->deprecated = vdef->deprecated;
             x86_register_cpu_model_type(vdef->alias, am);
         }
     }
-- 
1.8.3.1



Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D225C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:15:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC5C2076E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC5C2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKcWf-0007fk-NI
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 03:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kKcVX-0006is-UI
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:14:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:37150)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kKcVV-0006Kd-02
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:14:35 -0400
IronPort-SDR: nsftTT2QaBh21gUc4BPUvU88LuZwBnD22zhLn67/9wy7+qOcuQFs9XRaJbcDfde+r6bL/JbpOi
 4GPDP9ALjyJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="222141827"
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; d="scan'208";a="222141827"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 00:14:29 -0700
IronPort-SDR: W1K83BuwA/H722vOV2zFoN0AUyZSrTqclSLejlrac1f6zAEKHmWml57WflPwLR9o/S/rUgWDA/
 R8kc2WfSePDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; d="scan'208";a="341918100"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by fmsmga002.fm.intel.com with ESMTP; 22 Sep 2020 00:14:26 -0700
From: Robert Hoo <robert.hu@linux.intel.com>
To: ehabkost@redhat.com, eblake@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net, armbru@redhat.com
Subject: [PATCH v4 1/2] Introduce (x86) CPU model deprecation API
Date: Tue, 22 Sep 2020 15:14:14 +0800
Message-Id: <1600758855-80046-1-git-send-email-robert.hu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: none client-ip=134.134.136.31;
 envelope-from=robert.hu@linux.intel.com; helo=mga06.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 03:14:31
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
v4:
Move deprecation_note from X86CPUModel to X86CPUDefinition, to make it
simple. Also, simplify 2 fields (deprecation_note and deprecated) into 1
(deprecation_note).

v3:
Make the deprecation implementation CPUClass generic.

v2:
Move deprecation check from parse_cpu_option() to machine_run_board_init(), so
that it can cover implicit cpu_type assignment cases.
Add qapi new member documentation. Thanks Eric for comment and guidance on qapi.

---
 hw/core/machine.c        | 12 ++++++++++--
 include/hw/core/cpu.h    |  3 +++
 qapi/machine-target.json |  7 ++++++-
 target/i386/cpu.c        |  8 ++++++++
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index ea26d61..67fff0b 100644
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
+    if (cc->deprecation_note) {
+        warn_report("CPU model %s is deprecated -- %s", machine->cpu_type,
+                    cc->deprecation_note);
+    }
+
     machine_class->init(machine);
 }
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 99dc33f..c40c29d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -155,6 +155,8 @@ struct TranslationBlock;
  * @disas_set_info: Setup architecture specific components of disassembly info
  * @adjust_watchpoint_address: Perform a target-specific adjustment to an
  * address before attempting to match it against watchpoints.
+ * @deprecation_note: If this CPUClass is deprecated, this field provides
+ *                    related information.
  *
  * Represents a CPU family or model.
  */
@@ -221,6 +223,7 @@ struct CPUClass {
     vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr, int len);
     void (*tcg_initialize)(void);
 
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
index 1c58f76..323c7e3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1633,6 +1633,7 @@ typedef struct X86CPUDefinition {
      * If NULL, version 1 will be registered automatically.
      */
     const X86CPUVersionDefinition *versions;
+    const char *deprecation_note;
 } X86CPUDefinition;
 
 /* Reference to a specific CPU model version */
@@ -4992,6 +4993,11 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
     info->migration_safe = cc->migration_safe;
     info->has_migration_safe = true;
     info->q_static = cc->static_model;
+    if (cc->model && cc->model->cpudef->deprecation_note) {
+        info->deprecated = true;
+    } else {
+        info->deprecated = false;
+    }
     /*
      * Old machine types won't report aliases, so that alias translation
      * doesn't break compatibility with previous QEMU versions.
@@ -5382,9 +5388,11 @@ static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
 {
     X86CPUModel *model = data;
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
+    CPUClass *cc = CPU_CLASS(oc);
 
     xcc->model = model;
     xcc->migration_safe = true;
+    cc->deprecation_note = model->cpudef->deprecation_note;
 }
 
 static void x86_register_cpu_model_type(const char *name, X86CPUModel *model)
-- 
1.8.3.1



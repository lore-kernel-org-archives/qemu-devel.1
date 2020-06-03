Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0FBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 11:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B824120674
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 11:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B824120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgRsc-00060M-0Z
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 07:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1jgRrn-0004ix-RC
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 07:47:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:46649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1jgRrm-0002xR-Fs
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 07:47:31 -0400
IronPort-SDR: AmtYXvAiooPDfVFLQI9Go/z3HjbwqY8H4lI6uxTa4nmwa8t6uigoV9ZiD1iCUc8pjmy33Fmsf9
 veEwSN18fTwg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2020 04:47:23 -0700
IronPort-SDR: IjyFuIf7dsiu7Kq2QeOd3qoRDBwtG3d5uSEfC4KXw6GKabwtLUO6QJAaHID33O6qk+/31PcGS6
 /yHNAoDZL7CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; d="scan'208";a="304582616"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by orsmga008.jf.intel.com with ESMTP; 03 Jun 2020 04:47:20 -0700
From: Robert Hoo <robert.hu@linux.intel.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 eblake@redhat.com, armbru@redhat.com
Subject: [PATCH 1/2] Introduce (x86) CPU model deprecation API
Date: Wed,  3 Jun 2020 19:47:02 +0800
Message-Id: <1591184823-140846-1-git-send-email-robert.hu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: none client-ip=134.134.136.65;
 envelope-from=robert.hu@linux.intel.com; helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 07:47:24
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: robert.hu@intel.com, Robert Hoo <robert.hu@linux.intel.com>,
 xiaoyao.li@intel.com, qemu-devel@nongnu.org, chenyi.qiang@intel.com
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
 exec.c                   |  3 +++
 include/hw/core/cpu.h    |  1 +
 qapi/machine-target.json |  3 ++-
 target/i386/cpu.c        | 45 +++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/exec.c b/exec.c
index 5162f0d..a403937 100644
--- a/exec.c
+++ b/exec.c
@@ -981,6 +981,9 @@ const char *parse_cpu_option(const char *cpu_option)
     cpu_type = object_class_get_name(oc);
     cc = CPU_CLASS(oc);
     cc->parse_features(cpu_type, model_pieces[1], &error_fatal);
+    if (cc->deprecation_check) {
+        cc->deprecation_check(oc);
+    }
     g_strfreev(model_pieces);
     return cpu_type;
 }
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 07f7698..b2df186 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -218,6 +218,7 @@ typedef struct CPUClass {
     void (*disas_set_info)(CPUState *cpu, disassemble_info *info);
     vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr, int len);
     void (*tcg_initialize)(void);
+    void (*deprecation_check)(ObjectClass *oc);
 
     /* Keep non-pointer data at the end to minimize holes.  */
     int gdb_num_core_regs;
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index f2c8294..2e7db97 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -309,7 +309,8 @@
             'static': 'bool',
             '*unavailable-features': [ 'str' ],
             'typename': 'str',
-            '*alias-of' : 'str' },
+            '*alias-of' : 'str',
+            'deprecated' : 'bool' },
   'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
 
 ##
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3733d9a..d7ac22f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1599,6 +1599,7 @@ typedef struct X86CPUVersionDefinition {
     const char *alias;
     const char *note;
     PropValue *props;
+    bool       deprecated;
 } X86CPUVersionDefinition;
 
 /* Base definition for a CPU model */
@@ -1638,6 +1639,11 @@ struct X86CPUModel {
      * This matters only for "-cpu help" and query-cpu-definitions
      */
     bool is_alias;
+    /*
+     * If true, this is deprecated and obsoleted in the future.
+     * Trying to use deprecated CPU model shall be warned.
+     */
+    bool deprecated;
 };
 
 /* Get full model name for CPU version */
@@ -4128,8 +4134,7 @@ static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
     X86CPUVersion v = model->version;
     if (v == CPU_VERSION_AUTO) {
         v = default_cpu_version;
-    }
-    if (v == CPU_VERSION_LATEST) {
+    } else if (v == CPU_VERSION_LATEST) {
         return x86_cpu_model_last_version(model);
     }
     return v;
@@ -4975,6 +4980,7 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
     info->migration_safe = cc->migration_safe;
     info->has_migration_safe = true;
     info->q_static = cc->static_model;
+    info->deprecated = cc->model ? cc->model->deprecated : false;
     /*
      * Old machine types won't report aliases, so that alias translation
      * doesn't break compatibility with previous QEMU versions.
@@ -5411,6 +5417,7 @@ static void x86_register_cpudef_types(X86CPUDefinition *def)
         m->cpudef = def;
         m->version = vdef->version;
         m->note = vdef->note;
+        m->deprecated = vdef->deprecated;
         x86_register_cpu_model_type(name, m);
 
         if (vdef->alias) {
@@ -5418,6 +5425,8 @@ static void x86_register_cpudef_types(X86CPUDefinition *def)
             am->cpudef = def;
             am->version = vdef->version;
             am->is_alias = true;
+            am->note = vdef->note;
+            am->deprecated = vdef->deprecated;
             x86_register_cpu_model_type(vdef->alias, am);
         }
     }
@@ -7229,6 +7238,37 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
+static void x86_cpu_deprecation_check(ObjectClass *oc)
+{
+    X86CPUClass *xcc = X86_CPU_CLASS(oc);
+    X86CPUVersion effective_version;
+    const X86CPUVersionDefinition *vdef;
+
+    if (xcc->model == NULL) {
+        return;
+    }
+
+    if (xcc->model->version == CPU_VERSION_LEGACY) {
+        /* Treat legacy version as v1 */
+        effective_version = 1;
+    } else {
+        effective_version = x86_cpu_model_resolve_version(xcc->model);
+    }
+
+    vdef = xcc->model->cpudef->versions;
+
+    if (vdef == NULL) {
+        return;
+    } else {
+        if (vdef[effective_version - 1].deprecated) {
+            warn_report("Effective CPU model '%s' -- %s",
+                    x86_cpu_versioned_model_name(xcc->model->cpudef,\
+                                                effective_version),
+                    vdef[effective_version - 1].note);
+        }
+    }
+}
+
 static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 {
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
@@ -7287,6 +7327,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->tlb_fill = x86_cpu_tlb_fill;
 #endif
     cc->disas_set_info = x86_disas_set_info;
+    cc->deprecation_check = x86_cpu_deprecation_check;
 
     dc->user_creatable = true;
 }
-- 
1.8.3.1



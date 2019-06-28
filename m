Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ABCC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 00:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44EA82086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 00:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EA82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgevl-0001nQ-G2
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 20:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36303)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hgelH-0000QM-Fg
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hgelF-0006tW-CY
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:29:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hgelF-0006sy-4R
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:29:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A2D93082E71
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 00:29:04 +0000 (UTC)
Received: from localhost (ovpn-116-7.gru2.redhat.com [10.97.116.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6AE0608C1;
 Fri, 28 Jun 2019 00:29:03 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 21:28:42 -0300
Message-Id: <20190628002844.24894-8-ehabkost@redhat.com>
In-Reply-To: <20190628002844.24894-1-ehabkost@redhat.com>
References: <20190628002844.24894-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 28 Jun 2019 00:29:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 7/9] i386: Make unversioned CPU models be
 aliases
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
Cc: Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make unversioned CPU models behavior depend on the
machine type:

* "pc-*-4.0" and older will not report them as aliases.
  This is done to keep compatibility with older QEMU versions
  after management software starts translating aliases.

* "pc-*-4.1" will translate unversioned CPU models to -v1.
  This is done to keep compatibility with existing management
  software, that still relies on CPU model runnability promises.

* "none" will translate unversioned CPU models to their latest
  version.  This is planned become the default in future machine
  types (probably in pc-*-4.3).

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Patch v1 was "[PATCH 4/6] i386: Infrastructure for versioned CPU
models", and was split into multiple patches.

Changes v1 -> v2:
* Make version numbers simple integers, completely independent
  from machine type versions
* New X86CPUVersion typedef
* New CPU_VERSION_* defines to make X86CPUModel::version
  semantics clearer
---
 include/hw/i386/pc.h                       |   3 +
 target/i386/cpu.h                          |  12 ++
 hw/i386/pc.c                               |   3 +
 hw/i386/pc_piix.c                          |   4 +
 hw/i386/pc_q35.c                           |   4 +
 target/i386/cpu.c                          |  52 ++++++++-
 tests/acceptance/x86_cpu_model_versions.py | 126 +++++++++++++++++++++
 7 files changed, 203 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ee79d71ccc..1946c1023f 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -109,6 +109,9 @@ typedef struct PCMachineClass {
 
     /* Compat options: */
 
+    /* Default CPU model version.  See x86_cpu_set_default_version(). */
+    int default_cpu_version;
+
     /* ACPI compat: */
     bool has_acpi_build;
     bool rsdp_in_ram;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 12bc3cd4a8..05393cf9d1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1934,11 +1934,23 @@ void x86_cpu_change_kvm_default(const char *prop, const char *value);
 /* Resolve to latest CPU version */
 #define CPU_VERSION_LATEST -1
 
+/*
+ * Resolve to version defined by current machine type.
+ * See x86_cpu_set_default_version()
+ */
+#define CPU_VERSION_AUTO   -2
+
 /* Don't resolve to any versioned CPU models, like old QEMU versions */
 #define CPU_VERSION_LEGACY  0
 
 typedef int X86CPUVersion;
 
+/*
+ * Set default CPU model version for CPU models having
+ * version == CPU_VERSION_AUTO.
+ */
+void x86_cpu_set_default_version(X86CPUVersion version);
+
 /* Return name of 32-bit register, from a R_* constant */
 const char *get_register_name_32(unsigned int reg);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3f0f221a5b..1df569620a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1649,6 +1649,9 @@ void pc_cpus_init(PCMachineState *pcms)
     const CPUArchIdList *possible_cpus;
     MachineState *ms = MACHINE(pcms);
     MachineClass *mc = MACHINE_GET_CLASS(pcms);
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(mc);
+
+    x86_cpu_set_default_version(pcmc->default_cpu_version);
 
     /* Calculates the limit to CPU APIC ID values
      *
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c07c4a5b38..0a069bff54 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -430,9 +430,11 @@ static void pc_i440fx_machine_options(MachineClass *m)
 
 static void pc_i440fx_4_1_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
+    pcmc->default_cpu_version = 1;
 }
 
 DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1", NULL,
@@ -440,9 +442,11 @@ DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1", NULL,
 
 static void pc_i440fx_4_0_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_i440fx_4_1_machine_options(m);
     m->alias = NULL;
     m->is_default = 0;
+    pcmc->default_cpu_version = CPU_VERSION_LEGACY;
     compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
     compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 57232aed6b..397e1fdd2f 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -367,8 +367,10 @@ static void pc_q35_machine_options(MachineClass *m)
 
 static void pc_q35_4_1_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_machine_options(m);
     m->alias = "q35";
+    pcmc->default_cpu_version = 1;
 }
 
 DEFINE_Q35_MACHINE(v4_1, "pc-q35-4.1", NULL,
@@ -376,8 +378,10 @@ DEFINE_Q35_MACHINE(v4_1, "pc-q35-4.1", NULL,
 
 static void pc_q35_4_0_1_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_4_1_machine_options(m);
     m->alias = NULL;
+    pcmc->default_cpu_version = CPU_VERSION_LEGACY;
     /*
      * This is the default machine for the 4.0-stable branch. It is basically
      * a 4.0 that doesn't use split irqchip by default. It MUST hence apply the
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cddea91b1f..10a09c971a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1470,6 +1470,11 @@ struct X86CPUModel {
     X86CPUDefinition *cpudef;
     /* CPU model version */
     X86CPUVersion version;
+    /*
+     * If true, this is an alias CPU model.
+     * This matters only for "-cpu help" and query-cpu-definitions
+     */
+    bool is_alias;
 };
 
 /* Get full model name for CPU version */
@@ -2764,6 +2769,15 @@ static PropValue tcg_default_props[] = {
 };
 
 
+X86CPUVersion default_cpu_version = CPU_VERSION_LATEST;
+
+void x86_cpu_set_default_version(X86CPUVersion version)
+{
+    /* Translating CPU_VERSION_AUTO to CPU_VERSION_AUTO doesn't make sense */
+    assert(version != CPU_VERSION_AUTO);
+    default_cpu_version = version;
+}
+
 static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *model)
 {
     int v = 0;
@@ -2780,6 +2794,9 @@ static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *model)
 static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
 {
     X86CPUVersion v = model->version;
+    if (v == CPU_VERSION_AUTO) {
+        v = default_cpu_version;
+    }
     if (v == CPU_VERSION_LATEST) {
         return x86_cpu_model_last_version(model);
     }
@@ -3518,13 +3535,35 @@ static char *x86_cpu_class_get_model_id(X86CPUClass *xc)
     return r;
 }
 
+static char *x86_cpu_class_get_alias_of(X86CPUClass *cc)
+{
+    X86CPUVersion version;
+
+    if (!cc->model || !cc->model->is_alias) {
+        return NULL;
+    }
+    version = x86_cpu_model_resolve_version(cc->model);
+    if (version <= 0) {
+        return NULL;
+    }
+    return x86_cpu_versioned_model_name(cc->model->cpudef, version);
+}
+
 static void x86_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
     X86CPUClass *cc = X86_CPU_CLASS(oc);
     char *name = x86_cpu_class_get_model_name(cc);
     char *desc = g_strdup(cc->model_description);
+    char *alias_of = x86_cpu_class_get_alias_of(cc);
 
+    if (!desc && alias_of) {
+        if (cc->model && cc->model->version == CPU_VERSION_AUTO) {
+            desc = g_strdup("(alias configured by machine type)");
+        } else {
+            desc = g_strdup_printf("(alias of %s)", alias_of);
+        }
+    }
     if (!desc) {
         desc = x86_cpu_class_get_model_id(cc);
     }
@@ -3532,6 +3571,7 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
     qemu_printf("x86 %-20s  %-48s\n", name, desc);
     g_free(name);
     g_free(desc);
+    g_free(alias_of);
 }
 
 /* list available CPU models and flags */
@@ -3580,6 +3620,14 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
     info->migration_safe = cc->migration_safe;
     info->has_migration_safe = true;
     info->q_static = cc->static_model;
+    /*
+     * Old machine types won't report aliases, so that alias translation
+     * doesn't break compatibility with previous QEMU versions.
+     */
+    if (default_cpu_version != CPU_VERSION_LEGACY) {
+        info->alias_of = x86_cpu_class_get_alias_of(cc);
+        info->has_alias_of = !!info->alias_of;
+    }
 
     entry = g_malloc0(sizeof(*entry));
     entry->value = info;
@@ -3999,7 +4047,8 @@ static void x86_register_cpudef_types(X86CPUDefinition *def)
     /* Unversioned model: */
     m = g_new0(X86CPUModel, 1);
     m->cpudef = def;
-    m->version = CPU_VERSION_LEGACY;
+    m->version = CPU_VERSION_AUTO;
+    m->is_alias = true;
     x86_register_cpu_model_type(def->name, m);
 
     /* Versioned models: */
@@ -4016,6 +4065,7 @@ static void x86_register_cpudef_types(X86CPUDefinition *def)
             X86CPUModel *am = g_new0(X86CPUModel, 1);
             am->cpudef = def;
             am->version = vdef->version;
+            am->is_alias = true;
             x86_register_cpu_model_type(vdef->alias, am);
         }
     }
diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptance/x86_cpu_model_versions.py
index b85d6f8604..165c0c7601 100644
--- a/tests/acceptance/x86_cpu_model_versions.py
+++ b/tests/acceptance/x86_cpu_model_versions.py
@@ -103,3 +103,129 @@ class X86CPUModelAliases(avocado_qemu.Test):
         # On pc-*-4.0, no CPU model should be reported as an alias:
         for name,c in cpus.items():
             self.assertNotIn('alias-of', c, "%s shouldn't be an alias" % (name))
+
+    def test_4_1_alias(self):
+        """Check if unversioned CPU model is an alias pointing to right version"""
+        self.vm.add_args('-S')
+        self.vm.set_machine('pc-i440fx-4.1')
+        self.vm.launch()
+
+        cpus = dict((m['name'], m) for m in self.vm.command('query-cpu-definitions'))
+
+        self.assertFalse(cpus['Cascadelake-Server']['static'],
+                         'unversioned Cascadelake-Server CPU model must not be static')
+        self.assertEquals(cpus['Cascadelake-Server'].get('alias-of'), 'Cascadelake-Server-v1',
+                          'Cascadelake-Server must be an alias of Cascadelake-Server-v1')
+        self.assertNotIn('alias-of', cpus['Cascadelake-Server-v1'],
+                         'Cascadelake-Server-v1 must not be an alias')
+
+        self.assertFalse(cpus['qemu64']['static'],
+                         'unversioned qemu64 CPU model must not be static')
+        self.assertEquals(cpus['qemu64'].get('alias-of'), 'qemu64-v1',
+                          'qemu64 must be an alias of qemu64-v1')
+        self.assertNotIn('alias-of', cpus['qemu64-v1'],
+                         'qemu64-v1 must not be an alias')
+
+        self.validate_variant_aliases(cpus)
+
+        # On pc-*-4.1, -noTSX and -IBRS models should be aliases:
+        self.assertEquals(cpus["Haswell"].get('alias-of'),
+                          "Haswell-v1",
+                         "Haswell must be an alias")
+        self.assertEquals(cpus["Haswell-noTSX"].get('alias-of'),
+                          "Haswell-v2",
+                         "Haswell-noTSX must be an alias")
+        self.assertEquals(cpus["Haswell-IBRS"].get('alias-of'),
+                          "Haswell-v3",
+                         "Haswell-IBRS must be an alias")
+        self.assertEquals(cpus["Haswell-noTSX-IBRS"].get('alias-of'),
+                          "Haswell-v4",
+                         "Haswell-noTSX-IBRS must be an alias")
+
+        self.assertEquals(cpus["Broadwell"].get('alias-of'),
+                          "Broadwell-v1",
+                         "Broadwell must be an alias")
+        self.assertEquals(cpus["Broadwell-noTSX"].get('alias-of'),
+                          "Broadwell-v2",
+                         "Broadwell-noTSX must be an alias")
+        self.assertEquals(cpus["Broadwell-IBRS"].get('alias-of'),
+                          "Broadwell-v3",
+                         "Broadwell-IBRS must be an alias")
+        self.assertEquals(cpus["Broadwell-noTSX-IBRS"].get('alias-of'),
+                          "Broadwell-v4",
+                         "Broadwell-noTSX-IBRS must be an alias")
+
+        self.assertEquals(cpus["Nehalem"].get('alias-of'),
+                          "Nehalem-v1",
+                         "Nehalem must be an alias")
+        self.assertEquals(cpus["Nehalem-IBRS"].get('alias-of'),
+                          "Nehalem-v2",
+                         "Nehalem-IBRS must be an alias")
+
+        self.assertEquals(cpus["Westmere"].get('alias-of'),
+                          "Westmere-v1",
+                         "Westmere must be an alias")
+        self.assertEquals(cpus["Westmere-IBRS"].get('alias-of'),
+                          "Westmere-v2",
+                         "Westmere-IBRS must be an alias")
+
+        self.assertEquals(cpus["SandyBridge"].get('alias-of'),
+                          "SandyBridge-v1",
+                         "SandyBridge must be an alias")
+        self.assertEquals(cpus["SandyBridge-IBRS"].get('alias-of'),
+                          "SandyBridge-v2",
+                         "SandyBridge-IBRS must be an alias")
+
+        self.assertEquals(cpus["IvyBridge"].get('alias-of'),
+                          "IvyBridge-v1",
+                         "IvyBridge must be an alias")
+        self.assertEquals(cpus["IvyBridge-IBRS"].get('alias-of'),
+                          "IvyBridge-v2",
+                         "IvyBridge-IBRS must be an alias")
+
+        self.assertEquals(cpus["Skylake-Client"].get('alias-of'),
+                          "Skylake-Client-v1",
+                         "Skylake-Client must be an alias")
+        self.assertEquals(cpus["Skylake-Client-IBRS"].get('alias-of'),
+                          "Skylake-Client-v2",
+                         "Skylake-Client-IBRS must be an alias")
+
+        self.assertEquals(cpus["Skylake-Server"].get('alias-of'),
+                          "Skylake-Server-v1",
+                         "Skylake-Server must be an alias")
+        self.assertEquals(cpus["Skylake-Server-IBRS"].get('alias-of'),
+                          "Skylake-Server-v2",
+                         "Skylake-Server-IBRS must be an alias")
+
+        self.assertEquals(cpus["EPYC"].get('alias-of'),
+                          "EPYC-v1",
+                         "EPYC must be an alias")
+        self.assertEquals(cpus["EPYC-IBPB"].get('alias-of'),
+                          "EPYC-v2",
+                         "EPYC-IBPB must be an alias")
+
+        self.validate_aliases(cpus)
+
+    def test_none_alias(self):
+        """Check if unversioned CPU model is an alias pointing to some version"""
+        self.vm.add_args('-S')
+        self.vm.set_machine('none')
+        self.vm.launch()
+
+        cpus = dict((m['name'], m) for m in self.vm.command('query-cpu-definitions'))
+
+        self.assertFalse(cpus['Cascadelake-Server']['static'],
+                         'unversioned Cascadelake-Server CPU model must not be static')
+        self.assertTrue(re.match('Cascadelake-Server-v[0-9]+', cpus['Cascadelake-Server']['alias-of']),
+                        'Cascadelake-Server must be an alias of versioned CPU model')
+        self.assertNotIn('alias-of', cpus['Cascadelake-Server-v1'],
+                         'Cascadelake-Server-v1 must not be an alias')
+
+        self.assertFalse(cpus['qemu64']['static'],
+                         'unversioned qemu64 CPU model must not be static')
+        self.assertTrue(re.match('qemu64-v[0-9]+', cpus['qemu64']['alias-of']),
+                        'qemu64 must be an alias of versioned CPU model')
+        self.assertNotIn('alias-of', cpus['qemu64-v1'],
+                         'qemu64-v1 must not be an alias')
+
+        self.validate_aliases(cpus)
-- 
2.18.0.rc1.1.g3f1ff2140



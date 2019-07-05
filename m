Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2C9C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7397F2147A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7397F2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjX1G-0008Mp-OX
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 18:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55420)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hjWVy-0008NW-CU
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hjWVt-000439-Al
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:17:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hjWVp-0003uX-0r
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:17:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 359C630593D8;
 Fri,  5 Jul 2019 22:16:36 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 881104C7;
 Fri,  5 Jul 2019 22:16:35 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Fri,  5 Jul 2019 19:14:59 -0300
Message-Id: <20190705221504.25166-38-ehabkost@redhat.com>
In-Reply-To: <20190705221504.25166-1-ehabkost@redhat.com>
References: <20190705221504.25166-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 05 Jul 2019 22:16:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v6 37/42] i386: Make unversioned CPU models be
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
Message-Id: <20190628002844.24894-8-ehabkost@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
index 0fa3e3beeb..859b64c51d 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -109,6 +109,9 @@ typedef struct PCMachineClass {
=20
     /* Compat options: */
=20
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
@@ -1934,11 +1934,23 @@ void x86_cpu_change_kvm_default(const char *prop,=
 const char *value);
 /* Resolve to latest CPU version */
 #define CPU_VERSION_LATEST -1
=20
+/*
+ * Resolve to version defined by current machine type.
+ * See x86_cpu_set_default_version()
+ */
+#define CPU_VERSION_AUTO   -2
+
 /* Don't resolve to any versioned CPU models, like old QEMU versions */
 #define CPU_VERSION_LEGACY  0
=20
 typedef int X86CPUVersion;
=20
+/*
+ * Set default CPU model version for CPU models having
+ * version =3D=3D CPU_VERSION_AUTO.
+ */
+void x86_cpu_set_default_version(X86CPUVersion version);
+
 /* Return name of 32-bit register, from a R_* constant */
 const char *get_register_name_32(unsigned int reg);
=20
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b9c55301a2..c33ce47578 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1645,6 +1645,9 @@ void pc_cpus_init(PCMachineState *pcms)
     const CPUArchIdList *possible_cpus;
     MachineState *ms =3D MACHINE(pcms);
     MachineClass *mc =3D MACHINE_GET_CLASS(pcms);
+    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(mc);
+
+    x86_cpu_set_default_version(pcmc->default_cpu_version);
=20
     /* Calculates the limit to CPU APIC ID values
      *
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f29de58636..581b3c2baa 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -429,9 +429,11 @@ static void pc_i440fx_machine_options(MachineClass *=
m)
=20
 static void pc_i440fx_4_1_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_i440fx_machine_options(m);
     m->alias =3D "pc";
     m->is_default =3D 1;
+    pcmc->default_cpu_version =3D 1;
 }
=20
 DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1", NULL,
@@ -439,9 +441,11 @@ DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1", NULL,
=20
 static void pc_i440fx_4_0_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_i440fx_4_1_machine_options(m);
     m->alias =3D NULL;
     m->is_default =3D 0;
+    pcmc->default_cpu_version =3D CPU_VERSION_LEGACY;
     compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
     compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 57232aed6b..397e1fdd2f 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -367,8 +367,10 @@ static void pc_q35_machine_options(MachineClass *m)
=20
 static void pc_q35_4_1_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_q35_machine_options(m);
     m->alias =3D "q35";
+    pcmc->default_cpu_version =3D 1;
 }
=20
 DEFINE_Q35_MACHINE(v4_1, "pc-q35-4.1", NULL,
@@ -376,8 +378,10 @@ DEFINE_Q35_MACHINE(v4_1, "pc-q35-4.1", NULL,
=20
 static void pc_q35_4_0_1_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_q35_4_1_machine_options(m);
     m->alias =3D NULL;
+    pcmc->default_cpu_version =3D CPU_VERSION_LEGACY;
     /*
      * This is the default machine for the 4.0-stable branch. It is basi=
cally
      * a 4.0 that doesn't use split irqchip by default. It MUST hence ap=
ply the
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f41917649d..0cf8e545c6 100644
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
=20
 /* Get full model name for CPU version */
@@ -2835,6 +2840,15 @@ static PropValue tcg_default_props[] =3D {
 };
=20
=20
+X86CPUVersion default_cpu_version =3D CPU_VERSION_LATEST;
+
+void x86_cpu_set_default_version(X86CPUVersion version)
+{
+    /* Translating CPU_VERSION_AUTO to CPU_VERSION_AUTO doesn't make sen=
se */
+    assert(version !=3D CPU_VERSION_AUTO);
+    default_cpu_version =3D version;
+}
+
 static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *model=
)
 {
     int v =3D 0;
@@ -2851,6 +2865,9 @@ static X86CPUVersion x86_cpu_model_last_version(con=
st X86CPUModel *model)
 static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *mo=
del)
 {
     X86CPUVersion v =3D model->version;
+    if (v =3D=3D CPU_VERSION_AUTO) {
+        v =3D default_cpu_version;
+    }
     if (v =3D=3D CPU_VERSION_LATEST) {
         return x86_cpu_model_last_version(model);
     }
@@ -3589,13 +3606,35 @@ static char *x86_cpu_class_get_model_id(X86CPUCla=
ss *xc)
     return r;
 }
=20
+static char *x86_cpu_class_get_alias_of(X86CPUClass *cc)
+{
+    X86CPUVersion version;
+
+    if (!cc->model || !cc->model->is_alias) {
+        return NULL;
+    }
+    version =3D x86_cpu_model_resolve_version(cc->model);
+    if (version <=3D 0) {
+        return NULL;
+    }
+    return x86_cpu_versioned_model_name(cc->model->cpudef, version);
+}
+
 static void x86_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc =3D data;
     X86CPUClass *cc =3D X86_CPU_CLASS(oc);
     char *name =3D x86_cpu_class_get_model_name(cc);
     char *desc =3D g_strdup(cc->model_description);
+    char *alias_of =3D x86_cpu_class_get_alias_of(cc);
=20
+    if (!desc && alias_of) {
+        if (cc->model && cc->model->version =3D=3D CPU_VERSION_AUTO) {
+            desc =3D g_strdup("(alias configured by machine type)");
+        } else {
+            desc =3D g_strdup_printf("(alias of %s)", alias_of);
+        }
+    }
     if (!desc) {
         desc =3D x86_cpu_class_get_model_id(cc);
     }
@@ -3603,6 +3642,7 @@ static void x86_cpu_list_entry(gpointer data, gpoin=
ter user_data)
     qemu_printf("x86 %-20s  %-48s\n", name, desc);
     g_free(name);
     g_free(desc);
+    g_free(alias_of);
 }
=20
 /* list available CPU models and flags */
@@ -3651,6 +3691,14 @@ static void x86_cpu_definition_entry(gpointer data=
, gpointer user_data)
     info->migration_safe =3D cc->migration_safe;
     info->has_migration_safe =3D true;
     info->q_static =3D cc->static_model;
+    /*
+     * Old machine types won't report aliases, so that alias translation
+     * doesn't break compatibility with previous QEMU versions.
+     */
+    if (default_cpu_version !=3D CPU_VERSION_LEGACY) {
+        info->alias_of =3D x86_cpu_class_get_alias_of(cc);
+        info->has_alias_of =3D !!info->alias_of;
+    }
=20
     entry =3D g_malloc0(sizeof(*entry));
     entry->value =3D info;
@@ -4070,7 +4118,8 @@ static void x86_register_cpudef_types(X86CPUDefinit=
ion *def)
     /* Unversioned model: */
     m =3D g_new0(X86CPUModel, 1);
     m->cpudef =3D def;
-    m->version =3D CPU_VERSION_LEGACY;
+    m->version =3D CPU_VERSION_AUTO;
+    m->is_alias =3D true;
     x86_register_cpu_model_type(def->name, m);
=20
     /* Versioned models: */
@@ -4087,6 +4136,7 @@ static void x86_register_cpudef_types(X86CPUDefinit=
ion *def)
             X86CPUModel *am =3D g_new0(X86CPUModel, 1);
             am->cpudef =3D def;
             am->version =3D vdef->version;
+            am->is_alias =3D true;
             x86_register_cpu_model_type(vdef->alias, am);
         }
     }
diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptanc=
e/x86_cpu_model_versions.py
index b85d6f8604..165c0c7601 100644
--- a/tests/acceptance/x86_cpu_model_versions.py
+++ b/tests/acceptance/x86_cpu_model_versions.py
@@ -103,3 +103,129 @@ class X86CPUModelAliases(avocado_qemu.Test):
         # On pc-*-4.0, no CPU model should be reported as an alias:
         for name,c in cpus.items():
             self.assertNotIn('alias-of', c, "%s shouldn't be an alias" %=
 (name))
+
+    def test_4_1_alias(self):
+        """Check if unversioned CPU model is an alias pointing to right =
version"""
+        self.vm.add_args('-S')
+        self.vm.set_machine('pc-i440fx-4.1')
+        self.vm.launch()
+
+        cpus =3D dict((m['name'], m) for m in self.vm.command('query-cpu=
-definitions'))
+
+        self.assertFalse(cpus['Cascadelake-Server']['static'],
+                         'unversioned Cascadelake-Server CPU model must =
not be static')
+        self.assertEquals(cpus['Cascadelake-Server'].get('alias-of'), 'C=
ascadelake-Server-v1',
+                          'Cascadelake-Server must be an alias of Cascad=
elake-Server-v1')
+        self.assertNotIn('alias-of', cpus['Cascadelake-Server-v1'],
+                         'Cascadelake-Server-v1 must not be an alias')
+
+        self.assertFalse(cpus['qemu64']['static'],
+                         'unversioned qemu64 CPU model must not be stati=
c')
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
+        """Check if unversioned CPU model is an alias pointing to some v=
ersion"""
+        self.vm.add_args('-S')
+        self.vm.set_machine('none')
+        self.vm.launch()
+
+        cpus =3D dict((m['name'], m) for m in self.vm.command('query-cpu=
-definitions'))
+
+        self.assertFalse(cpus['Cascadelake-Server']['static'],
+                         'unversioned Cascadelake-Server CPU model must =
not be static')
+        self.assertTrue(re.match('Cascadelake-Server-v[0-9]+', cpus['Cas=
cadelake-Server']['alias-of']),
+                        'Cascadelake-Server must be an alias of versione=
d CPU model')
+        self.assertNotIn('alias-of', cpus['Cascadelake-Server-v1'],
+                         'Cascadelake-Server-v1 must not be an alias')
+
+        self.assertFalse(cpus['qemu64']['static'],
+                         'unversioned qemu64 CPU model must not be stati=
c')
+        self.assertTrue(re.match('qemu64-v[0-9]+', cpus['qemu64']['alias=
-of']),
+                        'qemu64 must be an alias of versioned CPU model'=
)
+        self.assertNotIn('alias-of', cpus['qemu64-v1'],
+                         'qemu64-v1 must not be an alias')
+
+        self.validate_aliases(cpus)
--=20
2.18.0.rc1.1.g3f1ff2140



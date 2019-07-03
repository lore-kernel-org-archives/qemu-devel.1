Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE68C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 21:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322B6218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 21:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322B6218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hinBs-0001vR-2o
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 17:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38545)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1himW7-0006dY-A7
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1himW4-0007Ui-2l
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:10:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36690)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1himVx-0007I1-Ff
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:10:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7E9753680B;
 Wed,  3 Jul 2019 21:09:52 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4A2C5D704;
 Wed,  3 Jul 2019 21:09:51 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Wed,  3 Jul 2019 18:08:13 -0300
Message-Id: <20190703210821.27550-36-ehabkost@redhat.com>
In-Reply-To: <20190703210821.27550-1-ehabkost@redhat.com>
References: <20190703210821.27550-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 03 Jul 2019 21:09:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v5 35/43] i386: Register versioned CPU models
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

Add support for registration of multiple versions of CPU models.

The existing CPU models will be registered with a "-v1" suffix.

The -noTSX, -IBRS, and -IBPB CPU model variants will become
versions of the original models in a separate patch, so
make sure we register no versions for them.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190628002844.24894-5-ehabkost@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu-qom.h                      |  10 +-
 target/i386/cpu.h                          |  10 +
 target/i386/cpu.c                          | 223 +++++++++++++++++++--
 tests/acceptance/x86_cpu_model_versions.py | 105 ++++++++++
 4 files changed, 318 insertions(+), 30 deletions(-)
 create mode 100644 tests/acceptance/x86_cpu_model_versions.py

diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
index 22f95eb3a4..1a52f02a4c 100644
--- a/target/i386/cpu-qom.h
+++ b/target/i386/cpu-qom.h
@@ -36,13 +36,7 @@
 #define X86_CPU_GET_CLASS(obj) \
     OBJECT_GET_CLASS(X86CPUClass, (obj), TYPE_X86_CPU)
=20
-/**
- * X86CPUDefinition:
- *
- * CPU model definition data that was not converted to QOM per-subclass
- * property defaults yet.
- */
-typedef struct X86CPUDefinition X86CPUDefinition;
+typedef struct X86CPUModel X86CPUModel;
=20
 /**
  * X86CPUClass:
@@ -64,7 +58,7 @@ typedef struct X86CPUClass {
     /* CPU definition, automatically loaded by instance_init if not NULL=
.
      * Should be eventually replaced by subclass-specific property defau=
lts.
      */
-    X86CPUDefinition *cpu_def;
+    X86CPUModel *model;
=20
     bool host_cpuid_required;
     int ordering;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4727226a6a..12bc3cd4a8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1929,6 +1929,16 @@ void apic_handle_tpr_access_report(DeviceState *d,=
 target_ulong ip,
  */
 void x86_cpu_change_kvm_default(const char *prop, const char *value);
=20
+/* Special values for X86CPUVersion: */
+
+/* Resolve to latest CPU version */
+#define CPU_VERSION_LATEST -1
+
+/* Don't resolve to any versioned CPU models, like old QEMU versions */
+#define CPU_VERSION_LEGACY  0
+
+typedef int X86CPUVersion;
+
 /* Return name of 32-bit register, from a R_* constant */
 const char *get_register_name_32(unsigned int reg);
=20
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a0e422adf3..87555a1c5a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1433,7 +1433,17 @@ static char *x86_cpu_class_get_model_name(X86CPUCl=
ass *cc)
                      strlen(class_name) - strlen(X86_CPU_TYPE_SUFFIX));
 }
=20
-struct X86CPUDefinition {
+typedef struct PropValue {
+    const char *prop, *value;
+} PropValue;
+
+typedef struct X86CPUVersionDefinition {
+    X86CPUVersion version;
+    PropValue *props;
+} X86CPUVersionDefinition;
+
+/* Base definition for a CPU model */
+typedef struct X86CPUDefinition {
     const char *name;
     uint32_t level;
     uint32_t xlevel;
@@ -1445,8 +1455,41 @@ struct X86CPUDefinition {
     FeatureWordArray features;
     const char *model_id;
     CPUCaches *cache_info;
+    /*
+     * Definitions for alternative versions of CPU model.
+     * List is terminated by item with version =3D=3D 0.
+     * If NULL, version 1 will be registered automatically.
+     */
+    const X86CPUVersionDefinition *versions;
+} X86CPUDefinition;
+
+/* Reference to a specific CPU model version */
+struct X86CPUModel {
+    /* Base CPU definition */
+    X86CPUDefinition *cpudef;
+    /* CPU model version */
+    X86CPUVersion version;
 };
=20
+/* Get full model name for CPU version */
+static char *x86_cpu_versioned_model_name(X86CPUDefinition *cpudef,
+                                          X86CPUVersion version)
+{
+    assert(version > 0);
+    return g_strdup_printf("%s-v%d", cpudef->name, (int)version);
+}
+
+static const X86CPUVersionDefinition *x86_cpu_def_get_versions(X86CPUDef=
inition *def)
+{
+    /* When X86CPUDefinition::versions is NULL, we register only v1 */
+    static const X86CPUVersionDefinition default_version_list[] =3D {
+        { 1 },
+        { /* end of list */ }
+    };
+
+    return def->versions ?: default_version_list;
+}
+
 static CPUCaches epyc_cache_info =3D {
     .l1d_cache =3D &(CPUCacheInfo) {
         .type =3D DATA_CACHE,
@@ -1833,6 +1876,11 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_EXT3_LAHF_LM,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Core i7 9xx (Nehalem Core i7, IBRS update)"=
,
+        /*
+         * This CPU model will eventually be replaced by an alias,
+         * don't register any versions for it.
+         */
+        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
     },
     {
         .name =3D "Westmere",
@@ -1887,6 +1935,11 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Westmere E56xx/L56xx/X56xx (IBRS update)",
+        /*
+         * This CPU model will eventually be replaced by an alias,
+         * don't register any versions for it.
+         */
+        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
     },
     {
         .name =3D "SandyBridge",
@@ -1951,6 +2004,11 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Xeon E312xx (Sandy Bridge, IBRS update)",
+        /*
+         * This CPU model will eventually be replaced by an alias,
+         * don't register any versions for it.
+         */
+        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
     },
     {
         .name =3D "IvyBridge",
@@ -2021,6 +2079,11 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Xeon E3-12xx v2 (Ivy Bridge, IBRS)",
+        /*
+         * This CPU model will eventually be replaced by an alias,
+         * don't register any versions for it.
+         */
+        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
     },
     {
         .name =3D "Haswell-noTSX",
@@ -2057,6 +2120,11 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Core Processor (Haswell, no TSX)",
+        /*
+         * This CPU model will eventually be replaced by an alias,
+         * don't register any versions for it.
+         */
+        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
     },
     {
         .name =3D "Haswell-noTSX-IBRS",
@@ -2095,6 +2163,11 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Core Processor (Haswell, no TSX, IBRS)",
+        /*
+         * This CPU model will eventually be replaced by an alias,
+         * don't register any versions for it.
+         */
+        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
     },
     {
         .name =3D "Haswell",
@@ -2171,6 +2244,11 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Core Processor (Haswell, IBRS)",
+        /*
+         * This CPU model will eventually be replaced by an alias,
+         * don't register any versions for it.
+         */
+        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
     },
     {
         .name =3D "Broadwell-noTSX",
@@ -2209,6 +2287,11 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Core Processor (Broadwell, no TSX)",
+        /*
+         * This CPU model will eventually be replaced by an alias,
+         * don't register any versions for it.
+         */
+        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
     },
     {
         .name =3D "Broadwell-noTSX-IBRS",
@@ -2249,6 +2332,11 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Core Processor (Broadwell, no TSX, IBRS)",
+        /*
+         * This CPU model will eventually be replaced by an alias,
+         * don't register any versions for it.
+         */
+        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
     },
     {
         .name =3D "Broadwell",
@@ -2327,6 +2415,11 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Core Processor (Broadwell, IBRS)",
+        /*
+         * This CPU model will eventually be replaced by an alias,
+         * don't register any versions for it.
+         */
+        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
     },
     {
         .name =3D "Skylake-Client",
@@ -2419,6 +2512,11 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Core Processor (Skylake, IBRS)",
+        /*
+         * This CPU model will eventually be replaced by an alias,
+         * don't register any versions for it.
+         */
+        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
     },
     {
         .name =3D "Skylake-Server",
@@ -2521,6 +2619,11 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Xeon Processor (Skylake, IBRS)",
+        /*
+         * This CPU model will eventually be replaced by an alias,
+         * don't register any versions for it.
+         */
+        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
     },
     {
         .name =3D "Cascadelake-Server",
@@ -3029,6 +3132,11 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
         .xlevel =3D 0x8000001E,
         .model_id =3D "AMD EPYC Processor (with IBPB)",
         .cache_info =3D &epyc_cache_info,
+        /*
+         * This CPU model will eventually be replaced by an alias,
+         * don't register any versions for it.
+         */
+        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
     },
     {
         .name =3D "Dhyana",
@@ -3082,10 +3190,6 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
     },
 };
=20
-typedef struct PropValue {
-    const char *prop, *value;
-} PropValue;
-
 /* KVM-specific features that are automatically added/removed
  * from all CPU models when KVM is enabled.
  */
@@ -3111,6 +3215,28 @@ static PropValue tcg_default_props[] =3D {
 };
=20
=20
+static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *model=
)
+{
+    int v =3D 0;
+    const X86CPUVersionDefinition *vdef =3D
+        x86_cpu_def_get_versions(model->cpudef);
+    while (vdef->version) {
+        v =3D vdef->version;
+        vdef++;
+    }
+    return v;
+}
+
+/* Return the actual version being used for a specific CPU model */
+static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *mo=
del)
+{
+    X86CPUVersion v =3D model->version;
+    if (v =3D=3D CPU_VERSION_LATEST) {
+        return x86_cpu_model_last_version(model);
+    }
+    return v;
+}
+
 void x86_cpu_change_kvm_default(const char *prop, const char *value)
 {
     PropValue *pv;
@@ -3188,8 +3314,6 @@ static void max_x86_cpu_class_init(ObjectClass *oc,=
 void *data)
     dc->props =3D max_x86_cpu_properties;
 }
=20
-static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error *=
*errp);
-
 static void max_x86_cpu_initfn(Object *obj)
 {
     X86CPU *cpu =3D X86_CPU(obj);
@@ -3980,10 +4104,40 @@ static void x86_cpu_apply_props(X86CPU *cpu, Prop=
Value *props)
     }
 }
=20
+/* Apply properties for the CPU model version specified in model */
+static void x86_cpu_apply_version_props(X86CPU *cpu, X86CPUModel *model)
+{
+    const X86CPUVersionDefinition *vdef;
+    X86CPUVersion version =3D x86_cpu_model_resolve_version(model);
+
+    if (version =3D=3D CPU_VERSION_LEGACY) {
+        return;
+    }
+
+    for (vdef =3D x86_cpu_def_get_versions(model->cpudef); vdef->version=
; vdef++) {
+        PropValue *p;
+
+        for (p =3D vdef->props; p && p->prop; p++) {
+            object_property_parse(OBJECT(cpu), p->value, p->prop,
+                                  &error_abort);
+        }
+
+        if (vdef->version =3D=3D version) {
+            break;
+        }
+    }
+
+    /*
+     * If we reached the end of the list, version number was invalid
+     */
+    assert(vdef->version =3D=3D version);
+}
+
 /* Load data from X86CPUDefinition into a X86CPU object
  */
-static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error *=
*errp)
+static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model, Error **=
errp)
 {
+    X86CPUDefinition *def =3D model->cpudef;
     CPUX86State *env =3D &cpu->env;
     const char *vendor;
     char host_vendor[CPUID_VENDOR_SZ + 1];
@@ -4040,11 +4194,12 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUD=
efinition *def, Error **errp)
=20
     object_property_set_str(OBJECT(cpu), vendor, "vendor", errp);
=20
+    x86_cpu_apply_version_props(cpu, model);
 }
=20
 #ifndef CONFIG_USER_ONLY
 /* Return a QDict containing keys for all properties that can be include=
d
- * in static expansion of CPU models. All properties set by x86_cpu_load=
_def()
+ * in static expansion of CPU models. All properties set by x86_cpu_load=
_model()
  * must be included in the dictionary.
  */
 static QDict *x86_cpu_static_props(void)
@@ -4258,23 +4413,33 @@ static gchar *x86_gdb_arch_name(CPUState *cs)
=20
 static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
 {
-    X86CPUDefinition *cpudef =3D data;
+    X86CPUModel *model =3D data;
     X86CPUClass *xcc =3D X86_CPU_CLASS(oc);
=20
-    xcc->cpu_def =3D cpudef;
+    xcc->model =3D model;
     xcc->migration_safe =3D true;
 }
=20
-static void x86_register_cpudef_type(X86CPUDefinition *def)
+static void x86_register_cpu_model_type(const char *name, X86CPUModel *m=
odel)
 {
-    char *typename =3D x86_cpu_type_name(def->name);
+    char *typename =3D x86_cpu_type_name(name);
     TypeInfo ti =3D {
         .name =3D typename,
         .parent =3D TYPE_X86_CPU,
         .class_init =3D x86_cpu_cpudef_class_init,
-        .class_data =3D def,
+        .class_data =3D model,
     };
=20
+    type_register(&ti);
+    g_free(typename);
+}
+
+static void x86_register_cpudef_types(X86CPUDefinition *def)
+{
+    X86CPUModel *m;
+    const X86CPUVersionDefinition *vdef;
+    char *name;
+
     /* AMD aliases are handled at runtime based on CPUID vendor, so
      * they shouldn't be set on the CPU model table.
      */
@@ -4282,9 +4447,23 @@ static void x86_register_cpudef_type(X86CPUDefinit=
ion *def)
     /* catch mistakes instead of silently truncating model_id when too l=
ong */
     assert(def->model_id && strlen(def->model_id) <=3D 48);
=20
+    /* Unversioned model: */
+    m =3D g_new0(X86CPUModel, 1);
+    m->cpudef =3D def;
+    m->version =3D CPU_VERSION_LEGACY;
+    x86_register_cpu_model_type(def->name, m);
+
+    /* Versioned models: */
+
+    for (vdef =3D x86_cpu_def_get_versions(def); vdef->version; vdef++) =
{
+        X86CPUModel *m =3D g_new0(X86CPUModel, 1);
+        m->cpudef =3D def;
+        m->version =3D vdef->version;
+        name =3D x86_cpu_versioned_model_name(def, vdef->version);
+        x86_register_cpu_model_type(name, m);
+        g_free(name);
+    }
=20
-    type_register(&ti);
-    g_free(typename);
 }
=20
 #if !defined(CONFIG_USER_ONLY)
@@ -5110,7 +5289,7 @@ static void x86_cpu_enable_xsave_components(X86CPU =
*cpu)
  * involved in setting up CPUID data are:
  *
  * 1) Loading CPU model definition (X86CPUDefinition). This is
- *    implemented by x86_cpu_load_def() and should be completely
+ *    implemented by x86_cpu_load_model() and should be completely
  *    transparent, as it is done automatically by instance_init.
  *    No code should need to look at X86CPUDefinition structs
  *    outside instance_init.
@@ -5432,7 +5611,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Err=
or **errp)
=20
     /* Cache information initialization */
     if (!cpu->legacy_cache) {
-        if (!xcc->cpu_def || !xcc->cpu_def->cache_info) {
+        if (!xcc->model || !xcc->model->cpudef->cache_info) {
             char *name =3D x86_cpu_class_get_model_name(xcc);
             error_setg(errp,
                        "CPU model '%s' doesn't support legacy-cache=3Dof=
f", name);
@@ -5440,7 +5619,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Err=
or **errp)
             return;
         }
         env->cache_info_cpuid2 =3D env->cache_info_cpuid4 =3D env->cache=
_info_amd =3D
-            *xcc->cpu_def->cache_info;
+            *xcc->model->cpudef->cache_info;
     } else {
         /* Build legacy cache information */
         env->cache_info_cpuid2.l1d_cache =3D &legacy_l1d_cache;
@@ -5799,8 +5978,8 @@ static void x86_cpu_initfn(Object *obj)
     object_property_add_alias(obj, "sse4_1", obj, "sse4.1", &error_abort=
);
     object_property_add_alias(obj, "sse4_2", obj, "sse4.2", &error_abort=
);
=20
-    if (xcc->cpu_def) {
-        x86_cpu_load_def(cpu, xcc->cpu_def, &error_abort);
+    if (xcc->model) {
+        x86_cpu_load_model(cpu, xcc->model, &error_abort);
     }
 }
=20
@@ -6139,7 +6318,7 @@ static void x86_cpu_register_types(void)
=20
     type_register_static(&x86_cpu_type_info);
     for (i =3D 0; i < ARRAY_SIZE(builtin_x86_defs); i++) {
-        x86_register_cpudef_type(&builtin_x86_defs[i]);
+        x86_register_cpudef_types(&builtin_x86_defs[i]);
     }
     type_register_static(&max_x86_cpu_type_info);
     type_register_static(&x86_base_cpu_type_info);
diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptanc=
e/x86_cpu_model_versions.py
new file mode 100644
index 0000000000..b85d6f8604
--- /dev/null
+++ b/tests/acceptance/x86_cpu_model_versions.py
@@ -0,0 +1,105 @@
+#!/usr/bin/env python
+#
+# Basic validation of x86 versioned CPU models and CPU model aliases
+#
+#  Copyright (c) 2019 Red Hat Inc
+#
+# Author:
+#  Eduardo Habkost <ehabkost@redhat.com>
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, see <http://www.gnu.org/licen=
ses/>.
+#
+
+
+import avocado_qemu
+import re
+
+class X86CPUModelAliases(avocado_qemu.Test):
+    """
+    Validation of PC CPU model versions and CPU model aliases
+
+    :avocado: tags=3Darch:x86_64
+    """
+    def validate_aliases(self, cpus):
+        for c in cpus.values():
+            if 'alias-of' in c:
+                # all aliases must point to a valid CPU model name:
+                self.assertIn(c['alias-of'], cpus,
+                              '%s.alias-of (%s) is not a valid CPU model=
 name' % (c['name'], c['alias-of']))
+                # aliases must not point to aliases
+                self.assertNotIn('alias-of', cpus[c['alias-of']],
+                                 '%s.alias-of (%s) points to another ali=
as' % (c['name'], c['alias-of']))
+
+                # aliases must not be static
+                self.assertFalse(c['static'])
+
+    def validate_variant_aliases(self, cpus):
+        # -noTSX, -IBRS and -IBPB variants of CPU models are special:
+        # they shouldn't have their own versions:
+        self.assertNotIn("Haswell-noTSX-v1", cpus,
+                         "Haswell-noTSX shouldn't be versioned")
+        self.assertNotIn("Broadwell-noTSX-v1", cpus,
+                         "Broadwell-noTSX shouldn't be versioned")
+        self.assertNotIn("Nehalem-IBRS-v1", cpus,
+                         "Nehalem-IBRS shouldn't be versioned")
+        self.assertNotIn("Westmere-IBRS-v1", cpus,
+                         "Westmere-IBRS shouldn't be versioned")
+        self.assertNotIn("SandyBridge-IBRS-v1", cpus,
+                         "SandyBridge-IBRS shouldn't be versioned")
+        self.assertNotIn("IvyBridge-IBRS-v1", cpus,
+                         "IvyBridge-IBRS shouldn't be versioned")
+        self.assertNotIn("Haswell-noTSX-IBRS-v1", cpus,
+                         "Haswell-noTSX-IBRS shouldn't be versioned")
+        self.assertNotIn("Haswell-IBRS-v1", cpus,
+                         "Haswell-IBRS shouldn't be versioned")
+        self.assertNotIn("Broadwell-noTSX-IBRS-v1", cpus,
+                         "Broadwell-noTSX-IBRS shouldn't be versioned")
+        self.assertNotIn("Broadwell-IBRS-v1", cpus,
+                         "Broadwell-IBRS shouldn't be versioned")
+        self.assertNotIn("Skylake-Client-IBRS-v1", cpus,
+                         "Skylake-Client-IBRS shouldn't be versioned")
+        self.assertNotIn("Skylake-Server-IBRS-v1", cpus,
+                         "Skylake-Server-IBRS shouldn't be versioned")
+        self.assertNotIn("EPYC-IBPB-v1", cpus,
+                         "EPYC-IBPB shouldn't be versioned")
+
+    def test_4_0_alias_compatibility(self):
+        """Check if pc-*-4.0 unversioned CPU model won't be reported as =
aliases"""
+        # pc-*-4.0 won't expose non-versioned CPU models as aliases
+        # We do this to help management software to keep compatibility
+        # with older QEMU versions that didn't have the versioned CPU mo=
del
+        self.vm.add_args('-S')
+        self.vm.set_machine('pc-i440fx-4.0')
+        self.vm.launch()
+        cpus =3D dict((m['name'], m) for m in self.vm.command('query-cpu=
-definitions'))
+
+        self.assertFalse(cpus['Cascadelake-Server']['static'],
+                         'unversioned Cascadelake-Server CPU model must =
not be static')
+        self.assertNotIn('alias-of', cpus['Cascadelake-Server'],
+                         'Cascadelake-Server must not be an alias')
+        self.assertNotIn('alias-of', cpus['Cascadelake-Server-v1'],
+                         'Cascadelake-Server-v1 must not be an alias')
+
+        self.assertFalse(cpus['qemu64']['static'],
+                         'unversioned qemu64 CPU model must not be stati=
c')
+        self.assertNotIn('alias-of', cpus['qemu64'],
+                         'qemu64 must not be an alias')
+        self.assertNotIn('alias-of', cpus['qemu64-v1'],
+                         'qemu64-v1 must not be an alias')
+
+        self.validate_variant_aliases(cpus)
+
+        # On pc-*-4.0, no CPU model should be reported as an alias:
+        for name,c in cpus.items():
+            self.assertNotIn('alias-of', c, "%s shouldn't be an alias" %=
 (name))
--=20
2.18.0.rc1.1.g3f1ff2140



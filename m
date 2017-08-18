Received: from eggs.gnu.org ([2001:4830:134:3::10]:60605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDH-0003wa-Bd
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDF-0000XO-Sz
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dieDF-0000X0-KM
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:09 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 18 Aug 2017 12:08:37 +0200
Message-Id: <1503050939-227939-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.11 05/27] target-i386: cpu: convert
 plus/minus properties to global properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Since
 (commit d4a606b3 i386: Don't override -cpu options on -cpu host/max)
it became possible to delete hack where it was necessary to
postpone applying plus/minus features to realize time
after max_features were applied to keep legacy +-feat
override semantics.

with above commit it's possible to convert +-feat to a set
of GlobalProperty items and keep +-feat override semantics,
these properties should be added to global list at the end
to override properties that were set with feat=3Don|off syntax.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Richard Henderson <rth@twiddle.net>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Artyom Tarasenko <atar4qemu@gmail.com>
CC: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 target/i386/cpu.c | 108 ++++++++++++++++++++----------------------------=
------
 1 file changed, 40 insertions(+), 68 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ddc45ab..84f552d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2058,23 +2058,32 @@ static const char *x86_cpu_feature_name(FeatureWo=
rd w, int bitnr)
     return feature_word_info[w].feat_names[bitnr];
 }
=20
-/* Compatibily hack to maintain legacy +-feat semantic,
- * where +-feat overwrites any feature set by
- * feat=3Don|feat even if the later is parsed after +-feat
- * (i.e. "-x2apic,x2apic=3Don" will result in x2apic disabled)
- */
-static GList *plus_features, *minus_features;
-
 static gint compare_string(gconstpointer a, gconstpointer b)
 {
     return g_strcmp0(a, b);
 }
=20
-/* Parse "+feature,-feature,feature=3Dfoo" CPU feature string
- */
+static void
+cpu_add_feat_as_prop(const char *typename, const char *name, const char =
*val)
+{
+    GlobalProperty *prop =3D g_new0(typeof(*prop), 1);
+    prop->driver =3D typename;
+    prop->property =3D g_strdup(name);
+    prop->value =3D g_strdup(val);
+    prop->errp =3D &error_fatal;
+    qdev_prop_register_global(prop);
+}
+
+/* Parse "+feature,-feature,feature=3Dfoo" CPU feature string */
 static void x86_cpu_parse_featurestr(const char *typename, char *feature=
s,
                                      Error **errp)
 {
+    /* Compatibily hack to maintain legacy +-feat semantic,
+     * where +-feat overwrites any feature set by
+     * feat=3Don|feat even if the later is parsed after +-feat
+     * (i.e. "-x2apic,x2apic=3Don" will result in x2apic disabled)
+     */
+    GList *l, *plus_features =3D NULL, *minus_features =3D NULL;
     char *featurestr; /* Single 'key=3Dvalue" string being parsed */
     static bool cpu_globals_initialized;
     bool ambiguous =3D false;
@@ -2095,7 +2104,6 @@ static void x86_cpu_parse_featurestr(const char *ty=
pename, char *features,
         const char *val =3D NULL;
         char *eq =3D NULL;
         char num[32];
-        GlobalProperty *prop;
=20
         /* Compatibility syntax: */
         if (featurestr[0] =3D=3D '+') {
@@ -2147,21 +2155,32 @@ static void x86_cpu_parse_featurestr(const char *=
typename, char *features,
             name =3D "tsc-frequency";
         }
=20
-        prop =3D g_new0(typeof(*prop), 1);
-        prop->driver =3D typename;
-        prop->property =3D g_strdup(name);
-        prop->value =3D g_strdup(val);
-        prop->errp =3D &error_fatal;
-        qdev_prop_register_global(prop);
+        cpu_add_feat_as_prop(typename, name, val);
     }
=20
     if (ambiguous) {
         warn_report("Compatibility of ambiguous CPU model "
                     "strings won't be kept on future QEMU versions");
     }
+
+    for (l =3D plus_features; l; l =3D l->next) {
+        const char *name =3D l->data;
+        cpu_add_feat_as_prop(typename, name, "on");
+    }
+    if (plus_features) {
+        g_list_free_full(plus_features, g_free);
+    }
+
+    for (l =3D minus_features; l; l =3D l->next) {
+        const char *name =3D l->data;
+        cpu_add_feat_as_prop(typename, name, "off");
+    }
+    if (minus_features) {
+        g_list_free_full(minus_features, g_free);
+    }
 }
=20
-static void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
+static void x86_cpu_expand_features(X86CPU *cpu);
 static int x86_cpu_filter_features(X86CPU *cpu);
=20
 /* Check for missing features that may prevent the CPU class from
@@ -2172,7 +2191,6 @@ static void x86_cpu_class_check_missing_features(X8=
6CPUClass *xcc,
 {
     X86CPU *xc;
     FeatureWord w;
-    Error *err =3D NULL;
     strList **next =3D missing_feats;
=20
     if (xcc->kvm_required && !kvm_enabled()) {
@@ -2184,18 +2202,7 @@ static void x86_cpu_class_check_missing_features(X=
86CPUClass *xcc,
=20
     xc =3D X86_CPU(object_new(object_class_get_name(OBJECT_CLASS(xcc))))=
;
=20
-    x86_cpu_expand_features(xc, &err);
-    if (err) {
-        /* Errors at x86_cpu_expand_features should never happen,
-         * but in case it does, just report the model as not
-         * runnable at all using the "type" property.
-         */
-        strList *new =3D g_new0(strList, 1);
-        new->value =3D g_strdup("type");
-        *next =3D new;
-        next =3D &new->next;
-    }
-
+    x86_cpu_expand_features(xc);
     x86_cpu_filter_features(xc);
=20
     for (w =3D 0; w < FEATURE_WORDS; w++) {
@@ -2559,11 +2566,7 @@ static X86CPU *x86_cpu_from_model(const char *mode=
l, QDict *props, Error **errp)
         }
     }
=20
-    x86_cpu_expand_features(xc, &err);
-    if (err) {
-        goto out;
-    }
-
+    x86_cpu_expand_features(xc);
 out:
     if (err) {
         error_propagate(errp, err);
@@ -3453,18 +3456,11 @@ static void x86_cpu_enable_xsave_components(X86CP=
U *cpu)
 /* Expand CPU configuration data, based on configured features
  * and host/accelerator capabilities when appropriate.
  */
-static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
+static void x86_cpu_expand_features(X86CPU *cpu)
 {
     CPUX86State *env =3D &cpu->env;
     FeatureWord w;
-    GList *l;
-    Error *local_err =3D NULL;
=20
-    /*TODO: Now cpu->max_features doesn't overwrite features
-     * set using QOM properties, and we can convert
-     * plus_features & minus_features to global properties
-     * inside x86_cpu_parse_featurestr() too.
-     */
     if (cpu->max_features) {
         for (w =3D 0; w < FEATURE_WORDS; w++) {
             /* Override only features that weren't set explicitly
@@ -3476,22 +3472,6 @@ static void x86_cpu_expand_features(X86CPU *cpu, E=
rror **errp)
         }
     }
=20
-    for (l =3D plus_features; l; l =3D l->next) {
-        const char *prop =3D l->data;
-        object_property_set_bool(OBJECT(cpu), true, prop, &local_err);
-        if (local_err) {
-            goto out;
-        }
-    }
-
-    for (l =3D minus_features; l; l =3D l->next) {
-        const char *prop =3D l->data;
-        object_property_set_bool(OBJECT(cpu), false, prop, &local_err);
-        if (local_err) {
-            goto out;
-        }
-    }
-
     if (!kvm_enabled() || !cpu->expose_kvm) {
         env->features[FEAT_KVM] =3D 0;
     }
@@ -3527,11 +3507,6 @@ static void x86_cpu_expand_features(X86CPU *cpu, E=
rror **errp)
     if (env->cpuid_xlevel2 =3D=3D UINT32_MAX) {
         env->cpuid_xlevel2 =3D env->cpuid_min_xlevel2;
     }
-
-out:
-    if (local_err !=3D NULL) {
-        error_propagate(errp, local_err);
-    }
 }
=20
 /*
@@ -3587,10 +3562,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
         return;
     }
=20
-    x86_cpu_expand_features(cpu, &local_err);
-    if (local_err) {
-        goto out;
-    }
+    x86_cpu_expand_features(cpu);
=20
     if (x86_cpu_filter_features(cpu) &&
         (cpu->check_cpuid || cpu->enforce_cpuid)) {
--=20
2.7.4

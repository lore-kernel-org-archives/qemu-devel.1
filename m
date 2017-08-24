Received: from eggs.gnu.org ([2001:4830:134:3::10]:54969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv33-0000c0-3x
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv31-0007TK-LP
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dkv31-0007St-Cr
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:31:59 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 24 Aug 2017 18:31:29 +0200
Message-Id: <1503592308-93913-7-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
References: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.11 v3 06/25] sparc: make cpu feature
 parsing property based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>

with features converted to properties we can use the same
approach as x86 for features parsing and drop legacy
approach that manipulated CPU instance directly.
New sparc_cpu_parse_features() will allow only +-feat
and explicitly disable feat=3Don|off syntax for now.

With that in place and sparc_cpu_parse_features() providing
generic CPUClass::parse_features callback, the cpu_sparc_init()
will do the same job as cpu_generic_init() so replace content
of cpu_sparc_init() with it.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Riku Voipio <riku.voipio@iki.fi>
CC: Laurent Vivier <laurent@vivier.eu>
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Artyom Tarasenko <atar4qemu@gmail.com>
CC: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
CC: Eduardo Habkost <ehabkost@redhat.com>

v3:
  * drop cpu_legacy_parse_featurestr() and reimplement
    sparc_cpu_parse_features() similar to x86 parser
    but without x86 baggage.
v2:
  * use new cpu_legacy_parse_featurestr() without
    plus_features/minus_features
  * drop cpu_legacy_apply_features() as it's been removed in
    previuos patch and new cpu_legacy_parse_featurestr()
    does its job
---
 target/sparc/cpu.c | 208 +++++++++++++++++++----------------------------=
------
 1 file changed, 75 insertions(+), 133 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 9dfc150..c02ca85 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -104,50 +104,92 @@ static void cpu_sparc_disas_set_info(CPUState *cpu,=
 disassemble_info *info)
 #endif
 }
=20
-static void sparc_cpu_parse_features(CPUState *cs, char *features,
-                                     Error **errp);
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
=20
-static int cpu_sparc_register(SPARCCPU *cpu, const char *cpu_model)
+/* Parse "+feature,-feature,feature=3Dfoo" CPU feature string */
+static void sparc_cpu_parse_features(const char *typename, char *feature=
s,
+                                     Error **errp)
 {
-    char *s =3D g_strdup(cpu_model);
-    char *featurestr =3D strtok(s, ",");
-    Error *err =3D NULL;
+    GList *l, *plus_features =3D NULL, *minus_features =3D NULL;
+    char *featurestr; /* Single 'key=3Dvalue" string being parsed */
+    static bool cpu_globals_initialized;
=20
-    featurestr =3D strtok(NULL, ",");
-    sparc_cpu_parse_features(CPU(cpu), featurestr, &err);
-    g_free(s);
-    if (err) {
-        error_report_err(err);
-        return -1;
+    if (cpu_globals_initialized) {
+        return;
     }
+    cpu_globals_initialized =3D true;
=20
-    return 0;
-}
+    if (!features) {
+        return;
+    }
=20
-SPARCCPU *cpu_sparc_init(const char *cpu_model)
-{
-    SPARCCPU *cpu;
-    ObjectClass *oc;
-    char *str, *name;
+    for (featurestr =3D strtok(features, ",");
+         featurestr;
+         featurestr =3D strtok(NULL, ",")) {
+        const char *name;
+        const char *val =3D NULL;
+        char *eq =3D NULL;
=20
-    str =3D g_strdup(cpu_model);
-    name =3D strtok(str, ",");
-    oc =3D cpu_class_by_name(TYPE_SPARC_CPU, name);
-    g_free(str);
-    if (oc =3D=3D NULL) {
-        return NULL;
-    }
+        /* Compatibility syntax: */
+        if (featurestr[0] =3D=3D '+') {
+            plus_features =3D g_list_append(plus_features,
+                                          g_strdup(featurestr + 1));
+            continue;
+        } else if (featurestr[0] =3D=3D '-') {
+            minus_features =3D g_list_append(minus_features,
+                                           g_strdup(featurestr + 1));
+            continue;
+        }
=20
-    cpu =3D SPARC_CPU(object_new(object_class_get_name(oc)));
+        eq =3D strchr(featurestr, '=3D');
+        name =3D featurestr;
+        if (eq) {
+            *eq++ =3D 0;
+            val =3D eq;
+            if (!strcasecmp(val, "on") ||
+                !strcasecmp(val, "off") ||
+                !strcasecmp(val, "true") ||
+                !strcasecmp(val, "false")) {
+                error_setg(errp, "Boolean properties in format %s=3D%s"
+                                 " are not supported", name, val);
+                return;
+            }
+        } else {
+            error_setg(errp, "Unsupported property format: %s", name);
+            return;
+        }
+        cpu_add_feat_as_prop(typename, name, val);
+    }
=20
-    if (cpu_sparc_register(cpu, cpu_model) < 0) {
-        object_unref(OBJECT(cpu));
-        return NULL;
+    for (l =3D plus_features; l; l =3D l->next) {
+        const char *name =3D l->data;
+        cpu_add_feat_as_prop(typename, name, "on");
+    }
+    if (plus_features) {
+        g_list_free_full(plus_features, g_free);
     }
=20
-    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
+    for (l =3D minus_features; l; l =3D l->next) {
+        const char *name =3D l->data;
+        cpu_add_feat_as_prop(typename, name, "off");
+    }
+    if (minus_features) {
+        g_list_free_full(minus_features, g_free);
+    }
+}
=20
-    return cpu;
+SPARCCPU *cpu_sparc_init(const char *cpu_model)
+{
+    return SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
 }
=20
 void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu)
@@ -528,107 +570,6 @@ static void print_features(FILE *f, fprintf_functio=
n cpu_fprintf,
     }
 }
=20
-static void add_flagname_to_bitmaps(const char *flagname, uint32_t *feat=
ures)
-{
-    unsigned int i;
-
-    for (i =3D 0; i < ARRAY_SIZE(feature_name); i++) {
-        if (feature_name[i] && !strcmp(flagname, feature_name[i])) {
-            *features |=3D 1 << i;
-            return;
-        }
-    }
-    error_report("CPU feature %s not found", flagname);
-}
-
-static void sparc_cpu_parse_features(CPUState *cs, char *features,
-                                     Error **errp)
-{
-    SPARCCPU *cpu =3D SPARC_CPU(cs);
-    sparc_def_t *cpu_def =3D &cpu->env.def;
-    char *featurestr;
-    uint32_t plus_features =3D 0;
-    uint32_t minus_features =3D 0;
-    uint64_t iu_version;
-    uint32_t fpu_version, mmu_version, nwindows;
-
-    featurestr =3D features ? strtok(features, ",") : NULL;
-    while (featurestr) {
-        char *val;
-
-        if (featurestr[0] =3D=3D '+') {
-            add_flagname_to_bitmaps(featurestr + 1, &plus_features);
-        } else if (featurestr[0] =3D=3D '-') {
-            add_flagname_to_bitmaps(featurestr + 1, &minus_features);
-        } else if ((val =3D strchr(featurestr, '=3D'))) {
-            *val =3D 0; val++;
-            if (!strcmp(featurestr, "iu_version")) {
-                char *err;
-
-                iu_version =3D strtoll(val, &err, 0);
-                if (!*val || *err) {
-                    error_setg(errp, "bad numerical value %s", val);
-                    return;
-                }
-                cpu_def->iu_version =3D iu_version;
-#ifdef DEBUG_FEATURES
-                fprintf(stderr, "iu_version %" PRIx64 "\n", iu_version);
-#endif
-            } else if (!strcmp(featurestr, "fpu_version")) {
-                char *err;
-
-                fpu_version =3D strtol(val, &err, 0);
-                if (!*val || *err) {
-                    error_setg(errp, "bad numerical value %s", val);
-                    return;
-                }
-                cpu_def->fpu_version =3D fpu_version;
-#ifdef DEBUG_FEATURES
-                fprintf(stderr, "fpu_version %x\n", fpu_version);
-#endif
-            } else if (!strcmp(featurestr, "mmu_version")) {
-                char *err;
-
-                mmu_version =3D strtol(val, &err, 0);
-                if (!*val || *err) {
-                    error_setg(errp, "bad numerical value %s", val);
-                    return;
-                }
-                cpu_def->mmu_version =3D mmu_version;
-#ifdef DEBUG_FEATURES
-                fprintf(stderr, "mmu_version %x\n", mmu_version);
-#endif
-            } else if (!strcmp(featurestr, "nwindows")) {
-                char *err;
-
-                nwindows =3D strtol(val, &err, 0);
-                if (!*val || *err || nwindows > MAX_NWINDOWS ||
-                    nwindows < MIN_NWINDOWS) {
-                    error_setg(errp, "bad numerical value %s", val);
-                    return;
-                }
-                cpu_def->nwindows =3D nwindows;
-#ifdef DEBUG_FEATURES
-                fprintf(stderr, "nwindows %d\n", nwindows);
-#endif
-            } else {
-                error_setg(errp, "unrecognized feature %s", featurestr);
-                return;
-            }
-        } else {
-            error_setg(errp, "feature string `%s' not in format "
-                             "(+feature|-feature|feature=3Dxyz)", featur=
estr);
-            return;
-        }
-        featurestr =3D strtok(NULL, ",");
-    }
-    cpu_def->features |=3D plus_features;
-    cpu_def->features &=3D ~minus_features;
-#ifdef DEBUG_FEATURES
-    print_features(stderr, fprintf, cpu_def->features, NULL);
-#endif
-}
-
 void sparc_cpu_list(FILE *f, fprintf_function cpu_fprintf)
 {
     unsigned int i;
@@ -931,6 +872,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, voi=
d *data)
     cc->reset =3D sparc_cpu_reset;
=20
     cc->class_by_name =3D sparc_cpu_class_by_name;
+    cc->parse_features =3D sparc_cpu_parse_features;
     cc->has_work =3D sparc_cpu_has_work;
     cc->do_interrupt =3D sparc_cpu_do_interrupt;
     cc->cpu_exec_interrupt =3D sparc_cpu_exec_interrupt;
--=20
2.7.4

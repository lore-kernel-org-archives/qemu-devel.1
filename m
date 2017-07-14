Received: from eggs.gnu.org ([2001:4830:134:3::10]:41304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW11v-0001kL-DQ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW11r-0001Yr-Md
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW11r-0001Xg-Cs
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:11 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:51:59 +0200
Message-Id: <1500040339-119465-9-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/28] x86: extract legacy cpu features format
 parser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Move cpu_model +-feat parsing into a separate file so that it
could be reused later for parsing similar format of sparc target

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Riku Voipio <riku.voipio@iki.fi>
CC: Laurent Vivier <laurent@vivier.eu>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/cpu.h                     |   6 ++
 default-configs/i386-bsd-user.mak     |   1 +
 default-configs/i386-linux-user.mak   |   1 +
 default-configs/i386-softmmu.mak      |   1 +
 default-configs/x86_64-bsd-user.mak   |   1 +
 default-configs/x86_64-linux-user.mak |   1 +
 default-configs/x86_64-softmmu.mak    |   1 +
 target/i386/cpu.c                     | 124 ++-------------------------
 util/Makefile.objs                    |   1 +
 util/legacy_cpu_features_parser.c     | 153 ++++++++++++++++++++++++++++=
++++++
 10 files changed, 172 insertions(+), 118 deletions(-)
 create mode 100644 util/legacy_cpu_features_parser.c

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 7bfd50c..60aea03 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -1039,4 +1039,10 @@ extern const struct VMStateDescription vmstate_cpu=
_common;
=20
 #define UNASSIGNED_CPU_INDEX -1
=20
+int cpu_legacy_apply_features(Object *obj, GList *features, bool enable,
+                              Error **errp);
+
+void cpu_legacy_parse_featurestr(const char *typename, char *features,
+                                 GList **plus_features, GList **minus_fe=
atures,
+                                 Error **errp);
 #endif
diff --git a/default-configs/i386-bsd-user.mak b/default-configs/i386-bsd=
-user.mak
index af1b31a..b28a05f 100644
--- a/default-configs/i386-bsd-user.mak
+++ b/default-configs/i386-bsd-user.mak
@@ -1 +1,2 @@
 # Default configuration for i386-bsd-user
+CONFIG_LEGACY_CPU_FEATURES=3Dy
diff --git a/default-configs/i386-linux-user.mak b/default-configs/i386-l=
inux-user.mak
index 8657e68..c136967 100644
--- a/default-configs/i386-linux-user.mak
+++ b/default-configs/i386-linux-user.mak
@@ -1 +1,2 @@
 # Default configuration for i386-linux-user
+CONFIG_LEGACY_CPU_FEATURES=3Dy
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-soft=
mmu.mak
index d2ab2f6..e3e7c0e 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -59,3 +59,4 @@ CONFIG_SMBIOS=3Dy
 CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
 CONFIG_PXB=3Dy
 CONFIG_ACPI_VMGENID=3Dy
+CONFIG_LEGACY_CPU_FEATURES=3Dy
diff --git a/default-configs/x86_64-bsd-user.mak b/default-configs/x86_64=
-bsd-user.mak
index 73e5d34..952323c 100644
--- a/default-configs/x86_64-bsd-user.mak
+++ b/default-configs/x86_64-bsd-user.mak
@@ -1 +1,2 @@
 # Default configuration for x86_64-bsd-user
+CONFIG_LEGACY_CPU_FEATURES=3Dy
diff --git a/default-configs/x86_64-linux-user.mak b/default-configs/x86_=
64-linux-user.mak
index bec1d9e..b513ef2 100644
--- a/default-configs/x86_64-linux-user.mak
+++ b/default-configs/x86_64-linux-user.mak
@@ -1 +1,2 @@
 # Default configuration for x86_64-linux-user
+CONFIG_LEGACY_CPU_FEATURES=3Dy
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-=
softmmu.mak
index 9bde2f1..6594ddf 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -59,3 +59,4 @@ CONFIG_SMBIOS=3Dy
 CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
 CONFIG_PXB=3Dy
 CONFIG_ACPI_VMGENID=3Dy
+CONFIG_LEGACY_CPU_FEATURES=3Dy
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c571772..91d3684 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -17,7 +17,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu/cutils.h"
=20
 #include "cpu.h"
 #include "exec/exec-all.h"
@@ -1970,13 +1969,6 @@ static PropertyInfo qdev_prop_spinlocks =3D {
 /* Convert all '_' in a feature string option name to '-', to make featu=
re
  * name conform to QOM property naming rule, which uses '-' instead of '=
_'.
  */
-static inline void feat2prop(char *s)
-{
-    while ((s =3D strchr(s, '_'))) {
-        *s =3D '-';
-    }
-}
-
 /* Return the feature property name for a feature flag bit */
 static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
 {
@@ -2005,100 +1997,11 @@ static const char *x86_cpu_feature_name(FeatureW=
ord w, int bitnr)
  */
 static GList *plus_features, *minus_features;
=20
-static gint compare_string(gconstpointer a, gconstpointer b)
-{
-    return g_strcmp0(a, b);
-}
-
-/* Parse "+feature,-feature,feature=3Dfoo" CPU feature string
- */
 static void x86_cpu_parse_featurestr(const char *typename, char *feature=
s,
                                      Error **errp)
 {
-    char *featurestr; /* Single 'key=3Dvalue" string being parsed */
-    static bool cpu_globals_initialized;
-    bool ambiguous =3D false;
-
-    if (cpu_globals_initialized) {
-        return;
-    }
-    cpu_globals_initialized =3D true;
-
-    if (!features) {
-        return;
-    }
-
-    for (featurestr =3D strtok(features, ",");
-         featurestr;
-         featurestr =3D strtok(NULL, ",")) {
-        const char *name;
-        const char *val =3D NULL;
-        char *eq =3D NULL;
-        char num[32];
-        GlobalProperty *prop;
-
-        /* Compatibility syntax: */
-        if (featurestr[0] =3D=3D '+') {
-            plus_features =3D g_list_append(plus_features,
-                                          g_strdup(featurestr + 1));
-            continue;
-        } else if (featurestr[0] =3D=3D '-') {
-            minus_features =3D g_list_append(minus_features,
-                                           g_strdup(featurestr + 1));
-            continue;
-        }
-
-        eq =3D strchr(featurestr, '=3D');
-        if (eq) {
-            *eq++ =3D 0;
-            val =3D eq;
-        } else {
-            val =3D "on";
-        }
-
-        feat2prop(featurestr);
-        name =3D featurestr;
-
-        if (g_list_find_custom(plus_features, name, compare_string)) {
-            error_report("warning: Ambiguous CPU model string. "
-                         "Don't mix both \"+%s\" and \"%s=3D%s\"",
-                         name, name, val);
-            ambiguous =3D true;
-        }
-        if (g_list_find_custom(minus_features, name, compare_string)) {
-            error_report("warning: Ambiguous CPU model string. "
-                         "Don't mix both \"-%s\" and \"%s=3D%s\"",
-                         name, name, val);
-            ambiguous =3D true;
-        }
-
-        /* Special case: */
-        if (!strcmp(name, "tsc-freq")) {
-            int ret;
-            uint64_t tsc_freq;
-
-            ret =3D qemu_strtosz_metric(val, NULL, &tsc_freq);
-            if (ret < 0 || tsc_freq > INT64_MAX) {
-                error_setg(errp, "bad numerical value %s", val);
-                return;
-            }
-            snprintf(num, sizeof(num), "%" PRId64, tsc_freq);
-            val =3D num;
-            name =3D "tsc-frequency";
-        }
-
-        prop =3D g_new0(typeof(*prop), 1);
-        prop->driver =3D typename;
-        prop->property =3D g_strdup(name);
-        prop->value =3D g_strdup(val);
-        prop->errp =3D &error_fatal;
-        qdev_prop_register_global(prop);
-    }
-
-    if (ambiguous) {
-        error_report("warning: Compatibility of ambiguous CPU model "
-                     "strings won't be kept on future QEMU versions");
-    }
+    cpu_legacy_parse_featurestr(typename, features,
+        &plus_features, &minus_features, errp);
 }
=20
 static void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
@@ -3370,8 +3273,6 @@ static void x86_cpu_expand_features(X86CPU *cpu, Er=
ror **errp)
 {
     CPUX86State *env =3D &cpu->env;
     FeatureWord w;
-    GList *l;
-    Error *local_err =3D NULL;
=20
     /*TODO: Now cpu->max_features doesn't overwrite features
      * set using QOM properties, and we can convert
@@ -3389,20 +3290,12 @@ static void x86_cpu_expand_features(X86CPU *cpu, =
Error **errp)
         }
     }
=20
-    for (l =3D plus_features; l; l =3D l->next) {
-        const char *prop =3D l->data;
-        object_property_set_bool(OBJECT(cpu), true, prop, &local_err);
-        if (local_err) {
-            goto out;
-        }
+    if (cpu_legacy_apply_features(OBJECT(cpu), plus_features, true, errp=
)) {
+        return;
     }
=20
-    for (l =3D minus_features; l; l =3D l->next) {
-        const char *prop =3D l->data;
-        object_property_set_bool(OBJECT(cpu), false, prop, &local_err);
-        if (local_err) {
-            goto out;
-        }
+    if (cpu_legacy_apply_features(OBJECT(cpu), minus_features, false, er=
rp)) {
+        return;
     }
=20
     if (!kvm_enabled() || !cpu->expose_kvm) {
@@ -3440,11 +3333,6 @@ static void x86_cpu_expand_features(X86CPU *cpu, E=
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
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 50a55ec..14e28f7 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -45,3 +45,4 @@ util-obj-y +=3D qht.o
 util-obj-y +=3D range.o
 util-obj-y +=3D stats64.o
 util-obj-y +=3D systemd.o
+util-obj-$(CONFIG_LEGACY_CPU_FEATURES) +=3D legacy_cpu_features_parser.o
diff --git a/util/legacy_cpu_features_parser.c b/util/legacy_cpu_features=
_parser.c
new file mode 100644
index 0000000..f2e3b81
--- /dev/null
+++ b/util/legacy_cpu_features_parser.c
@@ -0,0 +1,153 @@
+/* Support for legacy -cpu cpu,features CLI option with +-feat syntax,
+ * used by x86/sparc targets
+ *
+ * Author: Andreas F=C3=A4rber <afaerber@suse.de>
+ * Author: Andre Przywara <andre.przywara@amd.com>
+ * Author: Eduardo Habkost <ehabkost@redhat.com>
+ * Author: Igor Mammedov <imammedo@redhat.com>
+ * Author: Paolo Bonzini <pbonzini@redhat.com>
+ * Author: Markus Armbruster <armbru@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License alo=
ng
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/cutils.h"
+#include "qom/cpu.h"
+#include "qemu/error-report.h"
+#include "hw/qdev-properties.h"
+
+/* DO NOT USE WITH NEW CODE */
+int cpu_legacy_apply_features(Object *obj, GList *features, bool enable,
+                              Error **errp)
+{
+    GList *l;
+    Error *local_err =3D NULL;
+
+    for (l =3D features; l; l =3D l->next) {
+        const char *prop =3D l->data;
+        object_property_set_bool(obj, enable, prop, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return 1;
+        }
+    }
+    return 0;
+}
+
+static inline void feat2prop(char *s)
+{
+    while ((s =3D strchr(s, '_'))) {
+        *s =3D '-';
+    }
+}
+
+static gint compare_string(gconstpointer a, gconstpointer b)
+{
+    return g_strcmp0(a, b);
+}
+
+/* DO NOT USE WITH NEW CODE
+ * Parse "+feature,-feature,feature=3Dfoo" CPU feature string
+ */
+void cpu_legacy_parse_featurestr(const char *typename, char *features,
+                                 GList **plus_features, GList **minus_fe=
atures,
+                                 Error **errp)
+{
+    char *featurestr; /* Single 'key=3Dvalue" string being parsed */
+    static bool cpu_globals_initialized;
+    bool ambiguous =3D false;
+
+    if (cpu_globals_initialized) {
+        return;
+    }
+    cpu_globals_initialized =3D true;
+
+    if (!features) {
+        return;
+    }
+
+    for (featurestr =3D strtok(features, ",");
+         featurestr;
+         featurestr =3D strtok(NULL, ",")) {
+        const char *name;
+        const char *val =3D NULL;
+        char *eq =3D NULL;
+        char num[32];
+        GlobalProperty *prop;
+
+        /* Compatibility syntax: */
+        if (featurestr[0] =3D=3D '+') {
+            *plus_features =3D g_list_append(*plus_features,
+                                           g_strdup(featurestr + 1));
+            continue;
+        } else if (featurestr[0] =3D=3D '-') {
+            *minus_features =3D g_list_append(*minus_features,
+                                            g_strdup(featurestr + 1));
+            continue;
+        }
+
+        eq =3D strchr(featurestr, '=3D');
+        if (eq) {
+            *eq++ =3D 0;
+            val =3D eq;
+        } else {
+            val =3D "on";
+        }
+
+        feat2prop(featurestr);
+        name =3D featurestr;
+
+        if (g_list_find_custom(*plus_features, name, compare_string)) {
+            error_report("warning: Ambiguous CPU model string. "
+                         "Don't mix both \"+%s\" and \"%s=3D%s\"",
+                         name, name, val);
+            ambiguous =3D true;
+        }
+        if (g_list_find_custom(*minus_features, name, compare_string)) {
+            error_report("warning: Ambiguous CPU model string. "
+                         "Don't mix both \"-%s\" and \"%s=3D%s\"",
+                         name, name, val);
+            ambiguous =3D true;
+        }
+
+        /* Special case: */
+        if (!strcmp(name, "tsc-freq")) {
+            int ret;
+            uint64_t tsc_freq;
+
+            ret =3D qemu_strtosz_metric(val, NULL, &tsc_freq);
+            if (ret < 0 || tsc_freq > INT64_MAX) {
+                error_setg(errp, "bad numerical value %s", val);
+                return;
+            }
+            snprintf(num, sizeof(num), "%" PRId64, tsc_freq);
+            val =3D num;
+            name =3D "tsc-frequency";
+        }
+
+        prop =3D g_new0(typeof(*prop), 1);
+        prop->driver =3D typename;
+        prop->property =3D g_strdup(name);
+        prop->value =3D g_strdup(val);
+        prop->errp =3D &error_fatal;
+        qdev_prop_register_global(prop);
+    }
+
+    if (ambiguous) {
+        error_report("warning: Compatibility of ambiguous CPU model "
+                     "strings won't be kept on future QEMU versions");
+    }
+}
--=20
2.7.4

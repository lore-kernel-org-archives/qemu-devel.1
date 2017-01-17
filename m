Received: from eggs.gnu.org ([2001:4830:134:3::10]:36841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTIAI-0004pZ-O5
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTIAH-0001Xf-Ik
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTIAH-0001Vo-9q
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:21 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F0638553F
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 01:02:21 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 16 Jan 2017 23:01:58 -0200
Message-Id: <20170117010204.4909-4-ehabkost@redhat.com>
In-Reply-To: <20170117010204.4909-1-ehabkost@redhat.com>
References: <20170117010204.4909-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/9] cpu: Support comma escaping when parsing
 -cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

Currently it's impossible to use commas inside any option value
in -cpu due to the simple way the parser splits the options.

Change both cpu_common_parse_features() and
x86_cpu_parse_featurestr() to use get_opt_*() parsing options,
that can handle handle ",," escaping of commas.

The ideal solution is to use QemuOpts to parse the -cpu option.
But this will require changing the CPUClass::parse_features()
interface, so it will be done later.

Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qom/cpu.c                     | 32 +++++++++++++++-------
 target/i386/cpu.c             | 63 ++++++++++++++++++++++---------------------
 tests/test-x86-cpuid-compat.c | 19 +++++++++++++
 3 files changed, 74 insertions(+), 40 deletions(-)

diff --git a/qom/cpu.c b/qom/cpu.c
index 03d9190f8c..47d69f7135 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -295,8 +295,7 @@ static ObjectClass *cpu_common_class_by_name(const char *cpu_model)
 static void cpu_common_parse_features(const char *typename, char *features,
                                       Error **errp)
 {
-    char *featurestr; /* Single "key=value" string being parsed */
-    char *val;
+    const char *featurestr;
     static bool cpu_globals_initialized;
 
     /* TODO: all callers of ->parse_features() need to be changed to
@@ -310,16 +309,26 @@ static void cpu_common_parse_features(const char *typename, char *features,
     }
     cpu_globals_initialized = true;
 
-    featurestr = features ? strtok(features, ",") : NULL;
+    if (!features) {
+        return;
+    }
 
-    while (featurestr) {
-        val = strchr(featurestr, '=');
-        if (val) {
+    /*TODO: Use QemuOpts to parse -cpu on main(), so we don't need
+     *      to manually call get_opt_*() here.
+     */
+    for (featurestr = features; *featurestr != '\0'; featurestr++) {
+        const char *pe = strchr(featurestr, '=');
+        const char *pc = strchr(featurestr, ',');
+        if (pe && (!pc || pc > pe)) {
+            char option[128], val[1024];
             GlobalProperty *prop = g_new0(typeof(*prop), 1);
-            *val = 0;
-            val++;
+
+            featurestr = get_opt_name(option, sizeof(option), featurestr, '=');
+            featurestr++;
+            featurestr = get_opt_value(val, sizeof(val), featurestr);
+
             prop->driver = typename;
-            prop->property = g_strdup(featurestr);
+            prop->property = g_strdup(option);
             prop->value = g_strdup(val);
             prop->errp = &error_fatal;
             qdev_prop_register_global(prop);
@@ -328,7 +337,10 @@ static void cpu_common_parse_features(const char *typename, char *features,
                        featurestr);
             return;
         }
-        featurestr = strtok(NULL, ",");
+
+        if (*featurestr != ',') {
+            break;
+        }
     }
 }
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6046cc0ced..d0e9400e62 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1975,7 +1975,7 @@ static gint compare_string(gconstpointer a, gconstpointer b)
 static void x86_cpu_parse_featurestr(const char *typename, char *features,
                                      Error **errp)
 {
-    char *featurestr; /* Single 'key=value" string being parsed */
+    const char *featurestr;
     static bool cpu_globals_initialized;
     bool ambiguous = false;
 
@@ -1988,36 +1988,40 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
         return;
     }
 
-    for (featurestr = strtok(features, ",");
-         featurestr;
-         featurestr = strtok(NULL, ",")) {
-        const char *name;
-        const char *val = NULL;
-        char *eq = NULL;
-        char num[32];
+    /*TODO: Use QemuOpts to parse -cpu on main(), so we don't need
+     *      to manually call get_opt_*() here.
+     */
+    for (featurestr = features;
+         *featurestr != '\0';
+         *featurestr == ',' ? featurestr++ : 0) {
+        char name[128], val[1024];
         GlobalProperty *prop;
-
-        /* Compatibility syntax: */
-        if (featurestr[0] == '+') {
-            plus_features = g_list_append(plus_features,
-                                          g_strdup(featurestr + 1));
-            continue;
-        } else if (featurestr[0] == '-') {
-            minus_features = g_list_append(minus_features,
-                                           g_strdup(featurestr + 1));
-            continue;
-        }
-
-        eq = strchr(featurestr, '=');
-        if (eq) {
-            *eq++ = 0;
-            val = eq;
+        const char *pe = strchr(featurestr, '=');
+        const char *pc = strchr(featurestr, ',');
+
+        if (pe && (!pc || pc > pe)) {
+            /* opt=value[,...] */
+            featurestr = get_opt_name(name, sizeof(name), featurestr, '=');
+            featurestr++;
+            featurestr = get_opt_value(val, sizeof(val), featurestr);
         } else {
-            val = "on";
+            /* opt[,...] */
+            featurestr = get_opt_name(name, sizeof(name), featurestr, ',');
+            pstrcpy(val, sizeof(val), "on");
+
+            /* Compatibility syntax: */
+            if (name[0] == '+') {
+                plus_features = g_list_append(plus_features,
+                                              g_strdup(name + 1));
+                continue;
+            } else if (name[0] == '-') {
+                minus_features = g_list_append(minus_features,
+                                               g_strdup(name + 1));
+                continue;
+            }
         }
 
-        feat2prop(featurestr);
-        name = featurestr;
+        feat2prop(name);
 
         if (g_list_find_custom(plus_features, name, compare_string)) {
             error_report("warning: Ambiguous CPU model string. "
@@ -2043,9 +2047,8 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
                 error_setg(errp, "bad numerical value %s", val);
                 return;
             }
-            snprintf(num, sizeof(num), "%" PRId64, tsc_freq);
-            val = num;
-            name = "tsc-frequency";
+            snprintf(val, sizeof(val), "%" PRId64, tsc_freq);
+            pstrcpy(name, sizeof(name), "tsc-frequency");
         }
 
         prop = g_new0(typeof(*prop), 1);
diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.c
index 79a2e69a28..06caa5b945 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -4,6 +4,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qint.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qstring.h"
 #include "libqtest.h"
 
 static char *get_cpu0_qom_path(void)
@@ -52,6 +53,22 @@ typedef struct CpuidTestArgs {
     int64_t expected_value;
 } CpuidTestArgs;
 
+static void test_commas(void)
+{
+    char *path;
+    QString *value;
+
+    qtest_start("-cpu 'qemu64,fpu=on,model-id=A CPU with commas,,fpu=off'");
+    path = get_cpu0_qom_path();
+    value = qobject_to_qstring(qom_get(path, "model-id"));
+    g_assert_true(qom_get_bool(path, "fpu"));
+    g_assert_cmpstr(qstring_get_str(value), ==, "A CPU with commas,fpu=off");
+    qtest_end();
+
+    QDECREF(value);
+    g_free(path);
+}
+
 static void test_cpuid_prop(const void *data)
 {
     const CpuidTestArgs *args = data;
@@ -132,6 +149,8 @@ int main(int argc, char **argv)
     g_test_add_func("/x86/cpuid/parsing-plus-minus", test_plus_minus);
 #endif
 
+    g_test_add_func("/x86/parsing/commas", test_commas);
+
     /* Original level values for CPU models: */
     add_cpuid_test("x86/cpuid/phenom/level",
                    "-cpu phenom", "level", 5);
-- 
2.11.0.259.g40922b1

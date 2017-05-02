Received: from eggs.gnu.org ([2001:4830:134:3::10]:49997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5eSD-0004iq-NR
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5eSC-00053E-Lv
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:31:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d5eSC-00052d-Cr
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:31:24 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  2 May 2017 17:31:14 -0300
Message-Id: <20170502203115.22233-4-ehabkost@redhat.com>
In-Reply-To: <20170502203115.22233-1-ehabkost@redhat.com>
References: <20170502203115.22233-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] tests: Add [+-]feature and feature=on|off
 test cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Add test code to ensure features are enabled/disabled correctly in the
command-line. The test case use the "feature-words" and
"filtered-features" properties to check if the features were
enabled/disabled correctly.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/test-x86-cpuid-compat.c | 107 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.c
index 79a2e69a28..00ee8a264f 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/qmp/qlist.h"
+#include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qint.h"
 #include "qapi/qmp/qbool.h"
@@ -68,6 +69,9 @@ static void test_cpuid_prop(const void *data)
     g_free(path);
 }
 
+/* Add simple test that ensure that a given (integer) property has
+ * the right value after running QEMU using cmdline
+ */
 static void add_cpuid_test(const char *name, const char *cmdline,
                            const char *property, int64_t expected_value)
 {
@@ -78,6 +82,83 @@ static void add_cpuid_test(const char *name, const char *cmdline,
     qtest_add_data_func(name, args, test_cpuid_prop);
 }
 
+
+/* Parameters to a add_feature_test() test case */
+typedef struct FeatureTestArgs {
+    /* cmdline to start QEMU */
+    const char *cmdline;
+    /*
+     * cpuid-input-eax and cpuid-input-ecx values to look for,
+     * in "feature-words" and "filtered-features" properties.
+     */
+    uint32_t input_eax, input_ecx;
+    /* The register name to look for, in the X86CPUFeatureWordInfo array */
+    const char *reg;
+    /* The bit to check in X86CPUFeatureWordInfo.features */
+    int bitnr;
+    /* The expected value for the bit in (X86CPUFeatureWordInfo.features) */
+    bool expected_value;
+} FeatureTestArgs;
+
+/* Get the value for a feature word in a X86CPUFeatureWordInfo list */
+static uint32_t get_feature_word(QList *features, uint32_t eax, uint32_t ecx, const char *reg)
+{
+    const QListEntry *e;
+
+    for (e = qlist_first(features); e; e = qlist_next(e)) {
+        QDict *w = qobject_to_qdict(qlist_entry_obj(e));
+        if (eax == qint_get_int(qobject_to_qint(qdict_get(w, "cpuid-input-eax")))
+            && (!qdict_haskey(w, "cpuid-input-ecx")
+                || ecx == qint_get_int(qobject_to_qint(qdict_get(w, "cpuid-input-ecx"))))
+            && !strcmp(qstring_get_str(qobject_to_qstring(qdict_get(w, "cpuid-register"))), reg)) {
+            return qint_get_int(qobject_to_qint(qdict_get(w, "features")));
+        }
+    }
+    return 0;
+}
+
+static void test_feature_flag(const void *data)
+{
+    const FeatureTestArgs *args = data;
+    char *path;
+    QList *present, *filtered;
+    uint32_t value;
+
+    qtest_start(args->cmdline);
+    path = get_cpu0_qom_path();
+    present = qobject_to_qlist(qom_get(path, "feature-words"));
+    filtered = qobject_to_qlist(qom_get(path, "filtered-features"));
+    value = get_feature_word(present, args->input_eax, args->input_ecx, args->reg);
+    value |= get_feature_word(filtered, args->input_eax, args->input_ecx, args->reg);
+    qtest_end();
+
+    g_assert(!!(value & (1U << args->bitnr)) == args->expected_value);
+
+    QDECREF(present);
+    QDECREF(filtered);
+    g_free(path);
+}
+
+/* Add test case to ensure that a given feature flag is set in
+  * either "feature-words" or "filtered-features", when running QEMU
+  * using cmdline
+  */
+static FeatureTestArgs *add_feature_test(const char *name, const char *cmdline,
+                                         uint32_t eax, uint32_t ecx,
+                                         const char *reg, int bitnr,
+                                         bool expected_value)
+{
+    FeatureTestArgs *args = g_new0(FeatureTestArgs, 1);
+    args->cmdline = cmdline;
+    args->input_eax = eax;
+    args->input_ecx = ecx;
+    args->reg = reg;
+    args->bitnr = bitnr;
+    args->expected_value = expected_value;
+    qtest_add_data_func(name, args, test_feature_flag);
+    return args;
+}
+
 #ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
 static void test_plus_minus_subprocess(void)
 {
@@ -229,5 +310,31 @@ int main(int argc, char **argv)
                    "-machine pc-i440fx-2.7 -cpu 486,+xstore",
                    "xlevel2", 0);
 
+    /* Test feature parsing */
+    add_feature_test("x86/cpuid/features/plus",
+                     "-cpu 486,+arat",
+                     6, 0, "EAX", 2, true);
+    add_feature_test("x86/cpuid/features/minus",
+                     "-cpu pentium,-mmx",
+                     1, 0, "EDX", 23, false);
+    add_feature_test("x86/cpuid/features/on",
+                     "-cpu 486,arat=on",
+                     6, 0, "EAX", 2, true);
+    add_feature_test("x86/cpuid/features/off",
+                     "-cpu pentium,mmx=off",
+                     1, 0, "EDX", 23, false);
+    add_feature_test("x86/cpuid/features/max-plus-invtsc",
+                     "-machine accel=kvm:tcg -cpu max,+invtsc",
+                     0x80000007, 0, "EDX", 8, true);
+    add_feature_test("x86/cpuid/features/max-invtsc-on",
+                     "-machine accel=kvm:tcg -cpu max,invtsc=on",
+                     0x80000007, 0, "EDX", 8, true);
+    add_feature_test("x86/cpuid/features/max-minus-mmx",
+                     "-machine accel=kvm:tcg -cpu max,-mmx",
+                     1, 0, "EDX", 23, false);
+    add_feature_test("x86/cpuid/features/max-invtsc-on,mmx=off",
+                     "-machine accel=kvm:tcg -cpu max,mmx=off",
+                     1, 0, "EDX", 23, false);
+
     return g_test_run();
 }
-- 
2.11.0.259.g40922b1

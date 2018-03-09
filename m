Received: from eggs.gnu.org ([2001:4830:134:3::10]:33702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKl3-0001Ak-Kx
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKl2-00071T-1w
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:37 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:01 +0100
Message-Id: <20180309161933.8168-25-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 24/56] test-qemu-opts: Test qemu_opts_append()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Basic test for merging two QemuOptsLists.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/test-qemu-opts.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index 5d5a3daa7b..6c3183390b 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -23,6 +23,8 @@ static QemuOptsList opts_list_01 = {
         {
             .name = "str1",
             .type = QEMU_OPT_STRING,
+            .help = "Help texts are preserved in qemu_opts_append",
+            .def_value_str = "default",
         },{
             .name = "str2",
             .type = QEMU_OPT_STRING,
@@ -32,6 +34,7 @@ static QemuOptsList opts_list_01 = {
         },{
             .name = "number1",
             .type = QEMU_OPT_NUMBER,
+            .help = "Having help texts only for some options is okay",
         },{
             .name = "number2",
             .type = QEMU_OPT_NUMBER,
@@ -743,6 +746,129 @@ static void test_opts_parse_size(void)
     qemu_opts_reset(&opts_list_02);
 }
 
+static void append_verify_list_01(QemuOptDesc *desc, bool with_overlapping)
+{
+    int i = 0;
+
+    if (with_overlapping) {
+        g_assert_cmpstr(desc[i].name, ==, "str1");
+        g_assert_cmpint(desc[i].type, ==, QEMU_OPT_STRING);
+        g_assert_cmpstr(desc[i].help, ==,
+                        "Help texts are preserved in qemu_opts_append");
+        g_assert_cmpstr(desc[i].def_value_str, ==, "default");
+        i++;
+
+        g_assert_cmpstr(desc[i].name, ==, "str2");
+        g_assert_cmpint(desc[i].type, ==, QEMU_OPT_STRING);
+        g_assert_cmpstr(desc[i].help, ==, NULL);
+        g_assert_cmpstr(desc[i].def_value_str, ==, NULL);
+        i++;
+    }
+
+    g_assert_cmpstr(desc[i].name, ==, "str3");
+    g_assert_cmpint(desc[i].type, ==, QEMU_OPT_STRING);
+    g_assert_cmpstr(desc[i].help, ==, NULL);
+    g_assert_cmpstr(desc[i].def_value_str, ==, NULL);
+    i++;
+
+    g_assert_cmpstr(desc[i].name, ==, "number1");
+    g_assert_cmpint(desc[i].type, ==, QEMU_OPT_NUMBER);
+    g_assert_cmpstr(desc[i].help, ==,
+                    "Having help texts only for some options is okay");
+    g_assert_cmpstr(desc[i].def_value_str, ==, NULL);
+    i++;
+
+    g_assert_cmpstr(desc[i].name, ==, "number2");
+    g_assert_cmpint(desc[i].type, ==, QEMU_OPT_NUMBER);
+    g_assert_cmpstr(desc[i].help, ==, NULL);
+    g_assert_cmpstr(desc[i].def_value_str, ==, NULL);
+    i++;
+
+    g_assert_cmpstr(desc[i].name, ==, NULL);
+}
+
+static void append_verify_list_02(QemuOptDesc *desc)
+{
+    int i = 0;
+
+    g_assert_cmpstr(desc[i].name, ==, "str1");
+    g_assert_cmpint(desc[i].type, ==, QEMU_OPT_STRING);
+    g_assert_cmpstr(desc[i].help, ==, NULL);
+    g_assert_cmpstr(desc[i].def_value_str, ==, NULL);
+    i++;
+
+    g_assert_cmpstr(desc[i].name, ==, "str2");
+    g_assert_cmpint(desc[i].type, ==, QEMU_OPT_STRING);
+    g_assert_cmpstr(desc[i].help, ==, NULL);
+    g_assert_cmpstr(desc[i].def_value_str, ==, NULL);
+    i++;
+
+    g_assert_cmpstr(desc[i].name, ==, "bool1");
+    g_assert_cmpint(desc[i].type, ==, QEMU_OPT_BOOL);
+    g_assert_cmpstr(desc[i].help, ==, NULL);
+    g_assert_cmpstr(desc[i].def_value_str, ==, NULL);
+    i++;
+
+    g_assert_cmpstr(desc[i].name, ==, "bool2");
+    g_assert_cmpint(desc[i].type, ==, QEMU_OPT_BOOL);
+    g_assert_cmpstr(desc[i].help, ==, NULL);
+    g_assert_cmpstr(desc[i].def_value_str, ==, NULL);
+    i++;
+
+    g_assert_cmpstr(desc[i].name, ==, "size1");
+    g_assert_cmpint(desc[i].type, ==, QEMU_OPT_SIZE);
+    g_assert_cmpstr(desc[i].help, ==, NULL);
+    g_assert_cmpstr(desc[i].def_value_str, ==, NULL);
+    i++;
+
+    g_assert_cmpstr(desc[i].name, ==, "size2");
+    g_assert_cmpint(desc[i].type, ==, QEMU_OPT_SIZE);
+    g_assert_cmpstr(desc[i].help, ==, NULL);
+    g_assert_cmpstr(desc[i].def_value_str, ==, NULL);
+    i++;
+
+    g_assert_cmpstr(desc[i].name, ==, "size3");
+    g_assert_cmpint(desc[i].type, ==, QEMU_OPT_SIZE);
+    g_assert_cmpstr(desc[i].help, ==, NULL);
+    g_assert_cmpstr(desc[i].def_value_str, ==, NULL);
+}
+
+static void test_opts_append_to_null(void)
+{
+    QemuOptsList *merged;
+
+    merged = qemu_opts_append(NULL, &opts_list_01);
+    g_assert(merged != &opts_list_01);
+
+    g_assert_cmpstr(merged->name, ==, NULL);
+    g_assert_cmpstr(merged->implied_opt_name, ==, NULL);
+    g_assert_false(merged->merge_lists);
+
+    append_verify_list_01(merged->desc, true);
+
+    qemu_opts_free(merged);
+}
+
+static void test_opts_append(void)
+{
+    QemuOptsList *first, *merged;
+
+    first = qemu_opts_append(NULL, &opts_list_02);
+    merged = qemu_opts_append(first, &opts_list_01);
+    g_assert(first != &opts_list_02);
+    g_assert(merged != &opts_list_01);
+
+    g_assert_cmpstr(merged->name, ==, NULL);
+    g_assert_cmpstr(merged->implied_opt_name, ==, NULL);
+    g_assert_false(merged->merge_lists);
+
+    append_verify_list_02(&merged->desc[0]);
+    append_verify_list_01(&merged->desc[7], false);
+
+    qemu_opts_free(merged);
+}
+
+
 int main(int argc, char *argv[])
 {
     register_opts();
@@ -761,6 +887,8 @@ int main(int argc, char *argv[])
     g_test_add_func("/qemu-opts/opts_parse/bool", test_opts_parse_bool);
     g_test_add_func("/qemu-opts/opts_parse/number", test_opts_parse_number);
     g_test_add_func("/qemu-opts/opts_parse/size", test_opts_parse_size);
+    g_test_add_func("/qemu-opts/append_to_null", test_opts_append_to_null);
+    g_test_add_func("/qemu-opts/append", test_opts_append);
     g_test_run();
     return 0;
 }
-- 
2.13.6

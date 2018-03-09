Received: from eggs.gnu.org ([2001:4830:134:3::10]:33587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkz-000187-VZ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkx-0006vu-Mn
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:33 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:02 +0100
Message-Id: <20180309161933.8168-26-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 25/56] test-qemu-opts: Test
 qemu_opts_to_qdict_filtered()
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/test-qemu-opts.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index 6c3183390b..2c422abcd4 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/option.h"
+#include "qemu/option_int.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
@@ -868,6 +869,127 @@ static void test_opts_append(void)
     qemu_opts_free(merged);
 }
 
+static void test_opts_to_qdict_basic(void)
+{
+    QemuOpts *opts;
+    QDict *dict;
+
+    opts = qemu_opts_parse(&opts_list_01, "str1=foo,str2=,str3=bar,number1=42",
+                           false, &error_abort);
+    g_assert(opts != NULL);
+
+    dict = qemu_opts_to_qdict(opts, NULL);
+    g_assert(dict != NULL);
+
+    g_assert_cmpstr(qdict_get_str(dict, "str1"), ==, "foo");
+    g_assert_cmpstr(qdict_get_str(dict, "str2"), ==, "");
+    g_assert_cmpstr(qdict_get_str(dict, "str3"), ==, "bar");
+    g_assert_cmpstr(qdict_get_str(dict, "number1"), ==, "42");
+    g_assert_false(qdict_haskey(dict, "number2"));
+
+    QDECREF(dict);
+    qemu_opts_del(opts);
+}
+
+static void test_opts_to_qdict_filtered(void)
+{
+    QemuOptsList *first, *merged;
+    QemuOpts *opts;
+    QDict *dict;
+
+    first = qemu_opts_append(NULL, &opts_list_02);
+    merged = qemu_opts_append(first, &opts_list_01);
+
+    opts = qemu_opts_parse(merged,
+                           "str1=foo,str2=,str3=bar,bool1=off,number1=42",
+                           false, &error_abort);
+    g_assert(opts != NULL);
+
+    /* Convert to QDict without deleting from opts */
+    dict = qemu_opts_to_qdict_filtered(opts, NULL, &opts_list_01, false);
+    g_assert(dict != NULL);
+    g_assert_cmpstr(qdict_get_str(dict, "str1"), ==, "foo");
+    g_assert_cmpstr(qdict_get_str(dict, "str2"), ==, "");
+    g_assert_cmpstr(qdict_get_str(dict, "str3"), ==, "bar");
+    g_assert_cmpstr(qdict_get_str(dict, "number1"), ==, "42");
+    g_assert_false(qdict_haskey(dict, "number2"));
+    g_assert_false(qdict_haskey(dict, "bool1"));
+    QDECREF(dict);
+
+    dict = qemu_opts_to_qdict_filtered(opts, NULL, &opts_list_02, false);
+    g_assert(dict != NULL);
+    g_assert_cmpstr(qdict_get_str(dict, "str1"), ==, "foo");
+    g_assert_cmpstr(qdict_get_str(dict, "str2"), ==, "");
+    g_assert_cmpstr(qdict_get_str(dict, "bool1"), ==, "off");
+    g_assert_false(qdict_haskey(dict, "str3"));
+    g_assert_false(qdict_haskey(dict, "number1"));
+    g_assert_false(qdict_haskey(dict, "number2"));
+    QDECREF(dict);
+
+    /* Now delete converted options from opts */
+    dict = qemu_opts_to_qdict_filtered(opts, NULL, &opts_list_01, true);
+    g_assert(dict != NULL);
+    g_assert_cmpstr(qdict_get_str(dict, "str1"), ==, "foo");
+    g_assert_cmpstr(qdict_get_str(dict, "str2"), ==, "");
+    g_assert_cmpstr(qdict_get_str(dict, "str3"), ==, "bar");
+    g_assert_cmpstr(qdict_get_str(dict, "number1"), ==, "42");
+    g_assert_false(qdict_haskey(dict, "number2"));
+    g_assert_false(qdict_haskey(dict, "bool1"));
+    QDECREF(dict);
+
+    dict = qemu_opts_to_qdict_filtered(opts, NULL, &opts_list_02, true);
+    g_assert(dict != NULL);
+    g_assert_cmpstr(qdict_get_str(dict, "bool1"), ==, "off");
+    g_assert_false(qdict_haskey(dict, "str1"));
+    g_assert_false(qdict_haskey(dict, "str2"));
+    g_assert_false(qdict_haskey(dict, "str3"));
+    g_assert_false(qdict_haskey(dict, "number1"));
+    g_assert_false(qdict_haskey(dict, "number2"));
+    QDECREF(dict);
+
+    g_assert_true(QTAILQ_EMPTY(&opts->head));
+
+    qemu_opts_del(opts);
+    qemu_opts_free(merged);
+}
+
+static void test_opts_to_qdict_duplicates(void)
+{
+    QemuOpts *opts;
+    QemuOpt *opt;
+    QDict *dict;
+
+    opts = qemu_opts_parse(&opts_list_03, "foo=a,foo=b", false, &error_abort);
+    g_assert(opts != NULL);
+
+    /* Verify that opts has two options with the same name */
+    opt = QTAILQ_FIRST(&opts->head);
+    g_assert_cmpstr(opt->name, ==, "foo");
+    g_assert_cmpstr(opt->str , ==, "a");
+
+    opt = QTAILQ_NEXT(opt, next);
+    g_assert_cmpstr(opt->name, ==, "foo");
+    g_assert_cmpstr(opt->str , ==, "b");
+
+    opt = QTAILQ_NEXT(opt, next);
+    g_assert(opt == NULL);
+
+    /* In the conversion to QDict, the last one wins */
+    dict = qemu_opts_to_qdict(opts, NULL);
+    g_assert(dict != NULL);
+    g_assert_cmpstr(qdict_get_str(dict, "foo"), ==, "b");
+    QDECREF(dict);
+
+    /* The last one still wins if entries are deleted, and both are deleted */
+    dict = qemu_opts_to_qdict_filtered(opts, NULL, NULL, true);
+    g_assert(dict != NULL);
+    g_assert_cmpstr(qdict_get_str(dict, "foo"), ==, "b");
+    QDECREF(dict);
+
+    g_assert_true(QTAILQ_EMPTY(&opts->head));
+
+    qemu_opts_del(opts);
+}
 
 int main(int argc, char *argv[])
 {
@@ -889,6 +1011,9 @@ int main(int argc, char *argv[])
     g_test_add_func("/qemu-opts/opts_parse/size", test_opts_parse_size);
     g_test_add_func("/qemu-opts/append_to_null", test_opts_append_to_null);
     g_test_add_func("/qemu-opts/append", test_opts_append);
+    g_test_add_func("/qemu-opts/to_qdict/basic", test_opts_to_qdict_basic);
+    g_test_add_func("/qemu-opts/to_qdict/filtered", test_opts_to_qdict_filtered);
+    g_test_add_func("/qemu-opts/to_qdict/duplicates", test_opts_to_qdict_duplicates);
     g_test_run();
     return 0;
 }
-- 
2.13.6

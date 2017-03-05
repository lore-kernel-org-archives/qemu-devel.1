Received: from eggs.gnu.org ([2001:4830:134:3::10]:45707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckReC-0000P2-7n
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckRe9-0002zY-B0
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ckRe8-0002yZ-Rg
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:05 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B1F283F43
	for <qemu-devel@nongnu.org>; Sun,  5 Mar 2017 08:36:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E27C2D655
	for <qemu-devel@nongnu.org>; Sun,  5 Mar 2017 08:36:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Sun,  5 Mar 2017 09:35:53 +0100
Message-Id: <1488702958-24336-23-git-send-email-armbru@redhat.com>
In-Reply-To: <1488702958-24336-1-git-send-email-armbru@redhat.com>
References: <1488702958-24336-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 22/27] tests: Cover partial input visit of
 list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Demonstrates a design flaw: there is no way to for input visitors to
report that a list visit didn't visit the complete input list.  The
generated list visits always do, but manual visits needn't.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1488544368-30622-24-git-send-email-armbru@redhat.com>
---
 tests/test-opts-visitor.c          | 41 +++++++++++++++++++++++++++++++++++
 tests/test-qobject-input-visitor.c | 44 ++++++++++++++++++++++++++++++++++++++
 tests/test-string-input-visitor.c  | 22 +++++++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/tests/test-opts-visitor.c b/tests/test-opts-visitor.c
index 0a9e75f..d0f7646 100644
--- a/tests/test-opts-visitor.c
+++ b/tests/test-opts-visitor.c
@@ -172,6 +172,44 @@ expect_u64_max(OptsVisitorFixture *f, gconstpointer test_data)
 
 /* test cases */
 
+static void
+test_opts_range_unvisited(void)
+{
+    intList *list = NULL;
+    intList *tail;
+    QemuOpts *opts;
+    Visitor *v;
+
+    opts = qemu_opts_parse(qemu_find_opts("userdef"), "ilist=0-2", false,
+                           &error_abort);
+
+    v = opts_visitor_new(opts);
+
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+
+    /* Would be simpler if the visitor genuinely supported virtual walks */
+    visit_start_list(v, "ilist", (GenericList **)&list, sizeof(*list),
+                     &error_abort);
+    tail = list;
+    visit_type_int(v, NULL, &tail->value, &error_abort);
+    g_assert_cmpint(tail->value, ==, 0);
+    tail = (intList *)visit_next_list(v, (GenericList *)tail, sizeof(*list));
+    g_assert(tail);
+    visit_type_int(v, NULL, &tail->value, &error_abort);
+    g_assert_cmpint(tail->value, ==, 1);
+    tail = (intList *)visit_next_list(v, (GenericList *)tail, sizeof(*list));
+    g_assert(tail);
+    visit_end_list(v, (void **)&list);
+    /* BUG: unvisited tail not reported; actually not reportable by design */
+
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+
+    qapi_free_intList(list);
+    visit_free(v);
+    qemu_opts_del(opts);
+}
+
 int
 main(int argc, char **argv)
 {
@@ -263,6 +301,9 @@ main(int argc, char **argv)
     add_test("/visitor/opts/i64/range/2big/full", &expect_fail,
              "i64=-0x8000000000000000-0x7fffffffffffffff");
 
+    g_test_add_func("/visitor/opts/range/unvisited",
+                    test_opts_range_unvisited);
+
     g_test_run();
     return 0;
 }
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 32c6b3d..10c15c4 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -923,6 +923,46 @@ static void test_visitor_in_fail_struct_missing(TestInputVisitorData *data,
     visit_end_struct(v, NULL);
 }
 
+static void test_visitor_in_fail_list(TestInputVisitorData *data,
+                                      const void *unused)
+{
+    int64_t i64 = -1;
+    Visitor *v;
+
+    /* Unvisited list tail */
+
+    v = visitor_input_test_init(data, "[ 1, 2, 3 ]");
+
+    visit_start_list(v, NULL, NULL, 0, &error_abort);
+    visit_type_int(v, NULL, &i64, &error_abort);
+    g_assert_cmpint(i64, ==, 1);
+    visit_type_int(v, NULL, &i64, &error_abort);
+    g_assert_cmpint(i64, ==, 2);
+    visit_end_list(v, NULL);
+    /* BUG: unvisited tail not reported; actually not reportable by design */
+}
+
+static void test_visitor_in_fail_list_nested(TestInputVisitorData *data,
+                                             const void *unused)
+{
+    int64_t i64 = -1;
+    Visitor *v;
+
+    /* Unvisited nested list tail */
+
+    v = visitor_input_test_init(data, "[ 0, [ 1, 2, 3 ] ]");
+
+    visit_start_list(v, NULL, NULL, 0, &error_abort);
+    visit_type_int(v, NULL, &i64, &error_abort);
+    g_assert_cmpint(i64, ==, 0);
+    visit_start_list(v, NULL, NULL, 0, &error_abort);
+    visit_type_int(v, NULL, &i64, &error_abort);
+    g_assert_cmpint(i64, ==, 1);
+    visit_end_list(v, NULL);
+    /* BUG: unvisited tail not reported; actually not reportable by design */
+    visit_end_list(v, NULL);
+}
+
 static void test_visitor_in_fail_union_native_list(TestInputVisitorData *data,
                                                    const void *unused)
 {
@@ -1070,6 +1110,10 @@ int main(int argc, char **argv)
                            NULL, test_visitor_in_fail_struct_in_list);
     input_visitor_test_add("/visitor/input/fail/struct-missing",
                            NULL, test_visitor_in_fail_struct_missing);
+    input_visitor_test_add("/visitor/input/fail/list",
+                           NULL, test_visitor_in_fail_list);
+    input_visitor_test_add("/visitor/input/fail/list-nested",
+                           NULL, test_visitor_in_fail_list_nested);
     input_visitor_test_add("/visitor/input/fail/union-flat",
                            NULL, test_visitor_in_fail_union_flat);
     input_visitor_test_add("/visitor/input/fail/union-flat-no-discriminator",
diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index 72f8732..70cee65 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -121,6 +121,7 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
     uint64_t expect4[] = { UINT64_MAX };
     Error *err = NULL;
     int64List *res = NULL;
+    int64List *tail;
     Visitor *v;
 
     /* Valid lists */
@@ -151,6 +152,27 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
     visit_type_int64List(v, NULL, &res, &err);
     error_free_or_abort(&err);
     g_assert(!res);
+
+    /* Unvisited list tail */
+
+    v = visitor_input_test_init(data, "0,2-3");
+
+    /* Would be simpler if the visitor genuinely supported virtual walks */
+    visit_start_list(v, NULL, (GenericList **)&res, sizeof(*res),
+                     &error_abort);
+    tail = res;
+    visit_type_int64(v, NULL, &tail->value, &error_abort);
+    g_assert_cmpint(tail->value, ==, 0);
+    tail = (int64List *)visit_next_list(v, (GenericList *)tail, sizeof(*res));
+    g_assert(tail);
+    visit_type_int64(v, NULL, &tail->value, &error_abort);
+    g_assert_cmpint(tail->value, ==, 2);
+    tail = (int64List *)visit_next_list(v, (GenericList *)tail, sizeof(*res));
+    g_assert(tail);
+    visit_end_list(v, (void **)&res);
+    /* BUG: unvisited tail not reported; actually not reportable by design */
+
+    qapi_free_int64List(res);
 }
 
 static void test_visitor_in_bool(TestInputVisitorData *data,
-- 
2.7.4

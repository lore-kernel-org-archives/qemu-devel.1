Received: from eggs.gnu.org ([2001:4830:134:3::10]:34948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ch1CZ-0007nO-Ok
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ch1CW-0004du-8T
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:45:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ch1CW-0004cb-0O
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:45:24 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2FADA7E9ED
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 21:45:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C5D3E2D653
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 21:45:23 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Feb 2017 22:45:15 +0100
Message-Id: <1487886317-27400-20-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-1-git-send-email-armbru@redhat.com>
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 19/21] tests: Cover partial input visit of list
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
---
 tests/test-opts-visitor.c          | 41 ++++++++++++++++++++++++++++++++++++++
 tests/test-qobject-input-visitor.c | 19 ++++++++++++++++++
 tests/test-string-input-visitor.c  | 19 ++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/tests/test-opts-visitor.c b/tests/test-opts-visitor.c
index 0a9e75f..58d0eb1 100644
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
+    /* Would be simpler if  opts visitor supported virtual list walks */
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
index 32c6b3d..ac87e75 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -923,6 +923,23 @@ static void test_visitor_in_fail_struct_missing(TestInputVisitorData *data,
     visit_end_struct(v, NULL);
 }
 
+static void test_visitor_in_fail_list(TestInputVisitorData *data,
+                                      const void *unused)
+{
+    int64_t i64 = -1;
+    Visitor *v;
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
 static void test_visitor_in_fail_union_native_list(TestInputVisitorData *data,
                                                    const void *unused)
 {
@@ -1070,6 +1087,8 @@ int main(int argc, char **argv)
                            NULL, test_visitor_in_fail_struct_in_list);
     input_visitor_test_add("/visitor/input/fail/struct-missing",
                            NULL, test_visitor_in_fail_struct_missing);
+    input_visitor_test_add("/visitor/input/fail/list",
+                           NULL, test_visitor_in_fail_list);
     input_visitor_test_add("/visitor/input/fail/union-flat",
                            NULL, test_visitor_in_fail_union_flat);
     input_visitor_test_add("/visitor/input/fail/union-flat-no-discriminator",
diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index 7f10e25..bb50473 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -94,6 +94,25 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
     visit_type_int16List(v, NULL, &res, &err);
     error_free_or_abort(&err);
     g_assert(!res);
+
+    v = visitor_input_test_init(data, "0,2-3");
+
+    /* Would be simpler if  opts visitor supported virtual list walks */
+    visit_start_list(v, NULL, (GenericList **)&res, sizeof(*res),
+                     &error_abort);
+    tmp = res;
+    visit_type_int16(v, NULL, &tmp->value, &error_abort);
+    g_assert_cmpint(tmp->value, ==, 0);
+    tmp = (int16List *)visit_next_list(v, (GenericList *)tmp, sizeof(*res));
+    g_assert(tmp);
+    visit_type_int16(v, NULL, &tmp->value, &error_abort);
+    g_assert_cmpint(tmp->value, ==, 2);
+    tmp = (int16List *)visit_next_list(v, (GenericList *)tmp, sizeof(*res));
+    g_assert(tmp);
+    visit_end_list(v, (void **)&res);
+    /* BUG: unvisited tail not reported; actually not reportable by design */
+
+    qapi_free_int16List(res);
 }
 
 static void test_visitor_in_bool(TestInputVisitorData *data,
-- 
2.7.4

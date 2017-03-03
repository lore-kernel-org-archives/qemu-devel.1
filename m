Received: from eggs.gnu.org ([2001:4830:134:3::10]:42574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjmOJ-0007xj-9T
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:33:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjmOG-00081z-25
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:32:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cjmOF-00080B-LW
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:32:55 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B46557FB78
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 12:32:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  3 Mar 2017 13:32:46 +0100
Message-Id: <1488544368-30622-27-git-send-email-armbru@redhat.com>
In-Reply-To: <1488544368-30622-1-git-send-email-armbru@redhat.com>
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v4 26/28] tests: Cover input visit beyond end
 of list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When you try to visit beyond the end of a list, the qobject input
visitor crashes, and the string visitor screws returns garbage.  The
generated list visits never go beyond the list end, but manual visits
could.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/test-opts-visitor.c          | 39 ++++++++++++++++++++++++++++++++++++++
 tests/test-qobject-input-visitor.c | 10 ++++++++++
 tests/test-string-input-visitor.c  | 16 ++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/tests/test-opts-visitor.c b/tests/test-opts-visitor.c
index b93fd33..2238f8e 100644
--- a/tests/test-opts-visitor.c
+++ b/tests/test-opts-visitor.c
@@ -210,6 +210,43 @@ test_opts_range_unvisited(void)
     qemu_opts_del(opts);
 }
 
+static void
+test_opts_range_beyond(void)
+{
+    Error *err = NULL;
+    intList *list = NULL;
+    intList *tail;
+    QemuOpts *opts;
+    Visitor *v;
+    int64_t val;
+
+    opts = qemu_opts_parse(qemu_find_opts("userdef"), "ilist=0", false,
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
+    tail = (intList *)visit_next_list(v, (GenericList *)tail, sizeof(*tail));
+    g_assert(!tail);
+    visit_type_int(v, NULL, &val, &err);
+    error_free_or_abort(&err);
+    visit_end_list(v, (void **)&list);
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
@@ -303,6 +340,8 @@ main(int argc, char **argv)
 
     g_test_add_func("/visitor/opts/range/unvisited",
                     test_opts_range_unvisited);
+    g_test_add_func("/visitor/opts/range/beyond",
+                    test_opts_range_beyond);
 
     g_test_run();
     return 0;
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 87d4a77..8011baa 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -948,6 +948,16 @@ static void test_visitor_in_fail_list(TestInputVisitorData *data,
     visit_check_list(v, &err);
     error_free_or_abort(&err);
     visit_end_list(v, NULL);
+
+    /* Visit beyond end of list */
+    v = visitor_input_test_init(data, "[]");
+
+    visit_start_list(v, NULL, NULL, 0, &error_abort);
+#if 0 /* FIXME crash */
+    visit_type_int(v, NULL, &i64, &err);
+    error_free_or_abort(&err);
+#endif
+    visit_end_list(v, NULL);
 }
 
 static void test_visitor_in_fail_list_nested(TestInputVisitorData *data,
diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index fbe380a..6db850b 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -123,6 +123,7 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
     int64List *res = NULL;
     int64List *tail;
     Visitor *v;
+    int64_t val;
 
     /* Valid lists */
 
@@ -175,6 +176,21 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
     visit_end_list(v, (void **)&res);
 
     qapi_free_int64List(res);
+
+    /* Visit beyond end of list */
+    v = visitor_input_test_init(data, "0");
+
+    visit_start_list(v, NULL, (GenericList **)&res, sizeof(*res),
+                     &error_abort);
+    tail = res;
+    visit_type_int64(v, NULL, &tail->value, &err);
+    g_assert_cmpint(tail->value, ==, 0);
+    visit_type_int64(v, NULL, &val, &err);
+    g_assert_cmpint(val, ==, 1); /* BUG */
+    visit_check_list(v, &error_abort);
+    visit_end_list(v, (void **)&res);
+
+    qapi_free_int64List(res);
 }
 
 static void test_visitor_in_bool(TestInputVisitorData *data,
-- 
2.7.4

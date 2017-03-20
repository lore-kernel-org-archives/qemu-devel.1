Received: from eggs.gnu.org ([2001:4830:134:3::10]:44485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpwqs-00005d-Kl
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpwqr-0005Lp-Bm
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:55:58 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 20 Mar 2017 13:55:46 +0100
Message-Id: <1490014548-15083-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1490014548-15083-1-git-send-email-armbru@redhat.com>
References: <1490014548-15083-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 3/5] test-keyval: Cover alternate and
 'any' type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/Makefile.include |  2 +-
 tests/test-keyval.c    | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 402e71c..86f9490 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -736,7 +736,7 @@ tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o $(test-util-obj-y) \
 	$(chardev-obj-y)
 tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_scm_helper.o
 tests/test-qemu-opts$(EXESUF): tests/test-qemu-opts.o $(test-util-obj-y)
-tests/test-keyval$(EXESUF): tests/test-keyval.o $(test-util-obj-y)
+tests/test-keyval$(EXESUF): tests/test-keyval.o $(test-util-obj-y) $(test-qapi-obj-y)
 tests/test-write-threshold$(EXESUF): tests/test-write-threshold.o $(test-block-obj-y)
 tests/test-netfilter$(EXESUF): tests/test-netfilter.o $(qtest-obj-y)
 tests/test-filter-mirror$(EXESUF): tests/test-filter-mirror.o $(qtest-obj-y)
diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index e97f6d5..ba19560 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-input-visitor.h"
+#include "test-qapi-visit.h"
 #include "qemu/cutils.h"
 #include "qemu/option.h"
 
@@ -608,6 +609,56 @@ static void test_keyval_visit_optional(void)
     visit_free(v);
 }
 
+static void test_keyval_visit_alternate(void)
+{
+    Error *err = NULL;
+    Visitor *v;
+    QDict *qdict;
+    AltNumStr *ans;
+    AltNumInt *ani;
+
+    /*
+     * Can't do scalar alternate variants other than string.  You get
+     * the string variant if there is one, else an error.
+     */
+    qdict = keyval_parse("a=1,b=2", NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_AltNumStr(v, "a", &ans, &error_abort);
+    g_assert_cmpint(ans->type, ==, QTYPE_QSTRING);
+    g_assert_cmpstr(ans->u.s, ==, "1");
+    visit_type_AltNumInt(v, "a", &ani, &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+}
+
+static void test_keyval_visit_any(void)
+{
+    Visitor *v;
+    QDict *qdict;
+    QObject *any;
+    QList *qlist;
+    QString *qstr;
+
+    qdict = keyval_parse("a.0=null,a.1=1", NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_any(v, "a", &any, &error_abort);
+    qlist = qobject_to_qlist(any);
+    g_assert(qlist);
+    qstr = qobject_to_qstring(qlist_pop(qlist));
+    g_assert_cmpstr(qstring_get_str(qstr), ==, "null");
+    qstr = qobject_to_qstring(qlist_pop(qlist));
+    g_assert_cmpstr(qstring_get_str(qstr), ==, "1");
+    g_assert(qlist_empty(qlist));
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+}
+
 int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
@@ -619,6 +670,8 @@ int main(int argc, char *argv[])
     g_test_add_func("/keyval/visit/dict", test_keyval_visit_dict);
     g_test_add_func("/keyval/visit/list", test_keyval_visit_list);
     g_test_add_func("/keyval/visit/optional", test_keyval_visit_optional);
+    g_test_add_func("/keyval/visit/alternate", test_keyval_visit_alternate);
+    g_test_add_func("/keyval/visit/any", test_keyval_visit_any);
     g_test_run();
     return 0;
 }
-- 
2.7.4

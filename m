Received: from eggs.gnu.org ([2001:4830:134:3::10]:59088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIX-0002an-2t
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIT-0004Qq-VL
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cepIT-0004Pf-MR
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:29 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB81AC05AA48
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:38:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1HKcSVU005386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 15:38:29 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Feb 2017 21:38:18 +0100
Message-Id: <1487363905-9480-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-1-git-send-email-armbru@redhat.com>
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 07/14] Don't check qobject_type() before
 qobject_to_qdict()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qobject_to_qdict(obj) returns NULL when obj isn't a QDict.  Check
that instead of qobject_type(obj) == QTYPE_QDICT.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block.c                             |  4 ++--
 hw/pci/pcie_aer.c                   |  2 +-
 monitor.c                           | 10 ++++-----
 qapi/qmp-dispatch.c                 |  5 ++---
 tests/check-qdict.c                 |  9 ++------
 tests/test-qobject-output-visitor.c | 41 +++++++++++--------------------------
 6 files changed, 24 insertions(+), 47 deletions(-)

diff --git a/block.c b/block.c
index 743c349..3c36af5 100644
--- a/block.c
+++ b/block.c
@@ -1169,13 +1169,13 @@ static QDict *parse_json_filename(const char *filename, Error **errp)
         return NULL;
     }
 
-    if (qobject_type(options_obj) != QTYPE_QDICT) {
+    options = qobject_to_qdict(options_obj);
+    if (!options) {
         qobject_decref(options_obj);
         error_setg(errp, "Invalid JSON object given");
         return NULL;
     }
 
-    options = qobject_to_qdict(options_obj);
     qdict_flatten(options);
 
     return options;
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index daf1f65..a8c1820 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -1025,8 +1025,8 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    assert(qobject_type(data) == QTYPE_QDICT);
     qdict = qobject_to_qdict(data);
+    assert(qdict);
 
     devfn = (int)qdict_get_int(qdict, "devfn");
     monitor_printf(mon, "OK id: %s root bus: %s, bus: %x devfn: %x.%x\n",
diff --git a/monitor.c b/monitor.c
index 3cd72a9..493bed9 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3686,12 +3686,12 @@ static QDict *qmp_check_input_obj(QObject *input_obj, Error **errp)
     int has_exec_key = 0;
     QDict *input_dict;
 
-    if (qobject_type(input_obj) != QTYPE_QDICT) {
-        error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT, "object");
-        return NULL;
-    }
-
     input_dict = qobject_to_qdict(input_obj);
+    if (!input_dict) {
+        error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT, "object");
+        return NULL;
+    }
+
 
     for (ent = qdict_first(input_dict); ent; ent = qdict_next(input_dict, ent)){
         const char *arg_name = qdict_entry_key(ent);
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 505eb41..48bec20 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -28,14 +28,13 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
     bool has_exec_key = false;
     QDict *dict = NULL;
 
-    if (qobject_type(request) != QTYPE_QDICT) {
+    dict = qobject_to_qdict(request);
+    if (!dict) {
         error_setg(errp, QERR_QMP_BAD_INPUT_OBJECT,
                    "request is not a dictionary");
         return NULL;
     }
 
-    dict = qobject_to_qdict(request);
-
     for (ent = qdict_first(dict); ent;
          ent = qdict_next(dict, ent)) {
         arg_name = qdict_entry_key(ent);
diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index ded3a26..81162ee 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -591,7 +591,6 @@ static void qdict_join_test(void)
 static void qdict_crumple_test_recursive(void)
 {
     QDict *src, *dst, *rule, *vnc, *acl, *listen;
-    QObject *res;
     QList *rules;
 
     src = qdict_new();
@@ -605,12 +604,8 @@ static void qdict_crumple_test_recursive(void)
     qdict_put(src, "vnc.acl..name", qstring_from_str("acl0"));
     qdict_put(src, "vnc.acl.rule..name", qstring_from_str("acl0"));
 
-    res = qdict_crumple(src, &error_abort);
-
-    g_assert_cmpint(qobject_type(res), ==, QTYPE_QDICT);
-
-    dst = qobject_to_qdict(res);
-
+    dst = qobject_to_qdict(qdict_crumple(src, &error_abort));
+    g_assert(dst);
     g_assert_cmpint(qdict_size(dst), ==, 1);
 
     vnc = qdict_get_qdict(dst, "vnc");
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index 4e2d79c..a874386 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -160,15 +160,12 @@ static void test_visitor_out_struct(TestOutputVisitorData *data,
                                .boolean = false,
                                .string = (char *) "foo"};
     TestStruct *p = &test_struct;
-    QObject *obj;
     QDict *qdict;
 
     visit_type_TestStruct(data->ov, NULL, &p, &error_abort);
 
-    obj = visitor_get(data);
-    g_assert(qobject_type(obj) == QTYPE_QDICT);
-
-    qdict = qobject_to_qdict(obj);
+    qdict = qobject_to_qdict(visitor_get(data));
+    g_assert(qdict);
     g_assert_cmpint(qdict_size(qdict), ==, 3);
     g_assert_cmpint(qdict_get_int(qdict, "integer"), ==, 42);
     g_assert_cmpint(qdict_get_bool(qdict, "boolean"), ==, false);
@@ -180,7 +177,6 @@ static void test_visitor_out_struct_nested(TestOutputVisitorData *data,
 {
     int64_t value = 42;
     UserDefTwo *ud2;
-    QObject *obj;
     QDict *qdict, *dict1, *dict2, *dict3, *userdef;
     const char *string = "user def string";
     const char *strings[] = { "forty two", "forty three", "forty four",
@@ -207,10 +203,8 @@ static void test_visitor_out_struct_nested(TestOutputVisitorData *data,
 
     visit_type_UserDefTwo(data->ov, "unused", &ud2, &error_abort);
 
-    obj = visitor_get(data);
-    g_assert(qobject_type(obj) == QTYPE_QDICT);
-
-    qdict = qobject_to_qdict(obj);
+    qdict = qobject_to_qdict(visitor_get(data));
+    g_assert(qdict);
     g_assert_cmpint(qdict_size(qdict), ==, 2);
     g_assert_cmpstr(qdict_get_str(qdict, "string0"), ==, strings[0]);
 
@@ -296,8 +290,8 @@ static void test_visitor_out_list(TestOutputVisitorData *data,
     QLIST_FOREACH_ENTRY(qlist, entry) {
         QDict *qdict;
 
-        g_assert(qobject_type(entry->value) == QTYPE_QDICT);
         qdict = qobject_to_qdict(entry->value);
+        g_assert(qdict);
         g_assert_cmpint(qdict_size(qdict), ==, 3);
         g_assert_cmpint(qdict_get_int(qdict, "integer"), ==, value_int + i);
         g_assert_cmpint(qdict_get_bool(qdict, "boolean"), ==, value_bool);
@@ -362,8 +356,7 @@ static void test_visitor_out_any(TestOutputVisitorData *data,
     qobj = QOBJECT(qdict);
     visit_type_any(data->ov, NULL, &qobj, &error_abort);
     qobject_decref(qobj);
-    obj = visitor_get(data);
-    qdict = qobject_to_qdict(obj);
+    qdict = qobject_to_qdict(visitor_get(data));
     g_assert(qdict);
     qobj = qdict_get(qdict, "integer");
     g_assert(qobj);
@@ -385,7 +378,6 @@ static void test_visitor_out_any(TestOutputVisitorData *data,
 static void test_visitor_out_union_flat(TestOutputVisitorData *data,
                                         const void *unused)
 {
-    QObject *arg;
     QDict *qdict;
 
     UserDefFlatUnion *tmp = g_malloc0(sizeof(UserDefFlatUnion));
@@ -395,11 +387,8 @@ static void test_visitor_out_union_flat(TestOutputVisitorData *data,
     tmp->u.value1.boolean = true;
 
     visit_type_UserDefFlatUnion(data->ov, NULL, &tmp, &error_abort);
-    arg = visitor_get(data);
-
-    g_assert(qobject_type(arg) == QTYPE_QDICT);
-    qdict = qobject_to_qdict(arg);
-
+    qdict = qobject_to_qdict(visitor_get(data));
+    g_assert(qdict);
     g_assert_cmpstr(qdict_get_str(qdict, "enum1"), ==, "value1");
     g_assert_cmpstr(qdict_get_str(qdict, "string"), ==, "str");
     g_assert_cmpint(qdict_get_int(qdict, "integer"), ==, 41);
@@ -449,10 +438,8 @@ static void test_visitor_out_alternate(TestOutputVisitorData *data,
     tmp->u.udfu.u.value1.boolean = true;
 
     visit_type_UserDefAlternate(data->ov, NULL, &tmp, &error_abort);
-    arg = visitor_get(data);
-
-    g_assert_cmpint(qobject_type(arg), ==, QTYPE_QDICT);
-    qdict = qobject_to_qdict(arg);
+    qdict = qobject_to_qdict(visitor_get(data));
+    g_assert(qdict);
     g_assert_cmpint(qdict_size(qdict), ==, 4);
     g_assert_cmpint(qdict_get_int(qdict, "integer"), ==, 1);
     g_assert_cmpstr(qdict_get_str(qdict, "string"), ==, "str");
@@ -465,7 +452,6 @@ static void test_visitor_out_alternate(TestOutputVisitorData *data,
 static void test_visitor_out_null(TestOutputVisitorData *data,
                                   const void *unused)
 {
-    QObject *arg;
     QDict *qdict;
     QObject *nil;
 
@@ -473,9 +459,8 @@ static void test_visitor_out_null(TestOutputVisitorData *data,
     visit_type_null(data->ov, "a", &error_abort);
     visit_check_struct(data->ov, &error_abort);
     visit_end_struct(data->ov, NULL);
-    arg = visitor_get(data);
-    g_assert(qobject_type(arg) == QTYPE_QDICT);
-    qdict = qobject_to_qdict(arg);
+    qdict = qobject_to_qdict(visitor_get(data));
+    g_assert(qdict);
     g_assert_cmpint(qdict_size(qdict), ==, 1);
     nil = qdict_get(qdict, "a");
     g_assert(nil);
@@ -618,8 +603,6 @@ static void check_native_list(QObject *qobj,
     QList *qlist;
     int i;
 
-    g_assert(qobj);
-    g_assert(qobject_type(qobj) == QTYPE_QDICT);
     qdict = qobject_to_qdict(qobj);
     g_assert(qdict);
     g_assert(qdict_haskey(qdict, "data"));
-- 
2.7.4

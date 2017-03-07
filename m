Received: from eggs.gnu.org ([2001:4830:134:3::10]:44391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cl9QK-0001XQ-BZ
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cl9QH-000680-9N
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:20:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cl9QG-00067O-Vw
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:20:41 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34AB97F081
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 07:20:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  7 Mar 2017 08:20:17 +0100
Message-Id: <1488871237-12332-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1488871237-12332-1-git-send-email-armbru@redhat.com>
References: <1488871237-12332-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v3 04/24] qapi: qobject input visitor variant
 for use with keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Daniel P. Berrange" <berrange@redhat.com>

Currently the QObjectInputVisitor assumes that all scalar values are
directly represented as the final types declared by the thing being
visited. i.e. it assumes an 'int' is using QInt, and a 'bool' is using
QBool, etc.  This is good when QObjectInputVisitor is fed a QObject
that came from a JSON document on the QMP monitor, as it will strictly
validate correctness.

To allow QObjectInputVisitor to be reused for visiting a QObject
originating from keyval_parse(), an alternative mode is needed where
all the scalars types are represented as QString and converted on the
fly to the final desired type.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <1475246744-29302-8-git-send-email-berrange@redhat.com>

Rebased, conflicts resolved, commit message updated to refer to
keyval_parse().  autocast replaced by keyval in identifiers,
noautocast replaced by fail in tests.

Fix qobject_input_type_uint64_keyval() not to reject '-', for QemuOpts
compatibility: replace parse_uint_full() by open-coded
parse_option_number().  The next commit will add suitable tests.
Leave out the fancy ERANGE error reporting for now, but add a TODO
comment.  Add it qobject_input_type_int64_keyval() and
qobject_input_type_number_keyval(), too.

Open code parse_option_bool() and parse_option_size() so we have to
call qobject_input_get_name() only when actually needed.  Again, leave
out ERANGE error reporting for now.

QAPI/QMP downstream extension prefixes __RFQDN_ don't work, because
keyval_parse() splits them at '.'.  This will be addressed later in
the series.

qobject_input_type_int64_keyval(), qobject_input_type_uint64_keyval(),
qobject_input_type_number_keyval() tweaked for style.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <1488317230-26248-5-git-send-email-armbru@redhat.com>
---
 include/qapi/qobject-input-visitor.h |   9 ++
 qapi/qobject-input-visitor.c         | 166 ++++++++++++++++++++++++++++++-
 tests/test-qobject-input-visitor.c   | 188 ++++++++++++++++++++++++++++++++++-
 3 files changed, 358 insertions(+), 5 deletions(-)

diff --git a/include/qapi/qobject-input-visitor.h b/include/qapi/qobject-input-visitor.h
index 0b7633a..282f9d2 100644
--- a/include/qapi/qobject-input-visitor.h
+++ b/include/qapi/qobject-input-visitor.h
@@ -59,4 +59,13 @@ typedef struct QObjectInputVisitor QObjectInputVisitor;
  */
 Visitor *qobject_input_visitor_new(QObject *obj);
 
+/*
+ * Create a QObject input visitor for @obj for use with keyval_parse()
+ *
+ * This is like qobject_input_visitor_new(), except scalars are all
+ * QString, and error messages refer to parts of @obj in the syntax
+ * keyval_parse() uses for KEYs.
+ */
+Visitor *qobject_input_visitor_new_keyval(QObject *obj);
+
 #endif
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index d192727..e2e3e70 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -1,7 +1,7 @@
 /*
  * Input Visitor
  *
- * Copyright (C) 2012-2016 Red Hat, Inc.
+ * Copyright (C) 2012-2017 Red Hat, Inc.
  * Copyright IBM, Corp. 2011
  *
  * Authors:
@@ -20,6 +20,7 @@
 #include "qemu-common.h"
 #include "qapi/qmp/types.h"
 #include "qapi/qmp/qerror.h"
+#include "qemu/cutils.h"
 
 typedef struct StackObject {
     const char *name;            /* Name of @obj in its parent, if any */
@@ -337,6 +338,31 @@ static void qobject_input_type_int64(Visitor *v, const char *name, int64_t *obj,
     *obj = qint_get_int(qint);
 }
 
+
+static void qobject_input_type_int64_keyval(Visitor *v, const char *name,
+                                            int64_t *obj, Error **errp)
+{
+    QObjectInputVisitor *qiv = to_qiv(v);
+    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QString *qstr;
+
+    if (!qobj) {
+        return;
+    }
+    qstr = qobject_to_qstring(qobj);
+    if (!qstr) {
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
+                   full_name(qiv, name), "string");
+        return;
+    }
+
+    if (qemu_strtoi64(qstring_get_str(qstr), NULL, 0, obj) < 0) {
+        /* TODO report -ERANGE more nicely */
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   full_name(qiv, name), "integer");
+    }
+}
+
 static void qobject_input_type_uint64(Visitor *v, const char *name,
                                       uint64_t *obj, Error **errp)
 {
@@ -358,6 +384,30 @@ static void qobject_input_type_uint64(Visitor *v, const char *name,
     *obj = qint_get_int(qint);
 }
 
+static void qobject_input_type_uint64_keyval(Visitor *v, const char *name,
+                                             uint64_t *obj, Error **errp)
+{
+    QObjectInputVisitor *qiv = to_qiv(v);
+    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QString *qstr;
+
+    if (!qobj) {
+        return;
+    }
+    qstr = qobject_to_qstring(qobj);
+    if (!qstr) {
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
+                   full_name(qiv, name), "string");
+        return;
+    }
+
+    if (qemu_strtou64(qstring_get_str(qstr), NULL, 0, obj) < 0) {
+        /* TODO report -ERANGE more nicely */
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   full_name(qiv, name), "integer");
+    }
+}
+
 static void qobject_input_type_bool(Visitor *v, const char *name, bool *obj,
                                     Error **errp)
 {
@@ -378,6 +428,35 @@ static void qobject_input_type_bool(Visitor *v, const char *name, bool *obj,
     *obj = qbool_get_bool(qbool);
 }
 
+static void qobject_input_type_bool_keyval(Visitor *v, const char *name,
+                                           bool *obj, Error **errp)
+{
+    QObjectInputVisitor *qiv = to_qiv(v);
+    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QString *qstr;
+    const char *str;
+
+    if (!qobj) {
+        return;
+    }
+    qstr = qobject_to_qstring(qobj);
+    if (!qstr) {
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
+                   full_name(qiv, name), "string");
+        return;
+    }
+
+    str = qstring_get_str(qstr);
+    if (!strcmp(str, "on")) {
+        *obj = true;
+    } else if (!strcmp(str, "off")) {
+        *obj = false;
+    } else {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   full_name(qiv, name), "'on' or 'off'");
+    }
+}
+
 static void qobject_input_type_str(Visitor *v, const char *name, char **obj,
                                    Error **errp)
 {
@@ -426,6 +505,35 @@ static void qobject_input_type_number(Visitor *v, const char *name, double *obj,
                full_name(qiv, name), "number");
 }
 
+static void qobject_input_type_number_keyval(Visitor *v, const char *name,
+                                             double *obj, Error **errp)
+{
+    QObjectInputVisitor *qiv = to_qiv(v);
+    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QString *qstr;
+    const char *str;
+    char *endp;
+
+    if (!qobj) {
+        return;
+    }
+    qstr = qobject_to_qstring(qobj);
+    if (!qstr) {
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
+                   full_name(qiv, name), "string");
+        return;
+    }
+
+    str = qstring_get_str(qstr);
+    errno = 0;
+    *obj = strtod(str, &endp);
+    if (errno || endp == str || *endp) {
+        /* TODO report -ERANGE more nicely */
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
+                   full_name(qiv, name), "number");
+    }
+}
+
 static void qobject_input_type_any(Visitor *v, const char *name, QObject **obj,
                                    Error **errp)
 {
@@ -456,6 +564,30 @@ static void qobject_input_type_null(Visitor *v, const char *name, Error **errp)
     }
 }
 
+static void qobject_input_type_size_keyval(Visitor *v, const char *name,
+                                           uint64_t *obj, Error **errp)
+{
+    QObjectInputVisitor *qiv = to_qiv(v);
+    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QString *qstr;
+
+    if (!qobj) {
+        return;
+    }
+    qstr = qobject_to_qstring(qobj);
+    if (!qstr) {
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
+                   full_name(qiv, name), "string");
+        return;
+    }
+
+    if (qemu_strtosz(qstring_get_str(qstr), NULL, obj) < 0) {
+        /* TODO report -ERANGE more nicely */
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   full_name(qiv, name), "size");
+    }
+}
+
 static void qobject_input_optional(Visitor *v, const char *name, bool *present)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
@@ -518,3 +650,35 @@ Visitor *qobject_input_visitor_new(QObject *obj)
 
     return &v->visitor;
 }
+
+Visitor *qobject_input_visitor_new_keyval(QObject *obj)
+{
+    QObjectInputVisitor *v;
+
+    v = g_malloc0(sizeof(*v));
+
+    v->visitor.type = VISITOR_INPUT;
+    v->visitor.start_struct = qobject_input_start_struct;
+    v->visitor.check_struct = qobject_input_check_struct;
+    v->visitor.end_struct = qobject_input_pop;
+    v->visitor.start_list = qobject_input_start_list;
+    v->visitor.next_list = qobject_input_next_list;
+    v->visitor.check_list = qobject_input_check_list;
+    v->visitor.end_list = qobject_input_pop;
+    v->visitor.start_alternate = qobject_input_start_alternate;
+    v->visitor.type_int64 = qobject_input_type_int64_keyval;
+    v->visitor.type_uint64 = qobject_input_type_uint64_keyval;
+    v->visitor.type_bool = qobject_input_type_bool_keyval;
+    v->visitor.type_str = qobject_input_type_str;
+    v->visitor.type_number = qobject_input_type_number_keyval;
+    v->visitor.type_any = qobject_input_type_any;
+    v->visitor.type_null = qobject_input_type_null;
+    v->visitor.type_size = qobject_input_type_size_keyval;
+    v->visitor.optional = qobject_input_optional;
+    v->visitor.free = qobject_input_free;
+
+    v->root = obj;
+    qobject_incref(obj);
+
+    return &v->visitor;
+}
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 94305f5..32ba492 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -45,6 +45,7 @@ static void visitor_input_teardown(TestInputVisitorData *data,
    function so that the JSON string used by the tests are kept in the test
    functions (and not in main()). */
 static Visitor *visitor_input_test_init_internal(TestInputVisitorData *data,
+                                                 bool keyval,
                                                  const char *json_string,
                                                  va_list *ap)
 {
@@ -53,11 +54,29 @@ static Visitor *visitor_input_test_init_internal(TestInputVisitorData *data,
     data->obj = qobject_from_jsonv(json_string, ap);
     g_assert(data->obj);
 
-    data->qiv = qobject_input_visitor_new(data->obj);
+    if (keyval) {
+        data->qiv = qobject_input_visitor_new_keyval(data->obj);
+    } else {
+        data->qiv = qobject_input_visitor_new(data->obj);
+    }
     g_assert(data->qiv);
     return data->qiv;
 }
 
+static GCC_FMT_ATTR(3, 4)
+Visitor *visitor_input_test_init_full(TestInputVisitorData *data,
+                                      bool keyval,
+                                      const char *json_string, ...)
+{
+    Visitor *v;
+    va_list ap;
+
+    va_start(ap, json_string);
+    v = visitor_input_test_init_internal(data, keyval, json_string, &ap);
+    va_end(ap);
+    return v;
+}
+
 static GCC_FMT_ATTR(2, 3)
 Visitor *visitor_input_test_init(TestInputVisitorData *data,
                                  const char *json_string, ...)
@@ -66,7 +85,7 @@ Visitor *visitor_input_test_init(TestInputVisitorData *data,
     va_list ap;
 
     va_start(ap, json_string);
-    v = visitor_input_test_init_internal(data, json_string, &ap);
+    v = visitor_input_test_init_internal(data, false, json_string, &ap);
     va_end(ap);
     return v;
 }
@@ -81,7 +100,7 @@ Visitor *visitor_input_test_init(TestInputVisitorData *data,
 static Visitor *visitor_input_test_init_raw(TestInputVisitorData *data,
                                             const char *json_string)
 {
-    return visitor_input_test_init_internal(data, json_string, NULL);
+    return visitor_input_test_init_internal(data, false, json_string, NULL);
 }
 
 static void test_visitor_in_int(TestInputVisitorData *data,
@@ -114,6 +133,43 @@ static void test_visitor_in_int_overflow(TestInputVisitorData *data,
     error_free_or_abort(&err);
 }
 
+static void test_visitor_in_int_keyval(TestInputVisitorData *data,
+                                       const void *unused)
+{
+    int64_t res = 0, value = -42;
+    Error *err = NULL;
+    Visitor *v;
+
+    v = visitor_input_test_init_full(data, true, "%" PRId64, value);
+    visit_type_int(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+}
+
+static void test_visitor_in_int_str_keyval(TestInputVisitorData *data,
+                                           const void *unused)
+{
+    int64_t res = 0, value = -42;
+    Visitor *v;
+
+    v = visitor_input_test_init_full(data, true, "\"-42\"");
+
+    visit_type_int(v, NULL, &res, &error_abort);
+    g_assert_cmpint(res, ==, value);
+}
+
+static void test_visitor_in_int_str_fail(TestInputVisitorData *data,
+                                         const void *unused)
+{
+    int64_t res = 0;
+    Visitor *v;
+    Error *err = NULL;
+
+    v = visitor_input_test_init(data, "\"-42\"");
+
+    visit_type_int(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+}
+
 static void test_visitor_in_bool(TestInputVisitorData *data,
                                  const void *unused)
 {
@@ -126,6 +182,44 @@ static void test_visitor_in_bool(TestInputVisitorData *data,
     g_assert_cmpint(res, ==, true);
 }
 
+static void test_visitor_in_bool_keyval(TestInputVisitorData *data,
+                                        const void *unused)
+{
+    bool res = false;
+    Error *err = NULL;
+    Visitor *v;
+
+    v = visitor_input_test_init_full(data, true, "true");
+
+    visit_type_bool(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+}
+
+static void test_visitor_in_bool_str_keyval(TestInputVisitorData *data,
+                                            const void *unused)
+{
+    bool res = false;
+    Visitor *v;
+
+    v = visitor_input_test_init_full(data, true, "\"on\"");
+
+    visit_type_bool(v, NULL, &res, &error_abort);
+    g_assert_cmpint(res, ==, true);
+}
+
+static void test_visitor_in_bool_str_fail(TestInputVisitorData *data,
+                                          const void *unused)
+{
+    bool res = false;
+    Visitor *v;
+    Error *err = NULL;
+
+    v = visitor_input_test_init(data, "\"true\"");
+
+    visit_type_bool(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+}
+
 static void test_visitor_in_number(TestInputVisitorData *data,
                                    const void *unused)
 {
@@ -138,6 +232,69 @@ static void test_visitor_in_number(TestInputVisitorData *data,
     g_assert_cmpfloat(res, ==, value);
 }
 
+static void test_visitor_in_number_keyval(TestInputVisitorData *data,
+                                          const void *unused)
+{
+    double res = 0, value = 3.14;
+    Error *err = NULL;
+    Visitor *v;
+
+    v = visitor_input_test_init_full(data, true, "%f", value);
+
+    visit_type_number(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+}
+
+static void test_visitor_in_number_str_keyval(TestInputVisitorData *data,
+                                              const void *unused)
+{
+    double res = 0, value = 3.14;
+    Visitor *v;
+
+    v = visitor_input_test_init_full(data, true, "\"3.14\"");
+
+    visit_type_number(v, NULL, &res, &error_abort);
+    g_assert_cmpfloat(res, ==, value);
+}
+
+static void test_visitor_in_number_str_fail(TestInputVisitorData *data,
+                                            const void *unused)
+{
+    double res = 0;
+    Visitor *v;
+    Error *err = NULL;
+
+    v = visitor_input_test_init(data, "\"3.14\"");
+
+    visit_type_number(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+}
+
+static void test_visitor_in_size_str_keyval(TestInputVisitorData *data,
+                                            const void *unused)
+{
+    uint64_t res, value = 500 * 1024 * 1024;
+    Visitor *v;
+
+    v = visitor_input_test_init_full(data, true, "\"500M\"");
+
+    visit_type_size(v, NULL, &res, &error_abort);
+    g_assert_cmpfloat(res, ==, value);
+}
+
+static void test_visitor_in_size_str_fail(TestInputVisitorData *data,
+                                          const void *unused)
+{
+    uint64_t res = 0;
+    Visitor *v;
+    Error *err = NULL;
+
+    v = visitor_input_test_init(data, "\"500M\"");
+
+    visit_type_size(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+}
+
 static void test_visitor_in_string(TestInputVisitorData *data,
                                    const void *unused)
 {
@@ -294,7 +451,8 @@ static void test_visitor_in_null(TestInputVisitorData *data,
      * when input is not null.
      */
 
-    v = visitor_input_test_init(data, "{ 'a': null, 'b': '', 'c': null }");
+    v = visitor_input_test_init_full(data, false,
+                                     "{ 'a': null, 'b': '' }");
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_null(v, "a", &error_abort);
     visit_type_null(v, "b", &err);
@@ -1069,10 +1227,32 @@ int main(int argc, char **argv)
                            NULL, test_visitor_in_int);
     input_visitor_test_add("/visitor/input/int_overflow",
                            NULL, test_visitor_in_int_overflow);
+    input_visitor_test_add("/visitor/input/int_keyval",
+                           NULL, test_visitor_in_int_keyval);
+    input_visitor_test_add("/visitor/input/int_str_keyval",
+                           NULL, test_visitor_in_int_str_keyval);
+    input_visitor_test_add("/visitor/input/int_str_fail",
+                           NULL, test_visitor_in_int_str_fail);
     input_visitor_test_add("/visitor/input/bool",
                            NULL, test_visitor_in_bool);
+    input_visitor_test_add("/visitor/input/bool_keyval",
+                           NULL, test_visitor_in_bool_keyval);
+    input_visitor_test_add("/visitor/input/bool_str_keyval",
+                           NULL, test_visitor_in_bool_str_keyval);
+    input_visitor_test_add("/visitor/input/bool_str_fail",
+                           NULL, test_visitor_in_bool_str_fail);
     input_visitor_test_add("/visitor/input/number",
                            NULL, test_visitor_in_number);
+    input_visitor_test_add("/visitor/input/number_keyval",
+                           NULL, test_visitor_in_number_keyval);
+    input_visitor_test_add("/visitor/input/number_str_keyval",
+                           NULL, test_visitor_in_number_str_keyval);
+    input_visitor_test_add("/visitor/input/number_str_fail",
+                           NULL, test_visitor_in_number_str_fail);
+    input_visitor_test_add("/visitor/input/size_str_keyval",
+                           NULL, test_visitor_in_size_str_keyval);
+    input_visitor_test_add("/visitor/input/size_str_fail",
+                           NULL, test_visitor_in_size_str_fail);
     input_visitor_test_add("/visitor/input/string",
                            NULL, test_visitor_in_string);
     input_visitor_test_add("/visitor/input/enum",
-- 
2.7.4

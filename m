Received: from eggs.gnu.org ([2001:4830:134:3::10]:38784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgHZR-0005Hu-IP
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:02:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgHZO-0006fA-Nd
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:02:01 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 22:01:46 +0100
Message-Id: <1487710908-26356-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1487710908-26356-1-git-send-email-armbru@redhat.com>
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v3 3/5] qapi: Permit scalar type
 conversions in QObjectInputVisitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>

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
keyval_parse().

Control flow in qobject_input_type_number_autocast() simplified.

Additional tests in test-qemu-opts.c to verify QemuOpts compatibility.
To make the tests pass, use qemu_strtou64() instead of
parse_uint_full().

Use qemu_strtou64() and qemu_strtosz() instead of
parse_option_number() and parse_option_size() so we have to call
qobject_input_get_name() only when actually needed.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qobject-input-visitor.h |  32 ++++-
 qapi/qobject-input-visitor.c         | 165 ++++++++++++++++++++++++
 tests/test-keyval.c                  | 241 +++++++++++++++++++++++++++++++++++
 tests/test-qobject-input-visitor.c   | 194 +++++++++++++++++++++++++++-
 4 files changed, 624 insertions(+), 8 deletions(-)

diff --git a/include/qapi/qobject-input-visitor.h b/include/qapi/qobject-input-visitor.h
index cde328d..5022297 100644
--- a/include/qapi/qobject-input-visitor.h
+++ b/include/qapi/qobject-input-visitor.h
@@ -19,12 +19,36 @@
 
 typedef struct QObjectInputVisitor QObjectInputVisitor;
 
-/*
- * Return a new input visitor that converts a QObject to a QAPI object.
+/**
+ * Create a new input visitor that converts @obj to a QAPI object.
  *
- * Set @strict to reject a parse that doesn't consume all keys of a
- * dictionary; otherwise excess input is ignored.
+ * Any scalar values in the @obj input data structure should be in the
+ * required type already. i.e. if visiting a bool, the value should
+ * already be a QBool instance.
+ *
+ * If @strict is set to true, then an error will be reported if any
+ * dict keys are not consumed during visitation. If @strict is false
+ * then extra dict keys are silently ignored.
+ *
+ * The returned input visitor should be released by calling
+ * visit_free() when no longer required.
  */
 Visitor *qobject_input_visitor_new(QObject *obj, bool strict);
 
+/**
+ * Create a new input visitor that converts @obj to a QAPI object.
+ *
+ * Any scalar values in the @obj input data structure should always be
+ * represented as strings. i.e. if visiting a boolean, the value should
+ * be a QString whose contents represent a valid boolean.
+ *
+ * The visitor always operates in strict mode, requiring all dict keys
+ * to be consumed during visitation. An error will be reported if this
+ * does not happen.
+ *
+ * The returned input visitor should be released by calling
+ * visit_free() when no longer required.
+ */
+Visitor *qobject_input_visitor_new_autocast(QObject *obj);
+
 #endif
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 2439f1a..0bf6849 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -20,6 +20,7 @@
 #include "qemu-common.h"
 #include "qapi/qmp/types.h"
 #include "qapi/qmp/qerror.h"
+#include "qemu/cutils.h"
 
 typedef struct StackObject {
     const char *name;        /* Name if parent is QDict */
@@ -71,6 +72,7 @@ static const char *qobject_input_get_name(QObjectInputVisitor *qiv,
             g_string_prepend(qiv->errname, name);
             g_string_prepend_c(qiv->errname, '.');
         } else {
+            /* TODO needs to be .%zu for autocast */
             snprintf(buf, sizeof(buf), "[%zu]", so->index);
             g_string_prepend(qiv->errname, buf);
         }
@@ -321,6 +323,31 @@ static void qobject_input_type_int64(Visitor *v, const char *name, int64_t *obj,
     *obj = qint_get_int(qint);
 }
 
+
+static void qobject_input_type_int64_autocast(Visitor *v, const char *name,
+                                              int64_t *obj, Error **errp)
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
+                   qobject_input_get_name(qiv, name), "string");
+        return;
+    }
+
+    if (qemu_strtoi64(qstring_get_str(qstr), NULL, 0, obj) < 0) {
+        /* TODO report -ERANGE more nicely */
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   qobject_input_get_name(qiv, name), "integer");
+    }
+}
+
 static void qobject_input_type_uint64(Visitor *v, const char *name,
                                       uint64_t *obj, Error **errp)
 {
@@ -342,6 +369,30 @@ static void qobject_input_type_uint64(Visitor *v, const char *name,
     *obj = qint_get_int(qint);
 }
 
+static void qobject_input_type_uint64_autocast(Visitor *v, const char *name,
+                                               uint64_t *obj, Error **errp)
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
+                   qobject_input_get_name(qiv, name), "string");
+        return;
+    }
+
+    if (qemu_strtou64(qstring_get_str(qstr), NULL, 0, obj) < 0) {
+        /* TODO report -ERANGE more nicely */
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   qobject_input_get_name(qiv, name), "integer");
+    }
+}
+
 static void qobject_input_type_bool(Visitor *v, const char *name, bool *obj,
                                     Error **errp)
 {
@@ -362,6 +413,35 @@ static void qobject_input_type_bool(Visitor *v, const char *name, bool *obj,
     *obj = qbool_get_bool(qbool);
 }
 
+static void qobject_input_type_bool_autocast(Visitor *v, const char *name,
+                                             bool *obj, Error **errp)
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
+                   qobject_input_get_name(qiv, name), "string");
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
+                   qobject_input_get_name(qiv, name), "'on' or 'off'");
+    }
+}
+
 static void qobject_input_type_str(Visitor *v, const char *name, char **obj,
                                    Error **errp)
 {
@@ -410,6 +490,35 @@ static void qobject_input_type_number(Visitor *v, const char *name, double *obj,
                qobject_input_get_name(qiv, name), "number");
 }
 
+static void qobject_input_type_number_autocast(Visitor *v, const char *name,
+                                               double *obj, Error **errp)
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
+                   qobject_input_get_name(qiv, name), "string");
+        return;
+    }
+
+    str = qstring_get_str(qstr);
+    errno = 0;
+    *obj = strtod(str, &endp);
+    if (errno || endp == str || *endp) {
+        /* TODO report -ERANGE more nicely */
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
+                   qobject_input_get_name(qiv, name), "number");
+    }
+}
+
 static void qobject_input_type_any(Visitor *v, const char *name, QObject **obj,
                                    Error **errp)
 {
@@ -440,6 +549,30 @@ static void qobject_input_type_null(Visitor *v, const char *name, Error **errp)
     }
 }
 
+static void qobject_input_type_size_autocast(Visitor *v, const char *name,
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
+                   qobject_input_get_name(qiv, name), "string");
+        return;
+    }
+
+    if (qemu_strtosz(qstring_get_str(qstr), NULL, obj) < 0) {
+        /* TODO report -ERANGE more nicely */
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   qobject_input_get_name(qiv, name), "size");
+    }
+}
+
 static void qobject_input_optional(Visitor *v, const char *name, bool *present)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
@@ -502,3 +635,35 @@ Visitor *qobject_input_visitor_new(QObject *obj, bool strict)
 
     return &v->visitor;
 }
+
+Visitor *qobject_input_visitor_new_autocast(QObject *obj)
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
+    v->visitor.end_list = qobject_input_pop;
+    v->visitor.start_alternate = qobject_input_start_alternate;
+    v->visitor.type_int64 = qobject_input_type_int64_autocast;
+    v->visitor.type_uint64 = qobject_input_type_uint64_autocast;
+    v->visitor.type_bool = qobject_input_type_bool_autocast;
+    v->visitor.type_str = qobject_input_type_str;
+    v->visitor.type_number = qobject_input_type_number_autocast;
+    v->visitor.type_any = qobject_input_type_any;
+    v->visitor.type_null = qobject_input_type_null;
+    v->visitor.type_size = qobject_input_type_size_autocast;
+    v->visitor.optional = qobject_input_optional;
+    v->visitor.free = qobject_input_free;
+    v->strict = true;
+
+    v->root = obj;
+    qobject_incref(obj);
+
+    return &v->visitor;
+}
diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index 91b4391..116ff2e 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -12,7 +12,9 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qobject-input-visitor.h"
 #include "qemu/option.h"
+#include "qemu/cutils.h"
 
 static void test_keyval_parse(void)
 {
@@ -145,10 +147,249 @@ static void test_keyval_parse(void)
     QDECREF(qdict);
 }
 
+static void test_parse_visit_bool(void)
+{
+    Error *err = NULL;
+    Visitor *v;
+    QDict *qdict;
+    bool b;
+
+    qdict = keyval_parse("bool1=on,bool2=off", NULL, &error_abort);
+    v = qobject_input_visitor_new_autocast(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_bool(v, "bool1", &b, &error_abort);
+    g_assert(b);
+    visit_type_bool(v, "bool2", &b, &error_abort);
+    g_assert(!b);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    qdict = keyval_parse("bool1=offer", NULL, &error_abort);
+    v = qobject_input_visitor_new_autocast(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_bool(v, "bool1", &b, &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+}
+
+static void test_parse_visit_number(void)
+{
+    Error *err = NULL;
+    Visitor *v;
+    QDict *qdict;
+    uint64_t u;
+
+    /* Lower limit zero */
+    qdict = keyval_parse("number1=0", NULL, &error_abort);
+    v = qobject_input_visitor_new_autocast(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_uint64(v, "number1", &u, &error_abort);
+    g_assert_cmpuint(u, ==, 0);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Upper limit 2^64-1 */
+    qdict = keyval_parse("number1=18446744073709551615,number2=-1",
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_autocast(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_uint64(v, "number1", &u, &error_abort);
+    g_assert_cmphex(u, ==, UINT64_MAX);
+    visit_type_uint64(v, "number2", &u, &error_abort);
+    g_assert_cmphex(u, ==, UINT64_MAX);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Above upper limit */
+    qdict = keyval_parse("number1=18446744073709551616",
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_autocast(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_uint64(v, "number1", &u, &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Below lower limit */
+    qdict = keyval_parse("number1=-18446744073709551616",
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_autocast(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_uint64(v, "number1", &u, &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Hex and octal */
+    qdict = keyval_parse("number1=0x2a,number2=052",
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_autocast(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_uint64(v, "number1", &u, &error_abort);
+    g_assert_cmpuint(u, ==, 42);
+    visit_type_uint64(v, "number2", &u, &error_abort);
+    g_assert_cmpuint(u, ==, 42);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Trailing crap */
+    qdict = keyval_parse("number1=3.14,number2=08",
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_autocast(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_uint64(v, "number1", &u, &err);
+    error_free_or_abort(&err);
+    visit_type_uint64(v, "number2", &u, &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+}
+
+static void test_parse_visit_size(void)
+{
+    Error *err = NULL;
+    Visitor *v;
+    QDict *qdict;
+    uint64_t sz;
+
+    /* Lower limit zero */
+    qdict = keyval_parse("sz1=0", NULL, &error_abort);
+    v = qobject_input_visitor_new_autocast(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_size(v, "sz1", &sz, &error_abort);
+    g_assert_cmpuint(sz, ==, 0);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Note: precision is 53 bits since we're parsing with strtod() */
+
+    /* Around limit of precision: 2^53-1, 2^53, 2^54 */
+    qdict = keyval_parse("sz1=9007199254740991,"
+                         "sz2=9007199254740992,"
+                         "sz3=9007199254740993",
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_autocast(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_size(v, "sz1", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, 0x1fffffffffffff);
+    visit_type_size(v, "sz2", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, 0x20000000000000);
+    visit_type_size(v, "sz3", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, 0x20000000000000);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Close to signed upper limit 0x7ffffffffffffc00 (53 msbs set) */
+    qdict = keyval_parse("sz1=9223372036854774784," /* 7ffffffffffffc00 */
+                         "sz2=9223372036854775295", /* 7ffffffffffffdff */
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_autocast(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_size(v, "sz1", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, 0x7ffffffffffffc00);
+    visit_type_size(v, "sz2", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, 0x7ffffffffffffc00);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Close to actual upper limit 0xfffffffffffff800 (53 msbs set) */
+    qdict = keyval_parse("sz1=18446744073709549568," /* fffffffffffff800 */
+                         "sz2=18446744073709550591", /* fffffffffffffbff */
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_autocast(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_size(v, "sz1", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, 0xfffffffffffff800);
+    visit_type_size(v, "sz2", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, 0xfffffffffffff800);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Beyond limits */
+    qdict = keyval_parse("sz1=-1,"
+                         "sz2=18446744073709550592", /* fffffffffffffc00 */
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_autocast(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_size(v, "sz1", &sz, &err);
+    error_free_or_abort(&err);
+    visit_type_size(v, "sz2", &sz, &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Suffixes */
+    qdict = keyval_parse("sz1=8b,sz2=1.5k,sz3=2M,sz4=0.1G,sz5=16777215T",
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_autocast(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_size(v, "sz1", &sz, &error_abort);
+    g_assert_cmpuint(sz, ==, 8);
+    visit_type_size(v, "sz2", &sz, &error_abort);
+    g_assert_cmpuint(sz, ==, 1536);
+    visit_type_size(v, "sz3", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, 2 * M_BYTE);
+    visit_type_size(v, "sz4", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, G_BYTE / 10);
+    visit_type_size(v, "sz5", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, 16777215 * T_BYTE);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Beyond limit with suffix */
+    qdict = keyval_parse("sz1=16777216T", NULL, &error_abort);
+    v = qobject_input_visitor_new_autocast(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_size(v, "sz1", &sz, &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Trailing crap */
+    qdict = keyval_parse("sz1=16E,sz2=16Gi", NULL, &error_abort);
+    v = qobject_input_visitor_new_autocast(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_size(v, "sz1", &sz, &err);
+    error_free_or_abort(&err);
+    visit_type_size(v, "sz2", &sz, &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+}
+
 int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
     g_test_add_func("/keyval/keyval_parse", test_keyval_parse);
+    g_test_add_func("/keyval/parse_visit/bool", test_parse_visit_bool);
+    g_test_add_func("/keyval/parse_visit/number", test_parse_visit_number);
+    g_test_add_func("/keyval/parse_visit/size", test_parse_visit_size);
     g_test_run();
     return 0;
 }
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 945404a..95ad855 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -41,6 +41,7 @@ static void visitor_input_teardown(TestInputVisitorData *data,
    function so that the JSON string used by the tests are kept in the test
    functions (and not in main()). */
 static Visitor *visitor_input_test_init_internal(TestInputVisitorData *data,
+                                                 bool strict, bool autocast,
                                                  const char *json_string,
                                                  va_list *ap)
 {
@@ -49,11 +50,31 @@ static Visitor *visitor_input_test_init_internal(TestInputVisitorData *data,
     data->obj = qobject_from_jsonv(json_string, ap);
     g_assert(data->obj);
 
-    data->qiv = qobject_input_visitor_new(data->obj, false);
+    if (autocast) {
+        assert(strict);
+        data->qiv = qobject_input_visitor_new_autocast(data->obj);
+    } else {
+        data->qiv = qobject_input_visitor_new(data->obj, strict);
+    }
     g_assert(data->qiv);
     return data->qiv;
 }
 
+static GCC_FMT_ATTR(4, 5)
+Visitor *visitor_input_test_init_full(TestInputVisitorData *data,
+                                      bool strict, bool autocast,
+                                      const char *json_string, ...)
+{
+    Visitor *v;
+    va_list ap;
+
+    va_start(ap, json_string);
+    v = visitor_input_test_init_internal(data, strict, autocast,
+                                         json_string, &ap);
+    va_end(ap);
+    return v;
+}
+
 static GCC_FMT_ATTR(2, 3)
 Visitor *visitor_input_test_init(TestInputVisitorData *data,
                                  const char *json_string, ...)
@@ -62,7 +83,8 @@ Visitor *visitor_input_test_init(TestInputVisitorData *data,
     va_list ap;
 
     va_start(ap, json_string);
-    v = visitor_input_test_init_internal(data, json_string, &ap);
+    v = visitor_input_test_init_internal(data, true, false,
+                                         json_string, &ap);
     va_end(ap);
     return v;
 }
@@ -77,7 +99,8 @@ Visitor *visitor_input_test_init(TestInputVisitorData *data,
 static Visitor *visitor_input_test_init_raw(TestInputVisitorData *data,
                                             const char *json_string)
 {
-    return visitor_input_test_init_internal(data, json_string, NULL);
+    return visitor_input_test_init_internal(data, true, false,
+                                            json_string, NULL);
 }
 
 static void test_visitor_in_int(TestInputVisitorData *data,
@@ -110,6 +133,45 @@ static void test_visitor_in_int_overflow(TestInputVisitorData *data,
     error_free_or_abort(&err);
 }
 
+static void test_visitor_in_int_autocast(TestInputVisitorData *data,
+                                         const void *unused)
+{
+    int64_t res = 0, value = -42;
+    Error *err = NULL;
+    Visitor *v;
+
+    v = visitor_input_test_init_full(data, true, true,
+                                     "%" PRId64, value);
+    visit_type_int(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+}
+
+static void test_visitor_in_int_str_autocast(TestInputVisitorData *data,
+                                             const void *unused)
+{
+    int64_t res = 0, value = -42;
+    Visitor *v;
+
+    v = visitor_input_test_init_full(data, true, true,
+                                     "\"-42\"");
+
+    visit_type_int(v, NULL, &res, &error_abort);
+    g_assert_cmpint(res, ==, value);
+}
+
+static void test_visitor_in_int_str_noautocast(TestInputVisitorData *data,
+                                               const void *unused)
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
@@ -122,6 +184,44 @@ static void test_visitor_in_bool(TestInputVisitorData *data,
     g_assert_cmpint(res, ==, true);
 }
 
+static void test_visitor_in_bool_autocast(TestInputVisitorData *data,
+                                          const void *unused)
+{
+    bool res = false;
+    Error *err = NULL;
+    Visitor *v;
+
+    v = visitor_input_test_init_full(data, true, true, "true");
+
+    visit_type_bool(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+}
+
+static void test_visitor_in_bool_str_autocast(TestInputVisitorData *data,
+                                              const void *unused)
+{
+    bool res = false;
+    Visitor *v;
+
+    v = visitor_input_test_init_full(data, true, true, "\"on\"");
+
+    visit_type_bool(v, NULL, &res, &error_abort);
+    g_assert_cmpint(res, ==, true);
+}
+
+static void test_visitor_in_bool_str_noautocast(TestInputVisitorData *data,
+                                                const void *unused)
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
@@ -134,6 +234,69 @@ static void test_visitor_in_number(TestInputVisitorData *data,
     g_assert_cmpfloat(res, ==, value);
 }
 
+static void test_visitor_in_number_autocast(TestInputVisitorData *data,
+                                            const void *unused)
+{
+    double res = 0, value = 3.14;
+    Error *err = NULL;
+    Visitor *v;
+
+    v = visitor_input_test_init_full(data, true, true, "%f", value);
+
+    visit_type_number(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+}
+
+static void test_visitor_in_number_str_autocast(TestInputVisitorData *data,
+                                                const void *unused)
+{
+    double res = 0, value = 3.14;
+    Visitor *v;
+
+    v = visitor_input_test_init_full(data, true, true, "\"3.14\"");
+
+    visit_type_number(v, NULL, &res, &error_abort);
+    g_assert_cmpfloat(res, ==, value);
+}
+
+static void test_visitor_in_number_str_noautocast(TestInputVisitorData *data,
+                                                  const void *unused)
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
+static void test_visitor_in_size_str_autocast(TestInputVisitorData *data,
+                                              const void *unused)
+{
+    uint64_t res, value = 500 * 1024 * 1024;
+    Visitor *v;
+
+    v = visitor_input_test_init_full(data, true, true, "\"500M\"");
+
+    visit_type_size(v, NULL, &res, &error_abort);
+    g_assert_cmpfloat(res, ==, value);
+}
+
+static void test_visitor_in_size_str_noautocast(TestInputVisitorData *data,
+                                                const void *unused)
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
@@ -290,7 +453,8 @@ static void test_visitor_in_null(TestInputVisitorData *data,
      * when input is not null.
      */
 
-    v = visitor_input_test_init(data, "{ 'a': null, 'b': '' }");
+    v = visitor_input_test_init_full(data, false, false,
+                                     "{ 'a': null, 'b': '' }");
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
     visit_type_null(v, "a", &error_abort);
     visit_type_str(v, "a", &tmp, &err);
@@ -841,10 +1005,32 @@ int main(int argc, char **argv)
                            NULL, test_visitor_in_int);
     input_visitor_test_add("/visitor/input/int_overflow",
                            NULL, test_visitor_in_int_overflow);
+    input_visitor_test_add("/visitor/input/int_autocast",
+                           NULL, test_visitor_in_int_autocast);
+    input_visitor_test_add("/visitor/input/int_str_autocast",
+                           NULL, test_visitor_in_int_str_autocast);
+    input_visitor_test_add("/visitor/input/int_str_noautocast",
+                           NULL, test_visitor_in_int_str_noautocast);
     input_visitor_test_add("/visitor/input/bool",
                            NULL, test_visitor_in_bool);
+    input_visitor_test_add("/visitor/input/bool_autocast",
+                           NULL, test_visitor_in_bool_autocast);
+    input_visitor_test_add("/visitor/input/bool_str_autocast",
+                           NULL, test_visitor_in_bool_str_autocast);
+    input_visitor_test_add("/visitor/input/bool_str_noautocast",
+                           NULL, test_visitor_in_bool_str_noautocast);
     input_visitor_test_add("/visitor/input/number",
                            NULL, test_visitor_in_number);
+    input_visitor_test_add("/visitor/input/number_autocast",
+                           NULL, test_visitor_in_number_autocast);
+    input_visitor_test_add("/visitor/input/number_str_autocast",
+                           NULL, test_visitor_in_number_str_autocast);
+    input_visitor_test_add("/visitor/input/number_str_noautocast",
+                           NULL, test_visitor_in_number_str_noautocast);
+    input_visitor_test_add("/visitor/input/size_str_autocast",
+                           NULL, test_visitor_in_size_str_autocast);
+    input_visitor_test_add("/visitor/input/size_str_noautocast",
+                           NULL, test_visitor_in_size_str_noautocast);
     input_visitor_test_add("/visitor/input/string",
                            NULL, test_visitor_in_string);
     input_visitor_test_add("/visitor/input/enum",
-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMW-00067k-Oo
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMU-00012T-Da
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:04 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Feb 2017 12:20:45 +0100
Message-Id: <1488194450-28056-20-git-send-email-armbru@redhat.com>
In-Reply-To: <1488194450-28056-1-git-send-email-armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 19/24] qapi: Improve how keyval input visitor
 reports unexpected dicts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, eblake@redhat.com, "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com

Incorrect option

    -blockdev node-name=foo,driver=file,filename=foo.img,aio.unmap

is rejected with "Invalid parameter type for 'aio', expected: string".
To make sense of this, you almost have to translate it into the
equivalent QMP command

    { "execute": "blockdev-add", "arguments": { "node-name": "foo", "driver": "file", "filename": "foo.img", "aio": { "unmap": true } } }

Improve the error message to "Parameters 'aio.*' are unexpected".
Take care not to confuse the case "unexpected nested parameters"
(i.e. the object is a QDict or QList) with the case "non-string scalar
parameter".  The latter is a misuse of the visitor, and should perhaps
be an assertion.  Note that test-qobject-input-visitor exercises this
misuse in test_visitor_in_int_keyval(), test_visitor_in_bool_keyval()
and test_visitor_in_number_keyval().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qobject-input-visitor.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 64a08d3..1d7b420 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -167,9 +167,18 @@ static const char *qobject_input_get_keyval(QObjectInputVisitor *qiv,
 
     qstr = qobject_to_qstring(qobj);
     if (!qstr) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "string");
-        return NULL;
+        switch (qobject_type(qobj)) {
+        case QTYPE_QDICT:
+        case QTYPE_QLIST:
+            error_setg(errp, "Parameters '%s.*' are unexpected",
+                       full_name(qiv, name));
+            return NULL;
+        default:
+            /* Non-string scalar (should this be an assertion?) */
+            error_setg(errp, "Internal error: parameter %s invalid",
+                       full_name(qiv, name));
+            return NULL;
+        }
     }
 
     return qstring_get_str(qstr);
@@ -478,6 +487,15 @@ static void qobject_input_type_str(Visitor *v, const char *name, char **obj,
     *obj = g_strdup(qstring_get_str(qstr));
 }
 
+static void qobject_input_type_str_keyval(Visitor *v, const char *name,
+                                          char **obj, Error **errp)
+{
+    QObjectInputVisitor *qiv = to_qiv(v);
+    const char *str = qobject_input_get_keyval(qiv, name, errp);
+
+    *obj = g_strdup(str);
+}
+
 static void qobject_input_type_number(Visitor *v, const char *name, double *obj,
                                       Error **errp)
 {
@@ -649,7 +667,7 @@ Visitor *qobject_input_visitor_new_keyval(QObject *obj)
     v->visitor.type_int64 = qobject_input_type_int64_keyval;
     v->visitor.type_uint64 = qobject_input_type_uint64_keyval;
     v->visitor.type_bool = qobject_input_type_bool_keyval;
-    v->visitor.type_str = qobject_input_type_str;
+    v->visitor.type_str = qobject_input_type_str_keyval;
     v->visitor.type_number = qobject_input_type_number_keyval;
     v->visitor.type_any = qobject_input_type_any;
     v->visitor.type_null = qobject_input_type_null;
-- 
2.7.4

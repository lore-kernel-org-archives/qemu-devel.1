Received: from eggs.gnu.org ([2001:4830:134:3::10]:44641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMW-00066W-2D
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMT-00010e-67
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:04 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Feb 2017 12:20:33 +0100
Message-Id: <1488194450-28056-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1488194450-28056-1-git-send-email-armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 07/24] qapi: Factor out common
 qobject_input_get_keyval()
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/qobject-input-visitor.c | 87 ++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 52 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index e47615e..3db5850 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -151,6 +151,28 @@ static QObject *qobject_input_get_object(QObjectInputVisitor *qiv,
     return obj;
 }
 
+static const char *qobject_input_get_keyval(QObjectInputVisitor *qiv,
+                                            const char *name,
+                                            Error **errp)
+{
+    QObject *qobj;
+    QString *qstr;
+
+    qobj = qobject_input_get_object(qiv, name, true, errp);
+    if (!qobj) {
+        return NULL;
+    }
+
+    qstr = qobject_to_qstring(qobj);
+    if (!qstr) {
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
+                   full_name(qiv, name), "string");
+        return NULL;
+    }
+
+    return qstring_get_str(qstr);
+}
+
 static void qdict_add_key(const char *key, QObject *obj, void *opaque)
 {
     GHashTable *h = opaque;
@@ -342,20 +364,13 @@ static void qobject_input_type_int64_keyval(Visitor *v, const char *name,
                                             int64_t *obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
-    QString *qstr;
+    const char *str = qobject_input_get_keyval(qiv, name, errp);
 
-    if (!qobj) {
-        return;
-    }
-    qstr = qobject_to_qstring(qobj);
-    if (!qstr) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "string");
+    if (!str) {
         return;
     }
 
-    if (qemu_strtoi64(qstring_get_str(qstr), NULL, 0, obj) < 0) {
+    if (qemu_strtoi64(str, NULL, 0, obj) < 0) {
         /* TODO report -ERANGE more nicely */
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    full_name(qiv, name), "integer");
@@ -387,20 +402,13 @@ static void qobject_input_type_uint64_keyval(Visitor *v, const char *name,
                                              uint64_t *obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
-    QString *qstr;
+    const char *str = qobject_input_get_keyval(qiv, name, errp);
 
-    if (!qobj) {
-        return;
-    }
-    qstr = qobject_to_qstring(qobj);
-    if (!qstr) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "string");
+    if (!str) {
         return;
     }
 
-    if (qemu_strtou64(qstring_get_str(qstr), NULL, 0, obj) < 0) {
+    if (qemu_strtou64(str, NULL, 0, obj) < 0) {
         /* TODO report -ERANGE more nicely */
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    full_name(qiv, name), "integer");
@@ -431,21 +439,12 @@ static void qobject_input_type_bool_keyval(Visitor *v, const char *name,
                                            bool *obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
-    QString *qstr;
-    const char *str;
+    const char *str = qobject_input_get_keyval(qiv, name, errp);
 
-    if (!qobj) {
-        return;
-    }
-    qstr = qobject_to_qstring(qobj);
-    if (!qstr) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "string");
+    if (!str) {
         return;
     }
 
-    str = qstring_get_str(qstr);
     if (!strcmp(str, "on")) {
         *obj = true;
     } else if (!strcmp(str, "off")) {
@@ -508,22 +507,13 @@ static void qobject_input_type_number_keyval(Visitor *v, const char *name,
                                              double *obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
-    QString *qstr;
-    const char *str;
+    const char *str = qobject_input_get_keyval(qiv, name, errp);
     char *endp;
 
-    if (!qobj) {
-        return;
-    }
-    qstr = qobject_to_qstring(qobj);
-    if (!qstr) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "string");
+    if (!str) {
         return;
     }
 
-    str = qstring_get_str(qstr);
     errno = 0;
     *obj = strtod(str, &endp);
     if (errno || endp == str || *endp) {
@@ -567,20 +557,13 @@ static void qobject_input_type_size_keyval(Visitor *v, const char *name,
                                            uint64_t *obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
-    QString *qstr;
+    const char *str = qobject_input_get_keyval(qiv, name, errp);
 
-    if (!qobj) {
-        return;
-    }
-    qstr = qobject_to_qstring(qobj);
-    if (!qstr) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "string");
+    if (!str) {
         return;
     }
 
-    if (qemu_strtosz(qstring_get_str(qstr), NULL, obj) < 0) {
+    if (qemu_strtosz(str, NULL, obj) < 0) {
         /* TODO report -ERANGE more nicely */
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    full_name(qiv, name), "size");
-- 
2.7.4

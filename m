Received: from eggs.gnu.org ([2001:4830:134:3::10]:33607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDt-00056f-WC
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDs-0000YG-CC
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciqDs-0000XV-38
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:20 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 499E3C049D5C
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 22:26:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1SMQIge017519
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 17:26:19 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 23:25:58 +0100
Message-Id: <1488320775-9849-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1488320775-9849-1-git-send-email-armbru@redhat.com>
References: <1488320775-9849-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 07/24] qapi: Factor out common
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1488317230-26248-8-git-send-email-armbru@redhat.com>
---
 qapi/qobject-input-visitor.c | 87 ++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 52 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 270033e..6c56040 100644
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
@@ -343,20 +365,13 @@ static void qobject_input_type_int64_keyval(Visitor *v, const char *name,
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
@@ -388,20 +403,13 @@ static void qobject_input_type_uint64_keyval(Visitor *v, const char *name,
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
@@ -432,21 +440,12 @@ static void qobject_input_type_bool_keyval(Visitor *v, const char *name,
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
@@ -509,22 +508,13 @@ static void qobject_input_type_number_keyval(Visitor *v, const char *name,
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
@@ -568,20 +558,13 @@ static void qobject_input_type_size_keyval(Visitor *v, const char *name,
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

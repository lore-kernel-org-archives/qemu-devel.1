Received: from eggs.gnu.org ([2001:4830:134:3::10]:44460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cl9QM-0001Xp-6Y
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:20:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cl9QK-0006B7-GF
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:20:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cl9QK-00069e-5H
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:20:44 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59FF883F44
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 07:20:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2320F2D655
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 07:20:44 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  7 Mar 2017 08:20:35 +0100
Message-Id: <1488871237-12332-23-git-send-email-armbru@redhat.com>
In-Reply-To: <1488871237-12332-1-git-send-email-armbru@redhat.com>
References: <1488871237-12332-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v3 22/24] qapi: Improve how keyval input visitor
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

Incorrect option

    -blockdev node-name=foo,driver=file,filename=foo.img,aio.unmap=on

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
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <1488317230-26248-23-git-send-email-armbru@redhat.com>
---
 qapi/qobject-input-visitor.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 1a484d5..b9acd86 100644
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
@@ -479,6 +488,15 @@ static void qobject_input_type_str(Visitor *v, const char *name, char **obj,
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
@@ -650,7 +668,7 @@ Visitor *qobject_input_visitor_new_keyval(QObject *obj)
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

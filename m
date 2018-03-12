Received: from eggs.gnu.org ([2001:4830:134:3::10]:45120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJQ-0000d5-Jm
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJP-0005uf-Ay
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33594 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJP-0005u8-4X
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:43 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:00 -0500
Message-Id: <20180312183628.394722-10-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 09/36] qapi: Make more of qobject_to()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

From: Max Reitz <mreitz@redhat.com>

This patch reworks some places which use either qobject_type() checks
plus qobject_to(), where the latter alone is sufficient, or NULL checks
plus qobject_type() checks where we can simply do a qobject_to() != NULL
check.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-Id: <20180224154033.29559-6-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: rebase to qobject_to() parameter ordering]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/qobject-input-visitor.c |  4 ++--
 qobject/json-parser.c        | 13 +++++++------
 qobject/qdict.c              | 20 +++++++++++---------
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 0b5293385e5..a7569d5dcef 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -339,7 +339,7 @@ static GenericList *qobject_input_next_list(Visitor *v, GenericList *tail,
     QObjectInputVisitor *qiv = to_qiv(v);
     StackObject *tos = QSLIST_FIRST(&qiv->stack);

-    assert(tos && tos->obj && qobject_type(tos->obj) == QTYPE_QLIST);
+    assert(tos && qobject_to(QList, tos->obj));

     if (!tos->entry) {
         return NULL;
@@ -353,7 +353,7 @@ static void qobject_input_check_list(Visitor *v, Error **errp)
     QObjectInputVisitor *qiv = to_qiv(v);
     StackObject *tos = QSLIST_FIRST(&qiv->stack);

-    assert(tos && tos->obj && qobject_type(tos->obj) == QTYPE_QLIST);
+    assert(tos && qobject_to(QList, tos->obj));

     if (tos->entry) {
         error_setg(errp, "Only %u list elements expected in %s",
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 055c7f0272a..769b960c9fe 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -276,7 +276,8 @@ static void parser_context_free(JSONParserContext *ctxt)
  */
 static int parse_pair(JSONParserContext *ctxt, QDict *dict, va_list *ap)
 {
-    QObject *key = NULL, *value;
+    QObject *value;
+    QString *key = NULL;
     JSONToken *peek, *token;

     peek = parser_context_peek_token(ctxt);
@@ -285,8 +286,8 @@ static int parse_pair(JSONParserContext *ctxt, QDict *dict, va_list *ap)
         goto out;
     }

-    key = parse_value(ctxt, ap);
-    if (!key || qobject_type(key) != QTYPE_QSTRING) {
+    key = qobject_to(QString, parse_value(ctxt, ap));
+    if (!key) {
         parse_error(ctxt, peek, "key is not a string in object");
         goto out;
     }
@@ -308,14 +309,14 @@ static int parse_pair(JSONParserContext *ctxt, QDict *dict, va_list *ap)
         goto out;
     }

-    qdict_put_obj(dict, qstring_get_str(qobject_to(QString, key)), value);
+    qdict_put_obj(dict, qstring_get_str(key), value);

-    qobject_decref(key);
+    QDECREF(key);

     return 0;

 out:
-    qobject_decref(key);
+    QDECREF(key);

     return -1;
 }
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 45c8b53361f..d1997a0d8af 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -882,18 +882,20 @@ QObject *qdict_crumple(const QDict *src, Error **errp)

         child = qdict_get(two_level, prefix);
         if (suffix) {
-            if (child) {
-                if (qobject_type(child) != QTYPE_QDICT) {
+            QDict *child_dict = qobject_to(QDict, child);
+            if (!child_dict) {
+                if (child) {
                     error_setg(errp, "Key %s prefix is already set as a scalar",
                                prefix);
                     goto error;
                 }
-            } else {
-                child = QOBJECT(qdict_new());
-                qdict_put_obj(two_level, prefix, child);
+
+                child_dict = qdict_new();
+                qdict_put_obj(two_level, prefix, QOBJECT(child_dict));
             }
+
             qobject_incref(ent->value);
-            qdict_put_obj(qobject_to(QDict, child), suffix, ent->value);
+            qdict_put_obj(child_dict, suffix, ent->value);
         } else {
             if (child) {
                 error_setg(errp, "Key %s prefix is already set as a dict",
@@ -913,9 +915,9 @@ QObject *qdict_crumple(const QDict *src, Error **errp)
     multi_level = qdict_new();
     for (ent = qdict_first(two_level); ent != NULL;
          ent = qdict_next(two_level, ent)) {
-
-        if (qobject_type(ent->value) == QTYPE_QDICT) {
-            child = qdict_crumple(qobject_to(QDict, ent->value), errp);
+        QDict *dict = qobject_to(QDict, ent->value);
+        if (dict) {
+            child = qdict_crumple(dict, errp);
             if (!child) {
                 goto error;
             }
-- 
2.14.3

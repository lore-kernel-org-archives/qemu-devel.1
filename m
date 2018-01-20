Received: from eggs.gnu.org ([2001:4830:134:3::10]:51581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ecvJp-0004VO-Fx
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 10:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ecvJo-00005a-FT
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 10:44:33 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 20 Jan 2018 16:44:10 +0100
Message-Id: <20180120154412.9990-5-mreitz@redhat.com>
In-Reply-To: <20180120154412.9990-1-mreitz@redhat.com>
References: <20180120154412.9990-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/6] qapi: Make more of qobject_to()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

This patch reworks some places which use either qobject_type() checks
plus qobject_to(), where the latter alone is sufficient, or NULL checks
plus qobject_type() checks where we can simply do a qobject_to() != NULL
check.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/qobject-input-visitor.c |  4 ++--
 qobject/json-parser.c        | 13 +++++++------
 qobject/qdict.c              | 20 +++++++++++---------
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 45e6160b21..fa6b92d9f6 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -334,7 +334,7 @@ static GenericList *qobject_input_next_list(Visitor *v, GenericList *tail,
     QObjectInputVisitor *qiv = to_qiv(v);
     StackObject *tos = QSLIST_FIRST(&qiv->stack);
 
-    assert(tos && tos->obj && qobject_type(tos->obj) == QTYPE_QLIST);
+    assert(tos && qobject_to(tos->obj, QList));
 
     if (!tos->entry) {
         return NULL;
@@ -348,7 +348,7 @@ static void qobject_input_check_list(Visitor *v, Error **errp)
     QObjectInputVisitor *qiv = to_qiv(v);
     StackObject *tos = QSLIST_FIRST(&qiv->stack);
 
-    assert(tos && tos->obj && qobject_type(tos->obj) == QTYPE_QLIST);
+    assert(tos && qobject_to(tos->obj, QList));
 
     if (tos->entry) {
         error_setg(errp, "Only %u list elements expected in %s",
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 885039e94b..c4d1f0d8de 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -271,7 +271,8 @@ static void parser_context_free(JSONParserContext *ctxt)
  */
 static int parse_pair(JSONParserContext *ctxt, QDict *dict, va_list *ap)
 {
-    QObject *key = NULL, *value;
+    QObject *value;
+    QString *key = NULL;
     JSONToken *peek, *token;
 
     peek = parser_context_peek_token(ctxt);
@@ -280,8 +281,8 @@ static int parse_pair(JSONParserContext *ctxt, QDict *dict, va_list *ap)
         goto out;
     }
 
-    key = parse_value(ctxt, ap);
-    if (!key || qobject_type(key) != QTYPE_QSTRING) {
+    key = qobject_to(parse_value(ctxt, ap), QString);
+    if (!key) {
         parse_error(ctxt, peek, "key is not a string in object");
         goto out;
     }
@@ -303,14 +304,14 @@ static int parse_pair(JSONParserContext *ctxt, QDict *dict, va_list *ap)
         goto out;
     }
 
-    qdict_put_obj(dict, qstring_get_str(qobject_to(key, QString)), value);
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
index ca84455883..3e97c2d3bc 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -861,18 +861,20 @@ QObject *qdict_crumple(const QDict *src, Error **errp)
 
         child = qdict_get(two_level, prefix);
         if (suffix) {
-            if (child) {
-                if (qobject_type(child) != QTYPE_QDICT) {
+            QDict *child_dict = qobject_to(child, QDict);
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
-            qdict_put_obj(qobject_to(child, QDict), suffix, ent->value);
+            qdict_put_obj(child_dict, suffix, ent->value);
         } else {
             if (child) {
                 error_setg(errp, "Key %s prefix is already set as a dict",
@@ -892,9 +894,9 @@ QObject *qdict_crumple(const QDict *src, Error **errp)
     multi_level = qdict_new();
     for (ent = qdict_first(two_level); ent != NULL;
          ent = qdict_next(two_level, ent)) {
-
-        if (qobject_type(ent->value) == QTYPE_QDICT) {
-            child = qdict_crumple(qobject_to(ent->value, QDict), errp);
+        QDict *dict = qobject_to(ent->value, QDict);
+        if (dict) {
+            child = qdict_crumple(dict, errp);
             if (!child) {
                 goto error;
             }
-- 
2.14.3

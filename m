Received: from eggs.gnu.org ([2001:4830:134:3::10]:52737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg8Bv-0002Qc-Ru
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:01:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg8Br-00073M-33
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:01:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cg8Bq-00072y-O6
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:01:03 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 12:00:59 +0100
Message-Id: <1487674859-26249-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1487674859-26249-1-git-send-email-armbru@redhat.com>
References: <1487674859-26249-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qapi: Improve qobject input visitor error
 reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, eblake@redhat.com

Error messages refer to nodes of the QObject being visited by name.
Trouble is the names are sometimes less than helpful:

* The name of the root QObject is whatever @name argument got passed
  to the visitor, except NULL gets mapped to "null".  We commonly pass
  NULL.  Not good.

  Avoiding errors "at the root" mitigates.  For instance,
  visit_start_struct() can only fail when the visited object is not a
  dictionary, and we commonly ensure it is beforehand.

* The name of a QDict's member is the member key.  Good enough only
  when this happens to be unique.

* The name of a QList's member is "null".  Not good.

Improve error messages by referring to nodes by path instead, as
follows:

* The path of the root QObject is whatever @name argument got passed
  to the visitor, except NULL gets mapped to "<anonymous>".

* The path of a root QDict's member is the member key.

* The path of a root QList's member is "[%zu]", where %zu is the list
  index, starting at zero.

* The path of a non-root QDict's member is the path of the QDict
  concatenated with "." and the member key.

* The path of a non-root QList's member is the path of the QList
  concatenated with "[%zu]", where %zu is the list index.

For example, the incorrect QMP command

    { "execute": "blockdev-add", "arguments": { "node-name": "foo", "driver": "raw", "file": {"driver": "file" } } }

now fails with

    {"error": {"class": "GenericError", "desc": "Parameter 'file.filename' is missing"}}

instead of

    {"error": {"class": "GenericError", "desc": "Parameter 'filename' is missing"}}

and

    { "execute": "input-send-event", "arguments": { "device": "bar", "events": [ [] ] } }

now fails with

    {"error": {"class": "GenericError", "desc": "Invalid parameter type for 'events[0]', expected: object"}}

instead of

    {"error": {"class": "GenericError", "desc": "Invalid parameter type for 'null', expected: QDict"}}

The qobject output visitor doesn't have this problem because it should
not fail.  Same for dealloc and clone visitors.

The string visitors don't have this problem because they visit just
one value, whose name needs to be passed to the visitor as @name.  The
string output visitor shouldn't fail anyway.

The options visitor uses QemuOpts names.  Their name space is flat, so
the use of QDict member keys as names is fine.  NULL names used with
roots and lists could conceivably result in bad error messages.  Left
for another day.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/visitor.h       |   6 ---
 qapi/qobject-input-visitor.c | 123 +++++++++++++++++++++++++++++++------------
 2 files changed, 89 insertions(+), 40 deletions(-)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 9bb6cba..7c91a50 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -66,12 +66,6 @@
  * object, @name is the key associated with the value; and when
  * visiting a member of a list, @name is NULL.
  *
- * FIXME: Clients must pass NULL for @name when visiting a member of a
- * list, but this leads to poor error messages; it might be nicer to
- * require a non-NULL name such as "key.0" for '{ "key": [ "value" ]
- * }' if an error is encountered on "value" (or to have the visitor
- * core auto-generate the nicer name).
- *
  * The visit_type_FOO() functions expect a non-null @obj argument;
  * they allocate *@obj during input visits, leave it unchanged on
  * output visits, and recursively free any resources during a dealloc
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 1e81317..2439f1a 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -21,19 +21,19 @@
 #include "qapi/qmp/types.h"
 #include "qapi/qmp/qerror.h"
 
-typedef struct StackObject
-{
-    QObject *obj; /* Object being visited */
+typedef struct StackObject {
+    const char *name;        /* Name if parent is QDict */
+    QObject *obj;            /* Object being visited, either dict or list */
     void *qapi; /* sanity check that caller uses same pointer */
 
-    GHashTable *h;           /* If obj is dict: unvisited keys */
-    const QListEntry *entry; /* If obj is list: unvisited tail */
+    GHashTable *h;           /* If @obj is QDict: unvisited keys */
+    const QListEntry *entry; /* If @obj is QList: unvisited tail */
+    size_t index;            /* If @obj is QList: list index of @entry */
 
-    QSLIST_ENTRY(StackObject) node;
+    QSLIST_ENTRY(StackObject) node; /* parent */
 } StackObject;
 
-struct QObjectInputVisitor
-{
+struct QObjectInputVisitor {
     Visitor visitor;
 
     /* Root of visit at visitor creation. */
@@ -45,6 +45,8 @@ struct QObjectInputVisitor
 
     /* True to reject parse in visit_end_struct() if unvisited keys remain. */
     bool strict;
+
+    GString *errname;   /* Accumulator for qobject_input_get_name() */
 };
 
 static QObjectInputVisitor *to_qiv(Visitor *v)
@@ -52,9 +54,43 @@ static QObjectInputVisitor *to_qiv(Visitor *v)
     return container_of(v, QObjectInputVisitor, visitor);
 }
 
-static QObject *qobject_input_get_object(QObjectInputVisitor *qiv,
-                                         const char *name,
-                                         bool consume, Error **errp)
+static const char *qobject_input_get_name(QObjectInputVisitor *qiv,
+                                          const char *name)
+{
+    StackObject *so;
+    char buf[32];
+
+    if (qiv->errname) {
+        g_string_truncate(qiv->errname, 0);
+    } else {
+        qiv->errname = g_string_new("");
+    }
+
+    QSLIST_FOREACH(so , &qiv->stack, node) {
+        if (qobject_type(so->obj) == QTYPE_QDICT) {
+            g_string_prepend(qiv->errname, name);
+            g_string_prepend_c(qiv->errname, '.');
+        } else {
+            snprintf(buf, sizeof(buf), "[%zu]", so->index);
+            g_string_prepend(qiv->errname, buf);
+        }
+        name = so->name;
+    }
+
+    if (name) {
+        g_string_prepend(qiv->errname, name);
+    } else if (qiv->errname->str[0] == '.') {
+        g_string_erase(qiv->errname, 0, 1);
+    } else {
+        return "<anonymous>";
+    }
+
+    return qiv->errname->str;
+}
+
+static QObject *qobject_input_try_get_object(QObjectInputVisitor *qiv,
+                                             const char *name,
+                                             bool consume)
 {
     StackObject *tos;
     QObject *qobj;
@@ -78,9 +114,6 @@ static QObject *qobject_input_get_object(QObjectInputVisitor *qiv,
             bool removed = g_hash_table_remove(tos->h, name);
             assert(removed);
         }
-        if (!ret) {
-            error_setg(errp, QERR_MISSING_PARAMETER, name);
-        }
     } else {
         assert(qobject_type(qobj) == QTYPE_QLIST);
         assert(!name);
@@ -88,12 +121,26 @@ static QObject *qobject_input_get_object(QObjectInputVisitor *qiv,
         assert(ret);
         if (consume) {
             tos->entry = qlist_next(tos->entry);
+            tos->index++;
         }
     }
 
     return ret;
 }
 
+static QObject *qobject_input_get_object(QObjectInputVisitor *qiv,
+                                         const char *name,
+                                         bool consume, Error **errp)
+{
+    QObject *obj = qobject_input_try_get_object(qiv, name, consume);
+
+    if (!obj) {
+        error_setg(errp, QERR_MISSING_PARAMETER,
+                   qobject_input_get_name(qiv, name));
+    }
+    return obj;
+}
+
 static void qdict_add_key(const char *key, QObject *obj, void *opaque)
 {
     GHashTable *h = opaque;
@@ -101,12 +148,14 @@ static void qdict_add_key(const char *key, QObject *obj, void *opaque)
 }
 
 static const QListEntry *qobject_input_push(QObjectInputVisitor *qiv,
+                                            const char *name,
                                             QObject *obj, void *qapi)
 {
     GHashTable *h;
     StackObject *tos = g_new0(StackObject, 1);
 
     assert(obj);
+    tos->name = name;
     tos->obj = obj;
     tos->qapi = qapi;
 
@@ -116,6 +165,7 @@ static const QListEntry *qobject_input_push(QObjectInputVisitor *qiv,
         tos->h = h;
     } else if (qobject_type(obj) == QTYPE_QLIST) {
         tos->entry = qlist_first(qobject_to_qlist(obj));
+        tos->index = -1;
     }
 
     QSLIST_INSERT_HEAD(&qiv->stack, tos, node);
@@ -137,7 +187,8 @@ static void qobject_input_check_struct(Visitor *v, Error **errp)
 
             g_hash_table_iter_init(&iter, top_ht);
             if (g_hash_table_iter_next(&iter, (void **)&key, NULL)) {
-                error_setg(errp, QERR_QMP_EXTRA_MEMBER, key);
+                error_setg(errp, QERR_QMP_EXTRA_MEMBER,
+                           qobject_input_get_name(qiv, key));
             }
         }
     }
@@ -175,12 +226,12 @@ static void qobject_input_start_struct(Visitor *v, const char *name, void **obj,
         return;
     }
     if (qobject_type(qobj) != QTYPE_QDICT) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
-                   "QDict");
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
+                   qobject_input_get_name(qiv, name), "object");
         return;
     }
 
-    qobject_input_push(qiv, qobj, obj);
+    qobject_input_push(qiv, name, qobj, obj);
 
     if (obj) {
         *obj = g_malloc0(size);
@@ -203,12 +254,12 @@ static void qobject_input_start_list(Visitor *v, const char *name,
         if (list) {
             *list = NULL;
         }
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
-                   "list");
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
+                   qobject_input_get_name(qiv, name), "array");
         return;
     }
 
-    entry = qobject_input_push(qiv, qobj, list);
+    entry = qobject_input_push(qiv, name, qobj, list);
     if (list) {
         if (entry) {
             *list = g_malloc0(size);
@@ -262,8 +313,8 @@ static void qobject_input_type_int64(Visitor *v, const char *name, int64_t *obj,
     }
     qint = qobject_to_qint(qobj);
     if (!qint) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
-                   "integer");
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
+                   qobject_input_get_name(qiv, name), "integer");
         return;
     }
 
@@ -283,8 +334,8 @@ static void qobject_input_type_uint64(Visitor *v, const char *name,
     }
     qint = qobject_to_qint(qobj);
     if (!qint) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
-                   "integer");
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
+                   qobject_input_get_name(qiv, name), "integer");
         return;
     }
 
@@ -303,8 +354,8 @@ static void qobject_input_type_bool(Visitor *v, const char *name, bool *obj,
     }
     qbool = qobject_to_qbool(qobj);
     if (!qbool) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
-                   "boolean");
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
+                   qobject_input_get_name(qiv, name), "boolean");
         return;
     }
 
@@ -324,8 +375,8 @@ static void qobject_input_type_str(Visitor *v, const char *name, char **obj,
     }
     qstr = qobject_to_qstring(qobj);
     if (!qstr) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
-                   "string");
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
+                   qobject_input_get_name(qiv, name), "string");
         return;
     }
 
@@ -355,8 +406,8 @@ static void qobject_input_type_number(Visitor *v, const char *name, double *obj,
         return;
     }
 
-    error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
-               "number");
+    error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
+               qobject_input_get_name(qiv, name), "number");
 }
 
 static void qobject_input_type_any(Visitor *v, const char *name, QObject **obj,
@@ -384,15 +435,15 @@ static void qobject_input_type_null(Visitor *v, const char *name, Error **errp)
     }
 
     if (qobject_type(qobj) != QTYPE_QNULL) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
-                   "null");
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
+                   qobject_input_get_name(qiv, name), "null");
     }
 }
 
 static void qobject_input_optional(Visitor *v, const char *name, bool *present)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, false, NULL);
+    QObject *qobj = qobject_input_try_get_object(qiv, name, false);
 
     if (!qobj) {
         *present = false;
@@ -405,6 +456,7 @@ static void qobject_input_optional(Visitor *v, const char *name, bool *present)
 static void qobject_input_free(Visitor *v)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
+
     while (!QSLIST_EMPTY(&qiv->stack)) {
         StackObject *tos = QSLIST_FIRST(&qiv->stack);
 
@@ -413,6 +465,9 @@ static void qobject_input_free(Visitor *v)
     }
 
     qobject_decref(qiv->root);
+    if (qiv->errname) {
+        g_string_free(qiv->errname, TRUE);
+    }
     g_free(qiv);
 }
 
-- 
2.7.4

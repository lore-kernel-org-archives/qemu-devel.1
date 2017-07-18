Received: from eggs.gnu.org ([2001:4830:134:3::10]:58153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXZ7W-000572-CE
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXZ7T-00017N-BC
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:29:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dXZ7T-00016r-2B
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:29:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CBB74A6E6
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 20:29:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-60.ams2.redhat.com
	[10.36.116.60])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A0E377F384
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 20:29:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Jul 2017 22:29:11 +0200
Message-Id: <1500409760-20730-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1500409760-20730-1-git-send-email-armbru@redhat.com>
References: <1500409760-20730-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 01/10] qapi: Separate type QNull from QObject
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
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/qapi/qmp/qobject.h    | 10 +++++++---
 qapi/qobject-output-visitor.c |  2 +-
 qobject/json-parser.c         |  2 +-
 qobject/qnull.c               |  8 +++++---
 target/i386/cpu.c             |  4 ++--
 tests/check-qjson.c           |  6 +++---
 tests/check-qnull.c           | 18 +++++++++---------
 7 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index b8ddbca..3543b55 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -93,11 +93,15 @@ static inline QType qobject_type(const QObject *obj)
     return obj->type;
 }
 
-extern QObject qnull_;
+typedef struct QNull {
+    QObject base;
+} QNull;
 
-static inline QObject *qnull(void)
+extern QNull qnull_;
+
+static inline QNull *qnull(void)
 {
-    qobject_incref(&qnull_);
+    QINCREF(&qnull_);
     return &qnull_;
 }
 
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
index 70be84c..398dcb5 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -190,7 +190,7 @@ static void qobject_output_type_any(Visitor *v, const char *name,
 static void qobject_output_type_null(Visitor *v, const char *name, Error **errp)
 {
     QObjectOutputVisitor *qov = to_qov(v);
-    qobject_output_add_obj(qov, name, qnull());
+    qobject_output_add(qov, name, qnull());
 }
 
 /* Finish building, and return the root object.
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 7a417f2..724ca24 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -445,7 +445,7 @@ static QObject *parse_keyword(JSONParserContext *ctxt)
     } else if (!strcmp(token->str, "false")) {
         return QOBJECT(qbool_from_bool(false));
     } else if (!strcmp(token->str, "null")) {
-        return qnull();
+        return QOBJECT(qnull());
     }
     parse_error(ctxt, token, "invalid keyword '%s'", token->str);
     return NULL;
diff --git a/qobject/qnull.c b/qobject/qnull.c
index c124d05..69a21d1 100644
--- a/qobject/qnull.c
+++ b/qobject/qnull.c
@@ -14,7 +14,9 @@
 #include "qemu-common.h"
 #include "qapi/qmp/qobject.h"
 
-QObject qnull_ = {
-    .type = QTYPE_QNULL,
-    .refcnt = 1,
+QNull qnull_ = {
+    .base = {
+        .type = QTYPE_QNULL,
+        .refcnt = 1,
+    },
 };
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c571772..10e8386 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2394,7 +2394,7 @@ static QDict *x86_cpu_static_props(void)
 
     d = qdict_new();
     for (i = 0; props[i]; i++) {
-        qdict_put_obj(d, props[i], qnull());
+        qdict_put(d, props[i], qnull());
     }
 
     for (w = 0; w < FEATURE_WORDS; w++) {
@@ -2404,7 +2404,7 @@ static QDict *x86_cpu_static_props(void)
             if (!fi->feat_names[bit]) {
                 continue;
             }
-            qdict_put_obj(d, fi->feat_names[bit], qnull());
+            qdict_put(d, fi->feat_names[bit], qnull());
         }
     }
 
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 53f2275..a3a97b0 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1012,7 +1012,7 @@ static void keyword_literal(void)
 {
     QObject *obj;
     QBool *qbool;
-    QObject *null;
+    QNull *null;
     QString *str;
 
     obj = qobject_from_json("true", &error_abort);
@@ -1053,10 +1053,10 @@ static void keyword_literal(void)
     g_assert(qobject_type(obj) == QTYPE_QNULL);
 
     null = qnull();
-    g_assert(null == obj);
+    g_assert(QOBJECT(null) == obj);
 
     qobject_decref(obj);
-    qobject_decref(null);
+    QDECREF(null);
 }
 
 typedef struct LiteralQDictEntry LiteralQDictEntry;
diff --git a/tests/check-qnull.c b/tests/check-qnull.c
index 8dd1c96..1ab7c98 100644
--- a/tests/check-qnull.c
+++ b/tests/check-qnull.c
@@ -24,14 +24,14 @@ static void qnull_ref_test(void)
 {
     QObject *obj;
 
-    g_assert(qnull_.refcnt == 1);
-    obj = qnull();
+    g_assert(qnull_.base.refcnt == 1);
+    obj = QOBJECT(qnull());
     g_assert(obj);
-    g_assert(obj == &qnull_);
-    g_assert(qnull_.refcnt == 2);
+    g_assert(obj == QOBJECT(&qnull_));
+    g_assert(qnull_.base.refcnt == 2);
     g_assert(qobject_type(obj) == QTYPE_QNULL);
     qobject_decref(obj);
-    g_assert(qnull_.refcnt == 1);
+    g_assert(qnull_.base.refcnt == 1);
 }
 
 static void qnull_visit_test(void)
@@ -45,8 +45,8 @@ static void qnull_visit_test(void)
      * depend on layering violations to check qnull_ refcnt.
      */
 
-    g_assert(qnull_.refcnt == 1);
-    obj = qnull();
+    g_assert(qnull_.base.refcnt == 1);
+    obj = QOBJECT(qnull());
     v = qobject_input_visitor_new(obj);
     qobject_decref(obj);
     visit_type_null(v, NULL, &error_abort);
@@ -55,11 +55,11 @@ static void qnull_visit_test(void)
     v = qobject_output_visitor_new(&obj);
     visit_type_null(v, NULL, &error_abort);
     visit_complete(v, &obj);
-    g_assert(obj == &qnull_);
+    g_assert(obj == QOBJECT(&qnull_));
     qobject_decref(obj);
     visit_free(v);
 
-    g_assert(qnull_.refcnt == 1);
+    g_assert(qnull_.base.refcnt == 1);
 }
 
 int main(int argc, char **argv)
-- 
2.7.5

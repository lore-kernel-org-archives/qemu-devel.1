Received: from eggs.gnu.org ([2001:4830:134:3::10]:44752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMZ-0006BM-N3
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMS-0000zw-NY
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:07 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Feb 2017 12:20:32 +0100
Message-Id: <1488194450-28056-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1488194450-28056-1-git-send-email-armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 06/24] qapi: Factor out common part of qobject
 input visitor creation
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
---
 qapi/qobject-input-visitor.c | 61 +++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index d53bad3..e47615e 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -618,22 +618,34 @@ static void qobject_input_free(Visitor *v)
     g_free(qiv);
 }
 
+static QObjectInputVisitor *qobject_input_visitor_base_new(QObject *obj)
+{
+    QObjectInputVisitor *v = g_malloc0(sizeof(*v));
+
+    assert(obj);
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
+    v->visitor.optional = qobject_input_optional;
+    v->visitor.free = qobject_input_free;
+
+    v->root = obj;
+    qobject_incref(obj);
+
+    return v;
+}
+
 Visitor *qobject_input_visitor_new(QObject *obj)
 {
-    QObjectInputVisitor *v;
+    QObjectInputVisitor *v = qobject_input_visitor_base_new(obj);
 
-    assert(obj);
-    v = g_malloc0(sizeof(*v));
-
-    v->visitor.type = VISITOR_INPUT;
-    v->visitor.start_struct = qobject_input_start_struct;
-    v->visitor.check_struct = qobject_input_check_struct;
-    v->visitor.end_struct = qobject_input_pop;
-    v->visitor.start_list = qobject_input_start_list;
-    v->visitor.next_list = qobject_input_next_list;
-    v->visitor.check_list = qobject_input_check_list;
-    v->visitor.end_list = qobject_input_pop;
-    v->visitor.start_alternate = qobject_input_start_alternate;
     v->visitor.type_int64 = qobject_input_type_int64;
     v->visitor.type_uint64 = qobject_input_type_uint64;
     v->visitor.type_bool = qobject_input_type_bool;
@@ -641,30 +653,14 @@ Visitor *qobject_input_visitor_new(QObject *obj)
     v->visitor.type_number = qobject_input_type_number;
     v->visitor.type_any = qobject_input_type_any;
     v->visitor.type_null = qobject_input_type_null;
-    v->visitor.optional = qobject_input_optional;
-    v->visitor.free = qobject_input_free;
-
-    v->root = obj;
-    qobject_incref(obj);
 
     return &v->visitor;
 }
 
 Visitor *qobject_input_visitor_new_keyval(QObject *obj)
 {
-    QObjectInputVisitor *v;
+    QObjectInputVisitor *v = qobject_input_visitor_base_new(obj);
 
-    v = g_malloc0(sizeof(*v));
-
-    v->visitor.type = VISITOR_INPUT;
-    v->visitor.start_struct = qobject_input_start_struct;
-    v->visitor.check_struct = qobject_input_check_struct;
-    v->visitor.end_struct = qobject_input_pop;
-    v->visitor.start_list = qobject_input_start_list;
-    v->visitor.next_list = qobject_input_next_list;
-    v->visitor.check_list = qobject_input_check_list;
-    v->visitor.end_list = qobject_input_pop;
-    v->visitor.start_alternate = qobject_input_start_alternate;
     v->visitor.type_int64 = qobject_input_type_int64_keyval;
     v->visitor.type_uint64 = qobject_input_type_uint64_keyval;
     v->visitor.type_bool = qobject_input_type_bool_keyval;
@@ -673,11 +669,6 @@ Visitor *qobject_input_visitor_new_keyval(QObject *obj)
     v->visitor.type_any = qobject_input_type_any;
     v->visitor.type_null = qobject_input_type_null;
     v->visitor.type_size = qobject_input_type_size_keyval;
-    v->visitor.optional = qobject_input_optional;
-    v->visitor.free = qobject_input_free;
-
-    v->root = obj;
-    qobject_incref(obj);
 
     return &v->visitor;
 }
-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:34606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1clGv0-0003UC-Bd
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1clGuw-0003L9-RU
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:20:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1clGuw-0003Kv-JK
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:20:50 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F74AC0528DE
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 15:20:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v27FKnQl001019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 7 Mar 2017 10:20:50 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  7 Mar 2017 16:20:27 +0100
Message-Id: <1488900045-26344-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1488900045-26344-1-git-send-email-armbru@redhat.com>
References: <1488900045-26344-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v4 06/24] qapi: Factor out common part of
 qobject input visitor creation
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
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <1488317230-26248-7-git-send-email-armbru@redhat.com>
---
 qapi/qobject-input-visitor.c | 61 +++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index e2e3e70..270033e 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -619,22 +619,34 @@ static void qobject_input_free(Visitor *v)
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
@@ -642,30 +654,14 @@ Visitor *qobject_input_visitor_new(QObject *obj)
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
@@ -674,11 +670,6 @@ Visitor *qobject_input_visitor_new_keyval(QObject *obj)
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

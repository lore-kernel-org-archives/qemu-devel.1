Received: from eggs.gnu.org ([2001:4830:134:3::10]:35444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3ezV-0000Ms-4k
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3ezS-0004wH-1p
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:41:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d3ezR-0004vr-RU
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:41:29 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 27 Apr 2017 10:41:26 +0200
Message-Id: <1493282486-28338-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1493282486-28338-1-git-send-email-armbru@redhat.com>
References: <1493282486-28338-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] qobject-input-visitor: Catch misuse of
 end_struct vs. end_list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, mdroth@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qobject-input-visitor.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 2530959..68a6742 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -291,6 +291,15 @@ static void qobject_input_start_struct(Visitor *v, const char *name, void **obj,
     }
 }
 
+static void qobject_input_end_struct(Visitor *v, void **obj)
+{
+    QObjectInputVisitor *qiv = to_qiv(v);
+    StackObject *tos = QSLIST_FIRST(&qiv->stack);
+
+    assert(tos->h);
+    qobject_input_pop(v, obj);
+}
+
 
 static void qobject_input_start_list(Visitor *v, const char *name,
                                      GenericList **list, size_t size,
@@ -346,6 +355,14 @@ static void qobject_input_check_list(Visitor *v, Error **errp)
     }
 }
 
+static void qobject_input_end_list(Visitor *v, void **obj)
+{
+    QObjectInputVisitor *qiv = to_qiv(v);
+    StackObject *tos = QSLIST_FIRST(&qiv->stack);
+
+    assert(!tos->h);
+    qobject_input_pop(v, obj);
+}
 
 static void qobject_input_start_alternate(Visitor *v, const char *name,
                                           GenericAlternate **obj, size_t size,
@@ -645,11 +662,11 @@ static QObjectInputVisitor *qobject_input_visitor_base_new(QObject *obj)
     v->visitor.type = VISITOR_INPUT;
     v->visitor.start_struct = qobject_input_start_struct;
     v->visitor.check_struct = qobject_input_check_struct;
-    v->visitor.end_struct = qobject_input_pop;
+    v->visitor.end_struct = qobject_input_end_struct;
     v->visitor.start_list = qobject_input_start_list;
     v->visitor.next_list = qobject_input_next_list;
     v->visitor.check_list = qobject_input_check_list;
-    v->visitor.end_list = qobject_input_pop;
+    v->visitor.end_list = qobject_input_end_list;
     v->visitor.start_alternate = qobject_input_start_alternate;
     v->visitor.optional = qobject_input_optional;
     v->visitor.free = qobject_input_free;
-- 
2.7.4

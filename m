Received: from eggs.gnu.org ([2001:4830:134:3::10]:57255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX8Ny-0002mB-QD
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX8Nx-0007W5-4g
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:56:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dX8Nw-0007Vq-UK
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:56:37 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Jul 2017 10:56:28 -0500
Message-Id: <20170717155632.12754-2-eblake@redhat.com>
In-Reply-To: <20170717155632.12754-1-eblake@redhat.com>
References: <20170717155632.12754-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] qapi: Add QAPI_TO_QOBJECT() convenience
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

We have several callers that want to convert a QAPI C type into
a QObject; right now all of them have to copy the same boilerplate
of creating a visitor. A convenience macro makes this paradigm
easier to type.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qobject-output-visitor.h | 19 +++++++++++++++++++
 qapi/qobject-output-visitor.c         | 16 ++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/qapi/qobject-output-visitor.h b/include/qapi/qobject-output-visitor.h
index e5a3490812..f6066ce537 100644
--- a/include/qapi/qobject-output-visitor.h
+++ b/include/qapi/qobject-output-visitor.h
@@ -16,6 +16,8 @@

 #include "qapi/visitor.h"
 #include "qapi/qmp/qobject.h"
+#include "qapi/error.h"
+#include "qapi-visit.h"

 typedef struct QObjectOutputVisitor QObjectOutputVisitor;

@@ -54,4 +56,21 @@ typedef struct QObjectOutputVisitor QObjectOutputVisitor;
  */
 Visitor *qobject_output_visitor_new(QObject **result);

+QObject *qapi_to_qobject(const void *src,
+                         void (*visit_type)(Visitor *, const char *,
+                                            void **, Error **),
+                         Error **errp);
+
+/*
+ * Create a QObject from a QAPI object @src of the given @type.
+ *
+ * Not usable on QAPI scalars (integers, strings, enums), nor on a
+ * QAPI object that references the 'any' type.  @src must not be NULL.
+ */
+#define QAPI_TO_QOBJECT(type, src, err)                                 \
+    (qapi_to_qobject(1 ? (src) : (type *)NULL,                          \
+                     (void (*)(Visitor *, const char *, void**,         \
+                               Error **))visit_type_ ## type,           \
+                     err))
+
 #endif
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
index 70be84ccb5..0b1f098fa1 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -251,3 +251,19 @@ Visitor *qobject_output_visitor_new(QObject **result)

     return &v->visitor;
 }
+
+QObject *qapi_to_qobject(const void *src,
+                         void (*visit_type)(Visitor *, const char *,
+                                            void **, Error **),
+                         Error **errp)
+{
+    Visitor *v;
+    void *s = (void *) src; /* cast away const */
+    QObject *dst = NULL;
+
+    v = qobject_output_visitor_new(&dst);
+    visit_type(v, NULL, &s, &error_abort);
+    visit_complete(v, &dst);
+    visit_free(v);
+    return dst;
+}
-- 
2.13.3

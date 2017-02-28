Received: from eggs.gnu.org ([2001:4830:134:3::10]:36285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cipIt-0007Z3-1Y
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:27:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cipIq-0000yQ-KE
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:27:27 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 22:27:06 +0100
Message-Id: <1488317230-26248-21-git-send-email-armbru@redhat.com>
In-Reply-To: <1488317230-26248-1-git-send-email-armbru@redhat.com>
References: <1488317230-26248-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 20/24] qapi: New
 qobject_input_visitor_new_str() for convenience
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qobject-input-visitor.h | 12 ++++++++++++
 qapi/qobject-input-visitor.c         | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/qapi/qobject-input-visitor.h b/include/qapi/qobject-input-visitor.h
index 282f9d2..b399285 100644
--- a/include/qapi/qobject-input-visitor.h
+++ b/include/qapi/qobject-input-visitor.h
@@ -68,4 +68,16 @@ Visitor *qobject_input_visitor_new(QObject *obj);
  */
 Visitor *qobject_input_visitor_new_keyval(QObject *obj);
 
+/*
+ * Create a QObject input visitor for parsing @str.
+ *
+ * If @str looks like JSON, parse it as JSON, else as KEY=VALUE,...
+ * @implied_key applies to KEY=VALUE, and works as in keyval_parse().
+ * On failure, store an error through @errp and return NULL.
+ * On success, return a new QObject input visitor for the parse.
+ */
+Visitor *qobject_input_visitor_new_str(const char *str,
+                                       const char *implied_key,
+                                       Error **errp);
+
 #endif
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 6c56040..1a484d5 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -18,9 +18,11 @@
 #include "qapi/visitor-impl.h"
 #include "qemu/queue.h"
 #include "qemu-common.h"
+#include "qapi/qmp/qjson.h"
 #include "qapi/qmp/types.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/cutils.h"
+#include "qemu/option.h"
 
 typedef struct StackObject {
     const char *name;            /* Name of @obj in its parent, if any */
@@ -656,3 +658,37 @@ Visitor *qobject_input_visitor_new_keyval(QObject *obj)
 
     return &v->visitor;
 }
+
+Visitor *qobject_input_visitor_new_str(const char *str,
+                                       const char *implied_key,
+                                       Error **errp)
+{
+    bool is_json = str[0] == '{';
+    QObject *obj;
+    QDict *args;
+    Visitor *v;
+
+    if (is_json) {
+        obj = qobject_from_json(str, errp);
+        if (!obj) {
+            /* Work around qobject_from_json() lossage TODO fix that */
+            if (errp && !*errp) {
+                error_setg(errp, "JSON parse error");
+                return NULL;
+            }
+            return NULL;
+        }
+        args = qobject_to_qdict(obj);
+        assert(args);
+        v = qobject_input_visitor_new(QOBJECT(args));
+    } else {
+        args = keyval_parse(str, implied_key, errp);
+        if (!args) {
+            return NULL;
+        }
+        v = qobject_input_visitor_new_keyval(QOBJECT(args));
+    }
+    QDECREF(args);
+
+    return v;
+}
-- 
2.7.4

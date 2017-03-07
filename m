Received: from eggs.gnu.org ([2001:4830:134:3::10]:34652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1clGv1-0003Uy-Ho
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1clGuz-0003Pc-VT
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:20:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1clGuz-0003Ol-NM
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:20:53 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 93FFB7FD41
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 15:20:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v27FKqGY001071
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 7 Mar 2017 10:20:53 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  7 Mar 2017 16:20:41 +0100
Message-Id: <1488900045-26344-21-git-send-email-armbru@redhat.com>
In-Reply-To: <1488900045-26344-1-git-send-email-armbru@redhat.com>
References: <1488900045-26344-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v4 20/24] qapi: New
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1488317230-26248-21-git-send-email-armbru@redhat.com>
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

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQURh-0003px-KP
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQURg-0003Fv-L5
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:05:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dQURg-0003FW-CD
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:05:00 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 29 Jun 2017 16:04:46 +0800
Message-Id: <20170629080452.26470-2-famz@redhat.com>
In-Reply-To: <20170629080452.26470-1-famz@redhat.com>
References: <20170629080452.26470-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/7] qom: Make link property API public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>

The get/set pair and the struct will be reused by qdev link prop, make
them public.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/qom/link-property.h | 31 +++++++++++++++++++++++++++++++
 qom/object.c                | 19 +++++++------------
 2 files changed, 38 insertions(+), 12 deletions(-)
 create mode 100644 include/qom/link-property.h

diff --git a/include/qom/link-property.h b/include/qom/link-property.h
new file mode 100644
index 0000000..f3c3816
--- /dev/null
+++ b/include/qom/link-property.h
@@ -0,0 +1,31 @@
+/*
+ * QOM link property
+ *
+ * Copyright IBM, Corp. 2011
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QOM_LINK_PROPERTY_H
+#define QOM_LINK_PROPERTY_H
+
+#include "qom/object.h"
+
+typedef struct {
+    Object **child;
+    void (*check)(Object *, const char *, Object *, Error **);
+    ObjectPropertyLinkFlags flags;
+} LinkProperty;
+
+void object_get_link_property(Object *obj, Visitor *v,
+                              const char *name, void *opaque,
+                              Error **errp);
+void object_set_link_property(Object *obj, Visitor *v,
+                              const char *name, void *opaque,
+                              Error **errp);
+#endif
diff --git a/qom/object.c b/qom/object.c
index 5f6fdfa..fdb8f0d 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -28,6 +28,7 @@
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qstring.h"
+#include "qom/link-property.h"
 
 #define MAX_INTERFACES 32
 
@@ -1434,15 +1435,9 @@ void object_property_allow_set_link(Object *obj, const char *name,
     /* Allow the link to be set, always */
 }
 
-typedef struct {
-    Object **child;
-    void (*check)(Object *, const char *, Object *, Error **);
-    ObjectPropertyLinkFlags flags;
-} LinkProperty;
-
-static void object_get_link_property(Object *obj, Visitor *v,
-                                     const char *name, void *opaque,
-                                     Error **errp)
+void object_get_link_property(Object *obj, Visitor *v,
+                              const char *name, void *opaque,
+                              Error **errp)
 {
     LinkProperty *lprop = opaque;
     Object **child = lprop->child;
@@ -1498,9 +1493,9 @@ static Object *object_resolve_link(Object *obj, const char *name,
     return target;
 }
 
-static void object_set_link_property(Object *obj, Visitor *v,
-                                     const char *name, void *opaque,
-                                     Error **errp)
+void object_set_link_property(Object *obj, Visitor *v,
+                              const char *name, void *opaque,
+                              Error **errp)
 {
     Error *local_err = NULL;
     LinkProperty *prop = opaque;
-- 
2.9.4

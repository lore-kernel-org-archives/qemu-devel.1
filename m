Received: from eggs.gnu.org ([2001:4830:134:3::10]:41946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEfWq-0000KP-EX
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEfWn-0003AF-Uw
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:01:44 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 14 Nov 2017 19:01:23 +0100
Message-Id: <20171114180128.17076-2-mreitz@redhat.com>
In-Reply-To: <20171114180128.17076-1-mreitz@redhat.com>
References: <20171114180128.17076-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11? v7 1/6] qapi/qnull: Add own header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qdict.h    |  1 +
 include/qapi/qmp/qnull.h    | 30 ++++++++++++++++++++++++++++++
 include/qapi/qmp/qobject.h  | 12 ------------
 include/qapi/qmp/types.h    |  1 +
 qapi/qapi-clone-visitor.c   |  1 +
 qapi/string-input-visitor.c |  1 +
 qobject/qnull.c             |  2 +-
 tests/check-qnull.c         |  2 +-
 8 files changed, 36 insertions(+), 14 deletions(-)
 create mode 100644 include/qapi/qmp/qnull.h

diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index 6588c7f0c8..7ea5120c4a 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -15,6 +15,7 @@
 
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qlist.h"
+#include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
 #include "qemu/queue.h"
 
diff --git a/include/qapi/qmp/qnull.h b/include/qapi/qmp/qnull.h
new file mode 100644
index 0000000000..d075549283
--- /dev/null
+++ b/include/qapi/qmp/qnull.h
@@ -0,0 +1,30 @@
+/*
+ * QNull
+ *
+ * Copyright (C) 2015 Red Hat, Inc.
+ *
+ * Authors:
+ *  Markus Armbruster <armbru@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1
+ * or later.  See the COPYING.LIB file in the top-level directory.
+ */
+
+#ifndef QNULL_H
+#define QNULL_H
+
+#include "qapi/qmp/qobject.h"
+
+struct QNull {
+    QObject base;
+};
+
+extern QNull qnull_;
+
+static inline QNull *qnull(void)
+{
+    QINCREF(&qnull_);
+    return &qnull_;
+}
+
+#endif /* QNULL_H */
diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index eab29edd12..ef1d1a9237 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -93,16 +93,4 @@ static inline QType qobject_type(const QObject *obj)
     return obj->type;
 }
 
-struct QNull {
-    QObject base;
-};
-
-extern QNull qnull_;
-
-static inline QNull *qnull(void)
-{
-    QINCREF(&qnull_);
-    return &qnull_;
-}
-
 #endif /* QOBJECT_H */
diff --git a/include/qapi/qmp/types.h b/include/qapi/qmp/types.h
index a4bc662bfb..749ac44dcb 100644
--- a/include/qapi/qmp/types.h
+++ b/include/qapi/qmp/types.h
@@ -19,5 +19,6 @@
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
+#include "qapi/qmp/qnull.h"
 
 #endif /* QAPI_QMP_TYPES_H */
diff --git a/qapi/qapi-clone-visitor.c b/qapi/qapi-clone-visitor.c
index d8b62792bc..daab6819b4 100644
--- a/qapi/qapi-clone-visitor.c
+++ b/qapi/qapi-clone-visitor.c
@@ -12,6 +12,7 @@
 #include "qapi/clone-visitor.h"
 #include "qapi/visitor-impl.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qnull.h"
 
 struct QapiCloneVisitor {
     Visitor visitor;
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index 67a0a4a58b..b3fdd0827d 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -16,6 +16,7 @@
 #include "qapi/string-input-visitor.h"
 #include "qapi/visitor-impl.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/qmp/qnull.h"
 #include "qemu/option.h"
 #include "qemu/queue.h"
 #include "qemu/range.h"
diff --git a/qobject/qnull.c b/qobject/qnull.c
index 69a21d1059..bc9fd31626 100644
--- a/qobject/qnull.c
+++ b/qobject/qnull.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "qapi/qmp/qobject.h"
+#include "qapi/qmp/qnull.h"
 
 QNull qnull_ = {
     .base = {
diff --git a/tests/check-qnull.c b/tests/check-qnull.c
index 5c6eb0adc8..afa4400da1 100644
--- a/tests/check-qnull.c
+++ b/tests/check-qnull.c
@@ -8,7 +8,7 @@
  */
 #include "qemu/osdep.h"
 
-#include "qapi/qmp/qobject.h"
+#include "qapi/qmp/qnull.h"
 #include "qemu-common.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
-- 
2.13.6

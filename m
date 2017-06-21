Received: from eggs.gnu.org ([2001:4830:134:3::10]:52816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNfz9-0005vv-O4
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNfz8-0006LD-H4
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:47:55 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 21 Jun 2017 15:47:41 +0200
Message-Id: <20170621134744.8047-2-mreitz@redhat.com>
In-Reply-To: <20170621134744.8047-1-mreitz@redhat.com>
References: <20170621134744.8047-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/4] qapi/qnull: Add own header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/qapi/qmp/qnull.h   | 26 ++++++++++++++++++++++++++
 include/qapi/qmp/qobject.h |  8 --------
 include/qapi/qmp/types.h   |  1 +
 qobject/qnull.c            |  1 +
 target/i386/cpu.c          |  6 +-----
 tests/check-qnull.c        |  2 +-
 6 files changed, 30 insertions(+), 14 deletions(-)
 create mode 100644 include/qapi/qmp/qnull.h

diff --git a/include/qapi/qmp/qnull.h b/include/qapi/qmp/qnull.h
new file mode 100644
index 0000000..69555ac
--- /dev/null
+++ b/include/qapi/qmp/qnull.h
@@ -0,0 +1,26 @@
+/*
+ * QNull Module
+ *
+ * Copyright (C) 2009, 2017 Red Hat Inc.
+ *
+ * Authors:
+ *  Luiz Capitulino <lcapitulino@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#ifndef QNULL_H
+#define QNULL_H
+
+#include "qapi/qmp/qobject.h"
+
+extern QObject qnull_;
+
+static inline QObject *qnull(void)
+{
+    qobject_incref(&qnull_);
+    return &qnull_;
+}
+
+#endif /* QNULL_H */
diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index b8ddbca..ef1d1a9 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -93,12 +93,4 @@ static inline QType qobject_type(const QObject *obj)
     return obj->type;
 }
 
-extern QObject qnull_;
-
-static inline QObject *qnull(void)
-{
-    qobject_incref(&qnull_);
-    return &qnull_;
-}
-
 #endif /* QOBJECT_H */
diff --git a/include/qapi/qmp/types.h b/include/qapi/qmp/types.h
index 27cfbd8..4c87182 100644
--- a/include/qapi/qmp/types.h
+++ b/include/qapi/qmp/types.h
@@ -20,5 +20,6 @@
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
+#include "qapi/qmp/qnull.h"
 
 #endif /* QAPI_QMP_TYPES_H */
diff --git a/qobject/qnull.c b/qobject/qnull.c
index c124d05..b3cc85e 100644
--- a/qobject/qnull.c
+++ b/qobject/qnull.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/qmp/qobject.h"
+#include "qapi/qmp/qnull.h"
 
 QObject qnull_ = {
     .type = QTYPE_QNULL,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b2b1d20..f118a54 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -29,11 +29,7 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qint.h"
-#include "qapi/qmp/qfloat.h"
+#include "qapi/qmp/types.h"
 
 #include "qapi-types.h"
 #include "qapi-visit.h"
diff --git a/tests/check-qnull.c b/tests/check-qnull.c
index 8dd1c96..4a67b9a 100644
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
2.9.4

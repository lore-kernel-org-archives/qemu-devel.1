Received: from eggs.gnu.org ([2001:4830:134:3::10]:45105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJQ-0000cc-7M
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJN-0005rq-3p
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49252 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJM-0005rK-VH
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 26BD3406E897
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:38 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:35:57 -0500
Message-Id: <20180312183628.394722-7-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 06/36] qapi: Add qobject_to()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Max Reitz <mreitz@redhat.com>

This is a dynamic casting macro that, given a QObject type, returns an
object as that type or NULL if the object is of a different type (or
NULL itself).

The macro uses lower-case letters because:
1. There does not seem to be a hard rule on whether qemu macros have to
   be upper-cased,
2. The current situation in qapi/qmp is inconsistent (compare e.g.
   QINCREF() vs. qdict_put()),
3. qobject_to() will evaluate its @obj parameter only once, thus it is
   generally not important to the caller whether it is a macro or not,
4. I prefer it aesthetically.

The macro parameter order is chosen with typename first for
consistency with other QAPI macros like QAPI_CLONE(), as well as
for legibility (read it as "qobject to" type "applied to" obj).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20180224154033.29559-3-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
[eblake: swap parameter order to list type first]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/qobject.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index 012439a2e3b..ea9702270e7 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -50,6 +50,22 @@ struct QObject {
 #define QDECREF(obj)              \
     qobject_decref(obj ? QOBJECT(obj) : NULL)

+/* Required for qobject_to() */
+#define QTYPE_CAST_TO_QNull     QTYPE_QNULL
+#define QTYPE_CAST_TO_QNum      QTYPE_QNUM
+#define QTYPE_CAST_TO_QString   QTYPE_QSTRING
+#define QTYPE_CAST_TO_QDict     QTYPE_QDICT
+#define QTYPE_CAST_TO_QList     QTYPE_QLIST
+#define QTYPE_CAST_TO_QBool     QTYPE_QBOOL
+
+QEMU_BUILD_BUG_MSG(QTYPE__MAX != 7,
+                   "The QTYPE_CAST_TO_* list needs to be extended");
+
+#define qobject_to(type, obj) \
+    container_of(qobject_check_type(obj, glue(QTYPE_CAST_TO_, type)) ?: \
+                     QOBJECT((type *)NULL), \
+                 type, base)
+
 /* Initialize an object to default values */
 static inline void qobject_init(QObject *obj, QType type)
 {
@@ -102,4 +118,18 @@ static inline QType qobject_type(const QObject *obj)
     return obj->type;
 }

+/**
+ * qobject_check_type(): Helper function for the qobject_to() macro.
+ * Return @obj, but only if @obj is not NULL and @type is equal to
+ * @obj's type.  Return NULL otherwise.
+ */
+static inline QObject *qobject_check_type(const QObject *obj, QType type)
+{
+    if (obj && qobject_type(obj) == type) {
+        return (QObject *)obj;
+    } else {
+        return NULL;
+    }
+}
+
 #endif /* QOBJECT_H */
-- 
2.14.3

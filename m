Received: from eggs.gnu.org ([2001:4830:134:3::10]:50455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epbwS-0000dI-NL
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 10:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epbwR-00053c-MT
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 10:40:52 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 24 Feb 2018 16:40:28 +0100
Message-Id: <20180224154033.29559-3-mreitz@redhat.com>
In-Reply-To: <20180224154033.29559-1-mreitz@redhat.com>
References: <20180224154033.29559-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/7] qapi: Add qobject_to()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

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

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/qapi/qmp/qobject.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index 38ac68845c..a448576b46 100644
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
+#define qobject_to(obj, type) \
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

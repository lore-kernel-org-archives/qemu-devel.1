Received: from eggs.gnu.org ([2001:4830:134:3::10]:48927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ1-0007K1-RH
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIl-0003s6-Pm
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:55 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:06 +0200
Message-Id: <1502117160-24655-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 02/56] qdict: New helpers to put and get
 unsigned integers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qdict.h |  5 +++++
 qobject/qdict.c          | 43 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index 363e431..3b52481 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -56,6 +56,8 @@ void qdict_destroy_obj(QObject *obj);
 /* Helpers for int, bool, and string */
 #define qdict_put_int(qdict, key, value) \
         qdict_put(qdict, key, qnum_from_int(value))
+#define qdict_put_uint(qdict, key, value) \
+        qdict_put(qdict, key, qnum_from_uint(value))
 #define qdict_put_bool(qdict, key, value) \
         qdict_put(qdict, key, qbool_from_bool(value))
 #define qdict_put_str(qdict, key, value) \
@@ -64,12 +66,15 @@ void qdict_destroy_obj(QObject *obj);
 /* High level helpers */
 double qdict_get_double(const QDict *qdict, const char *key);
 int64_t qdict_get_int(const QDict *qdict, const char *key);
+uint64_t qdict_get_uint(const QDict *qdict, const char *key);
 bool qdict_get_bool(const QDict *qdict, const char *key);
 QList *qdict_get_qlist(const QDict *qdict, const char *key);
 QDict *qdict_get_qdict(const QDict *qdict, const char *key);
 const char *qdict_get_str(const QDict *qdict, const char *key);
 int64_t qdict_get_try_int(const QDict *qdict, const char *key,
                           int64_t def_value);
+uint64_t qdict_get_try_uint(const QDict *qdict, const char *key,
+                            uint64_t def_value);
 bool qdict_get_try_bool(const QDict *qdict, const char *key, bool def_value);
 const char *qdict_get_try_str(const QDict *qdict, const char *key);
 
diff --git a/qobject/qdict.c b/qobject/qdict.c
index d795079..be919b9 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -189,10 +189,9 @@ double qdict_get_double(const QDict *qdict, const char *key)
 }
 
 /**
- * qdict_get_int(): Get an integer mapped by @key
+ * qdict_get_int(): Get a signed integer mapped by @key
  *
- * This function assumes that @key exists and it stores a
- * QNum representable as int.
+ * @qdict must map @key to an integer QNum that fits into int64_t.
  *
  * Return integer mapped by @key.
  */
@@ -202,6 +201,18 @@ int64_t qdict_get_int(const QDict *qdict, const char *key)
 }
 
 /**
+ * qdict_get_uint(): Get an unsigned integer mapped by 'key'
+ *
+ * @qdict must map @key to an integer QNum that fits into uint64_t.
+ *
+ * Return integer mapped by 'key'.
+ */
+uint64_t qdict_get_uint(const QDict *qdict, const char *key)
+{
+    return qnum_get_uint(qobject_to_qnum(qdict_get(qdict, key)));
+}
+
+/**
  * qdict_get_bool(): Get a bool mapped by @key
  *
  * This function assumes that @key exists and it stores a
@@ -245,11 +256,10 @@ const char *qdict_get_str(const QDict *qdict, const char *key)
 }
 
 /**
- * qdict_get_try_int(): Try to get integer mapped by @key
+ * qdict_get_try_int(): Try to get signed integer mapped by @key
  *
- * Return integer mapped by @key, if it is not present in the
- * dictionary or if the stored object is not a QNum representing an
- * integer, @def_value will be returned.
+ * If @qdict maps @key to an integer QNum that fits into int64_t,
+ * return it.  Else return @def_value.
  */
 int64_t qdict_get_try_int(const QDict *qdict, const char *key,
                           int64_t def_value)
@@ -265,6 +275,25 @@ int64_t qdict_get_try_int(const QDict *qdict, const char *key,
 }
 
 /**
+ * qdict_get_try_uint(): Try to get unsigned integer mapped by 'key'
+ *
+ * If @qdict maps @key to an integer QNum that fits into uint64_t,
+ * return it.  Else return @def_value.
+ */
+uint64_t qdict_get_try_uint(const QDict *qdict, const char *key,
+                            uint64_t def_value)
+{
+    QNum *qnum = qobject_to_qnum(qdict_get(qdict, key));
+    uint64_t val;
+
+    if (!qnum || !qnum_get_try_uint(qnum, &val)) {
+        return def_value;
+    }
+
+    return val;
+}
+
+/**
  * qdict_get_try_bool(): Try to get a bool mapped by @key
  *
  * Return bool mapped by @key, if it is not present in the
-- 
2.7.5

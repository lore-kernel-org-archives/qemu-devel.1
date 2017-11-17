Received: from eggs.gnu.org ([2001:4830:134:3::10]:43040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCZ-0001Jb-Qo
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCX-0002Pj-Fr
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:19 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Nov 2017 19:16:40 +0100
Message-Id: <20171117181653.20651-13-kwolf@redhat.com>
In-Reply-To: <20171117181653.20651-1-kwolf@redhat.com>
References: <20171117181653.20651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 12/25] qapi: Add qobject_is_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

This generic function (along with its implementations for different
types) determines whether two QObjects are equal.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-id: 20171114180128.17076-4-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/qapi/qmp/qbool.h   |  1 +
 include/qapi/qmp/qdict.h   |  1 +
 include/qapi/qmp/qlist.h   |  1 +
 include/qapi/qmp/qnull.h   |  2 ++
 include/qapi/qmp/qnum.h    |  1 +
 include/qapi/qmp/qobject.h |  9 ++++++++
 include/qapi/qmp/qstring.h |  1 +
 qobject/qbool.c            |  8 +++++++
 qobject/qdict.c            | 29 +++++++++++++++++++++++++
 qobject/qlist.c            | 32 +++++++++++++++++++++++++++
 qobject/qnull.c            |  9 ++++++++
 qobject/qnum.c             | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 qobject/qobject.c          | 29 +++++++++++++++++++++++++
 qobject/qstring.c          |  9 ++++++++
 14 files changed, 186 insertions(+)

diff --git a/include/qapi/qmp/qbool.h b/include/qapi/qmp/qbool.h
index a41111c309..f77ea86c4e 100644
--- a/include/qapi/qmp/qbool.h
+++ b/include/qapi/qmp/qbool.h
@@ -24,6 +24,7 @@ typedef struct QBool {
 QBool *qbool_from_bool(bool value);
 bool qbool_get_bool(const QBool *qb);
 QBool *qobject_to_qbool(const QObject *obj);
+bool qbool_is_equal(const QObject *x, const QObject *y);
 void qbool_destroy_obj(QObject *obj);
 
 #endif /* QBOOL_H */
diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index 7ea5120c4a..fc218e7be6 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -43,6 +43,7 @@ void qdict_del(QDict *qdict, const char *key);
 int qdict_haskey(const QDict *qdict, const char *key);
 QObject *qdict_get(const QDict *qdict, const char *key);
 QDict *qobject_to_qdict(const QObject *obj);
+bool qdict_is_equal(const QObject *x, const QObject *y);
 void qdict_iter(const QDict *qdict,
                 void (*iter)(const char *key, QObject *obj, void *opaque),
                 void *opaque);
diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
index 59d209bbae..ec3fcc1a4c 100644
--- a/include/qapi/qmp/qlist.h
+++ b/include/qapi/qmp/qlist.h
@@ -61,6 +61,7 @@ QObject *qlist_peek(QList *qlist);
 int qlist_empty(const QList *qlist);
 size_t qlist_size(const QList *qlist);
 QList *qobject_to_qlist(const QObject *obj);
+bool qlist_is_equal(const QObject *x, const QObject *y);
 void qlist_destroy_obj(QObject *obj);
 
 static inline const QListEntry *qlist_first(const QList *qlist)
diff --git a/include/qapi/qmp/qnull.h b/include/qapi/qmp/qnull.h
index d075549283..c992ee2ae1 100644
--- a/include/qapi/qmp/qnull.h
+++ b/include/qapi/qmp/qnull.h
@@ -27,4 +27,6 @@ static inline QNull *qnull(void)
     return &qnull_;
 }
 
+bool qnull_is_equal(const QObject *x, const QObject *y);
+
 #endif /* QNULL_H */
diff --git a/include/qapi/qmp/qnum.h b/include/qapi/qmp/qnum.h
index d6b0791139..c3d86794bb 100644
--- a/include/qapi/qmp/qnum.h
+++ b/include/qapi/qmp/qnum.h
@@ -69,6 +69,7 @@ double qnum_get_double(QNum *qn);
 char *qnum_to_string(QNum *qn);
 
 QNum *qobject_to_qnum(const QObject *obj);
+bool qnum_is_equal(const QObject *x, const QObject *y);
 void qnum_destroy_obj(QObject *obj);
 
 #endif /* QNUM_H */
diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index ef1d1a9237..38ac68845c 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -68,6 +68,15 @@ static inline void qobject_incref(QObject *obj)
 }
 
 /**
+ * qobject_is_equal(): Return whether the two objects are equal.
+ *
+ * Any of the pointers may be NULL; return true if both are.  Always
+ * return false if only one is (therefore a QNull object is not
+ * considered equal to a NULL pointer).
+ */
+bool qobject_is_equal(const QObject *x, const QObject *y);
+
+/**
  * qobject_destroy(): Free resources used by the object
  */
 void qobject_destroy(QObject *obj);
diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
index 10076b7c8c..65c05a9be5 100644
--- a/include/qapi/qmp/qstring.h
+++ b/include/qapi/qmp/qstring.h
@@ -31,6 +31,7 @@ void qstring_append_int(QString *qstring, int64_t value);
 void qstring_append(QString *qstring, const char *str);
 void qstring_append_chr(QString *qstring, int c);
 QString *qobject_to_qstring(const QObject *obj);
+bool qstring_is_equal(const QObject *x, const QObject *y);
 void qstring_destroy_obj(QObject *obj);
 
 #endif /* QSTRING_H */
diff --git a/qobject/qbool.c b/qobject/qbool.c
index 0606bbd2a3..ac825fc5a2 100644
--- a/qobject/qbool.c
+++ b/qobject/qbool.c
@@ -52,6 +52,14 @@ QBool *qobject_to_qbool(const QObject *obj)
 }
 
 /**
+ * qbool_is_equal(): Test whether the two QBools are equal
+ */
+bool qbool_is_equal(const QObject *x, const QObject *y)
+{
+    return qobject_to_qbool(x)->value == qobject_to_qbool(y)->value;
+}
+
+/**
  * qbool_destroy_obj(): Free all memory allocated by a
  * QBool object
  */
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 576018e531..e8f15f1132 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -403,6 +403,35 @@ void qdict_del(QDict *qdict, const char *key)
 }
 
 /**
+ * qdict_is_equal(): Test whether the two QDicts are equal
+ *
+ * Here, equality means whether they contain the same keys and whether
+ * the respective values are in turn equal (i.e. invoking
+ * qobject_is_equal() on them yields true).
+ */
+bool qdict_is_equal(const QObject *x, const QObject *y)
+{
+    const QDict *dict_x = qobject_to_qdict(x);
+    const QDict *dict_y = qobject_to_qdict(y);
+    const QDictEntry *e;
+
+    if (qdict_size(dict_x) != qdict_size(dict_y)) {
+        return false;
+    }
+
+    for (e = qdict_first(dict_x); e; e = qdict_next(dict_x, e)) {
+        const QObject *obj_x = qdict_entry_value(e);
+        const QObject *obj_y = qdict_get(dict_y, qdict_entry_key(e));
+
+        if (!qobject_is_equal(obj_x, obj_y)) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+/**
  * qdict_destroy_obj(): Free all the memory allocated by a QDict
  */
 void qdict_destroy_obj(QObject *obj)
diff --git a/qobject/qlist.c b/qobject/qlist.c
index 86b60cb88c..3ef57d31d1 100644
--- a/qobject/qlist.c
+++ b/qobject/qlist.c
@@ -140,6 +140,38 @@ QList *qobject_to_qlist(const QObject *obj)
 }
 
 /**
+ * qlist_is_equal(): Test whether the two QLists are equal
+ *
+ * In order to be considered equal, the respective two objects at each
+ * index of the two lists have to compare equal (regarding
+ * qobject_is_equal()), and both lists have to have the same number of
+ * elements.
+ * That means both lists have to contain equal objects in equal order.
+ */
+bool qlist_is_equal(const QObject *x, const QObject *y)
+{
+    const QList *list_x = qobject_to_qlist(x);
+    const QList *list_y = qobject_to_qlist(y);
+    const QListEntry *entry_x, *entry_y;
+
+    entry_x = qlist_first(list_x);
+    entry_y = qlist_first(list_y);
+
+    while (entry_x && entry_y) {
+        if (!qobject_is_equal(qlist_entry_obj(entry_x),
+                              qlist_entry_obj(entry_y)))
+        {
+            return false;
+        }
+
+        entry_x = qlist_next(entry_x);
+        entry_y = qlist_next(entry_y);
+    }
+
+    return !entry_x && !entry_y;
+}
+
+/**
  * qlist_destroy_obj(): Free all the memory allocated by a QList
  */
 void qlist_destroy_obj(QObject *obj)
diff --git a/qobject/qnull.c b/qobject/qnull.c
index bc9fd31626..f6f55f11ea 100644
--- a/qobject/qnull.c
+++ b/qobject/qnull.c
@@ -20,3 +20,12 @@ QNull qnull_ = {
         .refcnt = 1,
     },
 };
+
+/**
+ * qnull_is_equal(): Always return true because any two QNull objects
+ * are equal.
+ */
+bool qnull_is_equal(const QObject *x, const QObject *y)
+{
+    return true;
+}
diff --git a/qobject/qnum.c b/qobject/qnum.c
index 476e81c93b..410686a611 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -213,6 +213,60 @@ QNum *qobject_to_qnum(const QObject *obj)
 }
 
 /**
+ * qnum_is_equal(): Test whether the two QNums are equal
+ *
+ * Negative integers are never considered equal to unsigned integers,
+ * but positive integers in the range [0, INT64_MAX] are considered
+ * equal independently of whether the QNum's kind is i64 or u64.
+ *
+ * Doubles are never considered equal to integers.
+ */
+bool qnum_is_equal(const QObject *x, const QObject *y)
+{
+    QNum *num_x = qobject_to_qnum(x);
+    QNum *num_y = qobject_to_qnum(y);
+
+    switch (num_x->kind) {
+    case QNUM_I64:
+        switch (num_y->kind) {
+        case QNUM_I64:
+            /* Comparison in native int64_t type */
+            return num_x->u.i64 == num_y->u.i64;
+        case QNUM_U64:
+            /* Implicit conversion of x to uin64_t, so we have to
+             * check its sign before */
+            return num_x->u.i64 >= 0 && num_x->u.i64 == num_y->u.u64;
+        case QNUM_DOUBLE:
+            return false;
+        }
+        abort();
+    case QNUM_U64:
+        switch (num_y->kind) {
+        case QNUM_I64:
+            return qnum_is_equal(y, x);
+        case QNUM_U64:
+            /* Comparison in native uint64_t type */
+            return num_x->u.u64 == num_y->u.u64;
+        case QNUM_DOUBLE:
+            return false;
+        }
+        abort();
+    case QNUM_DOUBLE:
+        switch (num_y->kind) {
+        case QNUM_I64:
+        case QNUM_U64:
+            return false;
+        case QNUM_DOUBLE:
+            /* Comparison in native double type */
+            return num_x->u.dbl == num_y->u.dbl;
+        }
+        abort();
+    }
+
+    abort();
+}
+
+/**
  * qnum_destroy_obj(): Free all memory allocated by a
  * QNum object
  */
diff --git a/qobject/qobject.c b/qobject/qobject.c
index b0cafb66f1..b2a536041d 100644
--- a/qobject/qobject.c
+++ b/qobject/qobject.c
@@ -27,3 +27,32 @@ void qobject_destroy(QObject *obj)
     assert(QTYPE_QNULL < obj->type && obj->type < QTYPE__MAX);
     qdestroy[obj->type](obj);
 }
+
+
+static bool (*qis_equal[QTYPE__MAX])(const QObject *, const QObject *) = {
+    [QTYPE_NONE] = NULL,               /* No such object exists */
+    [QTYPE_QNULL] = qnull_is_equal,
+    [QTYPE_QNUM] = qnum_is_equal,
+    [QTYPE_QSTRING] = qstring_is_equal,
+    [QTYPE_QDICT] = qdict_is_equal,
+    [QTYPE_QLIST] = qlist_is_equal,
+    [QTYPE_QBOOL] = qbool_is_equal,
+};
+
+bool qobject_is_equal(const QObject *x, const QObject *y)
+{
+    /* We cannot test x == y because an object does not need to be
+     * equal to itself (e.g. NaN floats are not). */
+
+    if (!x && !y) {
+        return true;
+    }
+
+    if (!x || !y || x->type != y->type) {
+        return false;
+    }
+
+    assert(QTYPE_NONE < x->type && x->type < QTYPE__MAX);
+
+    return qis_equal[x->type](x, y);
+}
diff --git a/qobject/qstring.c b/qobject/qstring.c
index 5da7b5f37c..74182a1c02 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -129,6 +129,15 @@ const char *qstring_get_str(const QString *qstring)
 }
 
 /**
+ * qstring_is_equal(): Test whether the two QStrings are equal
+ */
+bool qstring_is_equal(const QObject *x, const QObject *y)
+{
+    return !strcmp(qobject_to_qstring(x)->string,
+                   qobject_to_qstring(y)->string);
+}
+
+/**
  * qstring_destroy_obj(): Free all memory allocated by a QString
  * object
  */
-- 
2.13.6

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSpb4-00042s-2t
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 15:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSpb0-0005v0-SA
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 15:04:22 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  5 Jul 2017 21:04:01 +0200
Message-Id: <20170705190404.22449-3-mreitz@redhat.com>
In-Reply-To: <20170705190404.22449-1-mreitz@redhat.com>
References: <20170705190404.22449-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/5] qapi: Add qobject_is_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

This generic function (along with its implementations for different
types) determines whether two QObjects are equal.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
Markus also proposed just reporting two values as unequal if they have a
different internal representation (i.e. a different QNum kind).

I don't like this very much, because I feel like QInt and QFloat have
been unified for a reason: Outside of these classes, nobody should care
about the exact internal representation.  In JSON, there is no
difference anyway.  We probably want to use integers as long as we can
and doubles whenever we cannot.

In any case, I feel like the class should hide the different internal
representations from the user.  This necessitates being able to compare
floating point values against integers.  Since apparently the main use
of QObject is to parse and emit JSON (and represent such objects
internally), we also have to agree that JSON doesn't make a difference:
42 is just the same as 42.0.

Finally, I think it's rather pointless not to consider 42u and 42 the
same value.  But since unsigned/signed are two different kinds of QNums
already, we cannot consider them equal without considering 42.0 equal,
too.

Because of this, I have decided to continue to compare QNum values even
if they are of a different kind.
---
 include/qapi/qmp/qbool.h   |  1 +
 include/qapi/qmp/qdict.h   |  1 +
 include/qapi/qmp/qlist.h   |  1 +
 include/qapi/qmp/qnull.h   |  2 ++
 include/qapi/qmp/qnum.h    |  1 +
 include/qapi/qmp/qobject.h |  9 ++++++
 include/qapi/qmp/qstring.h |  1 +
 qobject/qbool.c            |  8 +++++
 qobject/qdict.c            | 29 ++++++++++++++++++
 qobject/qlist.c            | 32 ++++++++++++++++++++
 qobject/qnull.c            |  9 ++++++
 qobject/qnum.c             | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 qobject/qobject.c          | 29 ++++++++++++++++++
 qobject/qstring.c          |  9 ++++++
 14 files changed, 205 insertions(+)

diff --git a/include/qapi/qmp/qbool.h b/include/qapi/qmp/qbool.h
index a41111c..f77ea86 100644
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
index 363e431..84f8ea7 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -42,6 +42,7 @@ void qdict_del(QDict *qdict, const char *key);
 int qdict_haskey(const QDict *qdict, const char *key);
 QObject *qdict_get(const QDict *qdict, const char *key);
 QDict *qobject_to_qdict(const QObject *obj);
+bool qdict_is_equal(const QObject *x, const QObject *y);
 void qdict_iter(const QDict *qdict,
                 void (*iter)(const char *key, QObject *obj, void *opaque),
                 void *opaque);
diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
index c4b5fda..24e1e9f 100644
--- a/include/qapi/qmp/qlist.h
+++ b/include/qapi/qmp/qlist.h
@@ -58,6 +58,7 @@ QObject *qlist_peek(QList *qlist);
 int qlist_empty(const QList *qlist);
 size_t qlist_size(const QList *qlist);
 QList *qobject_to_qlist(const QObject *obj);
+bool qlist_is_equal(const QObject *x, const QObject *y);
 void qlist_destroy_obj(QObject *obj);
 
 static inline const QListEntry *qlist_first(const QList *qlist)
diff --git a/include/qapi/qmp/qnull.h b/include/qapi/qmp/qnull.h
index 48edad4..f4fbcae 100644
--- a/include/qapi/qmp/qnull.h
+++ b/include/qapi/qmp/qnull.h
@@ -23,4 +23,6 @@ static inline QObject *qnull(void)
     return &qnull_;
 }
 
+bool qnull_is_equal(const QObject *x, const QObject *y);
+
 #endif /* QNULL_H */
diff --git a/include/qapi/qmp/qnum.h b/include/qapi/qmp/qnum.h
index 09d745c..237d01b 100644
--- a/include/qapi/qmp/qnum.h
+++ b/include/qapi/qmp/qnum.h
@@ -48,6 +48,7 @@ double qnum_get_double(QNum *qn);
 char *qnum_to_string(QNum *qn);
 
 QNum *qobject_to_qnum(const QObject *obj);
+bool qnum_is_equal(const QObject *x, const QObject *y);
 void qnum_destroy_obj(QObject *obj);
 
 #endif /* QNUM_H */
diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index ef1d1a9..38ac688 100644
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
index 10076b7..65c05a9 100644
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
index 0606bbd..ac825fc 100644
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
index 576018e..e8f15f1 100644
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
index 86b60cb..3ef57d3 100644
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
index 43918f1..4b9cdbc 100644
--- a/qobject/qnull.c
+++ b/qobject/qnull.c
@@ -18,3 +18,12 @@ QObject qnull_ = {
     .type = QTYPE_QNULL,
     .refcnt = 1,
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
index 476e81c..96c348c 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -18,6 +18,8 @@
 #include "qapi/qmp/qobject.h"
 #include "qemu-common.h"
 
+#include <math.h>
+
 /**
  * qnum_from_int(): Create a new QNum from an int64_t
  *
@@ -213,6 +215,77 @@ QNum *qobject_to_qnum(const QObject *obj)
 }
 
 /**
+ * qnum_is_equal(): Test whether the two QNums are equal
+ *
+ * Negative integers are never considered equal to unsigned integers.
+ * Doubles are only considered equal to integers if their fractional
+ * part is zero and their integral part is exactly equal to the
+ * integer.  Because doubles have limited precision, there are
+ * therefore integers which do not have an equal double (e.g.
+ * INT64_MAX).
+ */
+bool qnum_is_equal(const QObject *x, const QObject *y)
+{
+    QNum *num_x = qobject_to_qnum(x);
+    QNum *num_y = qobject_to_qnum(y);
+    double integral_part; /* Needed for the modf() calls below */
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
+            /* Comparing x to y in double (which the implicit
+             * conversion would do) is not exact.  So after having
+             * checked that y is an integer in the int64_t range
+             * (i.e. that it is within bounds and its fractional part
+             * is zero), compare both as integers. */
+            return num_y->u.dbl >= -0x1p63 && num_y->u.dbl < 0x1p63 &&
+                modf(num_y->u.dbl, &integral_part) == 0.0 &&
+                num_x->u.i64 == (int64_t)num_y->u.dbl;
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
+            /* Comparing x to y in double (which the implicit
+             * conversion would do) is not exact.  So after having
+             * checked that y is an integer in the uint64_t range
+             * (i.e. that it is within bounds and its fractional part
+             * is zero), compare both as integers. */
+            return num_y->u.dbl >= 0 && num_y->u.dbl < 0x1p64 &&
+                modf(num_y->u.dbl, &integral_part) == 0.0 &&
+                num_x->u.u64 == (uint64_t)num_y->u.dbl;
+        }
+        abort();
+    case QNUM_DOUBLE:
+        switch (num_y->kind) {
+        case QNUM_I64:
+            return qnum_is_equal(y, x);
+        case QNUM_U64:
+            return qnum_is_equal(y, x);
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
index b0cafb6..b2a5360 100644
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
index 5da7b5f..74182a1 100644
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
2.9.4

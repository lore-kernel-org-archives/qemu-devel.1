Received: from eggs.gnu.org ([2001:4830:134:3::10]:52199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG49G-0003zv-Sc
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG49E-00046o-8s
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:58:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG49D-00046d-Vk
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:58:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4EE4448D7D
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 13:58:50 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:56:36 +0400
Message-Id: <20170531135709.345-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/45] qnum: add uint type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

In order to store integer values superior to INT64_MAX, add a u64
internal representation.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/qnum.h |  4 ++++
 qobject/qnum.c          | 51 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 tests/check-qnum.c      | 47 +++++++++++++++++++++++++++++++++++++++++++=
++
 3 files changed, 102 insertions(+)

diff --git a/include/qapi/qmp/qnum.h b/include/qapi/qmp/qnum.h
index cc636fac5f..549b2117ec 100644
--- a/include/qapi/qmp/qnum.h
+++ b/include/qapi/qmp/qnum.h
@@ -18,6 +18,7 @@
=20
 typedef enum {
     QNUM_I64,
+    QNUM_U64,
     QNUM_DOUBLE
 } QNumKind;
=20
@@ -26,14 +27,17 @@ typedef struct QNum {
     QNumKind kind;
     union {
         int64_t i64;
+        uint64_t u64;
         double dbl;
     } u;
 } QNum;
=20
 QNum *qnum_from_int(int64_t value);
+QNum *qnum_from_uint(uint64_t value);
 QNum *qnum_from_double(double value);
=20
 bool qnum_get_int(const QNum *qn, int64_t *val);
+bool qnum_get_uint(const QNum *qn, uint64_t *val);
 double qnum_get_double(QNum *qn);
=20
 char *qnum_to_string(QNum *qn);
diff --git a/qobject/qnum.c b/qobject/qnum.c
index f16864160a..4ad37ed5bc 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -34,6 +34,22 @@ QNum *qnum_from_int(int64_t value)
 }
=20
 /**
+ * qnum_from_uint(): Create a new QNum from an uint64_t
+ *
+ * Return strong reference.
+ */
+QNum *qnum_from_uint(uint64_t value)
+{
+    QNum *qn =3D g_new(QNum, 1);
+
+    qobject_init(QOBJECT(qn), QTYPE_QNUM);
+    qn->kind =3D QNUM_U64;
+    qn->u.u64 =3D value;
+
+    return qn;
+}
+
+/**
  * qnum_from_double(): Create a new QNum from a double
  *
  * Return strong reference.
@@ -60,6 +76,37 @@ bool qnum_get_int(const QNum *qn, int64_t *val)
     case QNUM_I64:
         *val =3D qn->u.i64;
         return true;
+    case QNUM_U64:
+        if (qn->u.u64 > INT64_MAX) {
+            return false;
+        }
+        *val =3D qn->u.u64;
+        return true;
+    case QNUM_DOUBLE:
+        return false;
+    }
+
+    g_assert_not_reached();
+    return false;
+}
+
+/**
+ * qnum_get_uint(): Get an unsigned integer from the number
+ *
+ * Return true on success.
+ */
+bool qnum_get_uint(const QNum *qn, uint64_t *val)
+{
+    switch (qn->kind) {
+    case QNUM_I64:
+        if (qn->u.i64 < 0) {
+            return false;
+        }
+        *val =3D qn->u.i64;
+        return true;
+    case QNUM_U64:
+        *val =3D qn->u.u64;
+        return true;
     case QNUM_DOUBLE:
         return false;
     }
@@ -76,6 +123,8 @@ double qnum_get_double(QNum *qn)
     switch (qn->kind) {
     case QNUM_I64:
         return qn->u.i64;
+    case QNUM_U64:
+        return qn->u.u64;
     case QNUM_DOUBLE:
         return qn->u.dbl;
     }
@@ -91,6 +140,8 @@ char *qnum_to_string(QNum *qn)
     switch (qn->kind) {
     case QNUM_I64:
         return g_strdup_printf("%" PRId64, qn->u.i64);
+    case QNUM_U64:
+        return g_strdup_printf("%" PRIu64, qn->u.u64);
     case QNUM_DOUBLE:
         /* FIXME: snprintf() is locale dependent; but JSON requires
          * numbers to be formatted as if in the C locale. Dependence
diff --git a/tests/check-qnum.c b/tests/check-qnum.c
index 7cc4262ee7..234fd7fc82 100644
--- a/tests/check-qnum.c
+++ b/tests/check-qnum.c
@@ -35,6 +35,20 @@ static void qnum_from_int_test(void)
     QDECREF(qi);
 }
=20
+static void qnum_from_uint_test(void)
+{
+    QNum *qu;
+    const int value =3D UINT_MAX;
+
+    qu =3D qnum_from_int(value);
+    g_assert(qu !=3D NULL);
+    g_assert(qu->u.u64 =3D=3D value);
+    g_assert(qu->base.refcnt =3D=3D 1);
+    g_assert(qobject_type(QOBJECT(qu)) =3D=3D QTYPE_QNUM);
+
+    QDECREF(qu);
+}
+
 static void qnum_from_double_test(void)
 {
     QNum *qf;
@@ -73,6 +87,37 @@ static void qnum_get_int_test(void)
     QDECREF(qi);
 }
=20
+static void qnum_get_uint_test(void)
+{
+    QNum *qn;
+    const int value =3D 123456;
+    uint64_t val;
+    int64_t ival;
+
+    qn =3D qnum_from_uint(value);
+    g_assert(qnum_get_uint(qn, &val));
+    g_assert_cmpuint(val, =3D=3D, value);
+    QDECREF(qn);
+
+    qn =3D qnum_from_int(value);
+    g_assert(qnum_get_uint(qn, &val));
+    g_assert_cmpuint(val, =3D=3D, value);
+    QDECREF(qn);
+
+    /* invalid cases */
+    qn =3D qnum_from_int(-1);
+    g_assert(!qnum_get_uint(qn, &val));
+    QDECREF(qn);
+
+    qn =3D qnum_from_uint(-1ULL);
+    g_assert(!qnum_get_int(qn, &ival));
+    QDECREF(qn);
+
+    qn =3D qnum_from_double(0.42);
+    g_assert(!qnum_get_uint(qn, &val));
+    QDECREF(qn);
+}
+
 static void qobject_to_qnum_test(void)
 {
     QNum *qn;
@@ -109,9 +154,11 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
=20
     g_test_add_func("/qnum/from_int", qnum_from_int_test);
+    g_test_add_func("/qnum/from_uint", qnum_from_uint_test);
     g_test_add_func("/qnum/from_double", qnum_from_double_test);
     g_test_add_func("/qnum/from_int64", qnum_from_int64_test);
     g_test_add_func("/qnum/get_int", qnum_get_int_test);
+    g_test_add_func("/qnum/get_uint", qnum_get_uint_test);
     g_test_add_func("/qnum/to_qnum", qobject_to_qnum_test);
     g_test_add_func("/qnum/to_string", qnum_to_string_test);
=20
--=20
2.13.0.91.g00982b8dd

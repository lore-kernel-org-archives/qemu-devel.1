Received: from eggs.gnu.org ([2001:4830:134:3::10]:45490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d895K-0006t9-0F
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d895I-0004I1-Tf
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:38:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d895I-0004Hs-FA
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:38:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E46EC04B94F
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 17:38:03 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 20:35:48 +0300
Message-Id: <20170509173559.31598-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170509173559.31598-1-marcandre.lureau@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/17] qnum: add uint type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

In order to store integer values superior to INT64_MAX, add a u64
internal representation.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/qnum.h |  4 ++++
 qobject/qnum.c          | 49 +++++++++++++++++++++++++++++++++++++++++++=
++++
 tests/check-qnum.c      | 51 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 3 files changed, 104 insertions(+)

diff --git a/include/qapi/qmp/qnum.h b/include/qapi/qmp/qnum.h
index 0e51427821..89c14e040f 100644
--- a/include/qapi/qmp/qnum.h
+++ b/include/qapi/qmp/qnum.h
@@ -17,6 +17,7 @@
=20
 typedef enum {
     QNUM_I64,
+    QNUM_U64,
     QNUM_DOUBLE
 } QNumType;
=20
@@ -25,14 +26,17 @@ typedef struct QNum {
     QNumType type;
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
 int64_t qnum_get_int(const QNum *qi, Error **errp);
+uint64_t qnum_get_uint(const QNum *qi, Error **errp);
 double qnum_get_double(QNum *qn);
=20
 char *qnum_to_string(QNum *qn);
diff --git a/qobject/qnum.c b/qobject/qnum.c
index 8e9dd38350..be6307accf 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -13,6 +13,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qobject.h"
 #include "qemu-common.h"
@@ -34,6 +35,22 @@ QNum *qnum_from_int(int64_t value)
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
+    qn->type =3D QNUM_U64;
+    qn->u.u64 =3D value;
+
+    return qn;
+}
+
+/**
  * qnum_from_double(): Create a new QNum from a double
  *
  * Return strong reference.
@@ -57,6 +74,34 @@ int64_t qnum_get_int(const QNum *qn, Error **errp)
     switch (qn->type) {
     case QNUM_I64:
         return qn->u.i64;
+    case QNUM_U64:
+        if (qn->u.u64 > INT64_MAX) {
+            error_setg(errp, "The number is too large, use qnum_get_uint=
()");
+            return 0;
+        }
+        return qn->u.u64;
+    case QNUM_DOUBLE:
+        error_setg(errp, "The number is a float");
+        return 0;
+    }
+
+    g_assert_not_reached();
+}
+
+/**
+ * qnum_get_uint(): Get an unsigned integer from the number
+ */
+uint64_t qnum_get_uint(const QNum *qn, Error **errp)
+{
+    switch (qn->type) {
+    case QNUM_I64:
+        if (qn->u.i64 < 0) {
+            error_setg(errp, "The number is negative");
+            return 0;
+        }
+        return qn->u.i64;
+    case QNUM_U64:
+        return qn->u.u64;
     case QNUM_DOUBLE:
         error_setg(errp, "The number is a float");
         return 0;
@@ -73,6 +118,8 @@ double qnum_get_double(QNum *qn)
     switch (qn->type) {
     case QNUM_I64:
         return qn->u.i64;
+    case QNUM_U64:
+        return qn->u.u64;
     case QNUM_DOUBLE:
         return qn->u.dbl;
     }
@@ -88,6 +135,8 @@ char *qnum_to_string(QNum *qn)
     switch (qn->type) {
     case QNUM_I64:
         return g_strdup_printf("%" PRId64, qn->u.i64);
+    case QNUM_U64:
+        return g_strdup_printf("%" PRIu64, qn->u.u64);
     case QNUM_DOUBLE:
         /* FIXME: snprintf() is locale dependent; but JSON requires
          * numbers to be formatted as if in the C locale. Dependence
diff --git a/tests/check-qnum.c b/tests/check-qnum.c
index d08d35e85a..8199546f99 100644
--- a/tests/check-qnum.c
+++ b/tests/check-qnum.c
@@ -36,6 +36,21 @@ static void qnum_from_int_test(void)
     g_free(qi);
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
+    // destroy doesn't exit yet
+    g_free(qu);
+}
+
 static void qnum_from_double_test(void)
 {
     QNum *qf;
@@ -73,6 +88,37 @@ static void qnum_get_int_test(void)
     QDECREF(qi);
 }
=20
+static void qnum_get_uint_test(void)
+{
+    QNum *qn;
+    const int value =3D 123456;
+    Error *err =3D NULL;
+
+    qn =3D qnum_from_uint(value);
+    g_assert(qnum_get_uint(qn, &error_abort) =3D=3D value);
+    QDECREF(qn);
+
+    qn =3D qnum_from_int(value);
+    g_assert(qnum_get_uint(qn, &error_abort) =3D=3D value);
+    QDECREF(qn);
+
+    qn =3D qnum_from_int(-1);
+    qnum_get_uint(qn, &err);
+    error_free_or_abort(&err);
+    QDECREF(qn);
+
+    qn =3D qnum_from_uint(-1ULL);
+    qnum_get_int(qn, &err);
+    error_free_or_abort(&err);
+    QDECREF(qn);
+
+    /* invalid case */
+    qn =3D qnum_from_double(0.42);
+    qnum_get_uint(qn, &err);
+    error_free_or_abort(&err);
+    QDECREF(qn);
+}
+
 static void qobject_to_qnum_test(void)
 {
     QNum *qn;
@@ -111,6 +157,9 @@ static void qnum_destroy_test(void)
     qn =3D qnum_from_int(0);
     QDECREF(qn);
=20
+    qn =3D qnum_from_uint(0);
+    QDECREF(qn);
+
     qn =3D qnum_from_double(0.42);
     QDECREF(qn);
 }
@@ -120,10 +169,12 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
=20
     g_test_add_func("/qnum/from_int", qnum_from_int_test);
+    g_test_add_func("/qnum/from_uint", qnum_from_uint_test);
     g_test_add_func("/qnum/from_double", qnum_from_double_test);
     g_test_add_func("/qnum/destroy", qnum_destroy_test);
     g_test_add_func("/qnum/from_int64", qnum_from_int64_test);
     g_test_add_func("/qnum/get_int", qnum_get_int_test);
+    g_test_add_func("/qnum/get_uint", qnum_get_uint_test);
     g_test_add_func("/qnum/to_qnum", qobject_to_qnum_test);
     g_test_add_func("/qnum/to_string", qnum_to_string_test);
=20
--=20
2.13.0.rc1.16.gd80b50c3f

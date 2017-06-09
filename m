Received: from eggs.gnu.org ([2001:4830:134:3::10]:38282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKGF-0000cL-La
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKGE-0003XE-DZ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJKGE-0003WU-4u
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1826D85541
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 13:47:33 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  9 Jun 2017 15:46:53 +0200
Message-Id: <1497016045-6009-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1497016045-6009-1-git-send-email-armbru@redhat.com>
References: <1497016045-6009-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/41] qnum: add uint type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

In order to store integer values between INT64_MAX and UINT64_MAX, add
a uint64_t internal representation.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170607163635.17635-10-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qnum.h |  7 ++++++
 qobject/qnum.c          | 64 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 tests/check-qnum.c      | 48 +++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)

diff --git a/include/qapi/qmp/qnum.h b/include/qapi/qmp/qnum.h
index e42b136..09d745c 100644
--- a/include/qapi/qmp/qnum.h
+++ b/include/qapi/qmp/qnum.h
@@ -19,6 +19,7 @@
=20
 typedef enum {
     QNUM_I64,
+    QNUM_U64,
     QNUM_DOUBLE
 } QNumKind;
=20
@@ -27,15 +28,21 @@ typedef struct QNum {
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
 bool qnum_get_try_int(const QNum *qn, int64_t *val);
 int64_t qnum_get_int(const QNum *qn);
+
+bool qnum_get_try_uint(const QNum *qn, uint64_t *val);
+uint64_t qnum_get_uint(const QNum *qn);
+
 double qnum_get_double(QNum *qn);
=20
 char *qnum_to_string(QNum *qn);
diff --git a/qobject/qnum.c b/qobject/qnum.c
index d88e4f7..52918ac 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -35,6 +35,22 @@ QNum *qnum_from_int(int64_t value)
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
@@ -61,6 +77,12 @@ bool qnum_get_try_int(const QNum *qn, int64_t *val)
     case QNUM_I64:
         *val =3D qn->u.i64;
         return true;
+    case QNUM_U64:
+        if (qn->u.u64 > INT64_MAX) {
+            return false;
+        }
+        *val =3D qn->u.u64;
+        return true;
     case QNUM_DOUBLE:
         return false;
     }
@@ -83,6 +105,44 @@ int64_t qnum_get_int(const QNum *qn)
 }
=20
 /**
+ * qnum_get_uint(): Get an unsigned integer from the number
+ *
+ * Return true on success.
+ */
+bool qnum_get_try_uint(const QNum *qn, uint64_t *val)
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
+    case QNUM_DOUBLE:
+        return false;
+    }
+
+    assert(0);
+    return false;
+}
+
+/**
+ * qnum_get_uint(): Get an unsigned integer from the number
+ *
+ * assert() on failure.
+ */
+uint64_t qnum_get_uint(const QNum *qn)
+{
+    uint64_t val;
+    bool success =3D qnum_get_try_uint(qn, &val);
+    assert(success);
+    return val;
+}
+
+/**
  * qnum_get_double(): Get a float representation of the number
  *
  * qnum_get_double() loses precision for integers beyond 53 bits.
@@ -92,6 +152,8 @@ double qnum_get_double(QNum *qn)
     switch (qn->kind) {
     case QNUM_I64:
         return qn->u.i64;
+    case QNUM_U64:
+        return qn->u.u64;
     case QNUM_DOUBLE:
         return qn->u.dbl;
     }
@@ -107,6 +169,8 @@ char *qnum_to_string(QNum *qn)
     switch (qn->kind) {
     case QNUM_I64:
         return g_strdup_printf("%" PRId64, qn->u.i64);
+    case QNUM_U64:
+        return g_strdup_printf("%" PRIu64, qn->u.u64);
     case QNUM_DOUBLE:
         /* FIXME: snprintf() is locale dependent; but JSON requires
          * numbers to be formatted as if in the C locale. Dependence
diff --git a/tests/check-qnum.c b/tests/check-qnum.c
index da7e0b0..d702d5d 100644
--- a/tests/check-qnum.c
+++ b/tests/check-qnum.c
@@ -39,6 +39,21 @@ static void qnum_from_int_test(void)
     QDECREF(qn);
 }
=20
+static void qnum_from_uint_test(void)
+{
+    QNum *qn;
+    const uint64_t value =3D UINT64_MAX;
+
+    qn =3D qnum_from_uint(value);
+    g_assert(qn !=3D NULL);
+    g_assert_cmpint(qn->kind, =3D=3D, QNUM_U64);
+    g_assert(qn->u.u64 =3D=3D value);
+    g_assert(qn->base.refcnt =3D=3D 1);
+    g_assert(qobject_type(QOBJECT(qn)) =3D=3D QTYPE_QNUM);
+
+    QDECREF(qn);
+}
+
 static void qnum_from_double_test(void)
 {
     QNum *qn;
@@ -76,6 +91,37 @@ static void qnum_get_int_test(void)
     QDECREF(qn);
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
+    g_assert(qnum_get_try_uint(qn, &val));
+    g_assert_cmpuint(val, =3D=3D, value);
+    QDECREF(qn);
+
+    qn =3D qnum_from_int(value);
+    g_assert(qnum_get_try_uint(qn, &val));
+    g_assert_cmpuint(val, =3D=3D, value);
+    QDECREF(qn);
+
+    /* invalid cases */
+    qn =3D qnum_from_int(-1);
+    g_assert(!qnum_get_try_uint(qn, &val));
+    QDECREF(qn);
+
+    qn =3D qnum_from_uint(-1ULL);
+    g_assert(!qnum_get_try_int(qn, &ival));
+    QDECREF(qn);
+
+    qn =3D qnum_from_double(0.42);
+    g_assert(!qnum_get_try_uint(qn, &val));
+    QDECREF(qn);
+}
+
 static void qobject_to_qnum_test(void)
 {
     QNum *qn;
@@ -112,9 +158,11 @@ int main(int argc, char **argv)
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
2.7.5

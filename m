Received: from eggs.gnu.org ([2001:4830:134:3::10]:58786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzq-0002H2-S9
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzp-0002eO-FM
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cmgzp-0002e4-61
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:45 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 11 Mar 2017 17:22:46 +0400
Message-Id: <20170311132256.22951-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-1-marcandre.lureau@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/21] qdict: learn to lookup quint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anderson@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Since a number may be parsed as an integer if it fits, learn to deal
with this situtation and fallback on QInt if QUint failed. There is no
need for exact type getters in qemu yet.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/qdict.h |  2 ++
 qobject/qdict.c          | 37 ++++++++++++++++++++++++++++++++++++-
 tests/check-qdict.c      | 31 +++++++++++++++++++++++++++++++
 util/qemu-option.c       |  6 ++++++
 4 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index fe9a4c5c60..dae3149603 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -61,6 +61,8 @@ QDict *qdict_get_qdict(const QDict *qdict, const char *=
key);
 const char *qdict_get_str(const QDict *qdict, const char *key);
 int64_t qdict_get_try_int(const QDict *qdict, const char *key,
                           int64_t def_value);
+uint64_t qdict_get_try_uint(const QDict *qdict, const char *key,
+                            Error **errp);
 bool qdict_get_try_bool(const QDict *qdict, const char *key, bool def_va=
lue);
 const char *qdict_get_try_str(const QDict *qdict, const char *key);
=20
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 291eef1a19..8d5c028181 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -12,6 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/qmp/qint.h"
+#include "qapi/qmp/quint.h"
 #include "qapi/qmp/qfloat.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qbool.h"
@@ -181,7 +182,7 @@ size_t qdict_size(const QDict *qdict)
  * qdict_get_double(): Get an number mapped by 'key'
  *
  * This function assumes that 'key' exists and it stores a
- * QFloat or QInt object.
+ * QFloat, QInt or QUInt object.
  *
  * Return number mapped by 'key'.
  */
@@ -195,6 +196,8 @@ double qdict_get_double(const QDict *qdict, const cha=
r *key)
         return qfloat_get_double(qobject_to_qfloat(obj));
     case QTYPE_QINT:
         return qint_get_int(qobject_to_qint(obj));
+    case QTYPE_QUINT:
+        return quint_get_uint(qobject_to_quint(obj));
     default:
         abort();
     }
@@ -272,6 +275,38 @@ int64_t qdict_get_try_int(const QDict *qdict, const =
char *key,
 }
=20
 /**
+ * qdict_get_try_uint(): Try to get unsigned mapped by 'key'
+ *
+ * Return integer mapped by 'key', if it is not present in
+ * the dictionary or with negative value, returns 0 and set error.
+ */
+uint64_t qdict_get_try_uint(const QDict *qdict, const char *key,
+                            Error **errp)
+{
+    QUInt *quint =3D qobject_to_quint(qdict_get(qdict, key));
+    QInt *qint;
+    int val;
+
+    if (quint) {
+        return quint_get_uint(quint);
+    }
+
+    qint =3D qobject_to_qint(qdict_get(qdict, key));
+    if (!qint) {
+        error_setg(errp, "Missing key or type mismatch");
+        return 0;
+    }
+
+    val =3D qint_get_int(qint);
+    if (val < 0) {
+        error_setg(errp, "Invalid value, unsigned int expected");
+        return 0;
+    }
+
+    return val;
+}
+
+/**
  * qdict_get_try_bool(): Try to get a bool mapped by 'key'
  *
  * Return bool mapped by 'key', if it is not present in the
diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index 81162ee572..80a8aef689 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
=20
 #include "qapi/qmp/qint.h"
+#include "qapi/qmp/quint.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/error.h"
@@ -121,6 +122,35 @@ static void qdict_get_try_int_test(void)
     QDECREF(tests_dict);
 }
=20
+static void qdict_get_try_uint_test(void)
+{
+    uint64_t ret;
+    const int ivalue =3D 100;
+    const uint64_t uvalue =3D G_MAXUINT64;
+    const char *key =3D "uint";
+    QDict *tests_dict =3D qdict_new();
+    Error *err =3D NULL;
+
+    qdict_put(tests_dict, key, qint_from_int(ivalue));
+    /* try_uint will work with int types too */
+    ret =3D qdict_get_try_uint(tests_dict, key, &err);
+    g_assert_cmpint(ret, =3D=3D, ivalue);
+    g_assert(!err);
+
+    qdict_put(tests_dict, key, quint_from_uint(uvalue));
+    ret =3D qdict_get_try_uint(tests_dict, key, &err);
+    g_assert_cmpint(ret, =3D=3D, uvalue);
+    g_assert(!err);
+
+    qdict_put(tests_dict, key, qint_from_int(-1));
+    /* try_uint will fail with negative values */
+    ret =3D qdict_get_try_uint(tests_dict, key, &err);
+    g_assert(err);
+    error_free(err);
+
+    QDECREF(tests_dict);
+}
+
 static void qdict_get_str_test(void)
 {
     const char *p;
@@ -854,6 +884,7 @@ int main(int argc, char **argv)
     g_test_add_func("/public/get", qdict_get_test);
     g_test_add_func("/public/get_int", qdict_get_int_test);
     g_test_add_func("/public/get_try_int", qdict_get_try_int_test);
+    g_test_add_func("/public/get_try_uint", qdict_get_try_uint_test);
     g_test_add_func("/public/get_str", qdict_get_str_test);
     g_test_add_func("/public/get_try_str", qdict_get_try_str_test);
     g_test_add_func("/public/defaults", qdict_defaults_test);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 5ce1b5c246..7338b943e1 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -959,6 +959,12 @@ static void qemu_opts_from_qdict_1(const char *key, =
QObject *obj, void *opaque)
         assert(n < sizeof(buf));
         value =3D buf;
         break;
+    case QTYPE_QUINT:
+        n =3D snprintf(buf, sizeof(buf), "%" PRIu64,
+                     quint_get_uint(qobject_to_quint(obj)));
+        assert(n < sizeof(buf));
+        value =3D buf;
+        break;
     case QTYPE_QFLOAT:
         n =3D snprintf(buf, sizeof(buf), "%.17g",
                      qfloat_get_double(qobject_to_qfloat(obj)));
--=20
2.12.0.191.gc5d8de91d

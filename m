Received: from eggs.gnu.org ([2001:4830:134:3::10]:54167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4FI-0001Um-BB
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4FD-0006W1-4k
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:05:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG4FC-0006Vu-SB
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:05:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D747A15447
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 14:05:01 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:57:08 +0400
Message-Id: <20170531135709.345-45-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 44/45] RFC: qdict: add uint
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

Similar to int support, add uint support.

Note this is RFC because this is currently unused in qemu, I haven't
found a good user for it yet (kaslr qemu-ga code did use it though).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/qdict.h |  5 +++++
 qobject/qdict.c          | 39 +++++++++++++++++++++++++++++++++++++++
 tests/check-qdict.c      | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index 363e431106..8c7c2b762b 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -56,6 +56,8 @@ void qdict_destroy_obj(QObject *obj);
 /* Helpers for int, bool, and string */
 #define qdict_put_int(qdict, key, value) \
         qdict_put(qdict, key, qnum_from_int(value))
+#define qdict_put_uint(qdict, key, value)        \
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
 bool qdict_get_try_bool(const QDict *qdict, const char *key, bool def_va=
lue);
 const char *qdict_get_try_str(const QDict *qdict, const char *key);
=20
diff --git a/qobject/qdict.c b/qobject/qdict.c
index f62625cbd6..b02dc6b745 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -208,6 +208,25 @@ int64_t qdict_get_int(const QDict *qdict, const char=
 *key)
 }
=20
 /**
+ * qdict_get_uint(): Get an unsigned integer mapped by 'key'
+ *
+ * This function assumes that 'key' exists and it stores a
+ * QNum int object.
+ *
+ * Return unsigned integer mapped by 'key'.
+ */
+uint64_t qdict_get_uint(const QDict *qdict, const char *key)
+{
+    uint64_t val;
+
+    if (!qnum_get_uint(qobject_to_qnum(qdict_get(qdict, key)), &val)) {
+        g_assert_not_reached();
+    }
+
+    return val;
+}
+
+/**
  * qdict_get_bool(): Get a bool mapped by 'key'
  *
  * This function assumes that 'key' exists and it stores a
@@ -271,6 +290,26 @@ int64_t qdict_get_try_int(const QDict *qdict, const =
char *key,
 }
=20
 /**
+ * qdict_get_try_uint(): Try to get usigned integer mapped by 'key'
+ *
+ * Return unsigned integer mapped by 'key', if it is not present in
+ * the dictionary or if the stored object is not of QNum type
+ * 'def_value' will be returned.
+ */
+uint64_t qdict_get_try_uint(const QDict *qdict, const char *key,
+                            uint64_t def_value)
+{
+    QNum *qnum =3D qobject_to_qnum(qdict_get(qdict, key));
+    uint64_t val;
+
+    if (!qnum || !qnum_get_uint(qnum, &val)) {
+        val =3D def_value;
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
index 889b43b57d..2a5b322509 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -109,6 +109,21 @@ static void qdict_get_int_test(void)
     QDECREF(tests_dict);
 }
=20
+static void qdict_get_uint_test(void)
+{
+    uint64_t ret;
+    const uint64_t value =3D UINT64_MAX;
+    const char *key =3D "uint";
+    QDict *tests_dict =3D qdict_new();
+
+    qdict_put_uint(tests_dict, key, value);
+
+    ret =3D qdict_get_uint(tests_dict, key);
+    g_assert(ret =3D=3D value);
+
+    QDECREF(tests_dict);
+}
+
 static void qdict_get_try_int_test(void)
 {
     int ret;
@@ -131,6 +146,28 @@ static void qdict_get_try_int_test(void)
     QDECREF(tests_dict);
 }
=20
+static void qdict_get_try_uint_test(void)
+{
+    uint64_t ret;
+    const uint64_t value =3D UINT64_MAX;
+    const char *key =3D "uint";
+    QDict *tests_dict =3D qdict_new();
+
+    qdict_put_uint(tests_dict, key, value);
+    qdict_put_str(tests_dict, "string", "test");
+
+    ret =3D qdict_get_try_uint(tests_dict, key, 0);
+    g_assert_cmpuint(ret, =3D=3D, value);
+
+    ret =3D qdict_get_try_uint(tests_dict, "missing", 42);
+    g_assert_cmpuint(ret, =3D=3D, 42);
+
+    ret =3D qdict_get_try_uint(tests_dict, "string", 42);
+    g_assert_cmpuint(ret, =3D=3D, 42);
+
+    QDECREF(tests_dict);
+}
+
 static void qdict_get_str_test(void)
 {
     const char *p;
@@ -866,7 +903,9 @@ int main(int argc, char **argv)
     /* Continue, but now with fixtures */
     g_test_add_func("/public/get", qdict_get_test);
     g_test_add_func("/public/get_int", qdict_get_int_test);
+    g_test_add_func("/public/get_uint", qdict_get_uint_test);
     g_test_add_func("/public/get_try_int", qdict_get_try_int_test);
+    g_test_add_func("/public/get_try_uint", qdict_get_try_uint_test);
     g_test_add_func("/public/get_str", qdict_get_str_test);
     g_test_add_func("/public/get_try_str", qdict_get_try_str_test);
     g_test_add_func("/public/defaults", qdict_defaults_test);
--=20
2.13.0.91.g00982b8dd

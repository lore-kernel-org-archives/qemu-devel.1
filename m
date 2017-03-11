Received: from eggs.gnu.org ([2001:4830:134:3::10]:58559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzS-0001v1-1i
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzQ-0002Rc-Ox
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cmgzQ-0002RB-Gp
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:20 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 11 Mar 2017 17:22:40 +0400
Message-Id: <20170311132256.22951-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-1-marcandre.lureau@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/21] qapi: update the qobject visitor to use
 QUInt
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi-visit.py               |  3 ++-
 qapi/qobject-input-visitor.c        | 30 ++++++++++++++++++++++++------
 qapi/qobject-output-visitor.c       |  3 +--
 tests/test-qobject-input-visitor.c  | 15 +++++++++++++++
 tests/test-qobject-output-visitor.c | 19 +++++++++++++++----
 5 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 330b9f321b..532f929e18 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -165,7 +165,8 @@ def gen_visit_alternate(name, variants):
     promote_int =3D 'true'
     ret =3D ''
     for var in variants.variants:
-        if var.type.alternate_qtype() =3D=3D 'QTYPE_QINT':
+        if var.type.alternate_qtype() =3D=3D 'QTYPE_QINT' \
+            or var.type.alternate_qtype() =3D=3D 'QTYPE_QUINT':
             promote_int =3D 'false'
=20
     ret +=3D mcgen('''
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 865e948ac0..41a825b06b 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -21,6 +21,7 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/types.h"
 #include "qapi/qmp/qerror.h"
+#include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "qemu/option.h"
=20
@@ -349,7 +350,8 @@ static void qobject_input_start_alternate(Visitor *v,=
 const char *name,
     }
     *obj =3D g_malloc0(size);
     (*obj)->type =3D qobject_type(qobj);
-    if (promote_int && (*obj)->type =3D=3D QTYPE_QINT) {
+    if (promote_int &&
+        ((*obj)->type =3D=3D QTYPE_QINT || (*obj)->type =3D=3D QTYPE_QUI=
NT)) {
         (*obj)->type =3D QTYPE_QFLOAT;
     }
 }
@@ -395,22 +397,38 @@ static void qobject_input_type_int64_keyval(Visitor=
 *v, const char *name,
 static void qobject_input_type_uint64(Visitor *v, const char *name,
                                       uint64_t *obj, Error **errp)
 {
-    /* FIXME: qobject_to_qint mishandles values over INT64_MAX */
     QObjectInputVisitor *qiv =3D to_qiv(v);
     QObject *qobj =3D qobject_input_get_object(qiv, name, true, errp);
+    QUInt *quint;
     QInt *qint;
+    int64_t val;
=20
     if (!qobj) {
         return;
     }
+
+    quint =3D qobject_to_quint(qobj);
+    if (quint) {
+        *obj =3D quint_get_uint(quint);
+        return;
+    }
+
     qint =3D qobject_to_qint(qobj);
     if (!qint) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "integer");
-        return;
+        goto error;
     }
=20
-    *obj =3D qint_get_int(qint);
+    val =3D qint_get_int(qint);
+    if (val < 0) {
+        goto error;
+    }
+
+    *obj =3D val;
+    return;
+
+error:
+    error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
+               full_name(qiv, name), "unsigned integer");
 }
=20
 static void qobject_input_type_uint64_keyval(Visitor *v, const char *nam=
e,
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.=
c
index 871127079d..7066b3b59b 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -150,9 +150,8 @@ static void qobject_output_type_int64(Visitor *v, con=
st char *name,
 static void qobject_output_type_uint64(Visitor *v, const char *name,
                                        uint64_t *obj, Error **errp)
 {
-    /* FIXME values larger than INT64_MAX become negative */
     QObjectOutputVisitor *qov =3D to_qov(v);
-    qobject_output_add(qov, name, qint_from_int(*obj));
+    qobject_output_add(qov, name, quint_from_uint(*obj));
 }
=20
 static void qobject_output_type_bool(Visitor *v, const char *name, bool =
*obj,
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index 6eb48fee7b..011366a65b 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -170,6 +170,19 @@ static void test_visitor_in_int_str_fail(TestInputVi=
sitorData *data,
     error_free_or_abort(&err);
 }
=20
+static void test_visitor_in_uint(TestInputVisitorData *data,
+                                const void *unused)
+{
+    uint64_t res =3D 0;
+    uint64_t value =3D G_MAXUINT64;
+    Visitor *v;
+
+    v =3D visitor_input_test_init(data, "%" PRIu64, value);
+
+    visit_type_uint64(v, NULL, &res, &error_abort);
+    g_assert_cmpint(res, =3D=3D, value);
+}
+
 static void test_visitor_in_bool(TestInputVisitorData *data,
                                  const void *unused)
 {
@@ -1233,6 +1246,8 @@ int main(int argc, char **argv)
                            NULL, test_visitor_in_int_str_keyval);
     input_visitor_test_add("/visitor/input/int_str_fail",
                            NULL, test_visitor_in_int_str_fail);
+    input_visitor_test_add("/visitor/input/uint",
+                           NULL, test_visitor_in_uint);
     input_visitor_test_add("/visitor/input/bool",
                            NULL, test_visitor_in_bool);
     input_visitor_test_add("/visitor/input/bool_keyval",
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
index 500b452d98..047c6b5c6c 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -597,14 +597,25 @@ static void check_native_list(QObject *qobj,
     qlist =3D qlist_copy(qobject_to_qlist(qdict_get(qdict, "data")));
=20
     switch (kind) {
-    case USER_DEF_NATIVE_LIST_UNION_KIND_S8:
-    case USER_DEF_NATIVE_LIST_UNION_KIND_S16:
-    case USER_DEF_NATIVE_LIST_UNION_KIND_S32:
-    case USER_DEF_NATIVE_LIST_UNION_KIND_S64:
     case USER_DEF_NATIVE_LIST_UNION_KIND_U8:
     case USER_DEF_NATIVE_LIST_UNION_KIND_U16:
     case USER_DEF_NATIVE_LIST_UNION_KIND_U32:
     case USER_DEF_NATIVE_LIST_UNION_KIND_U64:
+        for (i =3D 0; i < 32; i++) {
+            QObject *tmp;
+            QUInt *qvalue;
+            tmp =3D qlist_peek(qlist);
+            g_assert(tmp);
+            qvalue =3D qobject_to_quint(tmp);
+            g_assert_cmpint(quint_get_uint(qvalue), =3D=3D, i);
+            qobject_decref(qlist_pop(qlist));
+        }
+        break;
+
+    case USER_DEF_NATIVE_LIST_UNION_KIND_S8:
+    case USER_DEF_NATIVE_LIST_UNION_KIND_S16:
+    case USER_DEF_NATIVE_LIST_UNION_KIND_S32:
+    case USER_DEF_NATIVE_LIST_UNION_KIND_S64:
         /* all integer elements in JSON arrays get stored into QInts whe=
n
          * we convert to QObjects, so we can check them all in the same
          * fashion, so simply fall through here
--=20
2.12.0.191.gc5d8de91d

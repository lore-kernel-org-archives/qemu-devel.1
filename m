Received: from eggs.gnu.org ([2001:4830:134:3::10]:52295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG49V-0004DG-Mo
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG49U-0004AV-Go
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:59:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG49U-0004AJ-85
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:59:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 345DA80C15
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 13:59:07 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:56:38 +0400
Message-Id: <20170531135709.345-15-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 14/45] qapi: update the qobject visitor to
 use QNUM_U64
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

Switch to use QNum/uint where appropriate to remove i64 limitation.

The input visitor will cast i64 input to u64 for compatibility
reasons (existing json QMP client already use negative i64 for large
u64, and expect an implicit cast in qemu).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/acpi-build.c                |  3 +--
 qapi/qobject-input-visitor.c        | 21 ++++++++++++++++-----
 qapi/qobject-output-visitor.c       |  3 +--
 tests/test-qobject-input-visitor.c  |  7 ++-----
 tests/test-qobject-output-visitor.c | 28 +++++++++++++++++++++-------
 5 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1709efdf1c..ba2be1e9da 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2634,10 +2634,9 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
     if (!o) {
         return false;
     }
-    if (!qnum_get_int(qobject_to_qnum(o), &val)) {
+    if (!qnum_get_uint(qobject_to_qnum(o), &mcfg->mcfg_base)) {
         g_assert_not_reached();
     }
-    mcfg->mcfg_base =3D val;
     qobject_decref(o);
=20
     o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NUL=
L);
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 74835ba339..7f9d6f57a1 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -417,7 +417,6 @@ static void qobject_input_type_int64_keyval(Visitor *=
v, const char *name,
 static void qobject_input_type_uint64(Visitor *v, const char *name,
                                       uint64_t *obj, Error **errp)
 {
-    /* FIXME: qobject_to_qnum mishandles values over INT64_MAX */
     QObjectInputVisitor *qiv =3D to_qiv(v);
     QObject *qobj =3D qobject_input_get_object(qiv, name, true, errp);
     QNum *qnum;
@@ -427,11 +426,23 @@ static void qobject_input_type_uint64(Visitor *v, c=
onst char *name,
         return;
     }
     qnum =3D qobject_to_qnum(qobj);
-    if (!qnum || !qnum_get_int(qnum, &val)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "integer");
+    if (!qnum) {
+        goto err;
+    }
+
+    if (qnum_get_uint(qnum, obj)) {
+        return;
     }
-    *obj =3D val;
+
+    /* Need to accept negative values for backward compatibility */
+    if (qnum_get_int(qnum, &val)) {
+        *obj =3D val;
+        return;
+    }
+
+err:
+    error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+               full_name(qiv, name), "uint64");
 }
=20
 static void qobject_input_type_uint64_keyval(Visitor *v, const char *nam=
e,
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.=
c
index 2ca5093b22..70be84ccb5 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -150,9 +150,8 @@ static void qobject_output_type_int64(Visitor *v, con=
st char *name,
 static void qobject_output_type_uint64(Visitor *v, const char *name,
                                        uint64_t *obj, Error **errp)
 {
-    /* FIXME values larger than INT64_MAX become negative */
     QObjectOutputVisitor *qov =3D to_qov(v);
-    qobject_output_add(qov, name, qnum_from_int(*obj));
+    qobject_output_add(qov, name, qnum_from_uint(*obj));
 }
=20
 static void qobject_output_type_bool(Visitor *v, const char *name, bool =
*obj,
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index 983c59c474..6f94fc677c 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -122,7 +122,6 @@ static void test_visitor_in_int(TestInputVisitorData =
*data,
 static void test_visitor_in_uint(TestInputVisitorData *data,
                                 const void *unused)
 {
-    Error *err =3D NULL;
     uint64_t res =3D 0;
     int64_t i64;
     double dbl;
@@ -146,12 +145,10 @@ static void test_visitor_in_uint(TestInputVisitorDa=
ta *data,
     visit_type_uint64(v, NULL, &res, &error_abort);
     g_assert_cmpuint(res, =3D=3D, (uint64_t)-value);
=20
-    /* BUG: value between INT64_MAX+1 and UINT64_MAX rejected */
-
     v =3D visitor_input_test_init(data, "18446744073709551574");
=20
-    visit_type_uint64(v, NULL, &res, &err);
-    error_free_or_abort(&err);
+    visit_type_uint64(v, NULL, &res, &error_abort);
+    g_assert_cmpuint(res, =3D=3D, 18446744073709551574U);
=20
     visit_type_number(v, NULL, &dbl, &error_abort);
 }
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
index 3180d8cbde..d9f106d52e 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -602,17 +602,31 @@ static void check_native_list(QObject *qobj,
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
-        /* all integer elements in JSON arrays get stored into QNums whe=
n
-         * we convert to QObjects, so we can check them all in the same
-         * fashion, so simply fall through here
+        for (i =3D 0; i < 32; i++) {
+            QObject *tmp;
+            QNum *qvalue;
+            uint64_t val;
+
+            tmp =3D qlist_peek(qlist);
+            g_assert(tmp);
+            qvalue =3D qobject_to_qnum(tmp);
+            g_assert(qnum_get_uint(qvalue, &val));
+            g_assert_cmpuint(val, =3D=3D, i);
+            qobject_decref(qlist_pop(qlist));
+        }
+        break;
+
+    case USER_DEF_NATIVE_LIST_UNION_KIND_S8:
+    case USER_DEF_NATIVE_LIST_UNION_KIND_S16:
+    case USER_DEF_NATIVE_LIST_UNION_KIND_S32:
+    case USER_DEF_NATIVE_LIST_UNION_KIND_S64:
+        /* All signed integer elements in JSON arrays get stored into
+         * QInts when we convert to QObjects, so we can check them all
+         * in the same fashion, so simply fall through here.
          */
     case USER_DEF_NATIVE_LIST_UNION_KIND_INTEGER:
         for (i =3D 0; i < 32; i++) {
--=20
2.13.0.91.g00982b8dd

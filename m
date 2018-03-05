Received: from eggs.gnu.org ([2001:4830:134:3::10]:49734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1estwA-00077c-Q1
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:30:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1estw4-0004vS-HC
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:30:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51426 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1estw4-0004uC-Cz
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:30:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8589F4063655
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 17:30:03 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  5 Mar 2018 18:29:50 +0100
Message-Id: <20180305172951.2150-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180305172951.2150-1-marcandre.lureau@redhat.com>
References: <20180305172951.2150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] qlit: add qobject_from_qlit()
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

Instantiate a QObject* from a literal QLitObject.

LitObject only supports int64_t for now.  uint64_t and double aren't
implemented.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qlit.h |  2 ++
 qobject/qlit.c          | 37 +++++++++++++++++++++++++++++++++++++
 tests/check-qlit.c      | 28 ++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
index f1ed082df8..c0676d5daf 100644
--- a/include/qapi/qmp/qlit.h
+++ b/include/qapi/qmp/qlit.h
@@ -50,4 +50,6 @@ struct QLitDictEntry {
=20
 bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs);
=20
+QObject *qobject_from_qlit(const QLitObject *qlit);
+
 #endif /* QLIT_H */
diff --git a/qobject/qlit.c b/qobject/qlit.c
index 948e0b860c..d0e1b72fd0 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -21,6 +21,7 @@
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/qmp/qnull.h"
=20
 static bool qlit_equal_qdict(const QLitObject *lhs, const QDict *qdict)
 {
@@ -86,3 +87,39 @@ bool qlit_equal_qobject(const QLitObject *lhs, const Q=
Object *rhs)
=20
     return false;
 }
+
+QObject *qobject_from_qlit(const QLitObject *qlit)
+{
+    switch (qlit->type) {
+    case QTYPE_QNULL:
+        return QOBJECT(qnull());
+    case QTYPE_QNUM:
+        return QOBJECT(qnum_from_int(qlit->value.qnum));
+    case QTYPE_QSTRING:
+        return QOBJECT(qstring_from_str(qlit->value.qstr));
+    case QTYPE_QDICT: {
+        QDict *qdict =3D qdict_new();
+        QLitDictEntry *e;
+
+        for (e =3D qlit->value.qdict; e->key; e++) {
+            qdict_put_obj(qdict, e->key, qobject_from_qlit(&e->value));
+        }
+        return QOBJECT(qdict);
+    }
+    case QTYPE_QLIST: {
+        QList *qlist =3D qlist_new();
+        QLitObject *e;
+
+        for (e =3D qlit->value.qlist; e->type !=3D QTYPE_NONE; e++) {
+            qlist_append_obj(qlist, qobject_from_qlit(e));
+        }
+        return QOBJECT(qlist);
+    }
+    case QTYPE_QBOOL:
+        return QOBJECT(qbool_from_bool(qlit->value.qbool));
+    default:
+        assert(0);
+    }
+
+    return NULL;
+}
diff --git a/tests/check-qlit.c b/tests/check-qlit.c
index 5d0f65b9c7..836f4a3090 100644
--- a/tests/check-qlit.c
+++ b/tests/check-qlit.c
@@ -9,9 +9,11 @@
=20
 #include "qemu/osdep.h"
=20
+#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qlit.h"
+#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
=20
 static QLitObject qlit =3D QLIT_QDICT(((QLitDictEntry[]) {
@@ -63,11 +65,37 @@ static void qlit_equal_qobject_test(void)
     qobject_decref(qobj);
 }
=20
+static void qobject_from_qlit_test(void)
+{
+    QObject *obj, *qobj =3D qobject_from_qlit(&qlit);
+    QDict *qdict;
+    QList *bee;
+
+    qdict =3D qobject_to_qdict(qobj);
+    g_assert_cmpint(qdict_get_int(qdict, "foo"), =3D=3D, 42);
+    g_assert_cmpstr(qdict_get_str(qdict, "bar"), =3D=3D, "hello world");
+    g_assert(qobject_type(qdict_get(qdict, "baz")) =3D=3D QTYPE_QNULL);
+
+    bee =3D qdict_get_qlist(qdict, "bee");
+    obj =3D qlist_pop(bee);
+    g_assert_cmpint(qnum_get_int(qobject_to_qnum(obj)), =3D=3D, 43);
+    qobject_decref(obj);
+    obj =3D qlist_pop(bee);
+    g_assert_cmpint(qnum_get_int(qobject_to_qnum(obj)), =3D=3D, 44);
+    qobject_decref(obj);
+    obj =3D qlist_pop(bee);
+    g_assert(qbool_get_bool(qobject_to_qbool(obj)));
+    qobject_decref(obj);
+
+    qobject_decref(qobj);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
=20
     g_test_add_func("/qlit/equal_qobject", qlit_equal_qobject_test);
+    g_test_add_func("/qlit/qobject_from_qlit", qobject_from_qlit_test);
=20
     return g_test_run();
 }
--=20
2.16.2.346.g9779355e34

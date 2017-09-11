Received: from eggs.gnu.org ([2001:4830:134:3::10]:42542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMXz-0004kM-TU
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMXv-0005xV-UK
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:06:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drMXv-0005wX-Mo
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:06:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D70C033B417
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 11:06:30 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 13:05:34 +0200
Message-Id: <20170911110623.24981-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170911110623.24981-1-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 01/50] qlit: add qobject_from_qlit()
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

Instanciate a QObject* form a literal QLitObject.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/qlit.h |  2 ++
 qobject/qlit.c          | 36 ++++++++++++++++++++++++++++++++++++
 tests/check-qlit.c      | 26 ++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
index b18406bce9..56feb25e04 100644
--- a/include/qapi/qmp/qlit.h
+++ b/include/qapi/qmp/qlit.h
@@ -51,4 +51,6 @@ struct QLitDictEntry {
=20
 bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs);
=20
+QObject *qobject_from_qlit(const QLitObject *qlit);
+
 #endif /* QLIT_H */
diff --git a/qobject/qlit.c b/qobject/qlit.c
index 3c4882c784..df2ad97d33 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -82,3 +82,39 @@ bool qlit_equal_qobject(const QLitObject *lhs, const Q=
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
+    case QTYPE_NONE:
+        assert(0);
+    }
+
+    return NULL;
+}
diff --git a/tests/check-qlit.c b/tests/check-qlit.c
index c59ec1ab88..acd6e02e96 100644
--- a/tests/check-qlit.c
+++ b/tests/check-qlit.c
@@ -64,11 +64,37 @@ static void qlit_equal_qobject_test(void)
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
2.14.1.146.gd35faa819

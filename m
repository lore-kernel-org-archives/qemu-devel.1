Received: from eggs.gnu.org ([2001:4830:134:3::10]:47339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dlCLp-0000Ht-1Z
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dlCLj-0005H5-8I
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:00:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dlCLi-0005GC-Vu
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:00:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF9F04A6EB
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 11:00:25 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 25 Aug 2017 12:59:11 +0200
Message-Id: <20170825105913.4060-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170825105913.4060-1-marcandre.lureau@redhat.com>
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/14] qlit: improve QLit list vs qlist
 comparison
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

Use QLIST_FOREACH_ENTRY() to simplify the code and break earlier.

Check that the QLit list has the same size as the qlist, this should
ensure that we have an exact match when iterating over qlist for
comparing the elements.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qobject/qlit.c     | 53 +++++++++++++++++++-----------------------------=
-----
 tests/check-qlit.c |  3 +++
 2 files changed, 22 insertions(+), 34 deletions(-)

diff --git a/qobject/qlit.c b/qobject/qlit.c
index dc0015f76c..3c4882c784 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -18,29 +18,6 @@
 #include "qapi/qmp/qlit.h"
 #include "qapi/qmp/types.h"
=20
-typedef struct QListCompareHelper {
-    int index;
-    QLitObject *objs;
-    bool result;
-} QListCompareHelper;
-
-static void compare_helper(QObject *obj, void *opaque)
-{
-    QListCompareHelper *helper =3D opaque;
-
-    if (!helper->result) {
-        return;
-    }
-
-    if (helper->objs[helper->index].type =3D=3D QTYPE_NONE) {
-        helper->result =3D false;
-        return;
-    }
-
-    helper->result =3D
-        qlit_equal_qobject(&helper->objs[helper->index++], obj);
-}
-
 static bool qlit_equal_qdict(const QLitObject *lhs, const QDict *qdict)
 {
     int i;
@@ -62,6 +39,23 @@ static bool qlit_equal_qdict(const QLitObject *lhs, co=
nst QDict *qdict)
     return true;
 }
=20
+static bool qlit_equal_qlist(const QLitObject *lhs, const QList *qlist)
+{
+    QListEntry *e;
+    int i =3D 0;
+
+    QLIST_FOREACH_ENTRY(qlist, e) {
+        QObject *obj =3D qlist_entry_obj(e);
+
+        if (!qlit_equal_qobject(&lhs->value.qlist[i], obj)) {
+            return false;
+        }
+        i++;
+    }
+
+    return !e && lhs->value.qlist[i].type =3D=3D QTYPE_NONE;
+}
+
 bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs)
 {
     if (!rhs || lhs->type !=3D qobject_type(rhs)) {
@@ -78,17 +72,8 @@ bool qlit_equal_qobject(const QLitObject *lhs, const Q=
Object *rhs)
                        qstring_get_str(qobject_to_qstring(rhs))) =3D=3D =
0);
     case QTYPE_QDICT:
         return qlit_equal_qdict(lhs, qobject_to_qdict(rhs));
-    case QTYPE_QLIST: {
-        QListCompareHelper helper;
-
-        helper.index =3D 0;
-        helper.objs =3D lhs->value.qlist;
-        helper.result =3D true;
-
-        qlist_iter(qobject_to_qlist(rhs), compare_helper, &helper);
-
-        return helper.result;
-    }
+    case QTYPE_QLIST:
+        return qlit_equal_qlist(lhs, qobject_to_qlist(rhs));
     case QTYPE_QNULL:
         return true;
     default:
diff --git a/tests/check-qlit.c b/tests/check-qlit.c
index 5d9558dfd9..ae74bfcb83 100644
--- a/tests/check-qlit.c
+++ b/tests/check-qlit.c
@@ -58,6 +58,9 @@ static void qlit_equal_qobject_test(void)
=20
     g_assert(!qlit_equal_qobject(&qlit_foo, qobj));
=20
+    qdict_put(qobject_to_qdict(qobj), "bee", qlist_new());
+    g_assert(!qlit_equal_qobject(&qlit, qobj));
+
     qobject_decref(qobj);
 }
=20
--=20
2.14.1.146.gd35faa819

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkpTC-0007J3-36
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkpTB-0004BR-9E
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:34:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dkpTB-0004AK-0d
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:34:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 044FF85541
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 10:34:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 24 Aug 2017 12:33:48 +0200
Message-Id: <20170824103350.16400-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170824103350.16400-1-marcandre.lureau@redhat.com>
References: <20170824103350.16400-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/14] qlit: improve QLit list vs qlist
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

Check that the QLit list has the same size as the qlist, this should
ensure that we have an exact match when iterating over qlist for
comparing the elements.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qobject/qlit.c     | 39 ++++++++++++++++++++++++++-------------
 tests/check-qlit.c |  3 +++
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/qobject/qlit.c b/qobject/qlit.c
index 45ae0635c0..0a60802d74 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -67,6 +67,28 @@ end:
     return success;
 }
=20
+static bool qlit_equal_qlist(const QLitObject *lhs, const QList *qlist)
+{
+    QListCompareHelper helper;
+    int i;
+
+    for (i =3D 0; lhs->value.qlist[i].type !=3D QTYPE_NONE; i++) {
+        continue;
+    }
+
+    if (qlist_size(qlist) !=3D i) {
+        return false;
+    }
+
+    helper.index =3D 0;
+    helper.objs =3D lhs->value.qlist;
+    helper.result =3D true;
+
+    qlist_iter(qlist, compare_helper, &helper);
+
+    return helper.result;
+}
+
 bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs)
 {
     int64_t val;
@@ -82,21 +104,12 @@ bool qlit_equal_qobject(const QLitObject *lhs, const=
 QObject *rhs)
         val =3D qnum_get_int(qobject_to_qnum(rhs));
         return lhs->value.qnum =3D=3D val;
     case QTYPE_QSTRING:
-        return (strcmp(lhs->value.qstr,
-                       qstring_get_str(qobject_to_qstring(rhs))) =3D=3D =
0);
+        return g_str_equal(lhs->value.qstr,
+                           qstring_get_str(qobject_to_qstring(rhs)));
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

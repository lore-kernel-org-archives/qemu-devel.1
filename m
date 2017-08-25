Received: from eggs.gnu.org ([2001:4830:134:3::10]:47272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dlCLj-0000FO-O1
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dlCLf-0005D7-74
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:00:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dlCLe-0005CX-Uw
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:00:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9607C056787
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 11:00:21 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 25 Aug 2017 12:59:10 +0200
Message-Id: <20170825105913.4060-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170825105913.4060-1-marcandre.lureau@redhat.com>
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/14] qlit: improve QLit dict vs qdict
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

Verify that all qdict values are covered.

(a previous iteration of this patch created a copy of qdict to remove
all checked elements, verifying no duplicates exist in the literal
qdict, however this is a programming error, and a size comparison
should be enough)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qobject/qlit.c     | 37 +++++++++++++++++++++++--------------
 tests/check-qlit.c |  7 +++++++
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/qobject/qlit.c b/qobject/qlit.c
index b1d9146220..dc0015f76c 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -41,6 +41,27 @@ static void compare_helper(QObject *obj, void *opaque)
         qlit_equal_qobject(&helper->objs[helper->index++], obj);
 }
=20
+static bool qlit_equal_qdict(const QLitObject *lhs, const QDict *qdict)
+{
+    int i;
+
+    for (i =3D 0; lhs->value.qdict[i].key; i++) {
+        QObject *obj =3D qdict_get(qdict, lhs->value.qdict[i].key);
+
+        if (!qlit_equal_qobject(&lhs->value.qdict[i].value, obj)) {
+            return false;
+        }
+    }
+
+    /* Note: the literal qdict must not contain duplicates, this is
+     * considered a programming error and it isn't checked here. */
+    if (qdict_size(qdict) !=3D i) {
+        return false;
+    }
+
+    return true;
+}
+
 bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs)
 {
     if (!rhs || lhs->type !=3D qobject_type(rhs)) {
@@ -55,20 +76,8 @@ bool qlit_equal_qobject(const QLitObject *lhs, const Q=
Object *rhs)
     case QTYPE_QSTRING:
         return (strcmp(lhs->value.qstr,
                        qstring_get_str(qobject_to_qstring(rhs))) =3D=3D =
0);
-    case QTYPE_QDICT: {
-        int i;
-
-        for (i =3D 0; lhs->value.qdict[i].key; i++) {
-            QObject *obj =3D qdict_get(qobject_to_qdict(rhs),
-                                     lhs->value.qdict[i].key);
-
-            if (!qlit_equal_qobject(&lhs->value.qdict[i].value, obj)) {
-                return false;
-            }
-        }
-
-        return true;
-    }
+    case QTYPE_QDICT:
+        return qlit_equal_qdict(lhs, qobject_to_qdict(rhs));
     case QTYPE_QLIST: {
         QListCompareHelper helper;
=20
diff --git a/tests/check-qlit.c b/tests/check-qlit.c
index 47fde92a46..5d9558dfd9 100644
--- a/tests/check-qlit.c
+++ b/tests/check-qlit.c
@@ -28,6 +28,11 @@ static QLitObject qlit =3D QLIT_QDICT(((QLitDictEntry[=
]) {
     { },
 }));
=20
+static QLitObject qlit_foo =3D QLIT_QDICT(((QLitDictEntry[]) {
+    { "foo", QLIT_QNUM(42) },
+    { },
+}));
+
 static QObject *make_qobject(void)
 {
     QDict *qdict =3D qdict_new();
@@ -51,6 +56,8 @@ static void qlit_equal_qobject_test(void)
=20
     g_assert(qlit_equal_qobject(&qlit, qobj));
=20
+    g_assert(!qlit_equal_qobject(&qlit_foo, qobj));
+
     qobject_decref(qobj);
 }
=20
--=20
2.14.1.146.gd35faa819

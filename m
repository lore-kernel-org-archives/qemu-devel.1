Received: from eggs.gnu.org ([2001:4830:134:3::10]:44949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNIT8-0004E0-2a
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNIT6-00029w-9N
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dNIT6-00029M-0j
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0749AC04D2A3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 12:41:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 20 Jun 2017 14:40:35 +0200
Message-Id: <1497962468-22936-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1497962468-22936-1-git-send-email-armbru@redhat.com>
References: <1497962468-22936-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 08/41] tests: remove /{qnum, qlist,
 dict}/destroy test
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

The tests aren't really useful, or already covered by other simple tests.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170607163635.17635-9-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qdict.c   |  9 ++-------
 tests/check-qlist.c   | 23 ++---------------------
 tests/check-qnum.c    | 18 ++----------------
 tests/check-qstring.c |  9 ---------
 4 files changed, 6 insertions(+), 53 deletions(-)

diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index f067c63..5eca1b5 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -32,8 +32,7 @@ static void qdict_new_test(void)
     g_assert(qdict->base.refcnt =3D=3D 1);
     g_assert(qobject_type(QOBJECT(qdict)) =3D=3D QTYPE_QDICT);
=20
-    // destroy doesn't exit yet
-    g_free(qdict);
+    QDECREF(qdict);
 }
=20
 static void qdict_put_obj_test(void)
@@ -53,11 +52,7 @@ static void qdict_put_obj_test(void)
     qn =3D qobject_to_qnum(ent->value);
     g_assert_cmpint(qnum_get_int(qn), =3D=3D, num);
=20
-    // destroy doesn't exit yet
-    QDECREF(qn);
-    g_free(ent->key);
-    g_free(ent);
-    g_free(qdict);
+    QDECREF(qdict);
 }
=20
 static void qdict_destroy_simple_test(void)
diff --git a/tests/check-qlist.c b/tests/check-qlist.c
index a9b65c6..894e991 100644
--- a/tests/check-qlist.c
+++ b/tests/check-qlist.c
@@ -30,8 +30,7 @@ static void qlist_new_test(void)
     g_assert(qlist->base.refcnt =3D=3D 1);
     g_assert(qobject_type(QOBJECT(qlist)) =3D=3D QTYPE_QLIST);
=20
-    // destroy doesn't exist yet
-    g_free(qlist);
+    QDECREF(qlist);
 }
=20
 static void qlist_append_test(void)
@@ -49,10 +48,7 @@ static void qlist_append_test(void)
     g_assert(entry !=3D NULL);
     g_assert(entry->value =3D=3D QOBJECT(qi));
=20
-    // destroy doesn't exist yet
-    QDECREF(qi);
-    g_free(entry);
-    g_free(qlist);
+    QDECREF(qlist);
 }
=20
 static void qobject_to_qlist_test(void)
@@ -63,20 +59,6 @@ static void qobject_to_qlist_test(void)
=20
     g_assert(qobject_to_qlist(QOBJECT(qlist)) =3D=3D qlist);
=20
-    // destroy doesn't exist yet
-    g_free(qlist);
-}
-
-static void qlist_destroy_test(void)
-{
-    int i;
-    QList *qlist;
-
-    qlist =3D qlist_new();
-
-    for (i =3D 0; i < 42; i++)
-        qlist_append_int(qlist, i);
-
     QDECREF(qlist);
 }
=20
@@ -125,7 +107,6 @@ int main(int argc, char **argv)
     g_test_add_func("/public/new", qlist_new_test);
     g_test_add_func("/public/append", qlist_append_test);
     g_test_add_func("/public/to_qlist", qobject_to_qlist_test);
-    g_test_add_func("/public/destroy", qlist_destroy_test);
     g_test_add_func("/public/iter", qlist_iter_test);
=20
     return g_test_run();
diff --git a/tests/check-qnum.c b/tests/check-qnum.c
index d94cea0..da7e0b0 100644
--- a/tests/check-qnum.c
+++ b/tests/check-qnum.c
@@ -36,8 +36,7 @@ static void qnum_from_int_test(void)
     g_assert_cmpint(qn->base.refcnt, =3D=3D, 1);
     g_assert_cmpint(qobject_type(QOBJECT(qn)), =3D=3D, QTYPE_QNUM);
=20
-    // destroy doesn't exit yet
-    g_free(qn);
+    QDECREF(qn);
 }
=20
 static void qnum_from_double_test(void)
@@ -52,8 +51,7 @@ static void qnum_from_double_test(void)
     g_assert_cmpint(qn->base.refcnt, =3D=3D, 1);
     g_assert_cmpint(qobject_type(QOBJECT(qn)), =3D=3D, QTYPE_QNUM);
=20
-    // destroy doesn't exit yet
-    g_free(qn);
+    QDECREF(qn);
 }
=20
 static void qnum_from_int64_test(void)
@@ -109,24 +107,12 @@ static void qnum_to_string_test(void)
     QDECREF(qn);
 }
=20
-static void qnum_destroy_test(void)
-{
-    QNum *qn;
-
-    qn =3D qnum_from_int(0);
-    QDECREF(qn);
-
-    qn =3D qnum_from_double(0.42);
-    QDECREF(qn);
-}
-
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
=20
     g_test_add_func("/qnum/from_int", qnum_from_int_test);
     g_test_add_func("/qnum/from_double", qnum_from_double_test);
-    g_test_add_func("/qnum/destroy", qnum_destroy_test);
     g_test_add_func("/qnum/from_int64", qnum_from_int64_test);
     g_test_add_func("/qnum/get_int", qnum_get_int_test);
     g_test_add_func("/qnum/to_qnum", qobject_to_qnum_test);
diff --git a/tests/check-qstring.c b/tests/check-qstring.c
index 239e9d9..112ec08 100644
--- a/tests/check-qstring.c
+++ b/tests/check-qstring.c
@@ -31,14 +31,6 @@ static void qstring_from_str_test(void)
     g_assert(strcmp(str, qstring->string) =3D=3D 0);
     g_assert(qobject_type(QOBJECT(qstring)) =3D=3D QTYPE_QSTRING);
=20
-    // destroy doesn't exit yet
-    g_free(qstring->string);
-    g_free(qstring);
-}
-
-static void qstring_destroy_test(void)
-{
-    QString *qstring =3D qstring_from_str("destroy test");
     QDECREF(qstring);
 }
=20
@@ -97,7 +89,6 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
=20
     g_test_add_func("/public/from_str", qstring_from_str_test);
-    g_test_add_func("/public/destroy", qstring_destroy_test);
     g_test_add_func("/public/get_str", qstring_get_str_test);
     g_test_add_func("/public/append_chr", qstring_append_chr_test);
     g_test_add_func("/public/from_substr", qstring_from_substr_test);
--=20
2.7.5

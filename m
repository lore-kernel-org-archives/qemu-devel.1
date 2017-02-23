Received: from eggs.gnu.org ([2001:4830:134:3::10]:39728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgzSs-0001xg-Bu
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:54:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgzSp-0000ng-Ac
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:54:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgzSp-0000ma-1X
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:54:07 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28D0080467
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 19:54:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1NJs5Qr029931
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:54:06 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Feb 2017 20:53:48 +0100
Message-Id: <1487879642-16139-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1487879642-16139-1-git-send-email-armbru@redhat.com>
References: <1487879642-16139-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/24] test-cutils: Add missing
 qemu_strtosz()... endptr checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1487708048-2131-11-git-send-email-armbru@redhat.com>
---
 tests/test-cutils.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index 185b023..a3eb182 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -1393,60 +1393,75 @@ static void test_qemu_strtosz_units(void)
     const char *t =3D "1T";
     const char *p =3D "1P";
     const char *e =3D "1E";
+    char *endptr =3D NULL;
     int64_t res;
=20
     /* default is M */
-    res =3D qemu_strtosz(none, NULL);
+    res =3D qemu_strtosz(none, &endptr);
     g_assert_cmpint(res, =3D=3D, M_BYTE);
+    g_assert(endptr =3D=3D none + 1);
=20
-    res =3D qemu_strtosz(b, NULL);
+    res =3D qemu_strtosz(b, &endptr);
     g_assert_cmpint(res, =3D=3D, 1);
+    g_assert(endptr =3D=3D b + 2);
=20
-    res =3D qemu_strtosz(k, NULL);
+    res =3D qemu_strtosz(k, &endptr);
     g_assert_cmpint(res, =3D=3D, K_BYTE);
+    g_assert(endptr =3D=3D k + 2);
=20
-    res =3D qemu_strtosz(m, NULL);
+    res =3D qemu_strtosz(m, &endptr);
     g_assert_cmpint(res, =3D=3D, M_BYTE);
+    g_assert(endptr =3D=3D m + 2);
=20
-    res =3D qemu_strtosz(g, NULL);
+    res =3D qemu_strtosz(g, &endptr);
     g_assert_cmpint(res, =3D=3D, G_BYTE);
+    g_assert(endptr =3D=3D g + 2);
=20
-    res =3D qemu_strtosz(t, NULL);
+    res =3D qemu_strtosz(t, &endptr);
     g_assert_cmpint(res, =3D=3D, T_BYTE);
+    g_assert(endptr =3D=3D t + 2);
=20
-    res =3D qemu_strtosz(p, NULL);
+    res =3D qemu_strtosz(p, &endptr);
     g_assert_cmpint(res, =3D=3D, P_BYTE);
+    g_assert(endptr =3D=3D p + 2);
=20
-    res =3D qemu_strtosz(e, NULL);
+    res =3D qemu_strtosz(e, &endptr);
     g_assert_cmpint(res, =3D=3D, E_BYTE);
+    g_assert(endptr =3D=3D e + 2);
 }
=20
 static void test_qemu_strtosz_float(void)
 {
     const char *str =3D "12.345M";
+    char *endptr =3D NULL;
     int64_t res;
=20
-    res =3D qemu_strtosz(str, NULL);
+    res =3D qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, =3D=3D, 12.345 * M_BYTE);
+    g_assert(endptr =3D=3D str + 7);
 }
=20
 static void test_qemu_strtosz_erange(void)
 {
     const char *str =3D "10E";
+    char *endptr =3D NULL;
     int64_t res;
=20
-    res =3D qemu_strtosz(str, NULL);
+    res =3D qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, =3D=3D, -ERANGE);
+    g_assert(endptr =3D=3D str + 3);
 }
=20
 static void test_qemu_strtosz_suffix_unit(void)
 {
     const char *str =3D "12345";
+    char *endptr =3D NULL;
     int64_t res;
=20
-    res =3D qemu_strtosz_suffix_unit(str, NULL,
+    res =3D qemu_strtosz_suffix_unit(str, &endptr,
                                    QEMU_STRTOSZ_DEFSUFFIX_KB, 1000);
     g_assert_cmpint(res, =3D=3D, 12345000);
+    g_assert(endptr =3D=3D str + 5);
 }
=20
 int main(int argc, char **argv)
--=20
2.7.4

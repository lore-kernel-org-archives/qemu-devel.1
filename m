Received: from eggs.gnu.org ([2001:4830:134:3::10]:44911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNIT6-0004DA-Ln
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNIT5-00029c-LT
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dNIT5-000299-Du
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81B4A4E4FC
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 12:41:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 20 Jun 2017 14:40:31 +0200
Message-Id: <1497962468-22936-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1497962468-22936-1-git-send-email-armbru@redhat.com>
References: <1497962468-22936-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 04/41] tests: add more int/number ranges
 checks
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170607163635.17635-5-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[test_visitor_in_uint() tightened slightly]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qobject-input-visitor.c | 39 ++++++++++++++++++++++++++++++++=
+++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index 83d663d..4dc9c03 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -107,6 +107,7 @@ static void test_visitor_in_int(TestInputVisitorData =
*data,
                                 const void *unused)
 {
     int64_t res =3D 0;
+    double dbl;
     int value =3D -42;
     Visitor *v;
=20
@@ -114,6 +115,9 @@ static void test_visitor_in_int(TestInputVisitorData =
*data,
=20
     visit_type_int(v, NULL, &res, &error_abort);
     g_assert_cmpint(res, =3D=3D, value);
+
+    visit_type_number(v, NULL, &dbl, &error_abort);
+    g_assert_cmpfloat(dbl, =3D=3D, -42.0);
 }
=20
 static void test_visitor_in_uint(TestInputVisitorData *data,
@@ -121,6 +125,8 @@ static void test_visitor_in_uint(TestInputVisitorData=
 *data,
 {
     Error *err =3D NULL;
     uint64_t res =3D 0;
+    int64_t i64;
+    double dbl;
     int value =3D 42;
     Visitor *v;
=20
@@ -129,8 +135,13 @@ static void test_visitor_in_uint(TestInputVisitorDat=
a *data,
     visit_type_uint64(v, NULL, &res, &error_abort);
     g_assert_cmpuint(res, =3D=3D, (uint64_t)value);
=20
+    visit_type_int(v, NULL, &i64, &error_abort);
+    g_assert_cmpint(i64, =3D=3D, value);
+
+    visit_type_number(v, NULL, &dbl, &error_abort);
+    g_assert_cmpfloat(dbl, =3D=3D, value);
+
     /* BUG: value between INT64_MIN and -1 accepted modulo 2^64 */
-
     v =3D visitor_input_test_init(data, "%d", -value);
=20
     visit_type_uint64(v, NULL, &res, &error_abort);
@@ -142,6 +153,9 @@ static void test_visitor_in_uint(TestInputVisitorData=
 *data,
=20
     visit_type_uint64(v, NULL, &res, &err);
     error_free_or_abort(&err);
+
+    visit_type_number(v, NULL, &dbl, &error_abort);
+    g_assert_cmpfloat(dbl, =3D=3D, 18446744073709552000.0);
 }
=20
 static void test_visitor_in_int_overflow(TestInputVisitorData *data,
@@ -260,6 +274,27 @@ static void test_visitor_in_number(TestInputVisitorD=
ata *data,
     g_assert_cmpfloat(res, =3D=3D, value);
 }
=20
+static void test_visitor_in_large_number(TestInputVisitorData *data,
+                                         const void *unused)
+{
+    Error *err =3D NULL;
+    double res =3D 0;
+    int64_t i64;
+    uint64_t u64;
+    Visitor *v;
+
+    v =3D visitor_input_test_init(data, "-18446744073709551616"); /* -2^=
64 */
+
+    visit_type_number(v, NULL, &res, &error_abort);
+    g_assert_cmpfloat(res, =3D=3D, -18446744073709552e3);
+
+    visit_type_int(v, NULL, &i64, &err);
+    error_free_or_abort(&err);
+
+    visit_type_uint64(v, NULL, &u64, &err);
+    error_free_or_abort(&err);
+}
+
 static void test_visitor_in_number_keyval(TestInputVisitorData *data,
                                           const void *unused)
 {
@@ -1253,6 +1288,8 @@ int main(int argc, char **argv)
                            NULL, test_visitor_in_bool_str_fail);
     input_visitor_test_add("/visitor/input/number",
                            NULL, test_visitor_in_number);
+    input_visitor_test_add("/visitor/input/large_number",
+                           NULL, test_visitor_in_large_number);
     input_visitor_test_add("/visitor/input/number_keyval",
                            NULL, test_visitor_in_number_keyval);
     input_visitor_test_add("/visitor/input/number_str_keyval",
--=20
2.7.5

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d894F-0005de-Aa
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d894C-0003Vf-8Y
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:36:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d894B-0003VQ-Vt
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:36:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E81B16540A
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 17:36:54 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 20:35:45 +0300
Message-Id: <20170509173559.31598-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170509173559.31598-1-marcandre.lureau@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/17] tests: remove alt num-int cases
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

There are no real users of this case, and it's going to be invalid after
merging of QFloat and QInt use the same QNum type in the following patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-keyval.c                     |  3 ---
 tests/test-qobject-input-visitor.c      | 26 --------------------------
 tests/qapi-schema/qapi-schema-test.json |  2 --
 tests/qapi-schema/qapi-schema-test.out  |  8 --------
 4 files changed, 39 deletions(-)

diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index c556b1b117..df0ff831b5 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -615,7 +615,6 @@ static void test_keyval_visit_alternate(void)
     Visitor *v;
     QDict *qdict;
     AltNumStr *ans;
-    AltNumInt *ani;
=20
     /*
      * Can't do scalar alternate variants other than string.  You get
@@ -629,8 +628,6 @@ static void test_keyval_visit_alternate(void)
     g_assert_cmpint(ans->type, =3D=3D, QTYPE_QSTRING);
     g_assert_cmpstr(ans->u.s, =3D=3D, "1");
     qapi_free_AltNumStr(ans);
-    visit_type_AltNumInt(v, "a", &ani, &err);
-    error_free_or_abort(&err);
     visit_end_struct(v, NULL);
     visit_free(v);
 }
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index f965743b6e..a30e2d5e95 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -586,8 +586,6 @@ static void test_visitor_in_alternate_number(TestInpu=
tVisitorData *data,
     AltStrNum *asn;
     AltNumStr *ans;
     AltStrInt *asi;
-    AltIntNum *ain;
-    AltNumInt *ani;
=20
     /* Parsing an int */
=20
@@ -614,18 +612,6 @@ static void test_visitor_in_alternate_number(TestInp=
utVisitorData *data,
     g_assert_cmpint(asi->u.i, =3D=3D, 42);
     qapi_free_AltStrInt(asi);
=20
-    v =3D visitor_input_test_init(data, "42");
-    visit_type_AltIntNum(v, NULL, &ain, &error_abort);
-    g_assert_cmpint(ain->type, =3D=3D, QTYPE_QINT);
-    g_assert_cmpint(ain->u.i, =3D=3D, 42);
-    qapi_free_AltIntNum(ain);
-
-    v =3D visitor_input_test_init(data, "42");
-    visit_type_AltNumInt(v, NULL, &ani, &error_abort);
-    g_assert_cmpint(ani->type, =3D=3D, QTYPE_QINT);
-    g_assert_cmpint(ani->u.i, =3D=3D, 42);
-    qapi_free_AltNumInt(ani);
-
     /* Parsing a double */
=20
     v =3D visitor_input_test_init(data, "42.5");
@@ -649,18 +635,6 @@ static void test_visitor_in_alternate_number(TestInp=
utVisitorData *data,
     visit_type_AltStrInt(v, NULL, &asi, &err);
     error_free_or_abort(&err);
     qapi_free_AltStrInt(asi);
-
-    v =3D visitor_input_test_init(data, "42.5");
-    visit_type_AltIntNum(v, NULL, &ain, &error_abort);
-    g_assert_cmpint(ain->type, =3D=3D, QTYPE_QFLOAT);
-    g_assert_cmpfloat(ain->u.n, =3D=3D, 42.5);
-    qapi_free_AltIntNum(ain);
-
-    v =3D visitor_input_test_init(data, "42.5");
-    visit_type_AltNumInt(v, NULL, &ani, &error_abort);
-    g_assert_cmpint(ani->type, =3D=3D, QTYPE_QFLOAT);
-    g_assert_cmpfloat(ani->u.n, =3D=3D, 42.5);
-    qapi_free_AltNumInt(ani);
 }
=20
 static void test_native_list_integer_helper(TestInputVisitorData *data,
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 842ea3c5e3..9ad09e3758 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -103,8 +103,6 @@
 { 'alternate': 'AltStrNum', 'data': { 's': 'str', 'n': 'number' } }
 { 'alternate': 'AltNumStr', 'data': { 'n': 'number', 's': 'str' } }
 { 'alternate': 'AltStrInt', 'data': { 's': 'str', 'i': 'int' } }
-{ 'alternate': 'AltIntNum', 'data': { 'i': 'int', 'n': 'number' } }
-{ 'alternate': 'AltNumInt', 'data': { 'n': 'number', 'i': 'int' } }
=20
 # for testing native lists
 { 'union': 'UserDefNativeListUnion',
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 9d99c4eebb..5c6655a5c3 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -1,11 +1,3 @@
-alternate AltIntNum
-    tag type
-    case i: int
-    case n: number
-alternate AltNumInt
-    tag type
-    case n: number
-    case i: int
 alternate AltNumStr
     tag type
     case n: number
--=20
2.13.0.rc1.16.gd80b50c3f

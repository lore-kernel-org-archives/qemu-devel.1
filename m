Received: from eggs.gnu.org ([2001:4830:134:3::10]:38205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKGC-0000aA-SF
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKGB-0003V7-59
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJKGA-0003Us-SU
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF1EAC0587E3
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 13:47:29 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  9 Jun 2017 15:46:47 +0200
Message-Id: <1497016045-6009-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1497016045-6009-1-git-send-email-armbru@redhat.com>
References: <1497016045-6009-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/41] tests: Remove test cases for alternates
 of 'number' and 'int'
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

Alternates with both a 'number' and an 'int' branch will become
invalid when the next patch merges of QFloat and QInt into QNum.
More sophisticated alternate code could keep them valid, but since
we have no users outside tests, simply drop the tests.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170607163635.17635-4-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/qapi-schema-test.json |  2 --
 tests/qapi-schema/qapi-schema-test.out  |  8 --------
 tests/test-keyval.c                     |  4 ++--
 tests/test-qobject-input-visitor.c      | 26 --------------------------
 4 files changed, 2 insertions(+), 38 deletions(-)

diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 17649c6..91ffb26 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -103,8 +103,6 @@
 { 'alternate': 'AltEnumNum', 'data': { 'e': 'EnumOne', 'n': 'number' } }
 { 'alternate': 'AltNumEnum', 'data': { 'n': 'number', 'e': 'EnumOne' } }
 { 'alternate': 'AltEnumInt', 'data': { 'e': 'EnumOne', 'i': 'int' } }
-{ 'alternate': 'AltIntNum', 'data': { 'i': 'int', 'n': 'number' } }
-{ 'alternate': 'AltNumInt', 'data': { 'n': 'number', 'i': 'int' } }
=20
 # for testing use of 'str' within alternates
 { 'alternate': 'AltStrObj', 'data': { 's': 'str', 'o': 'TestStruct' } }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 9f68610..e727a5a 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -10,18 +10,10 @@ alternate AltEnumNum
     tag type
     case e: EnumOne
     case n: number
-alternate AltIntNum
-    tag type
-    case i: int
-    case n: number
 alternate AltNumEnum
     tag type
     case n: number
     case e: EnumOne
-alternate AltNumInt
-    tag type
-    case n: number
-    case i: int
 alternate AltStrObj
     tag type
     case s: str
diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index c3be005..baf7e33 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -615,7 +615,7 @@ static void test_keyval_visit_alternate(void)
     Visitor *v;
     QDict *qdict;
     AltStrObj *aso;
-    AltNumInt *ani;
+    AltNumEnum *ane;
     AltEnumBool *aeb;
=20
     /*
@@ -631,7 +631,7 @@ static void test_keyval_visit_alternate(void)
     g_assert_cmpint(aso->type, =3D=3D, QTYPE_QSTRING);
     g_assert_cmpstr(aso->u.s, =3D=3D, "1");
     qapi_free_AltStrObj(aso);
-    visit_type_AltNumInt(v, "b", &ani, &err);
+    visit_type_AltNumEnum(v, "b", &ane, &err);
     error_free_or_abort(&err);
     visit_type_AltEnumBool(v, "c", &aeb, &err);
     error_free_or_abort(&err);
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index 6b997a1..83d663d 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -592,8 +592,6 @@ static void test_visitor_in_alternate_number(TestInpu=
tVisitorData *data,
     AltEnumNum *aen;
     AltNumEnum *ans;
     AltEnumInt *asi;
-    AltIntNum *ain;
-    AltNumInt *ani;
=20
     /* Parsing an int */
=20
@@ -620,18 +618,6 @@ static void test_visitor_in_alternate_number(TestInp=
utVisitorData *data,
     g_assert_cmpint(asi->u.i, =3D=3D, 42);
     qapi_free_AltEnumInt(asi);
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
@@ -655,18 +641,6 @@ static void test_visitor_in_alternate_number(TestInp=
utVisitorData *data,
     visit_type_AltEnumInt(v, NULL, &asi, &err);
     error_free_or_abort(&err);
     qapi_free_AltEnumInt(asi);
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
--=20
2.7.5

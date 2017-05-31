Received: from eggs.gnu.org ([2001:4830:134:3::10]:51973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG48a-0003NP-MN
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG48Z-0003y8-B8
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:58:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG48Z-0003xe-3N
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:58:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F36639D404
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 13:58:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:56:31 +0400
Message-Id: <20170531135709.345-8-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/45] tests: remove alt num-int cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

From: Markus Armbruster <armbru@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> There are no real users of this case, and it's going to be invalid afte=
r
> merging of QFloat and QInt use the same QNum type in the following patc=
h.

Invalid because our alternate code is insufficiently sophisticated.  In
other words fixable.  See "[PATCH 4/4] qapi: Reject alternates that
can't work with keyval_parse()" I just posted.

My patch's commit message describes two related issues, one fixable and
one unfixable.  The fixable one already exists, but only in QGA.  I
intend to fix it, but it's not a priority.

Fixing the issue you describe seems even less important.  I considered
outlawing it in my series (patch appended for your reading pleasure),
but decided to leave it to yours.  I don't expect you to replace your
patch.  Perhaps my patch helps you with rebasing yours should that
become necessary.

Message-Id: <87tw4cn7sh.fsf@dusky.pond.sub.org>
---
 scripts/qapi.py                         |  4 ++++
 tests/test-keyval.c                     |  4 ++--
 tests/test-qobject-input-visitor.c      | 26 --------------------------
 tests/qapi-schema/qapi-schema-test.json |  2 --
 tests/qapi-schema/qapi-schema-test.out  |  8 --------
 5 files changed, 6 insertions(+), 38 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index b7a25e4759..06e583d8c3 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -826,6 +826,10 @@ def check_alternate(expr, info):
                 conflicting.add('QTYPE_QINT')
                 conflicting.add('QTYPE_QFLOAT')
                 conflicting.add('QTYPE_QBOOL')
+        elif qtype =3D=3D 'QTYPE_QINT':
+            conflicting.add('QTYPE_QFLOAT')
+        elif qtype =3D=3D 'QTYPE_QFLOAT':
+            conflicting.add('QTYPE_QINT')
         if conflicting & set(types_seen):
             raise QAPISemError(info, "Alternate '%s' member '%s' can't "
                                "be distinguished from member '%s'"
diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index c3be00524c..baf7e339ab 100644
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
index 6b997a177d..83d663d11d 100644
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
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 17649c6398..91ffb2648c 100644
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
index 9f68610dc2..e727a5a84c 100644
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
--=20
2.13.0.91.g00982b8dd

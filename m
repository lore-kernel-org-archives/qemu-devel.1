Received: from eggs.gnu.org ([2001:4830:134:3::10]:53843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dCqjp-0000VJ-2Q
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dCqjj-0003EQ-VM
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:03:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dCqjj-0003DC-NN
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:03:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B8193DBF6
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 17:03:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-4-marcandre.lureau@redhat.com>
Date: Mon, 22 May 2017 19:03:10 +0200
In-Reply-To: <20170509173559.31598-4-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 9 May 2017 20:35:45 +0300")
Message-ID: <87tw4cn7sh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/17] tests: remove alt num-int cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> There are no real users of this case, and it's going to be invalid after
> merging of QFloat and QInt use the same QNum type in the following patch.

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


diff --git a/scripts/qapi.py b/scripts/qapi.py
index b7a25e4..06e583d 100644
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
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qa=
pi-schema-test.json
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
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qap=
i-schema-test.out
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
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-=
visitor.c
index 6b997a1..83d663d 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -592,8 +592,6 @@ static void test_visitor_in_alternate_number(TestInputV=
isitorData *data,
     AltEnumNum *aen;
     AltNumEnum *ans;
     AltEnumInt *asi;
-    AltIntNum *ain;
-    AltNumInt *ani;
=20
     /* Parsing an int */
=20
@@ -620,18 +618,6 @@ static void test_visitor_in_alternate_number(TestInput=
VisitorData *data,
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
@@ -655,18 +641,6 @@ static void test_visitor_in_alternate_number(TestInput=
VisitorData *data,
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

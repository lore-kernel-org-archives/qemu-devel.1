Received: from eggs.gnu.org ([2001:4830:134:3::10]:32859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG77S-0002M1-63
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG77P-0000db-42
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:09:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dG77O-0000d9-Rk
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:09:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F339181250
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 17:09:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-98.ams2.redhat.com
	[10.36.116.98])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AA9E7C8A1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 17:09:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 31 May 2017 19:09:06 +0200
Message-Id: <1496250547-20701-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1496250547-20701-1-git-send-email-armbru@redhat.com>
References: <1496250547-20701-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/4] tests/qapi-schema: Avoid 'str' in alternate
 test cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The next commit is going to make alternate members of type 'str'
conflict with other scalar types.  Would break a few test cases that
don't actually require 'str'.  Flip them from 'str' to 'bool' or
'EnumOne'.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1495471335-23707-4-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/qapi-schema/alternate-clash.json          |  2 +-
 tests/qapi-schema/alternate-nested.json         |  2 +-
 tests/qapi-schema/args-alternate.json           |  2 +-
 tests/qapi-schema/doc-bad-alternate-member.json |  2 +-
 tests/qapi-schema/qapi-schema-test.json         |  9 ++--
 tests/qapi-schema/qapi-schema-test.out          | 30 +++++++------
 tests/qapi-schema/returns-alternate.json        |  2 +-
 tests/test-clone-visitor.c                      | 23 +++++-----
 tests/test-qobject-input-visitor.c              | 56 ++++++++++++-------=
------
 tests/test-qobject-output-visitor.c             |  4 +-
 10 files changed, 68 insertions(+), 64 deletions(-)

diff --git a/tests/qapi-schema/alternate-clash.json b/tests/qapi-schema/a=
lternate-clash.json
index 6d73bc5..9a59b88 100644
--- a/tests/qapi-schema/alternate-clash.json
+++ b/tests/qapi-schema/alternate-clash.json
@@ -5,4 +5,4 @@
 # the implicit Alt1Kind enum, we would still have a collision with the
 # resulting C union trying to have two members named 'a_b'.
 { 'alternate': 'Alt1',
-  'data': { 'a-b': 'str', 'a_b': 'int' } }
+  'data': { 'a-b': 'bool', 'a_b': 'int' } }
diff --git a/tests/qapi-schema/alternate-nested.json b/tests/qapi-schema/=
alternate-nested.json
index 8e22186..f2b9632 100644
--- a/tests/qapi-schema/alternate-nested.json
+++ b/tests/qapi-schema/alternate-nested.json
@@ -1,5 +1,5 @@
 # we reject a nested alternate branch
 { 'alternate': 'Alt1',
-  'data': { 'name': 'str', 'value': 'int' } }
+  'data': { 'name': 'bool', 'value': 'int' } }
 { 'alternate': 'Alt2',
   'data': { 'nested': 'Alt1', 'b': 'bool' } }
diff --git a/tests/qapi-schema/args-alternate.json b/tests/qapi-schema/ar=
gs-alternate.json
index 69e94d4..824d69c 100644
--- a/tests/qapi-schema/args-alternate.json
+++ b/tests/qapi-schema/args-alternate.json
@@ -1,3 +1,3 @@
 # we do not allow alternate arguments
-{ 'alternate': 'Alt', 'data': { 'case1': 'int', 'case2': 'str' } }
+{ 'alternate': 'Alt', 'data': { 'case1': 'int', 'case2': 'bool' } }
 { 'command': 'oops', 'data': 'Alt' }
diff --git a/tests/qapi-schema/doc-bad-alternate-member.json b/tests/qapi=
-schema/doc-bad-alternate-member.json
index 738635c..fa4143d 100644
--- a/tests/qapi-schema/doc-bad-alternate-member.json
+++ b/tests/qapi-schema/doc-bad-alternate-member.json
@@ -6,4 +6,4 @@
 # @bb: b
 ##
 { 'alternate': 'AorB',
-  'data': { 'a': 'str', 'b': 'int' } }
+  'data': { 'a': 'bool', 'b': 'int' } }
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 842ea3c..303f2b2 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -93,16 +93,17 @@
 { 'struct': 'WrapAlternate',
   'data': { 'alt': 'UserDefAlternate' } }
 { 'alternate': 'UserDefAlternate',
-  'data': { 'udfu': 'UserDefFlatUnion', 's': 'str', 'i': 'int' } }
+  'data': { 'udfu': 'UserDefFlatUnion', 'e': 'EnumOne', 'i': 'int' } }
=20
 { 'struct': 'UserDefC',
   'data': { 'string1': 'str', 'string2': 'str' } }
=20
 # for testing use of 'number' within alternates
-{ 'alternate': 'AltStrBool', 'data': { 's': 'str', 'b': 'bool' } }
-{ 'alternate': 'AltStrNum', 'data': { 's': 'str', 'n': 'number' } }
+{ 'alternate': 'AltEnumBool', 'data': { 'e': 'EnumOne', 'b': 'bool' } }
+{ 'alternate': 'AltEnumNum', 'data': { 'e': 'EnumOne', 'n': 'number' } }
 { 'alternate': 'AltNumStr', 'data': { 'n': 'number', 's': 'str' } }
-{ 'alternate': 'AltStrInt', 'data': { 's': 'str', 'i': 'int' } }
+{ 'alternate': 'AltNumEnum', 'data': { 'n': 'number', 'e': 'EnumOne' } }
+{ 'alternate': 'AltEnumInt', 'data': { 'e': 'EnumOne', 'i': 'int' } }
 { 'alternate': 'AltIntNum', 'data': { 'i': 'int', 'n': 'number' } }
 { 'alternate': 'AltNumInt', 'data': { 'n': 'number', 'i': 'int' } }
=20
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 9d99c4e..3081091 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -1,7 +1,23 @@
+alternate AltEnumBool
+    tag type
+    case e: EnumOne
+    case b: bool
+alternate AltEnumInt
+    tag type
+    case e: EnumOne
+    case i: int
+alternate AltEnumNum
+    tag type
+    case e: EnumOne
+    case n: number
 alternate AltIntNum
     tag type
     case i: int
     case n: number
+alternate AltNumEnum
+    tag type
+    case n: number
+    case e: EnumOne
 alternate AltNumInt
     tag type
     case n: number
@@ -10,18 +26,6 @@ alternate AltNumStr
     tag type
     case n: number
     case s: str
-alternate AltStrBool
-    tag type
-    case s: str
-    case b: bool
-alternate AltStrInt
-    tag type
-    case s: str
-    case i: int
-alternate AltStrNum
-    tag type
-    case s: str
-    case n: number
 event EVENT_A None
    boxed=3DFalse
 event EVENT_B None
@@ -66,7 +70,7 @@ object UserDefA
 alternate UserDefAlternate
     tag type
     case udfu: UserDefFlatUnion
-    case s: str
+    case e: EnumOne
     case i: int
 object UserDefB
     member intb: int optional=3DFalse
diff --git a/tests/qapi-schema/returns-alternate.json b/tests/qapi-schema=
/returns-alternate.json
index 972390c..f873718 100644
--- a/tests/qapi-schema/returns-alternate.json
+++ b/tests/qapi-schema/returns-alternate.json
@@ -1,3 +1,3 @@
 # we reject returns if it is an alternate type
-{ 'alternate': 'Alt', 'data': { 'a': 'int', 'b': 'str' } }
+{ 'alternate': 'Alt', 'data': { 'a': 'int', 'b': 'bool' } }
 { 'command': 'oops', 'returns': 'Alt' }
diff --git a/tests/test-clone-visitor.c b/tests/test-clone-visitor.c
index df0c045..9698216 100644
--- a/tests/test-clone-visitor.c
+++ b/tests/test-clone-visitor.c
@@ -42,29 +42,28 @@ static void test_clone_struct(void)
=20
 static void test_clone_alternate(void)
 {
-    AltStrBool *b_src, *s_src, *b_dst, *s_dst;
+    AltEnumBool *b_src, *s_src, *b_dst, *s_dst;
=20
-    b_src =3D g_new0(AltStrBool, 1);
+    b_src =3D g_new0(AltEnumBool, 1);
     b_src->type =3D QTYPE_QBOOL;
     b_src->u.b =3D true;
-    s_src =3D g_new0(AltStrBool, 1);
+    s_src =3D g_new0(AltEnumBool, 1);
     s_src->type =3D QTYPE_QSTRING;
-    s_src->u.s =3D g_strdup("World");
+    s_src->u.e =3D ENUM_ONE_VALUE1;
=20
-    b_dst =3D QAPI_CLONE(AltStrBool, b_src);
+    b_dst =3D QAPI_CLONE(AltEnumBool, b_src);
     g_assert(b_dst);
     g_assert_cmpint(b_dst->type, =3D=3D, b_src->type);
     g_assert_cmpint(b_dst->u.b, =3D=3D, b_src->u.b);
-    s_dst =3D QAPI_CLONE(AltStrBool, s_src);
+    s_dst =3D QAPI_CLONE(AltEnumBool, s_src);
     g_assert(s_dst);
     g_assert_cmpint(s_dst->type, =3D=3D, s_src->type);
-    g_assert_cmpstr(s_dst->u.s, =3D=3D, s_src->u.s);
-    g_assert(s_dst->u.s !=3D s_src->u.s);
+    g_assert_cmpint(s_dst->u.e, =3D=3D, s_src->u.e);
=20
-    qapi_free_AltStrBool(b_src);
-    qapi_free_AltStrBool(s_src);
-    qapi_free_AltStrBool(b_dst);
-    qapi_free_AltStrBool(s_dst);
+    qapi_free_AltEnumBool(b_src);
+    qapi_free_AltEnumBool(s_src);
+    qapi_free_AltEnumBool(b_dst);
+    qapi_free_AltEnumBool(s_dst);
 }
=20
 static void test_clone_native_list(void)
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index e2aabbe..6b997a1 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -537,10 +537,10 @@ static void test_visitor_in_alternate(TestInputVisi=
torData *data,
     g_assert_cmpint(tmp->u.i, =3D=3D, 42);
     qapi_free_UserDefAlternate(tmp);
=20
-    v =3D visitor_input_test_init(data, "'string'");
+    v =3D visitor_input_test_init(data, "'value1'");
     visit_type_UserDefAlternate(v, NULL, &tmp, &error_abort);
     g_assert_cmpint(tmp->type, =3D=3D, QTYPE_QSTRING);
-    g_assert_cmpstr(tmp->u.s, =3D=3D, "string");
+    g_assert_cmpint(tmp->u.e, =3D=3D, ENUM_ONE_VALUE1);
     qapi_free_UserDefAlternate(tmp);
=20
     v =3D visitor_input_test_init(data, "{'integer':1, 'string':'str', "
@@ -565,10 +565,10 @@ static void test_visitor_in_alternate(TestInputVisi=
torData *data,
     g_assert_cmpint(wrap->alt->u.i, =3D=3D, 42);
     qapi_free_WrapAlternate(wrap);
=20
-    v =3D visitor_input_test_init(data, "{ 'alt': 'string' }");
+    v =3D visitor_input_test_init(data, "{ 'alt': 'value1' }");
     visit_type_WrapAlternate(v, NULL, &wrap, &error_abort);
     g_assert_cmpint(wrap->alt->type, =3D=3D, QTYPE_QSTRING);
-    g_assert_cmpstr(wrap->alt->u.s, =3D=3D, "string");
+    g_assert_cmpint(wrap->alt->u.e, =3D=3D, ENUM_ONE_VALUE1);
     qapi_free_WrapAlternate(wrap);
=20
     v =3D visitor_input_test_init(data, "{ 'alt': {'integer':1, 'string'=
:'str', "
@@ -588,37 +588,37 @@ static void test_visitor_in_alternate_number(TestIn=
putVisitorData *data,
 {
     Visitor *v;
     Error *err =3D NULL;
-    AltStrBool *asb;
-    AltStrNum *asn;
-    AltNumStr *ans;
-    AltStrInt *asi;
+    AltEnumBool *aeb;
+    AltEnumNum *aen;
+    AltNumEnum *ans;
+    AltEnumInt *asi;
     AltIntNum *ain;
     AltNumInt *ani;
=20
     /* Parsing an int */
=20
     v =3D visitor_input_test_init(data, "42");
-    visit_type_AltStrBool(v, NULL, &asb, &err);
+    visit_type_AltEnumBool(v, NULL, &aeb, &err);
     error_free_or_abort(&err);
-    qapi_free_AltStrBool(asb);
+    qapi_free_AltEnumBool(aeb);
=20
     v =3D visitor_input_test_init(data, "42");
-    visit_type_AltStrNum(v, NULL, &asn, &error_abort);
-    g_assert_cmpint(asn->type, =3D=3D, QTYPE_QFLOAT);
-    g_assert_cmpfloat(asn->u.n, =3D=3D, 42);
-    qapi_free_AltStrNum(asn);
+    visit_type_AltEnumNum(v, NULL, &aen, &error_abort);
+    g_assert_cmpint(aen->type, =3D=3D, QTYPE_QFLOAT);
+    g_assert_cmpfloat(aen->u.n, =3D=3D, 42);
+    qapi_free_AltEnumNum(aen);
=20
     v =3D visitor_input_test_init(data, "42");
-    visit_type_AltNumStr(v, NULL, &ans, &error_abort);
+    visit_type_AltNumEnum(v, NULL, &ans, &error_abort);
     g_assert_cmpint(ans->type, =3D=3D, QTYPE_QFLOAT);
     g_assert_cmpfloat(ans->u.n, =3D=3D, 42);
-    qapi_free_AltNumStr(ans);
+    qapi_free_AltNumEnum(ans);
=20
     v =3D visitor_input_test_init(data, "42");
-    visit_type_AltStrInt(v, NULL, &asi, &error_abort);
+    visit_type_AltEnumInt(v, NULL, &asi, &error_abort);
     g_assert_cmpint(asi->type, =3D=3D, QTYPE_QINT);
     g_assert_cmpint(asi->u.i, =3D=3D, 42);
-    qapi_free_AltStrInt(asi);
+    qapi_free_AltEnumInt(asi);
=20
     v =3D visitor_input_test_init(data, "42");
     visit_type_AltIntNum(v, NULL, &ain, &error_abort);
@@ -635,26 +635,26 @@ static void test_visitor_in_alternate_number(TestIn=
putVisitorData *data,
     /* Parsing a double */
=20
     v =3D visitor_input_test_init(data, "42.5");
-    visit_type_AltStrBool(v, NULL, &asb, &err);
+    visit_type_AltEnumBool(v, NULL, &aeb, &err);
     error_free_or_abort(&err);
-    qapi_free_AltStrBool(asb);
+    qapi_free_AltEnumBool(aeb);
=20
     v =3D visitor_input_test_init(data, "42.5");
-    visit_type_AltStrNum(v, NULL, &asn, &error_abort);
-    g_assert_cmpint(asn->type, =3D=3D, QTYPE_QFLOAT);
-    g_assert_cmpfloat(asn->u.n, =3D=3D, 42.5);
-    qapi_free_AltStrNum(asn);
+    visit_type_AltEnumNum(v, NULL, &aen, &error_abort);
+    g_assert_cmpint(aen->type, =3D=3D, QTYPE_QFLOAT);
+    g_assert_cmpfloat(aen->u.n, =3D=3D, 42.5);
+    qapi_free_AltEnumNum(aen);
=20
     v =3D visitor_input_test_init(data, "42.5");
-    visit_type_AltNumStr(v, NULL, &ans, &error_abort);
+    visit_type_AltNumEnum(v, NULL, &ans, &error_abort);
     g_assert_cmpint(ans->type, =3D=3D, QTYPE_QFLOAT);
     g_assert_cmpfloat(ans->u.n, =3D=3D, 42.5);
-    qapi_free_AltNumStr(ans);
+    qapi_free_AltNumEnum(ans);
=20
     v =3D visitor_input_test_init(data, "42.5");
-    visit_type_AltStrInt(v, NULL, &asi, &err);
+    visit_type_AltEnumInt(v, NULL, &asi, &err);
     error_free_or_abort(&err);
-    qapi_free_AltStrInt(asi);
+    qapi_free_AltEnumInt(asi);
=20
     v =3D visitor_input_test_init(data, "42.5");
     visit_type_AltIntNum(v, NULL, &ain, &error_abort);
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
index 94b9518..4e8fdf1 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -406,12 +406,12 @@ static void test_visitor_out_alternate(TestOutputVi=
sitorData *data,
     visitor_reset(data);
     tmp =3D g_new0(UserDefAlternate, 1);
     tmp->type =3D QTYPE_QSTRING;
-    tmp->u.s =3D g_strdup("hello");
+    tmp->u.e =3D ENUM_ONE_VALUE1;
=20
     visit_type_UserDefAlternate(data->ov, NULL, &tmp, &error_abort);
     qstr =3D qobject_to_qstring(visitor_get(data));
     g_assert(qstr);
-    g_assert_cmpstr(qstring_get_str(qstr), =3D=3D, "hello");
+    g_assert_cmpstr(qstring_get_str(qstr), =3D=3D, "value1");
=20
     qapi_free_UserDefAlternate(tmp);
=20
--=20
2.7.4

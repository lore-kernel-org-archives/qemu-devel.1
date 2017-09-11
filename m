Received: from eggs.gnu.org ([2001:4830:134:3::10]:43369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMZ9-00060S-RS
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMZ3-0006oJ-Po
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drMZ3-0006nW-Is
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:41 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 13:06:01 +0200
Message-Id: <20170911110623.24981-29-marcandre.lureau@redhat.com>
In-Reply-To: <20170911110623.24981-1-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 28/50] qapi: add 'if' to alternate variant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                         | 9 ++++++++-
 tests/qapi-schema/qapi-schema-test.json | 6 +++++-
 tests/qapi-schema/qapi-schema-test.out  | 8 +++++++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 2f14edfa1f..19e48bd4d2 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -849,6 +849,9 @@ def check_alternate(expr, info):
         check_type(info, "Member '%s' of alternate '%s'" % (key, name),
                    value,
                    allow_metas=3D['built-in', 'union', 'struct', 'enum']=
)
+        if isinstance(value, dict):
+            check_unknown_keys(info, value, {'type', 'if'})
+            value =3D value['type']
         qtype =3D find_alternate_member_qtype(value)
         if not qtype:
             raise QAPISemError(info, "Alternate '%s' member '%s' cannot =
use "
@@ -1671,7 +1674,11 @@ class QAPISchema(object):
                                               None))
=20
     def _make_variant(self, case, typ):
-        return QAPISchemaObjectTypeVariant(case, typ)
+        ifcond =3D None
+        if isinstance(typ, dict):
+            ifcond =3D typ.get('if')
+            typ =3D typ['type']
+        return QAPISchemaObjectTypeVariant(case, typ, ifcond)
=20
     def _make_simple_variant(self, case, typ, info):
         ifcond =3D None
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 895e80a978..f7a62b24d1 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -208,9 +208,13 @@
 { 'command': 'TestIfUnionCmd', 'data': { 'union_cmd_arg': 'TestIfUnion' =
},
   'if': 'defined(TEST_IF_UNION)' }
=20
-{ 'alternate': 'TestIfAlternate', 'data': { 'foo': 'int', 'bar': 'TestSt=
ruct' },
+{ 'alternate': 'TestIfAlternate', 'data':
+  { 'foo': 'int', 'alt_bar': { 'type': 'TestStruct', 'if': 'defined(TEST=
_IF_ALT_BAR)'} },
   'if': 'defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)' }
=20
+{ 'command': 'TestIfAlternateCmd', 'data': { 'alt_cmd_arg': 'TestIfAlter=
nate' },
+  'if': 'defined(TEST_IF_ALT)' }
+
 { 'command': 'TestIfCmd', 'data':
   { 'foo': 'TestIfStruct',
     'bar': { 'type': 'TestIfEnum', 'if': 'defined(TEST_IF_CMD_BAR)' } },
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index ee009c5626..6887e49c9b 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -67,8 +67,11 @@ enum QType
 alternate TestIfAlternate
     tag type
     case foo: int
-    case bar: TestStruct
+    case alt_bar: TestStruct if=3Ddefined(TEST_IF_ALT_BAR)
     if defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)
+command TestIfAlternateCmd q_obj_TestIfAlternateCmd-arg -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse
+    if defined(TEST_IF_ALT)
 command TestIfCmd q_obj_TestIfCmd-arg -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
     if defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)
@@ -232,6 +235,9 @@ object q_obj_EVENT_D-arg
     member b: str optional=3DFalse
     member c: str optional=3DTrue
     member enum3: EnumOne optional=3DTrue
+object q_obj_TestIfAlternateCmd-arg
+    member alt_cmd_arg: TestIfAlternate optional=3DFalse
+    if defined(TEST_IF_ALT)
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=3DFalse
     member bar: TestIfEnum optional=3DFalse if=3Ddefined(TEST_IF_CMD_BAR=
)
--=20
2.14.1.146.gd35faa819

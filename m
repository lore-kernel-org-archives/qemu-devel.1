Received: from eggs.gnu.org ([2001:4830:134:3::10]:54803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Ho-0006fA-3h
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Hk-00064F-67
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9Hj-00063K-Ss
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:00 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:38 +0200
Message-Id: <20170822132255.23945-38-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 37/54] qapi: 'if' to alternate variant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                         | 8 +++++++-
 tests/qapi-schema/qapi-schema-test.json | 6 +++++-
 tests/qapi-schema/qapi-schema-test.out  | 8 +++++++-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index cd5d151809..bcd8d37c12 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -829,6 +829,8 @@ def check_alternate(expr, info):
         check_type(info, "Member '%s' of alternate '%s'" % (key, name),
                    value,
                    allow_metas=3D['built-in', 'union', 'struct', 'enum']=
)
+        if isinstance(value, dict):
+            value =3D value['type']
         qtype =3D find_alternate_member_qtype(value)
         if not qtype:
             raise QAPISemError(info, "Alternate '%s' member '%s' cannot =
use "
@@ -1644,7 +1646,11 @@ class QAPISchema(object):
                                               None, ifcond))
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
index 23dae79f92..0032e4f026 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -206,9 +206,13 @@
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
   { 'foo': 'TestIfStruct', 'bar': { 'type': 'TestIfEnum', 'if': 'defined=
(TEST_IF_CMD_BAR)' } },
   'if': 'defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)' }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 12fc5a4425..8b8144574b 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -55,8 +55,11 @@ enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict=
', 'qlist', 'qbool']
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
@@ -200,6 +203,9 @@ object q_obj_EVENT_D-arg
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

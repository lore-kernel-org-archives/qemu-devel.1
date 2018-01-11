Received: from eggs.gnu.org ([2001:4830:134:3::10]:51319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkW8-0007Hp-Ko
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkW6-0003w5-GN
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkW6-0003uA-7V
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:06 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:27 +0100
Message-Id: <20180111213250.16511-29-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 28/51] qapi: add an error in case a
 discriminator is conditionnal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Making a discriminator conditonal doesn't make much sense. Instead,
the union could be made conditional.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                                         | 11 +++++++++--
 tests/Makefile.include                                  |  1 +
 .../qapi-schema/flat-union-invalid-if-discriminator.err |  1 +
 .../flat-union-invalid-if-discriminator.exit            |  1 +
 .../flat-union-invalid-if-discriminator.json            | 17 +++++++++++=
++++++
 .../qapi-schema/flat-union-invalid-if-discriminator.out |  0
 6 files changed, 29 insertions(+), 2 deletions(-)
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.err
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.exit
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.json
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.out

diff --git a/scripts/qapi.py b/scripts/qapi.py
index c4a2623864..0f6d5dd179 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -568,7 +568,8 @@ def find_alternate_member_qtype(qapi_type):
=20
 # Return the discriminator enum define if discriminator is specified as =
an
 # enum type, otherwise return None.
-def discriminator_find_enum_define(expr):
+def discriminator_find_enum_define(expr, info):
+    name =3D expr['union']
     base =3D expr.get('base')
     discriminator =3D expr.get('discriminator')
=20
@@ -583,6 +584,11 @@ def discriminator_find_enum_define(expr):
     if not discriminator_member:
         return None
=20
+    if discriminator_member.get('if'):
+        raise QAPISemError(info, 'The discriminator %s.%s for union %s '
+                           'must not be conditional' %
+                           (base, discriminator, name))
+
     return enum_types.get(discriminator_member['type'])
=20
=20
@@ -1010,7 +1016,8 @@ def check_exprs(exprs):
     # Try again for hidden UnionKind enum
     for expr_elem in exprs:
         expr =3D expr_elem['expr']
-        if 'union' in expr and not discriminator_find_enum_define(expr):
+        info =3D expr_elem['info']
+        if 'union' in expr and not discriminator_find_enum_define(expr, =
info):
             name =3D '%sKind' % expr['union']
         elif 'alternate' in expr:
             name =3D '%sKind' % expr['alternate']
diff --git a/tests/Makefile.include b/tests/Makefile.include
index afd2971147..3aec5b0874 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -479,6 +479,7 @@ qapi-schema +=3D flat-union-inline.json
 qapi-schema +=3D flat-union-int-branch.json
 qapi-schema +=3D flat-union-invalid-branch-key.json
 qapi-schema +=3D flat-union-invalid-discriminator.json
+qapi-schema +=3D flat-union-invalid-if-discriminator.json
 qapi-schema +=3D flat-union-no-base.json
 qapi-schema +=3D flat-union-optional-discriminator.json
 qapi-schema +=3D flat-union-string-discriminator.json
diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.err b/=
tests/qapi-schema/flat-union-invalid-if-discriminator.err
new file mode 100644
index 0000000000..0c94c9860d
--- /dev/null
+++ b/tests/qapi-schema/flat-union-invalid-if-discriminator.err
@@ -0,0 +1 @@
+tests/qapi-schema/flat-union-invalid-if-discriminator.json:13: The discr=
iminator TestBase.enum1 for union TestUnion must not be conditional
diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.exit b=
/tests/qapi-schema/flat-union-invalid-if-discriminator.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/flat-union-invalid-if-discriminator.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.json b=
/tests/qapi-schema/flat-union-invalid-if-discriminator.json
new file mode 100644
index 0000000000..618ec36396
--- /dev/null
+++ b/tests/qapi-schema/flat-union-invalid-if-discriminator.json
@@ -0,0 +1,17 @@
+{ 'enum': 'TestEnum',
+  'data': [ 'value1', 'value2' ] }
+
+{ 'struct': 'TestBase',
+  'data': { 'enum1': { 'type': 'TestEnum', 'if': 'FOO' } } }
+
+{ 'struct': 'TestTypeA',
+  'data': { 'string': 'str' } }
+
+{ 'struct': 'TestTypeB',
+  'data': { 'integer': 'int' } }
+
+{ 'union': 'TestUnion',
+  'base': 'TestBase',
+  'discriminator': 'enum1',
+  'data': { 'value1': 'TestTypeA',
+            'value2': 'TestTypeB' } }
diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.out b/=
tests/qapi-schema/flat-union-invalid-if-discriminator.out
new file mode 100644
index 0000000000..e69de29bb2
--=20
2.16.0.rc1.1.gef27df75a1

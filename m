Received: from eggs.gnu.org ([2001:4830:134:3::10]:59981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVacZ-00056L-RX
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:18:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVacW-0004Bo-MO
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:18:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gVacW-0004Bg-D1
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:18:04 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat,  8 Dec 2018 15:15:54 +0400
Message-Id: <20181208111606.8505-16-marcandre.lureau@redhat.com>
In-Reply-To: <20181208111606.8505-1-marcandre.lureau@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v7 15/27] qapi: add an error in case a
 discriminator is conditional
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

Making a discriminator conditional doesn't make much sense. Instead,
the union could be made conditional.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py                          |  8 ++++++++
 tests/Makefile.include                          |  1 +
 .../flat-union-invalid-if-discriminator.err     |  1 +
 .../flat-union-invalid-if-discriminator.exit    |  1 +
 .../flat-union-invalid-if-discriminator.json    | 17 +++++++++++++++++
 .../flat-union-invalid-if-discriminator.out     |  0
 6 files changed, 28 insertions(+)
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.err
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.exit
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.json
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.out

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index aec51acb07..f79b3fad54 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -578,6 +578,7 @@ def find_alternate_member_qtype(qapi_type):
 # Return the discriminator enum define if discriminator is specified as =
an
 # enum type, otherwise return None.
 def discriminator_find_enum_define(expr):
+    name =3D expr['union']
     base =3D expr.get('base')
     discriminator =3D expr.get('discriminator')
=20
@@ -594,6 +595,7 @@ def discriminator_find_enum_define(expr):
=20
     if isinstance(discriminator_value, dict):
         discriminator_value =3D discriminator_value['type']
+
     return enum_types.get(discriminator_value)
=20
=20
@@ -800,7 +802,12 @@ def check_union(expr, info):
                                "struct '%s'"
                                % (discriminator, base))
         if isinstance(discriminator_value, dict):
+            if discriminator_value.get('if'):
+                raise QAPISemError(info, 'The discriminator %s.%s for un=
ion %s '
+                                   'must not be conditional' %
+                                   (base, discriminator, name))
             discriminator_value =3D discriminator_value['type']
+
         enum_define =3D enum_types.get(discriminator_value)
         allow_metas =3D ['struct']
         # Do not allow string discriminator
@@ -1023,6 +1030,7 @@ def check_exprs(exprs):
=20
         if 'include' in expr:
             continue
+        info =3D expr_elem['info']
         if 'union' in expr and not discriminator_find_enum_define(expr):
             name =3D '%sKind' % expr['union']
         elif 'alternate' in expr:
diff --git a/tests/Makefile.include b/tests/Makefile.include
index ea5d1e8787..3f5a1d0c30 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -409,6 +409,7 @@ qapi-schema +=3D flat-union-inline-invalid-dict.json
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
2.20.0.rc1

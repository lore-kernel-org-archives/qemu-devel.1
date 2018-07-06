Received: from eggs.gnu.org ([2001:4830:134:3::10]:58514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORZ-0008TY-HZ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORY-0000J4-8R
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53630 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbORY-0000HB-43
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A45C4007865
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 10:58:27 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 12:57:44 +0200
Message-Id: <20180706105753.26700-19-marcandre.lureau@redhat.com>
In-Reply-To: <20180706105753.26700-1-marcandre.lureau@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 18/27] qapi: add an error in case a
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
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Making a discriminator conditonal doesn't make much sense. Instead,
the union could be made conditional.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py                          | 11 +++++++++--
 tests/Makefile.include                          |  1 +
 .../flat-union-invalid-if-discriminator.err     |  1 +
 .../flat-union-invalid-if-discriminator.exit    |  1 +
 .../flat-union-invalid-if-discriminator.json    | 17 +++++++++++++++++
 .../flat-union-invalid-if-discriminator.out     |  0
 6 files changed, 29 insertions(+), 2 deletions(-)
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.err
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.exit
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.json
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.out

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 9b95f8cfe9..13fbb28493 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -577,7 +577,8 @@ def find_alternate_member_qtype(qapi_type):
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
@@ -592,6 +593,11 @@ def discriminator_find_enum_define(expr):
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
@@ -1020,7 +1026,8 @@ def check_exprs(exprs):
=20
         if 'include' in expr:
             continue
-        if 'union' in expr and not discriminator_find_enum_define(expr):
+        info =3D expr_elem['info']
+        if 'union' in expr and not discriminator_find_enum_define(expr, =
info):
             name =3D '%sKind' % expr['union']
         elif 'alternate' in expr:
             name =3D '%sKind' % expr['alternate']
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 43e100a6cd..abc3fdf764 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -510,6 +510,7 @@ qapi-schema +=3D flat-union-inline.json
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
2.18.0.rc1

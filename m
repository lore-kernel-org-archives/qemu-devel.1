Received: from eggs.gnu.org ([2001:4830:134:3::10]:47312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXQGP-0000qX-1q
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXQGJ-0007bX-F6
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:38:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXQGJ-0007ZP-57
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:38:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6966631256D7
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 12:38:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 16:37:16 +0400
Message-Id: <20181213123724.4866-15-marcandre.lureau@redhat.com>
In-Reply-To: <20181213123724.4866-1-marcandre.lureau@redhat.com>
References: <20181213123724.4866-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 14/22] qapi: add an error in case a
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
Cc: armbru@redhat.com

Making a discriminator conditional doesn't make much sense.  "qapi:
add a dictionary form for TYPE" allows it, this patch fixes
it. Eventually the two could be merged, but for clarity of review it
is kept separate.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py                          |  4 ++++
 tests/Makefile.include                          |  1 +
 .../flat-union-invalid-if-discriminator.err     |  1 +
 .../flat-union-invalid-if-discriminator.exit    |  1 +
 .../flat-union-invalid-if-discriminator.json    | 17 +++++++++++++++++
 .../flat-union-invalid-if-discriminator.out     |  0
 6 files changed, 24 insertions(+)
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.err
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.exit
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.json
 create mode 100644 tests/qapi-schema/flat-union-invalid-if-discriminator=
.out

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index cc2842bcc7..8ea1dde03b 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -784,6 +784,10 @@ def check_union(expr, info):
                                "Discriminator '%s' is not a member of ba=
se "
                                "struct '%s'"
                                % (discriminator, base))
+        if discriminator_value.get('if'):
+            raise QAPISemError(info, 'The discriminator %s.%s for union =
%s '
+                               'must not be conditional' %
+                               (base, discriminator, name))
         enum_define =3D enum_types.get(discriminator_value['type'])
         allow_metas =3D ['struct']
         # Do not allow string discriminator
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
2.20.0

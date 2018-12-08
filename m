Received: from eggs.gnu.org ([2001:4830:134:3::10]:60317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVadN-0006Fj-V9
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:18:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVadN-0004v0-5v
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:18:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gVadM-0004um-Ve
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:18:57 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat,  8 Dec 2018 15:16:02 +0400
Message-Id: <20181208111606.8505-24-marcandre.lureau@redhat.com>
In-Reply-To: <20181208111606.8505-1-marcandre.lureau@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v7 23/27] qapi: add 'If:' condition to
 struct members documentation
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
 scripts/qapi/doc.py             | 4 ++--
 tests/qapi-schema/doc-good.json | 3 ++-
 tests/qapi-schema/doc-good.out  | 1 +
 tests/qapi-schema/doc-good.texi | 1 +
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 2133ded47e..e0cf94421c 100755
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -142,10 +142,10 @@ def texi_member(member, desc=3D'', suffix=3D''):
     """Format a table of members item for an object type member"""
     typ =3D member.type.doc_type()
     membertype =3D ': ' + typ if typ else ''
-    return '@item @code{%s%s}%s%s\n%s' % (
+    return '@item @code{%s%s}%s%s\n%s%s' % (
         member.name, membertype,
         ' (optional)' if member.optional else '',
-        suffix, desc)
+        suffix, desc, texi_if(member.ifcond, prefix=3D'@*'))
=20
=20
 def texi_members(doc, what, base, variants, member_func):
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good=
.json
index c7fe08c530..158443b1a3 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -72,7 +72,8 @@
 #
 # Another paragraph (but no @var: line)
 ##
-{ 'struct': 'Variant1', 'data': { 'var1': 'str' } }
+{ 'struct': 'Variant1',
+  'data': { 'var1': { 'type': 'str', 'if': 'defined(IFSTR)' } } }
=20
 ##
 # @Variant2:
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
index a05535b69b..c310b47be2 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -18,6 +18,7 @@ object Base
     member base1: Enum optional=3DFalse
 object Variant1
     member var1: str optional=3DFalse
+        if ['defined(IFSTR)']
 object Variant2
 object Object
     base Base
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
index 5c0231e0e6..0f8d69a378 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -119,6 +119,7 @@ Another paragraph (but no @code{var}: line)
 @table @asis
 @item @code{var1: string}
 Not documented
+@*@b{If:} @code{defined(IFSTR)}
 @end table
=20
 @end deftp
--=20
2.20.0.rc1

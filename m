Received: from eggs.gnu.org ([2001:4830:134:3::10]:51672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkWh-0007mN-DC
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkWc-00056l-Ej
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkWc-000558-8c
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:38 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:34 +0100
Message-Id: <20180111213250.16511-36-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 35/51] qapi2texi: add 'If:' condition to
 struct members
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi2texi.py            | 4 +++-
 tests/qapi-schema/doc-good.json | 3 ++-
 tests/qapi-schema/doc-good.out  | 1 +
 tests/qapi-schema/doc-good.texi | 2 ++
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index d1e69358f6..d760596ce0 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -138,9 +138,11 @@ def texi_member(member, suffix=3D''):
     """Format a table of members item for an object type member"""
     typ =3D member.type.doc_type()
     membertype =3D ': ' + typ if typ else ''
-    return '@item @code{%s%s}%s%s\n' % (
+    return '@item @code{%s%s}%s%s%s\n' % (
         member.name, membertype,
         ' (optional)' if member.optional else '',
+        '\n@b{If:} @code{%s}\n' %
+        ', '.join(member.ifcond) if member.ifcond else '',
         suffix)
=20
=20
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
index 74bf60bb83..972b58c815 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -29,6 +29,7 @@ enum SugaredUnionKind
     member two
 object Variant1
     member var1: str optional=3DFalse
+        if ['defined(IFSTR)']
 object Variant2
 command cmd q_obj_cmd-arg -> Object
    gen=3DTrue success_response=3DTrue boxed=3DFalse
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
index c9988c1305..f2a902a06b 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -118,6 +118,8 @@ Another paragraph (but no @code{var}: line)
 @b{Members:}
 @table @asis
 @item @code{var1: string}
+@b{If:} @code{defined(IFSTR)}
+
 Not documented
 @end table
=20
--=20
2.16.0.rc1.1.gef27df75a1

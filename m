Received: from eggs.gnu.org ([2001:4830:134:3::10]:51598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkWY-0007f8-J0
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkWX-0004tk-Gz
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkWX-0004pq-BR
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:33 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:33 +0100
Message-Id: <20180111213250.16511-35-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 34/51] qapi2texi: add 'If:' condition to
 enum values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi2texi.py            | 5 ++++-
 tests/qapi-schema/doc-good.json | 4 +++-
 tests/qapi-schema/doc-good.out  | 1 +
 tests/qapi-schema/doc-good.texi | 2 ++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 76c336af34..d1e69358f6 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -128,7 +128,10 @@ def texi_body(doc):
=20
 def texi_enum_value(value):
     """Format a table of members item for an enumeration value"""
-    return '@item @code{%s}\n' % value.name
+    return '@item @code{%s}%s\n' % (
+        value.name,
+        '\n@b{If:} @code{%s}\n' %
+        ', '.join(value.ifcond) if value.ifcond else '')
=20
=20
 def texi_member(member, suffix=3D''):
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good=
.json
index 984cd8ed06..c7fe08c530 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -55,7 +55,9 @@
 #
 # @two is undocumented
 ##
-{ 'enum': 'Enum', 'data': [ 'one', 'two' ], 'if': 'defined(IFCOND)' }
+{ 'enum': 'Enum', 'data':
+  [ { 'name': 'one', 'if': 'defined(IFENUM)' }, 'two' ],
+  'if': 'defined(IFCOND)' }
=20
 ##
 # @Base:
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
index 8c75da180c..74bf60bb83 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -2,6 +2,7 @@ object Base
     member base1: Enum optional=3DFalse
 enum Enum
     member one
+        if ['defined(IFENUM)']
     member two
     if ['defined(IFCOND)']
 object Object
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
index cd422f8a8f..c9988c1305 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -81,6 +81,8 @@ Examples:
 @b{Values:}
 @table @asis
 @item @code{one}
+@b{If:} @code{defined(IFENUM)}
+
 The @emph{one} @{and only@}
 @item @code{two}
 Not documented
--=20
2.16.0.rc1.1.gef27df75a1

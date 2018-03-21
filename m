Received: from eggs.gnu.org ([2001:4830:134:3::10]:48877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJH-0006Cl-SK
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJH-0008OU-0Y
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46154 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycJG-0008OC-SG
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6163CA2017
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:53:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:54 +0100
Message-Id: <20180321115211.17937-33-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 32/49] qapi2texi: add 'If:' condition to
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/doc.py             | 5 ++++-
 tests/qapi-schema/doc-good.json | 4 +++-
 tests/qapi-schema/doc-good.out  | 1 +
 tests/qapi-schema/doc-good.texi | 2 ++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 783b13303a..f629425f53 100755
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
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
index e4054e293c..d27d345de2 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -11,6 +11,7 @@ enum QType
 module doc-good.json
 enum Enum
     member one
+        if ['defined(IFENUM)']
     member two
     if ['defined(IFCOND)']
 object Base
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
index e42eace474..2446a1c702 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -83,6 +83,8 @@ Examples:
 @b{Values:}
 @table @asis
 @item @code{one}
+@b{If:} @code{defined(IFENUM)}
+
 The @emph{one} @{and only@}
 @item @code{two}
 Not documented
--=20
2.16.2.521.g9aa15f885a

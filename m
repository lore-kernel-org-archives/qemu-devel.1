Received: from eggs.gnu.org ([2001:4830:134:3::10]:48891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJJ-0006FZ-UA
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJJ-0008Pu-3b
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42102 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycJI-0008Pf-W3
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F4A8407519B
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:53:40 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:55 +0100
Message-Id: <20180321115211.17937-34-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 33/49] qapi2texi: add 'If:' condition to
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/doc.py             | 4 +++-
 tests/qapi-schema/doc-good.json | 3 ++-
 tests/qapi-schema/doc-good.out  | 1 +
 tests/qapi-schema/doc-good.texi | 2 ++
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index f629425f53..42e34e1fe3 100755
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
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
index d27d345de2..9976d29eb0 100644
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
index 2446a1c702..255eed9a30 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -120,6 +120,8 @@ Another paragraph (but no @code{var}: line)
 @b{Members:}
 @table @asis
 @item @code{var1: string}
+@b{If:} @code{defined(IFSTR)}
+
 Not documented
 @end table
=20
--=20
2.16.2.521.g9aa15f885a

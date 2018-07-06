Received: from eggs.gnu.org ([2001:4830:134:3::10]:58617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORk-0000DV-0A
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORi-00010g-LZ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbORi-0000y0-FN
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 03BBE40122D9
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 10:58:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 12:57:50 +0200
Message-Id: <20180706105753.26700-25-marcandre.lureau@redhat.com>
In-Reply-To: <20180706105753.26700-1-marcandre.lureau@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 24/27] qapi: add 'If:' condition to struct
 members documentation
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/doc.py             | 4 +++-
 tests/qapi-schema/doc-good.json | 3 ++-
 tests/qapi-schema/doc-good.out  | 1 +
 tests/qapi-schema/doc-good.texi | 2 ++
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 196deea11d..56dc98c068 100755
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
2.18.0.rc1

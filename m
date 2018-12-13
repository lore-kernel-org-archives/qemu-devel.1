Received: from eggs.gnu.org ([2001:4830:134:3::10]:53376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVy6-00061m-7V
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxv-0002yG-DI
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXVxr-0001hv-LY
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:05 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3C3B30833A4
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 18:43:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Dec 2018 19:43:37 +0100
Message-Id: <20181213184340.24037-30-armbru@redhat.com>
In-Reply-To: <20181213184340.24037-1-armbru@redhat.com>
References: <20181213184340.24037-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 29/32] qapi: add 'If:' condition to struct
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181213123724.4866-20-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/doc.py             | 4 ++--
 tests/qapi-schema/doc-good.json | 3 ++-
 tests/qapi-schema/doc-good.out  | 1 +
 tests/qapi-schema/doc-good.texi | 1 +
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index ab36b9dec6..b6f834b917 100755
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -143,10 +143,10 @@ def texi_member(member, desc, suffix):
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
index 1cd4935710..28992fc615 100644
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
index 53bd177f7d..4ab55683ce 100644
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
index 405055b146..f87f9faacb 100644
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
2.17.2

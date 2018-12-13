Received: from eggs.gnu.org ([2001:4830:134:3::10]:53194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxo-0005hZ-Gt
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxk-0002Bz-6P
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:43:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXVxj-0001iW-Hd
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:43:55 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40AF3300238C
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 18:43:50 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Dec 2018 19:43:36 +0100
Message-Id: <20181213184340.24037-29-armbru@redhat.com>
In-Reply-To: <20181213184340.24037-1-armbru@redhat.com>
References: <20181213184340.24037-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 28/32] qapi: add 'If:' condition to enum values
 documentation
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

Use a common function to generate the "If:..." line.

While at it, get rid of the existing \n\n (no idea why it was
there). Use a line-break in member description, this seems to look
slightly better in the plaintext version.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181213123724.4866-19-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/doc.py             | 25 ++++++++++++++++---------
 tests/qapi-schema/doc-good.json |  4 +++-
 tests/qapi-schema/doc-good.out  |  1 +
 tests/qapi-schema/doc-good.texi |  2 +-
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 76cb186ff9..ab36b9dec6 100755
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -126,19 +126,27 @@ def texi_body(doc):
     return texi_format(doc.body.text)
=20
=20
-def texi_enum_value(value):
+def texi_if(ifcond, prefix=3D'\n', suffix=3D'\n'):
+    """Format the #if condition"""
+    if not ifcond:
+        return ''
+    return '%s@b{If:} @code{%s}%s' % (prefix, ', '.join(ifcond), suffix)
+
+
+def texi_enum_value(value, desc, suffix):
     """Format a table of members item for an enumeration value"""
-    return '@item @code{%s}\n' % value.name
+    return '@item @code{%s}\n%s%s' % (
+        value.name, desc, texi_if(value.ifcond, prefix=3D'@*'))
=20
=20
-def texi_member(member, suffix=3D''):
+def texi_member(member, desc, suffix):
     """Format a table of members item for an object type member"""
     typ =3D member.type.doc_type()
     membertype =3D ': ' + typ if typ else ''
-    return '@item @code{%s%s}%s%s\n' % (
+    return '@item @code{%s%s}%s%s\n%s' % (
         member.name, membertype,
         ' (optional)' if member.optional else '',
-        suffix)
+        suffix, desc)
=20
=20
 def texi_members(doc, what, base, variants, member_func):
@@ -155,7 +163,7 @@ def texi_members(doc, what, base, variants, member_fu=
nc):
             desc =3D 'One of ' + members_text + '\n'
         else:
             desc =3D 'Not documented\n'
-        items +=3D member_func(section.member) + desc
+        items +=3D member_func(section.member, desc, suffix=3D'')
     if base:
         items +=3D '@item The members of @code{%s}\n' % base.doc_type()
     if variants:
@@ -165,7 +173,7 @@ def texi_members(doc, what, base, variants, member_fu=
nc):
             if v.type.is_implicit():
                 assert not v.type.base and not v.type.variants
                 for m in v.type.local_members:
-                    items +=3D member_func(m, when)
+                    items +=3D member_func(m, desc=3D'', suffix=3Dwhen)
             else:
                 items +=3D '@item The members of @code{%s}%s\n' % (
                     v.type.doc_type(), when)
@@ -185,8 +193,7 @@ def texi_sections(doc, ifcond):
             body +=3D texi_example(section.text)
         else:
             body +=3D texi_format(section.text)
-    if ifcond:
-        body +=3D '\n\n@b{If:} @code{%s}' % ", ".join(ifcond)
+    body +=3D texi_if(ifcond, suffix=3D'')
     return body
=20
=20
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good=
.json
index 984cd8ed06..1cd4935710 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -55,7 +55,9 @@
 #
 # @two is undocumented
 ##
-{ 'enum': 'Enum', 'data': [ 'one', 'two' ], 'if': 'defined(IFCOND)' }
+{ 'enum': 'Enum', 'data':
+  [ { 'name': 'one', 'if': 'defined(IFONE)' }, 'two' ],
+  'if': 'defined(IFCOND)' }
=20
 ##
 # @Base:
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
index c2fc5c774a..53bd177f7d 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -11,6 +11,7 @@ enum QType
 module doc-good.json
 enum Enum
     member one
+        if ['defined(IFONE)']
     member two
     if ['defined(IFCOND)']
 object Base
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
index e42eace474..405055b146 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -84,12 +84,12 @@ Examples:
 @table @asis
 @item @code{one}
 The @emph{one} @{and only@}
+@*@b{If:} @code{defined(IFONE)}
 @item @code{two}
 Not documented
 @end table
 @code{two} is undocumented
=20
-
 @b{If:} @code{defined(IFCOND)}
 @end deftp
=20
--=20
2.17.2

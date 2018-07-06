Received: from eggs.gnu.org ([2001:4830:134:3::10]:58627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORl-0000Ea-4u
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORk-00017F-2q
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53640 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbORj-00016C-TS
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AD1B401DEAB
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 10:58:39 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 12:57:51 +0200
Message-Id: <20180706105753.26700-26-marcandre.lureau@redhat.com>
In-Reply-To: <20180706105753.26700-1-marcandre.lureau@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 25/27] qapi: add condition to variants
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
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/doc.py             | 5 +++--
 tests/qapi-schema/doc-good.json | 4 ++--
 tests/qapi-schema/doc-good.out  | 3 +++
 tests/qapi-schema/doc-good.texi | 4 ++--
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 56dc98c068..e9dfdc7d23 100755
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -165,8 +165,9 @@ def texi_members(doc, what, base, variants, member_fu=
nc):
         items +=3D '@item The members of @code{%s}\n' % base.doc_type()
     if variants:
         for v in variants.variants:
-            when =3D ' when @code{%s} is @t{"%s"}' % (
-                variants.tag_member.name, v.name)
+            when =3D ' when @code{%s} is @t{"%s"}%s' % (
+                variants.tag_member.name, v.name,
+                ' (@b{If:} @code{%s})' % v.ifcond if v.ifcond else '')
             if v.type.is_implicit():
                 assert not v.type.base and not v.type.variants
                 for m in v.type.local_members:
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good=
.json
index 158443b1a3..afe46d93f0 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -86,13 +86,13 @@
 { 'union': 'Object',
   'base': 'Base',
   'discriminator': 'base1',
-  'data': { 'one': 'Variant1', 'two': 'Variant2' } }
+  'data': { 'one': 'Variant1', 'two': { 'type': 'Variant2', 'if': 'IFTWO=
' } } }
=20
 ##
 # @SugaredUnion:
 ##
 { 'union': 'SugaredUnion',
-  'data': { 'one': 'Variant1', 'two': 'Variant2' } }
+  'data': { 'one': 'Variant1', 'two': { 'type': 'Variant2', 'if': 'IFTWO=
' } } }
=20
 ##
 # =3D=3D Another subsection
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
index c310b47be2..ed647b82be 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -25,6 +25,7 @@ object Object
     tag base1
     case one: Variant1
     case two: Variant2
+        if ['IFTWO']
 object q_obj_Variant1-wrapper
     member data: Variant1 optional=3DFalse
 object q_obj_Variant2-wrapper
@@ -32,11 +33,13 @@ object q_obj_Variant2-wrapper
 enum SugaredUnionKind
     member one
     member two
+        if ['IFTWO']
 object SugaredUnion
     member type: SugaredUnionKind optional=3DFalse
     tag type
     case one: q_obj_Variant1-wrapper
     case two: q_obj_Variant2-wrapper
+        if ['IFTWO']
 object q_obj_cmd-arg
     member arg1: int optional=3DFalse
     member arg2: str optional=3DTrue
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
index 255eed9a30..6e226a6231 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -145,7 +145,7 @@ Not documented
 @table @asis
 @item The members of @code{Base}
 @item The members of @code{Variant1} when @code{base1} is @t{"one"}
-@item The members of @code{Variant2} when @code{base1} is @t{"two"}
+@item The members of @code{Variant2} when @code{base1} is @t{"two"} (@b{=
If:} @code{['IFTWO']})
 @end table
=20
 @end deftp
@@ -161,7 +161,7 @@ Not documented
 @item @code{type}
 One of @t{"one"}, @t{"two"}
 @item @code{data: Variant1} when @code{type} is @t{"one"}
-@item @code{data: Variant2} when @code{type} is @t{"two"}
+@item @code{data: Variant2} when @code{type} is @t{"two"} (@b{If:} @code=
{['IFTWO']})
 @end table
=20
 @end deftp
--=20
2.18.0.rc1

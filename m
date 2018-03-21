Received: from eggs.gnu.org ([2001:4830:134:3::10]:48925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJQ-0006UE-Sy
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJN-0008SE-MT
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51870 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycJN-0008Rx-HW
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D357C40267D7
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:53:44 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:56 +0100
Message-Id: <20180321115211.17937-35-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 34/49] qapi2texi: add condition to variants
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
 scripts/qapi/doc.py             | 5 +++--
 tests/qapi-schema/doc-good.json | 4 ++--
 tests/qapi-schema/doc-good.out  | 3 +++
 tests/qapi-schema/doc-good.texi | 4 ++--
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 42e34e1fe3..40dcedc6ed 100755
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
index 9976d29eb0..4b36cf6f7d 100644
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
2.16.2.521.g9aa15f885a

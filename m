Received: from eggs.gnu.org ([2001:4830:134:3::10]:53274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxr-0005lE-OP
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxo-0002Sc-HH
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXVxm-0001iD-QL
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:43:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F9DE88E4F
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 18:43:50 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Dec 2018 19:43:38 +0100
Message-Id: <20181213184340.24037-31-armbru@redhat.com>
In-Reply-To: <20181213184340.24037-1-armbru@redhat.com>
References: <20181213184340.24037-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 30/32] qapi: add condition to variants
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181213123724.4866-21-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/doc.py             | 4 ++--
 tests/qapi-schema/doc-good.json | 4 ++--
 tests/qapi-schema/doc-good.out  | 3 +++
 tests/qapi-schema/doc-good.texi | 4 ++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index b6f834b917..c03b690161 100755
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -168,8 +168,8 @@ def texi_members(doc, what, base, variants, member_fu=
nc):
         items +=3D '@item The members of @code{%s}\n' % base.doc_type()
     if variants:
         for v in variants.variants:
-            when =3D ' when @code{%s} is @t{"%s"}' % (
-                variants.tag_member.name, v.name)
+            when =3D ' when @code{%s} is @t{"%s"}%s' % (
+                variants.tag_member.name, v.name, texi_if(v.ifcond, " ("=
, ")"))
             if v.type.is_implicit():
                 assert not v.type.base and not v.type.variants
                 for m in v.type.local_members:
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good=
.json
index 28992fc615..f7fb48af38 100644
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
index 4ab55683ce..21bf345ff0 100644
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
index f87f9faacb..2526abc6d9 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -142,7 +142,7 @@ Not documented
 @table @asis
 @item The members of @code{Base}
 @item The members of @code{Variant1} when @code{base1} is @t{"one"}
-@item The members of @code{Variant2} when @code{base1} is @t{"two"}
+@item The members of @code{Variant2} when @code{base1} is @t{"two"} (@b{=
If:} @code{IFTWO})
 @end table
=20
 @end deftp
@@ -158,7 +158,7 @@ Not documented
 @item @code{type}
 One of @t{"one"}, @t{"two"}
 @item @code{data: Variant1} when @code{type} is @t{"one"}
-@item @code{data: Variant2} when @code{type} is @t{"two"}
+@item @code{data: Variant2} when @code{type} is @t{"two"} (@b{If:} @code=
{IFTWO})
 @end table
=20
 @end deftp
--=20
2.17.2

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVadU-0006LV-1E
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVadS-0004wa-Eo
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:19:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gVadS-0004wS-72
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:19:02 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat,  8 Dec 2018 15:16:03 +0400
Message-Id: <20181208111606.8505-25-marcandre.lureau@redhat.com>
In-Reply-To: <20181208111606.8505-1-marcandre.lureau@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v7 24/27] qapi: add condition to
 variants documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/doc.py             | 4 ++--
 tests/qapi-schema/doc-good.json | 4 ++--
 tests/qapi-schema/doc-good.out  | 3 +++
 tests/qapi-schema/doc-good.texi | 4 ++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index e0cf94421c..4008054eea 100755
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -167,8 +167,8 @@ def texi_members(doc, what, base, variants, member_fu=
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
index 0f8d69a378..df08a89521 100644
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
2.20.0.rc1

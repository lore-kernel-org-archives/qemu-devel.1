Received: from eggs.gnu.org ([2001:4830:134:3::10]:51673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkWh-0007mO-DT
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkWf-0005Dh-QF
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkWf-0005CE-HI
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:41 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:35 +0100
Message-Id: <20180111213250.16511-37-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 36/51] qapi2texi: add condition to variants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi2texi.py            | 5 +++--
 tests/qapi-schema/doc-good.json | 4 ++--
 tests/qapi-schema/doc-good.out  | 3 +++
 tests/qapi-schema/doc-good.texi | 4 ++--
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index d760596ce0..d8a0379c52 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
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
index 972b58c815..9a9d745f8e 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -10,6 +10,7 @@ object Object
     tag base1
     case one: Variant1
     case two: Variant2
+        if ['IFTWO']
 enum QType
     prefix QTYPE
     member none
@@ -24,9 +25,11 @@ object SugaredUnion
     tag type
     case one: q_obj_Variant1-wrapper
     case two: q_obj_Variant2-wrapper
+        if ['IFTWO']
 enum SugaredUnionKind
     member one
     member two
+        if ['IFTWO']
 object Variant1
     member var1: str optional=3DFalse
         if ['defined(IFSTR)']
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
index f2a902a06b..3d513a89b7 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -143,7 +143,7 @@ Not documented
 @table @asis
 @item The members of @code{Base}
 @item The members of @code{Variant1} when @code{base1} is @t{"one"}
-@item The members of @code{Variant2} when @code{base1} is @t{"two"}
+@item The members of @code{Variant2} when @code{base1} is @t{"two"} (@b{=
If:} @code{['IFTWO']})
 @end table
=20
 @end deftp
@@ -159,7 +159,7 @@ Not documented
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
2.16.0.rc1.1.gef27df75a1

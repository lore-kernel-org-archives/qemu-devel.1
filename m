Received: from eggs.gnu.org ([2001:4830:134:3::10]:55728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaY-0002An-9z
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaT-000639-2w
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRjaS-00061e-Mj
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ADB6E13AA3
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-74.ams2.redhat.com
	[10.36.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 54CD75278F
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Dec 2017 19:59:20 +0100
Message-Id: <20171220185924.32756-10-armbru@redhat.com>
In-Reply-To: <20171220185924.32756-1-armbru@redhat.com>
References: <20171220185924.32756-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/13] qapi2texi: Simplify representation of
 section text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Use a string instead of a list of strings.  While there, generate
fewer superfluous blank lines.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20171002141341.24616-10-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi2texi.py            | 33 ++++++++++++++++-----------------
 tests/qapi-schema/doc-good.texi | 10 ----------
 2 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 379d27643d..58add26c11 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -13,7 +13,6 @@ MSG_FMT =3D """
 @deftypefn {type} {{}} {name}
=20
 {body}
-
 @end deftypefn
=20
 """.format
@@ -22,7 +21,6 @@ TYPE_FMT =3D """
 @deftp {{{type}}} {name}
=20
 {body}
-
 @end deftp
=20
 """.format
@@ -74,7 +72,7 @@ def texi_format(doc):
     - 1. or 1): generates an @enumerate @item
     - */-: generates an @itemize list
     """
-    lines =3D []
+    ret =3D ''
     doc =3D subst_braces(doc)
     doc =3D subst_vars(doc)
     doc =3D subst_emph(doc)
@@ -100,32 +98,32 @@ def texi_format(doc):
             line =3D '@subsection ' + line[3:]
         elif re.match(r'^([0-9]*\.) ', line):
             if not inlist:
-                lines.append('@enumerate')
+                ret +=3D '@enumerate\n'
                 inlist =3D 'enumerate'
+            ret +=3D '@item\n'
             line =3D line[line.find(' ')+1:]
-            lines.append('@item')
         elif re.match(r'^[*-] ', line):
             if not inlist:
-                lines.append('@itemize %s' % {'*': '@bullet',
-                                              '-': '@minus'}[line[0]])
+                ret +=3D '@itemize %s\n' % {'*': '@bullet',
+                                          '-': '@minus'}[line[0]]
                 inlist =3D 'itemize'
-            lines.append('@item')
+            ret +=3D '@item\n'
             line =3D line[2:]
         elif lastempty and inlist:
-            lines.append('@end %s\n' % inlist)
+            ret +=3D '@end %s\n\n' % inlist
             inlist =3D ''
=20
         lastempty =3D empty
-        lines.append(line)
+        ret +=3D line + '\n'
=20
     if inlist:
-        lines.append('@end %s\n' % inlist)
-    return '\n'.join(lines)
+        ret +=3D '@end %s\n\n' % inlist
+    return ret
=20
=20
 def texi_body(doc):
     """Format the main documentation body"""
-    return texi_format(doc.body.text) + '\n'
+    return texi_format(doc.body.text)
=20
=20
 def texi_enum_value(value):
@@ -154,10 +152,11 @@ def texi_members(doc, what, base, variants, member_=
func):
         elif (variants and variants.tag_member =3D=3D section.member
               and not section.member.type.doc_type()):
             values =3D section.member.type.member_names()
-            desc =3D 'One of ' + ', '.join(['@t{"%s"}' % v for v in valu=
es])
+            members_text =3D ', '.join(['@t{"%s"}' % v for v in values])
+            desc =3D 'One of ' + members_text + '\n'
         else:
-            desc =3D 'Not documented'
-        items +=3D member_func(section.member) + desc + '\n'
+            desc =3D 'Not documented\n'
+        items +=3D member_func(section.member) + desc
     if base:
         items +=3D '@item The members of @code{%s}\n' % base.doc_type()
     if variants:
@@ -182,7 +181,7 @@ def texi_sections(doc):
     for section in doc.sections:
         if section.name:
             # prefer @b over @strong, so txt doesn't translate it to *Fo=
o:*
-            body +=3D '\n\n@b{%s:}\n' % section.name
+            body +=3D '\n@b{%s:}\n' % section.name
         if section.name and section.name.startswith('Example'):
             body +=3D texi_example(section.text)
         else:
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
index c032f23fc1..1778312581 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -101,7 +101,6 @@ Not documented
 the first member
 @end table
=20
-
 @end deftp
=20
=20
@@ -118,7 +117,6 @@ Another paragraph (but no @code{var}: line)
 Not documented
 @end table
=20
-
 @end deftp
=20
=20
@@ -127,7 +125,6 @@ Not documented
=20
=20
=20
-
 @end deftp
=20
=20
@@ -143,7 +140,6 @@ Not documented
 @item The members of @code{Variant2} when @code{base1} is @t{"two"}
 @end table
=20
-
 @end deftp
=20
=20
@@ -160,7 +156,6 @@ One of @t{"one"}, @t{"two"}
 @item @code{data: Variant2} when @code{type} is @t{"two"}
 @end table
=20
-
 @end deftp
=20
=20
@@ -182,7 +177,6 @@ argument
 Not documented
 @end table
=20
-
 @b{Note:}
 @code{arg3} is undocumented
=20
@@ -209,14 +203,12 @@ Duis aute irure dolor
 <- out
 @end example
=20
-
 @b{Examples:}
 @example
 - *verbatim*
 - @{braces@}
 @end example
=20
-
 @b{Since:}
 2.10
=20
@@ -230,7 +222,6 @@ If you're bored enough to read this, go see a video o=
f boxed cats
=20
 @b{Arguments:} the members of @code{Object}
=20
-
 @b{Example:}
 @example
 -> in
@@ -238,7 +229,6 @@ If you're bored enough to read this, go see a video o=
f boxed cats
 <- out
 @end example
=20
-
 @end deftypefn
=20
=20
--=20
2.13.6

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Tq-00077t-2L
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Tj-0003eU-L0
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz1Tj-0003e2-CO
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 822BF356DB
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:13:50 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:13:39 +0200
Message-Id: <20171002141341.24616-10-armbru@redhat.com>
In-Reply-To: <20171002141341.24616-1-armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 09/11] qapi2texi: Simplify representation of
 section text
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
List-ID: <qemu-devel.nongnu.org>

Use a string instead of a list of strings.  While there, generate
fewer superfluous blank lines.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi2texi.py            | 33 ++++++++++++++++-----------------
 tests/qapi-schema/doc-good.texi | 10 ----------
 2 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 379d27643d..58add26c11 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -13,7 +13,6 @@ MSG_FMT = """
 @deftypefn {type} {{}} {name}
 
 {body}
-
 @end deftypefn
 
 """.format
@@ -22,7 +21,6 @@ TYPE_FMT = """
 @deftp {{{type}}} {name}
 
 {body}
-
 @end deftp
 
 """.format
@@ -74,7 +72,7 @@ def texi_format(doc):
     - 1. or 1): generates an @enumerate @item
     - */-: generates an @itemize list
     """
-    lines = []
+    ret = ''
     doc = subst_braces(doc)
     doc = subst_vars(doc)
     doc = subst_emph(doc)
@@ -100,32 +98,32 @@ def texi_format(doc):
             line = '@subsection ' + line[3:]
         elif re.match(r'^([0-9]*\.) ', line):
             if not inlist:
-                lines.append('@enumerate')
+                ret += '@enumerate\n'
                 inlist = 'enumerate'
+            ret += '@item\n'
             line = line[line.find(' ')+1:]
-            lines.append('@item')
         elif re.match(r'^[*-] ', line):
             if not inlist:
-                lines.append('@itemize %s' % {'*': '@bullet',
-                                              '-': '@minus'}[line[0]])
+                ret += '@itemize %s\n' % {'*': '@bullet',
+                                          '-': '@minus'}[line[0]]
                 inlist = 'itemize'
-            lines.append('@item')
+            ret += '@item\n'
             line = line[2:]
         elif lastempty and inlist:
-            lines.append('@end %s\n' % inlist)
+            ret += '@end %s\n\n' % inlist
             inlist = ''
 
         lastempty = empty
-        lines.append(line)
+        ret += line + '\n'
 
     if inlist:
-        lines.append('@end %s\n' % inlist)
-    return '\n'.join(lines)
+        ret += '@end %s\n\n' % inlist
+    return ret
 
 
 def texi_body(doc):
     """Format the main documentation body"""
-    return texi_format(doc.body.text) + '\n'
+    return texi_format(doc.body.text)
 
 
 def texi_enum_value(value):
@@ -154,10 +152,11 @@ def texi_members(doc, what, base, variants, member_func):
         elif (variants and variants.tag_member == section.member
               and not section.member.type.doc_type()):
             values = section.member.type.member_names()
-            desc = 'One of ' + ', '.join(['@t{"%s"}' % v for v in values])
+            members_text = ', '.join(['@t{"%s"}' % v for v in values])
+            desc = 'One of ' + members_text + '\n'
         else:
-            desc = 'Not documented'
-        items += member_func(section.member) + desc + '\n'
+            desc = 'Not documented\n'
+        items += member_func(section.member) + desc
     if base:
         items += '@item The members of @code{%s}\n' % base.doc_type()
     if variants:
@@ -182,7 +181,7 @@ def texi_sections(doc):
     for section in doc.sections:
         if section.name:
             # prefer @b over @strong, so txt doesn't translate it to *Foo:*
-            body += '\n\n@b{%s:}\n' % section.name
+            body += '\n@b{%s:}\n' % section.name
         if section.name and section.name.startswith('Example'):
             body += texi_example(section.text)
         else:
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
index c032f23fc1..1778312581 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -101,7 +101,6 @@ Not documented
 the first member
 @end table
 
-
 @end deftp
 
 
@@ -118,7 +117,6 @@ Another paragraph (but no @code{var}: line)
 Not documented
 @end table
 
-
 @end deftp
 
 
@@ -127,7 +125,6 @@ Not documented
 
 
 
-
 @end deftp
 
 
@@ -143,7 +140,6 @@ Not documented
 @item The members of @code{Variant2} when @code{base1} is @t{"two"}
 @end table
 
-
 @end deftp
 
 
@@ -160,7 +156,6 @@ One of @t{"one"}, @t{"two"}
 @item @code{data: Variant2} when @code{type} is @t{"two"}
 @end table
 
-
 @end deftp
 
 
@@ -182,7 +177,6 @@ argument
 Not documented
 @end table
 
-
 @b{Note:}
 @code{arg3} is undocumented
 
@@ -209,14 +203,12 @@ Duis aute irure dolor
 <- out
 @end example
 
-
 @b{Examples:}
 @example
 - *verbatim*
 - @{braces@}
 @end example
 
-
 @b{Since:}
 2.10
 
@@ -230,7 +222,6 @@ If you're bored enough to read this, go see a video of boxed cats
 
 @b{Arguments:} the members of @code{Object}
 
-
 @b{Example:}
 @example
 -> in
@@ -238,7 +229,6 @@ If you're bored enough to read this, go see a video of boxed cats
 <- out
 @end example
 
-
 @end deftypefn
 
 
-- 
2.13.6

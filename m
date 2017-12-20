Received: from eggs.gnu.org ([2001:4830:134:3::10]:55758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaY-0002BM-SW
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaT-00063D-46
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRjaS-00061V-OY
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7F0B624DF
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-74.ams2.redhat.com
	[10.36.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 510875B816
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Dec 2017 19:59:19 +0100
Message-Id: <20171220185924.32756-9-armbru@redhat.com>
In-Reply-To: <20171220185924.32756-1-armbru@redhat.com>
References: <20171220185924.32756-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/13] qapi: Simplify representation of QAPIDoc
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

Use a string instead of a list of strings.

This makes qapi2texi.py generate additional blank lines.  They're
harmless, and the next commit will get rid of them again.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20171002141341.24616-9-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                 | 16 ++++++----------
 scripts/qapi2texi.py            | 14 +++++++-------
 tests/qapi-schema/doc-good.texi |  1 +
 tests/qapi-schema/test-qapi.py  |  6 +++---
 4 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 2137067b48..e338868a52 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -106,13 +106,10 @@ class QAPIDoc(object):
             # optional section name (argument/member or section name)
             self.name =3D name
             # the list of lines for this section
-            self.content =3D []
+            self.text =3D ''
=20
         def append(self, line):
-            self.content.append(line)
-
-        def __repr__(self):
-            return '\n'.join(self.content).strip()
+            self.text +=3D line.rstrip() + '\n'
=20
     class ArgSection(Section):
         def __init__(self, name):
@@ -160,7 +157,7 @@ class QAPIDoc(object):
         # recognized, and get silently treated as ordinary text
         if self.symbol:
             self._append_symbol_line(line)
-        elif not self.body.content and line.startswith('@'):
+        elif not self.body.text and line.startswith('@'):
             if not line.endswith(':'):
                 raise QAPIParseError(self.parser, "Line should end with =
:")
             self.symbol =3D line[1:-1]
@@ -214,16 +211,15 @@ class QAPIDoc(object):
=20
     def _end_section(self):
         if self.section:
-            contents =3D str(self.section)
-            if self.section.name and (not contents or contents.isspace()=
):
+            text =3D self.section.text =3D self.section.text.strip()
+            if self.section.name and (not text or text.isspace()):
                 raise QAPIParseError(self.parser, "Empty doc section '%s=
'"
                                      % self.section.name)
             self.section =3D None
=20
     def _append_freeform(self, line):
         in_arg =3D isinstance(self.section, QAPIDoc.ArgSection)
-        if (in_arg and self.section.content
-                and not self.section.content[-1]
+        if (in_arg and self.section.text.endswith('\n\n')
                 and line and not line[0].isspace()):
             self._start_section()
         if (in_arg or not self.section.name
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index f16fa1ba53..379d27643d 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -125,7 +125,7 @@ def texi_format(doc):
=20
 def texi_body(doc):
     """Format the main documentation body"""
-    return texi_format(str(doc.body)) + '\n'
+    return texi_format(doc.body.text) + '\n'
=20
=20
 def texi_enum_value(value):
@@ -149,8 +149,8 @@ def texi_members(doc, what, base, variants, member_fu=
nc):
     items =3D ''
     for section in doc.args.itervalues():
         # TODO Drop fallbacks when undocumented members are outlawed
-        if section.content:
-            desc =3D texi_format(str(section))
+        if section.text:
+            desc =3D texi_format(section.text)
         elif (variants and variants.tag_member =3D=3D section.member
               and not section.member.type.doc_type()):
             values =3D section.member.type.member_names()
@@ -183,11 +183,10 @@ def texi_sections(doc):
         if section.name:
             # prefer @b over @strong, so txt doesn't translate it to *Fo=
o:*
             body +=3D '\n\n@b{%s:}\n' % section.name
-        text =3D str(section)
         if section.name and section.name.startswith('Example'):
-            body +=3D texi_example(text)
+            body +=3D texi_example(section.text)
         else:
-            body +=3D texi_format(text)
+            body +=3D texi_format(section.text)
     return body
=20
=20
@@ -240,7 +239,8 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor)=
:
             self.out +=3D '\n'
         if boxed:
             body =3D texi_body(doc)
-            body +=3D '\n@b{Arguments:} the members of @code{%s}' % arg_=
type.name
+            body +=3D ('\n@b{Arguments:} the members of @code{%s}\n'
+                     % arg_type.name)
             body +=3D texi_sections(doc)
         else:
             body =3D texi_entity(doc, 'Arguments')
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
index a331349756..c032f23fc1 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -230,6 +230,7 @@ If you're bored enough to read this, go see a video o=
f boxed cats
=20
 @b{Arguments:} the members of @code{Object}
=20
+
 @b{Example:}
 @example
 -> in
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index c7724d3437..fe0ca08d78 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -61,8 +61,8 @@ for doc in schema.docs:
         print 'doc symbol=3D%s' % doc.symbol
     else:
         print 'doc freeform'
-    print '    body=3D\n%s' % doc.body
+    print '    body=3D\n%s' % doc.body.text
     for arg, section in doc.args.iteritems():
-        print '    arg=3D%s\n%s' % (arg, section)
+        print '    arg=3D%s\n%s' % (arg, section.text)
     for section in doc.sections:
-        print '    section=3D%s\n%s' % (section.name, section)
+        print '    section=3D%s\n%s' % (section.name, section.text)
--=20
2.13.6

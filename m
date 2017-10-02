Received: from eggs.gnu.org ([2001:4830:134:3::10]:44125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Tn-00075I-Lz
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Th-0003cw-Di
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz1Th-0003cO-4J
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42FD8356C9
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:13:48 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:13:38 +0200
Message-Id: <20171002141341.24616-9-armbru@redhat.com>
In-Reply-To: <20171002141341.24616-1-armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 08/11] qapi: Simplify representation of QAPIDoc
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

Use a string instead of a list of strings.

This makes qapi2texi.py generate additional blank lines.  They're
harmless, and the next commit will get rid of them again.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
             self.name = name
             # the list of lines for this section
-            self.content = []
+            self.text = ''
 
         def append(self, line):
-            self.content.append(line)
-
-        def __repr__(self):
-            return '\n'.join(self.content).strip()
+            self.text += line.rstrip() + '\n'
 
     class ArgSection(Section):
         def __init__(self, name):
@@ -160,7 +157,7 @@ class QAPIDoc(object):
         # recognized, and get silently treated as ordinary text
         if self.symbol:
             self._append_symbol_line(line)
-        elif not self.body.content and line.startswith('@'):
+        elif not self.body.text and line.startswith('@'):
             if not line.endswith(':'):
                 raise QAPIParseError(self.parser, "Line should end with :")
             self.symbol = line[1:-1]
@@ -214,16 +211,15 @@ class QAPIDoc(object):
 
     def _end_section(self):
         if self.section:
-            contents = str(self.section)
-            if self.section.name and (not contents or contents.isspace()):
+            text = self.section.text = self.section.text.strip()
+            if self.section.name and (not text or text.isspace()):
                 raise QAPIParseError(self.parser, "Empty doc section '%s'"
                                      % self.section.name)
             self.section = None
 
     def _append_freeform(self, line):
         in_arg = isinstance(self.section, QAPIDoc.ArgSection)
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
 
 def texi_body(doc):
     """Format the main documentation body"""
-    return texi_format(str(doc.body)) + '\n'
+    return texi_format(doc.body.text) + '\n'
 
 
 def texi_enum_value(value):
@@ -149,8 +149,8 @@ def texi_members(doc, what, base, variants, member_func):
     items = ''
     for section in doc.args.itervalues():
         # TODO Drop fallbacks when undocumented members are outlawed
-        if section.content:
-            desc = texi_format(str(section))
+        if section.text:
+            desc = texi_format(section.text)
         elif (variants and variants.tag_member == section.member
               and not section.member.type.doc_type()):
             values = section.member.type.member_names()
@@ -183,11 +183,10 @@ def texi_sections(doc):
         if section.name:
             # prefer @b over @strong, so txt doesn't translate it to *Foo:*
             body += '\n\n@b{%s:}\n' % section.name
-        text = str(section)
         if section.name and section.name.startswith('Example'):
-            body += texi_example(text)
+            body += texi_example(section.text)
         else:
-            body += texi_format(text)
+            body += texi_format(section.text)
     return body
 
 
@@ -240,7 +239,8 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
             self.out += '\n'
         if boxed:
             body = texi_body(doc)
-            body += '\n@b{Arguments:} the members of @code{%s}' % arg_type.name
+            body += ('\n@b{Arguments:} the members of @code{%s}\n'
+                     % arg_type.name)
             body += texi_sections(doc)
         else:
             body = texi_entity(doc, 'Arguments')
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
index a331349756..c032f23fc1 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -230,6 +230,7 @@ If you're bored enough to read this, go see a video of boxed cats
 
 @b{Arguments:} the members of @code{Object}
 
+
 @b{Example:}
 @example
 -> in
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index c7724d3437..fe0ca08d78 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -61,8 +61,8 @@ for doc in schema.docs:
         print 'doc symbol=%s' % doc.symbol
     else:
         print 'doc freeform'
-    print '    body=\n%s' % doc.body
+    print '    body=\n%s' % doc.body.text
     for arg, section in doc.args.iteritems():
-        print '    arg=%s\n%s' % (arg, section)
+        print '    arg=%s\n%s' % (arg, section.text)
     for section in doc.sections:
-        print '    section=%s\n%s' % (section.name, section)
+        print '    section=%s\n%s' % (section.name, section.text)
-- 
2.13.6

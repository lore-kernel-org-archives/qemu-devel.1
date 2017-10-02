Received: from eggs.gnu.org ([2001:4830:134:3::10]:44079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Ti-0006yU-L9
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Th-0003cl-3H
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz1Tg-0003c5-QJ
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0153883C1
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:13:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:13:40 +0200
Message-Id: <20171002141341.24616-11-armbru@redhat.com>
In-Reply-To: <20171002141341.24616-1-armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 10/11] qapi: Rename QAPIDoc.parser,
 .section to ._parser, ._section
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index e338868a52..43a54bf40f 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -120,11 +120,11 @@ class QAPIDoc(object):
             self.member = member
 
     def __init__(self, parser, info):
-        # self.parser is used to report errors with QAPIParseError.  The
+        # self._parser is used to report errors with QAPIParseError.  The
         # resulting error position depends on the state of the parser.
         # It happens to be the beginning of the comment.  More or less
         # servicable, but action at a distance.
-        self.parser = parser
+        self._parser = parser
         self.info = info
         self.symbol = None
         self.body = QAPIDoc.Section()
@@ -133,7 +133,7 @@ class QAPIDoc(object):
         # a list of Section
         self.sections = []
         # the current section
-        self.section = self.body
+        self._section = self.body
 
     def has_section(self, name):
         """Return True if we have a section with this name."""
@@ -150,7 +150,7 @@ class QAPIDoc(object):
             return
 
         if line[0] != ' ':
-            raise QAPIParseError(self.parser, "Missing space after #")
+            raise QAPIParseError(self._parser, "Missing space after #")
         line = line[1:]
 
         # FIXME not nice: things like '#  @foo:' and '# @foo: ' aren't
@@ -159,11 +159,11 @@ class QAPIDoc(object):
             self._append_symbol_line(line)
         elif not self.body.text and line.startswith('@'):
             if not line.endswith(':'):
-                raise QAPIParseError(self.parser, "Line should end with :")
+                raise QAPIParseError(self._parser, "Line should end with :")
             self.symbol = line[1:-1]
             # FIXME invalid names other than the empty string aren't flagged
             if not self.symbol:
-                raise QAPIParseError(self.parser, "Invalid name")
+                raise QAPIParseError(self._parser, "Invalid name")
         else:
             self._append_freeform(line)
 
@@ -189,48 +189,48 @@ class QAPIDoc(object):
     def _start_args_section(self, name):
         # FIXME invalid names other than the empty string aren't flagged
         if not name:
-            raise QAPIParseError(self.parser, "Invalid parameter name")
+            raise QAPIParseError(self._parser, "Invalid parameter name")
         if name in self.args:
-            raise QAPIParseError(self.parser,
+            raise QAPIParseError(self._parser,
                                  "'%s' parameter name duplicated" % name)
         if self.sections:
-            raise QAPIParseError(self.parser,
+            raise QAPIParseError(self._parser,
                                  "'@%s:' can't follow '%s' section"
                                  % (name, self.sections[0].name))
         self._end_section()
-        self.section = QAPIDoc.ArgSection(name)
-        self.args[name] = self.section
+        self._section = QAPIDoc.ArgSection(name)
+        self.args[name] = self._section
 
     def _start_section(self, name=None):
         if name in ('Returns', 'Since') and self.has_section(name):
-            raise QAPIParseError(self.parser,
+            raise QAPIParseError(self._parser,
                                  "Duplicated '%s' section" % name)
         self._end_section()
-        self.section = QAPIDoc.Section(name)
-        self.sections.append(self.section)
+        self._section = QAPIDoc.Section(name)
+        self.sections.append(self._section)
 
     def _end_section(self):
-        if self.section:
-            text = self.section.text = self.section.text.strip()
-            if self.section.name and (not text or text.isspace()):
-                raise QAPIParseError(self.parser, "Empty doc section '%s'"
-                                     % self.section.name)
-            self.section = None
+        if self._section:
+            text = self._section.text = self._section.text.strip()
+            if self._section.name and (not text or text.isspace()):
+                raise QAPIParseError(self._parser, "Empty doc section '%s'"
+                                     % self._section.name)
+            self._section = None
 
     def _append_freeform(self, line):
-        in_arg = isinstance(self.section, QAPIDoc.ArgSection)
-        if (in_arg and self.section.text.endswith('\n\n')
+        in_arg = isinstance(self._section, QAPIDoc.ArgSection)
+        if (in_arg and self._section.text.endswith('\n\n')
                 and line and not line[0].isspace()):
             self._start_section()
-        if (in_arg or not self.section.name
-                or not self.section.name.startswith('Example')):
+        if (in_arg or not self._section.name
+                or not self._section.name.startswith('Example')):
             line = line.strip()
         match = re.match(r'(@\S+:)', line)
         if match:
-            raise QAPIParseError(self.parser,
+            raise QAPIParseError(self._parser,
                                  "'%s' not allowed in free-form documentation"
                                  % match.group(1))
-        self.section.append(line)
+        self._section.append(line)
 
     def connect_member(self, member):
         if member.name not in self.args:
-- 
2.13.6

Received: from eggs.gnu.org ([2001:4830:134:3::10]:52423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJr-0007bG-2V
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJm-0003eb-N5
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJm-0003c5-B6
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:54 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:34 +0100
Message-Id: <1489385927-6735-35-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 34/47] qapi: Move empty doc section
 checking to doc parser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Results in a more precise error location, but the real reason is
emptying out check_docs() step by step.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py                         | 20 ++++++++++++++------
 tests/qapi-schema/doc-empty-section.err |  2 +-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 8d34651..e53701a 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -173,6 +173,9 @@ class QAPIDoc(object):
         else:
             self._append_freeform(line)
 
+    def end_comment(self):
+        self._end_section()
+
     def _append_symbol_line(self, line):
         name = line.split(' ', 1)[0]
 
@@ -200,6 +203,7 @@ class QAPIDoc(object):
             raise QAPIParseError(self.parser,
                                  "'@%s:' can't follow '%s' section"
                                  % (name, self.sections[0].name))
+        self._end_section()
         self.section = QAPIDoc.ArgSection(name)
         self.args[name] = self.section
 
@@ -207,9 +211,18 @@ class QAPIDoc(object):
         if name in ('Returns', 'Since') and self.has_section(name):
             raise QAPIParseError(self.parser,
                                  "Duplicated '%s' section" % name)
+        self._end_section()
         self.section = QAPIDoc.Section(name)
         self.sections.append(self.section)
 
+    def _end_section(self):
+        if self.section:
+            contents = str(self.section)
+            if self.section.name and (not contents or contents.isspace()):
+                raise QAPIParseError(self.parser, "Empty doc section '%s'"
+                                     % self.section.name)
+            self.section = None
+
     def _append_freeform(self, line):
         in_arg = isinstance(self.section, QAPIDoc.ArgSection)
         if (in_arg and self.section.content
@@ -507,6 +520,7 @@ class QAPISchemaParser(object):
                 if self.val != '##':
                     raise QAPIParseError(self, "Junk after '##' at end of "
                                          "documentation comment")
+                doc.end_comment()
                 self.accept()
                 return doc
             else:
@@ -1007,12 +1021,6 @@ def check_definition_doc(doc, expr, info):
 
 def check_docs(docs):
     for doc in docs:
-        for section in doc.args.values() + doc.sections:
-            content = str(section)
-            if not content or content.isspace():
-                raise QAPISemError(doc.info,
-                                   "Empty doc section '%s'" % section.name)
-
         if doc.expr:
             check_definition_doc(doc, doc.expr, doc.info)
 
diff --git a/tests/qapi-schema/doc-empty-section.err b/tests/qapi-schema/doc-empty-section.err
index 00ad625..b61e4a7 100644
--- a/tests/qapi-schema/doc-empty-section.err
+++ b/tests/qapi-schema/doc-empty-section.err
@@ -1 +1 @@
-tests/qapi-schema/doc-empty-section.json:3: Empty doc section 'Note'
+tests/qapi-schema/doc-empty-section.json:7:1: Empty doc section 'Note'
-- 
2.7.4

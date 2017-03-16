Received: from eggs.gnu.org ([2001:4830:134:3::10]:54868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtW-000695-Lx
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtS-00079E-4v
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtR-00077K-Mk
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D2C83DBDF
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 66EB0189B8
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:52 +0100
Message-Id: <1489645685-4750-37-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for 2.9 36/49] qapi: Move empty doc section
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

Results in a more precise error location, but the real reason is
emptying out check_docs() step by step.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1489582656-31133-35-git-send-email-armbru@redhat.com>
---
 scripts/qapi.py                         | 20 ++++++++++++++------
 tests/qapi-schema/doc-empty-section.err |  2 +-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 4edcea1..648355e 100644
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
@@ -512,6 +525,7 @@ class QAPISchemaParser(object):
                 if self.val != '##':
                     raise QAPIParseError(self, "Junk after '##' at end of "
                                          "documentation comment")
+                doc.end_comment()
                 self.accept()
                 return doc
             else:
@@ -1012,12 +1026,6 @@ def check_definition_doc(doc, expr, info):
 
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

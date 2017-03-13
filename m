Received: from eggs.gnu.org ([2001:4830:134:3::10]:52478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJs-0007bu-Fh
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJn-0003fw-BI
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJm-0003dh-W3
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:55 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:38 +0100
Message-Id: <1489385927-6735-39-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 38/47] qapi: Eliminate check_docs() and
 drop QAPIDoc.expr
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

Move what's left in check_docs() to check_expr().  Delegate the actual
checking to new QAPIDoc.check_expr().

QAPIDoc.expr is now unused; drop it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 0b0ba59..0da426a 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -138,8 +138,6 @@ class QAPIDoc(object):
         self.sections = []
         # the current section
         self.section = self.body
-        # associated expression (to be set by expression parser)
-        self.expr = None
 
     def has_section(self, name):
         """Return True if we have a section with this name."""
@@ -249,6 +247,11 @@ class QAPIDoc(object):
             self.args[member.name] = QAPIDoc.ArgSection(member.name)
         self.args[member.name].connect(member)
 
+    def check_expr(self, expr):
+        if self.has_section('Returns') and 'command' not in expr:
+            raise QAPISemError(self.info,
+                               "'Returns:' is only valid for commands")
+
     def check(self):
         bogus = [name for name, section in self.args.iteritems()
                  if not section.member]
@@ -311,7 +314,6 @@ class QAPISchemaParser(object):
                         raise QAPISemError(
                             self.cur_doc.info,
                             "Expression documentation required")
-                    self.cur_doc.expr = expr
                     expr_elem['doc'] = self.cur_doc
                 self.exprs.append(expr_elem)
             self.cur_doc = None
@@ -979,6 +981,7 @@ def check_exprs(exprs):
     for expr_elem in exprs:
         expr = expr_elem['expr']
         info = expr_elem['info']
+        doc = expr_elem.get('doc')
 
         if 'enum' in expr:
             check_enum(expr, info)
@@ -995,22 +998,12 @@ def check_exprs(exprs):
         else:
             assert False, 'unexpected meta type'
 
+        if doc:
+            doc.check_expr(expr)
+
     return exprs
 
 
-def check_definition_doc(doc, expr, info):
-    if doc.has_section('Returns') and 'command' not in expr:
-        raise QAPISemError(info, "'Returns:' is only valid for commands")
-
-
-def check_docs(docs):
-    for doc in docs:
-        if doc.expr:
-            check_definition_doc(doc, doc.expr, doc.info)
-
-    return docs
-
-
 #
 # Schema compiler frontend
 #
@@ -1506,7 +1499,7 @@ class QAPISchema(object):
         try:
             parser = QAPISchemaParser(open(fname, 'r'))
             self.exprs = check_exprs(parser.exprs)
-            self.docs = check_docs(parser.docs)
+            self.docs = parser.docs
             self._entity_dict = {}
             self._predefining = True
             self._def_predefineds()
-- 
2.7.4

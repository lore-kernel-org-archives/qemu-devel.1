Received: from eggs.gnu.org ([2001:4830:134:3::10]:54915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtX-0006AB-KS
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtS-00079g-9e
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtR-00077c-SD
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6AF67E9DA
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F8515DD66
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:56 +0100
Message-Id: <1489645685-4750-41-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for 2.9 40/49] qapi: Eliminate check_docs() and
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

Move what's left in check_docs() to check_expr().  Delegate the actual
checking to new QAPIDoc.check_expr().

QAPIDoc.expr is now unused; drop it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1489582656-31133-39-git-send-email-armbru@redhat.com>
---
 scripts/qapi.py | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index ca9926b..1aaae8e 100644
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
@@ -316,7 +319,6 @@ class QAPISchemaParser(object):
                         raise QAPISemError(
                             self.cur_doc.info,
                             "Expression documentation required")
-                    self.cur_doc.expr = expr
                     expr_elem['doc'] = self.cur_doc
                 self.exprs.append(expr_elem)
             self.cur_doc = None
@@ -984,6 +986,7 @@ def check_exprs(exprs):
     for expr_elem in exprs:
         expr = expr_elem['expr']
         info = expr_elem['info']
+        doc = expr_elem.get('doc')
 
         if 'enum' in expr:
             check_enum(expr, info)
@@ -1000,22 +1003,12 @@ def check_exprs(exprs):
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
@@ -1511,7 +1504,7 @@ class QAPISchema(object):
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

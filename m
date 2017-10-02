Received: from eggs.gnu.org ([2001:4830:134:3::10]:44048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Th-0006xT-IN
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Tg-0003c1-7S
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz1Tf-0003bM-Us
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1831BC04AC6C
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:13:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:13:34 +0200
Message-Id: <20171002141341.24616-5-armbru@redhat.com>
In-Reply-To: <20171002141341.24616-1-armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 04/11] qapi: Make cur_doc local to
 QAPISchemaParser.__init__()
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

QAPISchemaParser.cur_doc is used only by .__init__() and its helper
.reject_expr_doc().  Make it local to __init__() and pass it to
.reject_expr_doc() explicitly.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 6c8001e96d..2f2738f562 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -272,21 +272,21 @@ class QAPISchemaParser(object):
         self.line_pos = 0
         self.exprs = []
         self.docs = []
-        self.cur_doc = None
         self.accept()
+        cur_doc = None
 
         while self.tok is not None:
             info = {'file': self.fname, 'line': self.line,
                     'parent': self.incl_info}
             if self.tok == '#':
-                self.reject_expr_doc()
-                self.cur_doc = self.get_doc(info)
-                self.docs.append(self.cur_doc)
+                self.reject_expr_doc(cur_doc)
+                cur_doc = self.get_doc(info)
+                self.docs.append(cur_doc)
                 continue
 
             expr = self.get_expr(False)
             if 'include' in expr:
-                self.reject_expr_doc()
+                self.reject_expr_doc(cur_doc)
                 if len(expr) != 1:
                     raise QAPISemError(info, "Invalid 'include' directive")
                 include = expr['include']
@@ -296,7 +296,7 @@ class QAPISchemaParser(object):
                 self._include(include, info, os.path.dirname(abs_fname),
                               previously_included)
             elif "pragma" in expr:
-                self.reject_expr_doc()
+                self.reject_expr_doc(cur_doc)
                 if len(expr) != 1:
                     raise QAPISemError(info, "Invalid 'pragma' directive")
                 pragma = expr['pragma']
@@ -308,22 +308,22 @@ class QAPISchemaParser(object):
             else:
                 expr_elem = {'expr': expr,
                              'info': info}
-                if self.cur_doc:
-                    if not self.cur_doc.symbol:
+                if cur_doc:
+                    if not cur_doc.symbol:
                         raise QAPISemError(
-                            self.cur_doc.info,
-                            "Expression documentation required")
-                    expr_elem['doc'] = self.cur_doc
+                            cur_doc.info, "Expression documentation required")
+                    expr_elem['doc'] = cur_doc
                 self.exprs.append(expr_elem)
-            self.cur_doc = None
-        self.reject_expr_doc()
+            cur_doc = None
+        self.reject_expr_doc(cur_doc)
 
-    def reject_expr_doc(self):
-        if self.cur_doc and self.cur_doc.symbol:
+    @staticmethod
+    def reject_expr_doc(doc):
+        if doc and doc.symbol:
             raise QAPISemError(
-                self.cur_doc.info,
+                doc.info,
                 "Documentation for '%s' is not followed by the definition"
-                % self.cur_doc.symbol)
+                % doc.symbol)
 
     def _include(self, include, info, base_dir, previously_included):
         incl_abs_fname = os.path.join(base_dir, include)
-- 
2.13.6

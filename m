Received: from eggs.gnu.org ([2001:4830:134:3::10]:54917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtY-0006AX-0C
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtS-00078z-1Q
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtR-000776-Kl
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A51F80F8E
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E4AE18379
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:49 +0100
Message-Id: <1489645685-4750-34-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for 2.9 33/49] qapi: Fix detection of doc /
 expression mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This fixes the errors uncovered by the previous commit.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1489582656-31133-32-git-send-email-armbru@redhat.com>
---
 scripts/qapi.py                           | 35 +++++++++++++++++++------------
 tests/qapi-schema/doc-before-include.err  |  1 +
 tests/qapi-schema/doc-before-include.exit |  2 +-
 tests/qapi-schema/doc-before-include.json |  1 -
 tests/qapi-schema/doc-before-include.out  |  4 ----
 tests/qapi-schema/doc-before-pragma.err   |  1 +
 tests/qapi-schema/doc-before-pragma.exit  |  2 +-
 tests/qapi-schema/doc-before-pragma.json  |  1 -
 tests/qapi-schema/doc-before-pragma.out   |  4 ----
 tests/qapi-schema/doc-missing-expr.err    |  2 +-
 tests/qapi-schema/doc-no-symbol.err       |  2 +-
 tests/qapi-schema/doc-no-symbol.json      |  1 -
 12 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 21a1591..37f2814 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -248,18 +248,21 @@ class QAPISchemaParser(object):
         self.line_pos = 0
         self.exprs = []
         self.docs = []
+        self.cur_doc = None
         self.accept()
 
         while self.tok is not None:
             info = {'file': fname, 'line': self.line,
                     'parent': self.incl_info}
             if self.tok == '#':
-                doc = self.get_doc(info)
-                self.docs.append(doc)
+                self.reject_expr_doc()
+                self.cur_doc = self.get_doc(info)
+                self.docs.append(self.cur_doc)
                 continue
 
             expr = self.get_expr(False)
             if 'include' in expr:
+                self.reject_expr_doc()
                 if len(expr) != 1:
                     raise QAPISemError(info, "Invalid 'include' directive")
                 include = expr['include']
@@ -269,6 +272,7 @@ class QAPISchemaParser(object):
                 self._include(include, info, os.path.dirname(abs_fname),
                               previously_included)
             elif "pragma" in expr:
+                self.reject_expr_doc()
                 if len(expr) != 1:
                     raise QAPISemError(info, "Invalid 'pragma' directive")
                 pragma = expr['pragma']
@@ -280,13 +284,23 @@ class QAPISchemaParser(object):
             else:
                 expr_elem = {'expr': expr,
                              'info': info}
-                if (self.docs
-                        and self.docs[-1].info['file'] == fname
-                        and not self.docs[-1].expr):
-                    self.docs[-1].expr = expr
-                    expr_elem['doc'] = self.docs[-1]
-
+                if self.cur_doc:
+                    if not self.cur_doc.symbol:
+                        raise QAPISemError(
+                            self.cur_doc.info,
+                            "Expression documentation required")
+                    self.cur_doc.expr = expr
+                    expr_elem['doc'] = self.cur_doc
                 self.exprs.append(expr_elem)
+            self.cur_doc = None
+        self.reject_expr_doc()
+
+    def reject_expr_doc(self):
+        if self.cur_doc and self.cur_doc.symbol:
+            raise QAPISemError(
+                self.cur_doc.info,
+                "Documentation for '%s' is not followed by the definition"
+                % self.cur_doc.symbol)
 
     def _include(self, include, info, base_dir, previously_included):
         incl_abs_fname = os.path.join(base_dir, include)
@@ -950,11 +964,6 @@ def check_exprs(exprs):
 
 
 def check_freeform_doc(doc):
-    if doc.symbol:
-        raise QAPISemError(doc.info,
-                           "Documention for '%s' is not followed"
-                           " by the definition" % doc.symbol)
-
     body = str(doc.body)
     if re.search(r'@\S+:', body, re.MULTILINE):
         raise QAPISemError(doc.info,
diff --git a/tests/qapi-schema/doc-before-include.err b/tests/qapi-schema/doc-before-include.err
index e69de29..a649d38 100644
--- a/tests/qapi-schema/doc-before-include.err
+++ b/tests/qapi-schema/doc-before-include.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-before-include.json:3: Documentation for 'foo' is not followed by the definition
diff --git a/tests/qapi-schema/doc-before-include.exit b/tests/qapi-schema/doc-before-include.exit
index 573541a..d00491f 100644
--- a/tests/qapi-schema/doc-before-include.exit
+++ b/tests/qapi-schema/doc-before-include.exit
@@ -1 +1 @@
-0
+1
diff --git a/tests/qapi-schema/doc-before-include.json b/tests/qapi-schema/doc-before-include.json
index ec1fbf2..0caa0ae 100644
--- a/tests/qapi-schema/doc-before-include.json
+++ b/tests/qapi-schema/doc-before-include.json
@@ -1,5 +1,4 @@
 # Doc comment separated from defining expression by non-defining expression
-# BUG: not rejected
 
 ##
 # @foo:
diff --git a/tests/qapi-schema/doc-before-include.out b/tests/qapi-schema/doc-before-include.out
index 236a849..e69de29 100644
--- a/tests/qapi-schema/doc-before-include.out
+++ b/tests/qapi-schema/doc-before-include.out
@@ -1,4 +0,0 @@
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloat', 'qbool']
-    prefix QTYPE
-object foo
-object q_empty
diff --git a/tests/qapi-schema/doc-before-pragma.err b/tests/qapi-schema/doc-before-pragma.err
index e69de29..c0fb066 100644
--- a/tests/qapi-schema/doc-before-pragma.err
+++ b/tests/qapi-schema/doc-before-pragma.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-before-pragma.json:3: Documentation for 'foo' is not followed by the definition
diff --git a/tests/qapi-schema/doc-before-pragma.exit b/tests/qapi-schema/doc-before-pragma.exit
index 573541a..d00491f 100644
--- a/tests/qapi-schema/doc-before-pragma.exit
+++ b/tests/qapi-schema/doc-before-pragma.exit
@@ -1 +1 @@
-0
+1
diff --git a/tests/qapi-schema/doc-before-pragma.json b/tests/qapi-schema/doc-before-pragma.json
index fb2ec8e..a6e090e 100644
--- a/tests/qapi-schema/doc-before-pragma.json
+++ b/tests/qapi-schema/doc-before-pragma.json
@@ -1,5 +1,4 @@
 # Doc comment separated from defining expression by non-defining expression
-# BUG: not rejected
 
 ##
 # @foo:
diff --git a/tests/qapi-schema/doc-before-pragma.out b/tests/qapi-schema/doc-before-pragma.out
index 236a849..e69de29 100644
--- a/tests/qapi-schema/doc-before-pragma.out
+++ b/tests/qapi-schema/doc-before-pragma.out
@@ -1,4 +0,0 @@
-enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloat', 'qbool']
-    prefix QTYPE
-object foo
-object q_empty
diff --git a/tests/qapi-schema/doc-missing-expr.err b/tests/qapi-schema/doc-missing-expr.err
index c0e687c..c909e26 100644
--- a/tests/qapi-schema/doc-missing-expr.err
+++ b/tests/qapi-schema/doc-missing-expr.err
@@ -1 +1 @@
-tests/qapi-schema/doc-missing-expr.json:3: Documention for 'bar' is not followed by the definition
+tests/qapi-schema/doc-missing-expr.json:3: Documentation for 'bar' is not followed by the definition
diff --git a/tests/qapi-schema/doc-no-symbol.err b/tests/qapi-schema/doc-no-symbol.err
index 727966c..75f032a 100644
--- a/tests/qapi-schema/doc-no-symbol.err
+++ b/tests/qapi-schema/doc-no-symbol.err
@@ -1 +1 @@
-tests/qapi-schema/doc-no-symbol.json:4: Definition of 'foo' follows documentation for 'None'
+tests/qapi-schema/doc-no-symbol.json:3: Expression documentation required
diff --git a/tests/qapi-schema/doc-no-symbol.json b/tests/qapi-schema/doc-no-symbol.json
index ee86ca1..98605ba 100644
--- a/tests/qapi-schema/doc-no-symbol.json
+++ b/tests/qapi-schema/doc-no-symbol.json
@@ -1,5 +1,4 @@
 # Documentation for expression lacks symbol
-# BUG: Error message claims it has symbol 'None'
 
 ##
 # foo:
-- 
2.7.4

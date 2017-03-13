Received: from eggs.gnu.org ([2001:4830:134:3::10]:52417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJr-0007bC-0b
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJm-0003eN-Kl
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJm-0003bG-6L
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:54 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:31 +0100
Message-Id: <1489385927-6735-32-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 31/47] qapi: Fix detection of doc /
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
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

This fixes the errors uncovered by the previous commit.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py                        | 34 +++++++++++++++++++++-------------
 tests/qapi-schema/doc-bad-expr.err     |  1 +
 tests/qapi-schema/doc-bad-expr.exit    |  2 +-
 tests/qapi-schema/doc-bad-expr.json    |  1 -
 tests/qapi-schema/doc-bad-expr.out     |  4 ----
 tests/qapi-schema/doc-missing-expr.err |  2 +-
 tests/qapi-schema/doc-no-symbol.err    |  2 +-
 tests/qapi-schema/doc-no-symbol.json   |  1 -
 8 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index b82a2a6..1052274 100644
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
@@ -276,13 +279,23 @@ class QAPISchemaParser(object):
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
@@ -946,11 +959,6 @@ def check_exprs(exprs):
 
 
 def check_freeform_doc(doc):
-    if doc.symbol:
-        raise QAPISemError(doc.info,
-                           "Documention for '%s' is not followed"
-                           " by the definition" % doc.symbol)
-
     body = str(doc.body)
     if re.search(r'@\S+:', body, re.MULTILINE):
         raise QAPISemError(doc.info,
diff --git a/tests/qapi-schema/doc-bad-expr.err b/tests/qapi-schema/doc-bad-expr.err
index e69de29..65e9d1f 100644
--- a/tests/qapi-schema/doc-bad-expr.err
+++ b/tests/qapi-schema/doc-bad-expr.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-bad-expr.json:3: Documentation for 'foo' is not followed by the definition
diff --git a/tests/qapi-schema/doc-bad-expr.exit b/tests/qapi-schema/doc-bad-expr.exit
index 573541a..d00491f 100644
--- a/tests/qapi-schema/doc-bad-expr.exit
+++ b/tests/qapi-schema/doc-bad-expr.exit
@@ -1 +1 @@
-0
+1
diff --git a/tests/qapi-schema/doc-bad-expr.json b/tests/qapi-schema/doc-bad-expr.json
index ec1fbf2..0caa0ae 100644
--- a/tests/qapi-schema/doc-bad-expr.json
+++ b/tests/qapi-schema/doc-bad-expr.json
@@ -1,5 +1,4 @@
 # Doc comment separated from defining expression by non-defining expression
-# BUG: not rejected
 
 ##
 # @foo:
diff --git a/tests/qapi-schema/doc-bad-expr.out b/tests/qapi-schema/doc-bad-expr.out
index 236a849..e69de29 100644
--- a/tests/qapi-schema/doc-bad-expr.out
+++ b/tests/qapi-schema/doc-bad-expr.out
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

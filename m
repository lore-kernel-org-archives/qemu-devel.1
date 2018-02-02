Received: from eggs.gnu.org ([208.118.235.92]:55983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdLZ-0002kG-Uk
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdKV-0003VU-JV
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:33:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehdKU-0003Tg-U1
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:32:43 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  2 Feb 2018 14:03:28 +0100
Message-Id: <20180202130336.24719-14-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-1-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 13/21] qapi: Record 'include' directives in
 parse tree
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

The parse tree is a list of expressions.  Except include expressions
currently get replaced by the included file's parse tree.

Instead of throwing away the include expression, keep it with the file
name expanded so you don't have to track the including file's
directory to make sense of it.

A future commit will put this include expression to use.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 7a327bfe9f..d5b93e7381 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -286,8 +286,11 @@ class QAPISchemaParser(object):
                 if not isinstance(include, str):
                     raise QAPISemError(info,
                                        "Value of 'include' must be a string")
-                exprs_include = self._include(include, info,
-                                              os.path.dirname(self.fname),
+                incl_fname = os.path.join(os.path.dirname(self.fname),
+                                          include)
+                self.exprs.append({'expr': {'include': incl_fname},
+                                   'info': info})
+                exprs_include = self._include(include, info, incl_fname,
                                               previously_included)
                 if exprs_include:
                     self.exprs.extend(exprs_include.exprs)
@@ -322,8 +325,7 @@ class QAPISchemaParser(object):
                 "Documentation for '%s' is not followed by the definition"
                 % doc.symbol)
 
-    def _include(self, include, info, base_dir, previously_included):
-        incl_fname = os.path.join(base_dir, include)
+    def _include(self, include, info, incl_fname, previously_included):
         incl_abs_fname = os.path.abspath(incl_fname)
         # catch inclusion cycle
         inf = info
@@ -889,6 +891,9 @@ def check_exprs(exprs):
         info = expr_elem['info']
         doc = expr_elem.get('doc')
 
+        if 'include' in expr:
+            continue
+
         if not doc and doc_required:
             raise QAPISemError(info,
                                "Expression missing documentation comment")
@@ -927,6 +932,9 @@ def check_exprs(exprs):
 
     # Try again for hidden UnionKind enum
     for expr_elem in exprs:
+        if 'include' in expr:
+            continue
+
         expr = expr_elem['expr']
         if 'union' in expr and not discriminator_find_enum_define(expr):
             name = '%sKind' % expr['union']
@@ -939,6 +947,9 @@ def check_exprs(exprs):
 
     # Validate that exprs make sense
     for expr_elem in exprs:
+        if 'include' in expr:
+            continue
+
         expr = expr_elem['expr']
         info = expr_elem['info']
         doc = expr_elem.get('doc')
@@ -1663,6 +1674,8 @@ class QAPISchema(object):
                 self._def_command(expr, info, doc)
             elif 'event' in expr:
                 self._def_event(expr, info, doc)
+            elif 'include' in expr:
+                pass
             else:
                 assert False
 
-- 
2.13.6

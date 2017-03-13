Received: from eggs.gnu.org ([2001:4830:134:3::10]:52405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJq-0007au-N0
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJm-0003eF-H3
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJm-0003bD-6A
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:54 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:32 +0100
Message-Id: <1489385927-6735-33-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 32/47] qapi: Move detection of doc /
 expression name mismatch
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

Move the check whether the doc matches the expression name from
check_definition_doc() to check_exprs().  This changes the error
location from the comment to the expression.  Makes sense as the
message talks about the expresion: "Definition of '%s' follows
documentation for '%s'".  It's also a step towards getting rid of
check_docs().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py                      | 28 ++++++++++++++++++----------
 tests/qapi-schema/doc-bad-symbol.err |  2 +-
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 1052274..ca8d1f0 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -889,40 +889,52 @@ def check_keys(expr_elem, meta, required, optional=[]):
 def check_exprs(exprs):
     global all_names
 
-    # Learn the types and check for valid expression keys
+    # Populate name table with names of built-in types
     for builtin in builtin_types.keys():
         all_names[builtin] = 'built-in'
+
+    # Learn the types and check for valid expression keys
     for expr_elem in exprs:
         expr = expr_elem['expr']
         info = expr_elem['info']
+        doc = expr_elem.get('doc')
 
-        if 'doc' not in expr_elem and doc_required:
+        if not doc and doc_required:
             raise QAPISemError(info,
                                "Expression missing documentation comment")
 
         if 'enum' in expr:
+            name = expr['enum']
             check_keys(expr_elem, 'enum', ['data'], ['prefix'])
-            add_enum(expr['enum'], info, expr['data'])
+            add_enum(name, info, expr['data'])
         elif 'union' in expr:
+            name = expr['union']
             check_keys(expr_elem, 'union', ['data'],
                        ['base', 'discriminator'])
             add_union(expr, info)
         elif 'alternate' in expr:
+            name = expr['alternate']
             check_keys(expr_elem, 'alternate', ['data'])
-            add_name(expr['alternate'], info, 'alternate')
+            add_name(name, info, 'alternate')
         elif 'struct' in expr:
+            name = expr['struct']
             check_keys(expr_elem, 'struct', ['data'], ['base'])
             add_struct(expr, info)
         elif 'command' in expr:
+            name = expr['command']
             check_keys(expr_elem, 'command', [],
                        ['data', 'returns', 'gen', 'success-response', 'boxed'])
-            add_name(expr['command'], info, 'command')
+            add_name(name, info, 'command')
         elif 'event' in expr:
+            name = expr['event']
             check_keys(expr_elem, 'event', [], ['data', 'boxed'])
-            add_name(expr['event'], info, 'event')
+            add_name(name, info, 'event')
         else:
             raise QAPISemError(expr_elem['info'],
                                "Expression is missing metatype")
+        if doc and doc.symbol != name:
+            raise QAPISemError(info, "Definition of '%s' follows documentation"
+                               " for '%s'" % (name, doc.symbol))
 
     # Try again for hidden UnionKind enum
     for expr_elem in exprs:
@@ -972,10 +984,6 @@ def check_definition_doc(doc, expr, info):
             meta = i
             break
 
-    name = expr[meta]
-    if doc.symbol != name:
-        raise QAPISemError(info, "Definition of '%s' follows documentation"
-                           " for '%s'" % (name, doc.symbol))
     if doc.has_section('Returns') and 'command' not in expr:
         raise QAPISemError(info, "'Returns:' is only valid for commands")
 
diff --git a/tests/qapi-schema/doc-bad-symbol.err b/tests/qapi-schema/doc-bad-symbol.err
index ac4e566..8472030 100644
--- a/tests/qapi-schema/doc-bad-symbol.err
+++ b/tests/qapi-schema/doc-bad-symbol.err
@@ -1 +1 @@
-tests/qapi-schema/doc-bad-symbol.json:3: Definition of 'foo' follows documentation for 'food'
+tests/qapi-schema/doc-bad-symbol.json:6: Definition of 'foo' follows documentation for 'food'
-- 
2.7.4

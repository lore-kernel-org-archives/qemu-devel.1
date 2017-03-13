Received: from eggs.gnu.org ([2001:4830:134:3::10]:52550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJu-0007d5-9s
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJn-0003g5-Dm
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJm-0003dj-Ve
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:55 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:41 +0100
Message-Id: <1489385927-6735-42-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 41/47] qapi: Factor add_name() calls
 out of the meta conditional
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index ffd30d2..f06e3c4 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -635,8 +635,6 @@ def add_name(name, info, meta, implicit=False):
 
 def add_struct(definition, info):
     global struct_types
-    name = definition['struct']
-    add_name(name, info, 'struct')
     struct_types.append(definition)
 
 
@@ -650,8 +648,6 @@ def find_struct(name):
 
 def add_union(definition, info):
     global union_types
-    name = definition['union']
-    add_name(name, info, 'union')
     union_types.append(definition)
 
 
@@ -665,8 +661,6 @@ def find_union(name):
 
 def add_enum(definition, info):
     global enum_types
-    name = definition['enum']
-    add_name(name, info, 'enum', 'data' not in definition)
     enum_types.append(definition)
 
 
@@ -932,34 +926,33 @@ def check_exprs(exprs):
                                "Expression missing documentation comment")
 
         if 'enum' in expr:
-            name = expr['enum']
+            meta = 'enum'
             check_keys(expr_elem, 'enum', ['data'], ['prefix'])
             add_enum(expr, info)
         elif 'union' in expr:
-            name = expr['union']
+            meta = 'union'
             check_keys(expr_elem, 'union', ['data'],
                        ['base', 'discriminator'])
             add_union(expr, info)
         elif 'alternate' in expr:
-            name = expr['alternate']
+            meta = 'alternate'
             check_keys(expr_elem, 'alternate', ['data'])
-            add_name(name, info, 'alternate')
         elif 'struct' in expr:
-            name = expr['struct']
+            meta = 'struct'
             check_keys(expr_elem, 'struct', ['data'], ['base'])
             add_struct(expr, info)
         elif 'command' in expr:
-            name = expr['command']
+            meta = 'command'
             check_keys(expr_elem, 'command', [],
                        ['data', 'returns', 'gen', 'success-response', 'boxed'])
-            add_name(name, info, 'command')
         elif 'event' in expr:
-            name = expr['event']
+            meta = 'event'
             check_keys(expr_elem, 'event', [], ['data', 'boxed'])
-            add_name(name, info, 'event')
         else:
             raise QAPISemError(expr_elem['info'],
                                "Expression is missing metatype")
+        name = expr[meta]
+        add_name(name, info, meta)
         if doc and doc.symbol != name:
             raise QAPISemError(info, "Definition of '%s' follows documentation"
                                " for '%s'" % (name, doc.symbol))
@@ -974,6 +967,7 @@ def check_exprs(exprs):
         else:
             continue
         add_enum({ 'enum': name }, expr_elem['info'])
+        add_name(name, info, 'enum', implicit=True)
 
     # Validate that exprs make sense
     for expr_elem in exprs:
-- 
2.7.4

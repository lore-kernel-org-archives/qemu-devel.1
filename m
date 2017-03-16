Received: from eggs.gnu.org ([2001:4830:134:3::10]:55010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtZ-0006Cu-Mo
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtS-0007Au-Li
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtS-00077s-5n
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC56051453
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A7FCB1754C
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:59 +0100
Message-Id: <1489645685-4750-44-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for 2.9 43/49] qapi: Factor add_name() calls out
 of the meta conditional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1489582656-31133-42-git-send-email-armbru@redhat.com>
---
 scripts/qapi.py | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 3c6e137..1f79eb4 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -640,8 +640,6 @@ def add_name(name, info, meta, implicit=False):
 
 def add_struct(definition, info):
     global struct_types
-    name = definition['struct']
-    add_name(name, info, 'struct')
     struct_types.append(definition)
 
 
@@ -655,8 +653,6 @@ def find_struct(name):
 
 def add_union(definition, info):
     global union_types
-    name = definition['union']
-    add_name(name, info, 'union')
     union_types.append(definition)
 
 
@@ -670,8 +666,6 @@ def find_union(name):
 
 def add_enum(definition, info):
     global enum_types
-    name = definition['enum']
-    add_name(name, info, 'enum', 'data' not in definition)
     enum_types.append(definition)
 
 
@@ -937,34 +931,33 @@ def check_exprs(exprs):
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
@@ -979,6 +972,7 @@ def check_exprs(exprs):
         else:
             continue
         add_enum({ 'enum': name }, expr_elem['info'])
+        add_name(name, info, 'enum', implicit=True)
 
     # Validate that exprs make sense
     for expr_elem in exprs:
-- 
2.7.4

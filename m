Received: from eggs.gnu.org ([2001:4830:134:3::10]:33630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ux-0001ax-9J
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ur-0000Nl-Op
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Ur-0000L4-Ce
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:45 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:57:29 +0100
Message-Id: <1489582656-31133-41-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.9 40/47] qapi: Simplify what gets
 stored in enum_types
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

Don't invent a new dictionary structure just for enum_types, simply
store the defining expression, like we do for struct_types and
union_types.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi.py | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index d5a113c..3c6e137 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -668,16 +668,17 @@ def find_union(name):
     return None
 
 
-def add_enum(name, info, enum_values=None, implicit=False):
+def add_enum(definition, info):
     global enum_types
-    add_name(name, info, 'enum', implicit)
-    enum_types.append({'enum_name': name, 'enum_values': enum_values})
+    name = definition['enum']
+    add_name(name, info, 'enum', 'data' not in definition)
+    enum_types.append(definition)
 
 
 def find_enum(name):
     global enum_types
     for enum in enum_types:
-        if enum['enum_name'] == name:
+        if enum['enum'] == name:
             return enum
     return None
 
@@ -825,15 +826,15 @@ def check_union(expr, info):
         # If the discriminator names an enum type, then all members
         # of 'data' must also be members of the enum type.
         if enum_define:
-            if key not in enum_define['enum_values']:
+            if key not in enum_define['data']:
                 raise QAPISemError(info,
                                    "Discriminator value '%s' is not found in "
                                    "enum '%s'"
-                                   % (key, enum_define['enum_name']))
+                                   % (key, enum_define['enum']))
 
     # If discriminator is user-defined, ensure all values are covered
     if enum_define:
-        for value in enum_define['enum_values']:
+        for value in enum_define['data']:
             if value not in members.keys():
                 raise QAPISemError(info, "Union '%s' data missing '%s' branch"
                                    % (name, value))
@@ -938,7 +939,7 @@ def check_exprs(exprs):
         if 'enum' in expr:
             name = expr['enum']
             check_keys(expr_elem, 'enum', ['data'], ['prefix'])
-            add_enum(name, info, expr['data'])
+            add_enum(expr, info)
         elif 'union' in expr:
             name = expr['union']
             check_keys(expr_elem, 'union', ['data'],
@@ -971,13 +972,13 @@ def check_exprs(exprs):
     # Try again for hidden UnionKind enum
     for expr_elem in exprs:
         expr = expr_elem['expr']
-        if 'union' in expr:
-            if not discriminator_find_enum_define(expr):
-                add_enum('%sKind' % expr['union'], expr_elem['info'],
-                         implicit=True)
+        if 'union' in expr and not discriminator_find_enum_define(expr):
+            name = '%sKind' % expr['union']
         elif 'alternate' in expr:
-            add_enum('%sKind' % expr['alternate'], expr_elem['info'],
-                     implicit=True)
+            name = '%sKind' % expr['alternate']
+        else:
+            continue
+        add_enum({ 'enum': name }, expr_elem['info'])
 
     # Validate that exprs make sense
     for expr_elem in exprs:
-- 
2.7.4

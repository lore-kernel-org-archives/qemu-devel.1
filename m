Received: from eggs.gnu.org ([2001:4830:134:3::10]:33623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ux-0001ad-7w
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ur-0000Nz-Ri
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Ur-0000Lj-HX
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:45 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:57:31 +0100
Message-Id: <1489582656-31133-43-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.9 42/47] qapi: enum_types is a list
 used like a dict, make it one
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi.py | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 1f79eb4..735ddaa 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -46,7 +46,7 @@ returns_whitelist = []
 # Whitelist of entities allowed to violate case conventions
 name_case_whitelist = []
 
-enum_types = []
+enum_types = {}
 struct_types = []
 union_types = []
 all_names = {}
@@ -567,7 +567,7 @@ def find_alternate_member_qtype(qapi_type):
         return builtin_types[qapi_type]
     elif find_struct(qapi_type):
         return 'QTYPE_QDICT'
-    elif find_enum(qapi_type):
+    elif qapi_type in enum_types:
         return 'QTYPE_QSTRING'
     elif find_union(qapi_type):
         return 'QTYPE_QDICT'
@@ -591,7 +591,7 @@ def discriminator_find_enum_define(expr):
     if not discriminator_type:
         return None
 
-    return find_enum(discriminator_type)
+    return enum_types.get(discriminator_type)
 
 
 # Names must be letters, numbers, -, and _.  They must start with letter,
@@ -664,23 +664,6 @@ def find_union(name):
     return None
 
 
-def add_enum(definition, info):
-    global enum_types
-    enum_types.append(definition)
-
-
-def find_enum(name):
-    global enum_types
-    for enum in enum_types:
-        if enum['enum'] == name:
-            return enum
-    return None
-
-
-def is_enum(name):
-    return find_enum(name) is not None
-
-
 def check_type(info, source, value, allow_array=False,
                allow_dict=False, allow_optional=False,
                allow_metas=[]):
@@ -799,7 +782,7 @@ def check_union(expr, info):
                                "Discriminator '%s' is not a member of base "
                                "struct '%s'"
                                % (discriminator, base))
-        enum_define = find_enum(discriminator_type)
+        enum_define = enum_types.get(discriminator_type)
         allow_metas = ['struct']
         # Do not allow string discriminator
         if not enum_define:
@@ -933,7 +916,7 @@ def check_exprs(exprs):
         if 'enum' in expr:
             meta = 'enum'
             check_keys(expr_elem, 'enum', ['data'], ['prefix'])
-            add_enum(expr, info)
+            enum_types[expr[meta]] = expr
         elif 'union' in expr:
             meta = 'union'
             check_keys(expr_elem, 'union', ['data'],
@@ -971,7 +954,7 @@ def check_exprs(exprs):
             name = '%sKind' % expr['alternate']
         else:
             continue
-        add_enum({ 'enum': name }, expr_elem['info'])
+        enum_types[name] = {'enum': name}
         add_name(name, info, 'enum', implicit=True)
 
     # Validate that exprs make sense
-- 
2.7.4

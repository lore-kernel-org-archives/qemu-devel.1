Received: from eggs.gnu.org ([2001:4830:134:3::10]:33627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ux-0001au-88
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Us-0000OV-2m
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Ur-0000Lv-Px
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:45 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:57:32 +0100
Message-Id: <1489582656-31133-44-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.9 43/47] qapi: struct_types is a list
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
 scripts/qapi.py | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 735ddaa..f4d1a48 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -47,7 +47,7 @@ returns_whitelist = []
 name_case_whitelist = []
 
 enum_types = {}
-struct_types = []
+struct_types = {}
 union_types = []
 all_names = {}
 
@@ -555,7 +555,7 @@ class QAPISchemaParser(object):
 def find_base_members(base):
     if isinstance(base, dict):
         return base
-    base_struct_define = find_struct(base)
+    base_struct_define = struct_types.get(base)
     if not base_struct_define:
         return None
     return base_struct_define['data']
@@ -565,7 +565,7 @@ def find_base_members(base):
 def find_alternate_member_qtype(qapi_type):
     if qapi_type in builtin_types:
         return builtin_types[qapi_type]
-    elif find_struct(qapi_type):
+    elif qapi_type in struct_types:
         return 'QTYPE_QDICT'
     elif qapi_type in enum_types:
         return 'QTYPE_QSTRING'
@@ -638,19 +638,6 @@ def add_name(name, info, meta, implicit=False):
     all_names[name] = meta
 
 
-def add_struct(definition, info):
-    global struct_types
-    struct_types.append(definition)
-
-
-def find_struct(name):
-    global struct_types
-    for struct in struct_types:
-        if struct['struct'] == name:
-            return struct
-    return None
-
-
 def add_union(definition, info):
     global union_types
     union_types.append(definition)
@@ -928,7 +915,7 @@ def check_exprs(exprs):
         elif 'struct' in expr:
             meta = 'struct'
             check_keys(expr_elem, 'struct', ['data'], ['base'])
-            add_struct(expr, info)
+            struct_types[expr[meta]] = expr
         elif 'command' in expr:
             meta = 'command'
             check_keys(expr_elem, 'command', [],
-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtX-0006A6-IV
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtS-0007A3-EK
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtS-00077t-2A
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBD4CC04BD37
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A853C1837E
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:28:01 +0100
Message-Id: <1489645685-4750-46-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for 2.9 45/49] qapi: struct_types is a list used
 like a dict, make it one
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
Message-Id: <1489582656-31133-44-git-send-email-armbru@redhat.com>
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

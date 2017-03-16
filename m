Received: from eggs.gnu.org ([2001:4830:134:3::10]:55009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtZ-0006Cm-Mj
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtS-0007Al-Li
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtS-00077v-5x
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC1E2C04BD3A
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A758A60F85
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:28:00 +0100
Message-Id: <1489645685-4750-45-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for 2.9 44/49] qapi: enum_types is a list used
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
Message-Id: <1489582656-31133-43-git-send-email-armbru@redhat.com>
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

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fH3zz-0000aP-51
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fH3zu-0000fG-Si
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:05:59 -0400
Received: from mail-he1eur01on0724.outbound.protection.outlook.com
	([2a01:111:f400:fe1e::724]:32813
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1fH3zu-0000WI-HL
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:05:54 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 11 May 2018 12:05:33 +0300
Message-Id: <1526029534-35771-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1526029534-35771-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1526029534-35771-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/2] qapi: allow flat unions with empty branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

The patch makes possible to avoid introducing dummy empty types
for the flat union branches that have no data.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 scripts/qapi/common.py         | 18 ++++++++++++------
 scripts/qapi/doc.py            |  2 +-
 scripts/qapi/types.py          |  2 +-
 scripts/qapi/visit.py          | 12 +++++++-----
 tests/qapi-schema/test-qapi.py |  2 +-
 5 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index a032cec..ec5cf28 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -721,6 +721,7 @@ def check_union(expr, info):
     name = expr['union']
     base = expr.get('base')
     discriminator = expr.get('discriminator')
+    partial = expr.get('data-partial', False)
     members = expr['data']
 
     # Two types of unions, determined by discriminator.
@@ -783,7 +784,7 @@ def check_union(expr, info):
                                    % (key, enum_define['enum']))
 
     # If discriminator is user-defined, ensure all values are covered
-    if enum_define:
+    if enum_define and not partial:
         for value in enum_define['data']:
             if value not in members.keys():
                 raise QAPISemError(info, "Union '%s' data missing '%s' branch"
@@ -909,7 +910,7 @@ def check_exprs(exprs):
         elif 'union' in expr:
             meta = 'union'
             check_keys(expr_elem, 'union', ['data'],
-                       ['base', 'discriminator'])
+                       ['base', 'discriminator', 'data-partial'])
             union_types[expr[meta]] = expr
         elif 'alternate' in expr:
             meta = 'alternate'
@@ -1035,7 +1036,7 @@ class QAPISchemaVisitor(object):
     def visit_array_type(self, name, info, element_type):
         pass
 
-    def visit_object_type(self, name, info, base, members, variants):
+    def visit_object_type(self, name, info, base, members, variants, partial):
         pass
 
     def visit_object_type_flat(self, name, info, members, variants):
@@ -1192,7 +1193,8 @@ class QAPISchemaArrayType(QAPISchemaType):
 
 
 class QAPISchemaObjectType(QAPISchemaType):
-    def __init__(self, name, info, doc, base, local_members, variants):
+    def __init__(self, name, info, doc, base, local_members, variants,
+                 partial = False):
         # struct has local_members, optional base, and no variants
         # flat union has base, variants, and no local_members
         # simple union has local_members, variants, and no base
@@ -1209,6 +1211,7 @@ class QAPISchemaObjectType(QAPISchemaType):
         self.local_members = local_members
         self.variants = variants
         self.members = None
+        self.partial = partial
 
     def check(self, schema):
         if self.members is False:               # check for cycles
@@ -1269,7 +1272,8 @@ class QAPISchemaObjectType(QAPISchemaType):
 
     def visit(self, visitor):
         visitor.visit_object_type(self.name, self.info,
-                                  self.base, self.local_members, self.variants)
+                                  self.base, self.local_members, self.variants,
+                                  self.partial)
         visitor.visit_object_type_flat(self.name, self.info,
                                        self.members, self.variants)
 
@@ -1636,6 +1640,7 @@ class QAPISchema(object):
         name = expr['union']
         data = expr['data']
         base = expr.get('base')
+        partial = expr.get('data-partial', False)
         tag_name = expr.get('discriminator')
         tag_member = None
         if isinstance(base, dict):
@@ -1656,7 +1661,8 @@ class QAPISchema(object):
             QAPISchemaObjectType(name, info, doc, base, members,
                                  QAPISchemaObjectTypeVariants(tag_name,
                                                               tag_member,
-                                                              variants)))
+                                                              variants),
+                                 partial))
 
     def _def_alternate_type(self, expr, info, doc):
         name = expr['alternate']
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 9b312b2..40dffc4 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -211,7 +211,7 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaVisitor):
                                body=texi_entity(doc, 'Values',
                                                 member_func=texi_enum_value)))
 
-    def visit_object_type(self, name, info, base, members, variants):
+    def visit_object_type(self, name, info, base, members, variants, partial):
         doc = self.cur_doc
         if base and base.is_implicit():
             base = None
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 64d9c0f..e805509 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -215,7 +215,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):
         self._genh.add(gen_array(name, element_type))
         self._gen_type_cleanup(name)
 
-    def visit_object_type(self, name, info, base, members, variants):
+    def visit_object_type(self, name, info, base, members, variants, partial):
         # Nothing to do for the special empty builtin
         if name == 'q_empty':
             return
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 5d72d89..3ee64bb 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -34,7 +34,7 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp);
                  c_name=c_name(name))
 
 
-def gen_visit_object_members(name, base, members, variants):
+def gen_visit_object_members(name, base, members, variants, partial):
     ret = mcgen('''
 
 void visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
@@ -93,9 +93,10 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
 
         ret += mcgen('''
     default:
-        abort();
+        %(action)s
     }
-''')
+''',
+                     action="break;" if partial else "abort();")
 
     # 'goto out' produced for base, for each member, and if variants were
     # present
@@ -309,12 +310,13 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisitor):
         self._genh.add(gen_visit_decl(name))
         self._genc.add(gen_visit_list(name, element_type))
 
-    def visit_object_type(self, name, info, base, members, variants):
+    def visit_object_type(self, name, info, base, members, variants, partial):
         # Nothing to do for the special empty builtin
         if name == 'q_empty':
             return
         self._genh.add(gen_visit_members_decl(name))
-        self._genc.add(gen_visit_object_members(name, base, members, variants))
+        self._genc.add(gen_visit_object_members(name, base, members, variants,
+                                                partial))
         # TODO Worth changing the visitor signature, so we could
         # directly use rather than repeat type.is_implicit()?
         if not name.startswith('q_'):
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index c1a144b..95cd575 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -28,7 +28,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         if prefix:
             print('    prefix %s' % prefix)
 
-    def visit_object_type(self, name, info, base, members, variants):
+    def visit_object_type(self, name, info, base, members, variants, partial):
         print('object %s' % name)
         if base:
             print('    base %s' % base.name)
-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1el8RN-0000j8-B4
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1el8RK-0005vw-M4
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43056 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1el8RK-0005tq-AJ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:14 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 12 Feb 2018 08:22:02 +0100
Message-Id: <20180212072207.9367-10-armbru@redhat.com>
In-Reply-To: <20180212072207.9367-1-armbru@redhat.com>
References: <20180212072207.9367-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 09/14] qapi: Pass ifcond to visitors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py                 | 15 +++++++++++++++
 tests/qapi-schema/qapi-schema-test.out |  9 +++++++++
 tests/qapi-schema/test-qapi.py         | 19 +++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 78aeec785e..692a7ec7c2 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1066,6 +1066,9 @@ class QAPISchemaVisitor(object):
     def visit_include(self, fname, info):
         pass
 
+    def visit_ifcond(self, ifcond, begin):
+        pass
+
     def visit_builtin_type(self, name, info, json_type):
         pass
 
@@ -1792,12 +1795,24 @@ class QAPISchema(object):
     def visit(self, visitor):
         visitor.visit_begin(self)
         module = None
+        ifcond = None
         for entity in self._entity_list:
             if visitor.visit_needed(entity):
                 if entity.module != module:
+                    if ifcond:
+                        visitor.visit_ifcond(ifcond, False)
+                        ifcond = None
                     module = entity.module
                     visitor.visit_module(module)
+                if entity.ifcond != ifcond:
+                    if ifcond:
+                        visitor.visit_ifcond(ifcond, False)
+                    ifcond = entity.ifcond
+                    if ifcond:
+                        visitor.visit_ifcond(ifcond, True)
                 entity.visit(visitor)
+        if ifcond:
+            visitor.visit_ifcond(ifcond, False)
         visitor.visit_end()
 
 
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index b11682314c..8fe9d7a3a8 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -232,23 +232,32 @@ command __org.qemu_x-command q_obj___org.qemu_x-command-arg -> __org.qemu_x-Unio
    gen=True success_response=True boxed=False
 object TestIfStruct
     member foo: int optional=False
+    if ['defined(TEST_IF_STRUCT)']
 enum TestIfEnum ['foo', 'bar']
+    if ['defined(TEST_IF_ENUM)']
 object q_obj_TestStruct-wrapper
     member data: TestStruct optional=False
 enum TestIfUnionKind ['foo']
+    if ['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)']
 object TestIfUnion
     member type: TestIfUnionKind optional=False
     tag type
     case foo: q_obj_TestStruct-wrapper
+    if ['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)']
 alternate TestIfAlternate
     tag type
     case foo: int
     case bar: TestStruct
+    if ['defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)']
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=False
+    if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
 command TestIfCmd q_obj_TestIfCmd-arg -> None
    gen=True success_response=True boxed=False
+    if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
 object q_obj_TestIfEvent-arg
     member foo: TestIfStruct optional=False
+    if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
 event TestIfEvent q_obj_TestIfEvent-arg
    boxed=False
+    if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 67e417e298..fcdbb5b1ea 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -17,16 +17,26 @@ from qapi.common import QAPIError, QAPISchema, QAPISchemaVisitor
 
 class QAPISchemaTestVisitor(QAPISchemaVisitor):
 
+    def __init__(self):
+        self._ifcond = None
+
     def visit_module(self, name):
         print('module %s' % name)
 
     def visit_include(self, name, info):
         print('include %s' % name)
 
+    def visit_ifcond(self, ifcond, begin):
+        if begin:
+            self._ifcond = ifcond
+        else:
+            self._ifcond = None
+
     def visit_enum_type(self, name, info, values, prefix):
         print('enum %s %s' % (name, values))
         if prefix:
             print('    prefix %s' % prefix)
+        self._print_if(self._ifcond)
 
     def visit_object_type(self, name, info, base, members, variants):
         print('object %s' % name)
@@ -36,10 +46,12 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             print('    member %s: %s optional=%s' % \
                   (m.name, m.type.name, m.optional))
         self._print_variants(variants)
+        self._print_if(self._ifcond)
 
     def visit_alternate_type(self, name, info, variants):
         print('alternate %s' % name)
         self._print_variants(variants)
+        self._print_if(self._ifcond)
 
     def visit_command(self, name, info, arg_type, ret_type,
                       gen, success_response, boxed):
@@ -47,10 +59,12 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
               (name, arg_type and arg_type.name, ret_type and ret_type.name))
         print('   gen=%s success_response=%s boxed=%s' % \
               (gen, success_response, boxed))
+        self._print_if(self._ifcond)
 
     def visit_event(self, name, info, arg_type, boxed):
         print('event %s %s' % (name, arg_type and arg_type.name))
         print('   boxed=%s' % boxed)
+        self._print_if(self._ifcond)
 
     @staticmethod
     def _print_variants(variants):
@@ -59,6 +73,11 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             for v in variants.variants:
                 print('    case %s: %s' % (v.name, v.type.name))
 
+    @staticmethod
+    def _print_if(ifcond, indent=4):
+        if ifcond:
+            print('%sif %s' % (' ' * indent, ifcond))
+
 
 try:
     schema = QAPISchema(sys.argv[1])
-- 
2.13.6

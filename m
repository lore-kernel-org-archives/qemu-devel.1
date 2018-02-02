Received: from eggs.gnu.org ([208.118.235.92]:55455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdLH-0002Ua-44
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:34:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdKD-00037R-2w
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:33:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehdKC-00035H-5m
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:32:24 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  2 Feb 2018 14:03:30 +0100
Message-Id: <20180202130336.24719-16-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-1-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 15/21] qapi: Record 'include' directives in
 intermediate representation
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

The include directive permits modular QAPI schemata, but the generated
code is monolithic all the same.  To permit generating modular code,
the front end needs to pass more information on inclusions to the back
ends.  The commit before last added the necessary information to the
parse tree.  This commit adds it to the intermediate representation
and its QAPISchemaVisitor.  A later commit will use this to to
generate modular code.

New entity QAPISchemaInclude represents inclusions.  Call new visitor
method visit_include() for it, so visitors can see the sub-modules a
module includes.

New QAPISchemaEntity attribute @module names the entity's source file.
Call new visitor method visit_module() when it changes during a visit,
so visitors can keep track of the module being visited.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py                   | 44 ++++++++++++++++++++++++++++----
 tests/qapi-schema/comments.out           |  1 +
 tests/qapi-schema/doc-bad-section.out    |  1 +
 tests/qapi-schema/doc-good.out           |  1 +
 tests/qapi-schema/event-case.out         |  1 +
 tests/qapi-schema/ident-with-escape.out  |  1 +
 tests/qapi-schema/include-relpath.out    |  5 ++++
 tests/qapi-schema/include-repetition.out | 10 ++++++++
 tests/qapi-schema/include-simple.out     |  3 +++
 tests/qapi-schema/indented-expr.out      |  1 +
 tests/qapi-schema/qapi-schema-test.out   |  1 +
 tests/qapi-schema/test-qapi.py           |  7 +++++
 12 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 3b97bf8702..f4e9ebbb53 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -981,8 +981,9 @@ def check_exprs(exprs):
 
 class QAPISchemaEntity(object):
     def __init__(self, name, info, doc):
-        assert isinstance(name, str)
+        assert name is None or isinstance(name, str)
         self.name = name
+        self.module = None
         # For explicitly defined entities, info points to the (explicit)
         # definition.  For builtins (and their arrays), info is None.
         # For implicitly defined entities, info points to a place that
@@ -1011,10 +1012,16 @@ class QAPISchemaVisitor(object):
     def visit_end(self):
         pass
 
+    def visit_module(self, fname):
+        pass
+
     def visit_needed(self, entity):
         # Default to visiting everything
         return True
 
+    def visit_include(self, fname, info):
+        pass
+
     def visit_builtin_type(self, name, info, json_type):
         pass
 
@@ -1041,6 +1048,16 @@ class QAPISchemaVisitor(object):
         pass
 
 
+class QAPISchemaInclude(QAPISchemaEntity):
+
+    def __init__(self, fname, info):
+        QAPISchemaEntity.__init__(self, None, info, None)
+        self.fname = fname
+
+    def visit(self, visitor):
+        visitor.visit_include(self.fname, self.info)
+
+
 class QAPISchemaType(QAPISchemaEntity):
     # Return the C type for common use.
     # For the types we commonly box, this is a pointer type.
@@ -1468,6 +1485,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
 
 class QAPISchema(object):
     def __init__(self, fname):
+        self._fname = fname
         parser = QAPISchemaParser(open(fname, 'r'))
         exprs = check_exprs(parser.exprs)
         self.docs = parser.docs
@@ -1475,16 +1493,19 @@ class QAPISchema(object):
         self._entity_dict = {}
         self._predefining = True
         self._def_predefineds()
-        self._predefining = False
         self._def_exprs(exprs)
         self.check()
 
     def _def_entity(self, ent):
         # Only the predefined types are allowed to not have info
         assert ent.info or self._predefining
-        assert ent.name not in self._entity_dict
+        assert ent.name is None or ent.name not in self._entity_dict
         self._entity_list.append(ent)
-        self._entity_dict[ent.name] = ent
+        if ent.name is not None:
+            self._entity_dict[ent.name] = ent
+        if ent.info:
+            ent.module = os.path.relpath(ent.info['file'],
+                                         os.path.dirname(self._fname))
 
     def lookup_entity(self, name, typ=None):
         ent = self._entity_dict.get(name)
@@ -1495,6 +1516,15 @@ class QAPISchema(object):
     def lookup_type(self, name):
         return self.lookup_entity(name, QAPISchemaType)
 
+    def _def_include(self, expr, info, doc):
+        include = expr['include']
+        assert doc is None
+        main_info = info
+        while main_info['parent']:
+            main_info = main_info['parent']
+        fname = os.path.relpath(include, os.path.dirname(main_info['file']))
+        self._def_entity(QAPISchemaInclude(fname, info))
+
     def _def_builtin_type(self, name, json_type, c_type):
         self._def_entity(QAPISchemaBuiltinType(name, json_type, c_type))
         # TODO As long as we have QAPI_TYPES_BUILTIN to share multiple
@@ -1677,7 +1707,7 @@ class QAPISchema(object):
             elif 'event' in expr:
                 self._def_event(expr, info, doc)
             elif 'include' in expr:
-                pass
+                self._def_include(expr, info, doc)
             else:
                 assert False
 
@@ -1687,8 +1717,12 @@ class QAPISchema(object):
 
     def visit(self, visitor):
         visitor.visit_begin(self)
+        module = None
         for entity in self._entity_list:
             if visitor.visit_needed(entity):
+                if entity.module != module:
+                    module = entity.module
+                    visitor.visit_module(module)
                 entity.visit(visitor)
         visitor.visit_end()
 
diff --git a/tests/qapi-schema/comments.out b/tests/qapi-schema/comments.out
index 0261ddf202..8d2f1ce8a2 100644
--- a/tests/qapi-schema/comments.out
+++ b/tests/qapi-schema/comments.out
@@ -1,4 +1,5 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
     prefix QTYPE
+module comments.json
 enum Status ['good', 'bad', 'ugly']
diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/doc-bad-section.out
index 23bf8c71ab..cd28721568 100644
--- a/tests/qapi-schema/doc-bad-section.out
+++ b/tests/qapi-schema/doc-bad-section.out
@@ -1,6 +1,7 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
     prefix QTYPE
+module doc-bad-section.json
 enum Enum ['one', 'two']
 doc symbol=Enum
     body=
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 0c07301f07..430b5a87db 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -1,6 +1,7 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
     prefix QTYPE
+module doc-good.json
 enum Enum ['one', 'two']
 object Base
     member base1: Enum optional=False
diff --git a/tests/qapi-schema/event-case.out b/tests/qapi-schema/event-case.out
index 110571b793..88c0964917 100644
--- a/tests/qapi-schema/event-case.out
+++ b/tests/qapi-schema/event-case.out
@@ -1,5 +1,6 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
     prefix QTYPE
+module event-case.json
 event oops None
    boxed=False
diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/ident-with-escape.out
index 8336aa7629..ee3b34e623 100644
--- a/tests/qapi-schema/ident-with-escape.out
+++ b/tests/qapi-schema/ident-with-escape.out
@@ -1,6 +1,7 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
     prefix QTYPE
+module ident-with-escape.json
 object q_obj_fooA-arg
     member bar1: str optional=False
 command fooA q_obj_fooA-arg -> None
diff --git a/tests/qapi-schema/include-relpath.out b/tests/qapi-schema/include-relpath.out
index 0261ddf202..ebbabd7a18 100644
--- a/tests/qapi-schema/include-relpath.out
+++ b/tests/qapi-schema/include-relpath.out
@@ -1,4 +1,9 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
     prefix QTYPE
+module include-relpath.json
+include include/relpath.json
+module include/relpath.json
+include include-relpath-sub.json
+module include-relpath-sub.json
 enum Status ['good', 'bad', 'ugly']
diff --git a/tests/qapi-schema/include-repetition.out b/tests/qapi-schema/include-repetition.out
index 0261ddf202..7235e055bc 100644
--- a/tests/qapi-schema/include-repetition.out
+++ b/tests/qapi-schema/include-repetition.out
@@ -1,4 +1,14 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
     prefix QTYPE
+module include-repetition.json
+include comments.json
+module comments.json
 enum Status ['good', 'bad', 'ugly']
+module include-repetition.json
+include include-repetition-sub.json
+module include-repetition-sub.json
+include comments.json
+include comments.json
+module include-repetition.json
+include comments.json
diff --git a/tests/qapi-schema/include-simple.out b/tests/qapi-schema/include-simple.out
index 0261ddf202..006f723eeb 100644
--- a/tests/qapi-schema/include-simple.out
+++ b/tests/qapi-schema/include-simple.out
@@ -1,4 +1,7 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
     prefix QTYPE
+module include-simple.json
+include include-simple-sub.json
+module include-simple-sub.json
 enum Status ['good', 'bad', 'ugly']
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/indented-expr.out
index 34de8be426..a79935e8c3 100644
--- a/tests/qapi-schema/indented-expr.out
+++ b/tests/qapi-schema/indented-expr.out
@@ -1,6 +1,7 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
     prefix QTYPE
+module indented-expr.json
 command eins None -> None
    gen=True success_response=True boxed=False
 command zwei None -> None
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 50706b0136..012e7fc06a 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -1,6 +1,7 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
     prefix QTYPE
+module qapi-schema-test.json
 object TestStruct
     member integer: int optional=False
     member boolean: bool optional=False
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index d6bb8ec6a4..2027eef3e5 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -17,6 +17,13 @@ import sys
 
 
 class QAPISchemaTestVisitor(QAPISchemaVisitor):
+
+    def visit_module(self, name):
+        print 'module %s' % name
+
+    def visit_include(self, name, info):
+        print 'include %s' % name
+
     def visit_enum_type(self, name, info, values, prefix):
         print 'enum %s %s' % (name, values)
         if prefix:
-- 
2.13.6

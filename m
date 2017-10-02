Received: from eggs.gnu.org ([2001:4830:134:3::10]:38872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bf-00080s-VN
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2ba-0007vX-D3
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bZ-0007tu-UT
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:02 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:34 +0200
Message-Id: <20171002152552.27999-15-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 14/32] qapi: Rework generated code for
 built-in types
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com
List-ID: <qemu-devel.nongnu.org>

qapi-types.py and qapi-visit.py generate some C code for built-in
types.  To make this work with multiple schemas, we generate code for
built-ins into .c files only when the user asks for it with -b.  The
user is responsible for linking exactly one set of files generated
with -b per program.  We generate code for built-ins into .h
regardless of -b, but guard it with a preprocessor symbol.

This is cumbersome and inflexible.  Move the code generated for
built-in types into separate files builtin-qapi-{types,visit}.{c,h}.
Run qapi-types.py and qapi-visit.py without a schema argument to
generate them.  Drop their option -b.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 .gitignore                               |  2 ++
 Makefile                                 | 18 ++++++++--
 Makefile.objs                            |  1 +
 docs/devel/qapi-code-gen.txt             | 24 +++++++++++--
 qga/Makefile.objs                        |  1 +
 scripts/qapi-introspect.py               |  4 +--
 scripts/qapi-types.py                    | 54 ++++++++++------------------
 scripts/qapi-visit.py                    | 62 ++++++++++++--------------------
 scripts/qapi.py                          | 57 ++++++++++++++++-------------
 scripts/qapi2texi.py                     |  2 +-
 tests/Makefile.include                   |  4 ++-
 tests/qapi-schema/builtins.err           |  0
 tests/qapi-schema/builtins.exit          |  1 +
 tests/qapi-schema/builtins.json          |  1 +
 tests/qapi-schema/builtins.out           |  3 ++
 tests/qapi-schema/comments.out           |  3 --
 tests/qapi-schema/doc-bad-section.out    |  3 --
 tests/qapi-schema/doc-good.out           |  3 --
 tests/qapi-schema/empty.out              |  3 --
 tests/qapi-schema/event-case.out         |  3 --
 tests/qapi-schema/ident-with-escape.out  |  3 --
 tests/qapi-schema/include-relpath.out    |  3 --
 tests/qapi-schema/include-repetition.out |  3 --
 tests/qapi-schema/include-simple.out     |  3 --
 tests/qapi-schema/indented-expr.out      |  3 --
 tests/qapi-schema/qapi-schema-test.out   |  3 --
 tests/qapi-schema/test-qapi.py           |  4 +--
 27 files changed, 127 insertions(+), 144 deletions(-)
 create mode 100644 tests/qapi-schema/builtins.err
 create mode 100644 tests/qapi-schema/builtins.exit
 create mode 100644 tests/qapi-schema/builtins.json
 create mode 100644 tests/qapi-schema/builtins.out

diff --git a/.gitignore b/.gitignore
index 40acfcb9e2..84a57060ad 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,5 @@
+/builtin-qapi-types.[ch]
+/builtin-qapi-visit.[ch]
 /config-devices.*
 /config-all-devices.*
 /config-all-disas.*
diff --git a/Makefile b/Makefile
index 784b601247..421e65d833 100644
--- a/Makefile
+++ b/Makefile
@@ -52,6 +52,8 @@ endif
 include $(SRC_PATH)/rules.mak
 
 GENERATED_FILES = qemu-version.h config-host.h qemu-options.def
+GENERATED_FILES += builtin-qapi-types.h builtin-qapi-types.c
+GENERATED_FILES += builtin-qapi-visit.h builtin-qapi-visit.c
 GENERATED_FILES += qmp-commands.h qapi-types.h qapi-visit.h qapi-event.h
 GENERATED_FILES += qmp-marshal.c qapi-types.c qapi-visit.c qapi-event.c
 GENERATED_FILES += qmp-introspect.h
@@ -428,18 +430,30 @@ qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/transaction.json \
                $(SRC_PATH)/qapi/ui.json
 
+.INTERMEDIATE: builtin-qapi-types-gen
+builtin-qapi-types.c builtin-qapi-types.h: builtin-qapi-types-gen ;
+builtin-qapi-types-gen: $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py, \
+		"GEN","$@")
+
+.INTERMEDIATE: builtin-qapi-visit-gen
+builtin-qapi-visit.c builtin-qapi-visit.h: builtin-qapi-visit-gen ;
+builtin-qapi-visit-gen: $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py, \
+		"GEN","$@")
+
 .INTERMEDIATE: qapi-types-gen
 qapi-types.c qapi-types.h: qapi-types-gen ;
 qapi-types-gen: $(qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
-		-b $<, \
+		$<, \
 		"GEN","$@")
 
 .INTERMEDIATE: qapi-visit-gen
 qapi-visit.c qapi-visit.h: qapi-visit-gen ;
 qapi-visit-gen: $(qapi-modules) $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py \
-		-b $<, \
+		$<, \
 		"GEN","$@")
 
 .INTERMEDIATE: qapi-event-gen
diff --git a/Makefile.objs b/Makefile.objs
index cc4f94d77a..c2c62cb462 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -2,6 +2,7 @@
 # Common libraries for tools and emulators
 stub-obj-y = stubs/ crypto/
 util-obj-y = util/ qobject/ qapi/
+util-obj-y += builtin-qapi-types.o builtin-qapi-visit.o
 util-obj-y += qapi-types.o qapi-visit.o qapi-event.o
 
 chardev-obj-y = chardev/
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 579807f6a5..f5b7659caf 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -937,7 +937,7 @@ supporting code. The following files are created:
 
 $(prefix)qapi-types.h - C types corresponding to types defined in
                         the schema you pass in
-$(prefix)qapi-types.c - Cleanup functions for the above C types
+$(prefix)qapi-types.c - Support code for the above C types
 
 The $(prefix) is an optional parameter used as a namespace to keep the
 generated code from one schema/code-generation separated from others so code
@@ -954,7 +954,7 @@ Example:
     #ifndef EXAMPLE_QAPI_TYPES_H
     #define EXAMPLE_QAPI_TYPES_H
 
-[Built-in types omitted...]
+    #include "builtin-qapi-types.h"
 
     typedef struct UserDefOne UserDefOne;
 
@@ -1011,6 +1011,14 @@ Example:
         visit_free(v);
     }
 
+Type definitions for the built-in types are generated separately, into
+builtin-qapi-types.h and builtin-qapi-types.c.  These are independent
+of the schema.
+
+Example:
+
+    $ python scripts/qapi-types.py --output-dir="qapi-generated"
+
 === scripts/qapi-visit.py ===
 
 Used to generate the visitor functions used to walk through and
@@ -1039,7 +1047,9 @@ Example:
     #ifndef EXAMPLE_QAPI_VISIT_H
     #define EXAMPLE_QAPI_VISIT_H
 
-[Visitors for built-in types omitted...]
+    #include "builtin-qapi-visit.h"
+    #include "example-qapi-types.h"
+
 
     void visit_type_UserDefOne_members(Visitor *v, UserDefOne *obj, Error **errp);
     void visit_type_UserDefOne(Visitor *v, const char *name, UserDefOne **obj, Error **errp);
@@ -1140,6 +1150,14 @@ Example:
         error_propagate(errp, err);
     }
 
+Visitor functions for the built-in types are generated separately,
+into builtin-qapi-visit.h and builtin-qapi-visit.c.  These are
+independent of the schema.
+
+Example:
+
+    $ python scripts/qapi-visit.py --output-dir="qapi-generated"
+
 === scripts/qapi-commands.py ===
 
 Used to generate the marshaling/dispatch functions for the commands
diff --git a/qga/Makefile.objs b/qga/Makefile.objs
index 1c5986c0bb..1430655fbe 100644
--- a/qga/Makefile.objs
+++ b/qga/Makefile.objs
@@ -2,6 +2,7 @@ qga-obj-y = commands.o guest-agent-command-state.o main.o
 qga-obj-$(CONFIG_POSIX) += commands-posix.o channel-posix.o
 qga-obj-$(CONFIG_WIN32) += commands-win32.o channel-win32.o service-win32.o
 qga-obj-$(CONFIG_WIN32) += vss-win32.o
+qga-obj-y += ../builtin-qapi-types.o ../builtin-qapi-visit.o
 qga-obj-y += qapi-generated/qga-qapi-types.o qapi-generated/qga-qapi-visit.o
 qga-obj-y += qapi-generated/qga-qmp-marshal.o
 
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index ad87fc57e3..cc4ff01cd4 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -60,7 +60,7 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaVisitor):
         jsons = self._jsons
         self._jsons = []
         for typ in self._used_types:
-            typ.visit(self)
+            typ.visit(self, builtins=True)
         # generate C
         # TODO can generate awfully long lines
         jsons.extend(self._jsons)
@@ -208,7 +208,7 @@ fdef.write(mcgen('''
 
 schema = QAPISchema(args.schema)
 gen = QAPISchemaGenIntrospectVisitor(args.unmask_non_abi_names)
-schema.visit(gen)
+schema.visit(gen, builtins=True)
 fdef.write(gen.defn)
 fdecl.write(gen.decl)
 
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index ed05d828bf..18fd2a98c0 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -170,7 +170,6 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         self.decl = None
         self.defn = None
         self._fwdecl = None
-        self._btin = None
 
     def visit_begin(self, schema):
         # gen_object() is recursive, ensure it doesn't visit the empty type
@@ -178,45 +177,23 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         self.decl = ''
         self.defn = ''
         self._fwdecl = ''
-        self._btin = guardstart('QAPI_TYPES_BUILTIN')
 
     def visit_end(self):
         self.decl = self._fwdecl + self.decl
         self._fwdecl = None
-        # To avoid header dependency hell, we always generate
-        # declarations for built-in types in our header files and
-        # simply guard them.  See also args.builtins (command line
-        # option -b).
-        self._btin += guardend('QAPI_TYPES_BUILTIN')
-        self.decl = self._btin + self.decl
-        self._btin = None
 
     def _gen_type_cleanup(self, name):
         self.decl += gen_type_cleanup_decl(name)
         self.defn += gen_type_cleanup(name)
 
     def visit_enum_type(self, name, info, values, prefix):
-        # Special case for our lone builtin enum type
-        # TODO use something cleaner than existence of info
-        if not info:
-            self._btin += gen_enum(name, values, prefix)
-            if args.builtins:
-                self.defn += gen_enum_lookup(name, values, prefix)
-        else:
-            self._fwdecl += gen_enum(name, values, prefix)
-            self.defn += gen_enum_lookup(name, values, prefix)
+        self._fwdecl += gen_enum(name, values, prefix)
+        self.defn += gen_enum_lookup(name, values, prefix)
 
     def visit_array_type(self, name, info, element_type):
-        if isinstance(element_type, QAPISchemaBuiltinType):
-            self._btin += gen_fwd_object_or_array(name)
-            self._btin += gen_array(name, element_type)
-            self._btin += gen_type_cleanup_decl(name)
-            if args.builtins:
-                self.defn += gen_type_cleanup(name)
-        else:
-            self._fwdecl += gen_fwd_object_or_array(name)
-            self.decl += gen_array(name, element_type)
-            self._gen_type_cleanup(name)
+        self._fwdecl += gen_fwd_object_or_array(name)
+        self.decl += gen_array(name, element_type)
+        self._gen_type_cleanup(name)
 
     def visit_object_type(self, name, info, base, members, variants):
         # Nothing to do for the special empty builtin
@@ -237,12 +214,12 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         self.decl += gen_object(name, None, [variants.tag_member], variants)
         self._gen_type_cleanup(name)
 
-# If you link code generated from multiple schemata, you want only one
-# instance of the code for built-in types.  Generate it only when
-# args.builtins, enabled by command line option -b.  See also
-# QAPISchemaGenTypeVisitor.visit_end().
-
-args = common_argument_parser(builtins=True).parse_args()
+argparser = common_argument_parser(builtins=True)
+args = argparser.parse_args()
+if not args.schema:
+    if args.prefix:
+        argparser.error('schema required with -p')
+    args.prefix = 'builtin-'
 
 c_comment = '''
 /*
@@ -286,13 +263,18 @@ fdef.write(mcgen('''
 ''',
                  prefix=args.prefix))
 
-fdecl.write(mcgen('''
+if args.schema:
+    fdecl.write(mcgen('''
+#include "builtin-qapi-types.h"
+'''))
+else:
+    fdecl.write(mcgen('''
 #include "qapi/util.h"
 '''))
 
 schema = QAPISchema(args.schema)
 gen = QAPISchemaGenTypeVisitor()
-schema.visit(gen)
+schema.visit(gen, builtins=not args.schema)
 fdef.write(gen.defn)
 fdecl.write(gen.decl)
 
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 010d68434f..e756ef98ee 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -266,43 +266,18 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
     def __init__(self):
         self.decl = None
         self.defn = None
-        self._btin = None
 
     def visit_begin(self, schema):
         self.decl = ''
         self.defn = ''
-        self._btin = guardstart('QAPI_VISIT_BUILTIN')
-
-    def visit_end(self):
-        # To avoid header dependency hell, we always generate
-        # declarations for built-in types in our header files and
-        # simply guard them.  See also args.builtins (command line
-        # option -b).
-        self._btin += guardend('QAPI_VISIT_BUILTIN')
-        self.decl = self._btin + self.decl
-        self._btin = None
 
     def visit_enum_type(self, name, info, values, prefix):
-        # Special case for our lone builtin enum type
-        # TODO use something cleaner than existence of info
-        if not info:
-            self._btin += gen_visit_decl(name, scalar=True)
-            if args.builtins:
-                self.defn += gen_visit_enum(name)
-        else:
-            self.decl += gen_visit_decl(name, scalar=True)
-            self.defn += gen_visit_enum(name)
+        self.decl += gen_visit_decl(name, scalar=True)
+        self.defn += gen_visit_enum(name)
 
     def visit_array_type(self, name, info, element_type):
-        decl = gen_visit_decl(name)
-        defn = gen_visit_list(name, element_type)
-        if isinstance(element_type, QAPISchemaBuiltinType):
-            self._btin += decl
-            if args.builtins:
-                self.defn += defn
-        else:
-            self.decl += decl
-            self.defn += defn
+        self.decl += gen_visit_decl(name)
+        self.defn += gen_visit_list(name, element_type)
 
     def visit_object_type(self, name, info, base, members, variants):
         # Nothing to do for the special empty builtin
@@ -321,12 +296,12 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         self.decl += gen_visit_decl(name)
         self.defn += gen_visit_alternate(name, variants)
 
-# If you link code generated from multiple schemata, you want only one
-# instance of the code for built-in types.  Generate it only when
-# args.builtins, enabled by command line option -b.  See also
-# QAPISchemaGenVisitVisitor.visit_end().
-
-args = common_argument_parser(builtins=True).parse_args()
+argparser = common_argument_parser(builtins=True)
+args = argparser.parse_args()
+if not args.schema:
+    if args.prefix:
+        argparser.error('schema required with -p')
+    args.prefix = 'builtin-'
 
 c_comment = '''
 /*
@@ -369,17 +344,24 @@ fdef.write(mcgen('''
 ''',
                  prefix=args.prefix))
 
-fdecl.write(mcgen('''
+if args.schema:
+    fdecl.write(mcgen('''
+#include "builtin-qapi-visit.h"
+#include "%(prefix)sqapi-types.h"
+
+''',
+                      prefix=args.prefix))
+else:
+    fdecl.write(mcgen('''
 #include "qapi/visitor.h"
 #include "qapi/qmp/qerror.h"
-#include "%(prefix)sqapi-types.h"
+#include "builtin-qapi-types.h"
 
-''',
-                  prefix=args.prefix))
+'''))
 
 schema = QAPISchema(args.schema)
 gen = QAPISchemaGenVisitVisitor()
-schema.visit(gen)
+schema.visit(gen, builtins=not args.schema)
 fdef.write(gen.defn)
 fdecl.write(gen.decl)
 
diff --git a/scripts/qapi.py b/scripts/qapi.py
index a33203e82d..248d650858 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -983,7 +983,7 @@ class QAPISchemaEntity(object):
     def is_implicit(self):
         return not self.info
 
-    def visit(self, visitor):
+    def visit(self, visitor, builtins):
         pass
 
 
@@ -1084,8 +1084,9 @@ class QAPISchemaBuiltinType(QAPISchemaType):
     def doc_type(self):
         return self.json_type()
 
-    def visit(self, visitor):
-        visitor.visit_builtin_type(self.name, self.info, self.json_type())
+    def visit(self, visitor, builtins):
+        if builtins:
+            visitor.visit_builtin_type(self.name, self.info, self.json_type())
 
 
 class QAPISchemaEnumType(QAPISchemaType):
@@ -1118,9 +1119,11 @@ class QAPISchemaEnumType(QAPISchemaType):
     def json_type(self):
         return 'string'
 
-    def visit(self, visitor):
-        visitor.visit_enum_type(self.name, self.info,
-                                self.member_names(), self.prefix)
+    def visit(self, visitor, builtins):
+        # TODO use something cleaner than existence of info
+        if builtins or self.info:
+            visitor.visit_enum_type(self.name, self.info,
+                                    self.member_names(), self.prefix)
 
 
 class QAPISchemaArrayType(QAPISchemaType):
@@ -1149,8 +1152,10 @@ class QAPISchemaArrayType(QAPISchemaType):
             return None
         return 'array of ' + elt_doc_type
 
-    def visit(self, visitor):
-        visitor.visit_array_type(self.name, self.info, self.element_type)
+    def visit(self, visitor, builtins):
+        if builtins or not isinstance(self.element_type,
+                                      QAPISchemaBuiltinType):
+            visitor.visit_array_type(self.name, self.info, self.element_type)
 
 
 class QAPISchemaObjectType(QAPISchemaType):
@@ -1229,11 +1234,13 @@ class QAPISchemaObjectType(QAPISchemaType):
     def json_type(self):
         return 'object'
 
-    def visit(self, visitor):
-        visitor.visit_object_type(self.name, self.info,
-                                  self.base, self.local_members, self.variants)
-        visitor.visit_object_type_flat(self.name, self.info,
-                                       self.members, self.variants)
+    def visit(self, visitor, builtins):
+        # TODO use something cleaner than existence of info
+        if builtins or self.info:
+            visitor.visit_object_type(self.name, self.info, self.base,
+                                      self.local_members, self.variants)
+            visitor.visit_object_type_flat(self.name, self.info,
+                                           self.members, self.variants)
 
 
 class QAPISchemaMember(object):
@@ -1375,7 +1382,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
     def json_type(self):
         return 'value'
 
-    def visit(self, visitor):
+    def visit(self, visitor, builtins):
         visitor.visit_alternate_type(self.name, self.info, self.variants)
 
     def is_empty(self):
@@ -1415,7 +1422,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
             self.ret_type = schema.lookup_type(self._ret_type_name)
             assert isinstance(self.ret_type, QAPISchemaType)
 
-    def visit(self, visitor):
+    def visit(self, visitor, builtins):
         visitor.visit_command(self.name, self.info,
                               self.arg_type, self.ret_type,
                               self.gen, self.success_response, self.boxed)
@@ -1445,16 +1452,20 @@ class QAPISchemaEvent(QAPISchemaEntity):
         elif self.boxed:
             raise QAPISemError(self.info, "Use of 'boxed' requires 'data'")
 
-    def visit(self, visitor):
+    def visit(self, visitor, builtins):
         visitor.visit_event(self.name, self.info, self.arg_type, self.boxed)
 
 
 class QAPISchema(object):
     def __init__(self, file):
         try:
-            parser = QAPISchemaParser(file)
-            self.exprs = check_exprs(parser.exprs)
-            self.docs = parser.docs
+            if file:
+                parser = QAPISchemaParser(file)
+                self.exprs = check_exprs(parser.exprs)
+                self.docs = parser.docs
+            else:
+                self.exprs = []
+                self.docs = []
             self._entity_dict = {}
             self._predefining = True
             self._def_predefineds()
@@ -1668,11 +1679,11 @@ class QAPISchema(object):
         for ent in self._entity_dict.values():
             ent.check(self)
 
-    def visit(self, visitor):
+    def visit(self, visitor, builtins=False):
         visitor.visit_begin(self)
         for (name, entity) in sorted(self._entity_dict.items()):
             if visitor.visit_needed(entity):
-                entity.visit(visitor)
+                entity.visit(visitor, builtins)
         visitor.visit_end()
 
 
@@ -1927,14 +1938,12 @@ def common_argument_parser(builtins=False):
         return string
 
     parser = argparse.ArgumentParser(conflict_handler='resolve')
-    if builtins:
-        parser.add_argument('-b', '--builtins', action='store_true',
-                            help='generate builtins')
     parser.add_argument('-o', '--output-dir', default='',
                         help='output directory')
     parser.add_argument('-p', '--prefix', default='', type=prefix,
                         help='prefix to add to output files')
     parser.add_argument('schema', type=argparse.FileType('r'),
+                        nargs='?' if builtins else None,
                         help='QAPI schema source file')
     return parser
 
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index d95d7541a3..071abc9d5d 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -257,7 +257,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
         if self.out:
             self.out += '\n'
         self.cur_doc = doc
-        entity.visit(self)
+        entity.visit(self, builtins=False)
         self.cur_doc = None
 
     def freeform(self, doc):
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5d53c58506..2ef5dc51f1 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -371,6 +371,7 @@ check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
 check-qtest-generic-y += tests/qom-test$(EXESUF)
 check-qtest-generic-y += tests/test-hmp$(EXESUF)
 
+qapi-schema += builtins.json
 qapi-schema += alternate-any.json
 qapi-schema += alternate-array.json
 qapi-schema += alternate-base.json
@@ -910,7 +911,8 @@ check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-img$(EXESUF)
 $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH)/%.json
 	$(call quiet-command, PYTHONPATH=$(SRC_PATH)/scripts \
 		$(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
-		$^ >$*.test.out 2>$*.test.err; \
+		`echo "$^" | sed '/builtins/d'` \
+		>$*.test.out 2>$*.test.err; \
 		echo $$? >$*.test.exit, \
 		"TEST","$*.out")
 	@diff -q $(SRC_PATH)/$*.out $*.test.out
diff --git a/tests/qapi-schema/builtins.err b/tests/qapi-schema/builtins.err
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/builtins.exit b/tests/qapi-schema/builtins.exit
new file mode 100644
index 0000000000..573541ac97
--- /dev/null
+++ b/tests/qapi-schema/builtins.exit
@@ -0,0 +1 @@
+0
diff --git a/tests/qapi-schema/builtins.json b/tests/qapi-schema/builtins.json
new file mode 100644
index 0000000000..c4088f6792
--- /dev/null
+++ b/tests/qapi-schema/builtins.json
@@ -0,0 +1 @@
+# This file exists to simplify make's job, it's not actually read
diff --git a/tests/qapi-schema/builtins.out b/tests/qapi-schema/builtins.out
new file mode 100644
index 0000000000..40b886ddae
--- /dev/null
+++ b/tests/qapi-schema/builtins.out
@@ -0,0 +1,3 @@
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
+    prefix QTYPE
+object q_empty
diff --git a/tests/qapi-schema/comments.out b/tests/qapi-schema/comments.out
index 17e652535c..6161b90e91 100644
--- a/tests/qapi-schema/comments.out
+++ b/tests/qapi-schema/comments.out
@@ -1,4 +1 @@
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
-    prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
-object q_empty
diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/doc-bad-section.out
index 089bde1381..a2f0842130 100644
--- a/tests/qapi-schema/doc-bad-section.out
+++ b/tests/qapi-schema/doc-bad-section.out
@@ -1,7 +1,4 @@
 enum Enum ['one', 'two']
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
-    prefix QTYPE
-object q_empty
 doc symbol=Enum
     body=
 == Produces *invalid* texinfo
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index f0ba51db4b..f609c5d5f5 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -6,8 +6,6 @@ object Object
     tag base1
     case one: Variant1
     case two: Variant2
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
-    prefix QTYPE
 object SugaredUnion
     member type: SugaredUnionKind optional=False
     tag type
@@ -21,7 +19,6 @@ command cmd q_obj_cmd-arg -> Object
    gen=True success_response=True boxed=False
 command cmd-boxed Object -> None
    gen=True success_response=True boxed=True
-object q_empty
 object q_obj_Variant1-wrapper
     member data: Variant1 optional=False
 object q_obj_Variant2-wrapper
diff --git a/tests/qapi-schema/empty.out b/tests/qapi-schema/empty.out
index 40b886ddae..e69de29bb2 100644
--- a/tests/qapi-schema/empty.out
+++ b/tests/qapi-schema/empty.out
@@ -1,3 +0,0 @@
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
-    prefix QTYPE
-object q_empty
diff --git a/tests/qapi-schema/event-case.out b/tests/qapi-schema/event-case.out
index 313c0fe7be..0c3a3b5ba2 100644
--- a/tests/qapi-schema/event-case.out
+++ b/tests/qapi-schema/event-case.out
@@ -1,5 +1,2 @@
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
-    prefix QTYPE
 event oops None
    boxed=False
-object q_empty
diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/ident-with-escape.out
index b5637cb2e0..89fe61f9e9 100644
--- a/tests/qapi-schema/ident-with-escape.out
+++ b/tests/qapi-schema/ident-with-escape.out
@@ -1,7 +1,4 @@
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
-    prefix QTYPE
 command fooA q_obj_fooA-arg -> None
    gen=True success_response=True boxed=False
-object q_empty
 object q_obj_fooA-arg
     member bar1: str optional=False
diff --git a/tests/qapi-schema/include-relpath.out b/tests/qapi-schema/include-relpath.out
index 17e652535c..6161b90e91 100644
--- a/tests/qapi-schema/include-relpath.out
+++ b/tests/qapi-schema/include-relpath.out
@@ -1,4 +1 @@
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
-    prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
-object q_empty
diff --git a/tests/qapi-schema/include-repetition.out b/tests/qapi-schema/include-repetition.out
index 17e652535c..6161b90e91 100644
--- a/tests/qapi-schema/include-repetition.out
+++ b/tests/qapi-schema/include-repetition.out
@@ -1,4 +1 @@
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
-    prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
-object q_empty
diff --git a/tests/qapi-schema/include-simple.out b/tests/qapi-schema/include-simple.out
index 17e652535c..6161b90e91 100644
--- a/tests/qapi-schema/include-simple.out
+++ b/tests/qapi-schema/include-simple.out
@@ -1,4 +1 @@
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
-    prefix QTYPE
 enum Status ['good', 'bad', 'ugly']
-object q_empty
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/indented-expr.out
index 586795f44d..bfdc976854 100644
--- a/tests/qapi-schema/indented-expr.out
+++ b/tests/qapi-schema/indented-expr.out
@@ -1,7 +1,4 @@
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
-    prefix QTYPE
 command eins None -> None
    gen=True success_response=True boxed=False
-object q_empty
 command zwei None -> None
    gen=True success_response=True boxed=False
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 3b1e9082d3..4b42db23b2 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -50,8 +50,6 @@ object NestedEnumsOne
     member enum4: EnumOne optional=True
 enum QEnumTwo ['value1', 'value2']
     prefix QENUM_TWO
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
-    prefix QTYPE
 object TestStruct
     member integer: int optional=False
     member boolean: bool optional=False
@@ -162,7 +160,6 @@ command guest-get-time q_obj_guest-get-time-arg -> int
    gen=True success_response=True boxed=False
 command guest-sync q_obj_guest-sync-arg -> any
    gen=True success_response=True boxed=False
-object q_empty
 object q_obj_EVENT_C-arg
     member a: int optional=True
     member b: UserDefOne optional=True
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 225417d861..0294a66619 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -53,12 +53,12 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
                 print '    case %s: %s' % (v.name, v.type.name)
 
 parser = argparse.ArgumentParser()
-parser.add_argument('schema', type=argparse.FileType('r'),
+parser.add_argument('schema', type=argparse.FileType('r'), nargs='?',
                     help='QAPI schema source file')
 args = parser.parse_args()
 
 schema = QAPISchema(args.schema)
-schema.visit(QAPISchemaTestVisitor())
+schema.visit(QAPISchemaTestVisitor(), builtins=not args.schema)
 
 for doc in schema.docs:
     if doc.symbol:
-- 
2.13.6

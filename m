Received: from eggs.gnu.org ([2001:4830:134:3::10]:54191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3i-00077b-EM
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3X-0006Kp-0k
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54012 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eko3W-0006JX-M6
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:18 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 11 Feb 2018 10:35:57 +0100
Message-Id: <20180211093607.27351-20-armbru@redhat.com>
In-Reply-To: <20180211093607.27351-1-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 19/29] qapi: Make code-generating visitors
 use QAPIGen more
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

The use of QAPIGen is rather shallow so far: most of the output
accumulation is not converted.  Take the next step: convert output
accumulation in the code-generating visitor classes.  Helper functions
outside these classes are not converted.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/commands.py   | 71 ++++++++++++++++------------------------
 scripts/qapi/common.py     | 13 ++++++++
 scripts/qapi/doc.py        | 74 ++++++++++++++++++++----------------------
 scripts/qapi/events.py     | 55 ++++++++++++-------------------
 scripts/qapi/introspect.py | 56 +++++++++++++-------------------
 scripts/qapi/types.py      | 81 +++++++++++++++++++---------------------------
 scripts/qapi/visit.py      | 80 +++++++++++++++++++--------------------------
 7 files changed, 188 insertions(+), 242 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 05fe33a03b..46757db771 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -223,44 +223,15 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)
     return ret
 
 
-class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
+class QAPISchemaGenCommandVisitor(QAPISchemaMonolithicCVisitor):
+
     def __init__(self, prefix):
-        self._prefix = prefix
-        self.decl = None
-        self.defn = None
-        self._regy = None
-        self._visited_ret_types = None
-
-    def visit_begin(self, schema):
-        self.decl = ''
-        self.defn = ''
+        QAPISchemaMonolithicCVisitor.__init__(
+            self, prefix, 'qmp-commands',
+            ' * Schema-defined QAPI/QMP commands', __doc__)
         self._regy = ''
         self._visited_ret_types = set()
-
-    def visit_end(self):
-        self.defn += gen_registry(self._regy, self._prefix)
-        self._regy = None
-        self._visited_ret_types = None
-
-    def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
-        if not gen:
-            return
-        self.decl += gen_command_decl(name, arg_type, boxed, ret_type)
-        if ret_type and ret_type not in self._visited_ret_types:
-            self._visited_ret_types.add(ret_type)
-            self.defn += gen_marshal_output(ret_type)
-        self.decl += gen_marshal_decl(name)
-        self.defn += gen_marshal(name, arg_type, boxed, ret_type)
-        self._regy += gen_register_command(name, success_response)
-
-
-def gen_commands(schema, output_dir, prefix):
-    blurb = ' * Schema-defined QAPI/QMP commands'
-    genc = QAPIGenC(blurb, __doc__)
-    genh = QAPIGenH(blurb, __doc__)
-
-    genc.add(mcgen('''
+        self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/module.h"
@@ -275,19 +246,33 @@ def gen_commands(schema, output_dir, prefix):
 #include "%(prefix)sqmp-commands.h"
 
 ''',
-                   prefix=prefix))
-
-    genh.add(mcgen('''
+                             prefix=prefix))
+        self._genh.add(mcgen('''
 #include "%(prefix)sqapi-types.h"
 #include "qapi/qmp/dispatch.h"
 
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
 ''',
-                   prefix=prefix, c_prefix=c_name(prefix, protect=False)))
+                             prefix=prefix,
+                             c_prefix=c_name(prefix, protect=False)))
 
+    def visit_end(self):
+        self._genc.add(gen_registry(self._regy, self._prefix))
+
+    def visit_command(self, name, info, arg_type, ret_type,
+                      gen, success_response, boxed):
+        if not gen:
+            return
+        self._genh.add(gen_command_decl(name, arg_type, boxed, ret_type))
+        if ret_type and ret_type not in self._visited_ret_types:
+            self._visited_ret_types.add(ret_type)
+            self._genc.add(gen_marshal_output(ret_type))
+        self._genh.add(gen_marshal_decl(name))
+        self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
+        self._regy += gen_register_command(name, success_response)
+
+
+def gen_commands(schema, output_dir, prefix):
     vis = QAPISchemaGenCommandVisitor(prefix)
     schema.visit(vis)
-    genc.add(vis.defn)
-    genh.add(vis.decl)
-    genc.write(output_dir, prefix + 'qmp-commands.c')
-    genh.write(output_dir, prefix + 'qmp-commands.h')
+    vis.write(output_dir)
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 29d98ca934..31d2f73e7e 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -2049,3 +2049,16 @@ class QAPIGenDoc(QAPIGen):
     def _top(self, fname):
         return (QAPIGen._top(self, fname)
                 + '@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n\n')
+
+
+class QAPISchemaMonolithicCVisitor(QAPISchemaVisitor):
+
+    def __init__(self, prefix, what, blurb, pydoc):
+        self._prefix = prefix
+        self._what = what
+        self._genc = QAPIGenC(blurb, pydoc)
+        self._genh = QAPIGenH(blurb, pydoc)
+
+    def write(self, output_dir):
+        self._genc.write(output_dir, self._prefix + self._what + '.c')
+        self._genh.write(output_dir, self._prefix + self._what + '.h')
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index cc4d5a43fb..0ea68bf813 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -197,33 +197,35 @@ def texi_entity(doc, what, base=None, variants=None,
 
 
 class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaVisitor):
-    def __init__(self):
-        self.out = None
+    def __init__(self, prefix):
+        self._prefix = prefix
+        self._gen = qapi.common.QAPIGenDoc()
         self.cur_doc = None
 
-    def visit_begin(self, schema):
-        self.out = ''
+    def write(self, output_dir):
+        self._gen.write(output_dir, self._prefix + 'qapi-doc.texi')
 
     def visit_enum_type(self, name, info, values, prefix):
         doc = self.cur_doc
-        self.out += TYPE_FMT(type='Enum',
-                             name=doc.symbol,
-                             body=texi_entity(doc, 'Values',
-                                              member_func=texi_enum_value))
+        self._gen.add(TYPE_FMT(type='Enum',
+                               name=doc.symbol,
+                               body=texi_entity(doc, 'Values',
+                                                member_func=texi_enum_value)))
 
     def visit_object_type(self, name, info, base, members, variants):
         doc = self.cur_doc
         if base and base.is_implicit():
             base = None
-        self.out += TYPE_FMT(type='Object',
-                             name=doc.symbol,
-                             body=texi_entity(doc, 'Members', base, variants))
+        self._gen.add(TYPE_FMT(type='Object',
+                               name=doc.symbol,
+                               body=texi_entity(doc, 'Members',
+                                                base, variants)))
 
     def visit_alternate_type(self, name, info, variants):
         doc = self.cur_doc
-        self.out += TYPE_FMT(type='Alternate',
-                             name=doc.symbol,
-                             body=texi_entity(doc, 'Members'))
+        self._gen.add(TYPE_FMT(type='Alternate',
+                               name=doc.symbol,
+                               body=texi_entity(doc, 'Members')))
 
     def visit_command(self, name, info, arg_type, ret_type,
                       gen, success_response, boxed):
@@ -235,44 +237,38 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaVisitor):
             body += texi_sections(doc)
         else:
             body = texi_entity(doc, 'Arguments')
-        self.out += MSG_FMT(type='Command',
-                            name=doc.symbol,
-                            body=body)
+        self._gen.add(MSG_FMT(type='Command',
+                              name=doc.symbol,
+                              body=body))
 
     def visit_event(self, name, info, arg_type, boxed):
         doc = self.cur_doc
-        self.out += MSG_FMT(type='Event',
-                            name=doc.symbol,
-                            body=texi_entity(doc, 'Arguments'))
+        self._gen.add(MSG_FMT(type='Event',
+                              name=doc.symbol,
+                              body=texi_entity(doc, 'Arguments')))
 
     def symbol(self, doc, entity):
-        if self.out:
-            self.out += '\n'
+        if self._gen._body:
+            self._gen.add('\n')
         self.cur_doc = doc
         entity.visit(self)
         self.cur_doc = None
 
     def freeform(self, doc):
         assert not doc.args
-        if self.out:
-            self.out += '\n'
-        self.out += texi_body(doc) + texi_sections(doc)
+        if self._gen._body:
+            self._gen.add('\n')
+        self._gen.add(texi_body(doc) + texi_sections(doc))
 
 
-def texi_schema(schema):
-    """Convert QAPI schema documentation to Texinfo"""
-    gen = QAPISchemaGenDocVisitor()
-    gen.visit_begin(schema)
+def gen_doc(schema, output_dir, prefix):
+    if not qapi.common.doc_required:
+        return
+    vis = QAPISchemaGenDocVisitor(prefix)
+    vis.visit_begin(schema)
     for doc in schema.docs:
         if doc.symbol:
-            gen.symbol(doc, schema.lookup_entity(doc.symbol))
+            vis.symbol(doc, schema.lookup_entity(doc.symbol))
         else:
-            gen.freeform(doc)
-    return gen.out
-
-
-def gen_doc(schema, output_dir, prefix):
-    if qapi.common.doc_required:
-        gen = qapi.common.QAPIGenDoc()
-        gen.add(texi_schema(schema))
-        gen.write(output_dir, prefix + 'qapi-doc.texi')
+            vis.freeform(doc)
+    vis.write(output_dir)
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index b7dc82004f..81ab3abb30 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -148,35 +148,15 @@ out:
     return ret
 
 
-class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
+class QAPISchemaGenEventVisitor(QAPISchemaMonolithicCVisitor):
+
     def __init__(self, prefix):
+        QAPISchemaMonolithicCVisitor.__init__(
+            self, prefix, 'qapi-event',
+            ' * Schema-defined QAPI/QMP events', __doc__)
         self._enum_name = c_name(prefix + 'QAPIEvent', protect=False)
-        self.decl = None
-        self.defn = None
-        self._event_names = None
-
-    def visit_begin(self, schema):
-        self.decl = ''
-        self.defn = ''
         self._event_names = []
-
-    def visit_end(self):
-        self.decl += gen_enum(self._enum_name, self._event_names)
-        self.defn += gen_enum_lookup(self._enum_name, self._event_names)
-        self._event_names = None
-
-    def visit_event(self, name, info, arg_type, boxed):
-        self.decl += gen_event_send_decl(name, arg_type, boxed)
-        self.defn += gen_event_send(name, arg_type, boxed, self._enum_name)
-        self._event_names.append(name)
-
-
-def gen_events(schema, output_dir, prefix):
-    blurb = ' * Schema-defined QAPI/QMP events'
-    genc = QAPIGenC(blurb, __doc__)
-    genh = QAPIGenH(blurb, __doc__)
-
-    genc.add(mcgen('''
+        self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "%(prefix)sqapi-event.h"
@@ -187,18 +167,25 @@ def gen_events(schema, output_dir, prefix):
 #include "qapi/qmp-event.h"
 
 ''',
-                   prefix=prefix))
-
-    genh.add(mcgen('''
+                             prefix=prefix))
+        self._genh.add(mcgen('''
 #include "qapi/util.h"
 #include "%(prefix)sqapi-types.h"
 
 ''',
-                   prefix=prefix))
+                             prefix=prefix))
 
+    def visit_end(self):
+        self._genh.add(gen_enum(self._enum_name, self._event_names))
+        self._genc.add(gen_enum_lookup(self._enum_name, self._event_names))
+
+    def visit_event(self, name, info, arg_type, boxed):
+        self._genh.add(gen_event_send_decl(name, arg_type, boxed))
+        self._genc.add(gen_event_send(name, arg_type, boxed, self._enum_name))
+        self._event_names.append(name)
+
+
+def gen_events(schema, output_dir, prefix):
     vis = QAPISchemaGenEventVisitor(prefix)
     schema.visit(vis)
-    genc.add(vis.defn)
-    genh.add(vis.decl)
-    genc.write(output_dir, prefix + 'qapi-event.c')
-    genh.write(output_dir, prefix + 'qapi-event.h')
+    vis.write(output_dir)
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 1e4f065164..f571cc134c 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -40,22 +40,26 @@ def to_c_string(string):
     return '"' + string.replace('\\', r'\\').replace('"', r'\"') + '"'
 
 
-class QAPISchemaGenIntrospectVisitor(QAPISchemaVisitor):
+class QAPISchemaGenIntrospectVisitor(QAPISchemaMonolithicCVisitor):
+
     def __init__(self, prefix, unmask):
-        self._prefix = prefix
+        QAPISchemaMonolithicCVisitor.__init__(
+            self, prefix, 'qmp-introspect',
+            ' * QAPI/QMP schema introspection', __doc__)
         self._unmask = unmask
-        self.defn = None
-        self.decl = None
         self._schema = None
-        self._jsons = None
-        self._used_types = None
-        self._name_map = None
+        self._jsons = []
+        self._used_types = []
+        self._name_map = {}
+        self._genc.add(mcgen('''
+#include "qemu/osdep.h"
+#include "%(prefix)sqmp-introspect.h"
+
+''',
+                             prefix=prefix))
 
     def visit_begin(self, schema):
         self._schema = schema
-        self._jsons = []
-        self._used_types = []
-        self._name_map = {}
 
     def visit_end(self):
         # visit the types that are actually used
@@ -67,21 +71,21 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaVisitor):
         # TODO can generate awfully long lines
         jsons.extend(self._jsons)
         name = c_name(self._prefix, protect=False) + 'qmp_schema_json'
-        self.decl = mcgen('''
+        self._genh.add(mcgen('''
 extern const char %(c_name)s[];
 ''',
-                          c_name=c_name(name))
+                             c_name=c_name(name)))
         lines = to_json(jsons).split('\n')
         c_string = '\n    '.join([to_c_string(line) for line in lines])
-        self.defn = mcgen('''
+        self._genc.add(mcgen('''
 const char %(c_name)s[] = %(c_string)s;
 ''',
-                          c_name=c_name(name),
-                          c_string=c_string)
+                             c_name=c_name(name),
+                             c_string=c_string))
         self._schema = None
-        self._jsons = None
-        self._used_types = None
-        self._name_map = None
+        self._jsons = []
+        self._used_types = []
+        self._name_map = {}
 
     def visit_needed(self, entity):
         # Ignore types on first pass; visit_end() will pick up used types
@@ -169,20 +173,6 @@ const char %(c_name)s[] = %(c_string)s;
 
 
 def gen_introspect(schema, output_dir, prefix, opt_unmask):
-    blurb = ' * QAPI/QMP schema introspection'
-    genc = QAPIGenC(blurb, __doc__)
-    genh = QAPIGenH(blurb, __doc__)
-
-    genc.add(mcgen('''
-#include "qemu/osdep.h"
-#include "%(prefix)sqmp-introspect.h"
-
-''',
-                   prefix=prefix))
-
     vis = QAPISchemaGenIntrospectVisitor(prefix, opt_unmask)
     schema.visit(vis)
-    genc.add(vis.defn)
-    genh.add(vis.decl)
-    genc.write(output_dir, prefix + 'qmp-introspect.c')
-    genh.write(output_dir, prefix + 'qmp-introspect.h')
+    vis.write(output_dir)
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index aa3c01e750..d2b8423479 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -167,36 +167,41 @@ void qapi_free_%(c_name)s(%(c_name)s *obj)
     return ret
 
 
-class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
-    def __init__(self, opt_builtins):
+class QAPISchemaGenTypeVisitor(QAPISchemaMonolithicCVisitor):
+
+    def __init__(self, prefix, opt_builtins):
+        QAPISchemaMonolithicCVisitor.__init__(
+            self, prefix, 'qapi-types', ' * Schema-defined QAPI types',
+            __doc__)
         self._opt_builtins = opt_builtins
-        self.decl = None
-        self.defn = None
-        self._fwdecl = None
-        self._btin = None
+        self._genc.preamble_add(mcgen('''
+#include "qemu/osdep.h"
+#include "qapi/dealloc-visitor.h"
+#include "%(prefix)sqapi-types.h"
+#include "%(prefix)sqapi-visit.h"
+''',
+                                      prefix=prefix))
+        self._genh.preamble_add(mcgen('''
+#include "qapi/util.h"
+'''))
+        self._btin = '\n' + guardstart('QAPI_TYPES_BUILTIN')
 
     def visit_begin(self, schema):
         # gen_object() is recursive, ensure it doesn't visit the empty type
         objects_seen.add(schema.the_empty_object_type.name)
-        self.decl = ''
-        self.defn = ''
-        self._fwdecl = ''
-        self._btin = '\n' + guardstart('QAPI_TYPES_BUILTIN')
 
     def visit_end(self):
-        self.decl = self._fwdecl + self.decl
-        self._fwdecl = None
         # To avoid header dependency hell, we always generate
         # declarations for built-in types in our header files and
         # simply guard them.  See also opt_builtins (command line
         # option -b).
         self._btin += guardend('QAPI_TYPES_BUILTIN')
-        self.decl = self._btin + self.decl
+        self._genh.preamble_add(self._btin)
         self._btin = None
 
     def _gen_type_cleanup(self, name):
-        self.decl += gen_type_cleanup_decl(name)
-        self.defn += gen_type_cleanup(name)
+        self._genh.add(gen_type_cleanup_decl(name))
+        self._genc.add(gen_type_cleanup(name))
 
     def visit_enum_type(self, name, info, values, prefix):
         # Special case for our lone builtin enum type
@@ -204,10 +209,10 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         if not info:
             self._btin += gen_enum(name, values, prefix)
             if self._opt_builtins:
-                self.defn += gen_enum_lookup(name, values, prefix)
+                self._genc.add(gen_enum_lookup(name, values, prefix))
         else:
-            self._fwdecl += gen_enum(name, values, prefix)
-            self.defn += gen_enum_lookup(name, values, prefix)
+            self._genh.preamble_add(gen_enum(name, values, prefix))
+            self._genc.add(gen_enum_lookup(name, values, prefix))
 
     def visit_array_type(self, name, info, element_type):
         if isinstance(element_type, QAPISchemaBuiltinType):
@@ -215,20 +220,20 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
             self._btin += gen_array(name, element_type)
             self._btin += gen_type_cleanup_decl(name)
             if self._opt_builtins:
-                self.defn += gen_type_cleanup(name)
+                self._genc.add(gen_type_cleanup(name))
         else:
-            self._fwdecl += gen_fwd_object_or_array(name)
-            self.decl += gen_array(name, element_type)
+            self._genh.preamble_add(gen_fwd_object_or_array(name))
+            self._genh.add(gen_array(name, element_type))
             self._gen_type_cleanup(name)
 
     def visit_object_type(self, name, info, base, members, variants):
         # Nothing to do for the special empty builtin
         if name == 'q_empty':
             return
-        self._fwdecl += gen_fwd_object_or_array(name)
-        self.decl += gen_object(name, base, members, variants)
+        self._genh.preamble_add(gen_fwd_object_or_array(name))
+        self._genh.add(gen_object(name, base, members, variants))
         if base and not base.is_implicit():
-            self.decl += gen_upcast(name, base)
+            self._genh.add(gen_upcast(name, base))
         # TODO Worth changing the visitor signature, so we could
         # directly use rather than repeat type.is_implicit()?
         if not name.startswith('q_'):
@@ -236,31 +241,13 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
             self._gen_type_cleanup(name)
 
     def visit_alternate_type(self, name, info, variants):
-        self._fwdecl += gen_fwd_object_or_array(name)
-        self.decl += gen_object(name, None, [variants.tag_member], variants)
+        self._genh.preamble_add(gen_fwd_object_or_array(name))
+        self._genh.add(gen_object(name, None,
+                                  [variants.tag_member], variants))
         self._gen_type_cleanup(name)
 
 
 def gen_types(schema, output_dir, prefix, opt_builtins):
-    blurb = ' * Schema-defined QAPI types'
-    genc = QAPIGenC(blurb, __doc__)
-    genh = QAPIGenH(blurb, __doc__)
-
-    genc.add(mcgen('''
-#include "qemu/osdep.h"
-#include "qapi/dealloc-visitor.h"
-#include "%(prefix)sqapi-types.h"
-#include "%(prefix)sqapi-visit.h"
-''',
-                   prefix=prefix))
-
-    genh.add(mcgen('''
-#include "qapi/util.h"
-'''))
-
-    vis = QAPISchemaGenTypeVisitor(opt_builtins)
+    vis = QAPISchemaGenTypeVisitor(prefix, opt_builtins)
     schema.visit(vis)
-    genc.add(vis.defn)
-    genh.add(vis.decl)
-    genc.write(output_dir, prefix + 'qapi-types.c')
-    genh.write(output_dir, prefix + 'qapi-types.h')
+    vis.write(output_dir)
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index f966e7975f..3d09d44265 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -263,16 +263,27 @@ out:
                  c_name=c_name(name))
 
 
-class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
-    def __init__(self, opt_builtins):
+class QAPISchemaGenVisitVisitor(QAPISchemaMonolithicCVisitor):
+
+    def __init__(self, prefix, opt_builtins):
+        QAPISchemaMonolithicCVisitor.__init__(
+            self, prefix, 'qapi-visit', ' * Schema-defined QAPI visitors',
+            __doc__)
         self._opt_builtins = opt_builtins
-        self.decl = None
-        self.defn = None
-        self._btin = None
+        self._genc.preamble_add(mcgen('''
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
+#include "%(prefix)sqapi-visit.h"
+''',
+                                      prefix=prefix))
+        self._genh.preamble_add(mcgen('''
+#include "qapi/visitor.h"
+#include "%(prefix)sqapi-types.h"
 
-    def visit_begin(self, schema):
-        self.decl = ''
-        self.defn = ''
+''',
+                                      prefix=prefix))
         self._btin = guardstart('QAPI_VISIT_BUILTIN')
 
     def visit_end(self):
@@ -281,7 +292,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         # simply guard them.  See also opt_builtins (command line
         # option -b).
         self._btin += guardend('QAPI_VISIT_BUILTIN')
-        self.decl = self._btin + self.decl
+        self._genh.preamble_add(self._btin)
         self._btin = None
 
     def visit_enum_type(self, name, info, values, prefix):
@@ -290,10 +301,10 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         if not info:
             self._btin += gen_visit_decl(name, scalar=True)
             if self._opt_builtins:
-                self.defn += gen_visit_enum(name)
+                self._genc.add(gen_visit_enum(name))
         else:
-            self.decl += gen_visit_decl(name, scalar=True)
-            self.defn += gen_visit_enum(name)
+            self._genh.add(gen_visit_decl(name, scalar=True))
+            self._genc.add(gen_visit_enum(name))
 
     def visit_array_type(self, name, info, element_type):
         decl = gen_visit_decl(name)
@@ -301,53 +312,30 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         if isinstance(element_type, QAPISchemaBuiltinType):
             self._btin += decl
             if self._opt_builtins:
-                self.defn += defn
+                self._genc.add(defn)
         else:
-            self.decl += decl
-            self.defn += defn
+            self._genh.add(decl)
+            self._genc.add(defn)
 
     def visit_object_type(self, name, info, base, members, variants):
         # Nothing to do for the special empty builtin
         if name == 'q_empty':
             return
-        self.decl += gen_visit_members_decl(name)
-        self.defn += gen_visit_object_members(name, base, members, variants)
+        self._genh.add(gen_visit_members_decl(name))
+        self._genc.add(gen_visit_object_members(name, base, members, variants))
         # TODO Worth changing the visitor signature, so we could
         # directly use rather than repeat type.is_implicit()?
         if not name.startswith('q_'):
             # only explicit types need an allocating visit
-            self.decl += gen_visit_decl(name)
-            self.defn += gen_visit_object(name, base, members, variants)
+            self._genh.add(gen_visit_decl(name))
+            self._genc.add(gen_visit_object(name, base, members, variants))
 
     def visit_alternate_type(self, name, info, variants):
-        self.decl += gen_visit_decl(name)
-        self.defn += gen_visit_alternate(name, variants)
+        self._genh.add(gen_visit_decl(name))
+        self._genc.add(gen_visit_alternate(name, variants))
 
 
 def gen_visit(schema, output_dir, prefix, opt_builtins):
-    blurb = ' * Schema-defined QAPI visitors'
-    genc = QAPIGenC(blurb, __doc__)
-    genh = QAPIGenH(blurb, __doc__)
-
-    genc.add(mcgen('''
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
-#include "%(prefix)sqapi-visit.h"
-''',
-                   prefix=prefix))
-
-    genh.add(mcgen('''
-#include "qapi/visitor.h"
-#include "%(prefix)sqapi-types.h"
-
-''',
-                   prefix=prefix))
-
-    vis = QAPISchemaGenVisitVisitor(opt_builtins)
+    vis = QAPISchemaGenVisitVisitor(prefix, opt_builtins)
     schema.visit(vis)
-    genc.add(vis.defn)
-    genh.add(vis.decl)
-    genc.write(output_dir, prefix + 'qapi-visit.c')
-    genh.write(output_dir, prefix + 'qapi-visit.h')
+    vis.write(output_dir)
-- 
2.13.6

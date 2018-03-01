Received: from eggs.gnu.org ([2001:4830:134:3::10]:40679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6z-0000zb-PR
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6w-0007l0-Jg
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:10607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU6w-0007j6-83
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6EBD9C0587DF
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 19:43:25 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:34 -0600
Message-Id: <20180301194245.29854-20-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/30] qapi: Make code-generating visitors use
 QAPIGen more
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

The use of QAPIGen is rather shallow so far: most of the output
accumulation is not converted.  Take the next step: convert output
accumulation in the code-generating visitor classes.  Helper functions
outside these classes are not converted.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180211093607.27351-20-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
[eblake: rebase to earlier guardstart cleanup]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/commands.py   | 71 ++++++++++++++++-----------------------
 scripts/qapi/common.py     | 13 ++++++++
 scripts/qapi/doc.py        | 74 ++++++++++++++++++++--------------------=
-
 scripts/qapi/events.py     | 55 ++++++++++++-------------------
 scripts/qapi/introspect.py | 56 +++++++++++++------------------
 scripts/qapi/types.py      | 81 +++++++++++++++++++---------------------=
-----
 scripts/qapi/visit.py      | 82 ++++++++++++++++++++--------------------=
------
 7 files changed, 189 insertions(+), 243 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 05fe33a03bc..46757db771d 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -223,44 +223,15 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *c=
mds)
     return ret


-class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
+class QAPISchemaGenCommandVisitor(QAPISchemaMonolithicCVisitor):
+
     def __init__(self, prefix):
-        self._prefix =3D prefix
-        self.decl =3D None
-        self.defn =3D None
-        self._regy =3D None
-        self._visited_ret_types =3D None
-
-    def visit_begin(self, schema):
-        self.decl =3D ''
-        self.defn =3D ''
+        QAPISchemaMonolithicCVisitor.__init__(
+            self, prefix, 'qmp-commands',
+            ' * Schema-defined QAPI/QMP commands', __doc__)
         self._regy =3D ''
         self._visited_ret_types =3D set()
-
-    def visit_end(self):
-        self.defn +=3D gen_registry(self._regy, self._prefix)
-        self._regy =3D None
-        self._visited_ret_types =3D None
-
-    def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
-        if not gen:
-            return
-        self.decl +=3D gen_command_decl(name, arg_type, boxed, ret_type)
-        if ret_type and ret_type not in self._visited_ret_types:
-            self._visited_ret_types.add(ret_type)
-            self.defn +=3D gen_marshal_output(ret_type)
-        self.decl +=3D gen_marshal_decl(name)
-        self.defn +=3D gen_marshal(name, arg_type, boxed, ret_type)
-        self._regy +=3D gen_register_command(name, success_response)
-
-
-def gen_commands(schema, output_dir, prefix):
-    blurb =3D ' * Schema-defined QAPI/QMP commands'
-    genc =3D QAPIGenC(blurb, __doc__)
-    genh =3D QAPIGenH(blurb, __doc__)
-
-    genc.add(mcgen('''
+        self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/module.h"
@@ -275,19 +246,33 @@ def gen_commands(schema, output_dir, prefix):
 #include "%(prefix)sqmp-commands.h"

 ''',
-                   prefix=3Dprefix))
-
-    genh.add(mcgen('''
+                             prefix=3Dprefix))
+        self._genh.add(mcgen('''
 #include "%(prefix)sqapi-types.h"
 #include "qapi/qmp/dispatch.h"

 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
 ''',
-                   prefix=3Dprefix, c_prefix=3Dc_name(prefix, protect=3D=
False)))
+                             prefix=3Dprefix,
+                             c_prefix=3Dc_name(prefix, protect=3DFalse))=
)

+    def visit_end(self):
+        self._genc.add(gen_registry(self._regy, self._prefix))
+
+    def visit_command(self, name, info, arg_type, ret_type,
+                      gen, success_response, boxed):
+        if not gen:
+            return
+        self._genh.add(gen_command_decl(name, arg_type, boxed, ret_type)=
)
+        if ret_type and ret_type not in self._visited_ret_types:
+            self._visited_ret_types.add(ret_type)
+            self._genc.add(gen_marshal_output(ret_type))
+        self._genh.add(gen_marshal_decl(name))
+        self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
+        self._regy +=3D gen_register_command(name, success_response)
+
+
+def gen_commands(schema, output_dir, prefix):
     vis =3D QAPISchemaGenCommandVisitor(prefix)
     schema.visit(vis)
-    genc.add(vis.defn)
-    genh.add(vis.decl)
-    genc.write(output_dir, prefix + 'qmp-commands.c')
-    genh.write(output_dir, prefix + 'qmp-commands.h')
+    vis.write(output_dir)
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 2c5c40ec0a9..23437b558f6 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -2050,3 +2050,16 @@ class QAPIGenDoc(QAPIGen):
     def _top(self, fname):
         return (QAPIGen._top(self, fname)
                 + '@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n\n')
+
+
+class QAPISchemaMonolithicCVisitor(QAPISchemaVisitor):
+
+    def __init__(self, prefix, what, blurb, pydoc):
+        self._prefix =3D prefix
+        self._what =3D what
+        self._genc =3D QAPIGenC(blurb, pydoc)
+        self._genh =3D QAPIGenH(blurb, pydoc)
+
+    def write(self, output_dir):
+        self._genc.write(output_dir, self._prefix + self._what + '.c')
+        self._genh.write(output_dir, self._prefix + self._what + '.h')
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index cc4d5a43fb9..0ea68bf8134 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -197,33 +197,35 @@ def texi_entity(doc, what, base=3DNone, variants=3D=
None,


 class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaVisitor):
-    def __init__(self):
-        self.out =3D None
+    def __init__(self, prefix):
+        self._prefix =3D prefix
+        self._gen =3D qapi.common.QAPIGenDoc()
         self.cur_doc =3D None

-    def visit_begin(self, schema):
-        self.out =3D ''
+    def write(self, output_dir):
+        self._gen.write(output_dir, self._prefix + 'qapi-doc.texi')

     def visit_enum_type(self, name, info, values, prefix):
         doc =3D self.cur_doc
-        self.out +=3D TYPE_FMT(type=3D'Enum',
-                             name=3Ddoc.symbol,
-                             body=3Dtexi_entity(doc, 'Values',
-                                              member_func=3Dtexi_enum_va=
lue))
+        self._gen.add(TYPE_FMT(type=3D'Enum',
+                               name=3Ddoc.symbol,
+                               body=3Dtexi_entity(doc, 'Values',
+                                                member_func=3Dtexi_enum_=
value)))

     def visit_object_type(self, name, info, base, members, variants):
         doc =3D self.cur_doc
         if base and base.is_implicit():
             base =3D None
-        self.out +=3D TYPE_FMT(type=3D'Object',
-                             name=3Ddoc.symbol,
-                             body=3Dtexi_entity(doc, 'Members', base, va=
riants))
+        self._gen.add(TYPE_FMT(type=3D'Object',
+                               name=3Ddoc.symbol,
+                               body=3Dtexi_entity(doc, 'Members',
+                                                base, variants)))

     def visit_alternate_type(self, name, info, variants):
         doc =3D self.cur_doc
-        self.out +=3D TYPE_FMT(type=3D'Alternate',
-                             name=3Ddoc.symbol,
-                             body=3Dtexi_entity(doc, 'Members'))
+        self._gen.add(TYPE_FMT(type=3D'Alternate',
+                               name=3Ddoc.symbol,
+                               body=3Dtexi_entity(doc, 'Members')))

     def visit_command(self, name, info, arg_type, ret_type,
                       gen, success_response, boxed):
@@ -235,44 +237,38 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchem=
aVisitor):
             body +=3D texi_sections(doc)
         else:
             body =3D texi_entity(doc, 'Arguments')
-        self.out +=3D MSG_FMT(type=3D'Command',
-                            name=3Ddoc.symbol,
-                            body=3Dbody)
+        self._gen.add(MSG_FMT(type=3D'Command',
+                              name=3Ddoc.symbol,
+                              body=3Dbody))

     def visit_event(self, name, info, arg_type, boxed):
         doc =3D self.cur_doc
-        self.out +=3D MSG_FMT(type=3D'Event',
-                            name=3Ddoc.symbol,
-                            body=3Dtexi_entity(doc, 'Arguments'))
+        self._gen.add(MSG_FMT(type=3D'Event',
+                              name=3Ddoc.symbol,
+                              body=3Dtexi_entity(doc, 'Arguments')))

     def symbol(self, doc, entity):
-        if self.out:
-            self.out +=3D '\n'
+        if self._gen._body:
+            self._gen.add('\n')
         self.cur_doc =3D doc
         entity.visit(self)
         self.cur_doc =3D None

     def freeform(self, doc):
         assert not doc.args
-        if self.out:
-            self.out +=3D '\n'
-        self.out +=3D texi_body(doc) + texi_sections(doc)
+        if self._gen._body:
+            self._gen.add('\n')
+        self._gen.add(texi_body(doc) + texi_sections(doc))


-def texi_schema(schema):
-    """Convert QAPI schema documentation to Texinfo"""
-    gen =3D QAPISchemaGenDocVisitor()
-    gen.visit_begin(schema)
+def gen_doc(schema, output_dir, prefix):
+    if not qapi.common.doc_required:
+        return
+    vis =3D QAPISchemaGenDocVisitor(prefix)
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
-        gen =3D qapi.common.QAPIGenDoc()
-        gen.add(texi_schema(schema))
-        gen.write(output_dir, prefix + 'qapi-doc.texi')
+            vis.freeform(doc)
+    vis.write(output_dir)
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index b7dc82004fc..81ab3abb309 100644
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
         self._enum_name =3D c_name(prefix + 'QAPIEvent', protect=3DFalse=
)
-        self.decl =3D None
-        self.defn =3D None
-        self._event_names =3D None
-
-    def visit_begin(self, schema):
-        self.decl =3D ''
-        self.defn =3D ''
         self._event_names =3D []
-
-    def visit_end(self):
-        self.decl +=3D gen_enum(self._enum_name, self._event_names)
-        self.defn +=3D gen_enum_lookup(self._enum_name, self._event_name=
s)
-        self._event_names =3D None
-
-    def visit_event(self, name, info, arg_type, boxed):
-        self.decl +=3D gen_event_send_decl(name, arg_type, boxed)
-        self.defn +=3D gen_event_send(name, arg_type, boxed, self._enum_=
name)
-        self._event_names.append(name)
-
-
-def gen_events(schema, output_dir, prefix):
-    blurb =3D ' * Schema-defined QAPI/QMP events'
-    genc =3D QAPIGenC(blurb, __doc__)
-    genh =3D QAPIGenH(blurb, __doc__)
-
-    genc.add(mcgen('''
+        self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "%(prefix)sqapi-event.h"
@@ -187,18 +167,25 @@ def gen_events(schema, output_dir, prefix):
 #include "qapi/qmp-event.h"

 ''',
-                   prefix=3Dprefix))
-
-    genh.add(mcgen('''
+                             prefix=3Dprefix))
+        self._genh.add(mcgen('''
 #include "qapi/util.h"
 #include "%(prefix)sqapi-types.h"

 ''',
-                   prefix=3Dprefix))
+                             prefix=3Dprefix))

+    def visit_end(self):
+        self._genh.add(gen_enum(self._enum_name, self._event_names))
+        self._genc.add(gen_enum_lookup(self._enum_name, self._event_name=
s))
+
+    def visit_event(self, name, info, arg_type, boxed):
+        self._genh.add(gen_event_send_decl(name, arg_type, boxed))
+        self._genc.add(gen_event_send(name, arg_type, boxed, self._enum_=
name))
+        self._event_names.append(name)
+
+
+def gen_events(schema, output_dir, prefix):
     vis =3D QAPISchemaGenEventVisitor(prefix)
     schema.visit(vis)
-    genc.add(vis.defn)
-    genh.add(vis.decl)
-    genc.write(output_dir, prefix + 'qapi-event.c')
-    genh.write(output_dir, prefix + 'qapi-event.h')
+    vis.write(output_dir)
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 1e4f0651643..f571cc134cf 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -40,22 +40,26 @@ def to_c_string(string):
     return '"' + string.replace('\\', r'\\').replace('"', r'\"') + '"'


-class QAPISchemaGenIntrospectVisitor(QAPISchemaVisitor):
+class QAPISchemaGenIntrospectVisitor(QAPISchemaMonolithicCVisitor):
+
     def __init__(self, prefix, unmask):
-        self._prefix =3D prefix
+        QAPISchemaMonolithicCVisitor.__init__(
+            self, prefix, 'qmp-introspect',
+            ' * QAPI/QMP schema introspection', __doc__)
         self._unmask =3D unmask
-        self.defn =3D None
-        self.decl =3D None
         self._schema =3D None
-        self._jsons =3D None
-        self._used_types =3D None
-        self._name_map =3D None
+        self._jsons =3D []
+        self._used_types =3D []
+        self._name_map =3D {}
+        self._genc.add(mcgen('''
+#include "qemu/osdep.h"
+#include "%(prefix)sqmp-introspect.h"
+
+''',
+                             prefix=3Dprefix))

     def visit_begin(self, schema):
         self._schema =3D schema
-        self._jsons =3D []
-        self._used_types =3D []
-        self._name_map =3D {}

     def visit_end(self):
         # visit the types that are actually used
@@ -67,21 +71,21 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaVisito=
r):
         # TODO can generate awfully long lines
         jsons.extend(self._jsons)
         name =3D c_name(self._prefix, protect=3DFalse) + 'qmp_schema_jso=
n'
-        self.decl =3D mcgen('''
+        self._genh.add(mcgen('''
 extern const char %(c_name)s[];
 ''',
-                          c_name=3Dc_name(name))
+                             c_name=3Dc_name(name)))
         lines =3D to_json(jsons).split('\n')
         c_string =3D '\n    '.join([to_c_string(line) for line in lines]=
)
-        self.defn =3D mcgen('''
+        self._genc.add(mcgen('''
 const char %(c_name)s[] =3D %(c_string)s;
 ''',
-                          c_name=3Dc_name(name),
-                          c_string=3Dc_string)
+                             c_name=3Dc_name(name),
+                             c_string=3Dc_string))
         self._schema =3D None
-        self._jsons =3D None
-        self._used_types =3D None
-        self._name_map =3D None
+        self._jsons =3D []
+        self._used_types =3D []
+        self._name_map =3D {}

     def visit_needed(self, entity):
         # Ignore types on first pass; visit_end() will pick up used type=
s
@@ -169,20 +173,6 @@ const char %(c_name)s[] =3D %(c_string)s;


 def gen_introspect(schema, output_dir, prefix, opt_unmask):
-    blurb =3D ' * QAPI/QMP schema introspection'
-    genc =3D QAPIGenC(blurb, __doc__)
-    genh =3D QAPIGenH(blurb, __doc__)
-
-    genc.add(mcgen('''
-#include "qemu/osdep.h"
-#include "%(prefix)sqmp-introspect.h"
-
-''',
-                   prefix=3Dprefix))
-
     vis =3D QAPISchemaGenIntrospectVisitor(prefix, opt_unmask)
     schema.visit(vis)
-    genc.add(vis.defn)
-    genh.add(vis.decl)
-    genc.write(output_dir, prefix + 'qmp-introspect.c')
-    genh.write(output_dir, prefix + 'qmp-introspect.h')
+    vis.write(output_dir)
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index aa3c01e7508..d2b84234797 100644
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
         self._opt_builtins =3D opt_builtins
-        self.decl =3D None
-        self.defn =3D None
-        self._fwdecl =3D None
-        self._btin =3D None
+        self._genc.preamble_add(mcgen('''
+#include "qemu/osdep.h"
+#include "qapi/dealloc-visitor.h"
+#include "%(prefix)sqapi-types.h"
+#include "%(prefix)sqapi-visit.h"
+''',
+                                      prefix=3Dprefix))
+        self._genh.preamble_add(mcgen('''
+#include "qapi/util.h"
+'''))
+        self._btin =3D '\n' + guardstart('QAPI_TYPES_BUILTIN')

     def visit_begin(self, schema):
         # gen_object() is recursive, ensure it doesn't visit the empty t=
ype
         objects_seen.add(schema.the_empty_object_type.name)
-        self.decl =3D ''
-        self.defn =3D ''
-        self._fwdecl =3D ''
-        self._btin =3D '\n' + guardstart('QAPI_TYPES_BUILTIN')

     def visit_end(self):
-        self.decl =3D self._fwdecl + self.decl
-        self._fwdecl =3D None
         # To avoid header dependency hell, we always generate
         # declarations for built-in types in our header files and
         # simply guard them.  See also opt_builtins (command line
         # option -b).
         self._btin +=3D guardend('QAPI_TYPES_BUILTIN')
-        self.decl =3D self._btin + self.decl
+        self._genh.preamble_add(self._btin)
         self._btin =3D None

     def _gen_type_cleanup(self, name):
-        self.decl +=3D gen_type_cleanup_decl(name)
-        self.defn +=3D gen_type_cleanup(name)
+        self._genh.add(gen_type_cleanup_decl(name))
+        self._genc.add(gen_type_cleanup(name))

     def visit_enum_type(self, name, info, values, prefix):
         # Special case for our lone builtin enum type
@@ -204,10 +209,10 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         if not info:
             self._btin +=3D gen_enum(name, values, prefix)
             if self._opt_builtins:
-                self.defn +=3D gen_enum_lookup(name, values, prefix)
+                self._genc.add(gen_enum_lookup(name, values, prefix))
         else:
-            self._fwdecl +=3D gen_enum(name, values, prefix)
-            self.defn +=3D gen_enum_lookup(name, values, prefix)
+            self._genh.preamble_add(gen_enum(name, values, prefix))
+            self._genc.add(gen_enum_lookup(name, values, prefix))

     def visit_array_type(self, name, info, element_type):
         if isinstance(element_type, QAPISchemaBuiltinType):
@@ -215,20 +220,20 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
             self._btin +=3D gen_array(name, element_type)
             self._btin +=3D gen_type_cleanup_decl(name)
             if self._opt_builtins:
-                self.defn +=3D gen_type_cleanup(name)
+                self._genc.add(gen_type_cleanup(name))
         else:
-            self._fwdecl +=3D gen_fwd_object_or_array(name)
-            self.decl +=3D gen_array(name, element_type)
+            self._genh.preamble_add(gen_fwd_object_or_array(name))
+            self._genh.add(gen_array(name, element_type))
             self._gen_type_cleanup(name)

     def visit_object_type(self, name, info, base, members, variants):
         # Nothing to do for the special empty builtin
         if name =3D=3D 'q_empty':
             return
-        self._fwdecl +=3D gen_fwd_object_or_array(name)
-        self.decl +=3D gen_object(name, base, members, variants)
+        self._genh.preamble_add(gen_fwd_object_or_array(name))
+        self._genh.add(gen_object(name, base, members, variants))
         if base and not base.is_implicit():
-            self.decl +=3D gen_upcast(name, base)
+            self._genh.add(gen_upcast(name, base))
         # TODO Worth changing the visitor signature, so we could
         # directly use rather than repeat type.is_implicit()?
         if not name.startswith('q_'):
@@ -236,31 +241,13 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
             self._gen_type_cleanup(name)

     def visit_alternate_type(self, name, info, variants):
-        self._fwdecl +=3D gen_fwd_object_or_array(name)
-        self.decl +=3D gen_object(name, None, [variants.tag_member], var=
iants)
+        self._genh.preamble_add(gen_fwd_object_or_array(name))
+        self._genh.add(gen_object(name, None,
+                                  [variants.tag_member], variants))
         self._gen_type_cleanup(name)


 def gen_types(schema, output_dir, prefix, opt_builtins):
-    blurb =3D ' * Schema-defined QAPI types'
-    genc =3D QAPIGenC(blurb, __doc__)
-    genh =3D QAPIGenH(blurb, __doc__)
-
-    genc.add(mcgen('''
-#include "qemu/osdep.h"
-#include "qapi/dealloc-visitor.h"
-#include "%(prefix)sqapi-types.h"
-#include "%(prefix)sqapi-visit.h"
-''',
-                   prefix=3Dprefix))
-
-    genh.add(mcgen('''
-#include "qapi/util.h"
-'''))
-
-    vis =3D QAPISchemaGenTypeVisitor(opt_builtins)
+    vis =3D QAPISchemaGenTypeVisitor(prefix, opt_builtins)
     schema.visit(vis)
-    genc.add(vis.defn)
-    genh.add(vis.decl)
-    genc.write(output_dir, prefix + 'qapi-types.c')
-    genh.write(output_dir, prefix + 'qapi-types.h')
+    vis.write(output_dir)
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 3ed78165d76..3d09d442650 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -263,17 +263,28 @@ out:
                  c_name=3Dc_name(name))


-class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
-    def __init__(self, opt_builtins):
+class QAPISchemaGenVisitVisitor(QAPISchemaMonolithicCVisitor):
+
+    def __init__(self, prefix, opt_builtins):
+        QAPISchemaMonolithicCVisitor.__init__(
+            self, prefix, 'qapi-visit', ' * Schema-defined QAPI visitors=
',
+            __doc__)
         self._opt_builtins =3D opt_builtins
-        self.decl =3D None
-        self.defn =3D None
-        self._btin =3D None
+        self._genc.preamble_add(mcgen('''
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
+#include "%(prefix)sqapi-visit.h"
+''',
+                                      prefix=3Dprefix))
+        self._genh.preamble_add(mcgen('''
+#include "qapi/visitor.h"
+#include "%(prefix)sqapi-types.h"

-    def visit_begin(self, schema):
-        self.decl =3D ''
-        self.defn =3D ''
-        self._btin =3D '\n' + guardstart('QAPI_VISIT_BUILTIN')
+''',
+                                      prefix=3Dprefix))
+        self._btin =3D guardstart('QAPI_VISIT_BUILTIN')

     def visit_end(self):
         # To avoid header dependency hell, we always generate
@@ -281,7 +292,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         # simply guard them.  See also opt_builtins (command line
         # option -b).
         self._btin +=3D guardend('QAPI_VISIT_BUILTIN')
-        self.decl =3D self._btin + self.decl
+        self._genh.preamble_add(self._btin)
         self._btin =3D None

     def visit_enum_type(self, name, info, values, prefix):
@@ -290,10 +301,10 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         if not info:
             self._btin +=3D gen_visit_decl(name, scalar=3DTrue)
             if self._opt_builtins:
-                self.defn +=3D gen_visit_enum(name)
+                self._genc.add(gen_visit_enum(name))
         else:
-            self.decl +=3D gen_visit_decl(name, scalar=3DTrue)
-            self.defn +=3D gen_visit_enum(name)
+            self._genh.add(gen_visit_decl(name, scalar=3DTrue))
+            self._genc.add(gen_visit_enum(name))

     def visit_array_type(self, name, info, element_type):
         decl =3D gen_visit_decl(name)
@@ -301,53 +312,30 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         if isinstance(element_type, QAPISchemaBuiltinType):
             self._btin +=3D decl
             if self._opt_builtins:
-                self.defn +=3D defn
+                self._genc.add(defn)
         else:
-            self.decl +=3D decl
-            self.defn +=3D defn
+            self._genh.add(decl)
+            self._genc.add(defn)

     def visit_object_type(self, name, info, base, members, variants):
         # Nothing to do for the special empty builtin
         if name =3D=3D 'q_empty':
             return
-        self.decl +=3D gen_visit_members_decl(name)
-        self.defn +=3D gen_visit_object_members(name, base, members, var=
iants)
+        self._genh.add(gen_visit_members_decl(name))
+        self._genc.add(gen_visit_object_members(name, base, members, var=
iants))
         # TODO Worth changing the visitor signature, so we could
         # directly use rather than repeat type.is_implicit()?
         if not name.startswith('q_'):
             # only explicit types need an allocating visit
-            self.decl +=3D gen_visit_decl(name)
-            self.defn +=3D gen_visit_object(name, base, members, variant=
s)
+            self._genh.add(gen_visit_decl(name))
+            self._genc.add(gen_visit_object(name, base, members, variant=
s))

     def visit_alternate_type(self, name, info, variants):
-        self.decl +=3D gen_visit_decl(name)
-        self.defn +=3D gen_visit_alternate(name, variants)
+        self._genh.add(gen_visit_decl(name))
+        self._genc.add(gen_visit_alternate(name, variants))


 def gen_visit(schema, output_dir, prefix, opt_builtins):
-    blurb =3D ' * Schema-defined QAPI visitors'
-    genc =3D QAPIGenC(blurb, __doc__)
-    genh =3D QAPIGenH(blurb, __doc__)
-
-    genc.add(mcgen('''
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
-#include "%(prefix)sqapi-visit.h"
-''',
-                   prefix=3Dprefix))
-
-    genh.add(mcgen('''
-#include "qapi/visitor.h"
-#include "%(prefix)sqapi-types.h"
-
-''',
-                   prefix=3Dprefix))
-
-    vis =3D QAPISchemaGenVisitVisitor(opt_builtins)
+    vis =3D QAPISchemaGenVisitVisitor(prefix, opt_builtins)
     schema.visit(vis)
-    genc.add(vis.defn)
-    genh.add(vis.decl)
-    genc.write(output_dir, prefix + 'qapi-visit.c')
-    genh.write(output_dir, prefix + 'qapi-visit.h')
+    vis.write(output_dir)
--=20
2.14.3

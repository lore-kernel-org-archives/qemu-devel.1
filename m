Received: from eggs.gnu.org ([208.118.235.92]:55592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdNV-0002Ze-PB
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdMG-0005f0-QO
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:35:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehdMG-0005cd-2e
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:34:32 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  2 Feb 2018 14:03:19 +0100
Message-Id: <20180202130336.24719-5-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-1-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 04/21] qapi: Reduce use of global variables
 in generators some
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

In preparation of the next commit, which will turn the generators into
modules.  These global variables will become local to main() then.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi-commands.py   |  9 +++++----
 scripts/qapi-event.py      | 15 +++++++--------
 scripts/qapi-introspect.py |  7 ++++---
 scripts/qapi-types.py      | 17 +++++++++--------
 scripts/qapi-visit.py      | 17 +++++++++--------
 5 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 4be7dbc482..d229537659 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -207,7 +207,7 @@ def gen_register_command(name, success_response):
     return ret
 
 
-def gen_registry(registry):
+def gen_registry(registry, prefix):
     ret = mcgen('''
 
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)
@@ -224,7 +224,8 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)
 
 
 class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
-    def __init__(self):
+    def __init__(self, prefix):
+        self._prefix = prefix
         self.decl = None
         self.defn = None
         self._regy = None
@@ -237,7 +238,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
         self._visited_ret_types = set()
 
     def visit_end(self):
-        self.defn += gen_registry(self._regy)
+        self.defn += gen_registry(self._regy, self._prefix)
         self._regy = None
         self._visited_ret_types = None
 
@@ -289,7 +290,7 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
                 prefix=prefix, c_prefix=c_name(prefix, protect=False)))
 
 schema = QAPISchema(input_file)
-vis = QAPISchemaGenCommandVisitor()
+vis = QAPISchemaGenCommandVisitor(prefix)
 schema.visit(vis)
 genc.body(vis.defn)
 genh.body(vis.decl)
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index da3de17c76..1af21b580a 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -58,7 +58,7 @@ def gen_param_var(typ):
     return ret
 
 
-def gen_event_send(name, arg_type, boxed):
+def gen_event_send(name, arg_type, boxed, event_enum_name):
     # FIXME: Our declaration of local variables (and of 'errp' in the
     # parameter list) can collide with exploded members of the event's
     # data type passed in as parameters.  If this collision ever hits in
@@ -149,7 +149,8 @@ out:
 
 
 class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
-    def __init__(self):
+    def __init__(self, prefix):
+        self._enum_name = c_name(prefix + 'QAPIEvent', protect=False)
         self.decl = None
         self.defn = None
         self._event_names = None
@@ -160,13 +161,13 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
         self._event_names = []
 
     def visit_end(self):
-        self.decl += gen_enum(event_enum_name, self._event_names)
-        self.defn += gen_enum_lookup(event_enum_name, self._event_names)
+        self.decl += gen_enum(self._enum_name, self._event_names)
+        self.defn += gen_enum_lookup(self._enum_name, self._event_names)
         self._event_names = None
 
     def visit_event(self, name, info, arg_type, boxed):
         self.decl += gen_event_send_decl(name, arg_type, boxed)
-        self.defn += gen_event_send(name, arg_type, boxed)
+        self.defn += gen_event_send(name, arg_type, boxed, self._enum_name)
         self._event_names.append(name)
 
 
@@ -199,10 +200,8 @@ genh.body(mcgen('''
 ''',
                 prefix=prefix))
 
-event_enum_name = c_name(prefix + 'QAPIEvent', protect=False)
-
 schema = QAPISchema(input_file)
-vis = QAPISchemaGenEventVisitor()
+vis = QAPISchemaGenEventVisitor(prefix)
 schema.visit(vis)
 genc.body(vis.defn)
 genh.body(vis.decl)
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index c654f8fa94..8d4e3c1c3a 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -41,7 +41,8 @@ def to_c_string(string):
 
 
 class QAPISchemaGenIntrospectVisitor(QAPISchemaVisitor):
-    def __init__(self, unmask):
+    def __init__(self, prefix, unmask):
+        self._prefix = prefix
         self._unmask = unmask
         self.defn = None
         self.decl = None
@@ -65,7 +66,7 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaVisitor):
         # generate C
         # TODO can generate awfully long lines
         jsons.extend(self._jsons)
-        name = c_name(prefix, protect=False) + 'qmp_schema_json'
+        name = c_name(self._prefix, protect=False) + 'qmp_schema_json'
         self.decl = mcgen('''
 extern const char %(c_name)s[];
 ''',
@@ -192,7 +193,7 @@ genc.body(mcgen('''
                 prefix=prefix))
 
 schema = QAPISchema(input_file)
-vis = QAPISchemaGenIntrospectVisitor(opt_unmask)
+vis = QAPISchemaGenIntrospectVisitor(prefix, opt_unmask)
 schema.visit(vis)
 genc.body(vis.defn)
 genh.body(vis.decl)
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 97406b3368..2d711b137b 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -168,7 +168,8 @@ void qapi_free_%(c_name)s(%(c_name)s *obj)
 
 
 class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
-    def __init__(self):
+    def __init__(self, opt_builtins):
+        self._opt_builtins = opt_builtins
         self.decl = None
         self.defn = None
         self._fwdecl = None
@@ -187,7 +188,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         self._fwdecl = None
         # To avoid header dependency hell, we always generate
         # declarations for built-in types in our header files and
-        # simply guard them.  See also do_builtins (command line
+        # simply guard them.  See also opt_builtins (command line
         # option -b).
         self._btin += guardend('QAPI_TYPES_BUILTIN')
         self.decl = self._btin + self.decl
@@ -202,7 +203,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         # TODO use something cleaner than existence of info
         if not info:
             self._btin += gen_enum(name, values, prefix)
-            if do_builtins:
+            if self._opt_builtins:
                 self.defn += gen_enum_lookup(name, values, prefix)
         else:
             self._fwdecl += gen_enum(name, values, prefix)
@@ -213,7 +214,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
             self._btin += gen_fwd_object_or_array(name)
             self._btin += gen_array(name, element_type)
             self._btin += gen_type_cleanup_decl(name)
-            if do_builtins:
+            if self._opt_builtins:
                 self.defn += gen_type_cleanup(name)
         else:
             self._fwdecl += gen_fwd_object_or_array(name)
@@ -241,16 +242,16 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
 
 # If you link code generated from multiple schemata, you want only one
 # instance of the code for built-in types.  Generate it only when
-# do_builtins, enabled by command line option -b.  See also
+# opt_builtins, enabled by command line option -b.  See also
 # QAPISchemaGenTypeVisitor.visit_end().
-do_builtins = False
+opt_builtins = False
 
 (input_file, output_dir, do_c, do_h, prefix, opts) = \
     parse_command_line('b', ['builtins'])
 
 for o, a in opts:
     if o in ('-b', '--builtins'):
-        do_builtins = True
+        opt_builtins = True
 
 blurb = '''
  * Schema-defined QAPI types
@@ -272,7 +273,7 @@ genh.body(mcgen('''
 '''))
 
 schema = QAPISchema(input_file)
-vis = QAPISchemaGenTypeVisitor()
+vis = QAPISchemaGenTypeVisitor(opt_builtins)
 schema.visit(vis)
 genc.body(vis.defn)
 genh.body(vis.decl)
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index d1b25daf0d..79dc6cae48 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -264,7 +264,8 @@ out:
 
 
 class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
-    def __init__(self):
+    def __init__(self, opt_builtins):
+        self._opt_builtins = opt_builtins
         self.decl = None
         self.defn = None
         self._btin = None
@@ -277,7 +278,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
     def visit_end(self):
         # To avoid header dependency hell, we always generate
         # declarations for built-in types in our header files and
-        # simply guard them.  See also do_builtins (command line
+        # simply guard them.  See also opt_builtins (command line
         # option -b).
         self._btin += guardend('QAPI_VISIT_BUILTIN')
         self.decl = self._btin + self.decl
@@ -288,7 +289,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         # TODO use something cleaner than existence of info
         if not info:
             self._btin += gen_visit_decl(name, scalar=True)
-            if do_builtins:
+            if self._opt_builtins:
                 self.defn += gen_visit_enum(name)
         else:
             self.decl += gen_visit_decl(name, scalar=True)
@@ -299,7 +300,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         defn = gen_visit_list(name, element_type)
         if isinstance(element_type, QAPISchemaBuiltinType):
             self._btin += decl
-            if do_builtins:
+            if self._opt_builtins:
                 self.defn += defn
         else:
             self.decl += decl
@@ -324,16 +325,16 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
 
 # If you link code generated from multiple schemata, you want only one
 # instance of the code for built-in types.  Generate it only when
-# do_builtins, enabled by command line option -b.  See also
+# opt_builtins, enabled by command line option -b.  See also
 # QAPISchemaGenVisitVisitor.visit_end().
-do_builtins = False
+opt_builtins = False
 
 (input_file, output_dir, do_c, do_h, prefix, opts) = \
     parse_command_line('b', ['builtins'])
 
 for o, a in opts:
     if o in ('-b', '--builtins'):
-        do_builtins = True
+        opt_builtins = True
 
 blurb = '''
  * Schema-defined QAPI visitors
@@ -359,7 +360,7 @@ genh.body(mcgen('''
                 prefix=prefix))
 
 schema = QAPISchema(input_file)
-vis = QAPISchemaGenVisitVisitor()
+vis = QAPISchemaGenVisitVisitor(opt_builtins)
 schema.visit(vis)
 genc.body(vis.defn)
 genh.body(vis.decl)
-- 
2.13.6

Received: from eggs.gnu.org ([208.118.235.92]:35624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdQ1-0006Mx-Ft
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdMC-0005Z0-FG
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:38:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehdMB-0005Xi-Ra
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:34:28 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  2 Feb 2018 14:03:20 +0100
Message-Id: <20180202130336.24719-6-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-1-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 05/21] qapi: Turn generators into modules
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

The next commit will introduce a common driver program for all
generators.  The generators need to be modules for that.  qapi2texi.py
already is.  Make the other generators follow suit.

The changes are actually trivial.  Obvious in the diffs once you view
them with whitespace changes ignored.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi-commands.py   | 43 ++++++++++++++++++--------------
 scripts/qapi-event.py      | 43 ++++++++++++++++++--------------
 scripts/qapi-introspect.py | 54 ++++++++++++++++++++++------------------
 scripts/qapi-types.py      | 56 ++++++++++++++++++++++-------------------
 scripts/qapi-visit.py      | 62 +++++++++++++++++++++++++---------------------
 5 files changed, 143 insertions(+), 115 deletions(-)

diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index d229537659..331b58670e 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -255,16 +255,17 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
         self._regy += gen_register_command(name, success_response)
 
 
-(input_file, output_dir, do_c, do_h, prefix, opts) = parse_command_line()
+def main(argv):
+    (input_file, output_dir, do_c, do_h, prefix, opts) = parse_command_line()
 
-blurb = '''
+    blurb = '''
  * Schema-defined QAPI/QMP commands
 '''
 
-genc = QAPIGenC(blurb, __doc__)
-genh = QAPIGenH(blurb, __doc__)
+    genc = QAPIGenC(blurb, __doc__)
+    genh = QAPIGenH(blurb, __doc__)
 
-genc.body(mcgen('''
+    genc.body(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/module.h"
@@ -278,24 +279,28 @@ genc.body(mcgen('''
 #include "%(prefix)sqmp-commands.h"
 
 ''',
-                prefix=prefix))
+                    prefix=prefix))
 
-genh.body(mcgen('''
+    genh.body(mcgen('''
 #include "%(prefix)sqapi-types.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/dispatch.h"
 
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
 ''',
-                prefix=prefix, c_prefix=c_name(prefix, protect=False)))
-
-schema = QAPISchema(input_file)
-vis = QAPISchemaGenCommandVisitor(prefix)
-schema.visit(vis)
-genc.body(vis.defn)
-genh.body(vis.decl)
-
-if do_c:
-    genc.write(output_dir, prefix + 'qmp-marshal.c')
-if do_h:
-    genh.write(output_dir, prefix + 'qmp-commands.h')
+                    prefix=prefix, c_prefix=c_name(prefix, protect=False)))
+
+    schema = QAPISchema(input_file)
+    vis = QAPISchemaGenCommandVisitor(prefix)
+    schema.visit(vis)
+    genc.body(vis.defn)
+    genh.body(vis.decl)
+
+    if do_c:
+        genc.write(output_dir, prefix + 'qmp-marshal.c')
+    if do_h:
+        genh.write(output_dir, prefix + 'qmp-commands.h')
+
+
+if __name__ == '__main__':
+    main(sys.argv)
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index 1af21b580a..5b33c694d4 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -171,16 +171,17 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
         self._event_names.append(name)
 
 
-(input_file, output_dir, do_c, do_h, prefix, dummy) = parse_command_line()
+def main(argv):
+    (input_file, output_dir, do_c, do_h, prefix, dummy) = parse_command_line()
 
-blurb = '''
+    blurb = '''
  * Schema-defined QAPI/QMP events
 '''
 
-genc = QAPIGenC(blurb, __doc__)
-genh = QAPIGenH(blurb, __doc__)
+    genc = QAPIGenC(blurb, __doc__)
+    genh = QAPIGenH(blurb, __doc__)
 
-genc.body(mcgen('''
+    genc.body(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "%(prefix)sqapi-event.h"
@@ -190,23 +191,27 @@ genc.body(mcgen('''
 #include "qapi/qmp-event.h"
 
 ''',
-                prefix=prefix))
+                    prefix=prefix))
 
-genh.body(mcgen('''
+    genh.body(mcgen('''
 #include "qapi/util.h"
 #include "qapi/qmp/qdict.h"
 #include "%(prefix)sqapi-types.h"
 
 ''',
-                prefix=prefix))
-
-schema = QAPISchema(input_file)
-vis = QAPISchemaGenEventVisitor(prefix)
-schema.visit(vis)
-genc.body(vis.defn)
-genh.body(vis.decl)
-
-if do_c:
-    genc.write(output_dir, prefix + 'qapi-event.c')
-if do_h:
-    genh.write(output_dir, prefix + 'qapi-event.h')
+                    prefix=prefix))
+
+    schema = QAPISchema(input_file)
+    vis = QAPISchemaGenEventVisitor(prefix)
+    schema.visit(vis)
+    genc.body(vis.defn)
+    genh.body(vis.decl)
+
+    if do_c:
+        genc.write(output_dir, prefix + 'qapi-event.c')
+    if do_h:
+        genh.write(output_dir, prefix + 'qapi-event.h')
+
+
+if __name__ == '__main__':
+    main(sys.argv)
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 8d4e3c1c3a..09e7d1f140 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -167,38 +167,44 @@ const char %(c_name)s[] = %(c_string)s;
         arg_type = arg_type or self._schema.the_empty_object_type
         self._gen_json(name, 'event', {'arg-type': self._use_type(arg_type)})
 
-# Debugging aid: unmask QAPI schema's type names
-# We normally mask them, because they're not QMP wire ABI
-opt_unmask = False
 
-(input_file, output_dir, do_c, do_h, prefix, opts) = \
-    parse_command_line('u', ['unmask-non-abi-names'])
+def main(argv):
+    # Debugging aid: unmask QAPI schema's type names
+    # We normally mask them, because they're not QMP wire ABI
+    opt_unmask = False
 
-for o, a in opts:
-    if o in ('-u', '--unmask-non-abi-names'):
-        opt_unmask = True
+    (input_file, output_dir, do_c, do_h, prefix, opts) = \
+        parse_command_line('u', ['unmask-non-abi-names'])
 
-blurb = '''
+    for o, a in opts:
+        if o in ('-u', '--unmask-non-abi-names'):
+            opt_unmask = True
+
+    blurb = '''
  * QAPI/QMP schema introspection
 '''
 
-genc = QAPIGenC(blurb, __doc__)
-genh = QAPIGenH(blurb, __doc__)
+    genc = QAPIGenC(blurb, __doc__)
+    genh = QAPIGenH(blurb, __doc__)
 
-genc.body(mcgen('''
+    genc.body(mcgen('''
 #include "qemu/osdep.h"
 #include "%(prefix)sqmp-introspect.h"
 
 ''',
-                prefix=prefix))
-
-schema = QAPISchema(input_file)
-vis = QAPISchemaGenIntrospectVisitor(prefix, opt_unmask)
-schema.visit(vis)
-genc.body(vis.defn)
-genh.body(vis.decl)
-
-if do_c:
-    genc.write(output_dir, prefix + 'qmp-introspect.c')
-if do_h:
-    genh.write(output_dir, prefix + 'qmp-introspect.h')
+                    prefix=prefix))
+
+    schema = QAPISchema(input_file)
+    vis = QAPISchemaGenIntrospectVisitor(prefix, opt_unmask)
+    schema.visit(vis)
+    genc.body(vis.defn)
+    genh.body(vis.decl)
+
+    if do_c:
+        genc.write(output_dir, prefix + 'qmp-introspect.c')
+    if do_h:
+        genh.write(output_dir, prefix + 'qmp-introspect.h')
+
+
+if __name__ == '__main__':
+    main(sys.argv)
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 2d711b137b..f2ddde94b1 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -240,45 +240,51 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         self.decl += gen_object(name, None, [variants.tag_member], variants)
         self._gen_type_cleanup(name)
 
-# If you link code generated from multiple schemata, you want only one
-# instance of the code for built-in types.  Generate it only when
-# opt_builtins, enabled by command line option -b.  See also
-# QAPISchemaGenTypeVisitor.visit_end().
-opt_builtins = False
 
-(input_file, output_dir, do_c, do_h, prefix, opts) = \
-    parse_command_line('b', ['builtins'])
+def main(argv):
+    # If you link code generated from multiple schemata, you want only one
+    # instance of the code for built-in types.  Generate it only when
+    # opt_builtins, enabled by command line option -b.  See also
+    # QAPISchemaGenTypeVisitor.visit_end().
+    opt_builtins = False
 
-for o, a in opts:
-    if o in ('-b', '--builtins'):
-        opt_builtins = True
+    (input_file, output_dir, do_c, do_h, prefix, opts) = \
+        parse_command_line('b', ['builtins'])
 
-blurb = '''
+    for o, a in opts:
+        if o in ('-b', '--builtins'):
+            opt_builtins = True
+
+    blurb = '''
  * Schema-defined QAPI types
 '''
 
-genc = QAPIGenC(blurb, __doc__)
-genh = QAPIGenH(blurb, __doc__)
+    genc = QAPIGenC(blurb, __doc__)
+    genh = QAPIGenH(blurb, __doc__)
 
-genc.body(mcgen('''
+    genc.body(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/dealloc-visitor.h"
 #include "%(prefix)sqapi-types.h"
 #include "%(prefix)sqapi-visit.h"
 ''',
-                prefix=prefix))
+                    prefix=prefix))
 
-genh.body(mcgen('''
+    genh.body(mcgen('''
 #include "qapi/util.h"
 '''))
 
-schema = QAPISchema(input_file)
-vis = QAPISchemaGenTypeVisitor(opt_builtins)
-schema.visit(vis)
-genc.body(vis.defn)
-genh.body(vis.decl)
+    schema = QAPISchema(input_file)
+    vis = QAPISchemaGenTypeVisitor(opt_builtins)
+    schema.visit(vis)
+    genc.body(vis.defn)
+    genh.body(vis.decl)
 
-if do_c:
-    genc.write(output_dir, prefix + 'qapi-types.c')
-if do_h:
-    genh.write(output_dir, prefix + 'qapi-types.h')
+    if do_c:
+        genc.write(output_dir, prefix + 'qapi-types.c')
+    if do_h:
+        genh.write(output_dir, prefix + 'qapi-types.h')
+
+
+if __name__ == '__main__':
+    main(sys.argv)
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 79dc6cae48..473fa72574 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -323,49 +323,55 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         self.decl += gen_visit_decl(name)
         self.defn += gen_visit_alternate(name, variants)
 
-# If you link code generated from multiple schemata, you want only one
-# instance of the code for built-in types.  Generate it only when
-# opt_builtins, enabled by command line option -b.  See also
-# QAPISchemaGenVisitVisitor.visit_end().
-opt_builtins = False
 
-(input_file, output_dir, do_c, do_h, prefix, opts) = \
-    parse_command_line('b', ['builtins'])
+def main(argv):
+    # If you link code generated from multiple schemata, you want only one
+    # instance of the code for built-in types.  Generate it only when
+    # opt_builtins, enabled by command line option -b.  See also
+    # QAPISchemaGenVisitVisitor.visit_end().
+    opt_builtins = False
 
-for o, a in opts:
-    if o in ('-b', '--builtins'):
-        opt_builtins = True
+    (input_file, output_dir, do_c, do_h, prefix, opts) = \
+        parse_command_line('b', ['builtins'])
 
-blurb = '''
+    for o, a in opts:
+        if o in ('-b', '--builtins'):
+            opt_builtins = True
+
+    blurb = '''
  * Schema-defined QAPI visitors
 '''
 
-genc = QAPIGenC(blurb, __doc__)
-genh = QAPIGenH(blurb, __doc__)
+    genc = QAPIGenC(blurb, __doc__)
+    genh = QAPIGenH(blurb, __doc__)
 
-genc.body(mcgen('''
+    genc.body(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
 #include "%(prefix)sqapi-visit.h"
 ''',
-                prefix=prefix))
+                    prefix=prefix))
 
-genh.body(mcgen('''
+    genh.body(mcgen('''
 #include "qapi/visitor.h"
 #include "qapi/qmp/qerror.h"
 #include "%(prefix)sqapi-types.h"
 
 ''',
-                prefix=prefix))
-
-schema = QAPISchema(input_file)
-vis = QAPISchemaGenVisitVisitor(opt_builtins)
-schema.visit(vis)
-genc.body(vis.defn)
-genh.body(vis.decl)
-
-if do_c:
-    genc.write(output_dir, prefix + 'qapi-visit.c')
-if do_h:
-    genh.write(output_dir, prefix + 'qapi-visit.h')
+                    prefix=prefix))
+
+    schema = QAPISchema(input_file)
+    vis = QAPISchemaGenVisitVisitor(opt_builtins)
+    schema.visit(vis)
+    genc.body(vis.defn)
+    genh.body(vis.decl)
+
+    if do_c:
+        genc.write(output_dir, prefix + 'qapi-visit.c')
+    if do_h:
+        genh.write(output_dir, prefix + 'qapi-visit.h')
+
+
+if __name__ == '__main__':
+    main(sys.argv)
-- 
2.13.6

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6l-0000mX-UW
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6j-0007Pr-B1
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU6j-0007OV-1h
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:13 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:22 -0600
Message-Id: <20180301194245.29854-8-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/30] qapi: Turn generators into modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

From: Markus Armbruster <armbru@redhat.com>

The next commit will introduce a common driver program for all
generators.  The generators need to be modules for that.  qapi2texi.py
already is.  Make the other generators follow suit.

The changes are actually trivial.  Obvious in the diffs once you view
them with whitespace changes ignored.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180211093607.27351-8-armbru@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
[eblake: minor tweak to keep 'blurb' one line]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi-commands.py   | 43 ++++++++++++++++++--------------
 scripts/qapi-event.py      | 43 ++++++++++++++++++--------------
 scripts/qapi-introspect.py | 54 ++++++++++++++++++++++------------------
 scripts/qapi-types.py      | 56 ++++++++++++++++++++++------------------=
-
 scripts/qapi-visit.py      | 62 +++++++++++++++++++++++++---------------=
------
 5 files changed, 143 insertions(+), 115 deletions(-)

diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index e75e32e4898..c20b22020ed 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -255,14 +255,15 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor=
):
         self._regy +=3D gen_register_command(name, success_response)


-(input_file, output_dir, do_c, do_h, prefix, opts) =3D parse_command_lin=
e()
+def main(argv):
+    (input_file, output_dir, do_c, do_h, prefix, opts) =3D parse_command=
_line()

-blurb =3D ' * Schema-defined QAPI/QMP commands'
+    blurb =3D ' * Schema-defined QAPI/QMP commands'

-genc =3D QAPIGenC(blurb, __doc__)
-genh =3D QAPIGenH(blurb, __doc__)
+    genc =3D QAPIGenC(blurb, __doc__)
+    genh =3D QAPIGenH(blurb, __doc__)

-genc.add(mcgen('''
+    genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/module.h"
@@ -277,23 +278,27 @@ genc.add(mcgen('''
 #include "%(prefix)sqmp-commands.h"

 ''',
-               prefix=3Dprefix))
+                   prefix=3Dprefix))

-genh.add(mcgen('''
+    genh.add(mcgen('''
 #include "%(prefix)sqapi-types.h"
 #include "qapi/qmp/dispatch.h"

 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
 ''',
-               prefix=3Dprefix, c_prefix=3Dc_name(prefix, protect=3DFals=
e)))
-
-schema =3D QAPISchema(input_file)
-vis =3D QAPISchemaGenCommandVisitor(prefix)
-schema.visit(vis)
-genc.add(vis.defn)
-genh.add(vis.decl)
-
-if do_c:
-    genc.write(output_dir, prefix + 'qmp-marshal.c')
-if do_h:
-    genh.write(output_dir, prefix + 'qmp-commands.h')
+                   prefix=3Dprefix, c_prefix=3Dc_name(prefix, protect=3D=
False)))
+
+    schema =3D QAPISchema(input_file)
+    vis =3D QAPISchemaGenCommandVisitor(prefix)
+    schema.visit(vis)
+    genc.add(vis.defn)
+    genh.add(vis.decl)
+
+    if do_c:
+        genc.write(output_dir, prefix + 'qmp-marshal.c')
+    if do_h:
+        genh.write(output_dir, prefix + 'qmp-commands.h')
+
+
+if __name__ =3D=3D '__main__':
+    main(sys.argv)
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index f65ccdc8eaa..1f8bf62c8b3 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -171,14 +171,15 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
         self._event_names.append(name)


-(input_file, output_dir, do_c, do_h, prefix, dummy) =3D parse_command_li=
ne()
+def main(argv):
+    (input_file, output_dir, do_c, do_h, prefix, dummy) =3D parse_comman=
d_line()

-blurb =3D ' * Schema-defined QAPI/QMP events'
+    blurb =3D ' * Schema-defined QAPI/QMP events'

-genc =3D QAPIGenC(blurb, __doc__)
-genh =3D QAPIGenH(blurb, __doc__)
+    genc =3D QAPIGenC(blurb, __doc__)
+    genh =3D QAPIGenH(blurb, __doc__)

-genc.add(mcgen('''
+    genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "%(prefix)sqapi-event.h"
@@ -189,22 +190,26 @@ genc.add(mcgen('''
 #include "qapi/qmp-event.h"

 ''',
-               prefix=3Dprefix))
+                   prefix=3Dprefix))

-genh.add(mcgen('''
+    genh.add(mcgen('''
 #include "qapi/util.h"
 #include "%(prefix)sqapi-types.h"

 ''',
-               prefix=3Dprefix))
-
-schema =3D QAPISchema(input_file)
-vis =3D QAPISchemaGenEventVisitor(prefix)
-schema.visit(vis)
-genc.add(vis.defn)
-genh.add(vis.decl)
-
-if do_c:
-    genc.write(output_dir, prefix + 'qapi-event.c')
-if do_h:
-    genh.write(output_dir, prefix + 'qapi-event.h')
+                   prefix=3Dprefix))
+
+    schema =3D QAPISchema(input_file)
+    vis =3D QAPISchemaGenEventVisitor(prefix)
+    schema.visit(vis)
+    genc.add(vis.defn)
+    genh.add(vis.decl)
+
+    if do_c:
+        genc.write(output_dir, prefix + 'qapi-event.c')
+    if do_h:
+        genh.write(output_dir, prefix + 'qapi-event.h')
+
+
+if __name__ =3D=3D '__main__':
+    main(sys.argv)
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 5d9a7abeb8b..cac219b4d8f 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -167,36 +167,42 @@ const char %(c_name)s[] =3D %(c_string)s;
         arg_type =3D arg_type or self._schema.the_empty_object_type
         self._gen_json(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)})

-# Debugging aid: unmask QAPI schema's type names
-# We normally mask them, because they're not QMP wire ABI
-opt_unmask =3D False

-(input_file, output_dir, do_c, do_h, prefix, opts) =3D \
-    parse_command_line('u', ['unmask-non-abi-names'])
+def main(argv):
+    # Debugging aid: unmask QAPI schema's type names
+    # We normally mask them, because they're not QMP wire ABI
+    opt_unmask =3D False

-for o, a in opts:
-    if o in ('-u', '--unmask-non-abi-names'):
-        opt_unmask =3D True
+    (input_file, output_dir, do_c, do_h, prefix, opts) =3D \
+        parse_command_line('u', ['unmask-non-abi-names'])

-blurb =3D ' * QAPI/QMP schema introspection'
+    for o, a in opts:
+        if o in ('-u', '--unmask-non-abi-names'):
+            opt_unmask =3D True

-genc =3D QAPIGenC(blurb, __doc__)
-genh =3D QAPIGenH(blurb, __doc__)
+    blurb =3D ' * QAPI/QMP schema introspection'

-genc.add(mcgen('''
+    genc =3D QAPIGenC(blurb, __doc__)
+    genh =3D QAPIGenH(blurb, __doc__)
+
+    genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "%(prefix)sqmp-introspect.h"

 ''',
-               prefix=3Dprefix))
-
-schema =3D QAPISchema(input_file)
-vis =3D QAPISchemaGenIntrospectVisitor(prefix, opt_unmask)
-schema.visit(vis)
-genc.add(vis.defn)
-genh.add(vis.decl)
-
-if do_c:
-    genc.write(output_dir, prefix + 'qmp-introspect.c')
-if do_h:
-    genh.write(output_dir, prefix + 'qmp-introspect.h')
+                   prefix=3Dprefix))
+
+    schema =3D QAPISchema(input_file)
+    vis =3D QAPISchemaGenIntrospectVisitor(prefix, opt_unmask)
+    schema.visit(vis)
+    genc.add(vis.defn)
+    genh.add(vis.decl)
+
+    if do_c:
+        genc.write(output_dir, prefix + 'qmp-introspect.c')
+    if do_h:
+        genh.write(output_dir, prefix + 'qmp-introspect.h')
+
+
+if __name__ =3D=3D '__main__':
+    main(sys.argv)
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 6ef8c40d5b9..7d23544228b 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -240,43 +240,49 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         self.decl +=3D gen_object(name, None, [variants.tag_member], var=
iants)
         self._gen_type_cleanup(name)

-# If you link code generated from multiple schemata, you want only one
-# instance of the code for built-in types.  Generate it only when
-# opt_builtins, enabled by command line option -b.  See also
-# QAPISchemaGenTypeVisitor.visit_end().
-opt_builtins =3D False

-(input_file, output_dir, do_c, do_h, prefix, opts) =3D \
-    parse_command_line('b', ['builtins'])
+def main(argv):
+    # If you link code generated from multiple schemata, you want only o=
ne
+    # instance of the code for built-in types.  Generate it only when
+    # opt_builtins, enabled by command line option -b.  See also
+    # QAPISchemaGenTypeVisitor.visit_end().
+    opt_builtins =3D False

-for o, a in opts:
-    if o in ('-b', '--builtins'):
-        opt_builtins =3D True
+    (input_file, output_dir, do_c, do_h, prefix, opts) =3D \
+        parse_command_line('b', ['builtins'])

-blurb =3D ' * Schema-defined QAPI types'
+    for o, a in opts:
+        if o in ('-b', '--builtins'):
+            opt_builtins =3D True

-genc =3D QAPIGenC(blurb, __doc__)
-genh =3D QAPIGenH(blurb, __doc__)
+    blurb =3D ' * Schema-defined QAPI types'

-genc.add(mcgen('''
+    genc =3D QAPIGenC(blurb, __doc__)
+    genh =3D QAPIGenH(blurb, __doc__)
+
+    genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/dealloc-visitor.h"
 #include "%(prefix)sqapi-types.h"
 #include "%(prefix)sqapi-visit.h"
 ''',
-               prefix=3Dprefix))
+                   prefix=3Dprefix))

-genh.add(mcgen('''
+    genh.add(mcgen('''
 #include "qapi/util.h"
 '''))

-schema =3D QAPISchema(input_file)
-vis =3D QAPISchemaGenTypeVisitor(opt_builtins)
-schema.visit(vis)
-genc.add(vis.defn)
-genh.add(vis.decl)
+    schema =3D QAPISchema(input_file)
+    vis =3D QAPISchemaGenTypeVisitor(opt_builtins)
+    schema.visit(vis)
+    genc.add(vis.defn)
+    genh.add(vis.decl)

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
+if __name__ =3D=3D '__main__':
+    main(sys.argv)
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index d5ca4804215..3c23a9389d4 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -323,47 +323,53 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         self.decl +=3D gen_visit_decl(name)
         self.defn +=3D gen_visit_alternate(name, variants)

-# If you link code generated from multiple schemata, you want only one
-# instance of the code for built-in types.  Generate it only when
-# opt_builtins, enabled by command line option -b.  See also
-# QAPISchemaGenVisitVisitor.visit_end().
-opt_builtins =3D False

-(input_file, output_dir, do_c, do_h, prefix, opts) =3D \
-    parse_command_line('b', ['builtins'])
+def main(argv):
+    # If you link code generated from multiple schemata, you want only o=
ne
+    # instance of the code for built-in types.  Generate it only when
+    # opt_builtins, enabled by command line option -b.  See also
+    # QAPISchemaGenVisitVisitor.visit_end().
+    opt_builtins =3D False

-for o, a in opts:
-    if o in ('-b', '--builtins'):
-        opt_builtins =3D True
+    (input_file, output_dir, do_c, do_h, prefix, opts) =3D \
+        parse_command_line('b', ['builtins'])

-blurb =3D ' * Schema-defined QAPI visitors'
+    for o, a in opts:
+        if o in ('-b', '--builtins'):
+            opt_builtins =3D True

-genc =3D QAPIGenC(blurb, __doc__)
-genh =3D QAPIGenH(blurb, __doc__)
+    blurb =3D ' * Schema-defined QAPI visitors'

-genc.add(mcgen('''
+    genc =3D QAPIGenC(blurb, __doc__)
+    genh =3D QAPIGenH(blurb, __doc__)
+
+    genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "%(prefix)sqapi-visit.h"
 ''',
-               prefix=3Dprefix))
+                   prefix=3Dprefix))

-genh.add(mcgen('''
+    genh.add(mcgen('''
 #include "qapi/visitor.h"
 #include "%(prefix)sqapi-types.h"

 ''',
-               prefix=3Dprefix))
-
-schema =3D QAPISchema(input_file)
-vis =3D QAPISchemaGenVisitVisitor(opt_builtins)
-schema.visit(vis)
-genc.add(vis.defn)
-genh.add(vis.decl)
-
-if do_c:
-    genc.write(output_dir, prefix + 'qapi-visit.c')
-if do_h:
-    genh.write(output_dir, prefix + 'qapi-visit.h')
+                   prefix=3Dprefix))
+
+    schema =3D QAPISchema(input_file)
+    vis =3D QAPISchemaGenVisitVisitor(opt_builtins)
+    schema.visit(vis)
+    genc.add(vis.defn)
+    genh.add(vis.decl)
+
+    if do_c:
+        genc.write(output_dir, prefix + 'qapi-visit.c')
+    if do_h:
+        genh.write(output_dir, prefix + 'qapi-visit.h')
+
+
+if __name__ =3D=3D '__main__':
+    main(sys.argv)
--=20
2.14.3

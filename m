Received: from eggs.gnu.org ([2001:4830:134:3::10]:54132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3f-000745-Ob
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3Y-0006MG-8X
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53994 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eko3X-0006HX-I9
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:19 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 11 Feb 2018 10:35:43 +0100
Message-Id: <20180211093607.27351-6-armbru@redhat.com>
In-Reply-To: <20180211093607.27351-1-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/29] qapi: New classes QAPIGenC, QAPIGenH,
 QAPIGenDoc
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

These classes encapsulate accumulating and writing output.

Convert C code generation to QAPIGenC and QAPIGenH.  The conversion is
rather shallow: most of the output accumulation is not converted.
Left for later.

The indentation machinery uses a single global variable indent_level,
even though we generally interleave creation of a .c and its .h.  It
should become instance variable of QAPIGenC.  Also left for later.

Documentation generation isn't converted, and QAPIGenDoc isn't used.
This will change shortly.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi-commands.py   | 23 +++++------
 scripts/qapi-event.py      | 22 ++++++-----
 scripts/qapi-introspect.py | 18 +++++----
 scripts/qapi-types.py      | 22 ++++++-----
 scripts/qapi-visit.py      | 22 ++++++-----
 scripts/qapi.py            | 99 +++++++++++++++++++++++++---------------=
------
 6 files changed, 112 insertions(+), 94 deletions(-)

diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index c3aa52fce1..8d38ade076 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -260,12 +260,10 @@ blurb =3D '''
  * Schema-defined QAPI/QMP commands
 '''
=20
-(fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
-                            'qmp-marshal.c', 'qmp-commands.h',
-                            blurb, __doc__)
-
-fdef.write(mcgen('''
+genc =3D QAPIGenC(blurb, __doc__)
+genh =3D QAPIGenH(blurb, __doc__)
=20
+genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/module.h"
@@ -280,20 +278,23 @@ fdef.write(mcgen('''
 #include "%(prefix)sqmp-commands.h"
=20
 ''',
-                 prefix=3Dprefix))
+               prefix=3Dprefix))
=20
-fdecl.write(mcgen('''
+genh.add(mcgen('''
 #include "%(prefix)sqapi-types.h"
 #include "qapi/qmp/dispatch.h"
=20
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
 ''',
-                  prefix=3Dprefix, c_prefix=3Dc_name(prefix, protect=3DF=
alse)))
+               prefix=3Dprefix, c_prefix=3Dc_name(prefix, protect=3DFals=
e)))
=20
 schema =3D QAPISchema(input_file)
 vis =3D QAPISchemaGenCommandVisitor()
 schema.visit(vis)
-fdef.write(vis.defn)
-fdecl.write(vis.decl)
+genc.add(vis.defn)
+genh.add(vis.decl)
=20
-close_output(fdef, fdecl)
+if do_c:
+    genc.write(output_dir, prefix + 'qmp-marshal.c')
+if do_h:
+    genh.write(output_dir, prefix + 'qmp-commands.h')
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index edb9ddb650..bd7a9be3dc 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -176,11 +176,10 @@ blurb =3D '''
  * Schema-defined QAPI/QMP events
 '''
=20
-(fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
-                            'qapi-event.c', 'qapi-event.h',
-                            blurb, __doc__)
+genc =3D QAPIGenC(blurb, __doc__)
+genh =3D QAPIGenH(blurb, __doc__)
=20
-fdef.write(mcgen('''
+genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "%(prefix)sqapi-event.h"
@@ -191,21 +190,24 @@ fdef.write(mcgen('''
 #include "qapi/qmp-event.h"
=20
 ''',
-                 prefix=3Dprefix))
+               prefix=3Dprefix))
=20
-fdecl.write(mcgen('''
+genh.add(mcgen('''
 #include "qapi/util.h"
 #include "%(prefix)sqapi-types.h"
=20
 ''',
-                  prefix=3Dprefix))
+               prefix=3Dprefix))
=20
 event_enum_name =3D c_name(prefix + 'QAPIEvent', protect=3DFalse)
=20
 schema =3D QAPISchema(input_file)
 vis =3D QAPISchemaGenEventVisitor()
 schema.visit(vis)
-fdef.write(vis.defn)
-fdecl.write(vis.decl)
+genc.add(vis.defn)
+genh.add(vis.decl)
=20
-close_output(fdef, fdecl)
+if do_c:
+    genc.write(output_dir, prefix + 'qapi-event.c')
+if do_h:
+    genh.write(output_dir, prefix + 'qapi-event.h')
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index ebe8706f41..3d65690fe3 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -181,21 +181,23 @@ blurb =3D '''
  * QAPI/QMP schema introspection
 '''
=20
-(fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
-                            'qmp-introspect.c', 'qmp-introspect.h',
-                            blurb, __doc__)
+genc =3D QAPIGenC(blurb, __doc__)
+genh =3D QAPIGenH(blurb, __doc__)
=20
-fdef.write(mcgen('''
+genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "%(prefix)sqmp-introspect.h"
=20
 ''',
-                 prefix=3Dprefix))
+               prefix=3Dprefix))
=20
 schema =3D QAPISchema(input_file)
 vis =3D QAPISchemaGenIntrospectVisitor(opt_unmask)
 schema.visit(vis)
-fdef.write(vis.defn)
-fdecl.write(vis.decl)
+genc.add(vis.defn)
+genh.add(vis.decl)
=20
-close_output(fdef, fdecl)
+if do_c:
+    genc.write(output_dir, prefix + 'qmp-introspect.c')
+if do_h:
+    genh.write(output_dir, prefix + 'qmp-introspect.h')
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 4db8424da1..c0ac879beb 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -180,7 +180,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         self.decl =3D ''
         self.defn =3D ''
         self._fwdecl =3D ''
-        self._btin =3D guardstart('QAPI_TYPES_BUILTIN')
+        self._btin =3D '\n' + guardstart('QAPI_TYPES_BUILTIN')
=20
     def visit_end(self):
         self.decl =3D self._fwdecl + self.decl
@@ -256,26 +256,28 @@ blurb =3D '''
  * Schema-defined QAPI types
 '''
=20
-(fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
-                            'qapi-types.c', 'qapi-types.h',
-                            blurb, __doc__)
+genc =3D QAPIGenC(blurb, __doc__)
+genh =3D QAPIGenH(blurb, __doc__)
=20
-fdef.write(mcgen('''
+genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/dealloc-visitor.h"
 #include "%(prefix)sqapi-types.h"
 #include "%(prefix)sqapi-visit.h"
 ''',
-                 prefix=3Dprefix))
+               prefix=3Dprefix))
=20
-fdecl.write(mcgen('''
+genh.add(mcgen('''
 #include "qapi/util.h"
 '''))
=20
 schema =3D QAPISchema(input_file)
 vis =3D QAPISchemaGenTypeVisitor()
 schema.visit(vis)
-fdef.write(vis.defn)
-fdecl.write(vis.decl)
+genc.add(vis.defn)
+genh.add(vis.decl)
=20
-close_output(fdef, fdecl)
+if do_c:
+    genc.write(output_dir, prefix + 'qapi-types.c')
+if do_h:
+    genh.write(output_dir, prefix + 'qapi-types.h')
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 3c1a0e2544..888c686303 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -339,30 +339,32 @@ blurb =3D '''
  * Schema-defined QAPI visitors
 '''
=20
-(fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
-                            'qapi-visit.c', 'qapi-visit.h',
-                            blurb, __doc__)
+genc =3D QAPIGenC(blurb, __doc__)
+genh =3D QAPIGenH(blurb, __doc__)
=20
-fdef.write(mcgen('''
+genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "%(prefix)sqapi-visit.h"
 ''',
-                 prefix=3Dprefix))
+               prefix=3Dprefix))
=20
-fdecl.write(mcgen('''
+genh.add(mcgen('''
 #include "qapi/visitor.h"
 #include "%(prefix)sqapi-types.h"
=20
 ''',
-                  prefix=3Dprefix))
+               prefix=3Dprefix))
=20
 schema =3D QAPISchema(input_file)
 vis =3D QAPISchemaGenVisitVisitor()
 schema.visit(vis)
-fdef.write(vis.defn)
-fdecl.write(vis.decl)
+genc.add(vis.defn)
+genh.add(vis.decl)
=20
-close_output(fdef, fdecl)
+if do_c:
+    genc.write(output_dir, prefix + 'qapi-visit.c')
+if do_h:
+    genh.write(output_dir, prefix + 'qapi-visit.h')
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 26c45cee34..9693fd1851 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -2,7 +2,7 @@
 # QAPI helper library
 #
 # Copyright IBM, Corp. 2011
-# Copyright (c) 2013-2016 Red Hat Inc.
+# Copyright (c) 2013-2018 Red Hat Inc.
 #
 # Authors:
 #  Anthony Liguori <aliguori@us.ibm.com>
@@ -22,10 +22,6 @@ try:
     from collections import OrderedDict
 except:
     from ordereddict import OrderedDict
-try:
-    from StringIO import StringIO
-except ImportError:
-    from io import StringIO
=20
 builtin_types =3D {
     'null':     'QTYPE_QNULL',
@@ -1831,7 +1827,6 @@ def guardname(filename):
=20
 def guardstart(name):
     return mcgen('''
-
 #ifndef %(name)s
 #define %(name)s
=20
@@ -1843,7 +1838,6 @@ def guardend(name):
     return mcgen('''
=20
 #endif /* %(name)s */
-
 ''',
                  name=3Dguardname(name))
=20
@@ -1980,17 +1974,53 @@ def parse_command_line(extra_options=3D'', extra_=
long_options=3D[]):
=20
     return (fname, output_dir, do_c, do_h, prefix, extra_opts)
=20
+
 #
-# Generate output files with boilerplate
+# Accumulate and write output
 #
=20
+class QAPIGen(object):
+
+    def __init__(self):
+        self._preamble =3D ''
+        self._body =3D ''
+
+    def preamble_add(self, text):
+        self._preamble +=3D text
+
+    def add(self, text):
+        self._body +=3D text
+
+    def _top(self, fname):
+        return ''
+
+    def _bottom(self, fname):
+        return ''
+
+    def write(self, output_dir, fname):
+        if output_dir:
+            try:
+                os.makedirs(output_dir)
+            except os.error as e:
+                if e.errno !=3D errno.EEXIST:
+                    raise
+        f =3D open(os.path.join(output_dir, fname), 'w')
+        f.write(self._top(fname) + self._preamble + self._body
+                + self._bottom(fname))
+        f.close()
+
+
+class QAPIGenC(QAPIGen):
+
+    def __init__(self, blurb, pydoc):
+        QAPIGen.__init__(self)
+        self._blurb =3D blurb.strip('\n')
+        self._copyright =3D '\n * '.join(re.findall(r'^Copyright .*', py=
doc,
+                                                  re.MULTILINE))
=20
-def open_output(output_dir, do_c, do_h, prefix, c_file, h_file, blurb, d=
oc):
-    guard =3D guardname(prefix + h_file)
-    c_file =3D output_dir + prefix + c_file
-    h_file =3D output_dir + prefix + h_file
-    copyright =3D '\n * '.join(re.findall(r'^Copyright .*', doc, re.MULT=
ILINE))
-    comment =3D mcgen('''/* AUTOMATICALLY GENERATED, DO NOT MODIFY */
+    def _top(self, fname):
+        return mcgen('''
+/* AUTOMATICALLY GENERATED, DO NOT MODIFY */
=20
 /*
 %(blurb)s
@@ -2002,40 +2032,19 @@ def open_output(output_dir, do_c, do_h, prefix, c=
_file, h_file, blurb, doc):
  */
=20
 ''',
-                    blurb=3Dblurb.strip('\n'), copyright=3Dcopyright)
+                     blurb=3Dself._blurb, copyright=3Dself._copyright)
=20
-    if output_dir:
-        try:
-            os.makedirs(output_dir)
-        except os.error as e:
-            if e.errno !=3D errno.EEXIST:
-                raise
=20
-    def maybe_open(really, name, opt):
-        if really:
-            return open(name, opt)
-        else:
-            return StringIO()
+class QAPIGenH(QAPIGenC):
=20
-    fdef =3D maybe_open(do_c, c_file, 'w')
-    fdecl =3D maybe_open(do_h, h_file, 'w')
+    def _top(self, fname):
+        return QAPIGenC._top(self, fname) + guardstart(fname)
=20
-    fdef.write(comment)
-    fdecl.write(comment)
-    fdecl.write(mcgen('''
-#ifndef %(guard)s
-#define %(guard)s
+    def _bottom(self, fname):
+        return guardend(fname)
=20
-''',
-                      guard=3Dguard))
=20
-    return (fdef, fdecl)
-
-
-def close_output(fdef, fdecl):
-    fdecl.write(mcgen('''
-
-#endif
-'''))
-    fdecl.close()
-    fdef.close()
+class QAPIGenDoc(QAPIGen):
+    def _top(self, fname):
+        return (QAPIGen._top(self, fname)
+                + '@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n\n')
--=20
2.13.6

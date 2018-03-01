Received: from eggs.gnu.org ([2001:4830:134:3::10]:40677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6z-0000zP-Km
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6x-0007mn-EG
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU6x-0007l3-4h
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C431C0587E3
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 19:43:26 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:35 -0600
Message-Id: <20180301194245.29854-21-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/30] qapi/types qapi/visit: Generate built-in
 stuff into separate files
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

Linking code from multiple separate QAPI schemata into the same
program is possible, but involves some weirdness around built-in
types:

* We generate code for built-in types into .c only with option
  --builtins.  The user is responsible for generating code for exactly
  one QAPI schema per program with --builtins.

* We generate code for built-in types into .h regardless of
  --builtins, but guarded by #ifndef QAPI_VISIT_BUILTIN.  Because all
  copies of this code are exactly the same, including any combination
  of these headers works.

Replace this contraption by something more conventional: generate code
for built-in types into their very own files: qapi-builtin-types.c,
qapi-builtin-visit.c, qapi-builtin-types.h, qapi-builtin-visit.h, but
only with --builtins.  Obey --output-dir, but ignore --prefix for
them.

Make qapi-types.h include qapi-builtin-types.h.  With multiple
schemata you now have multiple qapi-types.[ch], but only one
qapi-builtin-types.[ch].  Same for qapi-visit.[ch] and
qapi-builtin-visit.[ch].

Bonus: if all you need is built-in stuff, you can include a much
smaller header.  To be exploited shortly.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180211093607.27351-21-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
[eblake: fix octal constant for python 3]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 Makefile               | 13 ++++++----
 Makefile.objs          |  2 ++
 scripts/qapi/common.py | 60 +++++++++++++++++++++++++++++++++++++++-----=
--
 scripts/qapi/types.py  | 61 +++++++++++++++++++-------------------------=
---
 scripts/qapi/visit.py  | 64 +++++++++++++++++++++-----------------------=
------
 .gitignore             |  2 ++
 6 files changed, 115 insertions(+), 87 deletions(-)

diff --git a/Makefile b/Makefile
index b9f320f6ba7..494ae382794 100644
--- a/Makefile
+++ b/Makefile
@@ -90,10 +90,13 @@ endif
 include $(SRC_PATH)/rules.mak

 GENERATED_FILES =3D qemu-version.h config-host.h qemu-options.def
-GENERATED_FILES +=3D qmp-commands.h qapi-types.h qapi-visit.h qapi-event=
.h
-GENERATED_FILES +=3D qmp-commands.c qapi-types.c qapi-visit.c qapi-event=
.c
-GENERATED_FILES +=3D qmp-introspect.h
-GENERATED_FILES +=3D qmp-introspect.c
+GENERATED_FILES +=3D qapi-builtin-types.h qapi-builtin-types.c
+GENERATED_FILES +=3D qapi-types.h qapi-types.c
+GENERATED_FILES +=3D qapi-builtin-visit.h qapi-builtin-visit.c
+GENERATED_FILES +=3D qapi-visit.h qapi-visit.c
+GENERATED_FILES +=3D qmp-commands.h qmp-commands.c
+GENERATED_FILES +=3D qapi-event.h qapi-event.c
+GENERATED_FILES +=3D qmp-introspect.c qmp-introspect.h
 GENERATED_FILES +=3D qapi-doc.texi

 GENERATED_FILES +=3D trace/generated-tcg-tracers.h
@@ -519,7 +522,9 @@ qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_P=
ATH)/qapi/common.json \
                $(SRC_PATH)/qapi/transaction.json \
                $(SRC_PATH)/qapi/ui.json

+qapi-builtin-types.c qapi-builtin-types.h \
 qapi-types.c qapi-types.h \
+qapi-builtin-visit.c qapi-builtin-visit.h \
 qapi-visit.c qapi-visit.h \
 qmp-commands.h qmp-commands.c \
 qapi-event.c qapi-event.h \
diff --git a/Makefile.objs b/Makefile.objs
index 7aa67d89f8e..2ace9c13b9d 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -2,6 +2,8 @@
 # Common libraries for tools and emulators
 stub-obj-y =3D stubs/ crypto/
 util-obj-y =3D util/ qobject/ qapi/
+util-obj-y +=3D qapi-builtin-types.o
+util-obj-y +=3D qapi-builtin-visit.o
 util-obj-y +=3D qmp-introspect.o qapi-types.o qapi-visit.o qapi-event.o

 chardev-obj-y =3D chardev/
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 23437b558f6..547656c8b29 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1531,11 +1531,10 @@ class QAPISchema(object):

     def _def_builtin_type(self, name, json_type, c_type):
         self._def_entity(QAPISchemaBuiltinType(name, json_type, c_type))
-        # TODO As long as we have QAPI_TYPES_BUILTIN to share multiple
-        # qapi-types.h from a single .c, all arrays of builtins must be
-        # declared in the first file whether or not they are used.  Nice=
r
-        # would be to use lazy instantiation, while figuring out how to
-        # avoid compilation issues with multiple qapi-types.h.
+        # Instantiating only the arrays that are actually used would
+        # be nice, but we can't as long as their generated code
+        # (qapi-builtin-types.[ch]) may be shared by some other
+        # schema.
         self._make_array_type(name, None)

     def _def_predefineds(self):
@@ -1992,14 +1991,15 @@ class QAPIGen(object):
         return ''

     def write(self, output_dir, fname):
-        if output_dir:
+        pathname =3D os.path.join(output_dir, fname)
+        dir =3D os.path.dirname(pathname)
+        if dir:
             try:
-                os.makedirs(output_dir)
+                os.makedirs(dir)
             except os.error as e:
                 if e.errno !=3D errno.EEXIST:
                     raise
-        fd =3D os.open(os.path.join(output_dir, fname),
-                     os.O_RDWR | os.O_CREAT, 0o666)
+        fd =3D os.open(pathname, os.O_RDWR | os.O_CREAT, 0o666)
         f =3D os.fdopen(fd, 'r+')
         text =3D (self._top(fname) + self._preamble + self._body
                 + self._bottom(fname))
@@ -2063,3 +2063,45 @@ class QAPISchemaMonolithicCVisitor(QAPISchemaVisit=
or):
     def write(self, output_dir):
         self._genc.write(output_dir, self._prefix + self._what + '.c')
         self._genh.write(output_dir, self._prefix + self._what + '.h')
+
+
+class QAPISchemaModularCVisitor(QAPISchemaVisitor):
+
+    def __init__(self, prefix, what, blurb, pydoc):
+        self._prefix =3D prefix
+        self._what =3D what
+        self._blurb =3D blurb
+        self._pydoc =3D pydoc
+        self._module =3D {}
+
+    def _module_basename(self, what, name):
+        if name is None:
+            return re.sub(r'-', '-builtin-', what)
+        return self._prefix + what
+
+    def _add_module(self, name, blurb):
+        genc =3D QAPIGenC(blurb, self._pydoc)
+        genh =3D QAPIGenH(blurb, self._pydoc)
+        self._module[name] =3D (genc, genh)
+        self._set_module(name)
+
+    def _set_module(self, name):
+        self._genc, self._genh =3D self._module[name]
+
+    def write(self, output_dir, opt_builtins):
+        for name in self._module:
+            if name is None and not opt_builtins:
+                continue
+            basename =3D self._module_basename(self._what, name)
+            (genc, genh) =3D self._module[name]
+            genc.write(output_dir, basename + '.c')
+            genh.write(output_dir, basename + '.h')
+
+    def _begin_module(self, name):
+        pass
+
+    def visit_module(self, name):
+        if len(self._module) !=3D 1:
+            return
+        self._add_module(name, self._blurb)
+        self._begin_module(name)
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index d2b84234797..59826b11625 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -167,64 +167,51 @@ void qapi_free_%(c_name)s(%(c_name)s *obj)
     return ret


-class QAPISchemaGenTypeVisitor(QAPISchemaMonolithicCVisitor):
+class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):

-    def __init__(self, prefix, opt_builtins):
-        QAPISchemaMonolithicCVisitor.__init__(
+    def __init__(self, prefix):
+        QAPISchemaModularCVisitor.__init__(
             self, prefix, 'qapi-types', ' * Schema-defined QAPI types',
             __doc__)
-        self._opt_builtins =3D opt_builtins
+        self._add_module(None, ' * Built-in QAPI types')
+        self._genc.preamble_add(mcgen('''
+#include "qemu/osdep.h"
+#include "qapi/dealloc-visitor.h"
+#include "qapi-builtin-types.h"
+#include "qapi-builtin-visit.h"
+'''))
+        self._genh.preamble_add(mcgen('''
+#include "qapi/util.h"
+'''))
+
+    def _begin_module(self, name):
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/dealloc-visitor.h"
 #include "%(prefix)sqapi-types.h"
 #include "%(prefix)sqapi-visit.h"
 ''',
-                                      prefix=3Dprefix))
+                                      prefix=3Dself._prefix))
         self._genh.preamble_add(mcgen('''
-#include "qapi/util.h"
+#include "qapi-builtin-types.h"
 '''))
-        self._btin =3D '\n' + guardstart('QAPI_TYPES_BUILTIN')

     def visit_begin(self, schema):
         # gen_object() is recursive, ensure it doesn't visit the empty t=
ype
         objects_seen.add(schema.the_empty_object_type.name)

-    def visit_end(self):
-        # To avoid header dependency hell, we always generate
-        # declarations for built-in types in our header files and
-        # simply guard them.  See also opt_builtins (command line
-        # option -b).
-        self._btin +=3D guardend('QAPI_TYPES_BUILTIN')
-        self._genh.preamble_add(self._btin)
-        self._btin =3D None
-
     def _gen_type_cleanup(self, name):
         self._genh.add(gen_type_cleanup_decl(name))
         self._genc.add(gen_type_cleanup(name))

     def visit_enum_type(self, name, info, values, prefix):
-        # Special case for our lone builtin enum type
-        # TODO use something cleaner than existence of info
-        if not info:
-            self._btin +=3D gen_enum(name, values, prefix)
-            if self._opt_builtins:
-                self._genc.add(gen_enum_lookup(name, values, prefix))
-        else:
-            self._genh.preamble_add(gen_enum(name, values, prefix))
-            self._genc.add(gen_enum_lookup(name, values, prefix))
+        self._genh.preamble_add(gen_enum(name, values, prefix))
+        self._genc.add(gen_enum_lookup(name, values, prefix))

     def visit_array_type(self, name, info, element_type):
-        if isinstance(element_type, QAPISchemaBuiltinType):
-            self._btin +=3D gen_fwd_object_or_array(name)
-            self._btin +=3D gen_array(name, element_type)
-            self._btin +=3D gen_type_cleanup_decl(name)
-            if self._opt_builtins:
-                self._genc.add(gen_type_cleanup(name))
-        else:
-            self._genh.preamble_add(gen_fwd_object_or_array(name))
-            self._genh.add(gen_array(name, element_type))
-            self._gen_type_cleanup(name)
+        self._genh.preamble_add(gen_fwd_object_or_array(name))
+        self._genh.add(gen_array(name, element_type))
+        self._gen_type_cleanup(name)

     def visit_object_type(self, name, info, base, members, variants):
         # Nothing to do for the special empty builtin
@@ -248,6 +235,6 @@ class QAPISchemaGenTypeVisitor(QAPISchemaMonolithicCV=
isitor):


 def gen_types(schema, output_dir, prefix, opt_builtins):
-    vis =3D QAPISchemaGenTypeVisitor(prefix, opt_builtins)
+    vis =3D QAPISchemaGenTypeVisitor(prefix)
     schema.visit(vis)
-    vis.write(output_dir)
+    vis.write(output_dir, opt_builtins)
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 3d09d442650..9b678e72634 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -263,13 +263,27 @@ out:
                  c_name=3Dc_name(name))


-class QAPISchemaGenVisitVisitor(QAPISchemaMonolithicCVisitor):
+class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisitor):

-    def __init__(self, prefix, opt_builtins):
-        QAPISchemaMonolithicCVisitor.__init__(
+    def __init__(self, prefix):
+        QAPISchemaModularCVisitor.__init__(
             self, prefix, 'qapi-visit', ' * Schema-defined QAPI visitors=
',
             __doc__)
-        self._opt_builtins =3D opt_builtins
+        self._add_module(None, ' * Built-in QAPI visitors')
+        self._genc.preamble_add(mcgen('''
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "qapi-builtin-visit.h"
+'''))
+        self._genh.preamble_add(mcgen('''
+#include "qapi/visitor.h"
+#include "qapi-builtin-types.h"
+
+''',
+                                      prefix=3Dprefix))
+
+    def _begin_module(self, name):
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
@@ -277,45 +291,21 @@ class QAPISchemaGenVisitVisitor(QAPISchemaMonolithi=
cCVisitor):
 #include "qapi/qmp/qerror.h"
 #include "%(prefix)sqapi-visit.h"
 ''',
-                                      prefix=3Dprefix))
+                                      prefix=3Dself._prefix))
         self._genh.preamble_add(mcgen('''
-#include "qapi/visitor.h"
+#include "qapi-builtin-visit.h"
 #include "%(prefix)sqapi-types.h"

 ''',
-                                      prefix=3Dprefix))
-        self._btin =3D guardstart('QAPI_VISIT_BUILTIN')
-
-    def visit_end(self):
-        # To avoid header dependency hell, we always generate
-        # declarations for built-in types in our header files and
-        # simply guard them.  See also opt_builtins (command line
-        # option -b).
-        self._btin +=3D guardend('QAPI_VISIT_BUILTIN')
-        self._genh.preamble_add(self._btin)
-        self._btin =3D None
+                                      prefix=3Dself._prefix))

     def visit_enum_type(self, name, info, values, prefix):
-        # Special case for our lone builtin enum type
-        # TODO use something cleaner than existence of info
-        if not info:
-            self._btin +=3D gen_visit_decl(name, scalar=3DTrue)
-            if self._opt_builtins:
-                self._genc.add(gen_visit_enum(name))
-        else:
-            self._genh.add(gen_visit_decl(name, scalar=3DTrue))
-            self._genc.add(gen_visit_enum(name))
+        self._genh.add(gen_visit_decl(name, scalar=3DTrue))
+        self._genc.add(gen_visit_enum(name))

     def visit_array_type(self, name, info, element_type):
-        decl =3D gen_visit_decl(name)
-        defn =3D gen_visit_list(name, element_type)
-        if isinstance(element_type, QAPISchemaBuiltinType):
-            self._btin +=3D decl
-            if self._opt_builtins:
-                self._genc.add(defn)
-        else:
-            self._genh.add(decl)
-            self._genc.add(defn)
+        self._genh.add(gen_visit_decl(name))
+        self._genc.add(gen_visit_list(name, element_type))

     def visit_object_type(self, name, info, base, members, variants):
         # Nothing to do for the special empty builtin
@@ -336,6 +326,6 @@ class QAPISchemaGenVisitVisitor(QAPISchemaMonolithicC=
Visitor):


 def gen_visit(schema, output_dir, prefix, opt_builtins):
-    vis =3D QAPISchemaGenVisitVisitor(prefix, opt_builtins)
+    vis =3D QAPISchemaGenVisitVisitor(prefix)
     schema.visit(vis)
-    vis.write(output_dir)
+    vis.write(output_dir, opt_builtins)
diff --git a/.gitignore b/.gitignore
index 7d783e6e66b..9477a08b6b3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -29,6 +29,8 @@
 /qga/qapi-generated
 /qapi-generated
 /qapi-gen-timestamp
+/qapi-builtin-types.[ch]
+/qapi-builtin-visit.[ch]
 /qapi-types.[ch]
 /qapi-visit.[ch]
 /qapi-event.[ch]
--=20
2.14.3

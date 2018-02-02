Received: from eggs.gnu.org ([208.118.235.92]:55862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdOj-0002hf-P7
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdKW-0003XA-I9
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:37:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehdKW-0003VR-0Z
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:32:44 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  2 Feb 2018 14:03:31 +0100
Message-Id: <20180202130336.24719-17-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-1-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 16/21] qapi/types qapi/visit: Make visitors
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
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

The conversion is rather shallow so far: most of the output
accumulation is not converted.  Take the next step: convert output
accumulation in QAPISchemaGenTypeVisitor and
QAPISchemaGenVisitVisitor.  Helper functions outside these classes are
not converted.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/types.py | 83 +++++++++++++++++++++++----------------------------
 scripts/qapi/visit.py | 83 +++++++++++++++++++++++----------------------------
 2 files changed, 74 insertions(+), 92 deletions(-)

diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index b2095120e0..eeffcbf32c 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -168,35 +168,44 @@ void qapi_free_%(c_name)s(%(c_name)s *obj)
 
 
 class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
-    def __init__(self, opt_builtins):
+    def __init__(self, opt_builtins, prefix):
         self._opt_builtins = opt_builtins
-        self.decl = None
-        self.defn = None
-        self._fwdecl = None
-        self._btin = None
+        self._prefix = prefix
+        blurb = ' * Schema-defined QAPI types'
+        self._genc = QAPIGenC(blurb, __doc__)
+        self._genh = QAPIGenH(blurb, __doc__)
+        self._genc.preamble(mcgen('''
+#include "qemu/osdep.h"
+#include "qapi/dealloc-visitor.h"
+#include "%(prefix)sqapi-types.h"
+#include "%(prefix)sqapi-visit.h"
+''',
+                                  prefix=prefix))
+        self._genh.preamble(mcgen('''
+#include "qapi/util.h"
+'''))
+        self._btin = '\n' + guardstart('QAPI_TYPES_BUILTIN')
+
+    def write(self, output_dir):
+        self._genc.write(output_dir, self._prefix + 'qapi-types.c')
+        self._genh.write(output_dir, self._prefix + 'qapi-types.h')
 
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
+        self._genh.preamble(self._btin)
         self._btin = None
 
     def _gen_type_cleanup(self, name):
-        self.decl += gen_type_cleanup_decl(name)
-        self.defn += gen_type_cleanup(name)
+        self._genh.body(gen_type_cleanup_decl(name))
+        self._genc.body(gen_type_cleanup(name))
 
     def visit_enum_type(self, name, info, values, prefix):
         # Special case for our lone builtin enum type
@@ -204,10 +213,10 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         if not info:
             self._btin += gen_enum(name, values, prefix)
             if self._opt_builtins:
-                self.defn += gen_enum_lookup(name, values, prefix)
+                self._genc.body(gen_enum_lookup(name, values, prefix))
         else:
-            self._fwdecl += gen_enum(name, values, prefix)
-            self.defn += gen_enum_lookup(name, values, prefix)
+            self._genh.preamble(gen_enum(name, values, prefix))
+            self._genc.body(gen_enum_lookup(name, values, prefix))
 
     def visit_array_type(self, name, info, element_type):
         if isinstance(element_type, QAPISchemaBuiltinType):
@@ -215,20 +224,20 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
             self._btin += gen_array(name, element_type)
             self._btin += gen_type_cleanup_decl(name)
             if self._opt_builtins:
-                self.defn += gen_type_cleanup(name)
+                self._genc.body(gen_type_cleanup(name))
         else:
-            self._fwdecl += gen_fwd_object_or_array(name)
-            self.decl += gen_array(name, element_type)
+            self._genh.preamble(gen_fwd_object_or_array(name))
+            self._genh.body(gen_array(name, element_type))
             self._gen_type_cleanup(name)
 
     def visit_object_type(self, name, info, base, members, variants):
         # Nothing to do for the special empty builtin
         if name == 'q_empty':
             return
-        self._fwdecl += gen_fwd_object_or_array(name)
-        self.decl += gen_object(name, base, members, variants)
+        self._genh.preamble(gen_fwd_object_or_array(name))
+        self._genh.body(gen_object(name, base, members, variants))
         if base and not base.is_implicit():
-            self.decl += gen_upcast(name, base)
+            self._genh.body(gen_upcast(name, base))
         # TODO Worth changing the visitor signature, so we could
         # directly use rather than repeat type.is_implicit()?
         if not name.startswith('q_'):
@@ -236,31 +245,13 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
             self._gen_type_cleanup(name)
 
     def visit_alternate_type(self, name, info, variants):
-        self._fwdecl += gen_fwd_object_or_array(name)
-        self.decl += gen_object(name, None, [variants.tag_member], variants)
+        self._genh.preamble(gen_fwd_object_or_array(name))
+        self._genh.body(gen_object(name, None,
+                                   [variants.tag_member], variants))
         self._gen_type_cleanup(name)
 
 
 def gen_types(schema, output_dir, prefix, opt_builtins):
-    blurb = ' * Schema-defined QAPI types'
-    genc = QAPIGenC(blurb, __doc__)
-    genh = QAPIGenH(blurb, __doc__)
-
-    genc.body(mcgen('''
-#include "qemu/osdep.h"
-#include "qapi/dealloc-visitor.h"
-#include "%(prefix)sqapi-types.h"
-#include "%(prefix)sqapi-visit.h"
-''',
-                    prefix=prefix))
-
-    genh.body(mcgen('''
-#include "qapi/util.h"
-'''))
-
-    vis = QAPISchemaGenTypeVisitor(opt_builtins)
+    vis = QAPISchemaGenTypeVisitor(opt_builtins, prefix)
     schema.visit(vis)
-    genc.body(vis.defn)
-    genh.body(vis.decl)
-    genc.write(output_dir, prefix + 'qapi-types.c')
-    genh.write(output_dir, prefix + 'qapi-types.h')
+    vis.write(output_dir)
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 80c0b85f8c..ee1a849574 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -264,24 +264,38 @@ out:
 
 
 class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
-    def __init__(self, opt_builtins):
+    def __init__(self, opt_builtins, prefix):
         self._opt_builtins = opt_builtins
-        self.decl = None
-        self.defn = None
-        self._btin = None
-
-    def visit_begin(self, schema):
-        self.decl = ''
-        self.defn = ''
+        self._prefix = prefix
+        blurb = ' * Schema-defined QAPI visitors'
+        self._genc = QAPIGenC(blurb, __doc__)
+        self._genh = QAPIGenH(blurb, __doc__)
+        self._genc.preamble(mcgen('''
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "%(prefix)sqapi-visit.h"
+''',
+                                  prefix=prefix))
+        self._genh.preamble(mcgen('''
+#include "qapi/visitor.h"
+#include "qapi/qmp/qerror.h"
+#include "%(prefix)sqapi-types.h"
+''',
+                                  prefix=prefix))
         self._btin = guardstart('QAPI_VISIT_BUILTIN')
 
+    def write(self, output_dir):
+        self._genc.write(output_dir, self._prefix + 'qapi-visit.c')
+        self._genh.write(output_dir, self._prefix + 'qapi-visit.h')
+
     def visit_end(self):
         # To avoid header dependency hell, we always generate
         # declarations for built-in types in our header files and
         # simply guard them.  See also opt_builtins (command line
         # option -b).
         self._btin += guardend('QAPI_VISIT_BUILTIN')
-        self.decl = self._btin + self.decl
+        self._genh.preamble(self._btin)
         self._btin = None
 
     def visit_enum_type(self, name, info, values, prefix):
@@ -290,10 +304,10 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         if not info:
             self._btin += gen_visit_decl(name, scalar=True)
             if self._opt_builtins:
-                self.defn += gen_visit_enum(name)
+                self._genc.body(gen_visit_enum(name))
         else:
-            self.decl += gen_visit_decl(name, scalar=True)
-            self.defn += gen_visit_enum(name)
+            self._genh.body(gen_visit_decl(name, scalar=True))
+            self._genc.body(gen_visit_enum(name))
 
     def visit_array_type(self, name, info, element_type):
         decl = gen_visit_decl(name)
@@ -301,53 +315,30 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         if isinstance(element_type, QAPISchemaBuiltinType):
             self._btin += decl
             if self._opt_builtins:
-                self.defn += defn
+                self._genc.body(defn)
         else:
-            self.decl += decl
-            self.defn += defn
+            self._genh.body(decl)
+            self._genc.body(defn)
 
     def visit_object_type(self, name, info, base, members, variants):
         # Nothing to do for the special empty builtin
         if name == 'q_empty':
             return
-        self.decl += gen_visit_members_decl(name)
-        self.defn += gen_visit_object_members(name, base, members, variants)
+        self._genh.body(gen_visit_members_decl(name))
+        self._genc.body(gen_visit_object_members(name, base, members, variants))
         # TODO Worth changing the visitor signature, so we could
         # directly use rather than repeat type.is_implicit()?
         if not name.startswith('q_'):
             # only explicit types need an allocating visit
-            self.decl += gen_visit_decl(name)
-            self.defn += gen_visit_object(name, base, members, variants)
+            self._genh.body(gen_visit_decl(name))
+            self._genc.body(gen_visit_object(name, base, members, variants))
 
     def visit_alternate_type(self, name, info, variants):
-        self.decl += gen_visit_decl(name)
-        self.defn += gen_visit_alternate(name, variants)
+        self._genh.body(gen_visit_decl(name))
+        self._genc.body(gen_visit_alternate(name, variants))
 
 
 def gen_visit(schema, output_dir, prefix, opt_builtins):
-    blurb = ' * Schema-defined QAPI visitors'
-    genc = QAPIGenC(blurb, __doc__)
-    genh = QAPIGenH(blurb, __doc__)
-
-    genc.body(mcgen('''
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "qapi/error.h"
-#include "%(prefix)sqapi-visit.h"
-''',
-                    prefix=prefix))
-
-    genh.body(mcgen('''
-#include "qapi/visitor.h"
-#include "qapi/qmp/qerror.h"
-#include "%(prefix)sqapi-types.h"
-
-''',
-                    prefix=prefix))
-
-    vis = QAPISchemaGenVisitVisitor(opt_builtins)
+    vis = QAPISchemaGenVisitVisitor(opt_builtins, prefix)
     schema.visit(vis)
-    genc.body(vis.defn)
-    genh.body(vis.decl)
-    genc.write(output_dir, prefix + 'qapi-visit.c')
-    genh.write(output_dir, prefix + 'qapi-visit.h')
+    vis.write(output_dir)
-- 
2.13.6

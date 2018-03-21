Received: from eggs.gnu.org ([2001:4830:134:3::10]:49038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJb-0006fP-Az
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:54:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJY-00006k-Qk
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53280 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycJY-00006R-Is
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DEC74001852
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:53:56 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:52:02 +0100
Message-Id: <20180321115211.17937-41-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 40/49] RFC: qapi: learn to split schema by
 'top-unit'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Another take at making the schema modular, this time by introducing
the concept of a 'top-unit'. With this approach, each module is part
of a top-unit, which is visited first before visiting the module
themselfs. The default 'top-unit' is None. Else, a module belong to a
'top-unit' whose name is given by the 'top-unit' pragma value.

This gives a chance to the generators to break generated output into
different files. The point of this excercice is to have modules that
can be compiled per qemu targets, instead of everything belonging to
the top schema without the right to use poisoin defines for
conditional compilation.

Generated types, visitors, events and commands are split by
'top-unit'.

The generated introspection and documentation remain monolithic.

TODO: if this approach is acceptable, write tests & doc.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/commands.py |  22 +++++---
 scripts/qapi/common.py   | 105 +++++++++++++++++++++++++++++++--------
 scripts/qapi/events.py   |  33 ++++++++----
 scripts/qapi/types.py    |   8 +--
 scripts/qapi/visit.py    |   8 +--
 5 files changed, 129 insertions(+), 47 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 3d3e97f737..3ca36fc33b 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -235,14 +235,20 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModular=
CVisitor):
         QAPISchemaModularCVisitor.__init__(
             self, prefix, 'qapi-commands',
             ' * Schema-defined QAPI/QMP commands', __doc__)
+
+    def visit_unit_begin(self, unit):
+        super(self.__class__, self).visit_unit_begin(unit)
         self._regy =3D QAPIGenCSnippet()
         self._visited_ret_types =3D {}
=20
-    def _begin_module(self, name):
+    def _begin_module(self, name, main_module):
         self._visited_ret_types[self._genc] =3D set()
-        commands =3D self._module_basename('qapi-commands', name)
-        types =3D self._module_basename('qapi-types', name)
-        visit =3D self._module_basename('qapi-visit', name)
+        commands =3D self._module_basename('qapi-commands', name,
+                                         self._unit, main_module)
+        types =3D self._module_basename('qapi-types', name,
+                                      self._unit, main_module)
+        visit =3D self._module_basename('qapi-visit', name,
+                                      self._unit, main_module)
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
@@ -265,13 +271,13 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModular=
CVisitor):
 ''',
                              types=3Dtypes))
=20
-    def visit_end(self):
-        (genc, genh) =3D self._module[self._main_module]
+    def visit_unit_end(self):
+        (genc, genh) =3D self.get_module_gen(self._main_module)
         genh.add(mcgen('''
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
 ''',
-                       c_prefix=3Dc_name(self._prefix, protect=3DFalse))=
)
-        genc.add(gen_registry(self._regy.get_content(), self._prefix))
+                       c_prefix=3Dc_name(self._prefix_unit(), protect=3D=
False)))
+        genc.add(gen_registry(self._regy.get_content(), self._prefix_uni=
t()))
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type,
                       gen, success_response, boxed, allow_oob):
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 174b39ea50..bff8de05d1 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -271,11 +271,12 @@ class QAPISchemaParser(object):
         self.exprs =3D []
         self.docs =3D []
         self.accept()
+        self._top_unit =3D None
         cur_doc =3D None
=20
         while self.tok is not None:
             info =3D {'file': self.fname, 'line': self.line,
-                    'parent': self.incl_info}
+                    'parent': self.incl_info, 'top-unit': self._top_unit=
}
             if self.tok =3D=3D '#':
                 self.reject_expr_doc(cur_doc)
                 cur_doc =3D self.get_doc(info)
@@ -298,6 +299,9 @@ class QAPISchemaParser(object):
                 exprs_include =3D self._include(include, info, incl_fnam=
e,
                                               previously_included)
                 if exprs_include:
+                    incl_info =3D self.exprs[-1]['info']
+                    if exprs_include._top_unit:
+                        incl_info['has-pragma-top-unit'] =3D exprs_inclu=
de._top_unit
                     self.exprs.extend(exprs_include.exprs)
                     self.docs.extend(exprs_include.docs)
             elif "pragma" in expr:
@@ -356,6 +360,11 @@ class QAPISchemaParser(object):
                 raise QAPISemError(info,
                                    "Pragma 'doc-required' must be boolea=
n")
             doc_required =3D value
+        elif name =3D=3D 'top-unit':
+            if not isinstance(value, str):
+                raise QAPISemError(info,
+                                   "Pragma 'top-unit' must be a string")
+            self._top_unit =3D value
         elif name =3D=3D 'returns-whitelist':
             if (not isinstance(value, list)
                     or any([not isinstance(elt, str) for elt in value]))=
:
@@ -1098,6 +1107,11 @@ class QAPISchemaEntity(object):
     def c_name(self):
         return c_name(self.name)
=20
+    def get_top_unit(self):
+        if self.info:
+            return self.info['top-unit']
+        return None
+
     def check(self, schema):
         if isinstance(self._ifcond, QAPISchemaType):
             # inherit the condition from a type
@@ -1118,6 +1132,12 @@ class QAPISchemaVisitor(object):
     def visit_begin(self, schema):
         pass
=20
+    def visit_unit_begin(self, unit):
+        pass
+
+    def visit_unit_end(self):
+        pass
+
     def visit_end(self):
         pass
=20
@@ -1613,7 +1633,7 @@ class QAPISchema(object):
         parser =3D QAPISchemaParser(open(fname, 'r'))
         exprs =3D check_exprs(parser.exprs)
         self.docs =3D parser.docs
-        self._entity_list =3D []
+        self._entity_list =3D {} # dict of unit name -> list of entity
         self._entity_dict =3D {}
         self._predefining =3D True
         self._def_predefineds()
@@ -1625,7 +1645,8 @@ class QAPISchema(object):
         # Only the predefined types are allowed to not have info
         assert ent.info or self._predefining
         assert ent.name is None or ent.name not in self._entity_dict
-        self._entity_list.append(ent)
+        entity_list =3D self._entity_list.setdefault(ent.get_top_unit(),=
 [])
+        entity_list.append(ent)
         if ent.name is not None:
             self._entity_dict[ent.name] =3D ent
         if ent.info:
@@ -1870,18 +1891,23 @@ class QAPISchema(object):
                 assert False
=20
     def check(self):
-        for ent in self._entity_list:
-            ent.check(self)
+        for unit in self._entity_list:
+            for ent in self._entity_list[unit]:
+                ent.check(self)
=20
     def visit(self, visitor):
         visitor.visit_begin(self)
-        module =3D None
-        for entity in self._entity_list:
-            if visitor.visit_needed(entity):
+        for unit in self._entity_list:
+            module =3D None
+            visitor.visit_unit_begin(unit)
+            for entity in self._entity_list[unit]:
+                if not visitor.visit_needed(entity):
+                    continue
                 if entity.module !=3D module:
                     module =3D entity.module
                     visitor.visit_module(module)
                 entity.visit(visitor)
+            visitor.visit_unit_end()
         visitor.visit_end()
=20
=20
@@ -2301,6 +2327,19 @@ class QAPISchemaMonolithicCVisitor(QAPISchemaVisit=
or):
         self._genh.write(output_dir, self._prefix + self._what + '.h')
=20
=20
+class QAPIGenCModule(object):
+
+    def __init__(self, blurb, pydoc, unit, main_module=3DFalse):
+        self.genc =3D QAPIGenC(blurb, pydoc)
+        self.genh =3D QAPIGenH(blurb, pydoc)
+        self.unit =3D unit
+        self.main_module =3D main_module
+
+    def write(self, output_dir, basename):
+        self.genc.write(output_dir, basename + '.c')
+        self.genh.write(output_dir, basename + '.h')
+
+
 class QAPISchemaModularCVisitor(QAPISchemaVisitor):
=20
     def __init__(self, prefix, what, blurb, pydoc):
@@ -2309,48 +2348,70 @@ class QAPISchemaModularCVisitor(QAPISchemaVisitor=
):
         self._blurb =3D blurb
         self._pydoc =3D pydoc
         self._module =3D {}
+        self._unit =3D None
         self._main_module =3D None
=20
-    def _module_basename(self, what, name):
+    def _module_basename(self, what, name, unit=3DNone, main_module=3DFa=
lse):
         if name is None:
             return re.sub(r'-', '-builtin-', what)
         basename =3D os.path.join(os.path.dirname(name),
                                 self._prefix + what)
-        if name =3D=3D self._main_module:
+        if unit:
+            basename =3D unit + '-' + basename
+        if main_module:
             return basename
         return basename + '-' + os.path.splitext(os.path.basename(name))=
[0]
=20
+    def _prefix_unit(self):
+        if self._unit:
+            return self._prefix + self._unit + '-'
+        return self._prefix
+
+    def visit_unit_begin(self, unit):
+        self._unit =3D unit
+        self._main_module =3D None
+
     def _add_module(self, name, blurb):
-        if self._main_module is None and name is not None:
+        main_module =3D False
+        if (name is not None and
+            ((self._unit is None and self._main_module is None) or
+             (self._unit =3D=3D os.path.splitext(os.path.basename(name))=
[0]))):
             self._main_module =3D name
-        genc =3D QAPIGenC(blurb, self._pydoc)
-        genh =3D QAPIGenH(blurb, self._pydoc)
-        self._module[name] =3D (genc, genh)
+            main_module =3D True
+        self._module[name] =3D QAPIGenCModule(blurb, self._pydoc,
+                                            self._unit, main_module)
         self._set_module(name)
+        return main_module
+
+    def get_module_gen(self, name):
+        mod =3D self._module[name]
+        return mod.genc, mod.genh
=20
     def _set_module(self, name):
-        self._genc, self._genh =3D self._module[name]
+        self._genc, self._genh =3D self.get_module_gen(name)
=20
     def write(self, output_dir, opt_builtins=3DFalse):
         for name in self._module:
             if name is None and not opt_builtins:
                 continue
-            basename =3D self._module_basename(self._what, name)
-            (genc, genh) =3D self._module[name]
-            genc.write(output_dir, basename + '.c')
-            genh.write(output_dir, basename + '.h')
+            module =3D self._module[name]
+            basename =3D self._module_basename(self._what, name,
+                                             module.unit, module.main_mo=
dule)
+            module.write(output_dir, basename)
=20
-    def _begin_module(self, name):
+    def _begin_module(self, name, main_module):
         pass
=20
     def visit_module(self, name):
         if name in self._module:
             self._set_module(name)
             return
-        self._add_module(name, self._blurb)
-        self._begin_module(name)
+        main_module =3D self._add_module(name, self._blurb)
+        self._begin_module(name, main_module)
=20
     def visit_include(self, name, info):
+        if 'has-pragma-top-unit' in info:
+            return
         basename =3D self._module_basename(self._what, name)
         self._genh.preamble_add(mcgen('''
 #include "%(basename)s.h"
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index f02b65cf5a..88bfcfcf2a 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -58,7 +58,12 @@ def gen_param_var(typ):
     return ret
=20
=20
-def gen_event_send(name, arg_type, boxed, event_enum_name):
+def gen_event_send(unit, name, arg_type, boxed, event_enum_name):
+    if not unit:
+        unit =3D ''
+    else:
+        unit +=3D '_'
+
     # FIXME: Our declaration of local variables (and of 'errp' in the
     # parameter list) can collide with exploded members of the event's
     # data type passed in as parameters.  If this collision ever hits in
@@ -87,7 +92,7 @@ def gen_event_send(name, arg_type, boxed, event_enum_na=
me):
=20
     ret +=3D mcgen('''
=20
-    emit =3D qmp_event_get_func_emit();
+    emit =3D %(unit)sqmp_event_get_func_emit();
     if (!emit) {
         return;
     }
@@ -95,7 +100,7 @@ def gen_event_send(name, arg_type, boxed, event_enum_n=
ame):
     qmp =3D qmp_event_build_dict("%(name)s");
=20
 ''',
-                 name=3Dname)
+                 name=3Dname, unit=3Dunit)
=20
     if arg_type and not arg_type.is_empty():
         ret +=3D mcgen('''
@@ -154,12 +159,17 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCV=
isitor):
         QAPISchemaModularCVisitor.__init__(
             self, prefix, 'qapi-events',
             ' * Schema-defined QAPI/QMP events', __doc__)
-        self._enum_name =3D c_name(prefix + 'QAPIEvent', protect=3DFalse=
)
+
+    def visit_unit_begin(self, unit):
+        super(self.__class__, self).visit_unit_begin(unit)
+        self._enum_name =3D c_name(self._prefix_unit() + 'QAPIEvent', pr=
otect=3DFalse)
         self._event_names =3D []
=20
-    def _begin_module(self, name):
-        types =3D self._module_basename('qapi-types', name)
-        visit =3D self._module_basename('qapi-visit', name)
+    def _begin_module(self, name, main_module):
+        types =3D self._module_basename('qapi-types', name,
+                                      self._unit, main_module)
+        visit =3D self._module_basename('qapi-visit', name,
+                                      self._unit, main_module)
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
@@ -171,7 +181,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVis=
itor):
 #include "qapi/qmp-event.h"
=20
 ''',
-                             visit=3Dvisit, prefix=3Dself._prefix))
+                             visit=3Dvisit, prefix=3Dself._prefix_unit()=
))
         self._genh.add(mcgen('''
 #include "qapi/util.h"
 #include "%(types)s.h"
@@ -179,15 +189,16 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCV=
isitor):
 ''',
                              types=3Dtypes))
=20
-    def visit_end(self):
-        (genc, genh) =3D self._module[self._main_module]
+    def visit_unit_end(self):
+        (genc, genh) =3D self.get_module_gen(self._main_module)
         genh.add(gen_enum(self._enum_name, self._event_names))
         genc.add(gen_enum_lookup(self._enum_name, self._event_names))
=20
     def visit_event(self, name, info, ifcond, arg_type, boxed):
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_event_send_decl(name, arg_type, boxed))
-            self._genc.add(gen_event_send(name, arg_type, boxed, self._e=
num_name))
+            self._genc.add(gen_event_send(self._unit, name,
+                                          arg_type, boxed, self._enum_na=
me))
         self._event_names.append(QAPISchemaMember(name, ifcond))
=20
=20
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index b0d3ddb596..ac0c4603d4 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -194,9 +194,11 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVis=
itor):
 #include "qapi/util.h"
 '''))
=20
-    def _begin_module(self, name):
-        types =3D self._module_basename('qapi-types', name)
-        visit =3D self._module_basename('qapi-visit', name)
+    def _begin_module(self, name, main_module):
+        types =3D self._module_basename('qapi-types', name,
+                                      self._unit, main_module)
+        visit =3D self._module_basename('qapi-visit', name,
+                                      self._unit, main_module)
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/dealloc-visitor.h"
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index dc5a3173fc..60625aae72 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -289,9 +289,11 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVi=
sitor):
 ''',
                                       prefix=3Dprefix))
=20
-    def _begin_module(self, name):
-        types =3D self._module_basename('qapi-types', name)
-        visit =3D self._module_basename('qapi-visit', name)
+    def _begin_module(self, name, main_module):
+        types =3D self._module_basename('qapi-types', name,
+                                      self._unit, main_module)
+        visit =3D self._module_basename('qapi-visit', name,
+                                      self._unit, main_module)
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
--=20
2.16.2.521.g9aa15f885a

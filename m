Received: from eggs.gnu.org ([2001:4830:134:3::10]:33014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal51-0000fY-07
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal4v-0007N5-Im
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:52:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dal4v-0007La-2h
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:51:57 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 27 Jul 2017 17:41:07 +0200
Message-Id: <20170727154126.11339-8-marcandre.lureau@redhat.com>
In-Reply-To: <20170727154126.11339-1-marcandre.lureau@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/26] qapi: add 'if' condition on top-level
 schema elements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Add 'if' c-preprocessor condition on top-level schema elements:
struct, enum, union, alternate, command, event.

Variants objects types are created outside of #if blocks, since they
may be shared by various types. Even if unused, this shouldn't be an
issue, since those are internal types.

Note that there is no checks in qapi scripts to verify that elements
have compatible conditions (ex: if-struct used by a if-foo
command). This may thus fail at C build time if they don't share the
same subset of conditions.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                         | 153 +++++++++++++++++++++++++-=
------
 scripts/qapi-commands.py                |   4 +-
 scripts/qapi-event.py                   |   4 +-
 scripts/qapi-introspect.py              |  46 ++++++----
 scripts/qapi-types.py                   |  51 +++++++----
 scripts/qapi-visit.py                   |  13 ++-
 scripts/qapi2texi.py                    |  10 +--
 tests/Makefile.include                  |   1 +
 tests/qapi-schema/bad-if.err            |   1 +
 tests/qapi-schema/bad-if.exit           |   1 +
 tests/qapi-schema/bad-if.json           |   3 +
 tests/qapi-schema/bad-if.out            |   0
 tests/qapi-schema/qapi-schema-test.json |  20 +++++
 tests/qapi-schema/qapi-schema-test.out  |  31 +++++++
 tests/qapi-schema/test-qapi.py          |  21 +++--
 15 files changed, 272 insertions(+), 87 deletions(-)
 create mode 100644 tests/qapi-schema/bad-if.err
 create mode 100644 tests/qapi-schema/bad-if.exit
 create mode 100644 tests/qapi-schema/bad-if.json
 create mode 100644 tests/qapi-schema/bad-if.out

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 4ecc19e944..79ba1e93da 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -639,6 +639,16 @@ def add_name(name, info, meta, implicit=3DFalse):
     all_names[name] =3D meta
=20
=20
+def check_if(expr, info):
+    ifcond =3D expr.get('if')
+    if not ifcond or isinstance(ifcond, str):
+        return
+    if (not isinstance(ifcond, list) or
+        any([not isinstance(elt, str) for elt in ifcond])):
+        raise QAPISemError(info, "'if' condition requires a string or "
+                           "a list of string")
+
+
 def check_type(info, source, value, allow_array=3DFalse,
                allow_dict=3DFalse, allow_optional=3DFalse,
                allow_metas=3D[]):
@@ -865,6 +875,7 @@ def check_keys(expr_elem, meta, required, optional=3D=
[]):
     expr =3D expr_elem['expr']
     info =3D expr_elem['info']
     name =3D expr[meta]
+    optional.append('if')
     if not isinstance(name, str):
         raise QAPISemError(info, "'%s' key must have a string value" % m=
eta)
     required =3D required + [meta]
@@ -880,6 +891,8 @@ def check_keys(expr_elem, meta, required, optional=3D=
[]):
             raise QAPISemError(info,
                                "'%s' of %s '%s' should only use true val=
ue"
                                % (key, meta, name))
+        if key =3D=3D 'if':
+            check_if(expr, info)
     for key in required:
         if key not in expr:
             raise QAPISemError(info, "Key '%s' is missing from %s '%s'"
@@ -989,6 +1002,10 @@ class QAPISchemaEntity(object):
         # such place).
         self.info =3D info
         self.doc =3D doc
+        self.ifcond =3D None
+
+    def set_ifcond(self, ifcond):
+        self.ifcond =3D ifcond
=20
     def c_name(self):
         return c_name(self.name)
@@ -1017,26 +1034,26 @@ class QAPISchemaVisitor(object):
     def visit_builtin_type(self, name, info, json_type):
         pass
=20
-    def visit_enum_type(self, name, info, values, prefix):
+    def visit_enum_type(self, name, info, values, prefix, ifcond):
         pass
=20
-    def visit_array_type(self, name, info, element_type):
+    def visit_array_type(self, name, info, element_type, ifcond):
         pass
=20
-    def visit_object_type(self, name, info, base, members, variants):
+    def visit_object_type(self, name, info, base, members, variants, ifc=
ond):
         pass
=20
-    def visit_object_type_flat(self, name, info, members, variants):
+    def visit_object_type_flat(self, name, info, members, variants, ifco=
nd):
         pass
=20
-    def visit_alternate_type(self, name, info, variants):
+    def visit_alternate_type(self, name, info, variants, ifcond):
         pass
=20
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, ifcond):
         pass
=20
-    def visit_event(self, name, info, arg_type, boxed):
+    def visit_event(self, name, info, arg_type, boxed, ifcond):
         pass
=20
=20
@@ -1136,7 +1153,7 @@ class QAPISchemaEnumType(QAPISchemaType):
=20
     def visit(self, visitor):
         visitor.visit_enum_type(self.name, self.info,
-                                self.member_names(), self.prefix)
+                                self.member_names(), self.prefix, self.i=
fcond)
=20
=20
 class QAPISchemaArrayType(QAPISchemaType):
@@ -1149,6 +1166,7 @@ class QAPISchemaArrayType(QAPISchemaType):
     def check(self, schema):
         self.element_type =3D schema.lookup_type(self._element_type_name=
)
         assert self.element_type
+        self.ifcond =3D self.element_type.ifcond
=20
     def is_implicit(self):
         return True
@@ -1166,7 +1184,8 @@ class QAPISchemaArrayType(QAPISchemaType):
         return 'array of ' + elt_doc_type
=20
     def visit(self, visitor):
-        visitor.visit_array_type(self.name, self.info, self.element_type=
)
+        visitor.visit_array_type(self.name, self.info, self.element_type=
,
+                                 self.ifcond)
=20
=20
 class QAPISchemaObjectType(QAPISchemaType):
@@ -1247,9 +1266,10 @@ class QAPISchemaObjectType(QAPISchemaType):
=20
     def visit(self, visitor):
         visitor.visit_object_type(self.name, self.info,
-                                  self.base, self.local_members, self.va=
riants)
+                                  self.base, self.local_members, self.va=
riants,
+                                  self.ifcond)
         visitor.visit_object_type_flat(self.name, self.info,
-                                       self.members, self.variants)
+                                       self.members, self.variants, self=
.ifcond)
=20
=20
 class QAPISchemaMember(object):
@@ -1392,7 +1412,8 @@ class QAPISchemaAlternateType(QAPISchemaType):
         return 'value'
=20
     def visit(self, visitor):
-        visitor.visit_alternate_type(self.name, self.info, self.variants=
)
+        visitor.visit_alternate_type(self.name, self.info,
+                                     self.variants, self.ifcond)
=20
     def is_empty(self):
         return False
@@ -1434,7 +1455,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
     def visit(self, visitor):
         visitor.visit_command(self.name, self.info,
                               self.arg_type, self.ret_type,
-                              self.gen, self.success_response, self.boxe=
d)
+                              self.gen, self.success_response, self.boxe=
d,
+                              self.ifcond)
=20
=20
 class QAPISchemaEvent(QAPISchemaEntity):
@@ -1462,7 +1484,8 @@ class QAPISchemaEvent(QAPISchemaEntity):
             raise QAPISemError(self.info, "Use of 'boxed' requires 'data=
'")
=20
     def visit(self, visitor):
-        visitor.visit_event(self.name, self.info, self.arg_type, self.bo=
xed)
+        visitor.visit_event(self.name, self.info, self.arg_type, self.bo=
xed,
+                            self.ifcond)
=20
=20
 class QAPISchema(object):
@@ -1481,11 +1504,12 @@ class QAPISchema(object):
             print >>sys.stderr, err
             exit(1)
=20
-    def _def_entity(self, ent):
+    def _def_entity(self, ent, ifcond=3DNone):
         # Only the predefined types are allowed to not have info
         assert ent.info or self._predefining
         assert ent.name not in self._entity_dict
         self._entity_dict[ent.name] =3D ent
+        ent.set_ifcond(ifcond)
=20
     def lookup_entity(self, name, typ=3DNone):
         ent =3D self._entity_dict.get(name)
@@ -1534,11 +1558,11 @@ class QAPISchema(object):
     def _make_enum_members(self, values):
         return [QAPISchemaMember(v) for v in values]
=20
-    def _make_implicit_enum_type(self, name, info, values):
+    def _make_implicit_enum_type(self, name, info, values, ifcond):
         # See also QAPISchemaObjectTypeMember._pretty_owner()
         name =3D name + 'Kind'   # Use namespace reserved by add_name()
         self._def_entity(QAPISchemaEnumType(
-            name, info, None, self._make_enum_members(values), None))
+            name, info, None, self._make_enum_members(values), None), if=
cond)
         return name
=20
     def _make_array_type(self, element_type, info):
@@ -1547,22 +1571,26 @@ class QAPISchema(object):
             self._def_entity(QAPISchemaArrayType(name, info, element_typ=
e))
         return name
=20
-    def _make_implicit_object_type(self, name, info, doc, role, members)=
:
+    def _make_implicit_object_type(self, name, info, doc, role, members,
+                                   ifcond=3DNone):
         if not members:
             return None
         # See also QAPISchemaObjectTypeMember._pretty_owner()
         name =3D 'q_obj_%s-%s' % (name, role)
-        if not self.lookup_entity(name, QAPISchemaObjectType):
+        if self.lookup_entity(name, QAPISchemaObjectType):
+            assert ifcond is None
+        else:
             self._def_entity(QAPISchemaObjectType(name, info, doc, None,
-                                                  members, None))
+                                                  members, None), ifcond=
)
         return name
=20
     def _def_enum_type(self, expr, info, doc):
         name =3D expr['enum']
         data =3D expr['data']
         prefix =3D expr.get('prefix')
-        self._def_entity(QAPISchemaEnumType(
-            name, info, doc, self._make_enum_members(data), prefix))
+        return self._def_entity(QAPISchemaEnumType(
+            name, info, doc, self._make_enum_members(data), prefix),
+                                expr.get('if'))
=20
     def _make_member(self, name, typ, info):
         optional =3D False
@@ -1584,7 +1612,8 @@ class QAPISchema(object):
         data =3D expr['data']
         self._def_entity(QAPISchemaObjectType(name, info, doc, base,
                                               self._make_members(data, i=
nfo),
-                                              None))
+                                              None),
+                         expr.get('if'))
=20
     def _make_variant(self, case, typ):
         return QAPISchemaObjectTypeVariant(case, typ)
@@ -1593,8 +1622,10 @@ class QAPISchema(object):
         if isinstance(typ, list):
             assert len(typ) =3D=3D 1
             typ =3D self._make_array_type(typ[0], info)
+        type_entity =3D self.lookup_type(typ)
         typ =3D self._make_implicit_object_type(
-            typ, info, None, 'wrapper', [self._make_member('data', typ, =
info)])
+            typ, info, None, 'wrapper',
+            [self._make_member('data', typ, info)], type_entity.ifcond)
         return QAPISchemaObjectTypeVariant(case, typ)
=20
     def _def_union_type(self, expr, info, doc):
@@ -1604,8 +1635,9 @@ class QAPISchema(object):
         tag_name =3D expr.get('discriminator')
         tag_member =3D None
         if isinstance(base, dict):
-            base =3D (self._make_implicit_object_type(
-                name, info, doc, 'base', self._make_members(base, info))=
)
+            base =3D self._make_implicit_object_type(
+                name, info, doc, 'base', self._make_members(base, info),
+                expr.get('if'))
         if tag_name:
             variants =3D [self._make_variant(key, value)
                         for (key, value) in data.iteritems()]
@@ -1614,14 +1646,16 @@ class QAPISchema(object):
             variants =3D [self._make_simple_variant(key, value, info)
                         for (key, value) in data.iteritems()]
             typ =3D self._make_implicit_enum_type(name, info,
-                                                [v.name for v in variant=
s])
+                                                [v.name for v in variant=
s],
+                                                expr.get('if'))
             tag_member =3D QAPISchemaObjectTypeMember('type', typ, False=
)
             members =3D [tag_member]
         self._def_entity(
             QAPISchemaObjectType(name, info, doc, base, members,
                                  QAPISchemaObjectTypeVariants(tag_name,
                                                               tag_member=
,
-                                                              variants))=
)
+                                                              variants))=
,
+            expr.get('if'))
=20
     def _def_alternate_type(self, expr, info, doc):
         name =3D expr['alternate']
@@ -1633,7 +1667,8 @@ class QAPISchema(object):
             QAPISchemaAlternateType(name, info, doc,
                                     QAPISchemaObjectTypeVariants(None,
                                                                  tag_mem=
ber,
-                                                                 variant=
s)))
+                                                                 variant=
s)),
+            expr.get('if'))
=20
     def _def_command(self, expr, info, doc):
         name =3D expr['command']
@@ -1644,12 +1679,14 @@ class QAPISchema(object):
         boxed =3D expr.get('boxed', False)
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
-                name, info, doc, 'arg', self._make_members(data, info))
+                name, info, doc, 'arg', self._make_members(data, info),
+                expr.get('if'))
         if isinstance(rets, list):
             assert len(rets) =3D=3D 1
             rets =3D self._make_array_type(rets[0], info)
         self._def_entity(QAPISchemaCommand(name, info, doc, data, rets,
-                                           gen, success_response, boxed)=
)
+                                           gen, success_response, boxed)=
,
+                         expr.get('if'))
=20
     def _def_event(self, expr, info, doc):
         name =3D expr['event']
@@ -1657,8 +1694,10 @@ class QAPISchema(object):
         boxed =3D expr.get('boxed', False)
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
-                name, info, doc, 'arg', self._make_members(data, info))
-        self._def_entity(QAPISchemaEvent(name, info, doc, data, boxed))
+                name, info, doc, 'arg', self._make_members(data, info),
+                expr.get('if'))
+        self._def_entity(QAPISchemaEvent(name, info, doc, data, boxed),
+                         expr.get('if'))
=20
     def _def_exprs(self):
         for expr_elem in self.exprs:
@@ -1848,6 +1887,54 @@ def guardend(name):
                  name=3Dguardname(name))
=20
=20
+def gen_if(ifcond, func=3D''):
+    if not ifcond:
+        return ''
+    if isinstance(ifcond, str):
+        ifcond =3D [ifcond]
+    ret =3D '\n'
+    for ifc in ifcond:
+        ret +=3D mcgen('#if %(ifcond)s /* %(func)s */\n', ifcond=3Difc, =
func=3Dfunc)
+    ret +=3D '\n'
+    return ret
+
+
+def gen_endif(ifcond, func=3D''):
+    if not ifcond:
+        return ''
+    if isinstance(ifcond, str):
+        ifcond =3D [ifcond]
+    ret =3D '\n'
+    for ifc in reversed(ifcond):
+        ret +=3D mcgen('#endif /* %(ifcond)s %(func)s */\n',
+                     ifcond=3Difc, func=3Dfunc)
+    ret +=3D '\n'
+    return ret
+
+
+# wrap a method to add #if / #endif to generated code
+# self must have 'if_members' listing the attributes to wrap
+# the last argument of the wrapped function must be the 'ifcond'
+def if_wrap(func):
+    def func_wrapper(self, *args, **kwargs):
+        funcname =3D self.__class__.__name__ + '.' + func.__name__
+        ifcond =3D args[-1]
+        save =3D {}
+        for mem in self.if_members:
+            save[mem] =3D getattr(self, mem)
+        func(self, *args, **kwargs)
+        for mem, val in save.items():
+            newval =3D getattr(self, mem)
+            if newval !=3D val:
+                assert newval.startswith(val)
+                newval =3D newval[len(val):]
+                val +=3D gen_if(ifcond, funcname)
+                val +=3D newval
+                val +=3D gen_endif(ifcond, funcname)
+            setattr(self, mem, val)
+
+    return func_wrapper
+
 def gen_enum_lookup(name, values, prefix=3DNone):
     ret =3D mcgen('''
=20
diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 974d0a4a80..19b1bb9b88 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -228,6 +228,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
         self.defn =3D None
         self._regy =3D None
         self._visited_ret_types =3D None
+        self.if_members =3D ['decl', 'defn', '_regy']
=20
     def visit_begin(self, schema):
         self.decl =3D ''
@@ -240,8 +241,9 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
         self._regy =3D None
         self._visited_ret_types =3D None
=20
+    @if_wrap
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, ifcond):
         if not gen:
             return
         self.decl +=3D gen_command_decl(name, arg_type, boxed, ret_type)
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index bcbef1035f..cad9ece790 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -152,6 +152,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
         self.decl =3D None
         self.defn =3D None
         self._event_names =3D None
+        self.if_members =3D ['decl', 'defn']
=20
     def visit_begin(self, schema):
         self.decl =3D ''
@@ -163,7 +164,8 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
         self.defn +=3D gen_enum_lookup(event_enum_name, self._event_name=
s)
         self._event_names =3D None
=20
-    def visit_event(self, name, info, arg_type, boxed):
+    @if_wrap
+    def visit_event(self, name, info, arg_type, boxed, ifcond):
         self.decl +=3D gen_event_send_decl(name, arg_type, boxed)
         self.defn +=3D gen_event_send(name, arg_type, boxed)
         self._event_names.append(name)
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index fc72cdb66d..ecfb0f2752 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -12,7 +12,7 @@
 from qapi import *
=20
=20
-def to_qlit(obj, level=3D0, first_indent=3DTrue):
+def to_qlit(obj, level=3D0, first_indent=3DTrue, suffix=3D''):
     def indent(level):
         return level * 4 * ' '
     ret =3D ''
@@ -20,14 +20,20 @@ def to_qlit(obj, level=3D0, first_indent=3DTrue):
         ret +=3D indent(level)
     if obj is None:
         ret +=3D 'QLIT_QNULL'
+    elif isinstance(obj, tuple):
+        obj, ifcond =3D  obj
+        ret +=3D gen_if(ifcond)
+        ret +=3D to_qlit(obj, level, False) + suffix
+        ret +=3D gen_endif(ifcond)
+        suffix =3D ''
     elif isinstance(obj, str):
         ret +=3D 'QLIT_QSTR(' + '"' + obj.replace('"', r'\"') + '"' + ')=
'
     elif isinstance(obj, list):
-        elts =3D [to_qlit(elt, level + 1)
+        elts =3D [to_qlit(elt, level + 1, True, ",")
                 for elt in obj]
         elts.append(indent(level + 1) + "{ }")
         ret +=3D 'QLIT_QLIST(((QLitObject[]) {\n'
-        ret +=3D ',\n'.join(elts) + '\n'
+        ret +=3D '\n'.join(elts) + '\n'
         ret +=3D indent(level) + '}))'
     elif isinstance(obj, dict):
         elts =3D [ indent(level + 1) + '{ "%s", %s }' %
@@ -39,7 +45,7 @@ def to_qlit(obj, level=3D0, first_indent=3DTrue):
         ret +=3D indent(level) + '}))'
     else:
         assert False                # not implemented
-    return ret
+    return ret + suffix
=20
=20
 class QAPISchemaGenIntrospectVisitor(QAPISchemaVisitor):
@@ -113,12 +119,12 @@ const QLitObject %(c_name)s =3D %(c_string)s;
             return '[' + self._use_type(typ.element_type) + ']'
         return self._name(typ.name)
=20
-    def _gen_qlit(self, name, mtype, obj):
+    def _gen_qlit(self, name, mtype, obj, ifcond):
         if mtype not in ('command', 'event', 'builtin', 'array'):
             name =3D self._name(name)
         obj['name'] =3D name
         obj['meta-type'] =3D mtype
-        self._qlits.append(obj)
+        self._qlits.append((obj, ifcond))
=20
     def _gen_member(self, member):
         ret =3D {'name': member.name, 'type': self._use_type(member.type=
)}
@@ -134,38 +140,40 @@ const QLitObject %(c_name)s =3D %(c_string)s;
         return {'case': variant.name, 'type': self._use_type(variant.typ=
e)}
=20
     def visit_builtin_type(self, name, info, json_type):
-        self._gen_qlit(name, 'builtin', {'json-type': json_type})
+        self._gen_qlit(name, 'builtin', {'json-type': json_type}, None)
=20
-    def visit_enum_type(self, name, info, values, prefix):
-        self._gen_qlit(name, 'enum', {'values': values})
+    def visit_enum_type(self, name, info, values, prefix, ifcond):
+        self._gen_qlit(name, 'enum', {'values': values}, ifcond)
=20
-    def visit_array_type(self, name, info, element_type):
+    def visit_array_type(self, name, info, element_type, ifcond):
         element =3D self._use_type(element_type)
-        self._gen_qlit('[' + element + ']', 'array', {'element-type': el=
ement})
+        self._gen_qlit('[' + element + ']', 'array', {'element-type': el=
ement},
+                       ifcond)
=20
-    def visit_object_type_flat(self, name, info, members, variants):
+    def visit_object_type_flat(self, name, info, members, variants, ifco=
nd):
         obj =3D {'members': [self._gen_member(m) for m in members]}
         if variants:
             obj.update(self._gen_variants(variants.tag_member.name,
                                           variants.variants))
-        self._gen_qlit(name, 'object', obj)
+        self._gen_qlit(name, 'object', obj, ifcond)
=20
-    def visit_alternate_type(self, name, info, variants):
+    def visit_alternate_type(self, name, info, variants, ifcond):
         self._gen_qlit(name, 'alternate',
                        {'members': [{'type': self._use_type(m.type)}
-                                    for m in variants.variants]})
+                                    for m in variants.variants]}, ifcond=
)
=20
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, ifcond):
         arg_type =3D arg_type or self._schema.the_empty_object_type
         ret_type =3D ret_type or self._schema.the_empty_object_type
         self._gen_qlit(name, 'command',
                        {'arg-type': self._use_type(arg_type),
-                        'ret-type': self._use_type(ret_type)})
+                        'ret-type': self._use_type(ret_type)}, ifcond)
=20
-    def visit_event(self, name, info, arg_type, boxed):
+    def visit_event(self, name, info, arg_type, boxed, ifcond):
         arg_type =3D arg_type or self._schema.the_empty_object_type
-        self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)})
+        self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)},
+                       ifcond)
=20
 # Debugging aid: unmask QAPI schema's type names
 # We normally mask them, because they're not QMP wire ABI
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index b45e7b5634..d0d2eb917c 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -53,19 +53,22 @@ def gen_struct_members(members):
     return ret
=20
=20
-def gen_object(name, base, members, variants):
-    if name in objects_seen:
-        return ''
-    objects_seen.add(name)
-
+def gen_variants_objects(variants):
     ret =3D ''
     if variants:
         for v in variants.variants:
             if isinstance(v.type, QAPISchemaObjectType):
+                ret +=3D gen_variants_objects(v.type.variants)
                 ret +=3D gen_object(v.type.name, v.type.base,
                                   v.type.local_members, v.type.variants)
+    return ret
=20
-    ret +=3D mcgen('''
+def gen_object(name, base, members, variants):
+    if name in objects_seen:
+        return ''
+    objects_seen.add(name)
+
+    ret =3D mcgen('''
=20
 struct %(c_name)s {
 ''',
@@ -171,6 +174,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         self.defn =3D None
         self._fwdecl =3D None
         self._btin =3D None
+        self.if_members =3D ['decl', 'defn', '_fwdecl', '_btin']
=20
     def visit_begin(self, schema):
         # gen_object() is recursive, ensure it doesn't visit the empty t=
ype
@@ -191,11 +195,13 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         self.decl =3D self._btin + self.decl
         self._btin =3D None
=20
-    def _gen_type_cleanup(self, name):
+    @if_wrap
+    def _gen_type_cleanup(self, name, ifcond):
         self.decl +=3D gen_type_cleanup_decl(name)
         self.defn +=3D gen_type_cleanup(name)
=20
-    def visit_enum_type(self, name, info, values, prefix):
+    @if_wrap
+    def visit_enum_type(self, name, info, values, prefix, ifcond):
         # Special case for our lone builtin enum type
         # TODO use something cleaner than existence of info
         if not info:
@@ -206,7 +212,8 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
             self._fwdecl +=3D gen_enum(name, values, prefix)
             self.defn +=3D gen_enum_lookup(name, values, prefix)
=20
-    def visit_array_type(self, name, info, element_type):
+    @if_wrap
+    def visit_array_type(self, name, info, element_type, ifcond):
         if isinstance(element_type, QAPISchemaBuiltinType):
             self._btin +=3D gen_fwd_object_or_array(name)
             self._btin +=3D gen_array(name, element_type)
@@ -216,13 +223,10 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         else:
             self._fwdecl +=3D gen_fwd_object_or_array(name)
             self.decl +=3D gen_array(name, element_type)
-            self._gen_type_cleanup(name)
+            self._gen_type_cleanup(name, ifcond)
=20
-    def visit_object_type(self, name, info, base, members, variants):
-        # Nothing to do for the special empty builtin
-        if name =3D=3D 'q_empty':
-            return
-        self._fwdecl +=3D gen_fwd_object_or_array(name)
+    @if_wrap
+    def _gen_object(self, name, info, base, members, variants, ifcond):
         self.decl +=3D gen_object(name, base, members, variants)
         if base and not base.is_implicit():
             self.decl +=3D gen_upcast(name, base)
@@ -230,12 +234,21 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         # directly use rather than repeat type.is_implicit()?
         if not name.startswith('q_'):
             # implicit types won't be directly allocated/freed
-            self._gen_type_cleanup(name)
+            self._gen_type_cleanup(name, ifcond)
+
+    def visit_object_type(self, name, info, base, members, variants, ifc=
ond):
+        # Nothing to do for the special empty builtin
+        if name =3D=3D 'q_empty':
+            return
+        self._fwdecl +=3D gen_fwd_object_or_array(name)
+        self.decl +=3D gen_variants_objects(variants)
+        self._gen_object(name, info, base, members, variants, ifcond)
=20
-    def visit_alternate_type(self, name, info, variants):
+    def visit_alternate_type(self, name, info, variants, ifcond):
         self._fwdecl +=3D gen_fwd_object_or_array(name)
-        self.decl +=3D gen_object(name, None, [variants.tag_member], var=
iants)
-        self._gen_type_cleanup(name)
+        self.decl +=3D gen_variants_objects(variants)
+        self._gen_object(name, info, None, [variants.tag_member],
+                         variants, ifcond)
=20
 # If you link code generated from multiple schemata, you want only one
 # instance of the code for built-in types.  Generate it only when
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 60850a6cdd..335407d078 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -267,6 +267,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         self.decl =3D None
         self.defn =3D None
         self._btin =3D None
+        self.if_members =3D ['decl', 'defn', '_btin']
=20
     def visit_begin(self, schema):
         self.decl =3D ''
@@ -282,7 +283,8 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         self.decl =3D self._btin + self.decl
         self._btin =3D None
=20
-    def visit_enum_type(self, name, info, values, prefix):
+    @if_wrap
+    def visit_enum_type(self, name, info, values, prefix, ifcond):
         # Special case for our lone builtin enum type
         # TODO use something cleaner than existence of info
         if not info:
@@ -293,7 +295,8 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
             self.decl +=3D gen_visit_decl(name, scalar=3DTrue)
             self.defn +=3D gen_visit_enum(name, prefix)
=20
-    def visit_array_type(self, name, info, element_type):
+    @if_wrap
+    def visit_array_type(self, name, info, element_type, ifcond):
         decl =3D gen_visit_decl(name)
         defn =3D gen_visit_list(name, element_type)
         if isinstance(element_type, QAPISchemaBuiltinType):
@@ -304,7 +307,8 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
             self.decl +=3D decl
             self.defn +=3D defn
=20
-    def visit_object_type(self, name, info, base, members, variants):
+    @if_wrap
+    def visit_object_type(self, name, info, base, members, variants, ifc=
ond):
         # Nothing to do for the special empty builtin
         if name =3D=3D 'q_empty':
             return
@@ -317,7 +321,8 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
             self.decl +=3D gen_visit_decl(name)
             self.defn +=3D gen_visit_object(name, base, members, variant=
s)
=20
-    def visit_alternate_type(self, name, info, variants):
+    @if_wrap
+    def visit_alternate_type(self, name, info, variants, ifcond):
         self.decl +=3D gen_visit_decl(name)
         self.defn +=3D gen_visit_alternate(name, variants)
=20
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 639eb1d042..5aa2f48bfd 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -207,7 +207,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor)=
:
     def visit_begin(self, schema):
         self.out =3D ''
=20
-    def visit_enum_type(self, name, info, values, prefix):
+    def visit_enum_type(self, name, info, values, prefix, ifcond):
         doc =3D self.cur_doc
         if self.out:
             self.out +=3D '\n'
@@ -216,7 +216,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor)=
:
                              body=3Dtexi_entity(doc, 'Values',
                                               member_func=3Dtexi_enum_va=
lue))
=20
-    def visit_object_type(self, name, info, base, members, variants):
+    def visit_object_type(self, name, info, base, members, variants, ifc=
ond):
         doc =3D self.cur_doc
         if base and base.is_implicit():
             base =3D None
@@ -226,7 +226,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor)=
:
                              name=3Ddoc.symbol,
                              body=3Dtexi_entity(doc, 'Members', base, va=
riants))
=20
-    def visit_alternate_type(self, name, info, variants):
+    def visit_alternate_type(self, name, info, variants, ifcond):
         doc =3D self.cur_doc
         if self.out:
             self.out +=3D '\n'
@@ -235,7 +235,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor)=
:
                              body=3Dtexi_entity(doc, 'Members'))
=20
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, ifcond):
         doc =3D self.cur_doc
         if self.out:
             self.out +=3D '\n'
@@ -249,7 +249,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor)=
:
                             name=3Ddoc.symbol,
                             body=3Dbody)
=20
-    def visit_event(self, name, info, arg_type, boxed):
+    def visit_event(self, name, info, arg_type, boxed, ifcond):
         doc =3D self.cur_doc
         if self.out:
             self.out +=3D '\n'
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 960ab8c6dd..0fc7088b2c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -373,6 +373,7 @@ qapi-schema +=3D args-unknown.json
 qapi-schema +=3D bad-base.json
 qapi-schema +=3D bad-data.json
 qapi-schema +=3D bad-ident.json
+qapi-schema +=3D bad-if.json
 qapi-schema +=3D bad-type-bool.json
 qapi-schema +=3D bad-type-dict.json
 qapi-schema +=3D bad-type-int.json
diff --git a/tests/qapi-schema/bad-if.err b/tests/qapi-schema/bad-if.err
new file mode 100644
index 0000000000..8054fbb143
--- /dev/null
+++ b/tests/qapi-schema/bad-if.err
@@ -0,0 +1 @@
+tests/qapi-schema/bad-if.json:2: 'if' condition requires a string or a l=
ist of string
diff --git a/tests/qapi-schema/bad-if.exit b/tests/qapi-schema/bad-if.exi=
t
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/bad-if.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/bad-if.json b/tests/qapi-schema/bad-if.jso=
n
new file mode 100644
index 0000000000..3edd1a0bf2
--- /dev/null
+++ b/tests/qapi-schema/bad-if.json
@@ -0,0 +1,3 @@
+# check invalid 'if' type
+{ 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
+  'if': { 'value': 'defined(TEST_IF_STRUCT)' } }
diff --git a/tests/qapi-schema/bad-if.out b/tests/qapi-schema/bad-if.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index c72dbd8050..dc2c444fc1 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -188,3 +188,23 @@
   'data': { 'a': ['__org.qemu_x-Enum'], 'b': ['__org.qemu_x-Struct'],
             'c': '__org.qemu_x-Union2', 'd': '__org.qemu_x-Alt' },
   'returns': '__org.qemu_x-Union1' }
+
+# test 'if' condition handling
+
+{ 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
+  'if': 'defined(TEST_IF_STRUCT)' }
+
+{ 'enum': 'TestIfEnum', 'data': [ 'foo', 'bar' ],
+  'if': 'defined(TEST_IF_ENUM)' }
+
+{ 'union': 'TestIfUnion', 'data': { 'foo': 'TestStruct' },
+  'if': 'defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)' }
+
+{ 'alternate': 'TestIfAlternate', 'data': { 'foo': 'int', 'bar': 'TestSt=
ruct' },
+  'if': 'defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)' }
+
+{ 'command': 'TestIfCmd', 'data': { 'foo': 'TestIfStruct' },
+  'if': 'defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)' }
+
+{ 'event': 'TestIfEvent', 'data': { 'foo': 'TestIfStruct' },
+  'if': 'defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)' }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 3b1e9082d3..fc5fd25f1b 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -52,6 +52,29 @@ enum QEnumTwo ['value1', 'value2']
     prefix QENUM_TWO
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
+alternate TestIfAlternate
+    tag type
+    case foo: int
+    case bar: TestStruct
+    if defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)
+command TestIfCmd q_obj_TestIfCmd-arg -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse
+    if defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)
+enum TestIfEnum ['foo', 'bar']
+    if defined(TEST_IF_ENUM)
+event TestIfEvent q_obj_TestIfEvent-arg
+   boxed=3DFalse
+    if defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)
+object TestIfStruct
+    member foo: int optional=3DFalse
+    if defined(TEST_IF_STRUCT)
+object TestIfUnion
+    member type: TestIfUnionKind optional=3DFalse
+    tag type
+    case foo: q_obj_TestStruct-wrapper
+    if defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)
+enum TestIfUnionKind ['foo']
+    if defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)
 object TestStruct
     member integer: int optional=3DFalse
     member boolean: bool optional=3DFalse
@@ -172,6 +195,14 @@ object q_obj_EVENT_D-arg
     member b: str optional=3DFalse
     member c: str optional=3DTrue
     member enum3: EnumOne optional=3DTrue
+object q_obj_TestIfCmd-arg
+    member foo: TestIfStruct optional=3DFalse
+    if defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)
+object q_obj_TestIfEvent-arg
+    member foo: TestIfStruct optional=3DFalse
+    if defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)
+object q_obj_TestStruct-wrapper
+    member data: TestStruct optional=3DFalse
 object q_obj_UserDefFlatUnion2-base
     member integer: int optional=3DTrue
     member string: str optional=3DFalse
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index c7724d3437..17fd975812 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -17,12 +17,13 @@ import sys
=20
=20
 class QAPISchemaTestVisitor(QAPISchemaVisitor):
-    def visit_enum_type(self, name, info, values, prefix):
+    def visit_enum_type(self, name, info, values, prefix, ifcond):
         print 'enum %s %s' % (name, values)
         if prefix:
             print '    prefix %s' % prefix
+        self._print_if(ifcond)
=20
-    def visit_object_type(self, name, info, base, members, variants):
+    def visit_object_type(self, name, info, base, members, variants, ifc=
ond):
         print 'object %s' % name
         if base:
             print '    base %s' % base.name
@@ -30,21 +31,25 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             print '    member %s: %s optional=3D%s' % \
                 (m.name, m.type.name, m.optional)
         self._print_variants(variants)
+        self._print_if(ifcond)
=20
-    def visit_alternate_type(self, name, info, variants):
+    def visit_alternate_type(self, name, info, variants, ifcond):
         print 'alternate %s' % name
         self._print_variants(variants)
+        self._print_if(ifcond)
=20
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, ifcond):
         print 'command %s %s -> %s' % \
             (name, arg_type and arg_type.name, ret_type and ret_type.nam=
e)
         print '   gen=3D%s success_response=3D%s boxed=3D%s' % \
             (gen, success_response, boxed)
+        self._print_if(ifcond)
=20
-    def visit_event(self, name, info, arg_type, boxed):
+    def visit_event(self, name, info, arg_type, boxed, ifcond):
         print 'event %s %s' % (name, arg_type and arg_type.name)
         print '   boxed=3D%s' % boxed
+        self._print_if(ifcond)
=20
     @staticmethod
     def _print_variants(variants):
@@ -53,6 +58,12 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             for v in variants.variants:
                 print '    case %s: %s' % (v.name, v.type.name)
=20
+    @staticmethod
+    def _print_if(ifcond):
+        if ifcond:
+            print '    if %s' % ifcond
+
+
 schema =3D QAPISchema(sys.argv[1])
 schema.visit(QAPISchemaTestVisitor())
=20
--=20
2.14.0.rc0.1.g40ca67566

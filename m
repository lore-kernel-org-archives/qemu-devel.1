Received: from eggs.gnu.org ([2001:4830:134:3::10]:49999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkUT-0005lD-LZ
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkUR-0001tk-Gx
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:34:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkUR-0001t9-8K
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:34:23 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:07 +0100
Message-Id: <20180111213250.16511-9-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 08/51] qapi: add 'ifcond' to visitor methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Modify the test visitor to check correct passing of values.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py                        | 31 +++++++++++++++++-----------=
---
 scripts/qapi-commands.py               |  2 +-
 scripts/qapi-event.py                  |  2 +-
 scripts/qapi-introspect.py             | 12 ++++++------
 scripts/qapi-types.py                  |  8 ++++----
 scripts/qapi-visit.py                  |  8 ++++----
 scripts/qapi2texi.py                   | 10 +++++-----
 tests/qapi-schema/qapi-schema-test.out |  9 +++++++++
 tests/qapi-schema/test-qapi.py         | 21 ++++++++++++++++-----
 9 files changed, 63 insertions(+), 40 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 4d2c214f19..ffb4fb58e0 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1046,26 +1046,26 @@ class QAPISchemaVisitor(object):
     def visit_builtin_type(self, name, info, json_type):
         pass
=20
-    def visit_enum_type(self, name, info, values, prefix):
+    def visit_enum_type(self, name, info, ifcond, values, prefix):
         pass
=20
-    def visit_array_type(self, name, info, element_type):
+    def visit_array_type(self, name, info, ifcond, element_type):
         pass
=20
-    def visit_object_type(self, name, info, base, members, variants):
+    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
         pass
=20
-    def visit_object_type_flat(self, name, info, members, variants):
+    def visit_object_type_flat(self, name, info, ifcond, members, varian=
ts):
         pass
=20
-    def visit_alternate_type(self, name, info, variants):
+    def visit_alternate_type(self, name, info, ifcond, variants):
         pass
=20
-    def visit_command(self, name, info, arg_type, ret_type,
+    def visit_command(self, name, info, ifcond, arg_type, ret_type,
                       gen, success_response, boxed):
         pass
=20
-    def visit_event(self, name, info, arg_type, boxed):
+    def visit_event(self, name, info, ifcond, arg_type, boxed):
         pass
=20
=20
@@ -1165,7 +1165,7 @@ class QAPISchemaEnumType(QAPISchemaType):
         return 'string'
=20
     def visit(self, visitor):
-        visitor.visit_enum_type(self.name, self.info,
+        visitor.visit_enum_type(self.name, self.info, self.ifcond,
                                 self.member_names(), self.prefix)
=20
=20
@@ -1199,7 +1199,8 @@ class QAPISchemaArrayType(QAPISchemaType):
         return 'array of ' + elt_doc_type
=20
     def visit(self, visitor):
-        visitor.visit_array_type(self.name, self.info, self.element_type=
)
+        visitor.visit_array_type(self.name, self.info, self.ifcond,
+                                 self.element_type)
=20
=20
 class QAPISchemaObjectType(QAPISchemaType):
@@ -1281,9 +1282,9 @@ class QAPISchemaObjectType(QAPISchemaType):
         return 'object'
=20
     def visit(self, visitor):
-        visitor.visit_object_type(self.name, self.info,
+        visitor.visit_object_type(self.name, self.info, self.ifcond,
                                   self.base, self.local_members, self.va=
riants)
-        visitor.visit_object_type_flat(self.name, self.info,
+        visitor.visit_object_type_flat(self.name, self.info, self.ifcond=
,
                                        self.members, self.variants)
=20
=20
@@ -1428,7 +1429,8 @@ class QAPISchemaAlternateType(QAPISchemaType):
         return 'value'
=20
     def visit(self, visitor):
-        visitor.visit_alternate_type(self.name, self.info, self.variants=
)
+        visitor.visit_alternate_type(self.name, self.info, self.ifcond,
+                                     self.variants)
=20
     def is_empty(self):
         return False
@@ -1469,7 +1471,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
             assert isinstance(self.ret_type, QAPISchemaType)
=20
     def visit(self, visitor):
-        visitor.visit_command(self.name, self.info,
+        visitor.visit_command(self.name, self.info, self.ifcond,
                               self.arg_type, self.ret_type,
                               self.gen, self.success_response, self.boxe=
d)
=20
@@ -1500,7 +1502,8 @@ class QAPISchemaEvent(QAPISchemaEntity):
             raise QAPISemError(self.info, "Use of 'boxed' requires 'data=
'")
=20
     def visit(self, visitor):
-        visitor.visit_event(self.name, self.info, self.arg_type, self.bo=
xed)
+        visitor.visit_event(self.name, self.info, self.ifcond,
+                            self.arg_type, self.boxed)
=20
=20
 class QAPISchema(object):
diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 974d0a4a80..669aef1eb7 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -240,7 +240,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
         self._regy =3D None
         self._visited_ret_types =3D None
=20
-    def visit_command(self, name, info, arg_type, ret_type,
+    def visit_command(self, name, info, ifcond, arg_type, ret_type,
                       gen, success_response, boxed):
         if not gen:
             return
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index 07b4b70199..dda496e824 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -163,7 +163,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
         self.defn +=3D gen_enum_lookup(event_enum_name, self._event_name=
s)
         self._event_names =3D None
=20
-    def visit_event(self, name, info, arg_type, boxed):
+    def visit_event(self, name, info, ifcond, arg_type, boxed):
         self.decl +=3D gen_event_send_decl(name, arg_type, boxed)
         self.defn +=3D gen_event_send(name, arg_type, boxed)
         self._event_names.append(name)
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 0002bc1a68..56c1f9d548 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -142,26 +142,26 @@ const QLitObject %(c_name)s =3D %(c_string)s;
     def visit_builtin_type(self, name, info, json_type):
         self._gen_qlit(name, 'builtin', {'json-type': json_type})
=20
-    def visit_enum_type(self, name, info, values, prefix):
+    def visit_enum_type(self, name, info, ifcond, values, prefix):
         self._gen_qlit(name, 'enum', {'values': values})
=20
-    def visit_array_type(self, name, info, element_type):
+    def visit_array_type(self, name, info, ifcond, element_type):
         element =3D self._use_type(element_type)
         self._gen_qlit('[' + element + ']', 'array', {'element-type': el=
ement})
=20
-    def visit_object_type_flat(self, name, info, members, variants):
+    def visit_object_type_flat(self, name, info, ifcond, members, varian=
ts):
         obj =3D {'members': [self._gen_member(m) for m in members]}
         if variants:
             obj.update(self._gen_variants(variants.tag_member.name,
                                           variants.variants))
         self._gen_qlit(name, 'object', obj)
=20
-    def visit_alternate_type(self, name, info, variants):
+    def visit_alternate_type(self, name, info, ifcond, variants):
         self._gen_qlit(name, 'alternate',
                        {'members': [{'type': self._use_type(m.type)}
                                     for m in variants.variants]})
=20
-    def visit_command(self, name, info, arg_type, ret_type,
+    def visit_command(self, name, info, ifcond, arg_type, ret_type,
                       gen, success_response, boxed):
         arg_type =3D arg_type or self._schema.the_empty_object_type
         ret_type =3D ret_type or self._schema.the_empty_object_type
@@ -169,7 +169,7 @@ const QLitObject %(c_name)s =3D %(c_string)s;
                        {'arg-type': self._use_type(arg_type),
                         'ret-type': self._use_type(ret_type)})
=20
-    def visit_event(self, name, info, arg_type, boxed):
+    def visit_event(self, name, info, ifcond, arg_type, boxed):
         arg_type =3D arg_type or self._schema.the_empty_object_type
         self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)})
=20
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 7e3051dbb9..915786c463 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -195,7 +195,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         self.decl +=3D gen_type_cleanup_decl(name)
         self.defn +=3D gen_type_cleanup(name)
=20
-    def visit_enum_type(self, name, info, values, prefix):
+    def visit_enum_type(self, name, info, ifcond, values, prefix):
         # Special case for our lone builtin enum type
         # TODO use something cleaner than existence of info
         if not info:
@@ -206,7 +206,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
             self._fwdecl +=3D gen_enum(name, values, prefix)
             self.defn +=3D gen_enum_lookup(name, values, prefix)
=20
-    def visit_array_type(self, name, info, element_type):
+    def visit_array_type(self, name, info, ifcond, element_type):
         if isinstance(element_type, QAPISchemaBuiltinType):
             self._btin +=3D gen_fwd_object_or_array(name)
             self._btin +=3D gen_array(name, element_type)
@@ -218,7 +218,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
             self.decl +=3D gen_array(name, element_type)
             self._gen_type_cleanup(name)
=20
-    def visit_object_type(self, name, info, base, members, variants):
+    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
         # Nothing to do for the special empty builtin
         if name =3D=3D 'q_empty':
             return
@@ -232,7 +232,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
             # implicit types won't be directly allocated/freed
             self._gen_type_cleanup(name)
=20
-    def visit_alternate_type(self, name, info, variants):
+    def visit_alternate_type(self, name, info, ifcond, variants):
         self._fwdecl +=3D gen_fwd_object_or_array(name)
         self.decl +=3D gen_object(name, None, [variants.tag_member], var=
iants)
         self._gen_type_cleanup(name)
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 7e1cfc13f0..aceea2a9f9 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -282,7 +282,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         self.decl =3D self._btin + self.decl
         self._btin =3D None
=20
-    def visit_enum_type(self, name, info, values, prefix):
+    def visit_enum_type(self, name, info, ifcond, values, prefix):
         # Special case for our lone builtin enum type
         # TODO use something cleaner than existence of info
         if not info:
@@ -293,7 +293,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
             self.decl +=3D gen_visit_decl(name, scalar=3DTrue)
             self.defn +=3D gen_visit_enum(name)
=20
-    def visit_array_type(self, name, info, element_type):
+    def visit_array_type(self, name, info, ifcond, element_type):
         decl =3D gen_visit_decl(name)
         defn =3D gen_visit_list(name, element_type)
         if isinstance(element_type, QAPISchemaBuiltinType):
@@ -304,7 +304,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
             self.decl +=3D decl
             self.defn +=3D defn
=20
-    def visit_object_type(self, name, info, base, members, variants):
+    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
         # Nothing to do for the special empty builtin
         if name =3D=3D 'q_empty':
             return
@@ -317,7 +317,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
             self.decl +=3D gen_visit_decl(name)
             self.defn +=3D gen_visit_object(name, base, members, variant=
s)
=20
-    def visit_alternate_type(self, name, info, variants):
+    def visit_alternate_type(self, name, info, ifcond, variants):
         self.decl +=3D gen_visit_decl(name)
         self.defn +=3D gen_visit_alternate(name, variants)
=20
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 0a08fbaf7b..f24fb89bd5 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -203,14 +203,14 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisito=
r):
     def visit_begin(self, schema):
         self.out =3D ''
=20
-    def visit_enum_type(self, name, info, values, prefix):
+    def visit_enum_type(self, name, info, ifcond, values, prefix):
         doc =3D self.cur_doc
         self.out +=3D TYPE_FMT(type=3D'Enum',
                              name=3Ddoc.symbol,
                              body=3Dtexi_entity(doc, 'Values',
                                               member_func=3Dtexi_enum_va=
lue))
=20
-    def visit_object_type(self, name, info, base, members, variants):
+    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
         doc =3D self.cur_doc
         if base and base.is_implicit():
             base =3D None
@@ -218,13 +218,13 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisito=
r):
                              name=3Ddoc.symbol,
                              body=3Dtexi_entity(doc, 'Members', base, va=
riants))
=20
-    def visit_alternate_type(self, name, info, variants):
+    def visit_alternate_type(self, name, info, ifcond, variants):
         doc =3D self.cur_doc
         self.out +=3D TYPE_FMT(type=3D'Alternate',
                              name=3Ddoc.symbol,
                              body=3Dtexi_entity(doc, 'Members'))
=20
-    def visit_command(self, name, info, arg_type, ret_type,
+    def visit_command(self, name, info, ifcond, arg_type, ret_type,
                       gen, success_response, boxed):
         doc =3D self.cur_doc
         if boxed:
@@ -238,7 +238,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor)=
:
                             name=3Ddoc.symbol,
                             body=3Dbody)
=20
-    def visit_event(self, name, info, arg_type, boxed):
+    def visit_event(self, name, info, ifcond, arg_type, boxed):
         doc =3D self.cur_doc
         self.out +=3D MSG_FMT(type=3D'Event',
                             name=3Ddoc.symbol,
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 7fbaea19bc..0804c3af84 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -56,18 +56,25 @@ alternate TestIfAlternate
     tag type
     case foo: int
     case bar: TestStruct
+    if ['defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)']
 command TestIfCmd q_obj_TestIfCmd-arg -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
+    if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
 enum TestIfEnum ['foo', 'bar']
+    if ['defined(TEST_IF_ENUM)']
 event TestIfEvent q_obj_TestIfEvent-arg
    boxed=3DFalse
+    if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
 object TestIfStruct
     member foo: int optional=3DFalse
+    if ['defined(TEST_IF_STRUCT)']
 object TestIfUnion
     member type: TestIfUnionKind optional=3DFalse
     tag type
     case foo: q_obj_TestStruct-wrapper
+    if ['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)']
 enum TestIfUnionKind ['foo']
+    if ['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)']
 object TestStruct
     member integer: int optional=3DFalse
     member boolean: bool optional=3DFalse
@@ -190,8 +197,10 @@ object q_obj_EVENT_D-arg
     member enum3: EnumOne optional=3DTrue
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=3DFalse
+    if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
 object q_obj_TestIfEvent-arg
     member foo: TestIfStruct optional=3DFalse
+    if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
 object q_obj_TestStruct-wrapper
     member data: TestStruct optional=3DFalse
 object q_obj_UserDefFlatUnion2-base
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index fe0ca08d78..a4b3a00bbd 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -17,12 +17,13 @@ import sys
=20
=20
 class QAPISchemaTestVisitor(QAPISchemaVisitor):
-    def visit_enum_type(self, name, info, values, prefix):
+    def visit_enum_type(self, name, info, ifcond, values, prefix):
         print 'enum %s %s' % (name, values)
         if prefix:
             print '    prefix %s' % prefix
+        self._print_if(ifcond)
=20
-    def visit_object_type(self, name, info, base, members, variants):
+    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
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
+    def visit_alternate_type(self, name, info, ifcond, variants):
         print 'alternate %s' % name
         self._print_variants(variants)
+        self._print_if(ifcond)
=20
-    def visit_command(self, name, info, arg_type, ret_type,
+    def visit_command(self, name, info, ifcond, arg_type, ret_type,
                       gen, success_response, boxed):
         print 'command %s %s -> %s' % \
             (name, arg_type and arg_type.name, ret_type and ret_type.nam=
e)
         print '   gen=3D%s success_response=3D%s boxed=3D%s' % \
             (gen, success_response, boxed)
+        self._print_if(ifcond)
=20
-    def visit_event(self, name, info, arg_type, boxed):
+    def visit_event(self, name, info, ifcond, arg_type, boxed):
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
+    def _print_if(ifcond, indent=3D4):
+        if ifcond:
+            print '%sif %s' % (' ' * indent, ifcond)
+
+
 schema =3D QAPISchema(sys.argv[1])
 schema.visit(QAPISchemaTestVisitor())
=20
--=20
2.16.0.rc1.1.gef27df75a1

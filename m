Received: from eggs.gnu.org ([2001:4830:134:3::10]:54562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9HN-0006Gz-CR
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9HL-0005dy-40
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:31:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9HK-0005dY-Qv
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:31:35 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:19 +0200
Message-Id: <20170822132255.23945-19-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 18/54] qapi: add 'ifcond' to visitor methods
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

Modify the test visitor to check correct passing of values.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                        | 34 ++++++++++++++++++++--------=
------
 scripts/qapi-commands.py               |  2 +-
 scripts/qapi-event.py                  |  2 +-
 scripts/qapi-introspect.py             | 12 ++++++------
 scripts/qapi-types.py                  |  8 ++++----
 scripts/qapi-visit.py                  |  8 ++++----
 scripts/qapi2texi.py                   | 10 +++++-----
 tests/qapi-schema/qapi-schema-test.out |  9 +++++++++
 tests/qapi-schema/test-qapi.py         | 21 ++++++++++++++++-----
 9 files changed, 66 insertions(+), 40 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index dc40d74abb..86845a28f9 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1031,26 +1031,26 @@ class QAPISchemaVisitor(object):
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
@@ -1150,7 +1150,7 @@ class QAPISchemaEnumType(QAPISchemaType):
=20
     def visit(self, visitor):
         visitor.visit_enum_type(self.name, self.info,
-                                self.member_names(), self.prefix)
+                                self.member_names(), self.prefix, self.i=
fcond)
=20
=20
 class QAPISchemaArrayType(QAPISchemaType):
@@ -1181,7 +1181,8 @@ class QAPISchemaArrayType(QAPISchemaType):
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
@@ -1263,9 +1264,11 @@ class QAPISchemaObjectType(QAPISchemaType):
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
+                                       self.members, self.variants,
+                                       self.ifcond)
=20
=20
 class QAPISchemaMember(object):
@@ -1408,7 +1411,8 @@ class QAPISchemaAlternateType(QAPISchemaType):
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
@@ -1450,7 +1454,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
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
@@ -1478,7 +1483,8 @@ class QAPISchemaEvent(QAPISchemaEntity):
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
diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 974d0a4a80..5eb96b2d95 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -241,7 +241,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
         self._visited_ret_types =3D None
=20
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, ifcond):
         if not gen:
             return
         self.decl +=3D gen_command_decl(name, arg_type, boxed, ret_type)
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index bcbef1035f..fec27fe2e1 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -163,7 +163,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
         self.defn +=3D gen_enum_lookup(event_enum_name, self._event_name=
s)
         self._event_names =3D None
=20
-    def visit_event(self, name, info, arg_type, boxed):
+    def visit_event(self, name, info, arg_type, boxed, ifcond):
         self.decl +=3D gen_event_send_decl(name, arg_type, boxed)
         self.defn +=3D gen_event_send(name, arg_type, boxed)
         self._event_names.append(name)
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 1b96926fa7..4c437d60ec 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -142,34 +142,34 @@ const QLitObject %(c_name)s =3D %(c_string)s;
     def visit_builtin_type(self, name, info, json_type):
         self._gen_qlit(name, 'builtin', {'json-type': json_type})
=20
-    def visit_enum_type(self, name, info, values, prefix):
+    def visit_enum_type(self, name, info, values, prefix, ifcond):
         self._gen_qlit(name, 'enum', {'values': values})
=20
-    def visit_array_type(self, name, info, element_type):
+    def visit_array_type(self, name, info, element_type, ifcond):
         element =3D self._use_type(element_type)
         self._gen_qlit('[' + element + ']', 'array', {'element-type': el=
ement})
=20
-    def visit_object_type_flat(self, name, info, members, variants):
+    def visit_object_type_flat(self, name, info, members, variants, ifco=
nd):
         obj =3D {'members': [self._gen_member(m) for m in members]}
         if variants:
             obj.update(self._gen_variants(variants.tag_member.name,
                                           variants.variants))
         self._gen_qlit(name, 'object', obj)
=20
-    def visit_alternate_type(self, name, info, variants):
+    def visit_alternate_type(self, name, info, variants, ifcond):
         self._gen_qlit(name, 'alternate',
                        {'members': [{'type': self._use_type(m.type)}
                                     for m in variants.variants]})
=20
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, ifcond):
         arg_type =3D arg_type or self._schema.the_empty_object_type
         ret_type =3D ret_type or self._schema.the_empty_object_type
         self._gen_qlit(name, 'command',
                        {'arg-type': self._use_type(arg_type),
                         'ret-type': self._use_type(ret_type)})
=20
-    def visit_event(self, name, info, arg_type, boxed):
+    def visit_event(self, name, info, arg_type, boxed, ifcond):
         arg_type =3D arg_type or self._schema.the_empty_object_type
         self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)})
=20
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index dc05268917..6f06720adc 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -201,7 +201,7 @@ typedef struct QEnumLookup {
         self.decl +=3D gen_type_cleanup_decl(name)
         self.defn +=3D gen_type_cleanup(name)
=20
-    def visit_enum_type(self, name, info, values, prefix):
+    def visit_enum_type(self, name, info, values, prefix, ifcond):
         # Special case for our lone builtin enum type
         # TODO use something cleaner than existence of info
         if not info:
@@ -212,7 +212,7 @@ typedef struct QEnumLookup {
             self._fwdecl +=3D gen_enum(name, values, prefix)
             self.defn +=3D gen_enum_lookup(name, values, prefix)
=20
-    def visit_array_type(self, name, info, element_type):
+    def visit_array_type(self, name, info, element_type, ifcond):
         if isinstance(element_type, QAPISchemaBuiltinType):
             self._btin +=3D gen_fwd_object_or_array(name)
             self._btin +=3D gen_array(name, element_type)
@@ -224,7 +224,7 @@ typedef struct QEnumLookup {
             self.decl +=3D gen_array(name, element_type)
             self._gen_type_cleanup(name)
=20
-    def visit_object_type(self, name, info, base, members, variants):
+    def visit_object_type(self, name, info, base, members, variants, ifc=
ond):
         # Nothing to do for the special empty builtin
         if name =3D=3D 'q_empty':
             return
@@ -238,7 +238,7 @@ typedef struct QEnumLookup {
             # implicit types won't be directly allocated/freed
             self._gen_type_cleanup(name)
=20
-    def visit_alternate_type(self, name, info, variants):
+    def visit_alternate_type(self, name, info, variants, ifcond):
         self._fwdecl +=3D gen_fwd_object_or_array(name)
         self.decl +=3D gen_object(name, None, [variants.tag_member], var=
iants)
         self._gen_type_cleanup(name)
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 7e1cfc13f0..c29c2d869e 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -282,7 +282,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
         self.decl =3D self._btin + self.decl
         self._btin =3D None
=20
-    def visit_enum_type(self, name, info, values, prefix):
+    def visit_enum_type(self, name, info, values, prefix, ifcond):
         # Special case for our lone builtin enum type
         # TODO use something cleaner than existence of info
         if not info:
@@ -293,7 +293,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
             self.decl +=3D gen_visit_decl(name, scalar=3DTrue)
             self.defn +=3D gen_visit_enum(name)
=20
-    def visit_array_type(self, name, info, element_type):
+    def visit_array_type(self, name, info, element_type, ifcond):
         decl =3D gen_visit_decl(name)
         defn =3D gen_visit_list(name, element_type)
         if isinstance(element_type, QAPISchemaBuiltinType):
@@ -304,7 +304,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
             self.decl +=3D decl
             self.defn +=3D defn
=20
-    def visit_object_type(self, name, info, base, members, variants):
+    def visit_object_type(self, name, info, base, members, variants, ifc=
ond):
         # Nothing to do for the special empty builtin
         if name =3D=3D 'q_empty':
             return
@@ -317,7 +317,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
             self.decl +=3D gen_visit_decl(name)
             self.defn +=3D gen_visit_object(name, base, members, variant=
s)
=20
-    def visit_alternate_type(self, name, info, variants):
+    def visit_alternate_type(self, name, info, variants, ifcond):
         self.decl +=3D gen_visit_decl(name)
         self.defn +=3D gen_visit_alternate(name, variants)
=20
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 8b542f9fff..ae7920aa87 100755
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
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 7fbaea19bc..fc5fd25f1b 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -56,18 +56,25 @@ alternate TestIfAlternate
     tag type
     case foo: int
     case bar: TestStruct
+    if defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)
 command TestIfCmd q_obj_TestIfCmd-arg -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
+    if defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)
 enum TestIfEnum ['foo', 'bar']
+    if defined(TEST_IF_ENUM)
 event TestIfEvent q_obj_TestIfEvent-arg
    boxed=3DFalse
+    if defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)
 object TestIfStruct
     member foo: int optional=3DFalse
+    if defined(TEST_IF_STRUCT)
 object TestIfUnion
     member type: TestIfUnionKind optional=3DFalse
     tag type
     case foo: q_obj_TestStruct-wrapper
+    if defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)
 enum TestIfUnionKind ['foo']
+    if defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)
 object TestStruct
     member integer: int optional=3DFalse
     member boolean: bool optional=3DFalse
@@ -190,8 +197,10 @@ object q_obj_EVENT_D-arg
     member enum3: EnumOne optional=3DTrue
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=3DFalse
+    if defined(TEST_IF_CMD) && defined(TEST_IF_STRUCT)
 object q_obj_TestIfEvent-arg
     member foo: TestIfStruct optional=3DFalse
+    if defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)
 object q_obj_TestStruct-wrapper
     member data: TestStruct optional=3DFalse
 object q_obj_UserDefFlatUnion2-base
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
2.14.1.146.gd35faa819

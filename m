Received: from eggs.gnu.org ([2001:4830:134:3::10]:39491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1faNfp-00024n-BQ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1faNfn-0003SO-0V
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:57:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36760 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1faNfm-0003Rz-QV
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:56:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 517F0408042B
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:56:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  3 Jul 2018 17:56:38 +0200
Message-Id: <20180703155648.11933-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180703155648.11933-1-marcandre.lureau@redhat.com>
References: <20180703155648.11933-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 04/14] qapi: add 'ifcond' to visitor methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Modify the test visitor to check correct passing of values.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/commands.py               |  2 +-
 scripts/qapi/common.py                 | 31 ++++++++++++++------------
 scripts/qapi/doc.py                    | 10 ++++-----
 scripts/qapi/events.py                 |  2 +-
 scripts/qapi/introspect.py             | 12 +++++-----
 scripts/qapi/types.py                  |  8 +++----
 scripts/qapi/visit.py                  |  8 +++----
 roms/seabios                           |  2 +-
 tests/qapi-schema/qapi-schema-test.out |  9 ++++++++
 tests/qapi-schema/test-qapi.py         | 20 ++++++++++++-----
 10 files changed, 63 insertions(+), 41 deletions(-)
 mode change 100644 =3D> 100755 scripts/qapi/doc.py

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 3b0867c14f..dcc03c7859 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -277,7 +277,7 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmd=
s);
                        c_prefix=3Dc_name(self._prefix, protect=3DFalse))=
)
         genc.add(gen_registry(self._regy, self._prefix))
=20
-    def visit_command(self, name, info, arg_type, ret_type, gen,
+    def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfi=
g):
         if not gen:
             return
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 46e33e23e4..feae646e09 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1062,26 +1062,26 @@ class QAPISchemaVisitor(object):
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
-    def visit_command(self, name, info, arg_type, ret_type, gen,
+    def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfi=
g):
         pass
=20
-    def visit_event(self, name, info, arg_type, boxed):
+    def visit_event(self, name, info, ifcond, arg_type, boxed):
         pass
=20
=20
@@ -1191,7 +1191,7 @@ class QAPISchemaEnumType(QAPISchemaType):
         return 'string'
=20
     def visit(self, visitor):
-        visitor.visit_enum_type(self.name, self.info,
+        visitor.visit_enum_type(self.name, self.info, self.ifcond,
                                 self.member_names(), self.prefix)
=20
=20
@@ -1225,7 +1225,8 @@ class QAPISchemaArrayType(QAPISchemaType):
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
@@ -1307,9 +1308,9 @@ class QAPISchemaObjectType(QAPISchemaType):
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
@@ -1462,7 +1463,8 @@ class QAPISchemaAlternateType(QAPISchemaType):
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
@@ -1505,7 +1507,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
             assert isinstance(self.ret_type, QAPISchemaType)
=20
     def visit(self, visitor):
-        visitor.visit_command(self.name, self.info,
+        visitor.visit_command(self.name, self.info, self.ifcond,
                               self.arg_type, self.ret_type,
                               self.gen, self.success_response,
                               self.boxed, self.allow_oob,
@@ -1538,7 +1540,8 @@ class QAPISchemaEvent(QAPISchemaEntity):
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
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
old mode 100644
new mode 100755
index b5630844f9..4db6674dc3
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -204,14 +204,14 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchem=
aVisitor):
     def write(self, output_dir):
         self._gen.write(output_dir, self._prefix + 'qapi-doc.texi')
=20
-    def visit_enum_type(self, name, info, values, prefix):
+    def visit_enum_type(self, name, info, ifcond, values, prefix):
         doc =3D self.cur_doc
         self._gen.add(TYPE_FMT(type=3D'Enum',
                                name=3Ddoc.symbol,
                                body=3Dtexi_entity(doc, 'Values',
                                                 member_func=3Dtexi_enum_=
value)))
=20
-    def visit_object_type(self, name, info, base, members, variants):
+    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
         doc =3D self.cur_doc
         if base and base.is_implicit():
             base =3D None
@@ -220,13 +220,13 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchem=
aVisitor):
                                body=3Dtexi_entity(doc, 'Members',
                                                 base, variants)))
=20
-    def visit_alternate_type(self, name, info, variants):
+    def visit_alternate_type(self, name, info, ifcond, variants):
         doc =3D self.cur_doc
         self._gen.add(TYPE_FMT(type=3D'Alternate',
                                name=3Ddoc.symbol,
                                body=3Dtexi_entity(doc, 'Members')))
=20
-    def visit_command(self, name, info, arg_type, ret_type, gen,
+    def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfi=
g):
         doc =3D self.cur_doc
         if boxed:
@@ -240,7 +240,7 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaV=
isitor):
                               name=3Ddoc.symbol,
                               body=3Dbody))
=20
-    def visit_event(self, name, info, arg_type, boxed):
+    def visit_event(self, name, info, ifcond, arg_type, boxed):
         doc =3D self.cur_doc
         self._gen.add(MSG_FMT(type=3D'Event',
                               name=3Ddoc.symbol,
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 5657524688..0a1afac134 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -184,7 +184,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVis=
itor):
         genh.add(gen_enum(self._enum_name, self._event_names))
         genc.add(gen_enum_lookup(self._enum_name, self._event_names))
=20
-    def visit_event(self, name, info, arg_type, boxed):
+    def visit_event(self, name, info, ifcond, arg_type, boxed):
         self._genh.add(gen_event_send_decl(name, arg_type, boxed))
         self._genc.add(gen_event_send(name, arg_type, boxed, self._enum_=
name))
         self._event_names.append(name)
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 6ad198ae5b..245cfdfb65 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -149,26 +149,26 @@ const QLitObject %(c_name)s =3D %(c_string)s;
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
-    def visit_command(self, name, info, arg_type, ret_type, gen,
+    def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfi=
g):
         arg_type =3D arg_type or self._schema.the_empty_object_type
         ret_type =3D ret_type or self._schema.the_empty_object_type
@@ -178,7 +178,7 @@ const QLitObject %(c_name)s =3D %(c_string)s;
                         'allow-oob': allow_oob,
                         'allow-preconfig': allow_preconfig})
=20
-    def visit_event(self, name, info, arg_type, boxed):
+    def visit_event(self, name, info, ifcond, arg_type, boxed):
         arg_type =3D arg_type or self._schema.the_empty_object_type
         self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)})
=20
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index a599352e59..659075f884 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -208,16 +208,16 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVi=
sitor):
         self._genh.add(gen_type_cleanup_decl(name))
         self._genc.add(gen_type_cleanup(name))
=20
-    def visit_enum_type(self, name, info, values, prefix):
+    def visit_enum_type(self, name, info, ifcond, values, prefix):
         self._genh.preamble_add(gen_enum(name, values, prefix))
         self._genc.add(gen_enum_lookup(name, values, prefix))
=20
-    def visit_array_type(self, name, info, element_type):
+    def visit_array_type(self, name, info, ifcond, element_type):
         self._genh.preamble_add(gen_fwd_object_or_array(name))
         self._genh.add(gen_array(name, element_type))
         self._gen_type_cleanup(name)
=20
-    def visit_object_type(self, name, info, base, members, variants):
+    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
         # Nothing to do for the special empty builtin
         if name =3D=3D 'q_empty':
             return
@@ -231,7 +231,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisi=
tor):
             # implicit types won't be directly allocated/freed
             self._gen_type_cleanup(name)
=20
-    def visit_alternate_type(self, name, info, variants):
+    def visit_alternate_type(self, name, info, ifcond, variants):
         self._genh.preamble_add(gen_fwd_object_or_array(name))
         self._genh.add(gen_object(name, None,
                                   [variants.tag_member], variants))
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index bdcafb64ee..34fe1ef5eb 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -310,15 +310,15 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCV=
isitor):
 ''',
                                       types=3Dtypes))
=20
-    def visit_enum_type(self, name, info, values, prefix):
+    def visit_enum_type(self, name, info, ifcond, values, prefix):
         self._genh.add(gen_visit_decl(name, scalar=3DTrue))
         self._genc.add(gen_visit_enum(name))
=20
-    def visit_array_type(self, name, info, element_type):
+    def visit_array_type(self, name, info, ifcond, element_type):
         self._genh.add(gen_visit_decl(name))
         self._genc.add(gen_visit_list(name, element_type))
=20
-    def visit_object_type(self, name, info, base, members, variants):
+    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
         # Nothing to do for the special empty builtin
         if name =3D=3D 'q_empty':
             return
@@ -331,7 +331,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVis=
itor):
             self._genh.add(gen_visit_decl(name))
             self._genc.add(gen_visit_object(name, base, members, variant=
s))
=20
-    def visit_alternate_type(self, name, info, variants):
+    def visit_alternate_type(self, name, info, ifcond, variants):
         self._genh.add(gen_visit_decl(name))
         self._genc.add(gen_visit_alternate(name, variants))
=20
diff --git a/roms/seabios b/roms/seabios
index f9626ccb91..0551a4be2c 160000
--- a/roms/seabios
+++ b/roms/seabios
@@ -1 +1 @@
-Subproject commit f9626ccb91e771f990fbb2da92e427a399d7d918
+Subproject commit 0551a4be2ce599fb60e478b4c15e06ab6587822c
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index ed25e5b60c..0da92455da 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -237,25 +237,34 @@ command __org.qemu_x-command q_obj___org.qemu_x-com=
mand-arg -> __org.qemu_x-Unio
    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
 object TestIfStruct
     member foo: int optional=3DFalse
+    if ['defined(TEST_IF_STRUCT)']
 enum TestIfEnum ['foo', 'bar']
+    if ['defined(TEST_IF_ENUM)']
 object q_obj_TestStruct-wrapper
     member data: TestStruct optional=3DFalse
 enum TestIfUnionKind ['foo']
+    if ['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)']
 object TestIfUnion
     member type: TestIfUnionKind optional=3DFalse
     tag type
     case foo: q_obj_TestStruct-wrapper
+    if ['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)']
 alternate TestIfAlternate
     tag type
     case foo: int
     case bar: TestStruct
+    if ['defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)']
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=3DFalse
+    if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
 command TestIfCmd q_obj_TestIfCmd-arg -> UserDefThree
    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+    if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
 command TestCmdReturnDefThree None -> UserDefThree
    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
 object q_obj_TestIfEvent-arg
     member foo: TestIfStruct optional=3DFalse
+    if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
 event TestIfEvent q_obj_TestIfEvent-arg
    boxed=3DFalse
+    if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index 4512a41504..f514fe71e4 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -23,12 +23,13 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
     def visit_include(self, name, info):
         print('include %s' % name)
=20
-    def visit_enum_type(self, name, info, values, prefix):
+    def visit_enum_type(self, name, info, ifcond, values, prefix):
         print('enum %s %s' % (name, values))
         if prefix:
             print('    prefix %s' % prefix)
+        self._print_if(ifcond)
=20
-    def visit_object_type(self, name, info, base, members, variants):
+    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
         print('object %s' % name)
         if base:
             print('    base %s' % base.name)
@@ -36,21 +37,25 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             print('    member %s: %s optional=3D%s' % \
                   (m.name, m.type.name, m.optional))
         self._print_variants(variants)
+        self._print_if(ifcond)
=20
-    def visit_alternate_type(self, name, info, variants):
+    def visit_alternate_type(self, name, info, ifcond, variants):
         print('alternate %s' % name)
         self._print_variants(variants)
+        self._print_if(ifcond)
=20
-    def visit_command(self, name, info, arg_type, ret_type, gen,
+    def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfi=
g):
         print('command %s %s -> %s' % \
               (name, arg_type and arg_type.name, ret_type and ret_type.n=
ame))
         print('   gen=3D%s success_response=3D%s boxed=3D%s oob=3D%s pre=
config=3D%s' % \
               (gen, success_response, boxed, allow_oob, allow_preconfig)=
)
+        self._print_if(ifcond)
=20
-    def visit_event(self, name, info, arg_type, boxed):
+    def visit_event(self, name, info, ifcond, arg_type, boxed):
         print('event %s %s' % (name, arg_type and arg_type.name))
         print('   boxed=3D%s' % boxed)
+        self._print_if(ifcond)
=20
     @staticmethod
     def _print_variants(variants):
@@ -59,6 +64,11 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             for v in variants.variants:
                 print('    case %s: %s' % (v.name, v.type.name))
=20
+    @staticmethod
+    def _print_if(ifcond, indent=3D4):
+        if ifcond:
+            print('%sif %s' % (' ' * indent, ifcond))
+
=20
 try:
     schema =3D QAPISchema(sys.argv[1])
--=20
2.18.0.rc1

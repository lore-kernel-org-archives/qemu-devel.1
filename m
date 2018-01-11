Received: from eggs.gnu.org ([2001:4830:134:3::10]:49444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkTV-0004wD-UD
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:33:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkTU-0000bC-7z
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:33:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkTT-0000Zv-VN
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:33:24 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:02 +0100
Message-Id: <20180111213250.16511-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 03/51] qapi: generate a literal qobject for
 introspection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Replace the generated json string with a literal qobject. The later is
easier to deal with, at run time as well as compile time: adding #if
conditionals will be easier than in a json string.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi-introspect.py         | 83 ++++++++++++++++++++++----------=
------
 monitor.c                          |  2 +-
 tests/test-qobject-input-visitor.c | 11 +++--
 docs/devel/qapi-code-gen.txt       | 29 ++++++++-----
 4 files changed, 76 insertions(+), 49 deletions(-)

diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 032bcea491..0002bc1a68 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -12,26 +12,36 @@
 from qapi import *
=20
=20
-# Caveman's json.dumps() replacement (we're stuck at Python 2.4)
-# TODO try to use json.dumps() once we get unstuck
-def to_json(obj, level=3D0):
+def to_qlit(obj, level=3D0, suppress_first_indent=3DFalse):
+
+    def indent(level):
+        return level * 4 * ' '
+
+    ret =3D ''
+    if not suppress_first_indent:
+        ret +=3D indent(level)
     if obj is None:
-        ret =3D 'null'
+        ret +=3D 'QLIT_QNULL'
     elif isinstance(obj, str):
-        ret =3D '"' + obj.replace('"', r'\"') + '"'
+        ret +=3D 'QLIT_QSTR(' + to_c_string(obj) + ')'
     elif isinstance(obj, list):
-        elts =3D [to_json(elt, level + 1)
+        elts =3D [to_qlit(elt, level + 1)
                 for elt in obj]
-        ret =3D '[' + ', '.join(elts) + ']'
+        elts.append(indent(level + 1) + "{}")
+        ret +=3D 'QLIT_QLIST(((QLitObject[]) {\n'
+        ret +=3D ',\n'.join(elts) + '\n'
+        ret +=3D indent(level) + '}))'
     elif isinstance(obj, dict):
-        elts =3D ['"%s": %s' % (key.replace('"', r'\"'),
-                              to_json(obj[key], level + 1))
-                for key in sorted(obj.keys())]
-        ret =3D '{' + ', '.join(elts) + '}'
+        elts =3D []
+        for key, value in sorted(obj.iteritems()):
+            elts.append(indent(level + 1) + '{ %s, %s }' %
+                        (to_c_string(key), to_qlit(value, level + 1, Tru=
e)))
+        elts.append(indent(level + 1) + '{}')
+        ret +=3D 'QLIT_QDICT(((QLitDictEntry[]) {\n'
+        ret +=3D ',\n'.join(elts) + '\n'
+        ret +=3D indent(level) + '}))'
     else:
         assert False                # not implemented
-    if level =3D=3D 1:
-        ret =3D '\n' + ret
     return ret
=20
=20
@@ -45,39 +55,37 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaVisito=
r):
         self.defn =3D None
         self.decl =3D None
         self._schema =3D None
-        self._jsons =3D None
+        self._qlits =3D None
         self._used_types =3D None
         self._name_map =3D None
=20
     def visit_begin(self, schema):
         self._schema =3D schema
-        self._jsons =3D []
+        self._qlits =3D []
         self._used_types =3D []
         self._name_map =3D {}
=20
     def visit_end(self):
         # visit the types that are actually used
-        jsons =3D self._jsons
-        self._jsons =3D []
+        qlits =3D self._qlits
+        self._qlits =3D []
         for typ in self._used_types:
             typ.visit(self)
         # generate C
         # TODO can generate awfully long lines
-        jsons.extend(self._jsons)
-        name =3D c_name(prefix, protect=3DFalse) + 'qmp_schema_json'
+        qlits.extend(self._qlits)
+        name =3D c_name(prefix, protect=3DFalse) + 'qmp_schema_qlit'
         self.decl =3D mcgen('''
-extern const char %(c_name)s[];
+extern const QLitObject %(c_name)s;
 ''',
                           c_name=3Dc_name(name))
-        lines =3D to_json(jsons).split('\n')
-        c_string =3D '\n    '.join([to_c_string(line) for line in lines]=
)
         self.defn =3D mcgen('''
-const char %(c_name)s[] =3D %(c_string)s;
+const QLitObject %(c_name)s =3D %(c_string)s;
 ''',
                           c_name=3Dc_name(name),
-                          c_string=3Dc_string)
+                          c_string=3Dto_qlit(qlits))
         self._schema =3D None
-        self._jsons =3D None
+        self._qlits =3D None
         self._used_types =3D None
         self._name_map =3D None
=20
@@ -111,12 +119,12 @@ const char %(c_name)s[] =3D %(c_string)s;
             return '[' + self._use_type(typ.element_type) + ']'
         return self._name(typ.name)
=20
-    def _gen_json(self, name, mtype, obj):
+    def _gen_qlit(self, name, mtype, obj):
         if mtype not in ('command', 'event', 'builtin', 'array'):
             name =3D self._name(name)
         obj['name'] =3D name
         obj['meta-type'] =3D mtype
-        self._jsons.append(obj)
+        self._qlits.append(obj)
=20
     def _gen_member(self, member):
         ret =3D {'name': member.name, 'type': self._use_type(member.type=
)}
@@ -132,24 +140,24 @@ const char %(c_name)s[] =3D %(c_string)s;
         return {'case': variant.name, 'type': self._use_type(variant.typ=
e)}
=20
     def visit_builtin_type(self, name, info, json_type):
-        self._gen_json(name, 'builtin', {'json-type': json_type})
+        self._gen_qlit(name, 'builtin', {'json-type': json_type})
=20
     def visit_enum_type(self, name, info, values, prefix):
-        self._gen_json(name, 'enum', {'values': values})
+        self._gen_qlit(name, 'enum', {'values': values})
=20
     def visit_array_type(self, name, info, element_type):
         element =3D self._use_type(element_type)
-        self._gen_json('[' + element + ']', 'array', {'element-type': el=
ement})
+        self._gen_qlit('[' + element + ']', 'array', {'element-type': el=
ement})
=20
     def visit_object_type_flat(self, name, info, members, variants):
         obj =3D {'members': [self._gen_member(m) for m in members]}
         if variants:
             obj.update(self._gen_variants(variants.tag_member.name,
                                           variants.variants))
-        self._gen_json(name, 'object', obj)
+        self._gen_qlit(name, 'object', obj)
=20
     def visit_alternate_type(self, name, info, variants):
-        self._gen_json(name, 'alternate',
+        self._gen_qlit(name, 'alternate',
                        {'members': [{'type': self._use_type(m.type)}
                                     for m in variants.variants]})
=20
@@ -157,13 +165,13 @@ const char %(c_name)s[] =3D %(c_string)s;
                       gen, success_response, boxed):
         arg_type =3D arg_type or self._schema.the_empty_object_type
         ret_type =3D ret_type or self._schema.the_empty_object_type
-        self._gen_json(name, 'command',
+        self._gen_qlit(name, 'command',
                        {'arg-type': self._use_type(arg_type),
                         'ret-type': self._use_type(ret_type)})
=20
     def visit_event(self, name, info, arg_type, boxed):
         arg_type =3D arg_type or self._schema.the_empty_object_type
-        self._gen_json(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)})
+        self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)})
=20
 # Debugging aid: unmask QAPI schema's type names
 # We normally mask them, because they're not QMP wire ABI
@@ -205,11 +213,18 @@ h_comment =3D '''
=20
 fdef.write(mcgen('''
 #include "qemu/osdep.h"
+#include "qapi/qmp/qlit.h"
 #include "%(prefix)sqmp-introspect.h"
=20
 ''',
                  prefix=3Dprefix))
=20
+fdecl.write(mcgen('''
+#include "qemu/osdep.h"
+#include "qapi/qmp/qlit.h"
+
+'''))
+
 schema =3D QAPISchema(input_file)
 gen =3D QAPISchemaGenIntrospectVisitor(opt_unmask)
 schema.visit(gen)
diff --git a/monitor.c b/monitor.c
index d682eee2d8..b8931364f2 100644
--- a/monitor.c
+++ b/monitor.c
@@ -953,7 +953,7 @@ EventInfoList *qmp_query_events(Error **errp)
 static void qmp_query_qmp_schema(QDict *qdict, QObject **ret_data,
                                  Error **errp)
 {
-    *ret_data =3D qobject_from_json(qmp_schema_json, &error_abort);
+    *ret_data =3D qobject_from_qlit(&qmp_schema_qlit);
 }
=20
 /*
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index fe591814e4..7c1d10e274 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -1247,24 +1247,27 @@ static void test_visitor_in_fail_alternate(TestIn=
putVisitorData *data,
 }
=20
 static void do_test_visitor_in_qmp_introspect(TestInputVisitorData *data=
,
-                                              const char *schema_json)
+                                              const QLitObject *qlit)
 {
     SchemaInfoList *schema =3D NULL;
+    QObject *obj =3D qobject_from_qlit(qlit);
     Visitor *v;
=20
-    v =3D visitor_input_test_init_raw(data, schema_json);
+    v =3D qobject_input_visitor_new(obj);
=20
     visit_type_SchemaInfoList(v, NULL, &schema, &error_abort);
     g_assert(schema);
=20
     qapi_free_SchemaInfoList(schema);
+    qobject_decref(obj);
+    visit_free(v);
 }
=20
 static void test_visitor_in_qmp_introspect(TestInputVisitorData *data,
                                            const void *unused)
 {
-    do_test_visitor_in_qmp_introspect(data, test_qmp_schema_json);
-    do_test_visitor_in_qmp_introspect(data, qmp_schema_json);
+    do_test_visitor_in_qmp_introspect(data, &test_qmp_schema_qlit);
+    do_test_visitor_in_qmp_introspect(data, &qmp_schema_qlit);
 }
=20
 int main(int argc, char **argv)
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 06ab699066..f58d62686a 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1327,18 +1327,27 @@ Example:
     #ifndef EXAMPLE_QMP_INTROSPECT_H
     #define EXAMPLE_QMP_INTROSPECT_H
=20
-    extern const char example_qmp_schema_json[];
+    extern const QLitObject qmp_schema_qlit;
=20
     #endif
     $ cat qapi-generated/example-qmp-introspect.c
 [Uninteresting stuff omitted...]
=20
-    const char example_qmp_schema_json[] =3D "["
-        "{\"arg-type\": \"0\", \"meta-type\": \"event\", \"name\": \"MY_=
EVENT\"}, "
-        "{\"arg-type\": \"1\", \"meta-type\": \"command\", \"name\": \"m=
y-command\", \"ret-type\": \"2\"}, "
-        "{\"members\": [], \"meta-type\": \"object\", \"name\": \"0\"}, =
"
-        "{\"members\": [{\"name\": \"arg1\", \"type\": \"[2]\"}], \"meta=
-type\": \"object\", \"name\": \"1\"}, "
-        "{\"members\": [{\"name\": \"integer\", \"type\": \"int\"}, {\"d=
efault\": null, \"name\": \"string\", \"type\": \"str\"}], \"meta-type\":=
 \"object\", \"name\": \"2\"}, "
-        "{\"element-type\": \"2\", \"meta-type\": \"array\", \"name\": \=
"[2]\"}, "
-        "{\"json-type\": \"int\", \"meta-type\": \"builtin\", \"name\": =
\"int\"}, "
-        "{\"json-type\": \"string\", \"meta-type\": \"builtin\", \"name\=
": \"str\"}]";
+    const QLitObject example_qmp_schema_qlit =3D QLIT_QLIST(((QLitObject=
[]) {
+        QLIT_QDICT(((QLitDictEntry[]) {
+            { "arg-type", QLIT_QSTR("0") },
+            { "meta-type", QLIT_QSTR("event") },
+            { "name", QLIT_QSTR("Event") },
+            { }
+        })),
+        QLIT_QDICT(((QLitDictEntry[]) {
+            { "members", QLIT_QLIST(((QLitObject[]) {
+                { }
+            })) },
+            { "meta-type", QLIT_QSTR("object") },
+            { "name", QLIT_QSTR("0") },
+            { }
+        })),
+        ...
+        { }
+    }));
--=20
2.16.0.rc1.1.gef27df75a1

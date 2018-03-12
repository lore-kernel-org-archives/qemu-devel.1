Received: from eggs.gnu.org ([2001:4830:134:3::10]:45108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJQ-0000ci-8O
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJN-0005s5-4Y
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33590 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJM-0005rL-Uz
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:41 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:35:55 -0500
Message-Id: <20180312183628.394722-5-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/36] qapi: generate a literal qobject for
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Replace the generated json string with a literal qobject. The later is
easier to deal with, at run time as well as compile time: adding #if
conditionals will be easier than in a json string.

The output of query-qmp-schema is not changed.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180305172951.2150-5-marcandre.lureau@redhat.com>
[eblake: fix python 3 failure]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/devel/qapi-code-gen.txt       | 29 ++++++++++-----
 scripts/qapi/introspect.py         | 76 +++++++++++++++++++++-----------=
------
 monitor.c                          |  2 +-
 tests/test-qobject-input-visitor.c | 11 ++++--
 4 files changed, 70 insertions(+), 48 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 25b7180a189..99d81230e26 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1319,18 +1319,27 @@ Example:
     #ifndef EXAMPLE_QMP_INTROSPECT_H
     #define EXAMPLE_QMP_INTROSPECT_H

-    extern const char example_qmp_schema_json[];
+    extern const QLitObject qmp_schema_qlit;

     #endif
     $ cat qapi-generated/example-qapi-introspect.c
 [Uninteresting stuff omitted...]

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
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index f66c397fb0e..1d46a6d6b6f 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -13,26 +13,36 @@ See the COPYING file in the top-level directory.
 from qapi.common import *


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
+        for key, value in sorted(obj.items()):
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


@@ -48,7 +58,7 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaMonolith=
icCVisitor):
             ' * QAPI/QMP schema introspection', __doc__)
         self._unmask =3D unmask
         self._schema =3D None
-        self._jsons =3D []
+        self._qlits =3D []
         self._used_types =3D []
         self._name_map =3D {}
         self._genc.add(mcgen('''
@@ -63,27 +73,27 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaMonoli=
thicCVisitor):

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
-        name =3D c_name(self._prefix, protect=3DFalse) + 'qmp_schema_jso=
n'
+        qlits.extend(self._qlits)
+        name =3D c_name(self._prefix, protect=3DFalse) + 'qmp_schema_qli=
t'
         self._genh.add(mcgen('''
-extern const char %(c_name)s[];
+#include "qapi/qmp/qlit.h"
+
+extern const QLitObject %(c_name)s;
 ''',
                              c_name=3Dc_name(name)))
-        lines =3D to_json(jsons).split('\n')
-        c_string =3D '\n    '.join([to_c_string(line) for line in lines]=
)
         self._genc.add(mcgen('''
-const char %(c_name)s[] =3D %(c_string)s;
+const QLitObject %(c_name)s =3D %(c_string)s;
 ''',
                              c_name=3Dc_name(name),
-                             c_string=3Dc_string))
+                             c_string=3Dto_qlit(qlits)))
         self._schema =3D None
-        self._jsons =3D []
+        self._qlits =3D []
         self._used_types =3D []
         self._name_map =3D {}

@@ -117,12 +127,12 @@ const char %(c_name)s[] =3D %(c_string)s;
             return '[' + self._use_type(typ.element_type) + ']'
         return self._name(typ.name)

-    def _gen_json(self, name, mtype, obj):
+    def _gen_qlit(self, name, mtype, obj):
         if mtype not in ('command', 'event', 'builtin', 'array'):
             name =3D self._name(name)
         obj['name'] =3D name
         obj['meta-type'] =3D mtype
-        self._jsons.append(obj)
+        self._qlits.append(obj)

     def _gen_member(self, member):
         ret =3D {'name': member.name, 'type': self._use_type(member.type=
)}
@@ -138,24 +148,24 @@ const char %(c_name)s[] =3D %(c_string)s;
         return {'case': variant.name, 'type': self._use_type(variant.typ=
e)}

     def visit_builtin_type(self, name, info, json_type):
-        self._gen_json(name, 'builtin', {'json-type': json_type})
+        self._gen_qlit(name, 'builtin', {'json-type': json_type})

     def visit_enum_type(self, name, info, values, prefix):
-        self._gen_json(name, 'enum', {'values': values})
+        self._gen_qlit(name, 'enum', {'values': values})

     def visit_array_type(self, name, info, element_type):
         element =3D self._use_type(element_type)
-        self._gen_json('[' + element + ']', 'array', {'element-type': el=
ement})
+        self._gen_qlit('[' + element + ']', 'array', {'element-type': el=
ement})

     def visit_object_type_flat(self, name, info, members, variants):
         obj =3D {'members': [self._gen_member(m) for m in members]}
         if variants:
             obj.update(self._gen_variants(variants.tag_member.name,
                                           variants.variants))
-        self._gen_json(name, 'object', obj)
+        self._gen_qlit(name, 'object', obj)

     def visit_alternate_type(self, name, info, variants):
-        self._gen_json(name, 'alternate',
+        self._gen_qlit(name, 'alternate',
                        {'members': [{'type': self._use_type(m.type)}
                                     for m in variants.variants]})

@@ -163,13 +173,13 @@ const char %(c_name)s[] =3D %(c_string)s;
                       gen, success_response, boxed):
         arg_type =3D arg_type or self._schema.the_empty_object_type
         ret_type =3D ret_type or self._schema.the_empty_object_type
-        self._gen_json(name, 'command',
+        self._gen_qlit(name, 'command',
                        {'arg-type': self._use_type(arg_type),
                         'ret-type': self._use_type(ret_type)})

     def visit_event(self, name, info, arg_type, boxed):
         arg_type =3D arg_type or self._schema.the_empty_object_type
-        self._gen_json(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)})
+        self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)})


 def gen_introspect(schema, output_dir, prefix, opt_unmask):
diff --git a/monitor.c b/monitor.c
index a4417f26cde..db166fab52f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -956,7 +956,7 @@ EventInfoList *qmp_query_events(Error **errp)
 static void qmp_query_qmp_schema(QDict *qdict, QObject **ret_data,
                                  Error **errp)
 {
-    *ret_data =3D qobject_from_json(qmp_schema_json, &error_abort);
+    *ret_data =3D qobject_from_qlit(&qmp_schema_qlit);
 }

 /*
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index 79b1a8cb175..55db6bdef13 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -1250,24 +1250,27 @@ static void test_visitor_in_fail_alternate(TestIn=
putVisitorData *data,
 }

 static void do_test_visitor_in_qmp_introspect(TestInputVisitorData *data=
,
-                                              const char *schema_json)
+                                              const QLitObject *qlit)
 {
     SchemaInfoList *schema =3D NULL;
+    QObject *obj =3D qobject_from_qlit(qlit);
     Visitor *v;

-    v =3D visitor_input_test_init_raw(data, schema_json);
+    v =3D qobject_input_visitor_new(obj);

     visit_type_SchemaInfoList(v, NULL, &schema, &error_abort);
     g_assert(schema);

     qapi_free_SchemaInfoList(schema);
+    qobject_decref(obj);
+    visit_free(v);
 }

 static void test_visitor_in_qmp_introspect(TestInputVisitorData *data,
                                            const void *unused)
 {
-    do_test_visitor_in_qmp_introspect(data, test_qmp_schema_json);
-    do_test_visitor_in_qmp_introspect(data, qmp_schema_json);
+    do_test_visitor_in_qmp_introspect(data, &test_qmp_schema_qlit);
+    do_test_visitor_in_qmp_introspect(data, &qmp_schema_qlit);
 }

 int main(int argc, char **argv)
--=20
2.14.3

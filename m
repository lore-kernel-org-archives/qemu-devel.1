Received: from eggs.gnu.org ([2001:4830:134:3::10]:37896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsio-0003Di-Sv
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsim-0007jp-Tu
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsim-0007jR-Kp
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:24 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC91F74E34
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:04:24 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:18 +0400
Message-Id: <20170118160332.13390-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/25] scripts: learn 'async' qapi commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kraxel@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Commands with the 'async' key will be registered as async type (see
related commit), and will allow a synchronous (in scope callback) or
asynchronous return (when ready, in idle etc) by keeping the given
QmpReturn and calling qmp_return function later.

Ex:
  { 'command': 'foo-async,
    'data': {'arg': 'str'},
    'returns': 'Foo',
    'async': true }

generates the following marshaller:

void qmp_marshal_foo_async(QDict *args, QmpReturn *qret)
{
    Error *err =3D NULL;
    Visitor *v;
    q_obj_foo_async_arg arg =3D {0};

    v =3D qmp_input_visitor_new(QOBJECT(args), true);
    visit_start_struct(v, NULL, NULL, 0, &err);
    if (err) {
        goto out;
    }
    visit_type_q_obj_foo_async_arg_members(v, &arg, &err);
    if (!err) {
        visit_check_struct(v, &err);
    }
    visit_end_struct(v, NULL);
    if (err) {
        goto out;
    }

    qmp_foo_async(arg.arg, qret);

out:
    if (err) {
        qmp_return_error(qret, err);
    }
    visit_free(v);
    v =3D qapi_dealloc_visitor_new();
    visit_start_struct(v, NULL, NULL, 0, NULL);
    visit_type_q_obj_foo_async_arg_members(v, &arg, NULL);
    visit_end_struct(v, NULL);
    visit_free(v);
}

and return helper:

void qmp_foo_async_return(QmpReturn *qret, Foo *ret_in)
{
    Error *err =3D NULL;
    QObject *ret_out =3D NULL;

    qmp_marshal_output_Foo(ret_in, &ret_out, &err);

    if (err) {
        qmp_return_error(qret, err);
    } else {
        qmp_return(qret, ret_out);
    }
}

The dispatched function may call the return helper within the calling
scope or delay the return. To return an error, it should call
qmp_return_error().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/introspect.json           |   2 +-
 scripts/qapi.py                |  14 +++--
 scripts/qapi-commands.py       | 139 +++++++++++++++++++++++++++++++++--=
------
 scripts/qapi-introspect.py     |   7 ++-
 tests/Makefile.include         |   1 +
 tests/qapi-schema/async.err    |   0
 tests/qapi-schema/async.exit   |   1 +
 tests/qapi-schema/async.json   |   6 ++
 tests/qapi-schema/async.out    |  10 +++
 tests/qapi-schema/test-qapi.py |   7 ++-
 10 files changed, 151 insertions(+), 36 deletions(-)
 create mode 100644 tests/qapi-schema/async.err
 create mode 100644 tests/qapi-schema/async.exit
 create mode 100644 tests/qapi-schema/async.json
 create mode 100644 tests/qapi-schema/async.out

diff --git a/qapi/introspect.json b/qapi/introspect.json
index f6adc439bb..fd6a9e98a4 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -262,7 +262,7 @@
 # Since: 2.5
 ##
 { 'struct': 'SchemaInfoCommand',
-  'data': { 'arg-type': 'str', 'ret-type': 'str' } }
+  'data': { 'arg-type': 'str', 'ret-type': 'str', 'async': 'bool' } }
=20
 ##
 # @SchemaInfoEvent:
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 53a44779d0..066b97a7fb 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -881,7 +881,8 @@ def check_exprs(exprs):
             add_struct(expr, info)
         elif 'command' in expr:
             check_keys(expr_elem, 'command', [],
-                       ['data', 'returns', 'gen', 'success-response', 'b=
oxed'])
+                       ['data', 'returns', 'gen', 'success-response', 'b=
oxed',
+                        'async'])
             add_name(expr['command'], info, 'command')
         elif 'event' in expr:
             check_keys(expr_elem, 'event', [], ['data', 'boxed'])
@@ -1064,7 +1065,7 @@ class QAPISchemaVisitor(object):
         pass
=20
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, async):
         pass
=20
     def visit_event(self, name, info, arg_type, boxed):
@@ -1406,7 +1407,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
=20
 class QAPISchemaCommand(QAPISchemaEntity):
     def __init__(self, name, info, arg_type, ret_type, gen, success_resp=
onse,
-                 boxed):
+                 boxed, async):
         QAPISchemaEntity.__init__(self, name, info)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
@@ -1417,6 +1418,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         self.gen =3D gen
         self.success_response =3D success_response
         self.boxed =3D boxed
+        self.async =3D async
=20
     def check(self, schema):
         if self._arg_type_name:
@@ -1440,7 +1442,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
     def visit(self, visitor):
         visitor.visit_command(self.name, self.info,
                               self.arg_type, self.ret_type,
-                              self.gen, self.success_response, self.boxe=
d)
+                              self.gen, self.success_response, self.boxe=
d,
+                              self.async)
=20
=20
 class QAPISchemaEvent(QAPISchemaEntity):
@@ -1645,6 +1648,7 @@ class QAPISchema(object):
         data =3D expr.get('data')
         rets =3D expr.get('returns')
         gen =3D expr.get('gen', True)
+        async =3D expr.get('async', False)
         success_response =3D expr.get('success-response', True)
         boxed =3D expr.get('boxed', False)
         if isinstance(data, OrderedDict):
@@ -1654,7 +1658,7 @@ class QAPISchema(object):
             assert len(rets) =3D=3D 1
             rets =3D self._make_array_type(rets[0], info)
         self._def_entity(QAPISchemaCommand(name, info, data, rets, gen,
-                                           success_response, boxed))
+                                           success_response, boxed, asyn=
c))
=20
     def _def_event(self, expr, info):
         name =3D expr['event']
diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 09e8467d90..8c6a281b7f 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -16,18 +16,30 @@ from qapi import *
 import re
=20
=20
-def gen_command_decl(name, arg_type, boxed, ret_type):
-    return mcgen('''
+def gen_command_decl(name, arg_type, boxed, ret_type, async):
+    if async:
+        extra =3D "QmpReturn *qret"
+    else:
+        extra =3D 'Error **errp'
+
+    if async:
+        return mcgen('''
+void qmp_%(name)s(%(params)s);
+void qmp_%(name)s_return(QmpReturn *qret%(c_type)s);
+''',
+                     c_type=3D(", " + ret_type.c_type() if ret_type else=
 ""),
+                     name=3Dc_name(name),
+                     params=3Dgen_params(arg_type, boxed, extra))
+    else:
+        return mcgen('''
 %(c_type)s qmp_%(c_name)s(%(params)s);
 ''',
-                 c_type=3D(ret_type and ret_type.c_type()) or 'void',
-                 c_name=3Dc_name(name),
-                 params=3Dgen_params(arg_type, boxed, 'Error **errp'))
+                     c_type=3D(ret_type and ret_type.c_type()) or 'void'=
,
+                     c_name=3Dc_name(name),
+                     params=3Dgen_params(arg_type, boxed, extra))
=20
=20
-def gen_call(name, arg_type, boxed, ret_type):
-    ret =3D ''
-
+def gen_argstr(arg_type, boxed):
     argstr =3D ''
     if boxed:
         assert arg_type and not arg_type.is_empty()
@@ -39,6 +51,13 @@ def gen_call(name, arg_type, boxed, ret_type):
                 argstr +=3D 'arg.has_%s, ' % c_name(memb.name)
             argstr +=3D 'arg.%s, ' % c_name(memb.name)
=20
+    return argstr
+
+
+def gen_call(name, arg_type, boxed, ret_type):
+    ret =3D ''
+
+    argstr =3D gen_argstr(arg_type, boxed)
     lhs =3D ''
     if ret_type:
         lhs =3D 'retval =3D '
@@ -60,6 +79,50 @@ def gen_call(name, arg_type, boxed, ret_type):
     return ret
=20
=20
+def gen_async_call(name, arg_type, boxed):
+    argstr =3D gen_argstr(arg_type, boxed)
+
+    push_indent()
+    ret =3D mcgen('''
+
+qmp_%(c_name)s(%(args)sqret);
+''',
+                c_name=3Dc_name(name), args=3Dargstr)
+
+    pop_indent()
+    return ret
+
+
+def gen_async_return(name, ret_type):
+    if ret_type:
+        return mcgen('''
+
+void qmp_%(c_name)s_return(QmpReturn *qret, %(ret_type)s ret_in)
+{
+    Error *err =3D NULL;
+    QObject *ret_out =3D NULL;
+
+    qmp_marshal_output_%(ret_c_name)s(ret_in, &ret_out, &err);
+
+    if (err) {
+        qmp_return_error(qret, err);
+    } else {
+        qmp_return(qret, ret_out);
+    }
+}
+''',
+                     c_name=3Dc_name(name),
+                     ret_type=3Dret_type.c_type(), ret_c_name=3Dret_type=
.c_name())
+    else:
+        return mcgen('''
+
+void qmp_%(c_name)s_return(QmpReturn *qret)
+{
+    qmp_return(qret, QOBJECT(qdict_new()));
+}
+''',
+                     c_name=3Dc_name(name))
+
 def gen_marshal_output(ret_type):
     return mcgen('''
=20
@@ -83,18 +146,22 @@ static void qmp_marshal_output_%(c_name)s(%(c_type)s=
 ret_in, QObject **ret_out,
                  c_type=3Dret_type.c_type(), c_name=3Dret_type.c_name())
=20
=20
-def gen_marshal_proto(name):
-    return 'void qmp_marshal_%s(QDict *args, QObject **ret, Error **errp=
)' % c_name(name)
+def gen_marshal_proto(name, async):
+    if async:
+        tmpl =3D 'void qmp_marshal_%s(QDict *args, QmpReturn *qret)'
+    else:
+        tmpl =3D 'void qmp_marshal_%s(QDict *args, QObject **ret, Error =
**errp)'
+    return tmpl % c_name(name)
=20
=20
-def gen_marshal_decl(name):
+def gen_marshal_decl(name, async):
     return mcgen('''
 %(proto)s;
 ''',
-                 proto=3Dgen_marshal_proto(name))
+                 proto=3Dgen_marshal_proto(name, async))
=20
=20
-def gen_marshal(name, arg_type, boxed, ret_type):
+def gen_marshal(name, arg_type, boxed, ret_type, async):
     have_args =3D arg_type and not arg_type.is_empty()
=20
     ret =3D mcgen('''
@@ -103,9 +170,9 @@ def gen_marshal(name, arg_type, boxed, ret_type):
 {
     Error *err =3D NULL;
 ''',
-                proto=3Dgen_marshal_proto(name))
+                proto=3Dgen_marshal_proto(name, async))
=20
-    if ret_type:
+    if ret_type and not async:
         ret +=3D mcgen('''
     %(c_type)s retval;
 ''',
@@ -152,12 +219,28 @@ def gen_marshal(name, arg_type, boxed, ret_type):
     }
 ''')
=20
-    ret +=3D gen_call(name, arg_type, boxed, ret_type)
+    if async:
+        ret +=3D gen_async_call(name, arg_type, boxed)
+    else:
+        ret +=3D gen_call(name, arg_type, boxed, ret_type)
=20
     ret +=3D mcgen('''
=20
 out:
+''')
+
+    if async:
+         ret +=3D mcgen('''
+    if (err) {
+        qmp_return_error(qret, err);
+    }
+''')
+    else:
+        ret +=3D mcgen('''
     error_propagate(errp, err);
+''')
+
+    ret +=3D mcgen('''
     visit_free(v);
 ''')
=20
@@ -192,15 +275,17 @@ out:
     return ret
=20
=20
-def gen_register_command(name, success_response):
+def gen_register_command(name, success_response, async):
     options =3D 'QCO_NO_OPTIONS'
     if not success_response:
         options =3D 'QCO_NO_SUCCESS_RESP'
-
+    func =3D 'qmp_register_command'
+    if async:
+        func =3D 'qmp_register_async_command'
     ret =3D mcgen('''
-    qmp_register_command("%(name)s", qmp_marshal_%(c_name)s, %(opts)s);
+    %(func)s("%(name)s", qmp_marshal_%(c_name)s, %(opts)s);
 ''',
-                name=3Dname, c_name=3Dc_name(name),
+                func=3Dfunc, name=3Dname, c_name=3Dc_name(name),
                 opts=3Doptions)
     return ret
=20
@@ -239,16 +324,19 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor=
):
         self._visited_ret_types =3D None
=20
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, async):
         if not gen:
             return
-        self.decl +=3D gen_command_decl(name, arg_type, boxed, ret_type)
+        self.decl +=3D gen_command_decl(name, arg_type, boxed,
+                                      ret_type, async)
         if ret_type and ret_type not in self._visited_ret_types:
             self._visited_ret_types.add(ret_type)
             self.defn +=3D gen_marshal_output(ret_type)
-        self.decl +=3D gen_marshal_decl(name)
-        self.defn +=3D gen_marshal(name, arg_type, boxed, ret_type)
-        self._regy +=3D gen_register_command(name, success_response)
+        if async:
+            self.defn +=3D gen_async_return(name, ret_type)
+        self.decl +=3D gen_marshal_decl(name, async)
+        self.defn +=3D gen_marshal(name, arg_type, boxed, ret_type, asyn=
c)
+        self._regy +=3D gen_register_command(name, success_response, asy=
nc)
=20
=20
 (input_file, output_dir, do_c, do_h, prefix, opts) =3D parse_command_lin=
e()
@@ -306,6 +394,7 @@ fdef.write(mcgen('''
 fdecl.write(mcgen('''
 #include "%(prefix)sqapi-types.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/dispatch.h"
 #include "qapi/error.h"
=20
 ''',
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 541644e350..f8a854dd0f 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -28,6 +28,8 @@ def to_json(obj, level=3D0):
                               to_json(obj[key], level + 1))
                 for key in sorted(obj.keys())]
         ret =3D '{' + ', '.join(elts) + '}'
+    elif isinstance(obj, bool):
+        ret =3D 'true' if obj else 'false'
     else:
         assert False                # not implemented
     if level =3D=3D 1:
@@ -154,12 +156,13 @@ const char %(c_name)s[] =3D %(c_string)s;
                                     for m in variants.variants]})
=20
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, async):
         arg_type =3D arg_type or self._schema.the_empty_object_type
         ret_type =3D ret_type or self._schema.the_empty_object_type
         self._gen_json(name, 'command',
                        {'arg-type': self._use_type(arg_type),
-                        'ret-type': self._use_type(ret_type)})
+                        'ret-type': self._use_type(ret_type),
+                        'async': async})
=20
     def visit_event(self, name, info, arg_type, boxed):
         arg_type =3D arg_type or self._schema.the_empty_object_type
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 152655d086..d9b575e657 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -343,6 +343,7 @@ qapi-schema +=3D args-member-unknown.json
 qapi-schema +=3D args-name-clash.json
 qapi-schema +=3D args-union.json
 qapi-schema +=3D args-unknown.json
+qapi-schema +=3D async.json
 qapi-schema +=3D bad-base.json
 qapi-schema +=3D bad-data.json
 qapi-schema +=3D bad-ident.json
diff --git a/tests/qapi-schema/async.err b/tests/qapi-schema/async.err
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/async.exit b/tests/qapi-schema/async.exit
new file mode 100644
index 0000000000..573541ac97
--- /dev/null
+++ b/tests/qapi-schema/async.exit
@@ -0,0 +1 @@
+0
diff --git a/tests/qapi-schema/async.json b/tests/qapi-schema/async.json
new file mode 100644
index 0000000000..2073349d39
--- /dev/null
+++ b/tests/qapi-schema/async.json
@@ -0,0 +1,6 @@
+##
+# @screendump-async:
+#
+# @filename: foo
+##
+{ 'command': 'screendump-async', 'data': {'filename': 'str'}, 'async': t=
rue }
diff --git a/tests/qapi-schema/async.out b/tests/qapi-schema/async.out
new file mode 100644
index 0000000000..bcb5a400d7
--- /dev/null
+++ b/tests/qapi-schema/async.out
@@ -0,0 +1,10 @@
+enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+    prefix QTYPE
+object q_empty
+object q_obj_screendump-async-arg
+    member filename: str optional=3DFalse
+command screendump-async q_obj_screendump-async-arg -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse async=3DTrue
+doc symbol=3Dscreendump-async expr=3D('command', 'screendump-async')
+    arg=3Dfilename
+foo
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index b4cde4ff4f..608c304995 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -36,11 +36,12 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         self._print_variants(variants)
=20
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, async):
         print 'command %s %s -> %s' % \
             (name, arg_type and arg_type.name, ret_type and ret_type.nam=
e)
-        print '   gen=3D%s success_response=3D%s boxed=3D%s' % \
-            (gen, success_response, boxed)
+        print '   gen=3D%s success_response=3D%s boxed=3D%s%s' % \
+            (gen, success_response, boxed,
+             ' async=3DTrue' if async else '')
=20
     def visit_event(self, name, info, arg_type, boxed):
         print 'event %s %s' % (name, arg_type and arg_type.name)
--=20
2.11.0.295.gd7dffce1c

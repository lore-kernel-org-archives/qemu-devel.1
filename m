Received: from eggs.gnu.org ([2001:4830:134:3::10]:55306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tlh-0006Da-Ps
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tlf-0003LY-Ju
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36674 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tlf-0003L3-Dt
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:39 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:09:08 +0200
Message-Id: <20180326150916.9602-31-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 30/38] scripts: learn 'async' qapi commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
 scripts/qapi/commands.py                | 149 ++++++++++++++++++++----
 scripts/qapi/common.py                  |  12 +-
 scripts/qapi/doc.py                     |   2 +-
 scripts/qapi/introspect.py              |   2 +-
 tests/test-qmp-cmds.c                   |  60 ++++++++++
 tests/qapi-schema/qapi-schema-test.json |   5 +
 tests/qapi-schema/qapi-schema-test.out  |   8 ++
 tests/qapi-schema/test-qapi.py          |   7 +-
 8 files changed, 210 insertions(+), 35 deletions(-)
 mode change 100644 =3D> 100755 scripts/qapi/doc.py

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 0c5da3a54d..a292164169 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -16,18 +16,36 @@ See the COPYING file in the top-level directory.
 from qapi.common import *
=20
=20
-def gen_command_decl(name, arg_type, boxed, ret_type):
-    return mcgen('''
-%(c_type)s qmp_%(c_name)s(%(params)s);
+def gen_command_decl(name, arg_type, boxed, ret_type, success_response, =
async):
+    if async:
+        extra =3D "QmpReturn *qret"
+    else:
+        extra =3D 'Error **errp'
+
+    if async:
+        ret =3D mcgen('''
+void qmp_%(name)s(%(params)s);
 ''',
-                 c_type=3D(ret_type and ret_type.c_type()) or 'void',
-                 c_name=3Dc_name(name),
-                 params=3Dbuild_params(arg_type, boxed, 'Error **errp'))
+                     name=3Dc_name(name),
+                     params=3Dbuild_params(arg_type, boxed, extra))
+        if success_response:
+            ret +=3D mcgen('''
+void qmp_%(name)s_return(QmpReturn *qret%(c_type)s);
+''',
+                        c_type=3D(", " + ret_type.c_type() if ret_type e=
lse ""),
+                        name=3Dc_name(name))
=20
+        return ret
+    else:
+        return mcgen('''
+%(c_type)s qmp_%(c_name)s(%(params)s);
+''',
+                     c_type=3D(ret_type and ret_type.c_type()) or 'void'=
,
+                     c_name=3Dc_name(name),
+                     params=3Dbuild_params(arg_type, boxed, extra))
=20
-def gen_call(name, arg_type, boxed, ret_type):
-    ret =3D ''
=20
+def gen_argstr(arg_type, boxed):
     argstr =3D ''
     if boxed:
         assert arg_type and not arg_type.is_empty()
@@ -39,6 +57,13 @@ def gen_call(name, arg_type, boxed, ret_type):
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
@@ -60,6 +85,50 @@ def gen_call(name, arg_type, boxed, ret_type):
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
@@ -83,19 +152,22 @@ static void qmp_marshal_output_%(c_name)s(%(c_type)s=
 ret_in, QObject **ret_out,
                  c_type=3Dret_type.c_type(), c_name=3Dret_type.c_name())
=20
=20
-def build_marshal_proto(name):
-    return ('void qmp_marshal_%s(QDict *args, QObject **ret, Error **err=
p)'
-            % c_name(name))
+def build_marshal_proto(name, async):
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
-                 proto=3Dbuild_marshal_proto(name))
+                 proto=3Dbuild_marshal_proto(name, async))
=20
=20
-def gen_marshal(name, arg_type, boxed, ret_type):
+def gen_marshal(name, arg_type, boxed, ret_type, async):
     have_args =3D arg_type and not arg_type.is_empty()
=20
     ret =3D mcgen('''
@@ -104,9 +176,9 @@ def gen_marshal(name, arg_type, boxed, ret_type):
 {
     Error *err =3D NULL;
 ''',
-                proto=3Dbuild_marshal_proto(name))
+                proto=3Dbuild_marshal_proto(name, async))
=20
-    if ret_type:
+    if ret_type and not async:
         ret +=3D mcgen('''
     %(c_type)s retval;
 ''',
@@ -153,12 +225,28 @@ def gen_marshal(name, arg_type, boxed, ret_type):
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
@@ -193,24 +281,31 @@ out:
     return ret
=20
=20
-def gen_register_command(name, success_response, allow_oob):
+def gen_register_command(name, success_response, allow_oob, async):
     options =3D []
=20
     if not success_response:
         options +=3D ['QCO_NO_SUCCESS_RESP']
     if allow_oob:
         options +=3D ['QCO_ALLOW_OOB']
+    if async:
+        options +=3D ['QCO_ASYNC']
=20
     if not options:
         options =3D ['QCO_NO_OPTIONS']
=20
     options =3D " | ".join(options)
=20
+    if async:
+        regfn =3D 'qmp_register_async_command'
+    else:
+        regfn =3D 'qmp_register_command'
+
     ret =3D mcgen('''
-    qmp_register_command(cmds, "%(name)s",
+    %(regfn)s(cmds, "%(name)s",
                          qmp_marshal_%(c_name)s, %(opts)s);
 ''',
-                name=3Dname, c_name=3Dc_name(name),
+                regfn=3Dregfn, name=3Dname, c_name=3Dc_name(name),
                 opts=3Doptions)
     return ret
=20
@@ -276,16 +371,20 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *c=
mds);
         genc.add(gen_registry(self._regy, self._prefix))
=20
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed, allow_oob):
+                      gen, success_response, boxed, allow_oob, async):
         if not gen:
             return
-        self._genh.add(gen_command_decl(name, arg_type, boxed, ret_type)=
)
+        self._genh.add(gen_command_decl(name, arg_type, boxed, ret_type,
+                                        success_response, async))
         if ret_type and ret_type not in self._visited_ret_types[self._ge=
nc]:
             self._visited_ret_types[self._genc].add(ret_type)
             self._genc.add(gen_marshal_output(ret_type))
-        self._genh.add(gen_marshal_decl(name))
-        self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
-        self._regy +=3D gen_register_command(name, success_response, all=
ow_oob)
+        if async and success_response:
+            self._genc.add(gen_async_return(name, ret_type))
+        self._genh.add(gen_marshal_decl(name, async))
+        self._genc.add(gen_marshal(name, arg_type, boxed, ret_type, asyn=
c))
+        self._regy +=3D gen_register_command(name, success_response,
+                                           allow_oob, async)
=20
=20
 def gen_commands(schema, output_dir, prefix):
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 2c05e3c284..109562ccb4 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -922,7 +922,7 @@ def check_exprs(exprs):
             meta =3D 'command'
             check_keys(expr_elem, 'command', [],
                        ['data', 'returns', 'gen', 'success-response',
-                        'boxed', 'allow-oob'])
+                        'boxed', 'allow-oob', 'async'])
         elif 'event' in expr:
             meta =3D 'event'
             check_keys(expr_elem, 'event', [], ['data', 'boxed'])
@@ -1045,7 +1045,7 @@ class QAPISchemaVisitor(object):
         pass
=20
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed, allow_oob):
+                      gen, success_response, boxed, allow_oob, async):
         pass
=20
     def visit_event(self, name, info, arg_type, boxed):
@@ -1422,7 +1422,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
=20
 class QAPISchemaCommand(QAPISchemaEntity):
     def __init__(self, name, info, doc, arg_type, ret_type,
-                 gen, success_response, boxed, allow_oob):
+                 gen, success_response, boxed, allow_oob, async):
         QAPISchemaEntity.__init__(self, name, info, doc)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
@@ -1434,6 +1434,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         self.success_response =3D success_response
         self.boxed =3D boxed
         self.allow_oob =3D allow_oob
+        self.async =3D async
=20
     def check(self, schema):
         if self._arg_type_name:
@@ -1458,7 +1459,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         visitor.visit_command(self.name, self.info,
                               self.arg_type, self.ret_type,
                               self.gen, self.success_response,
-                              self.boxed, self.allow_oob)
+                              self.boxed, self.allow_oob, self.async)
=20
=20
 class QAPISchemaEvent(QAPISchemaEntity):
@@ -1678,6 +1679,7 @@ class QAPISchema(object):
         success_response =3D expr.get('success-response', True)
         boxed =3D expr.get('boxed', False)
         allow_oob =3D expr.get('allow-oob', False)
+        async =3D expr.get('async', False)
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
                 name, info, doc, 'arg', self._make_members(data, info))
@@ -1686,7 +1688,7 @@ class QAPISchema(object):
             rets =3D self._make_array_type(rets[0], info)
         self._def_entity(QAPISchemaCommand(name, info, doc, data, rets,
                                            gen, success_response,
-                                           boxed, allow_oob))
+                                           boxed, allow_oob, async))
=20
     def _def_event(self, expr, info, doc):
         name =3D expr['event']
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
old mode 100644
new mode 100755
index 9b312b2c51..33b26e2bef
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -227,7 +227,7 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaV=
isitor):
                                body=3Dtexi_entity(doc, 'Members')))
=20
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed, allow_oob):
+                      gen, success_response, boxed, allow_oob, async):
         doc =3D self.cur_doc
         if boxed:
             body =3D texi_body(doc)
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index f9e67e8227..5de60d0357 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -172,7 +172,7 @@ const QLitObject %(c_name)s =3D %(c_string)s;
                                     for m in variants.variants]})
=20
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed, allow_oob):
+                      gen, success_response, boxed, allow_oob, async):
         arg_type =3D arg_type or self._schema.the_empty_object_type
         ret_type =3D ret_type or self._schema.the_empty_object_type
         self._gen_qlit(name, 'command',
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index eeaac03d50..f1e6cde990 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -20,6 +20,28 @@ void qmp_cmd_success_response(Error **errp)
 {
 }
=20
+static gboolean cmd_async_idle(gpointer user_data)
+{
+    QmpReturn *qret =3D user_data;
+
+    qmp_cmd_async_return(qret, g_new0(Empty2, 1));
+
+    return G_SOURCE_REMOVE;
+}
+
+void qmp_cmd_async(const char *filename, QmpReturn *qret)
+{
+    g_idle_add(cmd_async_idle, qret);
+}
+
+void qmp_cmd_success_response_async(const char *filename, QmpReturn *qre=
t)
+{
+    Error *err =3D NULL;
+
+    error_setg(&err, "no response, but error ok");
+    qmp_return_error(qret, err);
+}
+
 Empty2 *qmp_user_def_cmd0(Error **errp)
 {
     return g_new0(Empty2, 1);
@@ -345,6 +367,43 @@ static void test_qmp_return_orderly(void)
     QDECREF(dict);
 }
=20
+typedef struct QmpReturnAsync {
+    QmpSession session;
+    GMainLoop *loop;
+} QmpReturnAsync;
+
+static void dispatch_return_async(QmpSession *session, QDict *resp)
+{
+    QmpReturnAsync *a =3D container_of(session, QmpReturnAsync, session)=
;
+
+    g_main_loop_quit(a->loop);
+    g_main_loop_unref(a->loop);
+    a->loop =3D NULL;
+}
+
+static void test_qmp_return_async(void)
+{
+    QmpReturnAsync a =3D { 0, };
+    QDict *args =3D qdict_new();
+    QDict *req =3D qdict_new();
+
+    a.loop =3D g_main_loop_new(NULL, TRUE);
+    qmp_session_init(&a.session, &qmp_commands,
+                    qmp_dispatch, dispatch_return_async);
+
+    qdict_put_str(args, "filename", "test-filename");
+    qdict_put_str(req, "execute", "cmd-async");
+    qdict_put(req, "arguments", args);
+    qmp_dispatch(&a.session, req);
+    g_assert(a.loop);
+
+    g_main_loop_run(a.loop);
+    g_assert(!a.loop);
+
+    qmp_session_destroy(&a.session);
+    QDECREF(req);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -358,6 +417,7 @@ int main(int argc, char **argv)
     g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
     g_test_add_func("/qmp/dealloc_partial", test_dealloc_partial);
     g_test_add_func("/qmp/return_orderly", test_qmp_return_orderly);
+    g_test_add_func("/qmp/return_async", test_qmp_return_async);
=20
     test_qmp_init_marshal(&qmp_commands);
     g_test_run();
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 96ff3a8e47..383369cd58 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -134,6 +134,11 @@
=20
 { 'command': 'cmd-success-response', 'data': {}, 'success-response': fal=
se }
=20
+{ 'command': 'cmd-async', 'data': {'filename': 'str'},
+  'returns': 'Empty2', 'async': true }
+{ 'command': 'cmd-success-response-async', 'data': {'filename': 'str'},
+  'async': true, 'success-response': false}
+
 # Returning a non-dictionary requires a name from the whitelist
 { 'command': 'guest-get-time', 'data': {'a': 'int', '*b': 'int' },
   'returns': 'int' }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index cd3642be34..aa18f2c811 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -155,6 +155,14 @@ command user_def_cmd2 q_obj_user_def_cmd2-arg -> Use=
rDefTwo
    gen=3DTrue success_response=3DTrue boxed=3DFalse
 command cmd-success-response None -> None
    gen=3DTrue success_response=3DFalse boxed=3DFalse
+object q_obj_cmd-async-arg
+    member filename: str optional=3DFalse
+command cmd-async q_obj_cmd-async-arg -> Empty2
+   gen=3DTrue success_response=3DTrue boxed=3DFalse async=3DTrue
+object q_obj_cmd-success-response-async-arg
+    member filename: str optional=3DFalse
+command cmd-success-response-async q_obj_cmd-success-response-async-arg =
-> None
+   gen=3DTrue success_response=3DFalse boxed=3DFalse async=3DTrue
 object q_obj_guest-get-time-arg
     member a: int optional=3DFalse
     member b: int optional=3DTrue
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index 10e68b01d9..491bdc73dd 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -42,11 +42,12 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         self._print_variants(variants)
=20
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed, allow_oob):
+                      gen, success_response, boxed, allow_oob, async):
         print('command %s %s -> %s' % \
               (name, arg_type and arg_type.name, ret_type and ret_type.n=
ame))
-        print('   gen=3D%s success_response=3D%s boxed=3D%s' % \
-              (gen, success_response, boxed))
+        print('   gen=3D%s success_response=3D%s boxed=3D%s%s' % \
+              (gen, success_response, boxed,
+               ' async=3DTrue' if async else ''))
=20
     def visit_event(self, name, info, arg_type, boxed):
         print('event %s %s' % (name, arg_type and arg_type.name))
--=20
2.17.0.rc1.1.g4c4f2b46a3

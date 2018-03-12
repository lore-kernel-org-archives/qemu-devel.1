Received: from eggs.gnu.org ([2001:4830:134:3::10]:45478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJd-0000u6-Ql
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJb-000640-TH
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJb-00063U-MX
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:55 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:19 -0500
Message-Id: <20180312183628.394722-29-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 28/36] qapi: introduce new cmd option "allow-oob"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

From: Peter Xu <peterx@redhat.com>

Here "oob" stands for "Out-Of-Band".  When "allow-oob" is set, it means
the command allows out-of-band execution.

The "oob" idea is proposed by Markus Armbruster in following thread:

  https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02057.html

This new "allow-oob" boolean will be exposed by "query-qmp-schema" as
well for command entries, so that QMP clients can know which commands
can be used in out-of-band calls. For example the command "migrate"
originally looks like:

  {"name": "migrate", "ret-type": "17", "meta-type": "command",
   "arg-type": "86"}

And it'll be changed into:

  {"name": "migrate", "ret-type": "17", "allow-oob": false,
   "meta-type": "command", "arg-type": "86"}

This patch only provides the QMP interface level changes.  It does not
contain the real out-of-band execution implementation yet.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180309090006.10018-18-peterx@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: rebase on introspection done by qlit]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/introspect.json           |  6 +++++-
 scripts/qapi/commands.py       | 18 +++++++++++++-----
 scripts/qapi/common.py         | 15 ++++++++++-----
 scripts/qapi/doc.py            |  2 +-
 scripts/qapi/introspect.py     |  7 +++++--
 include/qapi/qmp/dispatch.h    |  5 +++--
 tests/qapi-schema/test-qapi.py |  2 +-
 7 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index 5b3e6e9d78b..c7f67b7d78b 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -259,12 +259,16 @@
 #
 # @ret-type: the name of the command's result type.
 #
+# @allow-oob: whether the command allows out-of-band execution.
+#             (Since: 2.12)
+#
 # TODO: @success-response (currently irrelevant, because it's QGA, not QMP)
 #
 # Since: 2.5
 ##
 { 'struct': 'SchemaInfoCommand',
-  'data': { 'arg-type': 'str', 'ret-type': 'str' } }
+  'data': { 'arg-type': 'str', 'ret-type': 'str',
+            'allow-oob': 'bool' } }

 ##
 # @SchemaInfoEvent:
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 21a7e0dbe61..0c5da3a54d6 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -193,10 +193,18 @@ out:
     return ret


-def gen_register_command(name, success_response):
-    options = 'QCO_NO_OPTIONS'
+def gen_register_command(name, success_response, allow_oob):
+    options = []
+
     if not success_response:
-        options = 'QCO_NO_SUCCESS_RESP'
+        options += ['QCO_NO_SUCCESS_RESP']
+    if allow_oob:
+        options += ['QCO_ALLOW_OOB']
+
+    if not options:
+        options = ['QCO_NO_OPTIONS']
+
+    options = " | ".join(options)

     ret = mcgen('''
     qmp_register_command(cmds, "%(name)s",
@@ -268,7 +276,7 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
         genc.add(gen_registry(self._regy, self._prefix))

     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, allow_oob):
         if not gen:
             return
         self._genh.add(gen_command_decl(name, arg_type, boxed, ret_type))
@@ -277,7 +285,7 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
             self._genc.add(gen_marshal_output(ret_type))
         self._genh.add(gen_marshal_decl(name))
         self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
-        self._regy += gen_register_command(name, success_response)
+        self._regy += gen_register_command(name, success_response, allow_oob)


 def gen_commands(schema, output_dir, prefix):
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 97e9060b674..2c05e3c2845 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -921,7 +921,8 @@ def check_exprs(exprs):
         elif 'command' in expr:
             meta = 'command'
             check_keys(expr_elem, 'command', [],
-                       ['data', 'returns', 'gen', 'success-response', 'boxed'])
+                       ['data', 'returns', 'gen', 'success-response',
+                        'boxed', 'allow-oob'])
         elif 'event' in expr:
             meta = 'event'
             check_keys(expr_elem, 'event', [], ['data', 'boxed'])
@@ -1044,7 +1045,7 @@ class QAPISchemaVisitor(object):
         pass

     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, allow_oob):
         pass

     def visit_event(self, name, info, arg_type, boxed):
@@ -1421,7 +1422,7 @@ class QAPISchemaAlternateType(QAPISchemaType):

 class QAPISchemaCommand(QAPISchemaEntity):
     def __init__(self, name, info, doc, arg_type, ret_type,
-                 gen, success_response, boxed):
+                 gen, success_response, boxed, allow_oob):
         QAPISchemaEntity.__init__(self, name, info, doc)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
@@ -1432,6 +1433,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         self.gen = gen
         self.success_response = success_response
         self.boxed = boxed
+        self.allow_oob = allow_oob

     def check(self, schema):
         if self._arg_type_name:
@@ -1455,7 +1457,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
     def visit(self, visitor):
         visitor.visit_command(self.name, self.info,
                               self.arg_type, self.ret_type,
-                              self.gen, self.success_response, self.boxed)
+                              self.gen, self.success_response,
+                              self.boxed, self.allow_oob)


 class QAPISchemaEvent(QAPISchemaEntity):
@@ -1674,6 +1677,7 @@ class QAPISchema(object):
         gen = expr.get('gen', True)
         success_response = expr.get('success-response', True)
         boxed = expr.get('boxed', False)
+        allow_oob = expr.get('allow-oob', False)
         if isinstance(data, OrderedDict):
             data = self._make_implicit_object_type(
                 name, info, doc, 'arg', self._make_members(data, info))
@@ -1681,7 +1685,8 @@ class QAPISchema(object):
             assert len(rets) == 1
             rets = self._make_array_type(rets[0], info)
         self._def_entity(QAPISchemaCommand(name, info, doc, data, rets,
-                                           gen, success_response, boxed))
+                                           gen, success_response,
+                                           boxed, allow_oob))

     def _def_event(self, expr, info, doc):
         name = expr['event']
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 79d11bbe9b5..9b312b2c51b 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -227,7 +227,7 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaVisitor):
                                body=texi_entity(doc, 'Members')))

     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, allow_oob):
         doc = self.cur_doc
         if boxed:
             body = texi_body(doc)
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 1d46a6d6b6f..f9e67e8227b 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -41,6 +41,8 @@ def to_qlit(obj, level=0, suppress_first_indent=False):
         ret += 'QLIT_QDICT(((QLitDictEntry[]) {\n'
         ret += ',\n'.join(elts) + '\n'
         ret += indent(level) + '}))'
+    elif isinstance(obj, bool):
+        ret += 'QLIT_QBOOL(%s)' % ('true' if obj else 'false')
     else:
         assert False                # not implemented
     return ret
@@ -170,12 +172,13 @@ const QLitObject %(c_name)s = %(c_string)s;
                                     for m in variants.variants]})

     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, allow_oob):
         arg_type = arg_type or self._schema.the_empty_object_type
         ret_type = ret_type or self._schema.the_empty_object_type
         self._gen_qlit(name, 'command',
                        {'arg-type': self._use_type(arg_type),
-                        'ret-type': self._use_type(ret_type)})
+                        'ret-type': self._use_type(ret_type),
+                        'allow-oob': allow_oob})

     def visit_event(self, name, info, arg_type, boxed):
         arg_type = arg_type or self._schema.the_empty_object_type
diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 1e694b5ecf9..26eb13ff417 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -20,8 +20,9 @@ typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);

 typedef enum QmpCommandOptions
 {
-    QCO_NO_OPTIONS = 0x0,
-    QCO_NO_SUCCESS_RESP = 0x1,
+    QCO_NO_OPTIONS            =  0x0,
+    QCO_NO_SUCCESS_RESP       =  (1U << 0),
+    QCO_ALLOW_OOB             =  (1U << 1),
 } QmpCommandOptions;

 typedef struct QmpCommand
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 67e417e2980..10e68b01d98 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -42,7 +42,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         self._print_variants(variants)

     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, allow_oob):
         print('command %s %s -> %s' % \
               (name, arg_type and arg_type.name, ret_type and ret_type.name))
         print('   gen=%s success_response=%s boxed=%s' % \
-- 
2.14.3

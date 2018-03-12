Received: from eggs.gnu.org ([2001:4830:134:3::10]:48260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1evNFq-0007Gy-Sz
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1evNFo-0005NZ-Mf
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51774 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1evNFo-0005MW-Gh
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:40 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 12 Mar 2018 14:11:11 +0100
Message-Id: <1520860275-101576-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v4 5/9] qapi: introduce new cmd option
 "allowed-in-preconfig"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

New option will be used to allow commands, which are prepared/need
to run run in preconfig state. Other commands that should be able
to run in preconfig state, should be ammeded to not expect machine
in initialized state or deal with it.

For compatibility reasons, commands, that don't use new flag
'allowed-in-preconfig' explicitly, are not permited to run in
preconfig state but allowed in all other states like they used
to be.

Within this patch allow following commands in preconfig state:
   qmp_capabilities
   query-qmp-schema
   query-commands
   query-status
   cont
to allow qmp connection, basic introspection and moving to the next
state.

PS:
set-numa-node and query-hotpluggable-cpus will be enabled later in
a separate patch.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v4:
  * replaces complex "universal" approach
     "[PATCH v3 5/9] QAPI: allow to specify valid runstates  per command"
    with a simpler new command flag "allowed-in-preconfig".
    (Eric Blake <eblake@redhat.com>)
---
 include/qapi/qmp/dispatch.h    |  3 ++-
 docs/devel/qapi-code-gen.txt   | 10 +++++++++-
 monitor.c                      |  5 +++--
 qapi/introspect.json           |  6 +++++-
 qapi/misc.json                 |  7 ++++---
 qapi/qmp-dispatch.c            |  8 ++++++++
 qapi/run-state.json            |  3 ++-
 scripts/qapi/commands.py       | 19 ++++++++++++++-----
 scripts/qapi/common.py         | 15 ++++++++++-----
 scripts/qapi/doc.py            |  2 +-
 scripts/qapi/introspect.py     | 10 ++++++++--
 tests/qapi-schema/test-qapi.py |  2 +-
 12 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 1e694b5..2d02b75 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -21,7 +21,8 @@ typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
 typedef enum QmpCommandOptions
 {
     QCO_NO_OPTIONS = 0x0,
-    QCO_NO_SUCCESS_RESP = 0x1,
+    QCO_NO_SUCCESS_RESP = 1U << 0,
+    QCO_ALLOWED_IN_PRECONFIG =  1U << 1,
 } QmpCommandOptions;
 
 typedef struct QmpCommand
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 25b7180..170f15f 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -556,7 +556,8 @@ following example objects:
 
 Usage: { 'command': STRING, '*data': COMPLEX-TYPE-NAME-OR-DICT,
          '*returns': TYPE-NAME, '*boxed': true,
-         '*gen': false, '*success-response': false }
+         '*gen': false, '*success-response': false,
+         '*allowed-in-preconfig': true }
 
 Commands are defined by using a dictionary containing several members,
 where three members are most common.  The 'command' member is a
@@ -636,6 +637,13 @@ possible, the command expression should include the optional key
 'success-response' with boolean value false.  So far, only QGA makes
 use of this member.
 
+A command may use optional 'allowed-in-preconfig' key to permit
+its execution at early runtime configuration stage (preconfig runstate).
+If not specified then a command defaults to 'allowed-in-preconfig: false'.
+
+An example of declaring preconfig enabled command:
+ { 'command': 'qmp_capabilities',
+   'allowed-in-preconfig': true }
 
 === Events ===
 
diff --git a/monitor.c b/monitor.c
index ea0ca57..0adf220 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1016,7 +1016,7 @@ void monitor_init_qmp_commands(void)
 
     qmp_register_command(&qmp_commands, "query-qmp-schema",
                          qmp_query_qmp_schema,
-                         QCO_NO_OPTIONS);
+                         QCO_ALLOWED_IN_PRECONFIG);
     qmp_register_command(&qmp_commands, "device_add", qmp_device_add,
                          QCO_NO_OPTIONS);
     qmp_register_command(&qmp_commands, "netdev_add", qmp_netdev_add,
@@ -1026,7 +1026,8 @@ void monitor_init_qmp_commands(void)
 
     QTAILQ_INIT(&qmp_cap_negotiation_commands);
     qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilities",
-                         qmp_marshal_qmp_capabilities, QCO_NO_OPTIONS);
+                         qmp_marshal_qmp_capabilities,
+                         QCO_ALLOWED_IN_PRECONFIG);
 }
 
 void qmp_qmp_capabilities(Error **errp)
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 5b3e6e9..05faded 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -259,12 +259,16 @@
 #
 # @ret-type: the name of the command's result type.
 #
+# @allowed-in-preconfig: command could be executed  in preconfig runstate,
+#                        default: 'false' (Since 2.12)
+#
 # TODO: @success-response (currently irrelevant, because it's QGA, not QMP)
 #
 # Since: 2.5
 ##
 { 'struct': 'SchemaInfoCommand',
-  'data': { 'arg-type': 'str', 'ret-type': 'str' } }
+  'data': { 'arg-type': 'str', 'ret-type': 'str',
+            'allowed-in-preconfig': 'bool' } }
 
 ##
 # @SchemaInfoEvent:
diff --git a/qapi/misc.json b/qapi/misc.json
index bcd5d10..1f48d35 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -24,7 +24,7 @@
 # Since: 0.13
 #
 ##
-{ 'command': 'qmp_capabilities' }
+{ 'command': 'qmp_capabilities', 'allowed-in-preconfig': true }
 
 ##
 # @VersionTriple:
@@ -127,7 +127,8 @@
 # Note: This example has been shortened as the real response is too long.
 #
 ##
-{ 'command': 'query-commands', 'returns': ['CommandInfo'] }
+{ 'command': 'query-commands', 'returns': ['CommandInfo'],
+  'allowed-in-preconfig': true }
 
 ##
 # @LostTickPolicy:
@@ -1180,7 +1181,7 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'cont' }
+{ 'command': 'cont', 'allowed-in-preconfig': true }
 
 ##
 # @system_wakeup:
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index e31ac4b..81dbd19 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -17,6 +17,7 @@
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
+#include "sysemu/sysemu.h"
 
 static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
 {
@@ -92,6 +93,13 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
         return NULL;
     }
 
+    if (runstate_check(RUN_STATE_PRECONFIG) &&
+        !(cmd->options & QCO_ALLOWED_IN_PRECONFIG)) {
+        error_setg(errp, "The command '%s' isn't permitted in '%s' state",
+                   cmd->name, RunState_str(RUN_STATE_PRECONFIG));
+        return NULL;
+    }
+
     if (!qdict_haskey(dict, "arguments")) {
         args = qdict_new();
     } else {
diff --git a/qapi/run-state.json b/qapi/run-state.json
index ce846a5..174a2a3 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -94,7 +94,8 @@
 #                  "status": "running" } }
 #
 ##
-{ 'command': 'query-status', 'returns': 'StatusInfo' }
+{ 'command': 'query-status', 'returns': 'StatusInfo',
+  'allowed-in-preconfig': true }
 
 ##
 # @SHUTDOWN:
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 21a7e0d..bd8dc5e 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -193,10 +193,18 @@ out:
     return ret
 
 
-def gen_register_command(name, success_response):
-    options = 'QCO_NO_OPTIONS'
+def gen_register_command(name, success_response, allowed_in_preconfig):
+    options = []
+
     if not success_response:
-        options = 'QCO_NO_SUCCESS_RESP'
+        options += ['QCO_NO_SUCCESS_RESP']
+    if allowed_in_preconfig:
+        options += ['QCO_ALLOWED_IN_PRECONFIG']
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
+                      gen, success_response, boxed, allowed_in_preconfig):
         if not gen:
             return
         self._genh.add(gen_command_decl(name, arg_type, boxed, ret_type))
@@ -277,7 +285,8 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
             self._genc.add(gen_marshal_output(ret_type))
         self._genh.add(gen_marshal_decl(name))
         self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
-        self._regy += gen_register_command(name, success_response)
+        self._regy += gen_register_command(name, success_response,
+                                           allowed_in_preconfig)
 
 
 def gen_commands(schema, output_dir, prefix):
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 97e9060..e92f514 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -921,7 +921,8 @@ def check_exprs(exprs):
         elif 'command' in expr:
             meta = 'command'
             check_keys(expr_elem, 'command', [],
-                       ['data', 'returns', 'gen', 'success-response', 'boxed'])
+                       ['data', 'returns', 'gen', 'success-response',
+                        'boxed', 'allowed-in-preconfig'])
         elif 'event' in expr:
             meta = 'event'
             check_keys(expr_elem, 'event', [], ['data', 'boxed'])
@@ -1044,7 +1045,7 @@ class QAPISchemaVisitor(object):
         pass
 
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, allowed_in_preconfig):
         pass
 
     def visit_event(self, name, info, arg_type, boxed):
@@ -1421,7 +1422,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
 
 class QAPISchemaCommand(QAPISchemaEntity):
     def __init__(self, name, info, doc, arg_type, ret_type,
-                 gen, success_response, boxed):
+                 gen, success_response, boxed, allowed_in_preconfig):
         QAPISchemaEntity.__init__(self, name, info, doc)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
@@ -1432,6 +1433,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         self.gen = gen
         self.success_response = success_response
         self.boxed = boxed
+        self.allowed_in_preconfig = allowed_in_preconfig
 
     def check(self, schema):
         if self._arg_type_name:
@@ -1455,7 +1457,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
     def visit(self, visitor):
         visitor.visit_command(self.name, self.info,
                               self.arg_type, self.ret_type,
-                              self.gen, self.success_response, self.boxed)
+                              self.gen, self.success_response, self.boxed,
+                              self.allowed_in_preconfig)
 
 
 class QAPISchemaEvent(QAPISchemaEntity):
@@ -1674,6 +1677,7 @@ class QAPISchema(object):
         gen = expr.get('gen', True)
         success_response = expr.get('success-response', True)
         boxed = expr.get('boxed', False)
+        allowed_in_preconfig = expr.get('allowed-in-preconfig', False)
         if isinstance(data, OrderedDict):
             data = self._make_implicit_object_type(
                 name, info, doc, 'arg', self._make_members(data, info))
@@ -1681,7 +1685,8 @@ class QAPISchema(object):
             assert len(rets) == 1
             rets = self._make_array_type(rets[0], info)
         self._def_entity(QAPISchemaCommand(name, info, doc, data, rets,
-                                           gen, success_response, boxed))
+                                           gen, success_response, boxed,
+                                           allowed_in_preconfig))
 
     def _def_event(self, expr, info, doc):
         name = expr['event']
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 0ea68bf..464c89b 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -228,7 +228,7 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaVisitor):
                                body=texi_entity(doc, 'Members')))
 
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, allowed_in_preconfig):
         doc = self.cur_doc
         if boxed:
             body = texi_body(doc)
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index f66c397..fa7dc01 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -29,6 +29,11 @@ def to_json(obj, level=0):
                               to_json(obj[key], level + 1))
                 for key in sorted(obj.keys())]
         ret = '{' + ', '.join(elts) + '}'
+    elif isinstance(obj, bool):
+        if obj:
+            ret = 'true'
+        else:
+            ret = 'false'
     else:
         assert False                # not implemented
     if level == 1:
@@ -160,12 +165,13 @@ const char %(c_name)s[] = %(c_string)s;
                                     for m in variants.variants]})
 
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, allowed_in_preconfig):
         arg_type = arg_type or self._schema.the_empty_object_type
         ret_type = ret_type or self._schema.the_empty_object_type
         self._gen_json(name, 'command',
                        {'arg-type': self._use_type(arg_type),
-                        'ret-type': self._use_type(ret_type)})
+                        'ret-type': self._use_type(ret_type),
+                        'allowed-in-preconfig': allowed_in_preconfig})
 
     def visit_event(self, name, info, arg_type, boxed):
         arg_type = arg_type or self._schema.the_empty_object_type
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 67e417e..7b22c90 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -42,7 +42,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         self._print_variants(variants)
 
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, allowed_in_preconfig):
         print('command %s %s -> %s' % \
               (name, arg_type and arg_type.name, ret_type and ret_type.name))
         print('   gen=%s success_response=%s boxed=%s' % \
-- 
2.7.4

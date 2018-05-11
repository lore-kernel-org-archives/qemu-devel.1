Received: from eggs.gnu.org ([2001:4830:134:3::10]:38312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fHBHZ-0003yy-OR
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fHBHV-0002qn-Pd
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:52:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41818 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fHBHV-0002q1-K7
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:52:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 89C42EC016
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 16:52:31 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 11 May 2018 18:51:43 +0200
Message-Id: <1526057503-39287-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <1525423069-61903-6-git-send-email-imammedo@redhat.com>
References: <1525423069-61903-6-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v8 05/11] qapi: introduce new cmd option
 "allow-preconfig"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, eblake@redhat.com

New option will be used to allow commands, which are prepared/need
to run, during preconfig state. Other commands that should be able
to run in preconfig state, should be amended to not expect machine
in initialized state or deal with it.

For compatibility reasons, commands that don't use new flag
'allow-preconfig' explicitly are not permitted to run in
preconfig state but allowed in all other states like they used
to be.

Within this patch allow following commands in preconfig state:
   qmp_capabilities
   query-qmp-schema
   query-commands
   query-command-line-options
   query-status
   exit-preconfig
to allow qmp connection, basic introspection and moving to the next
state.

PS:
set-numa-node and query-hotpluggable-cpus will be enabled later in
a separate patches.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v8:
  - (Eric Blake <eblake@redhat.com>)
    * replace allowed-in-preconfig on allow-preconfig in commit msg
    * more wording fixes
    * make example in doc match QMP schema
v7:
  - (Eric Blake <eblake@redhat.com>)
    * s/allowed-in-preconfig/allow-preconfig/
    * s/allowed_in_preconfig/allow_preconfig/
    * move here QCO_ALLOWED_IN_PRECONFIG declaration from
       'cli: add --preconfig option'
      and put this patch before it as well
    * s/QCO_ALLOWED_IN_PRECONFIG/QCO_ALLOW_PRECONFIG/
    * wording fixes in doc
v6:
  * exclude 'cont' command from preconfig enabled, in favor of
    exit-preconfig command
  * mark exit-preconfig with allowed-in-preconfig=true
v5:
  * allow query-command-line-options in preconfig state
  * rebase on top of OOB changes that's now in master
  * spelling/wording fixups
  * make sure that allowed-in-preconfig could be set only to True
  * move out QCO_ALLOWED_IN_PRECONFIG check in do_qmp_dispatch() to
    earlier 'cli: add -preconfig option' patch
v4:
  * replaces complex "universal" approach
     "[PATCH v3 5/9] QAPI: allow to specify valid runstates  per command"
    with a simpler new command flag "allowed-in-preconfig".
    (Eric Blake <eblake@redhat.com>)
---
 include/qapi/qmp/dispatch.h    |  1 +
 docs/devel/qapi-code-gen.txt   | 11 ++++++++++-
 monitor.c                      |  5 ++---
 qapi/introspect.json           |  5 ++++-
 qapi/misc.json                 |  9 ++++++---
 qapi/run-state.json            |  3 ++-
 scripts/qapi/commands.py       | 11 +++++++----
 scripts/qapi/common.py         | 18 +++++++++++-------
 scripts/qapi/doc.py            |  4 ++--
 scripts/qapi/introspect.py     |  7 ++++---
 tests/qapi-schema/test-qapi.py |  4 ++--
 11 files changed, 51 insertions(+), 27 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index ffb4652..b366bb4 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -23,6 +23,7 @@ typedef enum QmpCommandOptions
     QCO_NO_OPTIONS            =  0x0,
     QCO_NO_SUCCESS_RESP       =  (1U << 0),
     QCO_ALLOW_OOB             =  (1U << 1),
+    QCO_ALLOW_PRECONFIG       =  (1U << 2),
 } QmpCommandOptions;
 
 typedef struct QmpCommand
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index b9b6eab..1366228 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -559,7 +559,7 @@ following example objects:
 Usage: { 'command': STRING, '*data': COMPLEX-TYPE-NAME-OR-DICT,
          '*returns': TYPE-NAME, '*boxed': true,
          '*gen': false, '*success-response': false,
-         '*allow-oob': true }
+         '*allow-oob': true, '*allow-preconfig': true }
 
 Commands are defined by using a dictionary containing several members,
 where three members are most common.  The 'command' member is a
@@ -683,6 +683,15 @@ OOB command handlers must satisfy the following conditions:
 
 If in doubt, do not implement OOB execution support.
 
+A command may use the optional 'allow-preconfig' key to permit its execution
+at early runtime configuration stage (preconfig runstate).
+If not specified then a command defaults to 'allow-preconfig': false.
+
+An example of declaring a command that is enabled during preconfig:
+ { 'command': 'qmp_capabilities',
+   'data': { '*enable': [ 'QMPCapability' ] },
+   'allow-preconfig': true }
+
 === Events ===
 
 Usage: { 'event': STRING, '*data': COMPLEX-TYPE-NAME-OR-DICT,
diff --git a/monitor.c b/monitor.c
index 9e50418..922cfc0 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1179,8 +1179,7 @@ static void monitor_init_qmp_commands(void)
     qmp_init_marshal(&qmp_commands);
 
     qmp_register_command(&qmp_commands, "query-qmp-schema",
-                         qmp_query_qmp_schema,
-                         QCO_NO_OPTIONS);
+                         qmp_query_qmp_schema, QCO_ALLOW_PRECONFIG);
     qmp_register_command(&qmp_commands, "device_add", qmp_device_add,
                          QCO_NO_OPTIONS);
     qmp_register_command(&qmp_commands, "netdev_add", qmp_netdev_add,
@@ -1190,7 +1189,7 @@ static void monitor_init_qmp_commands(void)
 
     QTAILQ_INIT(&qmp_cap_negotiation_commands);
     qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilities",
-                         qmp_marshal_qmp_capabilities, QCO_NO_OPTIONS);
+                         qmp_marshal_qmp_capabilities, QCO_ALLOW_PRECONFIG);
 }
 
 static bool qmp_cap_enabled(Monitor *mon, QMPCapability cap)
diff --git a/qapi/introspect.json b/qapi/introspect.json
index c7f67b7..e8a833a 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -262,13 +262,16 @@
 # @allow-oob: whether the command allows out-of-band execution.
 #             (Since: 2.12)
 #
+# @allow-preconfig: command can be executed in preconfig runstate,
+#                   default: false (Since 2.13)
+#
 # TODO: @success-response (currently irrelevant, because it's QGA, not QMP)
 #
 # Since: 2.5
 ##
 { 'struct': 'SchemaInfoCommand',
   'data': { 'arg-type': 'str', 'ret-type': 'str',
-            'allow-oob': 'bool' } }
+            'allow-oob': 'bool', 'allow-preconfig': 'bool' } }
 
 ##
 # @SchemaInfoEvent:
diff --git a/qapi/misc.json b/qapi/misc.json
index f5988cc..a16a7ef 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -37,7 +37,8 @@
 #
 ##
 { 'command': 'qmp_capabilities',
-  'data': { '*enable': [ 'QMPCapability' ] } }
+  'data': { '*enable': [ 'QMPCapability' ] },
+  'allow-preconfig': true }
 
 ##
 # @QMPCapability:
@@ -155,7 +156,8 @@
 # Note: This example has been shortened as the real response is too long.
 #
 ##
-{ 'command': 'query-commands', 'returns': ['CommandInfo'] }
+{ 'command': 'query-commands', 'returns': ['CommandInfo'],
+  'allow-preconfig': true }
 
 ##
 # @LostTickPolicy:
@@ -2648,7 +2650,8 @@
 #
 ##
 {'command': 'query-command-line-options', 'data': { '*option': 'str' },
- 'returns': ['CommandLineOptionInfo'] }
+ 'returns': ['CommandLineOptionInfo'],
+ 'allow-preconfig': true }
 
 ##
 # @X86CPURegister32:
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 9694a9f..444b252 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -94,7 +94,8 @@
 #                  "status": "running" } }
 #
 ##
-{ 'command': 'query-status', 'returns': 'StatusInfo' }
+{ 'command': 'query-status', 'returns': 'StatusInfo',
+  'allow-preconfig': true }
 
 ##
 # @SHUTDOWN:
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 0c5da3a..3b0867c 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -193,13 +193,15 @@ out:
     return ret
 
 
-def gen_register_command(name, success_response, allow_oob):
+def gen_register_command(name, success_response, allow_oob, allow_preconfig):
     options = []
 
     if not success_response:
         options += ['QCO_NO_SUCCESS_RESP']
     if allow_oob:
         options += ['QCO_ALLOW_OOB']
+    if allow_preconfig:
+        options += ['QCO_ALLOW_PRECONFIG']
 
     if not options:
         options = ['QCO_NO_OPTIONS']
@@ -275,8 +277,8 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
                        c_prefix=c_name(self._prefix, protect=False)))
         genc.add(gen_registry(self._regy, self._prefix))
 
-    def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed, allow_oob):
+    def visit_command(self, name, info, arg_type, ret_type, gen,
+                      success_response, boxed, allow_oob, allow_preconfig):
         if not gen:
             return
         self._genh.add(gen_command_decl(name, arg_type, boxed, ret_type))
@@ -285,7 +287,8 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
             self._genc.add(gen_marshal_output(ret_type))
         self._genh.add(gen_marshal_decl(name))
         self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
-        self._regy += gen_register_command(name, success_response, allow_oob)
+        self._regy += gen_register_command(name, success_response, allow_oob,
+                                           allow_preconfig)
 
 
 def gen_commands(schema, output_dir, prefix):
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index a032cec..e82990f 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -872,7 +872,8 @@ def check_keys(expr_elem, meta, required, optional=[]):
             raise QAPISemError(info,
                                "'%s' of %s '%s' should only use false value"
                                % (key, meta, name))
-        if (key == 'boxed' or key == 'allow-oob') and value is not True:
+        if (key == 'boxed' or key == 'allow-oob' or
+            key == 'allow-preconfig') and value is not True:
             raise QAPISemError(info,
                                "'%s' of %s '%s' should only use true value"
                                % (key, meta, name))
@@ -922,7 +923,7 @@ def check_exprs(exprs):
             meta = 'command'
             check_keys(expr_elem, 'command', [],
                        ['data', 'returns', 'gen', 'success-response',
-                        'boxed', 'allow-oob'])
+                        'boxed', 'allow-oob', 'allow-preconfig'])
         elif 'event' in expr:
             meta = 'event'
             check_keys(expr_elem, 'event', [], ['data', 'boxed'])
@@ -1044,8 +1045,8 @@ class QAPISchemaVisitor(object):
     def visit_alternate_type(self, name, info, variants):
         pass
 
-    def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed, allow_oob):
+    def visit_command(self, name, info, arg_type, ret_type, gen,
+                      success_response, boxed, allow_oob, allow_preconfig):
         pass
 
     def visit_event(self, name, info, arg_type, boxed):
@@ -1422,7 +1423,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
 
 class QAPISchemaCommand(QAPISchemaEntity):
     def __init__(self, name, info, doc, arg_type, ret_type,
-                 gen, success_response, boxed, allow_oob):
+                 gen, success_response, boxed, allow_oob, allow_preconfig):
         QAPISchemaEntity.__init__(self, name, info, doc)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
@@ -1434,6 +1435,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         self.success_response = success_response
         self.boxed = boxed
         self.allow_oob = allow_oob
+        self.allow_preconfig = allow_preconfig
 
     def check(self, schema):
         if self._arg_type_name:
@@ -1458,7 +1460,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
         visitor.visit_command(self.name, self.info,
                               self.arg_type, self.ret_type,
                               self.gen, self.success_response,
-                              self.boxed, self.allow_oob)
+                              self.boxed, self.allow_oob,
+                              self.allow_preconfig)
 
 
 class QAPISchemaEvent(QAPISchemaEntity):
@@ -1678,6 +1681,7 @@ class QAPISchema(object):
         success_response = expr.get('success-response', True)
         boxed = expr.get('boxed', False)
         allow_oob = expr.get('allow-oob', False)
+        allow_preconfig = expr.get('allow-preconfig', False)
         if isinstance(data, OrderedDict):
             data = self._make_implicit_object_type(
                 name, info, doc, 'arg', self._make_members(data, info))
@@ -1686,7 +1690,7 @@ class QAPISchema(object):
             rets = self._make_array_type(rets[0], info)
         self._def_entity(QAPISchemaCommand(name, info, doc, data, rets,
                                            gen, success_response,
-                                           boxed, allow_oob))
+                                           boxed, allow_oob, allow_preconfig))
 
     def _def_event(self, expr, info, doc):
         name = expr['event']
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 9b312b2..b563084 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -226,8 +226,8 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaVisitor):
                                name=doc.symbol,
                                body=texi_entity(doc, 'Members')))
 
-    def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed, allow_oob):
+    def visit_command(self, name, info, arg_type, ret_type, gen,
+                      success_response, boxed, allow_oob, allow_preconfig):
         doc = self.cur_doc
         if boxed:
             body = texi_body(doc)
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index f9e67e8..5b6c72c 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -171,14 +171,15 @@ const QLitObject %(c_name)s = %(c_string)s;
                        {'members': [{'type': self._use_type(m.type)}
                                     for m in variants.variants]})
 
-    def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed, allow_oob):
+    def visit_command(self, name, info, arg_type, ret_type, gen,
+                      success_response, boxed, allow_oob, allow_preconfig):
         arg_type = arg_type or self._schema.the_empty_object_type
         ret_type = ret_type or self._schema.the_empty_object_type
         self._gen_qlit(name, 'command',
                        {'arg-type': self._use_type(arg_type),
                         'ret-type': self._use_type(ret_type),
-                        'allow-oob': allow_oob})
+                        'allow-oob': allow_oob,
+                        'allow-preconfig': allow_preconfig})
 
     def visit_event(self, name, info, arg_type, boxed):
         arg_type = arg_type or self._schema.the_empty_object_type
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index c1a144b..89b92ed 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -41,8 +41,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         print('alternate %s' % name)
         self._print_variants(variants)
 
-    def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed, allow_oob):
+    def visit_command(self, name, info, arg_type, ret_type, gen,
+                      success_response, boxed, allow_oob, allow_preconfig):
         print('command %s %s -> %s' % \
               (name, arg_type and arg_type.name, ret_type and ret_type.name))
         print('   gen=%s success_response=%s boxed=%s oob=%s' % \
-- 
2.7.4

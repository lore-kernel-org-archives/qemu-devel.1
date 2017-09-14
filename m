Received: from eggs.gnu.org ([2001:4830:134:3::10]:52830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsOwe-0007S9-6n
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsOwb-0008Cg-O1
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:52:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dsOwb-0008Am-Fm
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:52:17 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 14 Sep 2017 15:50:34 +0800
Message-Id: <1505375436-28439-14-git-send-email-peterx@redhat.com>
In-Reply-To: <1505375436-28439-1-git-send-email-peterx@redhat.com>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 13/15] qapi: introduce new cmd option "allow-oob"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Here "oob" stands for "Out-Of-Band".  When "allow-oob" is set, it means
the command allows out-of-band execution.  Please see the spec update
for more details.

The "oob" idea is proposed by Markus Armbruster in following thread:

  https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02057.html

This new "allow-oob" boolean will be exposed by "query-qmp-schema" as
well for command entries, so that QMP clients can know which command can
be used as out-of-band calls. For example the command "migrate"
originally looks like:

  {"name": "migrate", "ret-type": "17", "meta-type": "command",
   "arg-type": "86"}

And it'll be changed into:

  {"name": "migrate", "ret-type": "17", "allow-oob": false,
   "meta-type": "command", "arg-type": "86"}

This patch only provides the QMP interface level changes.  It does not
contains the real out-of-band execution implementation yet.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/qapi-code-gen.txt   | 41 ++++++++++++++++++++++++++++++++++++-----
 include/qapi/qmp/dispatch.h    |  1 +
 qapi/introspect.json           |  6 +++++-
 scripts/qapi-commands.py       | 19 ++++++++++++++-----
 scripts/qapi-introspect.py     | 10 ++++++++--
 scripts/qapi.py                | 15 ++++++++++-----
 scripts/qapi2texi.py           |  2 +-
 tests/qapi-schema/test-qapi.py |  2 +-
 8 files changed, 76 insertions(+), 20 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index f04c63f..61fa167 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -556,7 +556,8 @@ following example objects:
 
 Usage: { 'command': STRING, '*data': COMPLEX-TYPE-NAME-OR-DICT,
          '*returns': TYPE-NAME, '*boxed': true,
-         '*gen': false, '*success-response': false }
+         '*gen': false, '*success-response': false,
+         '*allow-oob': false }
 
 Commands are defined by using a dictionary containing several members,
 where three members are most common.  The 'command' member is a
@@ -636,6 +637,34 @@ possible, the command expression should include the optional key
 'success-response' with boolean value false.  So far, only QGA makes
 use of this member.
 
+Most of the QMP commands are handled sequentially in such a order.
+Firstly, the JSON Parser parses the command request into some internal
+message, then it delivers the message to QMP dispatchers; secondly,
+the QMP dispatchers will handle the commands one by one in time order,
+respond when necessary.  For some commands that always complete
+"quickly" can instead be executed directly during parsing, at the QMP
+client's request.  This kind of commands that allow direct execution
+is called "out-of-band" ("oob" as shortcut) commands. the response can
+overtake prior in-band commands' responses.  By default, commands are
+always in-band.  We need to explicitly specify "allow-oob" to "True"
+to show that one command can be run out-of-band.
+
+One thing to mention is that, although out-of-band execution of
+commands benefit from quick and asynchronous execution, it need to
+satisfy at least the following:
+
+(1) It is extremely quick and never blocks, so that its execution will
+    not block parsing routine of any other monitors.
+
+(2) It does not need BQL, since the parser can be run without BQL,
+    while the dispatcher is always with BQL held.
+
+If not, the command is not suitable to be allowed to run out-of-band,
+and it should set its "allow-oob" to "False".  Whether a command is
+allowed to run out-of-band can also be introspected using
+query-qmp-schema command.  Please see the section "Client JSON
+Protocol introspection" for more information.
+
 
 === Events ===
 
@@ -739,10 +768,12 @@ references by name.
 QAPI schema definitions not reachable that way are omitted.
 
 The SchemaInfo for a command has meta-type "command", and variant
-members "arg-type" and "ret-type".  On the wire, the "arguments"
-member of a client's "execute" command must conform to the object type
-named by "arg-type".  The "return" member that the server passes in a
-success response conforms to the type named by "ret-type".
+members "arg-type", "ret-type" and "allow-oob".  On the wire, the
+"arguments" member of a client's "execute" command must conform to the
+object type named by "arg-type".  The "return" member that the server
+passes in a success response conforms to the type named by
+"ret-type".  When "allow-oob" is set, it means the command supports
+out-of-band execution.
 
 If the command takes no arguments, "arg-type" names an object type
 without members.  Likewise, if the command returns nothing, "ret-type"
diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 20578dc..b767988 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -23,6 +23,7 @@ typedef enum QmpCommandOptions
 {
     QCO_NO_OPTIONS = 0x0,
     QCO_NO_SUCCESS_RESP = 0x1,
+    QCO_ALLOW_OOB = 0x2,
 } QmpCommandOptions;
 
 typedef struct QmpCommand
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 5b3e6e9..57cc137 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -259,12 +259,16 @@
 #
 # @ret-type: the name of the command's result type.
 #
+# @allow-oob: whether the command allows out-of-band execution.
+#             (Since: 2.11)
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
diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 974d0a4..b2b0bc0 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -192,10 +192,18 @@ out:
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
@@ -241,7 +249,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
         self._visited_ret_types = None
 
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, allow_oob):
         if not gen:
             return
         self.decl += gen_command_decl(name, arg_type, boxed, ret_type)
@@ -250,7 +258,8 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
             self.defn += gen_marshal_output(ret_type)
         self.decl += gen_marshal_decl(name)
         self.defn += gen_marshal(name, arg_type, boxed, ret_type)
-        self._regy += gen_register_command(name, success_response)
+        self._regy += gen_register_command(name, success_response,
+                                           allow_oob)
 
 
 (input_file, output_dir, do_c, do_h, prefix, opts) = parse_command_line()
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 032bcea..9fbf88b 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -28,6 +28,11 @@ def to_json(obj, level=0):
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
@@ -154,12 +159,13 @@ const char %(c_name)s[] = %(c_string)s;
                                     for m in variants.variants]})
 
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, allow_oob):
         arg_type = arg_type or self._schema.the_empty_object_type
         ret_type = ret_type or self._schema.the_empty_object_type
         self._gen_json(name, 'command',
                        {'arg-type': self._use_type(arg_type),
-                        'ret-type': self._use_type(ret_type)})
+                        'ret-type': self._use_type(ret_type),
+                        'allow-oob': allow_oob})
 
     def visit_event(self, name, info, arg_type, boxed):
         arg_type = arg_type or self._schema.the_empty_object_type
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 62dc52e..f411b8f 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -920,7 +920,8 @@ def check_exprs(exprs):
         elif 'command' in expr:
             meta = 'command'
             check_keys(expr_elem, 'command', [],
-                       ['data', 'returns', 'gen', 'success-response', 'boxed'])
+                       ['data', 'returns', 'gen', 'success-response',
+                        'boxed', 'allow-oob'])
         elif 'event' in expr:
             meta = 'event'
             check_keys(expr_elem, 'event', [], ['data', 'boxed'])
@@ -1031,7 +1032,7 @@ class QAPISchemaVisitor(object):
         pass
 
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, allow_oob):
         pass
 
     def visit_event(self, name, info, arg_type, boxed):
@@ -1398,7 +1399,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
 
 class QAPISchemaCommand(QAPISchemaEntity):
     def __init__(self, name, info, doc, arg_type, ret_type,
-                 gen, success_response, boxed):
+                 gen, success_response, boxed, allow_oob):
         QAPISchemaEntity.__init__(self, name, info, doc)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
@@ -1409,6 +1410,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         self.gen = gen
         self.success_response = success_response
         self.boxed = boxed
+        self.allow_oob = allow_oob
 
     def check(self, schema):
         if self._arg_type_name:
@@ -1432,7 +1434,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
     def visit(self, visitor):
         visitor.visit_command(self.name, self.info,
                               self.arg_type, self.ret_type,
-                              self.gen, self.success_response, self.boxed)
+                              self.gen, self.success_response,
+                              self.boxed, self.allow_oob)
 
 
 class QAPISchemaEvent(QAPISchemaEntity):
@@ -1640,6 +1643,7 @@ class QAPISchema(object):
         gen = expr.get('gen', True)
         success_response = expr.get('success-response', True)
         boxed = expr.get('boxed', False)
+        allow_oob = expr.get('allow-oob', False)
         if isinstance(data, OrderedDict):
             data = self._make_implicit_object_type(
                 name, info, doc, 'arg', self._make_members(data, info))
@@ -1647,7 +1651,8 @@ class QAPISchema(object):
             assert len(rets) == 1
             rets = self._make_array_type(rets[0], info)
         self._def_entity(QAPISchemaCommand(name, info, doc, data, rets,
-                                           gen, success_response, boxed))
+                                           gen, success_response,
+                                           boxed, allow_oob))
 
     def _def_event(self, expr, info, doc):
         name = expr['event']
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index a317526..0ac0df5 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -236,7 +236,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
                              body=texi_entity(doc, 'Members'))
 
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, allow_oob):
         doc = self.cur_doc
         if self.out:
             self.out += '\n'
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index c7724d3..6749e9e 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -36,7 +36,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         self._print_variants(variants)
 
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, allow_oob):
         print 'command %s %s -> %s' % \
             (name, arg_type and arg_type.name, ret_type and ret_type.name)
         print '   gen=%s success_response=%s boxed=%s' % \
-- 
2.7.4

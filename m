Received: from eggs.gnu.org ([2001:4830:134:3::10]:56397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eeDpd-0002jS-7r
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 00:42:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eeDpa-0000jE-0v
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 00:42:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eeDpZ-0000iI-Na
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 00:42:41 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed, 24 Jan 2018 13:39:51 +0800
Message-Id: <20180124053957.29145-18-peterx@redhat.com>
In-Reply-To: <20180124053957.29145-1-peterx@redhat.com>
References: <20180124053957.29145-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 17/23] qapi: introduce new cmd option
 "allow-oob"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Here "oob" stands for "Out-Of-Band".  When "allow-oob" is set, it means
the command allows out-of-band execution.

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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qapi/qmp/dispatch.h    |  1 +
 qapi/introspect.json           |  6 +++++-
 scripts/qapi-commands.py       | 19 ++++++++++++++-----
 scripts/qapi-introspect.py     | 10 ++++++++--
 scripts/qapi.py                | 15 ++++++++++-----
 scripts/qapi2texi.py           |  2 +-
 tests/qapi-schema/test-qapi.py |  2 +-
 7 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 20578dcd48..b76798800c 100644
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
index 5b3e6e9d78..c7f67b7d78 100644
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
diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 974d0a4a80..b2b0bc0510 100644
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
index 032bcea491..9fbf88b644 100644
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
index 43a54bf40f..61cc33660b 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -911,7 +911,8 @@ def check_exprs(exprs):
         elif 'command' in expr:
             meta = 'command'
             check_keys(expr_elem, 'command', [],
-                       ['data', 'returns', 'gen', 'success-response', 'boxed'])
+                       ['data', 'returns', 'gen', 'success-response',
+                        'boxed', 'allow-oob'])
         elif 'event' in expr:
             meta = 'event'
             check_keys(expr_elem, 'event', [], ['data', 'boxed'])
@@ -1022,7 +1023,7 @@ class QAPISchemaVisitor(object):
         pass
 
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, allow_oob):
         pass
 
     def visit_event(self, name, info, arg_type, boxed):
@@ -1389,7 +1390,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
 
 class QAPISchemaCommand(QAPISchemaEntity):
     def __init__(self, name, info, doc, arg_type, ret_type,
-                 gen, success_response, boxed):
+                 gen, success_response, boxed, allow_oob):
         QAPISchemaEntity.__init__(self, name, info, doc)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
@@ -1400,6 +1401,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         self.gen = gen
         self.success_response = success_response
         self.boxed = boxed
+        self.allow_oob = allow_oob
 
     def check(self, schema):
         if self._arg_type_name:
@@ -1423,7 +1425,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
     def visit(self, visitor):
         visitor.visit_command(self.name, self.info,
                               self.arg_type, self.ret_type,
-                              self.gen, self.success_response, self.boxed)
+                              self.gen, self.success_response,
+                              self.boxed, self.allow_oob)
 
 
 class QAPISchemaEvent(QAPISchemaEntity):
@@ -1631,6 +1634,7 @@ class QAPISchema(object):
         gen = expr.get('gen', True)
         success_response = expr.get('success-response', True)
         boxed = expr.get('boxed', False)
+        allow_oob = expr.get('allow-oob', False)
         if isinstance(data, OrderedDict):
             data = self._make_implicit_object_type(
                 name, info, doc, 'arg', self._make_members(data, info))
@@ -1638,7 +1642,8 @@ class QAPISchema(object):
             assert len(rets) == 1
             rets = self._make_array_type(rets[0], info)
         self._def_entity(QAPISchemaCommand(name, info, doc, data, rets,
-                                           gen, success_response, boxed))
+                                           gen, success_response,
+                                           boxed, allow_oob))
 
     def _def_event(self, expr, info, doc):
         name = expr['event']
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 92e2af2cd6..634ab3edb7 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -226,7 +226,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
                              body=texi_entity(doc, 'Members'))
 
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, allow_oob):
         doc = self.cur_doc
         if boxed:
             body = texi_body(doc)
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index fe0ca08d78..5c3ddce6a2 100644
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
2.14.3

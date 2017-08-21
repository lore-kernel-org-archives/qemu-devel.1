Received: from eggs.gnu.org ([2001:4830:134:3::10]:46344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1djhO7-0001NG-Fw
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1djhO5-0005AR-9I
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:44:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1djhO4-0005A8-Vx
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:44:41 -0400
From: Peter Xu <peterx@redhat.com>
Date: Mon, 21 Aug 2017 15:44:21 +0800
Message-Id: <1503301464-27886-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1503301464-27886-1-git-send-email-peterx@redhat.com>
References: <1503301464-27886-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 3/6] QAPI: new QMP command option "without-bql"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Introducing this new parameter for QMP commands in general to mark out
when the command does not need BQL.  Normally QMP command executions are
done with the protection of BQL in QEMU.  However the truth is that not
all the QMP commands require the BQL.

This new parameter provides a way to allow QMP commands to run in
parallel when possible, without the contention on the BQL.

Since the default value of "without-bql" is still false, so now all QMP
commands are still protected by BQL still.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 10 +++++++++-
 include/qapi/qmp/dispatch.h  |  1 +
 qapi/qmp-dispatch.c          | 11 +++++++++++
 scripts/qapi-commands.py     | 18 +++++++++++++-----
 scripts/qapi-introspect.py   |  2 +-
 scripts/qapi.py              | 15 ++++++++++-----
 scripts/qapi2texi.py         |  2 +-
 7 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 9903ac4..4960d00 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -556,7 +556,8 @@ following example objects:
 
 Usage: { 'command': STRING, '*data': COMPLEX-TYPE-NAME-OR-DICT,
          '*returns': TYPE-NAME, '*boxed': true,
-         '*gen': false, '*success-response': false }
+         '*gen': false, '*success-response': false,
+         '*without-bql': false }
 
 Commands are defined by using a dictionary containing several members,
 where three members are most common.  The 'command' member is a
@@ -636,6 +637,13 @@ possible, the command expression should include the optional key
 'success-response' with boolean value false.  So far, only QGA makes
 use of this member.
 
+Most of the commands require the Big QEMU Lock (BQL) be held during
+execution.  However, there is a small subset of the commands that may
+not really need BQL at all.  To mark out this kind of commands, we can
+specify "without-bql" to "true".  This parameter is only a hint for
+internal QMP implementation to provide possiblility to allow commands
+be run in parallel, or reduce the contention of the lock.  Users of QMP
+should not really be aware of such information.
 
 === Events ===
 
diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 20578dc..ec5c620 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -23,6 +23,7 @@ typedef enum QmpCommandOptions
 {
     QCO_NO_OPTIONS = 0x0,
     QCO_NO_SUCCESS_RESP = 0x1,
+    QCO_WITHOUT_BQL = 0x2,
 } QmpCommandOptions;
 
 typedef struct QmpCommand
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 3b6b224..b7fba5e 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -107,6 +107,17 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
         QINCREF(args);
     }
 
+    if (cmd->options & QCO_WITHOUT_BQL) {
+        /*
+         * If this command can live without BQL, then we don't take
+         * it.  One thing to mention: we may have already taken the
+         * BQL before reaching here.  If so, we just keep it.  So
+         * generally speaking we are trying our best on reducing the
+         * contention of BQL.
+         */
+        take_bql = false;
+    }
+
     if (take_bql) {
         qemu_mutex_lock_iothread();
     }
diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 974d0a4..155a0a4 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -192,10 +192,17 @@ out:
     return ret
 
 
-def gen_register_command(name, success_response):
-    options = 'QCO_NO_OPTIONS'
+def gen_register_command(name, success_response, without_bql):
+    options = []
+
     if not success_response:
-        options = 'QCO_NO_SUCCESS_RESP'
+        options += ['QCO_NO_SUCCESS_RESP']
+    if without_bql:
+        options += ['QCO_WITHOUT_BQL']
+
+    if not options:
+        options = ['QCO_NO_OPTIONS']
+    options = " | ".join(options)
 
     ret = mcgen('''
     qmp_register_command(cmds, "%(name)s",
@@ -241,7 +248,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
         self._visited_ret_types = None
 
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, without_bql):
         if not gen:
             return
         self.decl += gen_command_decl(name, arg_type, boxed, ret_type)
@@ -250,7 +257,8 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
             self.defn += gen_marshal_output(ret_type)
         self.decl += gen_marshal_decl(name)
         self.defn += gen_marshal(name, arg_type, boxed, ret_type)
-        self._regy += gen_register_command(name, success_response)
+        self._regy += gen_register_command(name, success_response,
+                                           without_bql)
 
 
 (input_file, output_dir, do_c, do_h, prefix, opts) = parse_command_line()
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 032bcea..a523544 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -154,7 +154,7 @@ const char %(c_name)s[] = %(c_string)s;
                                     for m in variants.variants]})
 
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, without_bql):
         arg_type = arg_type or self._schema.the_empty_object_type
         ret_type = ret_type or self._schema.the_empty_object_type
         self._gen_json(name, 'command',
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 8aa2775..3951143 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -920,7 +920,8 @@ def check_exprs(exprs):
         elif 'command' in expr:
             meta = 'command'
             check_keys(expr_elem, 'command', [],
-                       ['data', 'returns', 'gen', 'success-response', 'boxed'])
+                       ['data', 'returns', 'gen', 'success-response',
+                        'boxed', 'without-bql'])
         elif 'event' in expr:
             meta = 'event'
             check_keys(expr_elem, 'event', [], ['data', 'boxed'])
@@ -1031,7 +1032,7 @@ class QAPISchemaVisitor(object):
         pass
 
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, without_bql):
         pass
 
     def visit_event(self, name, info, arg_type, boxed):
@@ -1398,7 +1399,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
 
 class QAPISchemaCommand(QAPISchemaEntity):
     def __init__(self, name, info, doc, arg_type, ret_type,
-                 gen, success_response, boxed):
+                 gen, success_response, boxed, without_bql):
         QAPISchemaEntity.__init__(self, name, info, doc)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
@@ -1408,6 +1409,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         self.ret_type = None
         self.gen = gen
         self.success_response = success_response
+        self.without_bql = without_bql
         self.boxed = boxed
 
     def check(self, schema):
@@ -1432,7 +1434,8 @@ class QAPISchemaCommand(QAPISchemaEntity):
     def visit(self, visitor):
         visitor.visit_command(self.name, self.info,
                               self.arg_type, self.ret_type,
-                              self.gen, self.success_response, self.boxed)
+                              self.gen, self.success_response,
+                              self.boxed, self.without_bql)
 
 
 class QAPISchemaEvent(QAPISchemaEntity):
@@ -1639,6 +1642,7 @@ class QAPISchema(object):
         rets = expr.get('returns')
         gen = expr.get('gen', True)
         success_response = expr.get('success-response', True)
+        without_bql = expr.get('without-bql', False)
         boxed = expr.get('boxed', False)
         if isinstance(data, OrderedDict):
             data = self._make_implicit_object_type(
@@ -1647,7 +1651,8 @@ class QAPISchema(object):
             assert len(rets) == 1
             rets = self._make_array_type(rets[0], info)
         self._def_entity(QAPISchemaCommand(name, info, doc, data, rets,
-                                           gen, success_response, boxed))
+                                           gen, success_response,
+                                           boxed, without_bql))
 
     def _def_event(self, expr, info, doc):
         name = expr['event']
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index a317526..659bd83 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -236,7 +236,7 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
                              body=texi_entity(doc, 'Members'))
 
     def visit_command(self, name, info, arg_type, ret_type,
-                      gen, success_response, boxed):
+                      gen, success_response, boxed, without_bql):
         doc = self.cur_doc
         if self.out:
             self.out += '\n'
-- 
2.7.4

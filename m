Received: from eggs.gnu.org ([2001:4830:134:3::10]:38168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1el8RN-0000jB-Bc
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1el8RK-0005wD-Qr
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49860 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1el8RK-0005v8-JZ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:14 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 12 Feb 2018 08:22:07 +0100
Message-Id: <20180212072207.9367-15-armbru@redhat.com>
In-Reply-To: <20180212072207.9367-1-armbru@redhat.com>
References: <20180212072207.9367-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 14/14] qapi: Add #if conditions to commands, events,
 types, visitors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com

Example change to generated code:

    diff -rup test-qapi-events.h.old test-qapi-events.h
    --- test-qapi-events.h.old	2018-02-12 07:02:45.672737544 +0100
    +++ test-qapi-events.h	2018-02-12 07:03:01.128517669 +0100
    @@ -30,8 +30,10 @@ void qapi_event_send_event_e(UserDefZero
     void qapi_event_send_event_f(UserDefAlternate *arg, Error **errp);

     void qapi_event_send___org_qemu_x_event(__org_qemu_x_Enum __org_qemu_x_member1, const char *__org_qemu_x_member2, bool has_q_wchar_t, int64_t q_wchar_t, Error **errp);
    +#if defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)

     void qapi_event_send_testifevent(TestIfStruct *foo, Error **errp);
    +#endif /* defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT) */

     typedef enum test_QAPIEvent {
	 TEST_QAPI_EVENT_EVENT_A = 0,

TODO nice blank lines before #if and after #endif
FIXME unclean access of protected members in commands.py

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/commands.py |  7 ++++++-
 scripts/qapi/common.py   | 37 +++++++++++++++++++++++++++++++++++++
 tests/test-qmp-cmds.c    |  4 ++--
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 21a7e0dbe6..439a8714e2 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -276,8 +276,13 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
             self._visited_ret_types[self._genc].add(ret_type)
             self._genc.add(gen_marshal_output(ret_type))
         self._genh.add(gen_marshal_decl(name))
-        self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
+        self._genc.add(gen_marshal(name, arg_type, boxed, ret_type,))
+        # FIXME unclean access of protected members
+        if self._genc._open_ifcond:
+            self._regy += gen_if(self._genc._open_ifcond)
         self._regy += gen_register_command(name, success_response)
+        if self._genc._open_ifcond:
+            self._regy += gen_endif(self._genc._open_ifcond)
 
 
 def gen_commands(schema, output_dir, prefix):
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 1a78dfaf3f..164d3e2daa 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -2122,6 +2122,9 @@ class QAPIGenC(QAPIGen):
         self._blurb = blurb.strip('\n')
         self._copyright = '\n * '.join(re.findall(r'^Copyright .*', pydoc,
                                                   re.MULTILINE))
+        self._open_ifcond = None
+        self._preamble_needs_ifcond = False
+        self._body_needs_ifcond = False
 
     def _top(self, fname):
         return mcgen('''
@@ -2139,6 +2142,36 @@ class QAPIGenC(QAPIGen):
 ''',
                      blurb=self._blurb, copyright=self._copyright)
 
+    def ifcond(self, ifcond, begin):
+        if begin:
+            assert not self._open_ifcond
+            self._open_ifcond = ifcond
+            self._preamble_needs_ifcond = True
+            self._body_needs_ifcond = True
+        else:
+            assert self._open_ifcond == ifcond
+            if not self._preamble_needs_ifcond:
+                QAPIGen.preamble_add(self, gen_endif(ifcond))
+                # TODO emit blank line
+            if not self._body_needs_ifcond:
+                QAPIGen.add(self, gen_endif(ifcond))
+                # TODO emit blank line
+            self._open_ifcond = None
+
+    def preamble_add(self, text):
+        if self._open_ifcond and self._preamble_needs_ifcond:
+            # TODO emit blank line
+            QAPIGen.preamble_add(self, gen_if(self._open_ifcond))
+            self._preamble_needs_ifcond = False
+        QAPIGen.preamble_add(self, text)
+
+    def add(self, text):
+        if self._open_ifcond and self._body_needs_ifcond:
+            # TODO emit blank line
+            QAPIGen.add(self, gen_if(self._open_ifcond))
+            self._body_needs_ifcond = False
+        QAPIGen.add(self, text)
+
 
 class QAPIGenH(QAPIGenC):
 
@@ -2224,3 +2257,7 @@ class QAPISchemaModularCVisitor(QAPISchemaVisitor):
 #include "%(basename)s.h"
 ''',
                                       basename=basename))
+
+    def visit_ifcond(self, ifcond, begin):
+        self._genc.ifcond(ifcond, begin)
+        self._genh.ifcond(ifcond, begin)
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index c0a3c46439..b709a1fa3a 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -12,11 +12,11 @@
 
 static QmpCommandList qmp_commands;
 
-/* #if defined(TEST_IF_CMD) */
+#if defined(TEST_IF_CMD)
 void qmp_TestIfCmd(TestIfStruct *foo, Error **errp)
 {
 }
-/* #endif */
+#endif
 
 void qmp_user_def_cmd(Error **errp)
 {
-- 
2.13.6

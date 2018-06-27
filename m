Received: from eggs.gnu.org ([2001:4830:134:3::10]:58568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fYDQa-0003Xh-0f
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fYDQX-0003JF-Ef
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:36:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55602 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fYDQX-0003Ie-4z
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:36:17 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 27 Jun 2018 18:35:46 +0200
Message-Id: <20180627163551.31610-11-marcandre.lureau@redhat.com>
In-Reply-To: <20180627163551.31610-1-marcandre.lureau@redhat.com>
References: <20180627163551.31610-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 10/15] qapi/commands: add #if conditions to
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, eblake@redhat.com, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Wrap generated code with #if/#endif using an 'ifcontext' on
QAPIGenCSnippet objects.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/commands.py | 21 ++++++++++++---------
 tests/test-qmp-cmds.c    |  5 +++--
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index dcc03c7859..72749c7fc5 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -239,7 +239,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModularCV=
isitor):
         QAPISchemaModularCVisitor.__init__(
             self, prefix, 'qapi-commands',
             ' * Schema-defined QAPI/QMP commands', __doc__)
-        self._regy =3D ''
+        self._regy =3D QAPIGenCCode()
         self._visited_ret_types =3D {}
=20
     def _begin_module(self, name):
@@ -275,20 +275,23 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModular=
CVisitor):
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
 ''',
                        c_prefix=3Dc_name(self._prefix, protect=3DFalse))=
)
-        genc.add(gen_registry(self._regy, self._prefix))
+        genc.add(gen_registry(self._regy.get_content(), self._prefix))
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfi=
g):
         if not gen:
             return
-        self._genh.add(gen_command_decl(name, arg_type, boxed, ret_type)=
)
-        if ret_type and ret_type not in self._visited_ret_types[self._ge=
nc]:
+        if ret_type and \
+           ret_type not in self._visited_ret_types[self._genc]:
             self._visited_ret_types[self._genc].add(ret_type)
-            self._genc.add(gen_marshal_output(ret_type))
-        self._genh.add(gen_marshal_decl(name))
-        self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
-        self._regy +=3D gen_register_command(name, success_response, all=
ow_oob,
-                                           allow_preconfig)
+            with ifcontext(ret_type.ifcond, self._genh, self._genc, self=
._regy):
+                self._genc.add(gen_marshal_output(ret_type))
+        with ifcontext(ifcond, self._genh, self._genc, self._regy):
+            self._genh.add(gen_command_decl(name, arg_type, boxed, ret_t=
ype))
+            self._genh.add(gen_marshal_decl(name))
+            self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
+            self._regy.add(gen_register_command(name, success_response,
+                                                allow_oob, allow_preconf=
ig))
=20
=20
 def gen_commands(schema, output_dir, prefix):
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 840530b84c..bd27353908 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -12,12 +12,13 @@
=20
 static QmpCommandList qmp_commands;
=20
-/* #if defined(TEST_IF_STRUCT) && defined(TEST_IF_CMD) */
+#if defined(TEST_IF_STRUCT) && defined(TEST_IF_CMD)
 UserDefThree *qmp_TestIfCmd(TestIfStruct *foo, Error **errp)
+void qmp_TestIfCmd(TestIfStruct *foo, Error **errp)
 {
     return NULL;
 }
-/* #endif */
+#endif
=20
 UserDefThree *qmp_TestCmdReturnDefThree(Error **errp)
 {
--=20
2.18.0.rc1

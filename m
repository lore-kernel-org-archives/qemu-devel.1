Received: from eggs.gnu.org ([2001:4830:134:3::10]:39563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1faNfx-0002D7-18
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1faNfu-0003Wp-BE
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:57:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53150 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1faNfu-0003WS-5D
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:57:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA97840780F8
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:57:05 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  3 Jul 2018 17:56:43 +0200
Message-Id: <20180703155648.11933-10-marcandre.lureau@redhat.com>
In-Reply-To: <20180703155648.11933-1-marcandre.lureau@redhat.com>
References: <20180703155648.11933-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 09/14] qapi/commands: add #if conditions to
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
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Wrap generated code with #if/#endif using an 'ifcontext' on
QAPIGenCSnippet objects.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/commands.py | 26 +++++++++++++++++---------
 tests/test-qmp-cmds.c    |  4 ++--
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index dcc03c7859..0c9e321179 100644
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
@@ -275,20 +275,28 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModular=
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
+        # FIXME: If T is a user-defined type, the user is responsible
+        # for making this work, i.e. to make T's condition the
+        # conjunction of the T-returning commands' conditions.  If T
+        # is a built-in type, this isn't possible: the
+        # qmp_marshal_output_T() will be generated unconditionally.
+        if (ret_type and
+            ret_type not in self._visited_ret_types[self._genc]):
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
index 840530b84c..ce277c9c3b 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -12,12 +12,12 @@
=20
 static QmpCommandList qmp_commands;
=20
-/* #if defined(TEST_IF_STRUCT) && defined(TEST_IF_CMD) */
+#if defined(TEST_IF_STRUCT) && defined(TEST_IF_CMD)
 UserDefThree *qmp_TestIfCmd(TestIfStruct *foo, Error **errp)
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

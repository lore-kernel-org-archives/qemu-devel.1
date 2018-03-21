Received: from eggs.gnu.org ([2001:4830:134:3::10]:48425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIP-00055O-BG
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIO-0007pU-HB
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58158 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycIO-0007pG-CP
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E39ED80AD20C
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:52:43 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:33 +0100
Message-Id: <20180321115211.17937-12-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 11/49] qapi/commands: add #if conditions to
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Wrap generated code with #if/#endif using an 'ifcontext' on
QAPIGenCSnippet objects.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/commands.py | 19 ++++++++++---------
 tests/test-qmp-cmds.c    |  4 ++--
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index e2366b4801..40bb680b7c 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -237,7 +237,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModularCV=
isitor):
         QAPISchemaModularCVisitor.__init__(
             self, prefix, 'qapi-commands',
             ' * Schema-defined QAPI/QMP commands', __doc__)
-        self._regy =3D ''
+        self._regy =3D QAPIGenCSnippet()
         self._visited_ret_types =3D {}
=20
     def _begin_module(self, name):
@@ -273,19 +273,20 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModular=
CVisitor):
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
 ''',
                        c_prefix=3Dc_name(self._prefix, protect=3DFalse))=
)
-        genc.add(gen_registry(self._regy, self._prefix))
+        genc.add(gen_registry(self._regy.get_content(), self._prefix))
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type,
                       gen, success_response, boxed, allow_oob):
         if not gen:
             return
-        self._genh.add(gen_command_decl(name, arg_type, boxed, ret_type)=
)
-        if ret_type and ret_type not in self._visited_ret_types[self._ge=
nc]:
-            self._visited_ret_types[self._genc].add(ret_type)
-            self._genc.add(gen_marshal_output(ret_type))
-        self._genh.add(gen_marshal_decl(name))
-        self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
-        self._regy +=3D gen_register_command(name, success_response, all=
ow_oob)
+        with ifcontext(ifcond, self._genh, self._genc, self._regy):
+            self._genh.add(gen_command_decl(name, arg_type, boxed, ret_t=
ype))
+            if ret_type and ret_type not in self._visited_ret_types[self=
._genc]:
+                self._visited_ret_types[self._genc].add(ret_type)
+                self._genc.add(gen_marshal_output(ret_type))
+            self._genh.add(gen_marshal_decl(name))
+            self._genc.add(gen_marshal(name, arg_type, boxed, ret_type))
+            self._regy.add(gen_register_command(name, success_response, =
allow_oob))
=20
=20
 def gen_commands(schema, output_dir, prefix):
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index c25fc2100a..e675722593 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -12,11 +12,11 @@
=20
 static QmpCommandList qmp_commands;
=20
-/* #if defined(TEST_IF_STRUCT) && defined(TEST_IF_CMD) */
+#if defined(TEST_IF_STRUCT) && defined(TEST_IF_CMD)
 void qmp_TestIfCmd(TestIfStruct *foo, Error **errp)
 {
 }
-/* #endif */
+#endif
=20
 void qmp_user_def_cmd(Error **errp)
 {
--=20
2.16.2.521.g9aa15f885a

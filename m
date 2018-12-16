Received: from eggs.gnu.org ([2001:4830:134:3::10]:32874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gYX6k-0001B4-1s
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:09:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gYX6f-0004tF-3H
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:09:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gYX6e-0004st-Qy
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:09:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37DE75F72C
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 14:09:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Dec 2018 18:08:52 +0400
Message-Id: <20181216140902.23986-4-marcandre.lureau@redhat.com>
In-Reply-To: <20181216140902.23986-1-marcandre.lureau@redhat.com>
References: <20181216140902.23986-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/13] qapi-commands: rename init_marshal() to
 register_commands()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

The function only calls various register_command() now, use a more
descriptive name.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/commands.py     | 4 ++--
 monitor.c                    | 2 +-
 qga/main.c                   | 2 +-
 tests/test-qmp-cmds.c        | 2 +-
 docs/devel/qapi-code-gen.txt | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index a9b2ecb304..94313b8aef 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -220,7 +220,7 @@ def gen_register_command(name, success_response, allo=
w_oob, allow_preconfig):
 def gen_registry(registry, prefix):
     ret =3D mcgen('''
=20
-void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)
+void %(c_prefix)sqmp_register_commands(QmpCommandList *cmds)
 {
 ''',
                 c_prefix=3Dc_name(prefix, protect=3DFalse))
@@ -270,7 +270,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModularCV=
isitor):
     def visit_end(self):
         (genc, genh) =3D self._module[self._main_module]
         genh.add(mcgen('''
-void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
+void %(c_prefix)sqmp_register_commands(QmpCommandList *cmds);
 ''',
                        c_prefix=3Dc_name(self._prefix, protect=3DFalse))=
)
         genc.add(gen_registry(self._regy.get_content(), self._prefix))
diff --git a/monitor.c b/monitor.c
index 30e8926002..720d8d98a7 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1182,7 +1182,7 @@ static void monitor_init_qmp_commands(void)
      */
=20
     QTAILQ_INIT(&qmp_commands);
-    qmp_init_marshal(&qmp_commands);
+    qmp_register_commands(&qmp_commands);
=20
     qmp_register_command(&qmp_commands, "query-qmp-schema",
                          qmp_query_qmp_schema, QCO_ALLOW_PRECONFIG);
diff --git a/qga/main.c b/qga/main.c
index 1d6c1024c9..75496fa793 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1487,7 +1487,7 @@ int main(int argc, char **argv)
     config->log_level =3D G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL;
=20
     QTAILQ_INIT(&ga_commands);
-    qga_qmp_init_marshal(&ga_commands);
+    qga_qmp_register_commands(&ga_commands);
=20
     init_dfl_pathnames();
     config_load(config);
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index bbd52cfb69..039ffcc6a9 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -326,7 +326,7 @@ int main(int argc, char **argv)
     g_test_add_func("/qmp/dealloc_partial", test_dealloc_partial);
=20
     QTAILQ_INIT(&qmp_commands);
-    test_qmp_init_marshal(&qmp_commands);
+    test_qmp_register_commands(&qmp_commands);
     g_test_run();
=20
     return 0;
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 681177dec1..79a38c21e6 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1271,7 +1271,7 @@ Example:
=20
     UserDefOne *qmp_my_command(UserDefOneList *arg1, Error **errp);
     void qmp_marshal_my_command(QDict *args, QObject **ret, Error **errp=
);
-    void example_qmp_init_marshal(QmpCommandList *cmds);
+    void example_qmp_register_commands(QmpCommandList *cmds);
=20
     #endif /* EXAMPLE_QAPI_COMMANDS_H */
     $ cat qapi-generated/example-qapi-commands.c
@@ -1332,7 +1332,7 @@ Example:
         visit_free(v);
     }
=20
-    void example_qmp_init_marshal(QmpCommandList *cmds)
+    void example_qmp_register_commands(QmpCommandList *cmds)
     {
         qmp_register_command(cmds, "my-command",
                              qmp_marshal_my_command, QCO_NO_OPTIONS);
--=20
2.20.0

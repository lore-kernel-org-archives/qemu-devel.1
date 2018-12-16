Received: from eggs.gnu.org ([2001:4830:134:3::10]:32801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gYX6b-00014a-BK
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gYX6a-0004nG-Ey
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:09:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gYX6a-0004mU-9J
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:09:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2A85C0270B0
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 14:09:15 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Dec 2018 18:08:51 +0400
Message-Id: <20181216140902.23986-3-marcandre.lureau@redhat.com>
In-Reply-To: <20181216140902.23986-1-marcandre.lureau@redhat.com>
References: <20181216140902.23986-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/13] qapi-commands: don't initialize command
 list in qmp_init_marshall()
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

This will let the caller add several list of commands coming from
different schemas (the following patches split the schemas for common
and arch-specific parts).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/commands.py     | 2 --
 monitor.c                    | 1 +
 qga/main.c                   | 1 +
 tests/test-qmp-cmds.c        | 1 +
 docs/devel/qapi-code-gen.txt | 2 --
 5 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 0f3c991918..a9b2ecb304 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -222,8 +222,6 @@ def gen_registry(registry, prefix):
=20
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)
 {
-    QTAILQ_INIT(cmds);
-
 ''',
                 c_prefix=3Dc_name(prefix, protect=3DFalse))
     ret +=3D registry
diff --git a/monitor.c b/monitor.c
index 7848a3cb0d..30e8926002 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1181,6 +1181,7 @@ static void monitor_init_qmp_commands(void)
      *   "qmp_capabilities", to enforce capability negotiation
      */
=20
+    QTAILQ_INIT(&qmp_commands);
     qmp_init_marshal(&qmp_commands);
=20
     qmp_register_command(&qmp_commands, "query-qmp-schema",
diff --git a/qga/main.c b/qga/main.c
index 87a0711c14..1d6c1024c9 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1486,6 +1486,7 @@ int main(int argc, char **argv)
=20
     config->log_level =3D G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL;
=20
+    QTAILQ_INIT(&ga_commands);
     qga_qmp_init_marshal(&ga_commands);
=20
     init_dfl_pathnames();
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 481cb069ca..bbd52cfb69 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -325,6 +325,7 @@ int main(int argc, char **argv)
     g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
     g_test_add_func("/qmp/dealloc_partial", test_dealloc_partial);
=20
+    QTAILQ_INIT(&qmp_commands);
     test_qmp_init_marshal(&qmp_commands);
     g_test_run();
=20
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 43bd853e69..681177dec1 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1334,8 +1334,6 @@ Example:
=20
     void example_qmp_init_marshal(QmpCommandList *cmds)
     {
-        QTAILQ_INIT(cmds);
-
         qmp_register_command(cmds, "my-command",
                              qmp_marshal_my_command, QCO_NO_OPTIONS);
     }
--=20
2.20.0

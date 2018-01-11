Received: from eggs.gnu.org ([2001:4830:134:3::10]:51818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkX5-00087o-5S
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkX0-0005oF-6G
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkX0-0005mk-01
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:02 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:39 +0100
Message-Id: <20180111213250.16511-41-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 40/51] qapi-commands: don't initialize
 command list in qmp_init_marshall()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

This will let the caller add several list of commands coming from
different schemas (the following patches split the schemas for common
and arch-specific parts).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi-commands.py  | 2 --
 monitor.c                 | 1 +
 qga/main.c                | 1 +
 tests/test-qmp-commands.c | 1 +
 4 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 8af8d913b9..7455d2b8bb 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -211,8 +211,6 @@ def gen_registry(registry):
=20
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)
 {
-    QTAILQ_INIT(cmds);
-
 ''',
                 c_prefix=3Dc_name(prefix, protect=3DFalse))
     ret +=3D registry
diff --git a/monitor.c b/monitor.c
index c3a1a4ea6c..f5ffffa786 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1001,6 +1001,7 @@ void monitor_init_qmp_commands(void)
      *   "qmp_capabilities", to enforce capability negotiation
      */
=20
+    QTAILQ_INIT(&qmp_commands);
     qmp_init_marshal(&qmp_commands);
=20
     qmp_register_command(&qmp_commands, "query-qmp-schema",
diff --git a/qga/main.c b/qga/main.c
index 62a62755bd..b949b1ccb0 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1360,6 +1360,7 @@ int main(int argc, char **argv)
=20
     config->log_level =3D G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL;
=20
+    QTAILQ_INIT(&ga_commands);
     qga_qmp_init_marshal(&ga_commands);
=20
     init_dfl_pathnames();
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index ad7b6e4e1d..28ce88e012 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -283,6 +283,7 @@ int main(int argc, char **argv)
     g_test_add_func("/0.15/dealloc_types", test_dealloc_types);
     g_test_add_func("/0.15/dealloc_partial", test_dealloc_partial);
=20
+    QTAILQ_INIT(&qmp_commands);
     test_qmp_init_marshal(&qmp_commands);
     g_test_run();
=20
--=20
2.16.0.rc1.1.gef27df75a1

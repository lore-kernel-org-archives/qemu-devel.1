Received: from eggs.gnu.org ([2001:4830:134:3::10]:49014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJZ-0006dO-MW
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJW-00005r-Qe
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53278 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycJW-00005T-Mb
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 376B94001852
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:53:54 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:52:01 +0100
Message-Id: <20180321115211.17937-40-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 39/49] qapi-commands: don't initialize
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This will let the caller add several list of commands coming from
different schemas (the following patches split the schemas for common
and arch-specific parts).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/commands.py | 2 --
 monitor.c                | 1 +
 qga/main.c               | 1 +
 tests/test-qmp-cmds.c    | 1 +
 4 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 40bb680b7c..3d3e97f737 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -220,8 +220,6 @@ def gen_registry(registry, prefix):
=20
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)
 {
-    QTAILQ_INIT(cmds);
-
 ''',
                 c_prefix=3Dc_name(prefix, protect=3DFalse))
     ret +=3D registry
diff --git a/monitor.c b/monitor.c
index 88e6fd2e6f..0d84c3edb4 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1121,6 +1121,7 @@ static void monitor_init_qmp_commands(void)
      *   "qmp_capabilities", to enforce capability negotiation
      */
=20
+    QTAILQ_INIT(&qmp_commands);
     qmp_init_marshal(&qmp_commands);
=20
     qmp_register_command(&qmp_commands, "query-qmp-schema",
diff --git a/qga/main.c b/qga/main.c
index df1888edc1..6905c82b6c 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1364,6 +1364,7 @@ int main(int argc, char **argv)
=20
     config->log_level =3D G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL;
=20
+    QTAILQ_INIT(&ga_commands);
     qga_qmp_init_marshal(&ga_commands);
=20
     init_dfl_pathnames();
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index e675722593..e723b440ca 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -285,6 +285,7 @@ int main(int argc, char **argv)
     g_test_add_func("/0.15/dealloc_types", test_dealloc_types);
     g_test_add_func("/0.15/dealloc_partial", test_dealloc_partial);
=20
+    QTAILQ_INIT(&qmp_commands);
     test_qmp_init_marshal(&qmp_commands);
     g_test_run();
=20
--=20
2.16.2.521.g9aa15f885a

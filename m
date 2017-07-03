Received: from eggs.gnu.org ([2001:4830:134:3::10]:51115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dRzit-0004WE-66
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dRzio-0004jV-9x
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:40:59 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dRzio-0004j2-3D
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:40:54 -0400
Received: by mail-wm0-f42.google.com with SMTP id i127so105574014wma.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 04:40:53 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Mon,  3 Jul 2017 13:40:47 +0200
Message-Id: <217e64d171636218b61c41f1f70e72cdb40f9144.1499082038.git.tgolembi@redhat.com>
In-Reply-To: <cover.1499082038.git.tgolembi@redhat.com>
References: <cover.1499082038.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 2/3] test-qga: pass environemnt to qemu-ga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

Modify fixture_setup() to pass environemnt variables to spawned qemu-ga
instance.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 tests/test-qga.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/test-qga.c b/tests/test-qga.c
index c77f241036..631b98639a 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -46,7 +46,7 @@ static void qga_watch(GPid pid, gint status, gpointer user_data)
 }
 
 static void
-fixture_setup(TestFixture *fixture, gconstpointer data)
+fixture_setup(TestFixture *fixture, gconstpointer data, gchar **envp)
 {
     const gchar *extra_arg = data;
     GError *error = NULL;
@@ -67,7 +67,7 @@ fixture_setup(TestFixture *fixture, gconstpointer data)
     g_shell_parse_argv(cmd, NULL, &argv, &error);
     g_assert_no_error(error);
 
-    g_spawn_async(fixture->test_dir, argv, NULL,
+    g_spawn_async(fixture->test_dir, argv, envp,
                   G_SPAWN_SEARCH_PATH|G_SPAWN_DO_NOT_REAP_CHILD,
                   NULL, NULL, &fixture->pid, &error);
     g_assert_no_error(error);
@@ -707,7 +707,7 @@ static void test_qga_blacklist(gconstpointer data)
     QDict *ret, *error;
     const gchar *class, *desc;
 
-    fixture_setup(&fix, "-b guest-ping,guest-get-time");
+    fixture_setup(&fix, "-b guest-ping,guest-get-time", NULL);
 
     /* check blacklist */
     ret = qmp_fd(fix.fd, "{'execute': 'guest-ping'}");
@@ -943,7 +943,7 @@ int main(int argc, char **argv)
 
     setlocale (LC_ALL, "");
     g_test_init(&argc, &argv, NULL);
-    fixture_setup(&fix, NULL);
+    fixture_setup(&fix, NULL, NULL);
 
     g_test_add_data_func("/qga/sync-delimited", &fix, test_qga_sync_delimited);
     g_test_add_data_func("/qga/sync", &fix, test_qga_sync);
-- 
2.13.1

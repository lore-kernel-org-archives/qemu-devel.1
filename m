Received: from eggs.gnu.org ([2001:4830:134:3::10]:46714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gP3ea-00067L-8R
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:53:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gP3eZ-0008MF-Ib
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:53:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gP3eZ-0008Jv-B9
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:53:11 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 20 Nov 2018 11:52:23 +0100
Message-Id: <1542711143-1946-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1542711143-1946-1-git-send-email-thuth@redhat.com>
References: <1542711143-1946-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] qtest: log QEMU command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Record the command line that was used to start QEMU.  This can be
useful for debugging.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
[thuth: removed trailing \n from the message string]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqtest.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 44ce118..75e07e1 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -215,24 +215,28 @@ QTestState *qtest_init_without_qmp_handshake(bool use_oob,
 
     qtest_add_abrt_handler(kill_qemu_hook_func, s);
 
+    command = g_strdup_printf("exec %s "
+                              "-qtest unix:%s,nowait "
+                              "-qtest-log %s "
+                              "-chardev socket,path=%s,nowait,id=char0 "
+                              "-mon chardev=char0,mode=control%s "
+                              "-machine accel=qtest "
+                              "-display none "
+                              "%s", qemu_binary, socket_path,
+                              getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/null",
+                              qmp_socket_path, use_oob ? ",x-oob=on" : "",
+                              extra_args ?: "");
+
+    g_test_message("starting QEMU: %s", command);
+
     s->qemu_pid = fork();
     if (s->qemu_pid == 0) {
         setenv("QEMU_AUDIO_DRV", "none", true);
-        command = g_strdup_printf("exec %s "
-                                  "-qtest unix:%s,nowait "
-                                  "-qtest-log %s "
-                                  "-chardev socket,path=%s,nowait,id=char0 "
-                                  "-mon chardev=char0,mode=control%s "
-                                  "-machine accel=qtest "
-                                  "-display none "
-                                  "%s", qemu_binary, socket_path,
-                                  getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/null",
-                                  qmp_socket_path, use_oob ? ",x-oob=on" : "",
-                                  extra_args ?: "");
         execlp("/bin/sh", "sh", "-c", command, NULL);
         exit(1);
     }
 
+    g_free(command);
     s->fd = socket_accept(sock);
     if (s->fd >= 0) {
         s->qmp_fd = socket_accept(qmpsock);
-- 
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gNGmM-00046w-BK
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gNGmA-0003mQ-Af
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:29:50 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:34134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gNGmA-0003jF-2U
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:29:38 -0500
Received: by mail-wr1-x429.google.com with SMTP id j26-v6so21030994wre.1
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 04:29:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Nov 2018 13:29:30 +0100
Message-Id: <20181115122930.25732-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1?] qtest: log QEMU command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com

Record the command line that was used to start QEMU.  This can be
useful for debugging.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/libqtest.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 44ce118cfc..f6e061da44 100644
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
+    g_test_message("starting QEMU: %s\n", command);
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
2.19.1

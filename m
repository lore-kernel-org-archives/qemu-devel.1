Received: from eggs.gnu.org ([2001:4830:134:3::10]:52444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFm-0001rd-Cm
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFh-00060L-Js
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqFh-0005zo-CO
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:17 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:06 +0100
Message-Id: <1543851204-41186-54-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 53/71] vhost-user-test: always use 256 MiB of
 guest memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>

Some tests are using a small amount of RAM for the guest (2 MiB) in order to
save host memory, others are using 512 MiB.

However, pSeries machines only support multiples of 256 MiB.  Using 256
MiB of memory does not use more host memory than now, even for the
migration test that starts two guests, and it allows running the test on
pSeries too.

This of course is not optimal, it would be nice to let the qgraph machine object
judge how much memory to provide.  This is left for future work, together
with a more generic framework that wraps the QEMU command line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 0c9a79a..f135052 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -694,7 +694,7 @@ static void test_read_guest_mem(const void *arg)
                              "read-guest-memfd" : "read-guest-mem");
     test_server_listen(server);
 
-    qemu_cmd = get_qemu_cmd(server, 512, memfd, "", "");
+    qemu_cmd = get_qemu_cmd(server, 256, memfd, "", "");
 
     s = qtest_start(qemu_cmd);
     g_free(qemu_cmd);
@@ -729,7 +729,7 @@ static void test_migrate(void)
     test_server_listen(s);
     test_server_listen(dest);
 
-    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, "", "");
+    cmd = get_qemu_cmd(s, 256, TEST_MEMFD_AUTO, "", "");
     from = qtest_start(cmd);
     g_free(cmd);
 
@@ -739,10 +739,10 @@ static void test_migrate(void)
     }
 
     size = get_log_size(s);
-    g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));
+    g_assert_cmpint(size, ==, (256 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));
 
     tmp = g_strdup_printf(" -incoming %s", uri);
-    cmd = get_qemu_cmd(dest, 2, TEST_MEMFD_AUTO, "", tmp);
+    cmd = get_qemu_cmd(dest, 256, TEST_MEMFD_AUTO, "", tmp);
     g_free(tmp);
     to = qtest_init(cmd);
     g_free(cmd);
@@ -852,7 +852,7 @@ static void test_reconnect_subprocess(void)
     char *cmd;
 
     g_thread_new("connect", connect_thread, s);
-    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, ",server", "");
+    cmd = get_qemu_cmd(s, 256, TEST_MEMFD_AUTO, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
 
@@ -894,7 +894,7 @@ static void test_connect_fail_subprocess(void)
 
     s->test_fail = true;
     g_thread_new("connect", connect_thread, s);
-    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, ",server", "");
+    cmd = get_qemu_cmd(s, 256, TEST_MEMFD_AUTO, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
 
@@ -927,7 +927,7 @@ static void test_flags_mismatch_subprocess(void)
 
     s->test_flags = TEST_FLAGS_DISCONNECT;
     g_thread_new("connect", connect_thread, s);
-    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, ",server", "");
+    cmd = get_qemu_cmd(s, 256, TEST_MEMFD_AUTO, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
 
@@ -968,14 +968,14 @@ static void test_multiqueue(void)
         cmd = g_strdup_printf(
             QEMU_CMD_MEMFD QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=%d "
             "-device virtio-net-pci,netdev=net0,mq=on,vectors=%d",
-            512, 512, s->chr_name,
+            256, 256, s->chr_name,
             s->socket_path, "", s->chr_name,
             s->queues, s->queues * 2 + 2);
     } else {
         cmd = g_strdup_printf(
             QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=%d "
             "-device virtio-net-pci,netdev=net0,mq=on,vectors=%d",
-            512, 512, s->mem_path, s->chr_name,
+            256, 256, s->mem_path, s->chr_name,
             s->socket_path, "", s->chr_name,
             s->queues, s->queues * 2 + 2);
     }
-- 
1.8.3.1

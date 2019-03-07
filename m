Received: from eggs.gnu.org ([209.51.188.92]:39823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wr6-0003Yt-F7
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wr5-0008Np-Gk
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:52 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:45220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wr5-0008Mx-8O
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:51 -0500
Received: by mail-wr1-x436.google.com with SMTP id w17so18399344wrn.12
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:51 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:46 +0100
Message-Id: <1551979804-6060-40-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 39/57] vhost-user-test: always use 256 MiB of
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
Cc: thuth@redhat.com, lviver@redhat.com

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
index b1414e2..2a67a99 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -704,7 +704,7 @@ static void test_read_guest_mem(const void *arg)
                              "read-guest-memfd" : "read-guest-mem");
     test_server_listen(server);
 
-    qemu_cmd = get_qemu_cmd(server, 512, memfd, "", "");
+    qemu_cmd = get_qemu_cmd(server, 256, memfd, "", "");
 
     s = qtest_start(qemu_cmd);
     g_free(qemu_cmd);
@@ -739,7 +739,7 @@ static void test_migrate(void)
     test_server_listen(s);
     test_server_listen(dest);
 
-    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, "", "");
+    cmd = get_qemu_cmd(s, 256, TEST_MEMFD_AUTO, "", "");
     from = qtest_start(cmd);
     g_free(cmd);
 
@@ -749,10 +749,10 @@ static void test_migrate(void)
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
@@ -863,7 +863,7 @@ static void test_reconnect_subprocess(void)
     char *cmd;
 
     g_thread_new("connect", connect_thread, s);
-    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, ",server", "");
+    cmd = get_qemu_cmd(s, 256, TEST_MEMFD_AUTO, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
 
@@ -908,7 +908,7 @@ static void test_connect_fail_subprocess(void)
 
     s->test_fail = true;
     g_thread_new("connect", connect_thread, s);
-    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, ",server", "");
+    cmd = get_qemu_cmd(s, 256, TEST_MEMFD_AUTO, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
 
@@ -941,7 +941,7 @@ static void test_flags_mismatch_subprocess(void)
 
     s->test_flags = TEST_FLAGS_DISCONNECT;
     g_thread_new("connect", connect_thread, s);
-    cmd = get_qemu_cmd(s, 2, TEST_MEMFD_AUTO, ",server", "");
+    cmd = get_qemu_cmd(s, 256, TEST_MEMFD_AUTO, ",server", "");
     qtest_start(cmd);
     g_free(cmd);
 
@@ -982,14 +982,14 @@ static void test_multiqueue(void)
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

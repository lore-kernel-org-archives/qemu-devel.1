Received: from eggs.gnu.org ([2001:4830:134:3::10]:52844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6NA-0001Op-O3
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6N6-0000hT-Ix
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:28 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:55389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6N6-0000a7-9w
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:24 -0500
Received: by mail-wm1-x329.google.com with SMTP id y139so6134870wmc.5
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:24:13 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.24.11 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:24:12 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:23:12 +0100
Message-Id: <1544628195-37728-52-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 51/54] vhost-user-test: reduce usage of
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Whenever the code can run on multiple QTestStates, use them explicitly instead of
global_qtest.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1543851204-41186-12-git-send-email-pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 59e1aec..c3a8af3 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -187,12 +187,12 @@ static char *get_qemu_cmd(TestServer *s,
     }
 }
 
-static void init_virtio_dev(TestServer *s, uint32_t features_mask)
+static void init_virtio_dev(QTestState *qts, TestServer *s, uint32_t features_mask)
 {
     uint32_t features;
     int i;
 
-    s->bus = qpci_init_pc(global_qtest, NULL);
+    s->bus = qpci_init_pc(qts, NULL);
     g_assert_nonnull(s->bus);
 
     s->dev = qvirtio_pci_device_find(s->bus, VIRTIO_ID_NET);
@@ -203,7 +203,7 @@ static void init_virtio_dev(TestServer *s, uint32_t features_mask)
     qvirtio_set_acknowledge(&s->dev->vdev);
     qvirtio_set_driver(&s->dev->vdev);
 
-    s->alloc = pc_alloc_init(global_qtest);
+    s->alloc = pc_alloc_init(qts);
 
     for (i = 0; i < s->queues * 2; i++) {
         s->vq[i] = qvirtqueue_setup(&s->dev->vdev, s->alloc, i);
@@ -265,7 +265,7 @@ static bool wait_for_fds(TestServer *s)
     return got_region;
 }
 
-static void read_guest_mem_server(TestServer *s)
+static void read_guest_mem_server(QTestState *qts, TestServer *s)
 {
     uint8_t *guest_mem;
     int i, j;
@@ -293,7 +293,7 @@ static void read_guest_mem_server(TestServer *s)
         guest_mem += (s->memory.regions[i].mmap_offset / sizeof(*guest_mem));
 
         for (j = 0; j < 1024; j++) {
-            uint32_t a = readb(s->memory.regions[i].guest_phys_addr + j);
+            uint32_t a = qtest_readb(qts, s->memory.regions[i].guest_phys_addr + j);
             uint32_t b = guest_mem[j];
 
             g_assert_cmpint(a, ==, b);
@@ -670,13 +670,13 @@ static void test_read_guest_mem(const void *arg)
     s = qtest_start(qemu_cmd);
     g_free(qemu_cmd);
 
-    init_virtio_dev(server, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(global_qtest, server, 1u << VIRTIO_NET_F_MAC);
 
     if (!wait_for_fds(server)) {
         goto exit;
     }
 
-    read_guest_mem_server(server);
+    read_guest_mem_server(global_qtest, server);
 
 exit:
     uninit_virtio_dev(server);
@@ -690,7 +690,7 @@ static void test_migrate(void)
     TestServer *s = test_server_new("src");
     TestServer *dest = test_server_new("dest");
     char *uri = g_strdup_printf("%s%s", "unix:", dest->mig_path);
-    QTestState *global = global_qtest, *from, *to;
+    QTestState *from, *to;
     GSource *source;
     gchar *cmd, *tmp;
     QDict *rsp;
@@ -704,7 +704,7 @@ static void test_migrate(void)
     from = qtest_start(cmd);
     g_free(cmd);
 
-    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(from, s, 1u << VIRTIO_NET_F_MAC);
     if (!wait_for_fds(s)) {
         goto exit;
     }
@@ -717,7 +717,7 @@ static void test_migrate(void)
     g_free(tmp);
     to = qtest_init(cmd);
     g_free(cmd);
-    init_virtio_dev(dest, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(to, dest, 1u << VIRTIO_NET_F_MAC);
 
     source = g_source_new(&test_migrate_source_funcs,
                           sizeof(TestMigrateSource));
@@ -753,12 +753,10 @@ static void test_migrate(void)
     qobject_unref(rsp);
 
     qmp_eventwait("STOP");
+    qtest_qmp_eventwait(to, "RESUME");
 
-    global_qtest = to;
-    qmp_eventwait("RESUME");
-
-    g_assert(wait_for_fds(s));
-    read_guest_mem_server(dest);
+    g_assert(wait_for_fds(dest));
+    read_guest_mem_server(to, dest);
 
     uninit_virtio_dev(dest);
     qtest_quit(to);
@@ -773,8 +771,6 @@ exit:
     qtest_quit(from);
     test_server_free(s);
     g_free(uri);
-
-    global_qtest = global;
 }
 
 static void wait_for_rings_started(TestServer *s, size_t count)
@@ -831,7 +827,7 @@ static void test_reconnect_subprocess(void)
     qtest_start(cmd);
     g_free(cmd);
 
-    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(global_qtest, s, 1u << VIRTIO_NET_F_MAC);
     if (!wait_for_fds(s)) {
         goto exit;
     }
@@ -873,7 +869,7 @@ static void test_connect_fail_subprocess(void)
     qtest_start(cmd);
     g_free(cmd);
 
-    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(global_qtest, s, 1u << VIRTIO_NET_F_MAC);
     if (!wait_for_fds(s)) {
         goto exit;
     }
@@ -906,7 +902,7 @@ static void test_flags_mismatch_subprocess(void)
     qtest_start(cmd);
     g_free(cmd);
 
-    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(global_qtest, s, 1u << VIRTIO_NET_F_MAC);
     if (!wait_for_fds(s)) {
         goto exit;
     }
@@ -957,7 +953,7 @@ static void test_multiqueue(void)
     qtest_start(cmd);
     g_free(cmd);
 
-    init_virtio_dev(s, features_mask);
+    init_virtio_dev(global_qtest, s, features_mask);
 
     wait_for_rings_started(s, s->queues * 2);
 
-- 
1.8.3.1

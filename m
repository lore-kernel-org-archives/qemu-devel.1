Received: from eggs.gnu.org ([209.51.188.92]:59329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj6t-00054N-8K
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj6q-0003VM-S3
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:47 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:45422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj6q-0003IC-9f
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:44 -0500
Received: by mail-wr1-x42a.google.com with SMTP id q15so907472wro.12
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:36:26 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	s132sm8836236wmf.28.2019.02.04.10.36.24 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 Feb 2019 10:36:24 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:35:07 +0100
Message-Id: <1549305379-51117-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/77] vhost-user-test: skip if there is no
 memory at address 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The virt machine cannot run the vhost-user qtests because they hardcode
the presence of memory at address 0.  Report the tests as a skip so that
they can be converted to use qgraph.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1543851204-41186-11-git-send-email-pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 58 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 13 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index a4f51b5..a0da5c3 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -228,9 +228,11 @@ static void uninit_virtio_dev(TestServer *s)
     qvirtio_pci_device_free(s->dev);
 }
 
-static void wait_for_fds(TestServer *s)
+static bool wait_for_fds(TestServer *s)
 {
     gint64 end_time;
+    bool got_region;
+    int i;
 
     g_mutex_lock(&s->data_mutex);
 
@@ -248,6 +250,19 @@ static void wait_for_fds(TestServer *s)
     g_assert_cmpint(s->fds_num, ==, s->memory.nregions);
 
     g_mutex_unlock(&s->data_mutex);
+
+    got_region = false;
+    for (i = 0; i < s->memory.nregions; ++i) {
+        VhostUserMemoryRegion *reg = &s->memory.regions[i];
+        if (reg->guest_phys_addr == 0) {
+            got_region = true;
+            break;
+        }
+    }
+    if (!got_region) {
+        g_test_skip("No memory at address 0x0");
+    }
+    return got_region;
 }
 
 static void read_guest_mem_server(TestServer *s)
@@ -256,8 +271,6 @@ static void read_guest_mem_server(TestServer *s)
     int i, j;
     size_t size;
 
-    wait_for_fds(s);
-
     g_mutex_lock(&s->data_mutex);
 
     /* iterate all regions */
@@ -577,8 +590,6 @@ static void write_guest_mem(TestServer *s, uint32_t seed)
     int i, j;
     size_t size;
 
-    wait_for_fds(s);
-
     /* iterate all regions */
     for (i = 0; i < s->fds_num; i++) {
 
@@ -661,8 +672,13 @@ static void test_read_guest_mem(const void *arg)
 
     init_virtio_dev(server, 1u << VIRTIO_NET_F_MAC);
 
+    if (!wait_for_fds(server)) {
+        goto exit;
+    }
+
     read_guest_mem_server(server);
 
+exit:
     uninit_virtio_dev(server);
 
     qtest_quit(s);
@@ -689,8 +705,10 @@ static void test_migrate(void)
     g_free(cmd);
 
     init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
-    init_virtio_dev(dest, 1u << VIRTIO_NET_F_MAC);
-    wait_for_fds(s);
+    if (!wait_for_fds(s)) {
+        goto exit;
+    }
+
     size = get_log_size(s);
     g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));
 
@@ -699,6 +717,7 @@ static void test_migrate(void)
     g_free(tmp);
     to = qtest_init(cmd);
     g_free(cmd);
+    init_virtio_dev(dest, 1u << VIRTIO_NET_F_MAC);
 
     source = g_source_new(&test_migrate_source_funcs,
                           sizeof(TestMigrateSource));
@@ -738,15 +757,18 @@ static void test_migrate(void)
     global_qtest = to;
     qmp_eventwait("RESUME");
 
+    g_assert(wait_for_fds(s));
     read_guest_mem_server(dest);
 
-    uninit_virtio_dev(s);
     uninit_virtio_dev(dest);
+    qtest_quit(to);
 
     g_source_destroy(source);
     g_source_unref(source);
 
-    qtest_quit(to);
+exit:
+    uninit_virtio_dev(s);
+
     test_server_free(dest);
     qtest_quit(from);
     test_server_free(s);
@@ -810,16 +832,20 @@ static void test_reconnect_subprocess(void)
     g_free(cmd);
 
     init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
-    wait_for_fds(s);
+    if (!wait_for_fds(s)) {
+        goto exit;
+    }
+
     wait_for_rings_started(s, 2);
 
     /* reconnect */
     s->fds_num = 0;
     s->rings = 0;
     g_idle_add(reconnect_cb, s);
-    wait_for_fds(s);
+    g_assert(wait_for_fds(s));
     wait_for_rings_started(s, 2);
 
+exit:
     uninit_virtio_dev(s);
 
     qtest_end();
@@ -848,9 +874,12 @@ static void test_connect_fail_subprocess(void)
     g_free(cmd);
 
     init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
-    wait_for_fds(s);
+    if (!wait_for_fds(s)) {
+        goto exit;
+    }
     wait_for_rings_started(s, 2);
 
+exit:
     uninit_virtio_dev(s);
 
     qtest_end();
@@ -878,9 +907,12 @@ static void test_flags_mismatch_subprocess(void)
     g_free(cmd);
 
     init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
-    wait_for_fds(s);
+    if (!wait_for_fds(s)) {
+        goto exit;
+    }
     wait_for_rings_started(s, 2);
 
+exit:
     uninit_virtio_dev(s);
 
     qtest_end();
-- 
1.8.3.1

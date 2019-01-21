Received: from eggs.gnu.org ([209.51.188.92]:51595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldy3-0004If-Rf
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldy1-00044I-RS
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:39 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:39488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldy1-00041t-Hn
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:37 -0500
Received: by mail-wm1-x334.google.com with SMTP id y8so11690349wmi.4
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:06:36 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	133sm56197732wme.9.2019.01.21.10.06.34 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 21 Jan 2019 10:06:34 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:05:43 +0100
Message-Id: <1548093980-43088-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/49] vhost-user-test: skip if there is no
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
index e36f3e6..30b0aba 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -231,9 +231,11 @@ static void uninit_virtio_dev(TestServer *s)
     qvirtio_pci_device_free(s->dev);
 }
 
-static void wait_for_fds(TestServer *s)
+static bool wait_for_fds(TestServer *s)
 {
     gint64 end_time;
+    bool got_region;
+    int i;
 
     g_mutex_lock(&s->data_mutex);
 
@@ -251,6 +253,19 @@ static void wait_for_fds(TestServer *s)
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
@@ -259,8 +274,6 @@ static void read_guest_mem_server(TestServer *s)
     int i, j;
     size_t size;
 
-    wait_for_fds(s);
-
     g_mutex_lock(&s->data_mutex);
 
     /* iterate all regions */
@@ -582,8 +595,6 @@ static void write_guest_mem(TestServer *s, uint32_t seed)
     int i, j;
     size_t size;
 
-    wait_for_fds(s);
-
     /* iterate all regions */
     for (i = 0; i < s->fds_num; i++) {
 
@@ -666,8 +677,13 @@ static void test_read_guest_mem(const void *arg)
 
     init_virtio_dev(server, 1u << VIRTIO_NET_F_MAC);
 
+    if (!wait_for_fds(server)) {
+        goto exit;
+    }
+
     read_guest_mem_server(server);
 
+exit:
     uninit_virtio_dev(server);
 
     qtest_quit(s);
@@ -694,8 +710,10 @@ static void test_migrate(void)
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
 
@@ -704,6 +722,7 @@ static void test_migrate(void)
     g_free(tmp);
     to = qtest_init(cmd);
     g_free(cmd);
+    init_virtio_dev(dest, 1u << VIRTIO_NET_F_MAC);
 
     source = g_source_new(&test_migrate_source_funcs,
                           sizeof(TestMigrateSource));
@@ -743,15 +762,18 @@ static void test_migrate(void)
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
@@ -815,16 +837,20 @@ static void test_reconnect_subprocess(void)
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
@@ -853,9 +879,12 @@ static void test_connect_fail_subprocess(void)
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
@@ -883,9 +912,12 @@ static void test_flags_mismatch_subprocess(void)
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

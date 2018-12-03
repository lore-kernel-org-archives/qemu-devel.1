Received: from eggs.gnu.org ([2001:4830:134:3::10]:52446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFm-0001rq-KL
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFk-000631-Ih
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqFk-00062H-AH
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:20 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:07 +0100
Message-Id: <1543851204-41186-55-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 54/71] qos-test: vhost-user test node
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

Convert tests/virtio-net-test in qgraph test node,
virtio-net-test. This test consumes a virtio-net interface
and checks that its function return the expected values.

Note that this test does not allocate any virtio-net structure,
it's all done by the qtest walking graph mechanism.  Nevertheless,
vhost-user-test is a bit more complex than the other tests, because
it requires more complicated setup of back-ends and thus almost each
test has a slightly different opts.before function.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include  |   5 +-
 tests/vhost-user-test.c | 378 +++++++++++++++++++-----------------------------
 2 files changed, 150 insertions(+), 233 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index d300f60..070d93e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -192,7 +192,6 @@ check-qtest-i386-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
 check-qtest-i386-y += tests/cpu-plug-test$(EXESUF)
 check-qtest-i386-y += tests/q35-test$(EXESUF)
 check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
-check-qtest-i386-$(CONFIG_VHOST_NET_USER) += tests/vhost-user-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-swtpm-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM_TIS) += tests/tpm-tis-swtpm-test$(EXESUF)
@@ -686,6 +685,7 @@ qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
 qos-test-obj-y += tests/e1000e-test.o
 qos-test-obj-y += tests/pci-test.o
 qos-test-obj-y += tests/sdhci-test.o
+qos-test-obj-$(CONFIG_VHOST_NET_USER) += tests/vhost-user-test.o $(chardev-obj-y) $(test-io-obj-y)
 qos-test-obj-y += tests/virtio-test.o
 qos-test-obj-y += tests/virtio-9p-test.o
 qos-test-obj-y += tests/virtio-blk-test.o
@@ -758,9 +758,6 @@ tests/usb-hcd-ehci-test$(EXESUF): tests/usb-hcd-ehci-test.o $(libqos-usb-obj-y)
 tests/usb-hcd-xhci-test$(EXESUF): tests/usb-hcd-xhci-test.o $(libqos-usb-obj-y)
 tests/cpu-plug-test$(EXESUF): tests/cpu-plug-test.o
 tests/migration-test$(EXESUF): tests/migration-test.o
-tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o $(test-util-obj-y) \
-	$(qtest-obj-y) $(test-io-obj-y) $(libqos-virtio-obj-y) $(libqos-pc-obj-y) \
-	$(chardev-obj-y)
 tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_scm_helper.o
 tests/test-qemu-opts$(EXESUF): tests/test-qemu-opts.o $(test-util-obj-y)
 tests/test-keyval$(EXESUF): tests/test-keyval.o $(test-util-obj-y) $(test-qapi-obj-y)
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index f135052..1d22d8a 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -38,8 +38,7 @@
 #define QEMU_CMD_MEMFD  " -m %d -object memory-backend-memfd,id=mem,size=%dM," \
                         " -numa node,memdev=mem"
 #define QEMU_CMD_CHR    " -chardev socket,id=%s,path=%s%s"
-#define QEMU_CMD_NETDEV " -netdev vhost-user,id=net0,chardev=%s,vhostforce"
-#define QEMU_CMD_NET    " -device virtio-net-pci,netdev=net0"
+#define QEMU_CMD_NETDEV " -netdev vhost-user,id=hs0,chardev=%s,vhostforce"
 
 #define HUGETLBFS_MAGIC       0x958458f6
 
@@ -133,13 +132,9 @@ enum {
 };
 
 typedef struct TestServer {
-    QPCIBus *bus;
-    QVirtioPCIDevice *dev;
-    QVirtQueue *vq[VHOST_MAX_VIRTQUEUES];
     gchar *socket_path;
     gchar *mig_path;
     gchar *chr_name;
-    const gchar *mem_path;
     gchar *tmpfs;
     CharBackend chr;
     int fds_num;
@@ -154,9 +149,9 @@ typedef struct TestServer {
     bool test_fail;
     int test_flags;
     int queues;
-    QGuestAllocator alloc;
 } TestServer;
 
+static const char *init_hugepagefs(void);
 static TestServer *test_server_new(const gchar *name);
 static void test_server_free(TestServer *server);
 static void test_server_listen(TestServer *server);
@@ -167,64 +162,27 @@ enum test_memfd {
     TEST_MEMFD_NO,
 };
 
-static char *get_qemu_cmd(TestServer *s,
-                          int mem, enum test_memfd memfd,
-                          const char *chr_opts, const char *extra)
+static void append_vhost_opts(TestServer *s, GString *cmd_line,
+                             const char *chr_opts)
 {
-    if (memfd == TEST_MEMFD_AUTO && qemu_memfd_check(0)) {
-        memfd = TEST_MEMFD_YES;
-    }
-
-    if (memfd == TEST_MEMFD_YES) {
-        return g_strdup_printf(QEMU_CMD_MEMFD QEMU_CMD_CHR
-                               QEMU_CMD_NETDEV QEMU_CMD_NET "%s", mem, mem,
-                               s->chr_name, s->socket_path,
-                               chr_opts, s->chr_name, extra);
-    } else {
-        return g_strdup_printf(QEMU_CMD_MEM QEMU_CMD_CHR
-                               QEMU_CMD_NETDEV QEMU_CMD_NET "%s", mem, mem,
-                               s->mem_path, s->chr_name, s->socket_path,
-                               chr_opts, s->chr_name, extra);
-    }
+    g_string_append_printf(cmd_line, QEMU_CMD_CHR QEMU_CMD_NETDEV,
+                           s->chr_name, s->socket_path,
+                           chr_opts, s->chr_name);
 }
 
-static void init_virtio_dev(QTestState *qts, TestServer *s, uint32_t features_mask)
+static void append_mem_opts(TestServer *server, GString *cmd_line, int size, enum test_memfd memfd)
 {
-    uint32_t features;
-    int i;
-
-    s->bus = qpci_new_pc(qts, NULL);
-    g_assert_nonnull(s->bus);
-
-    s->dev = qvirtio_pci_device_find(s->bus, VIRTIO_ID_NET);
-    g_assert_nonnull(s->dev);
-
-    qvirtio_pci_device_enable(s->dev);
-    qvirtio_start_device(&s->dev->vdev);
-
-    pc_alloc_init(&s->alloc, qts, 0);
-
-    for (i = 0; i < s->queues * 2; i++) {
-        s->vq[i] = qvirtqueue_setup(&s->dev->vdev, &s->alloc, i);
+    if (memfd == TEST_MEMFD_AUTO) {
+        memfd = qemu_memfd_check(0) ? TEST_MEMFD_YES : TEST_MEMFD_NO;
     }
 
-    features = qvirtio_get_features(&s->dev->vdev);
-    features = features & features_mask;
-    qvirtio_set_features(&s->dev->vdev, features);
-
-    qvirtio_set_driver_ok(&s->dev->vdev);
-}
-
-static void uninit_virtio_dev(TestServer *s)
-{
-    int i;
+    if (memfd == TEST_MEMFD_YES) {
+        const char *root = init_hugepagefs() ? : server->tmpfs;
 
-    for (i = 0; i < s->queues * 2; i++) {
-        qvirtqueue_cleanup(s->dev->vdev.bus, s->vq[i], &s->alloc);
+        g_string_append_printf(cmd_line, QEMU_CMD_MEM, size, size, root);
+    } else {
+        g_string_append_printf(cmd_line, QEMU_CMD_MEMFD, size, size);
     }
-    alloc_destroy(&s->alloc);
-
-    qvirtio_pci_device_free(s->dev);
 }
 
 static bool wait_for_fds(TestServer *s)
@@ -460,17 +418,21 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
 
 static const char *init_hugepagefs(void)
 {
+    static const char *hugepagefs;
     const char *path = getenv("QTEST_HUGETLBFS_PATH");
     struct statfs fs;
     int ret;
 
+    if (hugepagefs) {
+        return hugepagefs;
+    }
     if (!path) {
         return NULL;
     }
 
     if (access(path, R_OK | W_OK | X_OK)) {
         g_test_message("access on path (%s): %s\n", path, strerror(errno));
-        abort();
+        g_test_fail();
         return NULL;
     }
 
@@ -480,17 +442,18 @@ static const char *init_hugepagefs(void)
 
     if (ret != 0) {
         g_test_message("statfs on path (%s): %s\n", path, strerror(errno));
-        abort();
+        g_test_fail();
         return NULL;
     }
 
     if (fs.f_type != HUGETLBFS_MAGIC) {
         g_test_message("Warning: path not on HugeTLBFS: %s\n", path);
-        abort();
+        g_test_fail();
         return NULL;
     }
 
-    return path;
+    hugepagefs = path;
+    return hugepagefs;
 }
 
 static TestServer *test_server_new(const gchar *name)
@@ -510,7 +473,6 @@ static TestServer *test_server_new(const gchar *name)
     g_assert(tmpfs);
 
     server->tmpfs = g_strdup(tmpfs);
-    server->mem_path = init_hugepagefs() ? : server->tmpfs;
     server->socket_path = g_strdup_printf("%s/%s.sock", tmpfs, name);
     server->mig_path = g_strdup_printf("%s/%s.mig", tmpfs, name);
     server->chr_name = g_strdup_printf("chr-%s", name);
@@ -590,8 +552,6 @@ static void test_server_free(TestServer *server)
     }
 
     g_free(server->chr_name);
-    g_assert(server->bus);
-    qpci_free_pc(server->bus);
 
     g_free(server);
 }
@@ -683,70 +643,79 @@ GSourceFuncs test_migrate_source_funcs = {
     .check = test_migrate_source_check,
 };
 
-static void test_read_guest_mem(const void *arg)
+static void vhost_user_test_cleanup(void *s)
 {
-    enum test_memfd memfd = GPOINTER_TO_INT(arg);
-    TestServer *server = NULL;
-    char *qemu_cmd = NULL;
-    QTestState *s = NULL;
+    TestServer *server = s;
+
+    qos_invalidate_command_line();
+    test_server_free(server);
+}
 
-    server = test_server_new(memfd == TEST_MEMFD_YES ?
-                             "read-guest-memfd" : "read-guest-mem");
+static void *vhost_user_test_setup(GString *cmd_line, void *arg)
+{
+    TestServer *server = test_server_new("vhost-user-test");
     test_server_listen(server);
 
-    qemu_cmd = get_qemu_cmd(server, 256, memfd, "", "");
+    append_mem_opts(server, cmd_line, 256, TEST_MEMFD_YES);
+    append_vhost_opts(server, cmd_line, "");
 
-    s = qtest_start(qemu_cmd);
-    g_free(qemu_cmd);
+    g_test_queue_destroy(vhost_user_test_cleanup, server);
 
-    init_virtio_dev(global_qtest, server, 1u << VIRTIO_NET_F_MAC);
+    return server;
+}
+
+static void *vhost_user_test_setup_memfd(GString *cmd_line, void *arg)
+{
+    TestServer *server = test_server_new("vhost-user-test");
+    test_server_listen(server);
+
+    append_mem_opts(server, cmd_line, 256, TEST_MEMFD_AUTO);
+    append_vhost_opts(server, cmd_line, "");
+
+    g_test_queue_destroy(vhost_user_test_cleanup, server);
+
+    return server;
+}
+
+static void test_read_guest_mem(void *obj, void *arg, QGuestAllocator *alloc)
+{
+    TestServer *server = arg;
 
     if (!wait_for_fds(server)) {
-        goto exit;
+        return;
     }
 
     read_guest_mem_server(global_qtest, server);
-
-exit:
-    uninit_virtio_dev(server);
-
-    qtest_quit(s);
-    test_server_free(server);
 }
 
-static void test_migrate(void)
+static void test_migrate(void *obj, void *arg, QGuestAllocator *alloc)
 {
-    TestServer *s = test_server_new("src");
+    TestServer *s = arg;
     TestServer *dest = test_server_new("dest");
+    GString *dest_cmdline = g_string_new(qos_get_current_command_line());
     char *uri = g_strdup_printf("%s%s", "unix:", dest->mig_path);
-    QTestState *from, *to;
+    QTestState *to;
     GSource *source;
-    gchar *cmd, *tmp;
     QDict *rsp;
     guint8 *log;
     guint64 size;
 
-    test_server_listen(s);
-    test_server_listen(dest);
-
-    cmd = get_qemu_cmd(s, 256, TEST_MEMFD_AUTO, "", "");
-    from = qtest_start(cmd);
-    g_free(cmd);
-
-    init_virtio_dev(from, s, 1u << VIRTIO_NET_F_MAC);
     if (!wait_for_fds(s)) {
-        goto exit;
+        return;
     }
 
     size = get_log_size(s);
     g_assert_cmpint(size, ==, (256 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));
 
-    tmp = g_strdup_printf(" -incoming %s", uri);
-    cmd = get_qemu_cmd(dest, 256, TEST_MEMFD_AUTO, "", tmp);
-    g_free(tmp);
-    to = qtest_init(cmd);
-    g_free(cmd);
-    init_virtio_dev(to, dest, 1u << VIRTIO_NET_F_MAC);
+    test_server_listen(dest);
+    g_string_append_printf(dest_cmdline, " -incoming %s", uri);
+    append_mem_opts(dest, dest_cmdline, 256, TEST_MEMFD_AUTO);
+    append_vhost_opts(dest, dest_cmdline, "");
+    to = qtest_init(dest_cmdline->str);
+
+    /* This would be where you call qos_allocate_objects(to, NULL), if you want
+     * to talk to the QVirtioNet object on the destination.
+     */
 
     source = g_source_new(&test_migrate_source_funcs,
                           sizeof(TestMigrateSource));
@@ -787,18 +756,11 @@ static void test_migrate(void)
     g_assert(wait_for_fds(dest));
     read_guest_mem_server(to, dest);
 
-    uninit_virtio_dev(dest);
-    qtest_quit(to);
-
     g_source_destroy(source);
     g_source_unref(source);
 
-exit:
-    uninit_virtio_dev(s);
-
+    qtest_quit(to);
     test_server_free(dest);
-    qtest_quit(from);
-    test_server_free(s);
     g_free(uri);
 }
 
@@ -846,19 +808,25 @@ connect_thread(gpointer data)
     return NULL;
 }
 
-static void test_reconnect_subprocess(void)
+static void *vhost_user_test_setup_reconnect(GString *cmd_line, void *arg)
 {
     TestServer *s = test_server_new("reconnect");
-    char *cmd;
 
     g_thread_new("connect", connect_thread, s);
-    cmd = get_qemu_cmd(s, 256, TEST_MEMFD_AUTO, ",server", "");
-    qtest_start(cmd);
-    g_free(cmd);
+    append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
+    append_vhost_opts(s, cmd_line, ",server");
+
+    g_test_queue_destroy(vhost_user_test_cleanup, s);
+
+    return s;
+}
+
+static void test_reconnect(void *obj, void *arg, QGuestAllocator *alloc)
+{
+    TestServer *s = arg;
 
-    init_virtio_dev(global_qtest, s, 1u << VIRTIO_NET_F_MAC);
     if (!wait_for_fds(s)) {
-        goto exit;
+        return;
     }
 
     wait_for_rings_started(s, 2);
@@ -869,159 +837,111 @@ static void test_reconnect_subprocess(void)
     g_idle_add(reconnect_cb, s);
     g_assert(wait_for_fds(s));
     wait_for_rings_started(s, 2);
-
-exit:
-    uninit_virtio_dev(s);
-
-    qtest_end();
-    test_server_free(s);
-    return;
 }
 
-static void test_reconnect(void)
-{
-    gchar *path = g_strdup_printf("/%s/vhost-user/reconnect/subprocess",
-                                  qtest_get_arch());
-    g_test_trap_subprocess(path, 0, 0);
-    g_test_trap_assert_passed();
-    g_free(path);
-}
-
-static void test_connect_fail_subprocess(void)
+static void *vhost_user_test_setup_connect_fail(GString *cmd_line, void *arg)
 {
     TestServer *s = test_server_new("connect-fail");
-    char *cmd;
 
     s->test_fail = true;
-    g_thread_new("connect", connect_thread, s);
-    cmd = get_qemu_cmd(s, 256, TEST_MEMFD_AUTO, ",server", "");
-    qtest_start(cmd);
-    g_free(cmd);
 
-    init_virtio_dev(global_qtest, s, 1u << VIRTIO_NET_F_MAC);
-    if (!wait_for_fds(s)) {
-        goto exit;
-    }
-    wait_for_rings_started(s, 2);
+    g_thread_new("connect", connect_thread, s);
+    append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
+    append_vhost_opts(s, cmd_line, ",server");
 
-exit:
-    uninit_virtio_dev(s);
+    g_test_queue_destroy(vhost_user_test_cleanup, s);
 
-    qtest_end();
-    test_server_free(s);
+    return s;
 }
 
-static void test_connect_fail(void)
-{
-    gchar *path = g_strdup_printf("/%s/vhost-user/connect-fail/subprocess",
-                                  qtest_get_arch());
-    g_test_trap_subprocess(path, 0, 0);
-    g_test_trap_assert_passed();
-    g_free(path);
-}
-
-static void test_flags_mismatch_subprocess(void)
+static void *vhost_user_test_setup_flags_mismatch(GString *cmd_line, void *arg)
 {
     TestServer *s = test_server_new("flags-mismatch");
-    char *cmd;
 
     s->test_flags = TEST_FLAGS_DISCONNECT;
-    g_thread_new("connect", connect_thread, s);
-    cmd = get_qemu_cmd(s, 256, TEST_MEMFD_AUTO, ",server", "");
-    qtest_start(cmd);
-    g_free(cmd);
 
-    init_virtio_dev(global_qtest, s, 1u << VIRTIO_NET_F_MAC);
-    if (!wait_for_fds(s)) {
-        goto exit;
-    }
-    wait_for_rings_started(s, 2);
+    g_thread_new("connect", connect_thread, s);
+    append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
+    append_vhost_opts(s, cmd_line, ",server");
 
-exit:
-    uninit_virtio_dev(s);
+    g_test_queue_destroy(vhost_user_test_cleanup, s);
 
-    qtest_end();
-    test_server_free(s);
+    return s;
 }
 
-static void test_flags_mismatch(void)
+static void test_vhost_user_started(void *obj, void *arg, QGuestAllocator *alloc)
 {
-    gchar *path = g_strdup_printf("/%s/vhost-user/flags-mismatch/subprocess",
-                                  qtest_get_arch());
-    g_test_trap_subprocess(path, 0, 0);
-    g_test_trap_assert_passed();
-    g_free(path);
-}
+    TestServer *s = arg;
 
+    if (!wait_for_fds(s)) {
+        return;
+    }
+    wait_for_rings_started(s, 2);
+}
 
-static void test_multiqueue(void)
+static void *vhost_user_test_setup_multiqueue(GString *cmd_line, void *arg)
 {
-    TestServer *s = test_server_new("mq");
-    char *cmd;
-    uint32_t features_mask = ~(QVIRTIO_F_BAD_FEATURE |
-                            (1u << VIRTIO_RING_F_INDIRECT_DESC) |
-                            (1u << VIRTIO_RING_F_EVENT_IDX));
+    TestServer *s = vhost_user_test_setup_memfd(cmd_line, arg);
+
     s->queues = 2;
-    test_server_listen(s);
+    g_string_append_printf(cmd_line,
+                           " -set netdev.hs0.queues=%d"
+                           " -global virtio-net-pci.vectors=%d",
+                           s->queues, s->queues * 2 + 2);
 
-    if (qemu_memfd_check(0)) {
-        cmd = g_strdup_printf(
-            QEMU_CMD_MEMFD QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=%d "
-            "-device virtio-net-pci,netdev=net0,mq=on,vectors=%d",
-            256, 256, s->chr_name,
-            s->socket_path, "", s->chr_name,
-            s->queues, s->queues * 2 + 2);
-    } else {
-        cmd = g_strdup_printf(
-            QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=%d "
-            "-device virtio-net-pci,netdev=net0,mq=on,vectors=%d",
-            256, 256, s->mem_path, s->chr_name,
-            s->socket_path, "", s->chr_name,
-            s->queues, s->queues * 2 + 2);
-    }
-    qtest_start(cmd);
-    g_free(cmd);
+    return s;
+}
 
-    init_virtio_dev(global_qtest, s, features_mask);
+static void test_multiqueue(void *obj, void *arg, QGuestAllocator *alloc)
+{
+    TestServer *s = arg;
 
     wait_for_rings_started(s, s->queues * 2);
-
-    uninit_virtio_dev(s);
-
-    qtest_end();
-
-    test_server_free(s);
 }
 
-int main(int argc, char **argv)
+static void register_vhost_user_test(void)
 {
-    g_test_init(&argc, &argv, NULL);
+    QOSGraphTestOptions opts = {
+        .before = vhost_user_test_setup,
+        .subprocess = true,
+    };
 
-    module_call_init(MODULE_INIT_QOM);
     qemu_add_opts(&qemu_chardev_opts);
 
+    qos_add_test("vhost-user/read-guest-mem/memfile",
+                 "virtio-net",
+                 test_read_guest_mem, &opts);
+
     if (qemu_memfd_check(0)) {
-        qtest_add_data_func("/vhost-user/read-guest-mem/memfd",
-                            GINT_TO_POINTER(TEST_MEMFD_YES),
-                            test_read_guest_mem);
+        opts.before = vhost_user_test_setup_memfd;
+        qos_add_test("vhost-user/read-guest-mem/memfd",
+                     "virtio-net",
+                     test_read_guest_mem, &opts);
     }
-    qtest_add_data_func("/vhost-user/read-guest-mem/memfile",
-                        GINT_TO_POINTER(TEST_MEMFD_NO), test_read_guest_mem);
-    qtest_add_func("/vhost-user/migrate", test_migrate);
-    qtest_add_func("/vhost-user/multiqueue", test_multiqueue);
+
+    qos_add_test("vhost-user/migrate",
+                 "virtio-net",
+                 test_migrate, &opts);
 
     /* keeps failing on build-system since Aug 15 2017 */
     if (getenv("QTEST_VHOST_USER_FIXME")) {
-        qtest_add_func("/vhost-user/reconnect/subprocess",
-                       test_reconnect_subprocess);
-        qtest_add_func("/vhost-user/reconnect", test_reconnect);
-        qtest_add_func("/vhost-user/connect-fail/subprocess",
-                       test_connect_fail_subprocess);
-        qtest_add_func("/vhost-user/connect-fail", test_connect_fail);
-        qtest_add_func("/vhost-user/flags-mismatch/subprocess",
-                       test_flags_mismatch_subprocess);
-        qtest_add_func("/vhost-user/flags-mismatch", test_flags_mismatch);
+        opts.before = vhost_user_test_setup_reconnect;
+        qos_add_test("vhost-user/reconnect", "virtio-net",
+                     test_reconnect, &opts);
+
+        opts.before = vhost_user_test_setup_connect_fail;
+        qos_add_test("vhost-user/connect-fail", "virtio-net",
+                     test_vhost_user_started, &opts);
+
+        opts.before = vhost_user_test_setup_flags_mismatch;
+        qos_add_test("vhost-user/flags-mismatch", "virtio-net",
+                     test_vhost_user_started, &opts);
     }
 
-    return g_test_run();
+    opts.before = vhost_user_test_setup_multiqueue;
+    opts.edge.extra_device_opts = "mq=on";
+    qos_add_test("vhost-user/multiqueue",
+                 "virtio-net",
+                 test_multiqueue, &opts);
 }
+libqos_init(register_vhost_user_test);
-- 
1.8.3.1

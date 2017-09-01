Received: from eggs.gnu.org ([2001:4830:134:3::10]:56374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqJ0-0007cj-26
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIu-00025j-PV
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnqIu-00025I-Hj
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A9DEC056819
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 18:04:27 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Sep 2017 13:03:38 -0500
Message-Id: <20170901180340.30009-28-eblake@redhat.com>
In-Reply-To: <20170901180340.30009-1-eblake@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 27/29] libqtest: Make qtest_init() accept
 format string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Several callers were formatting a string into a temporary
variable before calling qtest_init(); factor that into the
common code.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h         |  7 ++++---
 tests/libqtest.c         | 13 ++++++++++--
 tests/bios-tables-test.c |  7 +------
 tests/postcopy-test.c    |  4 ++--
 tests/vhost-user-test.c  | 51 ++++++++++++++----------------------------------
 5 files changed, 33 insertions(+), 49 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 3ae570927a..d338de3e22 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -25,11 +25,12 @@ extern QTestState *global_qtest;

 /**
  * qtest_init:
- * @extra_args: other arguments to pass to QEMU.
+ * @extra_args...: other arguments to pass to QEMU, formatted as if by
+ * sprintf().
  *
  * Returns: #QTestState instance.
  */
-QTestState *qtest_init(const char *extra_args);
+QTestState *qtest_init(const char *extra_args, ...) GCC_FMT_ATTR(1, 2);

 /**
  * qtest_init_without_qmp_handshake:
@@ -518,7 +519,7 @@ void qtest_add_abrt_handler(GHookFunc fn, const void *data);
  */
 static inline QTestState *qtest_start(const char *args)
 {
-    global_qtest = qtest_init(args);
+    global_qtest = qtest_init("%s", args);
     return global_qtest;
 }

diff --git a/tests/libqtest.c b/tests/libqtest.c
index b6dd26e54a..18facbf130 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -347,9 +347,18 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     return s;
 }

-QTestState *qtest_init(const char *extra_args)
+QTestState *qtest_init(const char *extra_args, ...)
 {
-    QTestState *s = qtest_init_without_qmp_handshake(extra_args);
+    va_list ap;
+    QTestState *s;
+    char *cmd;
+
+    va_start(ap, extra_args);
+    cmd = g_strdup_vprintf(extra_args, ap);
+    va_end(ap);
+
+    s = qtest_init_without_qmp_handshake(cmd);
+    g_free(cmd);

     /* Read the QMP greeting and then do the handshake */
     qtest_qmp_discard_response(s, "");
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 976792f2c5..f8a107499f 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -623,18 +623,14 @@ static void test_smbios_structs(test_data *data)

 static void test_acpi_one(const char *params, test_data *data)
 {
-    char *args;
-
     /* Disable kernel irqchip to be able to override apic irq0. */
-    args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off "
+    data->qts = qtest_init("-machine %s,accel=%s,kernel-irqchip=off "
                            "-net none -display none %s "
                            "-drive id=hd0,if=none,file=%s,format=raw "
                            "-device ide-hd,drive=hd0 ",
                            data->machine, "kvm:tcg",
                            params ? params : "", disk);

-    data->qts = qtest_init(args);
-
     boot_sector_test(data->qts);

     test_acpi_rsdp_address(data);
@@ -657,7 +653,6 @@ static void test_acpi_one(const char *params, test_data *data)
     test_smbios_structs(data);

     qtest_quit(data->qts);
-    g_free(args);
 }

 static uint8_t base_required_struct_types[] = {
diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index 0e5fe20a83..20cfb280f6 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -403,10 +403,10 @@ static void test_migrate(void)

     g_free(bootpath);

-    from = qtest_init(cmd_src);
+    from = qtest_init("%s", cmd_src);
     g_free(cmd_src);

-    to = qtest_init(cmd_dst);
+    to = qtest_init("%s", cmd_dst);
     g_free(cmd_dst);

     assert(!global_qtest);
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 1e0c50d12a..0dbed5a36a 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -482,12 +482,12 @@ static inline void test_server_connect(TestServer *server)
 }

 #define GET_QEMU_CMD(s)                                         \
-    g_strdup_printf(QEMU_CMD, 512, 512, (root), (s)->chr_name,  \
-                    (s)->socket_path, "", (s)->chr_name)
+    QEMU_CMD, 512, 512, (root), (s)->chr_name,                  \
+        (s)->socket_path, "", (s)->chr_name

 #define GET_QEMU_CMDE(s, mem, chr_opts, extra, ...)                     \
-    g_strdup_printf(QEMU_CMD extra, (mem), (mem), (root), (s)->chr_name, \
-                    (s)->socket_path, (chr_opts), (s)->chr_name, ##__VA_ARGS__)
+    QEMU_CMD extra, (mem), (mem), (root), (s)->chr_name,                \
+        (s)->socket_path, (chr_opts), (s)->chr_name, ##__VA_ARGS__

 static gboolean _test_server_free(TestServer *server)
 {
@@ -637,7 +637,6 @@ static void test_migrate(void)
     TestServer *dest = test_server_new("dest");
     char *uri = g_strdup_printf("%s%s", "unix:", dest->mig_path);
     GSource *source;
-    gchar *cmd;
     QDict *rsp;
     guint8 *log;
     guint64 size;
@@ -645,18 +644,14 @@ static void test_migrate(void)
     test_server_listen(s);
     test_server_listen(dest);

-    cmd = GET_QEMU_CMDE(s, 2, "", "");
-    s->qts = qtest_init(cmd);
-    g_free(cmd);
+    s->qts = qtest_init(GET_QEMU_CMDE(s, 2, "", ""));

     init_virtio_dev(s);
     wait_for_fds(s);
     size = get_log_size(s);
     g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));

-    cmd = GET_QEMU_CMDE(dest, 2, "", " -incoming %s", uri);
-    dest->qts = qtest_init(cmd);
-    g_free(cmd);
+    dest->qts = qtest_init(GET_QEMU_CMDE(dest, 2, "", " -incoming %s", uri));

     source = g_source_new(&test_migrate_source_funcs,
                           sizeof(TestMigrateSource));
@@ -749,12 +744,9 @@ connect_thread(gpointer data)
 static void test_reconnect_subprocess(void)
 {
     TestServer *s = test_server_new("reconnect");
-    char *cmd;

     g_thread_new("connect", connect_thread, s);
-    cmd = GET_QEMU_CMDE(s, 2, ",server", "");
-    s->qts = qtest_init(cmd);
-    g_free(cmd);
+    s->qts = qtest_init(GET_QEMU_CMDE(s, 2, ",server", ""));

     init_virtio_dev(s);
     wait_for_fds(s);
@@ -783,13 +775,10 @@ static void test_reconnect(void)
 static void test_connect_fail_subprocess(void)
 {
     TestServer *s = test_server_new("connect-fail");
-    char *cmd;

     s->test_fail = true;
     g_thread_new("connect", connect_thread, s);
-    cmd = GET_QEMU_CMDE(s, 2, ",server", "");
-    s->qts = qtest_init(cmd);
-    g_free(cmd);
+    s->qts = qtest_init(GET_QEMU_CMDE(s, 2, ",server", ""));

     init_virtio_dev(s);
     wait_for_fds(s);
@@ -810,13 +799,10 @@ static void test_connect_fail(void)
 static void test_flags_mismatch_subprocess(void)
 {
     TestServer *s = test_server_new("flags-mismatch");
-    char *cmd;

     s->test_flags = TEST_FLAGS_DISCONNECT;
     g_thread_new("connect", connect_thread, s);
-    cmd = GET_QEMU_CMDE(s, 2, ",server", "");
-    s->qts = qtest_init(cmd);
-    g_free(cmd);
+    s->qts = qtest_init(GET_QEMU_CMDE(s, 2, ",server", ""));

     init_virtio_dev(s);
     wait_for_fds(s);
@@ -875,19 +861,16 @@ static void test_multiqueue(void)
     QPCIBus *bus;
     QVirtQueuePCI *vq[queues * 2];
     QGuestAllocator *alloc;
-    char *cmd;
     int i;

     s->queues = queues;
     test_server_listen(s);

-    cmd = g_strdup_printf(QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=%d "
-                          "-device virtio-net-pci,netdev=net0,mq=on,vectors=%d",
-                          512, 512, root, s->chr_name,
-                          s->socket_path, "", s->chr_name,
-                          queues, queues * 2 + 2);
-    s->qts = qtest_init(cmd);
-    g_free(cmd);
+    s->qts = qtest_init(QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=%d "
+                        "-device virtio-net-pci,netdev=net0,mq=on,vectors=%d",
+                        512, 512, root, s->chr_name,
+                        s->socket_path, "", s->chr_name,
+                        queues, queues * 2 + 2);

     bus = qpci_init_pc(s->qts, NULL);
     dev = virtio_net_pci_init(bus, PCI_SLOT);
@@ -917,7 +900,6 @@ int main(int argc, char **argv)
 {
     TestServer *server = NULL;
     const char *hugefs;
-    char *qemu_cmd = NULL;
     int ret;
     char template[] = "/tmp/vhost-test-XXXXXX";
     GMainLoop *loop;
@@ -949,10 +931,7 @@ int main(int argc, char **argv)
     /* run the main loop thread so the chardev may operate */
     thread = g_thread_new(NULL, thread_function, loop);

-    qemu_cmd = GET_QEMU_CMD(server);
-
-    server->qts = qtest_init(qemu_cmd);
-    g_free(qemu_cmd);
+    server->qts = qtest_init(GET_QEMU_CMD(server));
     init_virtio_dev(server);

     qtest_add_data_func("/vhost-user/read-guest-mem", server, read_guest_mem);
-- 
2.13.5

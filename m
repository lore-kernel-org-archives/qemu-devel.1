Received: from eggs.gnu.org ([2001:4830:134:3::10]:56128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIn-0007QM-TS
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIi-0001s6-Mo
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnqIi-0001rE-FU
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85F29C056828
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 18:04:15 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Sep 2017 13:03:31 -0500
Message-Id: <20170901180340.30009-21-eblake@redhat.com>
In-Reply-To: <20170901180340.30009-1-eblake@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 20/29] vhost-user-test: Drop dependence on
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
Cc: armbru@redhat.com, pbonzini@redhat.com

Managing parallel connections to two different monitors via
the implicit global_qtest makes it hard to copy-and-paste code
to tests that are not aware of the implicit state.  Now that
libqos is fully-explicit, it is easy to expand the rest of
vhost-user-test to also use explicit state everywhere.

We can assert that the conversion is correct by checking that
global_qtest remains NULL throughout the test (a later patch
that changes global_qtest to not be a public global variable
will drop the assertions).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/vhost-user-test.c | 68 ++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 562bfaefd2..1e0c50d12a 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -139,6 +139,7 @@ enum {
 };

 typedef struct TestServer {
+    QTestState *qts;
     QPCIBus *bus;
     gchar *socket_path;
     gchar *mig_path;
@@ -164,7 +165,7 @@ static void init_virtio_dev(TestServer *s)
     QVirtioPCIDevice *dev;
     uint32_t features;

-    s->bus = qpci_init_pc(global_qtest, NULL);
+    s->bus = qpci_init_pc(s->qts, NULL);
     g_assert_nonnull(s->bus);

     dev = qvirtio_pci_device_find(s->bus, VIRTIO_ID_NET);
@@ -236,8 +237,11 @@ static void read_guest_mem(const void *data)
         guest_mem += (s->memory.regions[i].mmap_offset / sizeof(*guest_mem));

         for (j = 0; j < 256; j++) {
-            uint32_t a = readl(s->memory.regions[i].guest_phys_addr + j*4);
-            uint32_t b = guest_mem[j];
+            uint32_t a, b;
+
+            a = qtest_readl(s->qts,
+                            s->memory.regions[i].guest_phys_addr + j * 4);
+            b = guest_mem[j];

             g_assert_cmpint(a, ==, b);
         }
@@ -515,6 +519,12 @@ static gboolean _test_server_free(TestServer *server)

 static void test_server_free(TestServer *server)
 {
+    assert(!global_qtest);
+    if (server->qts) {
+        qtest_quit(server->qts);
+        server->qts = NULL;
+    }
+
     g_idle_add((GSourceFunc)_test_server_free, server);
 }

@@ -626,7 +636,6 @@ static void test_migrate(void)
     TestServer *s = test_server_new("src");
     TestServer *dest = test_server_new("dest");
     char *uri = g_strdup_printf("%s%s", "unix:", dest->mig_path);
-    QTestState *global = global_qtest, *from, *to;
     GSource *source;
     gchar *cmd;
     QDict *rsp;
@@ -637,7 +646,7 @@ static void test_migrate(void)
     test_server_listen(dest);

     cmd = GET_QEMU_CMDE(s, 2, "", "");
-    from = qtest_start(cmd);
+    s->qts = qtest_init(cmd);
     g_free(cmd);

     init_virtio_dev(s);
@@ -646,7 +655,7 @@ static void test_migrate(void)
     g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));

     cmd = GET_QEMU_CMDE(dest, 2, "", " -incoming %s", uri);
-    to = qtest_init(cmd);
+    dest->qts = qtest_init(cmd);
     g_free(cmd);

     source = g_source_new(&test_migrate_source_funcs,
@@ -657,16 +666,13 @@ static void test_migrate(void)

     /* slow down migration to have time to fiddle with log */
     /* TODO: qtest could learn to break on some places */
-    rsp = qmp("{ 'execute': 'migrate_set_speed',"
-              "'arguments': { 'value': 10 } }");
+    rsp = qtest_qmp(s->qts, "{ 'execute': 'migrate_set_speed',"
+                    "'arguments': { 'value': 10 } }");
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

-    cmd = g_strdup_printf("{ 'execute': 'migrate',"
-                          "'arguments': { 'uri': '%s' } }",
-                          uri);
-    rsp = qmp(cmd);
-    g_free(cmd);
+    rsp = qtest_qmp(s->qts,
+                    "{'execute': 'migrate', 'arguments': { 'uri': %s}}", uri);
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

@@ -681,28 +687,23 @@ static void test_migrate(void)
     munmap(log, size);

     /* speed things up */
-    rsp = qmp("{ 'execute': 'migrate_set_speed',"
-              "'arguments': { 'value': 0 } }");
+    rsp = qtest_qmp(s->qts, "{ 'execute': 'migrate_set_speed',"
+                    "'arguments': { 'value': 0 } }");
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

-    qmp_eventwait("STOP");
+    qtest_qmp_eventwait(s->qts, "STOP");

-    global_qtest = to;
-    qmp_eventwait("RESUME");
+    qtest_qmp_eventwait(dest->qts, "RESUME");

     read_guest_mem(dest);

     g_source_destroy(source);
     g_source_unref(source);

-    qtest_quit(to);
     test_server_free(dest);
-    qtest_quit(from);
     test_server_free(s);
     g_free(uri);
-
-    global_qtest = global;
 }

 static void wait_for_rings_started(TestServer *s, size_t count)
@@ -752,7 +753,7 @@ static void test_reconnect_subprocess(void)

     g_thread_new("connect", connect_thread, s);
     cmd = GET_QEMU_CMDE(s, 2, ",server", "");
-    qtest_start(cmd);
+    s->qts = qtest_init(cmd);
     g_free(cmd);

     init_virtio_dev(s);
@@ -766,7 +767,6 @@ static void test_reconnect_subprocess(void)
     wait_for_fds(s);
     wait_for_rings_started(s, 2);

-    qtest_end();
     test_server_free(s);
     return;
 }
@@ -788,14 +788,13 @@ static void test_connect_fail_subprocess(void)
     s->test_fail = true;
     g_thread_new("connect", connect_thread, s);
     cmd = GET_QEMU_CMDE(s, 2, ",server", "");
-    qtest_start(cmd);
+    s->qts = qtest_init(cmd);
     g_free(cmd);

     init_virtio_dev(s);
     wait_for_fds(s);
     wait_for_rings_started(s, 2);

-    qtest_end();
     test_server_free(s);
 }

@@ -816,14 +815,13 @@ static void test_flags_mismatch_subprocess(void)
     s->test_flags = TEST_FLAGS_DISCONNECT;
     g_thread_new("connect", connect_thread, s);
     cmd = GET_QEMU_CMDE(s, 2, ",server", "");
-    qtest_start(cmd);
+    s->qts = qtest_init(cmd);
     g_free(cmd);

     init_virtio_dev(s);
     wait_for_fds(s);
     wait_for_rings_started(s, 2);

-    qtest_end();
     test_server_free(s);
 }

@@ -888,13 +886,13 @@ static void test_multiqueue(void)
                           512, 512, root, s->chr_name,
                           s->socket_path, "", s->chr_name,
                           queues, queues * 2 + 2);
-    qtest_start(cmd);
+    s->qts = qtest_init(cmd);
     g_free(cmd);

-    bus = qpci_init_pc(global_qtest, NULL);
+    bus = qpci_init_pc(s->qts, NULL);
     dev = virtio_net_pci_init(bus, PCI_SLOT);

-    alloc = pc_alloc_init(global_qtest);
+    alloc = pc_alloc_init(s->qts);
     for (i = 0; i < queues * 2; i++) {
         vq[i] = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, alloc, i);
     }
@@ -911,14 +909,12 @@ static void test_multiqueue(void)
     g_free(dev->pdev);
     g_free(dev);
     qpci_free_pc(bus);
-    qtest_end();

     test_server_free(s);
 }

 int main(int argc, char **argv)
 {
-    QTestState *s = NULL;
     TestServer *server = NULL;
     const char *hugefs;
     char *qemu_cmd = NULL;
@@ -955,7 +951,7 @@ int main(int argc, char **argv)

     qemu_cmd = GET_QEMU_CMD(server);

-    s = qtest_start(qemu_cmd);
+    server->qts = qtest_init(qemu_cmd);
     g_free(qemu_cmd);
     init_virtio_dev(server);

@@ -976,10 +972,6 @@ int main(int argc, char **argv)

     ret = g_test_run();

-    if (s) {
-        qtest_quit(s);
-    }
-
     /* cleanup */
     test_server_free(server);

-- 
2.13.5

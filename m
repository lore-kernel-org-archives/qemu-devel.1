Received: from eggs.gnu.org ([2001:4830:134:3::10]:60452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNl-000082-Jc
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNj-0004W0-4O
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:29 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 20:25:45 -0500
Message-Id: <20170804012551.2714-17-eblake@redhat.com>
In-Reply-To: <20170804012551.2714-1-eblake@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 16/22] libqtest: Add qmp_cmd() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, John Snow <jsnow@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Jason Wang <jasowang@redhat.com>, Ben Warren <ben@skyportsystems.com>, "open list:IDE" <qemu-block@nongnu.org>

Now that we've asserted that all of our interpolated QMP commands
include 'execute', we can reduce some of the caller boilerplate
by providing a helpr function to wrap commands with no arguments
(later patches will cover commands with arguments).

Adjust all callers that can use the new helpers; in the process,
fixing a couple of places where we would have failed
-Wformat-nonliteral.  Likewise, libqos.c no longer needs
qmp_execute(), which in turn fixes the fact that it is better
to interpolate JSON strings through qobject_from_json() than
through sprintf().

The current name is long, but temporary: later patches will
remove all other uses of qmp(), and then make the mass rename
of qmp_cmd() down to qmp().

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h               | 16 ++++++++++++++++
 tests/libqtest.c               | 13 ++++++++++++-
 tests/ahci-test.c              |  4 +---
 tests/boot-order-test.c        |  2 +-
 tests/ide-test.c               |  2 +-
 tests/libqos/ahci.c            |  4 ++--
 tests/libqos/libqos.c          | 16 ++--------------
 tests/numa-test.c              |  2 +-
 tests/postcopy-test.c          |  8 ++++----
 tests/q35-test.c               |  2 +-
 tests/qmp-test.c               |  8 ++++----
 tests/qom-test.c               |  2 +-
 tests/test-filter-mirror.c     |  2 +-
 tests/test-filter-redirector.c |  4 ++--
 tests/test-x86-cpuid-compat.c  |  2 +-
 tests/virtio-net-test.c        | 13 ++++++-------
 tests/vmgenid-test.c           |  2 +-
 tests/wdt_ib700-test.c         |  2 +-
 18 files changed, 58 insertions(+), 46 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 684cfb3507..e0d87d035a 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -483,6 +483,22 @@ QDict *qmp_raw(const char *msg);
 void qmp_async(const char *fmt, ...);

 /**
+ * qmp_cmd:
+ * @cmd: QMP command, with no arguments.
+ *
+ * Sends a QMP message to QEMU and returns the response.
+ */
+QDict *qmp_cmd(const char *cmd);
+
+/**
+ * qmp_cmd_async:
+ * @cmd: QMP command, with no arguments.
+ *
+ * Sends a QMP message to QEMU and leaves the response in the stream.
+ */
+void qmp_cmd_async(const char *cmd);
+
+/**
  * qmp_discard_response:
  *
  * Read and discard a QMP response, typically after qmp_async().
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 2df01682c0..3926a4d481 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -858,6 +858,17 @@ void qmp_async(const char *fmt, ...)
     va_end(ap);
 }

+QDict *qmp_cmd(const char *cmd)
+{
+    qmp_cmd_async(cmd);
+    return qtest_qmp_receive(global_qtest);
+}
+
+void qmp_cmd_async(const char *cmd)
+{
+    qtest_qmp_send(global_qtest, "{'execute':%s}", cmd);
+}
+
 void qmp_discard_response(void)
 {
     QDict *response = qtest_qmp_receive(global_qtest);
@@ -890,7 +901,7 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine))
     const char *mname;

     qtest_start("-machine none");
-    response = qmp("{ 'execute': 'query-machines' }");
+    response = qmp_cmd("query-machines");
     g_assert(response);
     list = qdict_get_qlist(response, "return");
     g_assert(list);
diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 9460843a9f..63d52edfca 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -1350,7 +1350,6 @@ static void test_flush_migrate(void)
     AHCIQState *src, *dst;
     AHCICommand *cmd;
     uint8_t px;
-    const char *s;
     char *uri = g_strdup_printf("unix:%s", mig_socket);

     prepare_blkdebug_script(debug_path, "flush_to_disk");
@@ -1386,8 +1385,7 @@ static void test_flush_migrate(void)
     ahci_migrate(src, dst, uri);

     /* Complete the command */
-    s = "{'execute':'cont' }";
-    qmp_async(s);
+    qmp_cmd_async("cont");
     qmp_eventwait("RESUME");
     ahci_command_wait(dst, cmd);
     ahci_command_verify(dst, cmd);
diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index 4114720236..0be3333e6b 100644
--- a/tests/boot-order-test.c
+++ b/tests/boot-order-test.c
@@ -38,7 +38,7 @@ static void test_a_boot_order(const char *machine,
     qtest_start(args);
     actual = read_boot_order();
     g_assert_cmphex(actual, ==, expected_boot);
-    qmp_async("{ 'execute': 'system_reset' }");
+    qmp_cmd_async("system_reset");
     /*
      * system_reset only requests reset.  We get a RESET event after
      * the actual reset completes.  Need to wait for that.
diff --git a/tests/ide-test.c b/tests/ide-test.c
index 757af7cd1d..56a02b1c7f 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -651,7 +651,7 @@ static void test_retry_flush(const char *machine)
     qmp_eventwait("STOP");

     /* Complete the command */
-    qmp_async("{'execute':'cont' }");
+    qmp_cmd_async("cont");
     qmp_discard_response();

     /* Check registers */
diff --git a/tests/libqos/ahci.c b/tests/libqos/ahci.c
index 1ca7f456b5..06b9ce3a13 100644
--- a/tests/libqos/ahci.c
+++ b/tests/libqos/ahci.c
@@ -668,7 +668,7 @@ void ahci_exec(AHCIQState *ahci, uint8_t port,
         g_assert_cmpint(rc, ==, 0);
     }
     if (opts->error) {
-        qmp_async("{'execute':'cont' }");
+        qmp_cmd_async("cont");
         qmp_eventwait("RESUME");
     }

@@ -706,7 +706,7 @@ AHCICommand *ahci_guest_io_halt(AHCIQState *ahci, uint8_t port,
 void ahci_guest_io_resume(AHCIQState *ahci, AHCICommand *cmd)
 {
     /* Complete the command */
-    qmp_async("{'execute':'cont' }");
+    qmp_cmd_async("cont");
     qmp_eventwait("RESUME");
     ahci_command_wait(ahci, cmd);
     ahci_command_verify(ahci, cmd);
diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index 6226546c28..246a04d6e6 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -84,18 +84,6 @@ void set_context(QOSState *s)
     global_qtest = s->qts;
 }

-static QDict *qmp_execute(const char *command)
-{
-    char *fmt;
-    QDict *rsp;
-
-    fmt = g_strdup_printf("{ 'execute': '%s' }", command);
-    rsp = qmp(fmt);
-    g_free(fmt);
-
-    return rsp;
-}
-
 void migrate(QOSState *from, QOSState *to, const char *uri)
 {
     const char *st;
@@ -106,7 +94,7 @@ void migrate(QOSState *from, QOSState *to, const char *uri)
     set_context(from);

     /* Is the machine currently running? */
-    rsp = qmp_execute("query-status");
+    rsp = qmp_cmd("query-status");
     g_assert(qdict_haskey(rsp, "return"));
     sub = qdict_get_qdict(rsp, "return");
     g_assert(qdict_haskey(sub, "running"));
@@ -137,7 +125,7 @@ void migrate(QOSState *from, QOSState *to, const char *uri)

     /* Otherwise, we need to wait: poll until migration is completed. */
     while (1) {
-        rsp = qmp_execute("query-migrate");
+        rsp = qmp_cmd("query-migrate");
         g_assert(qdict_haskey(rsp, "return"));
         sub = qdict_get_qdict(rsp, "return");
         g_assert(qdict_haskey(sub, "status"));
diff --git a/tests/numa-test.c b/tests/numa-test.c
index e1b6152244..d98500012f 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -74,7 +74,7 @@ static void test_mon_partial(const void *data)

 static QList *get_cpus(QDict **resp)
 {
-    *resp = qmp("{ 'execute': 'query-cpus' }");
+    *resp = qmp_cmd("query-cpus");
     g_assert(*resp);
     g_assert(qdict_haskey(*resp, "return"));
     return qdict_get_qlist(*resp, "return");
diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index 61f4b4180a..6f7f81eccd 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -252,7 +252,7 @@ static uint64_t get_migration_pass(void)
     QDict *rsp, *rsp_return, *rsp_ram;
     uint64_t result;

-    rsp = return_or_event(qmp("{ 'execute': 'query-migrate' }"));
+    rsp = return_or_event(qmp_cmd("query-migrate"));
     rsp_return = qdict_get_qdict(rsp, "return");
     if (!qdict_haskey(rsp_return, "ram")) {
         /* Still in setup */
@@ -273,7 +273,7 @@ static void wait_for_migration_complete(void)
     do {
         const char *status;

-        rsp = return_or_event(qmp("{ 'execute': 'query-migrate' }"));
+        rsp = return_or_event(qmp_cmd("query-migrate"));
         rsp_return = qdict_get_qdict(rsp, "return");
         status = qdict_get_str(rsp_return, "status");
         completed = strcmp(status, "completed") == 0;
@@ -455,7 +455,7 @@ static void test_migrate(void)

     wait_for_migration_pass();

-    rsp = return_or_event(qmp("{ 'execute': 'migrate-start-postcopy' }"));
+    rsp = return_or_event(qmp_cmd("migrate-start-postcopy"));
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

@@ -482,7 +482,7 @@ static void test_migrate(void)
         usleep(10 * 1000);
     } while (dest_byte_a == dest_byte_b);

-    qmp_async("{ 'execute' : 'stop'}");
+    qmp_cmd_async("stop");
     qmp_discard_response();
     /* With it stopped, check nothing changes */
     qtest_memread(to, start_address, &dest_byte_c, 1);
diff --git a/tests/q35-test.c b/tests/q35-test.c
index f98bed7a2d..122872b90d 100644
--- a/tests/q35-test.c
+++ b/tests/q35-test.c
@@ -105,7 +105,7 @@ static void test_smram_lock(void)
     g_assert(smram_test_bit(pcidev, MCH_HOST_BRIDGE_SMRAM_D_OPEN) == false);

     /* reset */
-    response = qmp("{'execute': 'system_reset', 'arguments': {} }");
+    response = qmp_cmd("system_reset");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 905fb4b3e5..082c5f7e8d 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -92,7 +92,7 @@ static void test_qmp_protocol(void)
     QDECREF(resp);

     /* Test valid command before handshake */
-    resp = qmp("{ 'execute': 'query-version' }");
+    resp = qmp_cmd("query-version");
     g_assert_cmpstr(get_error_class(resp), ==, "CommandNotFound");
     QDECREF(resp);

@@ -100,18 +100,18 @@ static void test_qmp_protocol(void)
     test_malformed();

     /* Test handshake */
-    resp = qmp("{ 'execute': 'qmp_capabilities' }");
+    resp = qmp_cmd("qmp_capabilities");
     ret = qdict_get_qdict(resp, "return");
     g_assert(ret && !qdict_size(ret));
     QDECREF(resp);

     /* Test repeated handshake */
-    resp = qmp("{ 'execute': 'qmp_capabilities' }");
+    resp = qmp_cmd("qmp_capabilities");
     g_assert_cmpstr(get_error_class(resp), ==, "CommandNotFound");
     QDECREF(resp);

     /* Test valid command */
-    resp = qmp("{ 'execute': 'query-version' }");
+    resp = qmp_cmd("query-version");
     test_version(qdict_get(resp, "return"));
     QDECREF(resp);

diff --git a/tests/qom-test.c b/tests/qom-test.c
index ab0595dc75..369972629a 100644
--- a/tests/qom-test.c
+++ b/tests/qom-test.c
@@ -98,7 +98,7 @@ static void test_machine(gconstpointer data)

     test_properties("/machine", true);

-    response = qmp("{ 'execute': 'quit' }");
+    response = qmp_cmd("quit");
     g_assert(qdict_haskey(response, "return"));
     QDECREF(response);

diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
index 79c5306fe7..0fb87c124d 100644
--- a/tests/test-filter-mirror.c
+++ b/tests/test-filter-mirror.c
@@ -57,7 +57,7 @@ static void test_mirror(void)
     };

     /* send a qmp command to guarantee that 'connected' is setting to true. */
-    qmp_async("{ 'execute' : 'query-status'}");
+    qmp_cmd_async("query-status");
     qmp_discard_response();
     ret = iov_send(send_sock[0], iov, 2, 0, sizeof(size) + sizeof(send_buf));
     g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(size));
diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redirector.c
index a6a714abea..00f58f63b5 100644
--- a/tests/test-filter-redirector.c
+++ b/tests/test-filter-redirector.c
@@ -99,7 +99,7 @@ static void test_redirector_tx(void)
     g_assert_cmpint(recv_sock, !=, -1);

     /* send a qmp command to guarantee that 'connected' is setting to true. */
-    qmp_async("{ 'execute' : 'query-status'}");
+    qmp_cmd_async("query-status");
     qmp_discard_response();

     struct iovec iov[] = {
@@ -185,7 +185,7 @@ static void test_redirector_rx(void)
     send_sock = unix_connect(sock_path1, NULL);
     g_assert_cmpint(send_sock, !=, -1);
     /* send a qmp command to guarantee that 'connected' is setting to true. */
-    qmp_async("{ 'execute' : 'query-status'}");
+    qmp_cmd_async("query-status");
     qmp_discard_response();

     ret = iov_send(send_sock, iov, 2, 0, sizeof(size) + sizeof(send_buf));
diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.c
index 58a2dd9fe8..f29df9b9df 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -13,7 +13,7 @@ static char *get_cpu0_qom_path(void)
     QDict *cpu0;
     char *path;

-    resp = qmp("{'execute': 'query-cpus', 'arguments': {}}");
+    resp = qmp_cmd("query-cpus");
     g_assert(qdict_haskey(resp, "return"));
     ret = qdict_get_qlist(resp, "return");

diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 635b942c36..5d934d19c2 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -151,7 +151,6 @@ static void rx_stop_cont_test(QVirtioDevice *dev,
     char test[] = "TEST";
     char buffer[64];
     int len = htonl(sizeof(test));
-    QDict *rsp;
     struct iovec iov[] = {
         {
             .iov_base = &len,
@@ -168,8 +167,8 @@ static void rx_stop_cont_test(QVirtioDevice *dev,
     free_head = qvirtqueue_add(vq, req_addr, 64, true, false);
     qvirtqueue_kick(dev, vq, free_head);

-    rsp = qmp("{ 'execute' : 'stop'}");
-    QDECREF(rsp);
+    qmp_cmd_async("stop");
+    qmp_discard_response();

     ret = iov_send(socket, iov, 2, 0, sizeof(len) + sizeof(test));
     g_assert_cmpint(ret, ==, sizeof(test) + sizeof(len));
@@ -177,10 +176,10 @@ static void rx_stop_cont_test(QVirtioDevice *dev,
     /* We could check the status, but this command is more importantly to
      * ensure the packet data gets queued in QEMU, before we do 'cont'.
      */
-    rsp = qmp("{ 'execute' : 'query-status'}");
-    QDECREF(rsp);
-    rsp = qmp("{ 'execute' : 'cont'}");
-    QDECREF(rsp);
+    qmp_cmd_async("query-status");
+    qmp_discard_response();
+    qmp_cmd_async("cont");
+    qmp_discard_response();

     qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_NET_TIMEOUT_US);
     memread(req_addr + VNET_HDR_SIZE, buffer, sizeof(test));
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 3d5c1c3615..0842833eba 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -118,7 +118,7 @@ static void read_guid_from_monitor(QemuUUID *guid)
     QDict *rsp, *rsp_ret;
     const char *guid_str;

-    rsp = qmp("{ 'execute': 'query-vm-generation-id' }");
+    rsp = qmp_cmd("query-vm-generation-id");
     if (qdict_haskey(rsp, "return")) {
         rsp_ret = qdict_get_qdict(rsp, "return");
         g_assert(qdict_haskey(rsp_ret, "guid"));
diff --git a/tests/wdt_ib700-test.c b/tests/wdt_ib700-test.c
index 4fc8eeae86..a5fd795cc9 100644
--- a/tests/wdt_ib700-test.c
+++ b/tests/wdt_ib700-test.c
@@ -13,7 +13,7 @@

 static void qmp_check_no_event(void)
 {
-    QDict *resp = qmp("{'execute':'query-status'}");
+    QDict *resp = qmp_cmd("query-status");
     g_assert(qdict_haskey(resp, "return"));
     QDECREF(resp);
 }
-- 
2.13.3

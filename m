Received: from eggs.gnu.org ([2001:4830:134:3::10]:60691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNw-0000H7-9e
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNu-0004y1-B4
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:40 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 20:25:51 -0500
Message-Id: <20170804012551.2714-23-eblake@redhat.com>
In-Reply-To: <20170804012551.2714-1-eblake@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 22/22] libqtest: Rename qmp_cmd() to qmp()
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

Now that the previous patch got rid of the old signature of qmp(),
we can go back to using the shortest possible name for the common
action.

Performed mechanically with:
 for f in $(git grep -l qmp_cmd tests/); do
   case $f in *qemu-iotests*) continue;; esac
   sed -i s/qmp_cmd/qmp/ $f; done

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h               | 10 +++++-----
 tests/libqtest.c               |  8 ++++----
 tests/ahci-test.c              |  2 +-
 tests/boot-order-test.c        |  2 +-
 tests/ide-test.c               |  2 +-
 tests/libqos/ahci.c            |  4 ++--
 tests/libqos/libqos.c          |  4 ++--
 tests/numa-test.c              |  2 +-
 tests/postcopy-test.c          |  8 ++++----
 tests/q35-test.c               |  2 +-
 tests/qmp-test.c               |  8 ++++----
 tests/qom-test.c               |  2 +-
 tests/test-filter-mirror.c     |  2 +-
 tests/test-filter-redirector.c |  4 ++--
 tests/test-x86-cpuid-compat.c  |  2 +-
 tests/virtio-net-test.c        |  6 +++---
 tests/vmgenid-test.c           |  2 +-
 tests/wdt_ib700-test.c         |  2 +-
 18 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 04b36a7b11..874f0f9c35 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -465,20 +465,20 @@ static inline void qtest_end(void)
 QDict *qmp_raw(const char *msg);

 /**
- * qmp_cmd:
+ * qmp:
  * @cmd: QMP command, with no arguments.
  *
  * Sends a QMP message to QEMU and returns the response.
  */
-QDict *qmp_cmd(const char *cmd);
+QDict *qmp(const char *cmd);

 /**
- * qmp_cmd_async:
+ * qmp_async:
  * @cmd: QMP command, with no arguments.
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
-void qmp_cmd_async(const char *cmd);
+void qmp_async(const char *cmd);

 /**
  * qmp_args_dict:
@@ -512,7 +512,7 @@ void qmp_args_async(const char *cmd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 /**
  * qmp_discard_response:
  *
- * Read and discard a QMP response, typically after qmp_cmd_async().
+ * Read and discard a QMP response, typically after qmp_async().
  */
 void qmp_discard_response(void);

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 4597d4ac66..50e6c312a4 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -834,13 +834,13 @@ QDict *qmp_raw(const char *msg)
     return qtest_qmp_receive(global_qtest);
 }

-QDict *qmp_cmd(const char *cmd)
+QDict *qmp(const char *cmd)
 {
-    qmp_cmd_async(cmd);
+    qmp_async(cmd);
     return qtest_qmp_receive(global_qtest);
 }

-void qmp_cmd_async(const char *cmd)
+void qmp_async(const char *cmd)
 {
     qtest_qmp_send(global_qtest, "{'execute':%s}", cmd);
 }
@@ -912,7 +912,7 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine))
     const char *mname;

     qtest_start("-machine none");
-    response = qmp_cmd("query-machines");
+    response = qmp("query-machines");
     g_assert(response);
     list = qdict_get_qlist(response, "return");
     g_assert(list);
diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index ee8a539cf6..96a7249157 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -1385,7 +1385,7 @@ static void test_flush_migrate(void)
     ahci_migrate(src, dst, uri);

     /* Complete the command */
-    qmp_cmd_async("cont");
+    qmp_async("cont");
     qmp_eventwait("RESUME");
     ahci_command_wait(dst, cmd);
     ahci_command_verify(dst, cmd);
diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index 0be3333e6b..cd883c05c7 100644
--- a/tests/boot-order-test.c
+++ b/tests/boot-order-test.c
@@ -38,7 +38,7 @@ static void test_a_boot_order(const char *machine,
     qtest_start(args);
     actual = read_boot_order();
     g_assert_cmphex(actual, ==, expected_boot);
-    qmp_cmd_async("system_reset");
+    qmp_async("system_reset");
     /*
      * system_reset only requests reset.  We get a RESET event after
      * the actual reset completes.  Need to wait for that.
diff --git a/tests/ide-test.c b/tests/ide-test.c
index 56a02b1c7f..5819c2ed24 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -651,7 +651,7 @@ static void test_retry_flush(const char *machine)
     qmp_eventwait("STOP");

     /* Complete the command */
-    qmp_cmd_async("cont");
+    qmp_async("cont");
     qmp_discard_response();

     /* Check registers */
diff --git a/tests/libqos/ahci.c b/tests/libqos/ahci.c
index 06b9ce3a13..8bdf8ef246 100644
--- a/tests/libqos/ahci.c
+++ b/tests/libqos/ahci.c
@@ -668,7 +668,7 @@ void ahci_exec(AHCIQState *ahci, uint8_t port,
         g_assert_cmpint(rc, ==, 0);
     }
     if (opts->error) {
-        qmp_cmd_async("cont");
+        qmp_async("cont");
         qmp_eventwait("RESUME");
     }

@@ -706,7 +706,7 @@ AHCICommand *ahci_guest_io_halt(AHCIQState *ahci, uint8_t port,
 void ahci_guest_io_resume(AHCIQState *ahci, AHCICommand *cmd)
 {
     /* Complete the command */
-    qmp_cmd_async("cont");
+    qmp_async("cont");
     qmp_eventwait("RESUME");
     ahci_command_wait(ahci, cmd);
     ahci_command_verify(ahci, cmd);
diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index ba2707f89e..c215b81833 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -93,7 +93,7 @@ void migrate(QOSState *from, QOSState *to, const char *uri)
     set_context(from);

     /* Is the machine currently running? */
-    rsp = qmp_cmd("query-status");
+    rsp = qmp("query-status");
     g_assert(qdict_haskey(rsp, "return"));
     sub = qdict_get_qdict(rsp, "return");
     g_assert(qdict_haskey(sub, "running"));
@@ -120,7 +120,7 @@ void migrate(QOSState *from, QOSState *to, const char *uri)

     /* Otherwise, we need to wait: poll until migration is completed. */
     while (1) {
-        rsp = qmp_cmd("query-migrate");
+        rsp = qmp("query-migrate");
         g_assert(qdict_haskey(rsp, "return"));
         sub = qdict_get_qdict(rsp, "return");
         g_assert(qdict_haskey(sub, "status"));
diff --git a/tests/numa-test.c b/tests/numa-test.c
index d98500012f..237a9387d2 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -74,7 +74,7 @@ static void test_mon_partial(const void *data)

 static QList *get_cpus(QDict **resp)
 {
-    *resp = qmp_cmd("query-cpus");
+    *resp = qmp("query-cpus");
     g_assert(*resp);
     g_assert(qdict_haskey(*resp, "return"));
     return qdict_get_qlist(*resp, "return");
diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index 4e585006a8..98478f7f14 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -252,7 +252,7 @@ static uint64_t get_migration_pass(void)
     QDict *rsp, *rsp_return, *rsp_ram;
     uint64_t result;

-    rsp = return_or_event(qmp_cmd("query-migrate"));
+    rsp = return_or_event(qmp("query-migrate"));
     rsp_return = qdict_get_qdict(rsp, "return");
     if (!qdict_haskey(rsp_return, "ram")) {
         /* Still in setup */
@@ -273,7 +273,7 @@ static void wait_for_migration_complete(void)
     do {
         const char *status;

-        rsp = return_or_event(qmp_cmd("query-migrate"));
+        rsp = return_or_event(qmp("query-migrate"));
         rsp_return = qdict_get_qdict(rsp, "return");
         status = qdict_get_str(rsp_return, "status");
         completed = strcmp(status, "completed") == 0;
@@ -445,7 +445,7 @@ static void test_migrate(void)

     wait_for_migration_pass();

-    rsp = return_or_event(qmp_cmd("migrate-start-postcopy"));
+    rsp = return_or_event(qmp("migrate-start-postcopy"));
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

@@ -472,7 +472,7 @@ static void test_migrate(void)
         usleep(10 * 1000);
     } while (dest_byte_a == dest_byte_b);

-    qmp_cmd_async("stop");
+    qmp_async("stop");
     qmp_discard_response();
     /* With it stopped, check nothing changes */
     qtest_memread(to, start_address, &dest_byte_c, 1);
diff --git a/tests/q35-test.c b/tests/q35-test.c
index 122872b90d..20de9b0937 100644
--- a/tests/q35-test.c
+++ b/tests/q35-test.c
@@ -105,7 +105,7 @@ static void test_smram_lock(void)
     g_assert(smram_test_bit(pcidev, MCH_HOST_BRIDGE_SMRAM_D_OPEN) == false);

     /* reset */
-    response = qmp_cmd("system_reset");
+    response = qmp("system_reset");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 082c5f7e8d..150df1bf2e 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -92,7 +92,7 @@ static void test_qmp_protocol(void)
     QDECREF(resp);

     /* Test valid command before handshake */
-    resp = qmp_cmd("query-version");
+    resp = qmp("query-version");
     g_assert_cmpstr(get_error_class(resp), ==, "CommandNotFound");
     QDECREF(resp);

@@ -100,18 +100,18 @@ static void test_qmp_protocol(void)
     test_malformed();

     /* Test handshake */
-    resp = qmp_cmd("qmp_capabilities");
+    resp = qmp("qmp_capabilities");
     ret = qdict_get_qdict(resp, "return");
     g_assert(ret && !qdict_size(ret));
     QDECREF(resp);

     /* Test repeated handshake */
-    resp = qmp_cmd("qmp_capabilities");
+    resp = qmp("qmp_capabilities");
     g_assert_cmpstr(get_error_class(resp), ==, "CommandNotFound");
     QDECREF(resp);

     /* Test valid command */
-    resp = qmp_cmd("query-version");
+    resp = qmp("query-version");
     test_version(qdict_get(resp, "return"));
     QDECREF(resp);

diff --git a/tests/qom-test.c b/tests/qom-test.c
index 3c315cf864..2970f62bf5 100644
--- a/tests/qom-test.c
+++ b/tests/qom-test.c
@@ -95,7 +95,7 @@ static void test_machine(gconstpointer data)

     test_properties("/machine", true);

-    response = qmp_cmd("quit");
+    response = qmp("quit");
     g_assert(qdict_haskey(response, "return"));
     QDECREF(response);

diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
index 0fb87c124d..8980c288d4 100644
--- a/tests/test-filter-mirror.c
+++ b/tests/test-filter-mirror.c
@@ -57,7 +57,7 @@ static void test_mirror(void)
     };

     /* send a qmp command to guarantee that 'connected' is setting to true. */
-    qmp_cmd_async("query-status");
+    qmp_async("query-status");
     qmp_discard_response();
     ret = iov_send(send_sock[0], iov, 2, 0, sizeof(size) + sizeof(send_buf));
     g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(size));
diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redirector.c
index 00f58f63b5..14ea136b4d 100644
--- a/tests/test-filter-redirector.c
+++ b/tests/test-filter-redirector.c
@@ -99,7 +99,7 @@ static void test_redirector_tx(void)
     g_assert_cmpint(recv_sock, !=, -1);

     /* send a qmp command to guarantee that 'connected' is setting to true. */
-    qmp_cmd_async("query-status");
+    qmp_async("query-status");
     qmp_discard_response();

     struct iovec iov[] = {
@@ -185,7 +185,7 @@ static void test_redirector_rx(void)
     send_sock = unix_connect(sock_path1, NULL);
     g_assert_cmpint(send_sock, !=, -1);
     /* send a qmp command to guarantee that 'connected' is setting to true. */
-    qmp_cmd_async("query-status");
+    qmp_async("query-status");
     qmp_discard_response();

     ret = iov_send(send_sock, iov, 2, 0, sizeof(size) + sizeof(send_buf));
diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.c
index 536e1cae2c..9a0b42475f 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -13,7 +13,7 @@ static char *get_cpu0_qom_path(void)
     QDict *cpu0;
     char *path;

-    resp = qmp_cmd("query-cpus");
+    resp = qmp("query-cpus");
     g_assert(qdict_haskey(resp, "return"));
     ret = qdict_get_qlist(resp, "return");

diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 5d934d19c2..e204a9c561 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -167,7 +167,7 @@ static void rx_stop_cont_test(QVirtioDevice *dev,
     free_head = qvirtqueue_add(vq, req_addr, 64, true, false);
     qvirtqueue_kick(dev, vq, free_head);

-    qmp_cmd_async("stop");
+    qmp_async("stop");
     qmp_discard_response();

     ret = iov_send(socket, iov, 2, 0, sizeof(len) + sizeof(test));
@@ -176,9 +176,9 @@ static void rx_stop_cont_test(QVirtioDevice *dev,
     /* We could check the status, but this command is more importantly to
      * ensure the packet data gets queued in QEMU, before we do 'cont'.
      */
-    qmp_cmd_async("query-status");
+    qmp_async("query-status");
     qmp_discard_response();
-    qmp_cmd_async("cont");
+    qmp_async("cont");
     qmp_discard_response();

     qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_NET_TIMEOUT_US);
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 0842833eba..44385adb38 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -118,7 +118,7 @@ static void read_guid_from_monitor(QemuUUID *guid)
     QDict *rsp, *rsp_ret;
     const char *guid_str;

-    rsp = qmp_cmd("query-vm-generation-id");
+    rsp = qmp("query-vm-generation-id");
     if (qdict_haskey(rsp, "return")) {
         rsp_ret = qdict_get_qdict(rsp, "return");
         g_assert(qdict_haskey(rsp_ret, "guid"));
diff --git a/tests/wdt_ib700-test.c b/tests/wdt_ib700-test.c
index a5fd795cc9..c22e4f8fc3 100644
--- a/tests/wdt_ib700-test.c
+++ b/tests/wdt_ib700-test.c
@@ -13,7 +13,7 @@

 static void qmp_check_no_event(void)
 {
-    QDict *resp = qmp_cmd("query-status");
+    QDict *resp = qmp("query-status");
     g_assert(qdict_haskey(resp, "return"));
     QDECREF(resp);
 }
-- 
2.13.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSPk-0000C4-OC
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSPf-0001qN-UZ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:22:28 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:20:21 -0500
Message-Id: <20170911172022.4738-38-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 37/38] libqtest: Separate
 qmp_discard_response() from command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>

Upcoming patches will be adding new convenience methods for
constructing QMP commands.  But making every variation of sending
support every variation of response handling becomes unwieldy;
it's easier to specify that discarding a JSON response is
unassociated with sending the command, where qmp_async() already
fits the bill for sending a command without tying up a reference
to the response.

Doing this renders qtest_qmpv_discard_response() unused.

Bonus: gets rid of a non-literal format string in ide-test, which
is a step towards compile-time format string checking without
triggering -Wformat-nonliteral.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h               | 20 ++++----------------
 tests/libqtest.c               | 27 ++++++++-------------------
 tests/ahci-test.c              | 26 +++++++++++++-------------
 tests/boot-order-test.c        |  2 +-
 tests/drive_del-test.c         |  5 +++--
 tests/fdc-test.c               | 11 ++++++-----
 tests/ide-test.c               |  5 ++---
 tests/postcopy-test.c          |  3 ++-
 tests/test-filter-mirror.c     |  3 ++-
 tests/test-filter-redirector.c |  6 ++++--
 tests/virtio-blk-test.c        | 21 ++++++++++++---------
 11 files changed, 57 insertions(+), 72 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 8f2946ff5e..b811394d4d 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -69,11 +69,10 @@ void qtest_quit(QTestState *s);
 /**
  * qtest_qmp_discard_response:
  * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu
  *
- * Sends a QMP message to QEMU and consumes the response.
+ * Read and discard a QMP response, typically after qtest_async_qmp().
  */
-void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...);
+void qtest_qmp_discard_response(QTestState *s);

 /**
  * qtest_qmp:
@@ -94,16 +93,6 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
 void qtest_async_qmp(QTestState *s, const char *fmt, ...);

 /**
- * qtest_qmpv_discard_response:
- * @s: #QTestState instance to operate on.
- * @fmt: QMP message to send to QEMU
- * @ap: QMP message arguments
- *
- * Sends a QMP message to QEMU and consumes the response.
- */
-void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap);
-
-/**
  * qtest_qmpv:
  * @s: #QTestState instance to operate on.
  * @fmt: QMP message to send to QEMU
@@ -543,11 +532,10 @@ void qmp_async(const char *fmt, ...);

 /**
  * qmp_discard_response:
- * @fmt...: QMP message to send to qemu
  *
- * Sends a QMP message to QEMU and consumes the response.
+ * Read and discard a QMP response, typically after qmp_async().
  */
-void qmp_discard_response(const char *fmt, ...);
+void qmp_discard_response(void);

 /**
  * qmp_receive:
diff --git a/tests/libqtest.c b/tests/libqtest.c
index ac38f6d4bb..747411b5b5 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -238,8 +238,9 @@ QTestState *qtest_start(const char *extra_args)
     QTestState *s = qtest_start_without_qmp_handshake(extra_args);

     /* Read the QMP greeting and then do the handshake */
-    qtest_qmp_discard_response(s, "");
-    qtest_qmp_discard_response(s, "{ 'execute': 'qmp_capabilities' }");
+    qtest_qmp_discard_response(s);
+    qtest_async_qmp(s, "{ 'execute': 'qmp_capabilities' }");
+    qtest_qmp_discard_response(s);

     assert(!global_qtest);
     return s;
@@ -566,20 +567,10 @@ void qtest_async_qmp(QTestState *s, const char *fmt, ...)
     va_end(ap);
 }

-void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap)
+void qtest_qmp_discard_response(QTestState *s)
 {
-    QDict *response = qtest_qmpv(s, fmt, ap);
-    QDECREF(response);
-}
+    QDict *response = qtest_qmp_receive(s);

-void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...)
-{
-    va_list ap;
-    QDict *response;
-
-    va_start(ap, fmt);
-    response = qtest_qmpv(s, fmt, ap);
-    va_end(ap);
     QDECREF(response);
 }

@@ -955,13 +946,11 @@ void qmp_async(const char *fmt, ...)
     va_end(ap);
 }

-void qmp_discard_response(const char *fmt, ...)
+void qmp_discard_response(void)
 {
-    va_list ap;
+    QDict *response = qmp_receive();

-    va_start(ap, fmt);
-    qtest_qmpv_discard_response(global_qtest, fmt, ap);
-    va_end(ap);
+    QDECREF(response);
 }
 char *hmp(const char *fmt, ...)
 {
diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 18af01501f..a0ed334604 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -1589,9 +1589,10 @@ static void test_atapi_tray(void)
     rsp = qtest_qmp_receive(ahci->parent->qts);
     QDECREF(rsp);

-    qtest_qmp_discard_response(ahci->parent->qts,
-                               "{'execute': 'x-blockdev-remove-medium', "
-                               "'arguments': {'device': 'drive0'}}");
+    qtest_async_qmp(ahci->parent->qts,
+                    "{'execute': 'x-blockdev-remove-medium', "
+                    "'arguments': {'device': 'drive0'}}");
+    qtest_qmp_discard_response(ahci->parent->qts);

     /* Test the tray without a medium */
     ahci_atapi_load(ahci, port);
@@ -1601,16 +1602,15 @@ static void test_atapi_tray(void)
     atapi_wait_tray(ahci, true);

     /* Re-insert media */
-    qtest_qmp_discard_response(ahci->parent->qts,
-                               "{'execute': 'blockdev-add', "
-                               "'arguments': {'node-name': 'node0', "
-                                        "'driver': 'raw', "
-                                        "'file': { 'driver': 'file', "
-                                                  "'filename': %s }}}", iso);
-    qtest_qmp_discard_response(ahci->parent->qts,
-                               "{'execute': 'x-blockdev-insert-medium',"
-                               "'arguments': { 'device': 'drive0', "
-                                         "'node-name': 'node0' }}");
+    qtest_async_qmp(ahci->parent->qts,
+                    "{'execute': 'blockdev-add', 'arguments': {"
+                    "  'node-name': 'node0', 'driver': 'raw', "
+                    "  'file': { 'driver': 'file', 'filename': %s }}}", iso);
+    qtest_qmp_discard_response(ahci->parent->qts);
+    qtest_async_qmp(ahci->parent->qts,
+                    "{'execute': 'x-blockdev-insert-medium',"
+                    "'arguments': {'device': 'drive0', 'node-name': 'node0'}}");
+    qtest_qmp_discard_response(ahci->parent->qts);

     /* Again, the event shows up first */
     qtest_async_qmp(ahci->parent->qts, "{'execute': 'blockdev-close-tray', "
diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index 048c8721c6..5cd793e075 100644
--- a/tests/boot-order-test.c
+++ b/tests/boot-order-test.c
@@ -36,7 +36,7 @@ static void test_a_boot_order(const char *machine,
                                 test_args);
     actual = read_boot_order();
     g_assert_cmphex(actual, ==, expected_boot);
-    qmp_discard_response("{ 'execute': 'system_reset' }");
+    qmp_async("{ 'execute': 'system_reset' }");
     /*
      * system_reset only requests reset.  We get a RESET event after
      * the actual reset completes.  Need to wait for that.
diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index f68c4bc176..0fde0c2040 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -34,8 +34,9 @@ static void device_del(void)
     QDict *response;

     /* Complication: ignore DEVICE_DELETED event */
-    qmp_discard_response("{'execute': 'device_del',"
-                         " 'arguments': { 'id': 'dev0' } }");
+    qmp_async("{'execute': 'device_del',"
+              " 'arguments': { 'id': 'dev0' } }");
+    qmp_discard_response();
     response = qmp_receive();
     g_assert(response);
     g_assert(qdict_haskey(response, "return"));
diff --git a/tests/fdc-test.c b/tests/fdc-test.c
index 7803ff2789..241b13e4de 100644
--- a/tests/fdc-test.c
+++ b/tests/fdc-test.c
@@ -298,9 +298,10 @@ static void test_media_insert(void)

     /* Insert media in drive. DSKCHK should not be reset until a step pulse
      * is sent. */
-    qmp_discard_response("{'execute':'blockdev-change-medium', 'arguments':{"
-                         " 'id':'floppy0', 'filename': %s, 'format': 'raw' }}",
-                         test_image);
+    qmp_async("{'execute':'blockdev-change-medium', 'arguments':{"
+              " 'id':'floppy0', 'filename': %s, 'format': 'raw' }}",
+              test_image);
+    qmp_discard_response();

     dir = inb(global_qtest, FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);
@@ -329,8 +330,8 @@ static void test_media_change(void)

     /* Eject the floppy and check that DSKCHG is set. Reading it out doesn't
      * reset the bit. */
-    qmp_discard_response("{'execute':'eject', 'arguments':{"
-                         " 'id':'floppy0' }}");
+    qmp_async("{'execute':'eject', 'arguments':{ 'id':'floppy0' }}");
+    qmp_discard_response();

     dir = inb(global_qtest, FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);
diff --git a/tests/ide-test.c b/tests/ide-test.c
index c47cbb1949..6ba3a8589d 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -621,7 +621,6 @@ static void test_retry_flush(const char *machine)
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
     uint8_t data;
-    const char *s;

     prepare_blkdebug_script(debug_path, "flush_to_disk");

@@ -649,8 +648,8 @@ static void test_retry_flush(const char *machine)
     qmp_eventwait("STOP");

     /* Complete the command */
-    s = "{'execute':'cont' }";
-    qmp_discard_response(s);
+    qmp_async("{'execute':'cont' }");
+    qmp_discard_response();

     /* Check registers */
     data = qpci_io_readb(dev, ide_bar, reg_device);
diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index 04889b8078..9c995ee3e5 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -478,7 +478,8 @@ static void test_migrate(void)
         usleep(10 * 1000);
     } while (dest_byte_a == dest_byte_b);

-    qtest_qmp_discard_response(to, "{ 'execute' : 'stop'}");
+    qtest_async_qmp(to, "{ 'execute' : 'stop'}");
+    qtest_qmp_discard_response(to);
     /* With it stopped, check nothing changes */
     memread(to, start_address, &dest_byte_c, 1);
     sleep(1);
diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
index c590698991..3fc1211681 100644
--- a/tests/test-filter-mirror.c
+++ b/tests/test-filter-mirror.c
@@ -57,7 +57,8 @@ static void test_mirror(void)
     };

     /* send a qmp command to guarantee that 'connected' is setting to true. */
-    qmp_discard_response("{ 'execute' : 'query-status'}");
+    qmp_async("{ 'execute' : 'query-status'}");
+    qmp_discard_response();
     ret = iov_send(send_sock[0], iov, 2, 0, sizeof(size) + sizeof(send_buf));
     g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(size));
     close(send_sock[0]);
diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redirector.c
index bcb338e7c1..a10649d4fc 100644
--- a/tests/test-filter-redirector.c
+++ b/tests/test-filter-redirector.c
@@ -104,7 +104,8 @@ static void test_redirector_tx(void)
     g_assert_cmpint(recv_sock, !=, -1);

     /* send a qmp command to guarantee that 'connected' is setting to true. */
-    qmp_discard_response("{ 'execute' : 'query-status'}");
+    qmp_async("{ 'execute' : 'query-status'}");
+    qmp_discard_response();

     struct iovec iov[] = {
         {
@@ -182,7 +183,8 @@ static void test_redirector_rx(void)
     send_sock = unix_connect(sock_path1, NULL);
     g_assert_cmpint(send_sock, !=, -1);
     /* send a qmp command to guarantee that 'connected' is setting to true. */
-    qmp_discard_response("{ 'execute' : 'query-status'}");
+    qmp_async("{ 'execute' : 'query-status'}");
+    qmp_discard_response();

     ret = iov_send(send_sock, iov, 2, 0, sizeof(size) + sizeof(send_buf));
     g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(size));
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index ec582c8e1c..78ca44b520 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -410,9 +410,10 @@ static void pci_config(void)

     qvirtio_set_driver_ok(&dev->vdev);

-    qmp_discard_response("{ 'execute': 'block_resize', "
-                         " 'arguments': { 'device': 'drive0', "
-                         " 'size': %d } }", n_size);
+    qmp_async("{ 'execute': 'block_resize', "
+              " 'arguments': { 'device': 'drive0', "
+              " 'size': %d } }", n_size);
+    qmp_discard_response();
     qvirtio_wait_config_isr(&dev->vdev, QVIRTIO_BLK_TIMEOUT_US);

     capacity = qvirtio_config_readq(&dev->vdev, 0);
@@ -460,9 +461,10 @@ static void pci_msix(void)

     qvirtio_set_driver_ok(&dev->vdev);

-    qmp_discard_response("{ 'execute': 'block_resize', "
-                         " 'arguments': { 'device': 'drive0', "
-                         " 'size': %d } }", n_size);
+    qmp_async("{ 'execute': 'block_resize', "
+              " 'arguments': { 'device': 'drive0', "
+              " 'size': %d } }", n_size);
+    qmp_discard_response();

     qvirtio_wait_config_isr(&dev->vdev, QVIRTIO_BLK_TIMEOUT_US);

@@ -702,9 +704,10 @@ static void mmio_basic(void)

     test_basic(&dev->vdev, alloc, vq);

-    qmp_discard_response("{ 'execute': 'block_resize', "
-                         " 'arguments': { 'device': 'drive0', "
-                         " 'size': %d } }", n_size);
+    qmp_async("{ 'execute': 'block_resize', "
+              " 'arguments': { 'device': 'drive0', "
+              " 'size': %d } }", n_size);
+    qmp_discard_response();

     qvirtio_wait_queue_isr(&dev->vdev, vq, QVIRTIO_BLK_TIMEOUT_US);

-- 
2.13.5

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNg-0008WQ-6f
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNd-0004HP-Vi
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:24 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 20:25:43 -0500
Message-Id: <20170804012551.2714-15-eblake@redhat.com>
In-Reply-To: <20170804012551.2714-1-eblake@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 14/22] libqtest: Separate
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
Cc: armbru@redhat.com, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>

Upcoming patches will be adding new convenience methods for
constructing QMP commands.  But making every variation of sending
support every variation of response handling becomes unwieldy;
it's easier to specify that discarding a JSON response is
unassociated with sending the command, where qmp_async() already
fits the bill for sending a command without tying up a reference
to the response.

Doing this renders qtest_qmp[v]_discard_response() unused.

Bonus: gets rid of a non-literal format string, which is a step
towards compile-time format string checking without triggering
-Wformat-nonliteral.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h               | 27 ++-------------------------
 tests/libqtest.c               | 30 ++++++------------------------
 tests/ahci-test.c              | 20 ++++++++++----------
 tests/boot-order-test.c        |  2 +-
 tests/drive_del-test.c         |  5 +++--
 tests/fdc-test.c               | 11 ++++++-----
 tests/ide-test.c               |  5 ++---
 tests/postcopy-test.c          |  3 ++-
 tests/test-filter-mirror.c     |  3 ++-
 tests/test-filter-redirector.c |  6 ++++--
 tests/virtio-blk-test.c        | 21 ++++++++++++---------
 11 files changed, 50 insertions(+), 83 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 917ec5cf92..6bae0223aa 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -48,16 +48,6 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
 void qtest_quit(QTestState *s);

 /**
- * qtest_qmp_discard_response:
- * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu; formats arguments through
- * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
- *
- * Sends a QMP message to QEMU and consumes the response.
- */
-void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...);
-
-/**
  * qtest_qmp:
  * @s: #QTestState instance to operate on.
  * @fmt...: QMP message to send to qemu; formats arguments through
@@ -78,17 +68,6 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
 void qtest_async_qmp(QTestState *s, const char *fmt, ...);

 /**
- * qtest_qmpv_discard_response:
- * @s: #QTestState instance to operate on.
- * @fmt: QMP message to send to QEMU; formats arguments through
- * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
- * @ap: QMP message arguments
- *
- * Sends a QMP message to QEMU and consumes the response.
- */
-void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap);
-
-/**
  * qtest_qmpv:
  * @s: #QTestState instance to operate on.
  * @fmt: QMP message to send to QEMU; formats arguments through
@@ -568,12 +547,10 @@ void qmp_async(const char *fmt, ...);

 /**
  * qmp_discard_response:
- * @fmt...: QMP message to send to qemu; formats arguments through
- * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
  *
- * Sends a QMP message to QEMU and consumes the response.
+ * Read and discard a QMP response, typically after qmp_async().
  */
-void qmp_discard_response(const char *fmt, ...);
+void qmp_discard_response(void);

 /**
  * qmp_receive:
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 3071be2efb..f9781d67f5 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -235,7 +235,8 @@ QTestState *qtest_init(const char *extra_args)
     /* Read the QMP greeting and then do the handshake */
     greeting = qtest_qmp_receive(s);
     QDECREF(greeting);
-    qtest_qmp_discard_response(s, "{ 'execute': 'qmp_capabilities' }");
+    greeting = qtest_qmp(s, "{ 'execute': 'qmp_capabilities' }");
+    QDECREF(greeting);

     return s;
 }
@@ -518,23 +519,6 @@ void qtest_async_qmp(QTestState *s, const char *fmt, ...)
     va_end(ap);
 }

-void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap)
-{
-    QDict *response = qtest_qmpv(s, fmt, ap);
-    QDECREF(response);
-}
-
-void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...)
-{
-    va_list ap;
-    QDict *response;
-
-    va_start(ap, fmt);
-    response = qtest_qmpv(s, fmt, ap);
-    va_end(ap);
-    QDECREF(response);
-}
-
 QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event)
 {
     QDict *response;
@@ -909,14 +893,12 @@ void qmp_async(const char *fmt, ...)
     va_end(ap);
 }

-void qmp_discard_response(const char *fmt, ...)
+void qmp_discard_response(void)
 {
-    va_list ap;
-
-    va_start(ap, fmt);
-    qtest_qmpv_discard_response(global_qtest, fmt, ap);
-    va_end(ap);
+    QDict *response = qtest_qmp_receive(global_qtest);
+    QDECREF(response);
 }
+
 char *hmp(const char *fmt, ...)
 {
     va_list ap;
diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 999121bb7c..9460843a9f 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -1596,8 +1596,9 @@ static void test_atapi_tray(void)
     rsp = qmp_receive();
     QDECREF(rsp);

-    qmp_discard_response("{'execute': 'x-blockdev-remove-medium', "
-                         "'arguments': {'device': 'drive0'}}");
+    qmp_async("{'execute': 'x-blockdev-remove-medium', "
+              "'arguments': {'device': 'drive0'}}");
+    qmp_discard_response();

     /* Test the tray without a medium */
     ahci_atapi_load(ahci, port);
@@ -1607,14 +1608,13 @@ static void test_atapi_tray(void)
     atapi_wait_tray(true);

     /* Re-insert media */
-    qmp_discard_response("{'execute': 'blockdev-add', "
-                          "'arguments': {'node-name': 'node0', "
-                                        "'driver': 'raw', "
-                                        "'file': { 'driver': 'file', "
-                                                  "'filename': %s }}}", iso);
-    qmp_discard_response("{'execute': 'x-blockdev-insert-medium',"
-                          "'arguments': { 'device': 'drive0', "
-                                         "'node-name': 'node0' }}");
+    qmp_async("{'execute': 'blockdev-add', 'arguments': {"
+              "  'node-name': 'node0', 'driver': 'raw', "
+              "  'file': { 'driver': 'file', 'filename': %s }}}", iso);
+    qmp_discard_response();
+    qmp_async("{'execute': 'x-blockdev-insert-medium',"
+              "'arguments': { 'device': 'drive0', 'node-name': 'node0' }}");
+    qmp_discard_response();

     /* Again, the event shows up first */
     qmp_async("{'execute': 'blockdev-close-tray', "
diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index 9d516830dd..4114720236 100644
--- a/tests/boot-order-test.c
+++ b/tests/boot-order-test.c
@@ -38,7 +38,7 @@ static void test_a_boot_order(const char *machine,
     qtest_start(args);
     actual = read_boot_order();
     g_assert_cmphex(actual, ==, expected_boot);
-    qmp_discard_response("{ 'execute': 'system_reset' }");
+    qmp_async("{ 'execute': 'system_reset' }");
     /*
      * system_reset only requests reset.  We get a RESET event after
      * the actual reset completes.  Need to wait for that.
diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index 2175139abb..834a634da3 100644
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
index 325712e0f2..ab61a82873 100644
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

     dir = inb(FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);
@@ -329,8 +330,8 @@ static void test_media_change(void)

     /* Eject the floppy and check that DSKCHG is set. Reading it out doesn't
      * reset the bit. */
-    qmp_discard_response("{'execute':'eject', 'arguments':{"
-                         " 'id':'floppy0' }}");
+    qmp_async("{'execute':'eject', 'arguments':{ 'id':'floppy0' }}");
+    qmp_discard_response();

     dir = inb(FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);
diff --git a/tests/ide-test.c b/tests/ide-test.c
index bfd79ddbdc..757af7cd1d 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -624,7 +624,6 @@ static void test_retry_flush(const char *machine)
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
     uint8_t data;
-    const char *s;

     prepare_blkdebug_script(debug_path, "flush_to_disk");

@@ -652,8 +651,8 @@ static void test_retry_flush(const char *machine)
     qmp_eventwait("STOP");

     /* Complete the command */
-    s = "{'execute':'cont' }";
-    qmp_discard_response(s);
+    qmp_async("{'execute':'cont' }");
+    qmp_discard_response();

     /* Check registers */
     data = qpci_io_readb(dev, ide_bar, reg_device);
diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index 8142f2ab90..ceaed823eb 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -482,7 +482,8 @@ static void test_migrate(void)
         usleep(10 * 1000);
     } while (dest_byte_a == dest_byte_b);

-    qmp_discard_response("{ 'execute' : 'stop'}");
+    qmp_async("{ 'execute' : 'stop'}");
+    qmp_discard_response();
     /* With it stopped, check nothing changes */
     qtest_memread(to, start_address, &dest_byte_c, 1);
     sleep(1);
diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
index 9f84402493..79c5306fe7 100644
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
index 0c4b8d52ef..a6a714abea 100644
--- a/tests/test-filter-redirector.c
+++ b/tests/test-filter-redirector.c
@@ -99,7 +99,8 @@ static void test_redirector_tx(void)
     g_assert_cmpint(recv_sock, !=, -1);

     /* send a qmp command to guarantee that 'connected' is setting to true. */
-    qmp_discard_response("{ 'execute' : 'query-status'}");
+    qmp_async("{ 'execute' : 'query-status'}");
+    qmp_discard_response();

     struct iovec iov[] = {
         {
@@ -184,7 +185,8 @@ static void test_redirector_rx(void)
     send_sock = unix_connect(sock_path1, NULL);
     g_assert_cmpint(send_sock, !=, -1);
     /* send a qmp command to guarantee that 'connected' is setting to true. */
-    qmp_discard_response("{ 'execute' : 'query-status'}");
+    qmp_async("{ 'execute' : 'query-status'}");
+    qmp_discard_response();

     ret = iov_send(send_sock, iov, 2, 0, sizeof(size) + sizeof(send_buf));
     g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(size));
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 0576cb16ba..fe966c0606 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -409,9 +409,10 @@ static void pci_config(void)

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
@@ -459,9 +460,10 @@ static void pci_msix(void)

     qvirtio_set_driver_ok(&dev->vdev);

-    qmp_discard_response("{ 'execute': 'block_resize', "
-                         " 'arguments': { 'device': 'drive0', "
-                         " 'size': %d } }", n_size);
+    qmp_async("{ 'execute': 'block_resize', "
+              " 'arguments': { 'device': 'drive0', "
+              " 'size': %d } }", n_size);
+    qmp_discard_response();

     qvirtio_wait_config_isr(&dev->vdev, QVIRTIO_BLK_TIMEOUT_US);

@@ -700,9 +702,10 @@ static void mmio_basic(void)

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
2.13.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fj4RX-00067g-Rq
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:14:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fj4RV-0000Dr-04
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:14:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48194 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fj4RU-0000DY-Q5
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:14:08 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 27 Jul 2018 17:13:57 +0200
Message-Id: <20180727151359.29061-22-armbru@redhat.com>
In-Reply-To: <20180727151359.29061-1-armbru@redhat.com>
References: <20180727151359.29061-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 21/23] libqtest: Remove
 qtest_qmp_discard_response() & friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org, eblake@redhat.com

qtest_qmp_discard_response(...) is shorthand for
qobject_unref(qtest_qmp(...), except it's not actually shorter.
Moreover, the presence of these functions encourage sloppy testing.
Remove them.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/ahci-test.c              | 12 ++++++------
 tests/boot-order-test.c        |  4 ++--
 tests/drive_del-test.c         |  4 ++--
 tests/fdc-test.c               |  9 +++++----
 tests/ide-test.c               |  4 ++--
 tests/libqtest.c               | 27 +-------------------------
 tests/libqtest.h               | 35 ----------------------------------
 tests/migration-test.c         |  2 +-
 tests/test-filter-mirror.c     |  3 ++-
 tests/test-filter-redirector.c |  5 +++--
 tests/virtio-blk-test.c        | 19 +++++++++---------
 11 files changed, 34 insertions(+), 90 deletions(-)

diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 19a7ab1bca..7a2d70fa34 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -1596,8 +1596,8 @@ static void test_atapi_tray(void)
     rsp = qmp_receive();
     qobject_unref(rsp);
 
-    qmp_discard_response("{'execute': 'blockdev-remove-medium', "
-                         "'arguments': {'id': 'cd0'}}");
+    qobject_unref(qmp("{'execute': 'blockdev-remove-medium', "
+                      "'arguments': {'id': 'cd0'}}"));
 
     /* Test the tray without a medium */
     ahci_atapi_load(ahci, port);
@@ -1607,14 +1607,14 @@ static void test_atapi_tray(void)
     atapi_wait_tray(true);
 
     /* Re-insert media */
-    qmp_discard_response("{'execute': 'blockdev-add', "
+    qobject_unref(qmp("{'execute': 'blockdev-add', "
                           "'arguments': {'node-name': 'node0', "
                                         "'driver': 'raw', "
                                         "'file': { 'driver': 'file', "
-                                                  "'filename': %s }}}", iso);
-    qmp_discard_response("{'execute': 'blockdev-insert-medium',"
+                      "'filename': %s }}}", iso));
+    qobject_unref(qmp("{'execute': 'blockdev-insert-medium',"
                           "'arguments': { 'id': 'cd0', "
-                                         "'node-name': 'node0' }}");
+                      "'node-name': 'node0' }}"));
 
     /* Again, the event shows up first */
     qmp_send("{'execute': 'blockdev-close-tray',"
diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index e70f5dedba..2ec86c0ee2 100644
--- a/tests/boot-order-test.c
+++ b/tests/boot-order-test.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "libqos/fw_cfg.h"
 #include "libqtest.h"
-
+#include "qapi/qmp/qdict.h"
 #include "hw/nvram/fw_cfg_keys.h"
 
 typedef struct {
@@ -36,7 +36,7 @@ static void test_a_boot_order(const char *machine,
                                 test_args);
     actual = read_boot_order();
     g_assert_cmphex(actual, ==, expected_boot);
-    qmp_discard_response("{ 'execute': 'system_reset' }");
+    qobject_unref(qmp("{ 'execute': 'system_reset' }"));
     /*
      * system_reset only requests reset.  We get a RESET event after
      * the actual reset completes.  Need to wait for that.
diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index 852fefc8f3..92489be0ba 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -36,8 +36,8 @@ static void device_del(void)
     QDict *response;
 
     /* Complication: ignore DEVICE_DELETED event */
-    qmp_discard_response("{'execute': 'device_del',"
-                         " 'arguments': { 'id': 'dev0' } }");
+    qobject_unref(qmp("{'execute': 'device_del',"
+                      " 'arguments': { 'id': 'dev0' } }"));
     response = qmp_receive();
     g_assert(response);
     g_assert(qdict_haskey(response, "return"));
diff --git a/tests/fdc-test.c b/tests/fdc-test.c
index 325712e0f2..5775555e71 100644
--- a/tests/fdc-test.c
+++ b/tests/fdc-test.c
@@ -26,6 +26,7 @@
 
 
 #include "libqtest.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu-common.h"
 
 #define TEST_IMAGE_SIZE 1440 * 1024
@@ -298,9 +299,9 @@ static void test_media_insert(void)
 
     /* Insert media in drive. DSKCHK should not be reset until a step pulse
      * is sent. */
-    qmp_discard_response("{'execute':'blockdev-change-medium', 'arguments':{"
+    qobject_unref(qmp("{'execute':'blockdev-change-medium', 'arguments':{"
                          " 'id':'floppy0', 'filename': %s, 'format': 'raw' }}",
-                         test_image);
+                      test_image));
 
     dir = inb(FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);
@@ -329,8 +330,8 @@ static void test_media_change(void)
 
     /* Eject the floppy and check that DSKCHG is set. Reading it out doesn't
      * reset the bit. */
-    qmp_discard_response("{'execute':'eject', 'arguments':{"
-                         " 'id':'floppy0' }}");
+    qobject_unref(qmp("{'execute':'eject', 'arguments':{"
+                      " 'id':'floppy0' }}"));
 
     dir = inb(FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);
diff --git a/tests/ide-test.c b/tests/ide-test.c
index 834ee9005b..48bb0e6519 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -29,7 +29,7 @@
 #include "libqos/libqos.h"
 #include "libqos/pci-pc.h"
 #include "libqos/malloc-pc.h"
-
+#include "qapi/qmp/qdict.h"
 #include "qemu-common.h"
 #include "qemu/bswap.h"
 #include "hw/pci/pci_ids.h"
@@ -721,7 +721,7 @@ static void test_retry_flush(const char *machine)
     qmp_eventwait("STOP");
 
     /* Complete the command */
-    qmp_discard_response("{'execute':'cont' }");
+    qobject_unref(qmp("{'execute':'cont' }"));
 
     /* Check registers */
     data = qpci_io_readb(dev, ide_bar, reg_device);
diff --git a/tests/libqtest.c b/tests/libqtest.c
index ed832cd8e6..2f81bc6382 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -254,7 +254,7 @@ QTestState *qtest_init(const char *extra_args)
     /* Read the QMP greeting and then do the handshake */
     greeting = qtest_qmp_receive(s);
     qobject_unref(greeting);
-    qtest_qmp_discard_response(s, "{ 'execute': 'qmp_capabilities' }");
+    qobject_unref(qtest_qmp(s, "{ 'execute': 'qmp_capabilities' }"));
 
     return s;
 }
@@ -587,23 +587,6 @@ void qtest_qmp_send(QTestState *s, const char *fmt, ...)
     va_end(ap);
 }
 
-void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap)
-{
-    QDict *response = qtest_qmpv(s, fmt, ap);
-    qobject_unref(response);
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
-    qobject_unref(response);
-}
-
 QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event)
 {
     QDict *response;
@@ -975,14 +958,6 @@ void qmp_send(const char *fmt, ...)
     va_end(ap);
 }
 
-void qmp_discard_response(const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start(ap, fmt);
-    qtest_qmpv_discard_response(global_qtest, fmt, ap);
-    va_end(ap);
-}
 char *hmp(const char *fmt, ...)
 {
     va_list ap;
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 327e402da5..58dea82c76 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -73,18 +73,6 @@ QTestState *qtest_init_without_qmp_handshake(bool use_oob,
  */
 void qtest_quit(QTestState *s);
 
-/**
- * qtest_qmp_discard_response:
- * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu, formatted like
- * qobject_from_jsonf_nofail().
- * Only understands '%((l|ll|I64)?d|[ipsf])', see parse_escape().
- *
- * Sends a QMP message to QEMU and consumes the response.
- */
-void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...)
-    GCC_FMT_ATTR(2, 3);
-
 /**
  * qtest_qmp:
  * @s: #QTestState instance to operate on.
@@ -109,19 +97,6 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...)
 void qtest_qmp_send(QTestState *s, const char *fmt, ...)
     GCC_FMT_ATTR(2, 3);
 
-/**
- * qtest_qmpv_discard_response:
- * @s: #QTestState instance to operate on.
- * @fmt: QMP message to send to QEMU, formatted like
- * qobject_from_jsonf_nofail().
- * Only understands '%((l|ll|I64)?d|[ipsf])', see parse_escape().
- * @ap: QMP message arguments
- *
- * Sends a QMP message to QEMU and consumes the response.
- */
-void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap)
-    GCC_FMT_ATTR(2, 0);
-
 /**
  * qtest_qmpv:
  * @s: #QTestState instance to operate on.
@@ -615,16 +590,6 @@ QDict *qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
  */
 void qmp_send(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
-/**
- * qmp_discard_response:
- * @fmt...: QMP message to send to qemu, formatted like
- * qobject_from_jsonf_nofail().
- * Only understands '%((l|ll|I64)?d|[ipsf])', see parse_escape().
- *
- * Sends a QMP message to QEMU and consumes the response.
- */
-void qmp_discard_response(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
-
 /**
  * qmp_receive:
  *
diff --git a/tests/migration-test.c b/tests/migration-test.c
index 132c30891d..1bcd32e284 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -491,7 +491,7 @@ static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
             usleep(1000 * 10);
         } while (dest_byte_a == dest_byte_b);
 
-        qtest_qmp_discard_response(to, "{ 'execute' : 'stop'}");
+        qobject_unref(qtest_qmp(to, "{ 'execute' : 'stop'}"));
 
         /* With it stopped, check nothing changes */
         qtest_memread(to, start_address, &dest_byte_c, 1);
diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
index 6c6f710dc6..1ab4759b80 100644
--- a/tests/test-filter-mirror.c
+++ b/tests/test-filter-mirror.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
@@ -57,7 +58,7 @@ static void test_mirror(void)
     };
 
     /* send a qmp command to guarantee that 'connected' is setting to true. */
-    qmp_discard_response("{ 'execute' : 'query-status'}");
+    qobject_unref(qmp("{ 'execute' : 'query-status'}"));
     ret = iov_send(send_sock[0], iov, 2, 0, sizeof(size) + sizeof(send_buf));
     g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(size));
     close(send_sock[0]);
diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redirector.c
index fbaf19bbd8..5b6c594867 100644
--- a/tests/test-filter-redirector.c
+++ b/tests/test-filter-redirector.c
@@ -52,6 +52,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
@@ -104,7 +105,7 @@ static void test_redirector_tx(void)
     g_assert_cmpint(recv_sock, !=, -1);
 
     /* send a qmp command to guarantee that 'connected' is setting to true. */
-    qmp_discard_response("{ 'execute' : 'query-status'}");
+    qobject_unref(qmp("{ 'execute' : 'query-status'}"));
 
     struct iovec iov[] = {
         {
@@ -182,7 +183,7 @@ static void test_redirector_rx(void)
     send_sock = unix_connect(sock_path1, NULL);
     g_assert_cmpint(send_sock, !=, -1);
     /* send a qmp command to guarantee that 'connected' is setting to true. */
-    qmp_discard_response("{ 'execute' : 'query-status'}");
+    qobject_unref(qmp("{ 'execute' : 'query-status'}"));
 
     ret = iov_send(send_sock, iov, 2, 0, sizeof(size) + sizeof(send_buf));
     g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(size));
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index d96b4c69e1..5955bf6d57 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -16,6 +16,7 @@
 #include "libqos/virtio-pci.h"
 #include "libqos/virtio-mmio.h"
 #include "libqos/malloc-generic.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu/bswap.h"
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_config.h"
@@ -409,9 +410,9 @@ static void pci_config(void)
 
     qvirtio_set_driver_ok(&dev->vdev);
 
-    qmp_discard_response("{ 'execute': 'block_resize', "
-                         " 'arguments': { 'device': 'drive0', "
-                         " 'size': %d } }", n_size);
+    qobject_unref(qmp("{ 'execute': 'block_resize', "
+                      " 'arguments': { 'device': 'drive0', "
+                      " 'size': %d } }", n_size));
     qvirtio_wait_config_isr(&dev->vdev, QVIRTIO_BLK_TIMEOUT_US);
 
     capacity = qvirtio_config_readq(&dev->vdev, 0);
@@ -459,9 +460,9 @@ static void pci_msix(void)
 
     qvirtio_set_driver_ok(&dev->vdev);
 
-    qmp_discard_response("{ 'execute': 'block_resize', "
-                         " 'arguments': { 'device': 'drive0', "
-                         " 'size': %d } }", n_size);
+    qobject_unref(qmp("{ 'execute': 'block_resize', "
+                      " 'arguments': { 'device': 'drive0', "
+                      " 'size': %d } }", n_size));
 
     qvirtio_wait_config_isr(&dev->vdev, QVIRTIO_BLK_TIMEOUT_US);
 
@@ -725,9 +726,9 @@ static void mmio_basic(void)
 
     test_basic(&dev->vdev, alloc, vq);
 
-    qmp_discard_response("{ 'execute': 'block_resize', "
-                         " 'arguments': { 'device': 'drive0', "
-                         " 'size': %d } }", n_size);
+    qobject_unref(qmp("{ 'execute': 'block_resize', "
+                      " 'arguments': { 'device': 'drive0', "
+                      " 'size': %d } }", n_size));
 
     qvirtio_wait_queue_isr(&dev->vdev, vq, QVIRTIO_BLK_TIMEOUT_US);
 
-- 
2.17.1

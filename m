Received: from eggs.gnu.org ([2001:4830:134:3::10]:50513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmU-0000ql-2v
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmH-0005C9-Qv
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53664 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqDmB-00058u-Tu
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 640DB406E81D
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-56.ams2.redhat.com
	[10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F04D2166BA5
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:03 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Aug 2018 10:36:40 +0200
Message-Id: <20180816083701.3932-5-armbru@redhat.com>
In-Reply-To: <20180816083701.3932-1-armbru@redhat.com>
References: <20180816083701.3932-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 04/25] libqtest: Remove
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

qtest_qmp_discard_response(...) is shorthand for
qobject_unref(qtest_qmp(...), except it's not actually shorter.
Moreover, the presence of these functions encourage sloppy testing.
Remove them from libqtest.  Add them as macros to the tests that use
them, with a TODO comment asking for cleanup.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180806065344.7103-5-armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/ahci-test.c              |  3 +++
 tests/boot-order-test.c        |  5 ++++-
 tests/drive_del-test.c         |  3 +++
 tests/fdc-test.c               |  4 ++++
 tests/ide-test.c               |  5 ++++-
 tests/libqtest.c               | 27 +--------------------------
 tests/libqtest.h               | 27 ---------------------------
 tests/migration-test.c         |  3 +++
 tests/test-filter-mirror.c     |  4 ++++
 tests/test-filter-redirector.c |  4 ++++
 tests/virtio-blk-test.c        |  4 ++++
 11 files changed, 34 insertions(+), 55 deletions(-)

diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 7e3491b5bd..555f02112e 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -37,6 +37,9 @@
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/pci_regs.h"
 
+/* TODO actually test the results and get rid of this */
+#define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__))
+
 /* Test images sizes in MB */
 #define TEST_IMAGE_SIZE_MB_LARGE (200 * 1024)
 #define TEST_IMAGE_SIZE_MB_SMALL 64
diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index e70f5dedba..9096a4b5df 100644
--- a/tests/boot-order-test.c
+++ b/tests/boot-order-test.c
@@ -13,9 +13,12 @@
 #include "qemu/osdep.h"
 #include "libqos/fw_cfg.h"
 #include "libqtest.h"
-
+#include "qapi/qmp/qdict.h"
 #include "hw/nvram/fw_cfg_keys.h"
 
+/* TODO actually test the results and get rid of this */
+#define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__))
+
 typedef struct {
     const char *args;
     uint64_t expected_boot;
diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index 852fefc8f3..2d0b176b36 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -15,6 +15,9 @@
 #include "libqos/virtio.h"
 #include "qapi/qmp/qdict.h"
 
+/* TODO actually test the results and get rid of this */
+#define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__))
+
 static void drive_add(void)
 {
     char *resp = hmp("drive_add 0 if=none,id=drive0");
diff --git a/tests/fdc-test.c b/tests/fdc-test.c
index 325712e0f2..88f1abfa10 100644
--- a/tests/fdc-test.c
+++ b/tests/fdc-test.c
@@ -26,8 +26,12 @@
 
 
 #include "libqtest.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu-common.h"
 
+/* TODO actually test the results and get rid of this */
+#define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__))
+
 #define TEST_IMAGE_SIZE 1440 * 1024
 
 #define FLOPPY_BASE 0x3f0
diff --git a/tests/ide-test.c b/tests/ide-test.c
index 2384c2c3e2..7ab09c3448 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -29,12 +29,15 @@
 #include "libqos/libqos.h"
 #include "libqos/pci-pc.h"
 #include "libqos/malloc-pc.h"
-
+#include "qapi/qmp/qdict.h"
 #include "qemu-common.h"
 #include "qemu/bswap.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/pci_regs.h"
 
+/* TODO actually test the results and get rid of this */
+#define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__))
+
 #define TEST_IMAGE_SIZE 64 * 1024 * 1024
 
 #define IDE_PCI_DEV     1
diff --git a/tests/libqtest.c b/tests/libqtest.c
index c2c08a890c..2fe0f4dc29 100644
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
@@ -591,23 +591,6 @@ void qtest_qmp_send(QTestState *s, const char *fmt, ...)
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
@@ -979,14 +962,6 @@ void qmp_send(const char *fmt, ...)
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
index c1af40106f..3eecd5e9a7 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -73,15 +73,6 @@ QTestState *qtest_init_without_qmp_handshake(bool use_oob,
  */
 void qtest_quit(QTestState *s);
 
-/**
- * qtest_qmp_discard_response:
- * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu
- *
- * Sends a QMP message to QEMU and consumes the response.
- */
-void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...);
-
 /**
  * qtest_qmp:
  * @s: #QTestState instance to operate on.
@@ -100,16 +91,6 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
  */
 void qtest_qmp_send(QTestState *s, const char *fmt, ...);
 
-/**
- * qtest_qmpv_discard_response:
- * @s: #QTestState instance to operate on.
- * @fmt: QMP message to send to QEMU
- * @ap: QMP message arguments
- *
- * Sends a QMP message to QEMU and consumes the response.
- */
-void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap);
-
 /**
  * qtest_qmpv:
  * @s: #QTestState instance to operate on.
@@ -575,14 +556,6 @@ QDict *qmp(const char *fmt, ...);
  */
 void qmp_send(const char *fmt, ...);
 
-/**
- * qmp_discard_response:
- * @fmt...: QMP message to send to qemu
- *
- * Sends a QMP message to QEMU and consumes the response.
- */
-void qmp_discard_response(const char *fmt, ...);
-
 /**
  * qmp_receive:
  *
diff --git a/tests/migration-test.c b/tests/migration-test.c
index e079e0bdb6..bbe9c9e95d 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -20,6 +20,9 @@
 #include "chardev/char.h"
 #include "sysemu/sysemu.h"
 
+/* TODO actually test the results and get rid of this */
+#define qtest_qmp_discard_response(...) qobject_unref(qtest_qmp(__VA_ARGS__))
+
 const unsigned start_address = 1024 * 1024;
 const unsigned end_address = 100 * 1024 * 1024;
 bool got_stop;
diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
index 6c6f710dc6..de5ba155db 100644
--- a/tests/test-filter-mirror.c
+++ b/tests/test-filter-mirror.c
@@ -10,11 +10,15 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 
+/* TODO actually test the results and get rid of this */
+#define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__))
+
 static void test_mirror(void)
 {
     int send_sock[2], recv_sock;
diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redirector.c
index fbaf19bbd8..896f900e98 100644
--- a/tests/test-filter-redirector.c
+++ b/tests/test-filter-redirector.c
@@ -52,11 +52,15 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 
+/* TODO actually test the results and get rid of this */
+#define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__))
+
 static const char *get_devstr(void)
 {
     if (g_str_equal(qtest_get_arch(), "s390x")) {
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 9be9ffb378..06226b8717 100644
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
@@ -23,6 +24,9 @@
 #include "standard-headers/linux/virtio_blk.h"
 #include "standard-headers/linux/virtio_pci.h"
 
+/* TODO actually test the results and get rid of this */
+#define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__))
+
 #define TEST_IMAGE_SIZE         (64 * 1024 * 1024)
 #define QVIRTIO_BLK_TIMEOUT_US  (30 * 1000 * 1000)
 #define PCI_SLOT_HP             0x06
-- 
2.17.1

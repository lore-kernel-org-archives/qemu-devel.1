Received: from eggs.gnu.org ([2001:4830:134:3::10]:45335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejsW1-0002KO-Jb
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejsVz-0002KS-Nw
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:09:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43652 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ejsVz-0002KD-I8
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:09:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4638C40FB630
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 20:09:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  8 Feb 2018 21:09:32 +0100
Message-Id: <1518120582-26647-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1518120582-26647-1-git-send-email-thuth@redhat.com>
References: <1518120582-26647-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 04/14] libqos: Use explicit QTestState for
 fw_cfg operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Drop one more client of global_qtest by teaching all fw_cfg test
functionality (invoked through alloc-pc) to pass in an explicit
QTestState, adjusting all callers.  In particular, fw_cfg-test
had to reorder things to create the test state prior to creating
the fw_cfg (and drop a pointless strdup in the meantime), but that
test now no longer depends on global_qtest.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
[thuth: Fixed conflict wrt pc_alloc_init() in vhost-user-test.c]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/boot-order-test.c     |  6 +++---
 tests/e1000e-test.c         |  2 +-
 tests/fw_cfg-test.c         | 13 ++++---------
 tests/ide-test.c            |  2 +-
 tests/libqos/fw_cfg.c       | 14 ++++++++------
 tests/libqos/fw_cfg.h       | 10 ++++++----
 tests/libqos/libqos.c       |  2 +-
 tests/libqos/libqos.h       |  2 +-
 tests/libqos/malloc-pc.c    |  8 ++++----
 tests/libqos/malloc-pc.h    |  4 ++--
 tests/libqos/malloc-spapr.c |  4 ++--
 tests/libqos/malloc-spapr.h |  2 +-
 tests/libqos/malloc.h       |  1 +
 tests/vhost-user-test.c     |  2 +-
 14 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index 508469a..e70f5de 100644
--- a/tests/boot-order-test.c
+++ b/tests/boot-order-test.c
@@ -132,7 +132,7 @@ static void test_prep_boot_order(void)
 
 static uint64_t read_boot_order_pmac(void)
 {
-    QFWCFG *fw_cfg = mm_fw_cfg_init(0xf0000510);
+    QFWCFG *fw_cfg = mm_fw_cfg_init(global_qtest, 0xf0000510);
 
     return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);
 }
@@ -157,7 +157,7 @@ static void test_pmac_newworld_boot_order(void)
 
 static uint64_t read_boot_order_sun4m(void)
 {
-    QFWCFG *fw_cfg = mm_fw_cfg_init(0xd00000510ULL);
+    QFWCFG *fw_cfg = mm_fw_cfg_init(global_qtest, 0xd00000510ULL);
 
     return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);
 }
@@ -169,7 +169,7 @@ static void test_sun4m_boot_order(void)
 
 static uint64_t read_boot_order_sun4u(void)
 {
-    QFWCFG *fw_cfg = io_fw_cfg_init(0x510);
+    QFWCFG *fw_cfg = io_fw_cfg_init(global_qtest, 0x510);
 
     return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);
 }
diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
index d8085d9..32aa738 100644
--- a/tests/e1000e-test.c
+++ b/tests/e1000e-test.c
@@ -392,7 +392,7 @@ static void data_test_init(e1000e_device *d)
     qtest_start(cmdline);
     g_free(cmdline);
 
-    test_alloc = pc_alloc_init();
+    test_alloc = pc_alloc_init(global_qtest);
     g_assert_nonnull(test_alloc);
 
     test_bus = qpci_init_pc(global_qtest, test_alloc);
diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 81f45bd..1548bf1 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -102,12 +102,13 @@ static void test_fw_cfg_boot_menu(void)
 int main(int argc, char **argv)
 {
     QTestState *s;
-    char *cmdline;
     int ret;
 
     g_test_init(&argc, &argv, NULL);
 
-    fw_cfg = pc_fw_cfg_init();
+    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
+
+    fw_cfg = pc_fw_cfg_init(s);
 
     qtest_add_func("fw_cfg/signature", test_fw_cfg_signature);
     qtest_add_func("fw_cfg/id", test_fw_cfg_id);
@@ -125,15 +126,9 @@ int main(int argc, char **argv)
     qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
     qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
 
-    cmdline = g_strdup_printf("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8 ");
-    s = qtest_start(cmdline);
-    g_free(cmdline);
-
     ret = g_test_run();
 
-    if (s) {
-        qtest_quit(s);
-    }
+    qtest_quit(s);
 
     return ret;
 }
diff --git a/tests/ide-test.c b/tests/ide-test.c
index b2237b6..084f6a5 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -125,7 +125,7 @@ static void ide_test_start(const char *cmdline_fmt, ...)
     va_end(ap);
 
     qtest_start(cmdline);
-    guest_malloc = pc_alloc_init();
+    guest_malloc = pc_alloc_init(global_qtest);
 
     g_free(cmdline);
 }
diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
index 4d9dc3f..d0889d1 100644
--- a/tests/libqos/fw_cfg.c
+++ b/tests/libqos/fw_cfg.c
@@ -56,7 +56,7 @@ uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key)
 
 static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
 {
-    writew(fw_cfg->base, key);
+    qtest_writew(fw_cfg->qts, fw_cfg->base, key);
 }
 
 static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
@@ -65,15 +65,16 @@ static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
     int i;
 
     for (i = 0; i < len; i++) {
-        ptr[i] = readb(fw_cfg->base + 2);
+        ptr[i] = qtest_readb(fw_cfg->qts, fw_cfg->base + 2);
     }
 }
 
-QFWCFG *mm_fw_cfg_init(uint64_t base)
+QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base)
 {
     QFWCFG *fw_cfg = g_malloc0(sizeof(*fw_cfg));
 
     fw_cfg->base = base;
+    fw_cfg->qts = qts;
     fw_cfg->select = mm_fw_cfg_select;
     fw_cfg->read = mm_fw_cfg_read;
 
@@ -82,7 +83,7 @@ QFWCFG *mm_fw_cfg_init(uint64_t base)
 
 static void io_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
 {
-    outw(fw_cfg->base, key);
+    qtest_outw(fw_cfg->qts, fw_cfg->base, key);
 }
 
 static void io_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
@@ -91,15 +92,16 @@ static void io_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
     int i;
 
     for (i = 0; i < len; i++) {
-        ptr[i] = inb(fw_cfg->base + 1);
+        ptr[i] = qtest_inb(fw_cfg->qts, fw_cfg->base + 1);
     }
 }
 
-QFWCFG *io_fw_cfg_init(uint16_t base)
+QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base)
 {
     QFWCFG *fw_cfg = g_malloc0(sizeof(*fw_cfg));
 
     fw_cfg->base = base;
+    fw_cfg->qts = qts;
     fw_cfg->select = io_fw_cfg_select;
     fw_cfg->read = io_fw_cfg_read;
 
diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
index e8371b2..0353416 100644
--- a/tests/libqos/fw_cfg.h
+++ b/tests/libqos/fw_cfg.h
@@ -13,12 +13,14 @@
 #ifndef LIBQOS_FW_CFG_H
 #define LIBQOS_FW_CFG_H
 
+#include "libqtest.h"
 
 typedef struct QFWCFG QFWCFG;
 
 struct QFWCFG
 {
     uint64_t base;
+    QTestState *qts;
     void (*select)(QFWCFG *fw_cfg, uint16_t key);
     void (*read)(QFWCFG *fw_cfg, void *data, size_t len);
 };
@@ -30,12 +32,12 @@ uint16_t qfw_cfg_get_u16(QFWCFG *fw_cfg, uint16_t key);
 uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key);
 uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
 
-QFWCFG *mm_fw_cfg_init(uint64_t base);
-QFWCFG *io_fw_cfg_init(uint16_t base);
+QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
+QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);
 
-static inline QFWCFG *pc_fw_cfg_init(void)
+static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)
 {
-    return io_fw_cfg_init(0x510);
+    return io_fw_cfg_init(qts, 0x510);
 }
 
 #endif
diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index 7a76c1e..40018b9 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -23,7 +23,7 @@ QOSState *qtest_vboot(QOSOps *ops, const char *cmdline_fmt, va_list ap)
     qs->qts = qtest_start(cmdline);
     qs->ops = ops;
     if (ops) {
-        qs->alloc = ops->init_allocator(ALLOC_NO_FLAGS);
+        qs->alloc = ops->init_allocator(qs->qts, ALLOC_NO_FLAGS);
         qs->pcibus = ops->qpci_init(qs->qts, qs->alloc);
     }
 
diff --git a/tests/libqos/libqos.h b/tests/libqos/libqos.h
index 78e5c04..07d4b93 100644
--- a/tests/libqos/libqos.h
+++ b/tests/libqos/libqos.h
@@ -8,7 +8,7 @@
 typedef struct QOSState QOSState;
 
 typedef struct QOSOps {
-    QGuestAllocator *(*init_allocator)(QAllocOpts);
+    QGuestAllocator *(*init_allocator)(QTestState *qts, QAllocOpts);
     void (*uninit_allocator)(QGuestAllocator *);
     QPCIBus *(*qpci_init)(QTestState *qts, QGuestAllocator *alloc);
     void (*qpci_free)(QPCIBus *bus);
diff --git a/tests/libqos/malloc-pc.c b/tests/libqos/malloc-pc.c
index dd2b900..634b9c2 100644
--- a/tests/libqos/malloc-pc.c
+++ b/tests/libqos/malloc-pc.c
@@ -29,11 +29,11 @@ void pc_alloc_uninit(QGuestAllocator *allocator)
     alloc_uninit(allocator);
 }
 
-QGuestAllocator *pc_alloc_init_flags(QAllocOpts flags)
+QGuestAllocator *pc_alloc_init_flags(QTestState *qts, QAllocOpts flags)
 {
     QGuestAllocator *s;
     uint64_t ram_size;
-    QFWCFG *fw_cfg = pc_fw_cfg_init();
+    QFWCFG *fw_cfg = pc_fw_cfg_init(qts);
 
     ram_size = qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE);
     s = alloc_init_flags(flags, 1 << 20, MIN(ram_size, 0xE0000000));
@@ -45,7 +45,7 @@ QGuestAllocator *pc_alloc_init_flags(QAllocOpts flags)
     return s;
 }
 
-inline QGuestAllocator *pc_alloc_init(void)
+inline QGuestAllocator *pc_alloc_init(QTestState *qts)
 {
-    return pc_alloc_init_flags(ALLOC_NO_FLAGS);
+    return pc_alloc_init_flags(qts, ALLOC_NO_FLAGS);
 }
diff --git a/tests/libqos/malloc-pc.h b/tests/libqos/malloc-pc.h
index 86ab9f0..10f3da6 100644
--- a/tests/libqos/malloc-pc.h
+++ b/tests/libqos/malloc-pc.h
@@ -15,8 +15,8 @@
 
 #include "libqos/malloc.h"
 
-QGuestAllocator *pc_alloc_init(void);
-QGuestAllocator *pc_alloc_init_flags(QAllocOpts flags);
+QGuestAllocator *pc_alloc_init(QTestState *qts);
+QGuestAllocator *pc_alloc_init_flags(QTestState *qts, QAllocOpts flags);
 void pc_alloc_uninit(QGuestAllocator *allocator);
 
 #endif
diff --git a/tests/libqos/malloc-spapr.c b/tests/libqos/malloc-spapr.c
index 006404a..1c359ce 100644
--- a/tests/libqos/malloc-spapr.c
+++ b/tests/libqos/malloc-spapr.c
@@ -22,7 +22,7 @@ void spapr_alloc_uninit(QGuestAllocator *allocator)
     alloc_uninit(allocator);
 }
 
-QGuestAllocator *spapr_alloc_init_flags(QAllocOpts flags)
+QGuestAllocator *spapr_alloc_init_flags(QTestState *qts, QAllocOpts flags)
 {
     QGuestAllocator *s;
 
@@ -34,5 +34,5 @@ QGuestAllocator *spapr_alloc_init_flags(QAllocOpts flags)
 
 QGuestAllocator *spapr_alloc_init(void)
 {
-    return spapr_alloc_init_flags(ALLOC_NO_FLAGS);
+    return spapr_alloc_init_flags(NULL, ALLOC_NO_FLAGS);
 }
diff --git a/tests/libqos/malloc-spapr.h b/tests/libqos/malloc-spapr.h
index 64d0e77..52a9346 100644
--- a/tests/libqos/malloc-spapr.h
+++ b/tests/libqos/malloc-spapr.h
@@ -11,7 +11,7 @@
 #include "libqos/malloc.h"
 
 QGuestAllocator *spapr_alloc_init(void);
-QGuestAllocator *spapr_alloc_init_flags(QAllocOpts flags);
+QGuestAllocator *spapr_alloc_init_flags(QTestState *qts, QAllocOpts flags);
 void spapr_alloc_uninit(QGuestAllocator *allocator);
 
 #endif
diff --git a/tests/libqos/malloc.h b/tests/libqos/malloc.h
index ae9dac8..828fdda 100644
--- a/tests/libqos/malloc.h
+++ b/tests/libqos/malloc.h
@@ -14,6 +14,7 @@
 #define LIBQOS_MALLOC_H
 
 #include "qemu/queue.h"
+#include "libqtest.h"
 
 typedef enum {
     ALLOC_NO_FLAGS    = 0x00,
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 07b7e8a..d53146e 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -180,7 +180,7 @@ static void init_virtio_dev(TestServer *s, uint32_t features_mask)
     qvirtio_set_acknowledge(&s->dev->vdev);
     qvirtio_set_driver(&s->dev->vdev);
 
-    s->alloc = pc_alloc_init();
+    s->alloc = pc_alloc_init(global_qtest);
 
     for (i = 0; i < s->queues * 2; i++) {
         s->vq[i] = qvirtqueue_setup(&s->dev->vdev, s->alloc, i);
-- 
1.8.3.1

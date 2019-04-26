Received: from eggs.gnu.org ([209.51.188.92]:33960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hK3h2-0004BM-3R
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hK3gy-0000yx-1k
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:18 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30]:35957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hK3gu-0000wg-LX
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:14 -0400
Received: by mail-io1-xd30.google.com with SMTP id d19so3444061ioc.3
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 09:27:11 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Date: Fri, 26 Apr 2019 12:26:20 -0400
Message-Id: <20190426162624.55977-7-stephen.checkoway@oberlin.edu>
In-Reply-To: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
References: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 06/10] block/pflash_cfi02: Fix CFI in
 autoselect mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Stephen Checkoway <stephen.checkoway@oberlin.edu>

After a flash device enters CFI mode from autoselect mode, the reset
command returns the device to autoselect mode. An additional reset
command is necessary to return to read array mode.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 hw/block/pflash_cfi02.c   | 21 +++++++++++++++++----
 tests/pflash-cfi02-test.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index c4efbe8cdf..be10036886 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -61,8 +61,9 @@ do {                                                       \
  */
 #define PFLASH_MAX_ERASE_REGIONS 4
 
-/* Special write cycle for CFI queries. */
+/* Special write cycles for CFI queries. */
 #define WCYCLE_CFI 7
+#define WCYCLE_AUTOSELECT_CFI 8
 
 struct PFlashCFI02 {
     /*< private >*/
@@ -325,6 +326,12 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
         }
 
         if (cmd == 0xF0) {
+            if (pfl->wcycle == WCYCLE_AUTOSELECT_CFI) {
+                /* Return to autoselect mode. */
+                pfl->wcycle = 3;
+                pfl->cmd = 0x90;
+                return;
+            }
             goto reset_flash;
         }
     }
@@ -350,7 +357,6 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
         /* We're in read mode */
     check_unlock0:
         if (masked_addr == 0x55 && cmd == 0x98) {
-        enter_CFI_mode:
             /* Enter CFI query mode */
             pfl->wcycle = WCYCLE_CFI;
             pfl->cmd = 0x98;
@@ -427,9 +433,15 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
                 /* Unlock bypass reset */
                 goto reset_flash;
             }
-            /* We can enter CFI query mode from autoselect mode */
+            /*
+             * We can enter CFI query mode from autoselect mode, but we must
+             * return to autoselect mode after a reset.
+             */
             if (masked_addr == 0x55 && cmd == 0x98) {
-                goto enter_CFI_mode;
+                /* Enter autoselect CFI query mode */
+                pfl->wcycle = WCYCLE_AUTOSELECT_CFI;
+                pfl->cmd = 0x98;
+                return;
             }
             /* No break here */
         default:
@@ -510,6 +522,7 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
         }
         break;
     case WCYCLE_CFI: /* Special value for CFI queries */
+    case WCYCLE_AUTOSELECT_CFI:
         DPRINTF("%s: invalid write in CFI query mode\n", __func__);
         goto reset_flash;
     default:
diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index 703f084c5d..c2798bbb36 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -477,6 +477,42 @@ static void test_geometry(const void *opaque)
     qtest_quit(qtest);
 }
 
+/*
+ * Test that
+ * 1. enter autoselect mode;
+ * 2. enter CFI mode; and then
+ * 3. exit CFI mode
+ * leaves the flash device in autoselect mode.
+ */
+static void test_cfi_in_autoselect(const void *opaque)
+{
+    const FlashConfig *config = opaque;
+    QTestState *qtest;
+    qtest = qtest_initf("-M musicpal,accel=qtest"
+                        " -drive if=pflash,file=%s,format=raw,copy-on-read",
+                        image_path);
+    FlashConfig explicit_config = expand_config_defaults(config);
+    explicit_config.qtest = qtest;
+    const FlashConfig *c = &explicit_config;
+
+    /* 1. Enter autoselect. */
+    unlock(c);
+    flash_cmd(c, UNLOCK0_ADDR, AUTOSELECT_CMD);
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0)), ==, replicate(c, 0xBF));
+
+    /* 2. Enter CFI. */
+    flash_cmd(c, CFI_ADDR, CFI_CMD);
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0x10)), ==, replicate(c, 'Q'));
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0x11)), ==, replicate(c, 'R'));
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0x12)), ==, replicate(c, 'Y'));
+
+    /* 3. Exit CFI. */
+    reset(c);
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0)), ==, replicate(c, 0xBF));
+
+    qtest_quit(qtest);
+}
+
 static void cleanup(void *opaque)
 {
     unlink(image_path);
@@ -604,6 +640,9 @@ int main(int argc, char **argv)
         qtest_add_data_func(path, config, test_geometry);
         g_free(path);
     }
+
+    qtest_add_data_func("pflash-cfi02/cfi-in-autoselect", &configuration[0],
+                        test_cfi_in_autoselect);
     int result = g_test_run();
     cleanup(NULL);
     return result;
-- 
2.20.1 (Apple Git-117)

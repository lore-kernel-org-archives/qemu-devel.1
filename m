Received: from eggs.gnu.org ([209.51.188.92]:34061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hK3h6-0004GK-4A
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hK3h4-00012t-30
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:24 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:51213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hK3h0-0000y9-7j
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:20 -0400
Received: by mail-it1-x143.google.com with SMTP id s3so6812553itk.1
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 09:27:14 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Date: Fri, 26 Apr 2019 12:26:22 -0400
Message-Id: <20190426162624.55977-9-stephen.checkoway@oberlin.edu>
In-Reply-To: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
References: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 08/10] block/pflash_cfi02: Implement
 multi-sector erase
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

After two unlock cycles and a sector erase command, the AMD flash chips
start a 50 us erase time out. Any additional sector erase commands add a
sector to be erased and restart the 50 us timeout. During the timeout,
status bit DQ3 is cleared. After the time out, DQ3 is asserted during
erasure.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 hw/block/pflash_cfi02.c   | 94 +++++++++++++++++++++++++++++++--------
 tests/pflash-cfi02-test.c | 59 ++++++++++++++++++++++--
 2 files changed, 131 insertions(+), 22 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index cb1160eb35..21ceb0823b 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -30,7 +30,6 @@
  *
  * It does not implement software data protection as found in many real chips
  * It does not implement erase suspend/resume commands
- * It does not implement multiple sectors erase
  */
 
 #include "qemu/osdep.h"
@@ -106,6 +105,7 @@ struct PFlashCFI02 {
     MemoryRegion orig_mem;
     int rom_mode;
     int read_counter; /* used for lazy switch-back to rom mode */
+    int sectors_to_erase;
     char *name;
     void *storage;
 };
@@ -136,6 +136,22 @@ static inline void toggle_dq6(PFlashCFI02 *pfl)
     pfl->status ^= pfl->interleave_multiplier * 0x40;
 }
 
+/*
+ * Turn on DQ3.
+ */
+static inline void assert_dq3(PFlashCFI02 *pfl)
+{
+    pfl->status |= pfl->interleave_multiplier * 0x08;
+}
+
+/*
+ * Turn off DQ3.
+ */
+static inline void reset_dq3(PFlashCFI02 *pfl)
+{
+    pfl->status &= ~(pfl->interleave_multiplier * 0x08);
+}
+
 /*
  * Set up replicated mappings of the same region.
  */
@@ -159,11 +175,37 @@ static void pflash_register_memory(PFlashCFI02 *pfl, int rom_mode)
     pfl->rom_mode = rom_mode;
 }
 
-static void pflash_timer (void *opaque)
+static void pflash_timer(void *opaque)
 {
     PFlashCFI02 *pfl = opaque;
 
     trace_pflash_timer_expired(pfl->cmd);
+    if (pfl->cmd == 0x30) {
+        /*
+         * Sector erase. If DQ3 is 0 when the timer expires, then the 50
+         * us erase timeout has expired so we need to start the timer for the
+         * sector erase algorithm. Otherwise, the erase completed and we should
+         * go back to read array mode.
+         */
+        if ((pfl->status & 0x08) == 0) {
+            assert_dq3(pfl);
+            /*
+             * CFI address 0x21 is "Typical timeout per individual block erase
+             * 2^N ms"
+             */
+            uint64_t timeout = ((1ULL << pfl->cfi_table[0x21]) *
+                                pfl->sectors_to_erase) * 1000000;
+            timer_mod(&pfl->timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + timeout);
+            DPRINTF("%s: erase timeout fired; erasing %d sectors\n",
+                    __func__, pfl->sectors_to_erase);
+            return;
+        }
+        DPRINTF("%s: sector erase complete\n", __func__);
+        pfl->sectors_to_erase = 0;
+        reset_dq3(pfl);
+    }
+
     /* Reset flash */
     toggle_dq7(pfl);
     if (pfl->bypass) {
@@ -307,13 +349,30 @@ static void pflash_update(PFlashCFI02 *pfl, int offset, int size)
     }
 }
 
+static void pflash_sector_erase(PFlashCFI02 *pfl, hwaddr offset)
+{
+    uint64_t sector_len = pflash_sector_len(pfl, offset);
+    offset &= ~(sector_len - 1);
+    DPRINTF("%s: start sector erase at %0*" PRIx64 "-%0*" PRIx64 "\n",
+            __func__, pfl->bank_width * 2, offset,
+            pfl->bank_width * 2, offset + sector_len - 1);
+    if (!pfl->ro) {
+        uint8_t *p = pfl->storage;
+        memset(p + offset, 0xFF, sector_len);
+        pflash_update(pfl, offset, sector_len);
+    }
+    set_dq7(pfl, 0x00);
+    ++pfl->sectors_to_erase;
+    /* Set (or reset) the 50 us timer for additional erase commands.  */
+    timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 50000);
+}
+
 static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
                          unsigned int width)
 {
     PFlashCFI02 *pfl = opaque;
     uint8_t *p;
     uint8_t cmd;
-    uint32_t sector_len;
 
     cmd = value;
     if (pfl->cmd != 0xA0) {
@@ -486,20 +545,7 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
             break;
         case 0x30:
             /* Sector erase */
-            p = pfl->storage;
-            sector_len = pflash_sector_len(pfl, offset);
-            offset &= ~(sector_len - 1);
-            DPRINTF("%s: start sector erase at %0*" PRIx64 "-%0*" PRIx64 "\n",
-                    __func__, pfl->bank_width * 2, offset,
-                    pfl->bank_width * 2, offset + sector_len - 1);
-            if (!pfl->ro) {
-                memset(p + offset, 0xFF, sector_len);
-                pflash_update(pfl, offset, sector_len);
-            }
-            set_dq7(pfl, 0x00);
-            /* Let's wait 1/2 second before sector erase is done */
-            timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                      (NANOSECONDS_PER_SECOND / 2));
+            pflash_sector_erase(pfl, offset);
             break;
         default:
             DPRINTF("%s: invalid command %02x (wc 5)\n", __func__, cmd);
@@ -513,7 +559,19 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
             /* Ignore writes during chip erase */
             return;
         case 0x30:
-            /* Ignore writes during sector erase */
+            /*
+             * If DQ3 is 0, additional sector erase commands can be
+             * written and anything else (other than an erase suspend) resets
+             * the device.
+             */
+            if ((pfl->status & 0x08) == 0) {
+                if (cmd == 0x30) {
+                    pflash_sector_erase(pfl, offset);
+                } else {
+                    goto reset_flash;
+                }
+            }
+            /* Ignore writes during the actual erase. */
             return;
         default:
             /* Should never happen */
diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index c2798bbb36..0384593792 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -35,6 +35,7 @@ typedef struct {
 #define CFI_CMD 0x98
 #define UNLOCK0_CMD 0xAA
 #define UNLOCK1_CMD 0x55
+#define SECOND_UNLOCK_CMD 0x80
 #define AUTOSELECT_CMD 0x90
 #define RESET_CMD 0xF0
 #define PROGRAM_CMD 0xA0
@@ -222,7 +223,7 @@ static void reset(const FlashConfig *c)
 static void sector_erase(const FlashConfig *c, uint64_t byte_addr)
 {
     unlock(c);
-    flash_cmd(c, UNLOCK0_ADDR, 0x80);
+    flash_cmd(c, UNLOCK0_ADDR, SECOND_UNLOCK_CMD);
     unlock(c);
     flash_write(c, byte_addr, replicate(c, SECTOR_ERASE_CMD));
 }
@@ -261,7 +262,7 @@ static void program(const FlashConfig *c, uint64_t byte_addr, uint16_t data)
 static void chip_erase(const FlashConfig *c)
 {
     unlock(c);
-    flash_cmd(c, UNLOCK0_ADDR, 0x80);
+    flash_cmd(c, UNLOCK0_ADDR, SECOND_UNLOCK_CMD);
     unlock(c);
     flash_cmd(c, UNLOCK0_ADDR, CHIP_ERASE_CMD);
 }
@@ -383,6 +384,7 @@ static void test_geometry(const void *opaque)
     reset(c);
     const uint64_t dq7 = replicate(c, 0x80);
     const uint64_t dq6 = replicate(c, 0x40);
+    const uint64_t dq3 = replicate(c, 0x08);
 
     uint64_t byte_addr = 0;
     for (int region = 0; region < nb_erase_regions; ++region) {
@@ -400,18 +402,29 @@ static void test_geometry(const void *opaque)
         /* Erase and program sector. */
         for (uint32_t i = 0; i < nb_sectors; ++i) {
             sector_erase(c, byte_addr);
-            /* Read toggle. */
+
+            /* Check that DQ3 is 0. */
+            g_assert_cmpint(flash_read(c, byte_addr) & dq3, ==, 0);
+            qtest_clock_step_next(c->qtest); /* Step over the 50 us timeout. */
+
+            /* Check that DQ3 is 1. */
             uint64_t status0 = flash_read(c, byte_addr);
+            g_assert_cmpint(status0 & dq3, ==, dq3);
+
             /* DQ7 is 0 during an erase. */
             g_assert_cmpint(status0 & dq7, ==, 0);
             uint64_t status1 = flash_read(c, byte_addr);
+
             /* DQ6 toggles during an erase. */
             g_assert_cmpint(status0 & dq6, ==, ~status1 & dq6);
+
             /* Wait for erase to complete. */
-            qtest_clock_step_next(c->qtest);
+            wait_for_completion(c, byte_addr);
+
             /* Ensure DQ6 has stopped toggling. */
             g_assert_cmpint(flash_read(c, byte_addr), ==,
                             flash_read(c, byte_addr));
+
             /* Now the data should be valid. */
             g_assert_cmpint(flash_read(c, byte_addr), ==, bank_mask(c));
 
@@ -474,6 +487,44 @@ static void test_geometry(const void *opaque)
     g_assert_cmpint(flash_query(c, FLASH_ADDR(0)), ==, replicate(c, 0xBF));
     reset(c);
 
+    /*
+     * Program a word on each sector, erase one or two sectors per region, and
+     * verify that all of those, and only those, are erased.
+     */
+    byte_addr = 0;
+    for (int region = 0; region < nb_erase_regions; ++region) {
+        for (int i = 0; i < config->nb_blocs[region]; ++i) {
+            program(c, byte_addr, 0);
+            byte_addr += config->sector_len[region];
+        }
+    }
+    unlock(c);
+    flash_cmd(c, UNLOCK0_ADDR, SECOND_UNLOCK_CMD);
+    unlock(c);
+    byte_addr = 0;
+    const uint64_t erase_cmd = replicate(c, SECTOR_ERASE_CMD);
+    for (int region = 0; region < nb_erase_regions; ++region) {
+        flash_write(c, byte_addr, erase_cmd);
+        if (c->nb_blocs[region] > 1) {
+            flash_write(c, byte_addr + c->sector_len[region], erase_cmd);
+        }
+        byte_addr += c->sector_len[region] * c->nb_blocs[region];
+    }
+
+    qtest_clock_step_next(c->qtest); /* Step over the 50 us timeout. */
+    wait_for_completion(c, 0);
+    byte_addr = 0;
+    for (int region = 0; region < nb_erase_regions; ++region) {
+        for (int i = 0; i < config->nb_blocs[region]; ++i) {
+            if (i < 2) {
+                g_assert_cmpint(flash_read(c, byte_addr), ==, bank_mask(c));
+            } else {
+                g_assert_cmpint(flash_read(c, byte_addr), ==, 0);
+            }
+            byte_addr += config->sector_len[region];
+        }
+    }
+
     qtest_quit(qtest);
 }
 
-- 
2.20.1 (Apple Git-117)

Received: from eggs.gnu.org ([209.51.188.92]:47528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKK-0003nV-FL
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKJ-0007l8-8x
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:12 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30]:39622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDbKI-0007j8-U1
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:11 -0400
Received: by mail-io1-xd30.google.com with SMTP id e13so12308786ioq.6
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 13:57:10 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Date: Mon,  8 Apr 2019 16:55:46 -0400
Message-Id: <4662c1009d2d6f4d5ba0f19be1bed1880c7502a0.1554755001.git.stephen.checkoway@oberlin.edu>
In-Reply-To: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 03/10] block/pflash_cfi02: Fix command address
 comparison
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Stephen Checkoway <s@pahtak.org>, Stephen Checkoway <stephen.checkoway@oberlin.edu>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Stephen Checkoway <s@pahtak.org>

Most AMD commands only examine 11 bits of the address. This masks the
addresses used in the comparison to 11 bits. The exceptions are word or
sector addresses which use offset directly rather than the shifted
offset, boff.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 hw/block/pflash_cfi02.c   |  8 +++++++-
 tests/pflash-cfi02-test.c | 12 ++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 53db3fd09f..cb102739d6 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -296,11 +296,13 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
 
     DPRINTF("%s: offset " TARGET_FMT_plx " %08" PRIx64 " %d\n", __func__,
             offset, value, width);
-    boff = offset & (pfl->sector_len - 1);
+    boff = offset;
     if (pfl->width == 2)
         boff = boff >> 1;
     else if (pfl->width == 4)
         boff = boff >> 2;
+    /* Only the least-significant 11 bits are used in most cases. */
+    boff &= 0x7FF;
     switch (pfl->wcycle) {
     case 0:
         /* Set the device in I/O access mode if required */
@@ -519,6 +521,10 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* Only 11 bits are used in the comparison. */
+    pfl->unlock_addr0 &= 0x7FF;
+    pfl->unlock_addr1 &= 0x7FF;
+
     chip_len = pfl->sector_len * pfl->nb_blocs;
 
     memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl),
diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index d349b2cc22..57484c1585 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -23,8 +23,8 @@
 
 #define FLASH_WIDTH 2
 #define CFI_ADDR (FLASH_WIDTH*0x55)
-#define UNLOCK0_ADDR (FLASH_WIDTH*0x5555)
-#define UNLOCK1_ADDR (FLASH_WIDTH*0x2AAA)
+#define UNLOCK0_ADDR (FLASH_WIDTH*0x555)
+#define UNLOCK1_ADDR (FLASH_WIDTH*0x2AA)
 
 #define CFI_CMD 0x98
 #define UNLOCK0_CMD 0xAA
@@ -191,6 +191,14 @@ static void test_flash(void)
     g_assert_cmpint(flash_read(6), ==, 0xCDEF);
     g_assert_cmpint(flash_read(8), ==, 0xFFFF);
 
+    /* Test ignored high order bits of address. */
+    flash_write(FLASH_WIDTH*0x5555, UNLOCK0_CMD);
+    flash_write(FLASH_WIDTH*0x2AAA, UNLOCK1_CMD);
+    flash_write(FLASH_WIDTH*0x5555, AUTOSELECT_CMD);
+    g_assert_cmpint(flash_read(FLASH_WIDTH*0x0000), ==, 0x00BF);
+    g_assert_cmpint(flash_read(FLASH_WIDTH*0x0001), ==, 0x236D);
+    reset();
+
     qtest_quit(global_qtest);
 }
 
-- 
2.20.1 (Apple Git-117)

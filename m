Received: from eggs.gnu.org ([209.51.188.92]:36626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1guJOK-0005MA-V0
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:57:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1guJOJ-0001Vk-5C
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:57:36 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:37283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1guJOF-0001Lt-QK
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:57:33 -0500
Received: by mail-wm1-x332.google.com with SMTP id x10so6544368wmg.2
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 07:57:31 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 14 Feb 2019 15:57:14 +0000
Message-Id: <20190214155714.8779-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/block: report when pflash backing file
 isn't aligned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ard.biesheuvel@linaro.org, pkg-qemu-devel@lists.alioth.debian.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

It looks like there was going to be code to check we had some sort of
alignment so lets replace it with an actual check. This is a bit more
useful than the enigmatic "failed to read the initial flash content"
when we attempt to read the number of bytes the device should have.

This is a potential confusing stumbling block when you move from using
-bios to using -drive if=pflash,file=blob,format=raw,readonly for
loading your firmware code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/block/pflash_cfi01.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index bffb4c40e7..f3251b236c 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -722,12 +722,19 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     }
     device_len = sector_len_per_device * blocks_per_device;
 
-    /* XXX: to be fixed */
-#if 0
-    if (total_len != (8 * 1024 * 1024) && total_len != (16 * 1024 * 1024) &&
-        total_len != (32 * 1024 * 1024) && total_len != (64 * 1024 * 1024))
-        return NULL;
-#endif
+    /*
+     * Validate the backing store is the right size for pflash
+     * devices. It has to be padded to a multiple of the flash block
+     * size.
+     */
+    if (pfl->blk) {
+        uint64_t backing_len = blk_getlength(pfl->blk);
+        if (device_len != backing_len) {
+            error_setg(errp, "backing file wrong size "
+                       "(%" PRId64 " != %" PRId64")", backing_len, device_len);
+            return;
+        }
+    }
 
     memory_region_init_rom_device(
         &pfl->mem, OBJECT(dev),
-- 
2.20.1

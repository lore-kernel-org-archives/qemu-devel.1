Received: from eggs.gnu.org ([209.51.188.92]:50041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwtP7-0000Bw-LA
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:49:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwtP6-0002NE-Rk
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:49:05 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwtP6-0002ML-Ev
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:49:04 -0500
Received: by mail-wr1-x444.google.com with SMTP id v13so31763886wrw.5
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 10:49:04 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Feb 2019 18:48:57 +0000
Message-Id: <20190221184857.22434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3] hw/block: better reporting on pflash
 backing file mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, armbru@redhat.com, stappers@stappers.nl, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

It looks like there was going to be code to check we had some sort of
alignment so lets replace it with an actual check. This is a bit more
useful than the enigmatic "failed to read the initial flash content"
when we attempt to read the number of bytes the device should have.

This is a potential confusing stumbling block when you move from using
-bios to using -drive if=pflash,file=blob,format=raw,readonly for
loading your firmware code. To mitigate that we automatically pad in
the read-only case.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - tweak commit title/commentary
  - use total_len instead of device_len for checks
  - if the device is read-only do the padding for them
  - accept baking_len > total_len (how to warn_report with NULL *errp?)
---
 hw/block/pflash_cfi01.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 00c2efd0d7..37d7513c45 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -714,13 +714,6 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     }
     device_len = sector_len_per_device * blocks_per_device;
 
-    /* XXX: to be fixed */
-#if 0
-    if (total_len != (8 * 1024 * 1024) && total_len != (16 * 1024 * 1024) &&
-        total_len != (32 * 1024 * 1024) && total_len != (64 * 1024 * 1024))
-        return NULL;
-#endif
-
     memory_region_init_rom_device(
         &pfl->mem, OBJECT(dev),
         &pflash_cfi01_ops,
@@ -747,6 +740,27 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     }
 
     if (pfl->blk) {
+        /*
+         * Validate the backing store is the right size for pflash
+         * devices. It should be padded to a multiple of the flash
+         * block size. If the device is read-only we can elide the
+         * check and just null pad the region first. If the user
+         * supplies a larger file we silently accept it.
+         */
+        uint64_t backing_len = blk_getlength(pfl->blk);
+
+        if (backing_len < total_len) {
+            if (pfl->ro) {
+                memset(pfl->storage, 0, total_len);
+                total_len = backing_len;
+            } else {
+                error_setg(errp, "device(s) needs %" PRIu64 " bytes, "
+                           "backing file provides only %" PRIu64 " bytes",
+                           total_len, backing_len);
+                return;
+            }
+        }
+
         /* read the initial flash content */
         ret = blk_pread(pfl->blk, 0, pfl->storage, total_len);
 
-- 
2.20.1

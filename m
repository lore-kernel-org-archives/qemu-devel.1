Received: from eggs.gnu.org ([209.51.188.92]:54724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1pT1-0005Sr-5Y
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:37:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1pT0-0004uk-AA
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:37:31 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  7 Mar 2019 10:37:23 +0100
Message-Id: <20190307093723.655-5-armbru@redhat.com>
In-Reply-To: <20190307093723.655-1-armbru@redhat.com>
References: <20190307093723.655-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v6 4/4] fixup! hw/block: Pad undersized
 read-only images with 0xFF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, philmd@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

---
 hw/block/pflash_cfi02.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index d30a351472..db1c39499c 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -578,8 +578,9 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     if (pfl->blk) {
         /*
          * Validate the backing store is the right size for pflash
-         * devices. If the user supplies a larger file we ignore the
-         * tail.
+         * devices. If the device is read-only we can elide the check
+         * and just pad the region first. If the user supplies a
+         * larger file we ignore the tail.
          */
         int64_t backing_len = blk_getlength(pfl->blk);
         if (backing_len < 0) {
@@ -588,9 +589,20 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
         }
 
         if (backing_len < chip_len) {
-            error_setg(errp, "device needs %" PRIu32 " bytes, "
-                       "backing file provides only %" PRIu64 " bytes",
-                       chip_len, backing_len);
+            if (pfl->ro) {
+                size_t pad_bytes = chip_len - backing_len;
+                /* pad with NOR erase pattern */
+                memset((uint8_t *)pfl->storage + backing_len,
+                       0xff, pad_bytes);
+                warn_report("device needs %" PRIu32
+                            " bytes, padded with %zu 0xff bytes",
+                            chip_len, pad_bytes);
+                chip_len = backing_len;
+            } else {
+                error_setg(errp, "device needs %" PRIu32 " bytes, "
+                           "backing file provides only %" PRIu64 " bytes",
+                           chip_len, backing_len);
+            }
             return;
         } else if (backing_len > chip_len) {
             warn_report("device needs %" PRIu32 " bytes, rest ignored",
-- 
2.17.2

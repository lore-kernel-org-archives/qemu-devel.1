Received: from eggs.gnu.org ([2001:4830:134:3::10]:57341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rndfax@yandex.ru>) id 1eb6Rp-0001WH-EH
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:13:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rndfax@yandex.ru>) id 1eb6Ro-0008H8-MU
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:13:17 -0500
Received: from forward104j.mail.yandex.net ([2a02:6b8:0:801:2::107]:33469)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rndfax@yandex.ru>) id 1eb6Ro-0008FB-Bc
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:13:16 -0500
Received: from mxback3o.mail.yandex.net (mxback3o.mail.yandex.net
	[IPv6:2a02:6b8:0:1a2d::1d])
	by forward104j.mail.yandex.net (Yandex) with ESMTP id 59E7E42A1F
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 18:13:12 +0300 (MSK)
From: Aleksey Kuleshov <rndfax@yandex.ru>
MIME-Version: 1.0
Message-Id: <4692971516029191@web59g.yandex.ru>
Date: Mon, 15 Jan 2018 18:13:11 +0300
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] m25p80: prevent buffer overflow during erasing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

memset is not checked, so it's possible to go beyond the storage.
Add checks and truncate requested length.

Signed-off-by: Aleksey Kuleshov <rndfax@yandex.ru>
---
 hw/block/m25p80.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index ea142160b3..18ec501912 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -539,6 +539,8 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
     uint32_t len;
     uint8_t capa_to_assert = 0;
 
+    assert(0 <= offset && offset < s->size);
+
     switch (cmd) {
     case ERASE_4K:
     case ERASE4_4K:
@@ -581,6 +583,14 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
         qemu_log_mask(LOG_GUEST_ERROR, "M25P80: erase with write protect!\n");
         return;
     }
+
+    if (offset + len > s->size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                            "M25P80: trying to erase beyond the flash size! "
+                            "Truncating the length...\n");
+        len = s->size - offset;
+    }
+
     memset(s->storage + offset, 0xff, len);
     flash_sync_area(s, offset, len);
 }
-- 
2.11.0

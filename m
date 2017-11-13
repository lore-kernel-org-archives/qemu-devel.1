Received: from eggs.gnu.org ([2001:4830:134:3::10]:34248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eE8DB-0003EG-3S
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 01:27:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eE8DA-0006BL-0S
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 01:27:13 -0500
From: P J P <ppandit@redhat.com>
Date: Mon, 13 Nov 2017 11:56:58 +0530
Message-Id: <20171113062658.9697-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v2] highbank: validate register offset before
 access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Moguofang <moguofang@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Shawn Guo <shawn.guo@linaro.org>, Rob Herring <robh@kernel.org>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

An 'offset' parameter sent to highbank register r/w functions
could be greater than number(NUM_REGS=0x200) of hb registers,
leading to an OOB access issue. Add check to avoid it.

Reported-by: Moguofang (Dennis mo) <moguofang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/arm/highbank.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

Update: use HWADDR_PRIx to print offset
  -> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg02116.html

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 354c6b25a8..287392bbdc 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -34,6 +34,7 @@
 #include "hw/ide/ahci.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/cpu/a15mpcore.h"
+#include "qemu/log.h"
 
 #define SMP_BOOT_ADDR           0x100
 #define SMP_BOOT_REG            0x40
@@ -117,14 +118,26 @@ static void hb_regs_write(void *opaque, hwaddr offset,
         }
     }
 
-    regs[offset/4] = value;
+    if (offset / 4 >= NUM_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                  "highbank: bad write offset 0x%" HWADDR_PRIx "\n", offset);
+        return;
+    }
+    regs[offset / 4] = value;
 }
 
 static uint64_t hb_regs_read(void *opaque, hwaddr offset,
                              unsigned size)
 {
+    uint32_t value;
     uint32_t *regs = opaque;
-    uint32_t value = regs[offset/4];
+
+    if (offset / 4 >= NUM_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                  "highbank: bad read offset 0x%" HWADDR_PRIx "\n", offset);
+        return 0;
+    }
+    value = regs[offset / 4];
 
     if ((offset == 0x100) || (offset == 0x108) || (offset == 0x10C)) {
         value |= 0x30000000;
-- 
2.13.6

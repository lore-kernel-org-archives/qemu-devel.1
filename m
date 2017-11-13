Received: from eggs.gnu.org ([2001:4830:134:3::10]:47447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFSL-0004A6-Q8
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFSH-0007jt-Jc
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:21 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eEFSH-0007Yd-CW
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:17 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFS3-00022S-MZ
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 14:11:03 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 14:11:37 +0000
Message-Id: <1510582304-27058-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1510582304-27058-1-git-send-email-peter.maydell@linaro.org>
References: <1510582304-27058-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 2/9] highbank: validate register offset before
 access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Prasad J Pandit <pjp@fedoraproject.org>

An 'offset' parameter sent to highbank register r/w functions
could be greater than number(NUM_REGS=0x200) of hb registers,
leading to an OOB access issue. Add check to avoid it.

Reported-by: Moguofang (Dennis mo) <moguofang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-id: 20171113062658.9697-1-ppandit@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/highbank.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 354c6b2..287392b 100644
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
2.7.4

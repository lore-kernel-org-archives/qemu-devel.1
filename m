Received: from eggs.gnu.org ([2001:4830:134:3::10]:46797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eOLkk-0005bt-OU
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 05:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eOLkj-0001zW-Um
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 05:56:06 -0500
From: P J P <ppandit@redhat.com>
Date: Mon, 11 Dec 2017 16:25:46 +0530
Message-Id: <20171211105546.16466-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] display: check irq handler index before access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Moguofang <moguofang@huawei.com>, qemu-arm@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

The ctz32() routine could return value greater than
TC6393XB_GPIOS=16. This could lead to an OOB array access.
Add check to avoid it.

Reported-by: Moguofang <moguofang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/display/tc6393xb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index 74d10af3d4..78292cb847 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -175,6 +175,10 @@ static void tc6393xb_gpio_handler_update(TC6393xbState *s)
 
     for (diff = s->prev_level ^ level; diff; diff ^= 1 << bit) {
         bit = ctz32(diff);
+        if (bit >= TC6393XB_GPIOS) {
+            fprintf(stderr, "TC6393xb: no GPIO pin %d\n", bit);
+            return;
+        }
         qemu_set_irq(s->handler[bit], (level >> bit) & 1);
     }
 
-- 
2.13.6

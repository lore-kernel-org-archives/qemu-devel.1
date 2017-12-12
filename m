Received: from eggs.gnu.org ([2001:4830:134:3::10]:37912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eObyz-0005Vx-TJ
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 23:15:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eObyy-00081U-V7
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 23:15:53 -0500
From: P J P <ppandit@redhat.com>
Date: Tue, 12 Dec 2017 09:45:39 +0530
Message-Id: <20171212041539.25700-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v1] display: limit irq handler index to
 TC6393XB_GPIOS
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
Mask 'level' to avoid it.

Reported-by: Moguofang <moguofang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/display/tc6393xb.c | 1 +
 1 file changed, 1 insertion(+)

Update: mask 'level' value to TC6393XB_GPIOS=16
  -> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg01685.html

diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index 74d10af3d4..0ae63605f0 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -172,6 +172,7 @@ static void tc6393xb_gpio_handler_update(TC6393xbState *s)
     int bit;
 
     level = s->gpio_level & s->gpio_dir;
+    level &= MAKE_64BIT_MASK(0, TC6393XB_GPIOS);
 
     for (diff = s->prev_level ^ level; diff; diff ^= 1 << bit) {
         bit = ctz32(diff);
-- 
2.13.6

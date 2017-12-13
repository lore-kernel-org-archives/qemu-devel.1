Received: from eggs.gnu.org ([2001:4830:134:3::10]:51907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWt-00055O-Bl
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWp-0008EL-Ho
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:15 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWp-0008CR-B4
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:11 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWo-0007qE-3n
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:13:10 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:37 +0000
Message-Id: <1513188761-20784-40-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 39/43] hw/display/tc6393xb: limit irq handler
 index to TC6393XB_GPIOS
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

The ctz32() routine could return a value greater than
TC6393XB_GPIOS=16, because the device has 24 GPIO level
bits but we only implement 16 outgoing lines. This could
lead to an OOB array access. Mask 'level' to avoid it.

Reported-by: Moguofang <moguofang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-id: 20171212041539.25700-1-ppandit@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/tc6393xb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index 74d10af..0ae6360 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -172,6 +172,7 @@ static void tc6393xb_gpio_handler_update(TC6393xbState *s)
     int bit;
 
     level = s->gpio_level & s->gpio_dir;
+    level &= MAKE_64BIT_MASK(0, TC6393XB_GPIOS);
 
     for (diff = s->prev_level ^ level; diff; diff ^= 1 << bit) {
         bit = ctz32(diff);
-- 
2.7.4

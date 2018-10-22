Received: from eggs.gnu.org ([2001:4830:134:3::10]:33320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gEehD-0004KY-GL
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gEeh9-0002KZ-Do
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:12:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5667)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gEeh8-0002FH-Ua
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:12:51 -0400
From: P J P <ppandit@redhat.com>
Date: Mon, 22 Oct 2018 23:40:35 +0530
Message-Id: <20181022181035.20104-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v1] arm: check bit index before usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, liqsub1 <liqsub1@163.com>, Moguofang <moguofang@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While performing gpio write via strongarm_gpio_handler_update
routine, the 'bit' index could access beyond s->handler[28] array.
Add check to avoid OOB access.

Reported-by: Moguofang <moguofang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/arm/strongarm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Update v1: use ARRAY_SIZE macro
  -> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg04826.html

diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index ec2627374d..9225b1ba6e 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -532,7 +532,9 @@ static void strongarm_gpio_handler_update(StrongARMGPIOInfo *s)
 
     for (diff = s->prev_level ^ level; diff; diff ^= 1 << bit) {
         bit = ctz32(diff);
-        qemu_set_irq(s->handler[bit], (level >> bit) & 1);
+        if (bit < ARRAY_SIZE(s->handler)) {
+            qemu_set_irq(s->handler[bit], (level >> bit) & 1);
+        }
     }
 
     s->prev_level = level;
-- 
2.17.2

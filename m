Received: from eggs.gnu.org ([2001:4830:134:3::10]:59296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gEZ3e-0001AM-68
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gEZ3a-0007Q9-Vq
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:11:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gEZ3a-00075q-NY
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:11:38 -0400
From: P J P <ppandit@redhat.com>
Date: Mon, 22 Oct 2018 17:39:08 +0530
Message-Id: <20181022120908.13285-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] arm: check bit index before use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Moguofang <moguofang@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While performing gpio write via strongarm_gpio_handler_update
routine, the 'bit' index could access beyond s->handler[28] array.
Add check to avoid OOB access.

Reported-by: Moguofang <moguofang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/arm/strongarm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index ec2627374d..3dda75feaf 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -532,7 +532,9 @@ static void strongarm_gpio_handler_update(StrongARMGPIOInfo *s)
 
     for (diff = s->prev_level ^ level; diff; diff ^= 1 << bit) {
         bit = ctz32(diff);
-        qemu_set_irq(s->handler[bit], (level >> bit) & 1);
+        if (bit < sizeof(s->handler) / sizeof(s->handler[0])) {
+            qemu_set_irq(s->handler[bit], (level >> bit) & 1);
+        }
     }
 
     s->prev_level = level;
-- 
2.17.2

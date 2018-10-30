Received: from eggs.gnu.org ([2001:4830:134:3::10]:37894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gHSVu-0001Ls-Kw
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gHSVq-0001jo-ON
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:48:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gHSVn-0001ca-18
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:48:43 -0400
From: P J P <ppandit@redhat.com>
Date: Tue, 30 Oct 2018 17:16:35 +0530
Message-Id: <20181030114635.31232-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v3] strongarm: mask off high[31:28] bits from
 dir and state registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Moguofang <moguofang@huawei.com>, liqsub1 <liqsub1@163.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

The high[31:28] bits of 'direction' and 'state' registers of
SA-1100/SA-1110 device are reserved. Setting them may lead to
OOB 's->handler[]' array access issue. Mask off [31:28] bits to
avoid it.

Reported-by: Moguofang <moguofang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/arm/strongarm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Update v3: fix the mask value to 0x0fffffff
  -> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06088.html

diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index ec2627374d..644a9c45b4 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -587,12 +587,12 @@ static void strongarm_gpio_write(void *opaque, hwaddr offset,
 
     switch (offset) {
     case GPDR:        /* GPIO Pin-Direction registers */
-        s->dir = value;
+        s->dir = value & 0x0fffffff;
         strongarm_gpio_handler_update(s);
         break;
 
     case GPSR:        /* GPIO Pin-Output Set registers */
-        s->olevel |= value;
+        s->olevel |= value & 0x0fffffff;
         strongarm_gpio_handler_update(s);
         break;
 
-- 
2.17.2

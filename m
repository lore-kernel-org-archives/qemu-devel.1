Received: from eggs.gnu.org ([2001:4830:134:3::10]:45585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFwbx-0004TJ-Bz
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 03:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFwbt-00072N-D9
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 03:32:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gFwbt-00071q-65
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 03:32:45 -0400
From: P J P <ppandit@redhat.com>
Date: Fri, 26 Oct 2018 13:00:34 +0530
Message-Id: <20181026073034.16648-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v2] strongarm: mask off high[32:28] bits from
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
Cc: Moguofang <moguofang@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, liqsub1 <liqsub1@163.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

The high[32:28] bits of 'direction' and 'state' registers of
SA-1100/SA-1110 device are reserved. Setting them may lead to
OOB 's->handler[]' array access issue. Mask off [32:28] bits to
avoid it.

Reported-by: Moguofang <moguofang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/arm/strongarm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Update v2: mask off high[32:28] bits
  -> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg05746.html

diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index ec2627374d..dd8c4b1f2e 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -587,12 +587,12 @@ static void strongarm_gpio_write(void *opaque, hwaddr offset,
 
     switch (offset) {
     case GPDR:        /* GPIO Pin-Direction registers */
-        s->dir = value;
+        s->dir = value & 0x3fffff;
         strongarm_gpio_handler_update(s);
         break;
 
     case GPSR:        /* GPIO Pin-Output Set registers */
-        s->olevel |= value;
+        s->olevel |= value & 0x3fffff;
         strongarm_gpio_handler_update(s);
         break;
 
-- 
2.17.2

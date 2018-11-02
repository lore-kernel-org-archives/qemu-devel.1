Received: from eggs.gnu.org ([2001:4830:134:3::10]:50841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gId63-0001yc-Do
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gId62-0004Dy-1w
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:18:59 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gId61-0002Zn-3p
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:18:57 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gId3v-0003aW-21
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 17:16:47 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Nov 2018 17:16:34 +0000
Message-Id: <20181102171638.24069-7-peter.maydell@linaro.org>
In-Reply-To: <20181102171638.24069-1-peter.maydell@linaro.org>
References: <20181102171638.24069-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/10] strongarm: mask off high[31:28] bits from
 dir and state registers
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

The high[31:28] bits of 'direction' and 'state' registers of
SA-1100/SA-1110 device are reserved. Setting them may lead to
OOB 's->handler[]' array access issue. Mask off [31:28] bits to
avoid it.

Reported-by: Moguofang <moguofang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-id: 20181030114635.31232-1-ppandit@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/strongarm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index ec2627374d0..644a9c45b4e 100644
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
2.19.1

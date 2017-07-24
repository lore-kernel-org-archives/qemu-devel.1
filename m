Received: from eggs.gnu.org ([2001:4830:134:3::10]:45587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dZaVG-0008UO-49
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dZaVC-0006FQ-6R
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:22:18 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:60419)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dZaVB-0006BF-Fc
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:22:14 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Tue, 25 Jul 2017 02:35:22 +0800
Message-Id: <1500921322-36875-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V3] rtc: fix a infinite loop in windows vm
 startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>, Liu Yi <liu.yi24@zte.com.cn>

When a windows vm starts, periodic timer of rtc will stop several times.
windows kernel will check whether REG_A_UIP is changed. REG_C's interrupt
flags will not be cleared when periodic timer stops and the update timer
will switch to alarm timer. So the expiration time of alarm timer is very
long and REG_A_UIP will not vary.At last windows kernel will repeat to 
check REG_A_UIP all the time.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Liu Yi <liu.yi24@zte.com.cn>
---
 hw/timer/mc146818rtc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 1b8d3d7..aa55fae 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -457,6 +457,8 @@ static void rtc_update_timer(void *opaque)
     if ((new_irqs & s->cmos_data[RTC_REG_B]) != 0) {
         s->cmos_data[RTC_REG_C] |= REG_C_IRQF;
         qemu_irq_raise(s->irq);
+    } else if ((s->cmos_data[RTC_REG_B] & REG_B_UIE) == 0) {
+        s->cmos_data[RTC_REG_C] &= ~REG_C_UF;
     }
     check_update_timer(s);
 }
@@ -559,7 +561,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
                 s->cmos_data[RTC_REG_C] |= REG_C_IRQF;
                 qemu_irq_raise(s->irq);
             } else {
-                s->cmos_data[RTC_REG_C] &= ~REG_C_IRQF;
+                s->cmos_data[RTC_REG_C] &= ~(REG_C_UF | REG_C_IRQF);
                 qemu_irq_lower(s->irq);
             }
             s->cmos_data[RTC_REG_B] = data;
-- 
1.8.3.1

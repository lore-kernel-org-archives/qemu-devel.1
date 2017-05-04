Received: from eggs.gnu.org ([2001:4830:134:3::10]:51324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d6FQb-0002VI-7z
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d6FQZ-0006d5-OG
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:00:13 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1d6FQZ-0006cU-I2
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:00:11 -0400
Received: by mail-pg0-x244.google.com with SMTP id v1so2011964pgv.3
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 05:00:11 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Thu,  4 May 2017 19:59:44 +0800
Message-Id: <20170504115948.3048-2-xiaoguangrong@tencent.com>
In-Reply-To: <20170504115948.3048-1-xiaoguangrong@tencent.com>
References: <20170504115948.3048-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 1/5] mc146818rtc: update periodic timer only
 if it is needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, yunfangtai@tencent.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Currently, the timer is updated whenever RegA or RegB is written
even if the periodic timer related configuration is not changed

This patch optimizes it slightly to make the update happen only
if its period or enable-status is changed, also later patches are
depend on this optimization

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 hw/timer/mc146818rtc.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 4165450..5cccb2a 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -391,6 +391,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
                               uint64_t data, unsigned size)
 {
     RTCState *s = opaque;
+    bool update_periodic_timer;
 
     if ((addr & 1) == 0) {
         s->cmos_index = data & 0x7f;
@@ -423,6 +424,8 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
             }
             break;
         case RTC_REG_A:
+            update_periodic_timer = (s->cmos_data[RTC_REG_A] ^ data) & 0x0f;
+
             if ((data & 0x60) == 0x60) {
                 if (rtc_running(s)) {
                     rtc_update_time(s);
@@ -445,10 +448,17 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
             /* UIP bit is read only */
             s->cmos_data[RTC_REG_A] = (data & ~REG_A_UIP) |
                 (s->cmos_data[RTC_REG_A] & REG_A_UIP);
-            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
+
+            if (update_periodic_timer) {
+                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
+            }
+
             check_update_timer(s);
             break;
         case RTC_REG_B:
+            update_periodic_timer = (s->cmos_data[RTC_REG_B] ^ data)
+                                       & REG_B_PIE;
+
             if (data & REG_B_SET) {
                 /* update cmos to when the rtc was stopping */
                 if (rtc_running(s)) {
@@ -475,7 +485,11 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
                 qemu_irq_lower(s->irq);
             }
             s->cmos_data[RTC_REG_B] = data;
-            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
+
+            if (update_periodic_timer) {
+                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
+            }
+
             check_update_timer(s);
             break;
         case RTC_REG_C:
-- 
2.9.3

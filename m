Received: from eggs.gnu.org ([2001:4830:134:3::10]:49311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dBfyE-0004GR-Ei
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dBfyA-0000sh-Ss
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:22 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dBfyA-0000sK-NM
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:18 -0400
Received: by mail-wr0-x243.google.com with SMTP id v42so2612876wrc.3
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 04:21:18 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 19 May 2017 13:20:53 +0200
Message-Id: <1495192872-27667-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1495192872-27667-1-git-send-email-pbonzini@redhat.com>
References: <1495192872-27667-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/20] mc146818rtc: update periodic timer only
 if it is needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Currently, the timer is updated whenever RegA or RegB is written
even if the periodic timer related configuration is not changed

This patch optimizes it slightly to make the update happen only
if its period or enable-status is changed, also later patches are
depend on this optimization

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Message-Id: <20170510083259.3900-2-xiaoguangrong@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/mc146818rtc.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 93de3e1..7d78391 100644
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
1.8.3.1

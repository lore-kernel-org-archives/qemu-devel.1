Received: from eggs.gnu.org ([2001:4830:134:3::10]:59308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1faOpO-0003UP-I7
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 13:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1faOpN-0005Ff-KR
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 13:10:58 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  3 Jul 2018 18:10:44 +0100
Message-Id: <20180703171044.9503-5-peter.maydell@linaro.org>
In-Reply-To: <20180703171044.9503-1-peter.maydell@linaro.org>
References: <20180703171044.9503-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0 4/4] hw/timer/cmsdk-apb-timer: run or
 stop timer on writes to RELOAD and VALUE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Guenter Roeck <linux@roeck-us.net>

If the CMSDK APB timer is set up with a zero RELOAD value
then it will count down to zero, fire once and then stay
at zero. From the point of view of the ptimer system, the
timer is disabled; but the enable bit in the CTRL register
is still set and if the guest subsequently writes to the
RELOAD or VALUE registers this should cause the timer to
start counting down again.

Add code to the write paths for RELOAD and VALUE so that
we correctly restart the timer in this situation.

Conversely, if the new RELOAD and VALUE are both zero,
we should stop the ptimer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/cmsdk-apb-timer.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index 3ebdc7be408..801d1dba741 100644
--- a/hw/timer/cmsdk-apb-timer.c
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -126,10 +126,26 @@ static void cmsdk_apb_timer_write(void *opaque, hwaddr offset, uint64_t value,
         break;
     case A_RELOAD:
         /* Writing to reload also sets the current timer value */
+        if (!value) {
+            ptimer_stop(s->timer);
+        }
         ptimer_set_limit(s->timer, value, 1);
+        if (value && (s->ctrl & R_CTRL_EN_MASK)) {
+            /*
+             * Make sure timer is running (it might have stopped if this
+             * was an expired one-shot timer)
+             */
+            ptimer_run(s->timer, 0);
+        }
         break;
     case A_VALUE:
+        if (!value && !ptimer_get_limit(s->timer)) {
+            ptimer_stop(s->timer);
+        }
         ptimer_set_count(s->timer, value);
+        if (value && (s->ctrl & R_CTRL_EN_MASK)) {
+            ptimer_run(s->timer, ptimer_get_limit(s->timer) == 0);
+        }
         break;
     case A_INTSTATUS:
         /* Just one bit, which is W1C. */
-- 
2.17.1

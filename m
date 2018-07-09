Received: from eggs.gnu.org ([2001:4830:134:3::10]:48164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWck-0007fF-Ha
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWcj-00051s-Jy
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:42 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fcWcj-00051K-Cx
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:41 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWci-0000iL-Cd
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:54:40 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jul 2018 14:54:29 +0100
Message-Id: <20180709135435.836-6-peter.maydell@linaro.org>
In-Reply-To: <20180709135435.836-1-peter.maydell@linaro.org>
References: <20180709135435.836-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 05/11] hw/timer/cmsdk-apb-timer: run or stop
 timer on writes to RELOAD and VALUE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20180703171044.9503-5-peter.maydell@linaro.org
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

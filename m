Received: from eggs.gnu.org ([2001:4830:134:3::10]:59351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1faOpQ-0003WS-V5
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 13:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1faOpP-0005H8-Qw
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 13:11:00 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  3 Jul 2018 18:10:42 +0100
Message-Id: <20180703171044.9503-3-peter.maydell@linaro.org>
In-Reply-To: <20180703171044.9503-1-peter.maydell@linaro.org>
References: <20180703171044.9503-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0 2/4] hw/timer/cmsdk-apb-timer: Correct
 ptimer policy settings
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

The CMSDK timer interrupt triggers when the counter goes from 1 to 0,
so we want to trigger immediately, rather than waiting for a
clock cycle. Drop the incorrect NO_IMMEDIATE_TRIGGER setting.
We also do not want to get an interrupt if the guest sets the
counter directly to zero, so use the new TRIGGER_ONLY_ON_DECREMENT
policy.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/cmsdk-apb-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index 9878746609a..1f99081db1a 100644
--- a/hw/timer/cmsdk-apb-timer.c
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -201,7 +201,7 @@ static void cmsdk_apb_timer_realize(DeviceState *dev, Error **errp)
     bh = qemu_bh_new(cmsdk_apb_timer_tick, s);
     s->timer = ptimer_init(bh,
                            PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD |
-                           PTIMER_POLICY_NO_IMMEDIATE_TRIGGER |
+                           PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT |
                            PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
                            PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
 
-- 
2.17.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWcj-0007eJ-0R
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWci-00050j-3h
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:41 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fcWch-00050D-Sf
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:40 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWcg-0000hY-RQ
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:54:38 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jul 2018 14:54:27 +0100
Message-Id: <20180709135435.836-4-peter.maydell@linaro.org>
In-Reply-To: <20180709135435.836-1-peter.maydell@linaro.org>
References: <20180709135435.836-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/11] hw/timer/cmsdk-apb-timer: Correct ptimer
 policy settings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The CMSDK timer interrupt triggers when the counter goes from 1 to 0,
so we want to trigger immediately, rather than waiting for a
clock cycle. Drop the incorrect NO_IMMEDIATE_TRIGGER setting.
We also do not want to get an interrupt if the guest sets the
counter directly to zero, so use the new TRIGGER_ONLY_ON_DECREMENT
policy.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20180703171044.9503-3-peter.maydell@linaro.org
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

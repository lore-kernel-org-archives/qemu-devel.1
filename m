Received: from eggs.gnu.org ([2001:4830:134:3::10]:48161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWck-0007ex-7N
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWcj-00051V-4J
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:42 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fcWci-00050D-Tp
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:41 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWch-0000hm-KM
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:54:39 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jul 2018 14:54:28 +0100
Message-Id: <20180709135435.836-5-peter.maydell@linaro.org>
In-Reply-To: <20180709135435.836-1-peter.maydell@linaro.org>
References: <20180709135435.836-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/11] hw/timer/cmsdk-apb-timer: Correctly
 identify and set one-shot mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Guenter Roeck <linux@roeck-us.net>

The CMSDK APB timer is currently always configured as periodic timer.
This results in the following messages when trying to boot Linux.

Timer with delta zero, disabling

If the timer limit set with the RELOAD command is 0, the timer
needs to be enabled as one-shot timer.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/cmsdk-apb-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index 1f99081db1a..3ebdc7be408 100644
--- a/hw/timer/cmsdk-apb-timer.c
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -119,7 +119,7 @@ static void cmsdk_apb_timer_write(void *opaque, hwaddr offset, uint64_t value,
         }
         s->ctrl = value & 0xf;
         if (s->ctrl & R_CTRL_EN_MASK) {
-            ptimer_run(s->timer, 0);
+            ptimer_run(s->timer, ptimer_get_limit(s->timer) == 0);
         } else {
             ptimer_stop(s->timer);
         }
-- 
2.17.1

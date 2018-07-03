Received: from eggs.gnu.org ([2001:4830:134:3::10]:59332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1faOpP-0003Uf-Aw
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 13:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1faOpO-0005G2-BD
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 13:10:59 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  3 Jul 2018 18:10:43 +0100
Message-Id: <20180703171044.9503-4-peter.maydell@linaro.org>
In-Reply-To: <20180703171044.9503-1-peter.maydell@linaro.org>
References: <20180703171044.9503-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0 3/4] hw/timer/cmsdk-apb-timer:
 Correctly identify and set one-shot mode
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

From: Guenter Roeck <linux@roeck-us.net>

The CMSDK APB timer is currently always configured as periodic timer.
This results in the following messages when trying to boot Linux.

Timer with delta zero, disabling

If the timer limit set with the RELOAD command is 0, the timer
needs to be enabled as one-shot timer.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 1529374119-27015-1-git-send-email-linux@roeck-us.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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

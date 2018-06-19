Received: from eggs.gnu.org ([2001:4830:134:3::10]:51912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fV64e-0002L1-W6
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 22:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fV64e-0001XA-Am
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 22:08:48 -0400
From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 18 Jun 2018 19:08:39 -0700
Message-Id: <1529374119-27015-1-git-send-email-linux@roeck-us.net>
Subject: [Qemu-devel] [PATCH] hw/char/cmsdk-apb-timer: Correctly identify
 and set one-shot mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>

The CMSDK APB timer is currently always configured as periodic timer.
This results in the following messages when trying to boot Linux.

Timer with delta zero, disabling

If the timer limit set with the RELOAD command is 0, the timer
needs to be enabled as one-shot timer.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/timer/cmsdk-apb-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index 9878746..79c1b49 100644
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
2.7.4

Received: from eggs.gnu.org ([209.51.188.92]:53345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sohailalvi2236@gmail.com>) id 1hDaiH-0003PP-M3
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sohailalvi2236@gmail.com>) id 1hDaiG-0005yK-Np
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:17:53 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sohailalvi2236@gmail.com>)
	id 1hDaiF-0005w5-S2
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:17:52 -0400
Received: by mail-pg1-x543.google.com with SMTP id k3so7929140pga.6
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 13:17:48 -0700 (PDT)
From: sohailalvi2236@gmail.com
Date: Tue,  9 Apr 2019 01:47:41 +0530
Message-Id: <20190408201741.8042-1-sohailalvi2236@gmail.com>
In-Reply-To: <CAFEAcA-D0MK_eEs+tvPsdp+2s9YuC=qS=uyhzNtqy3DW9-=rNQ@mail.gmail.com>
References: <CAFEAcA-D0MK_eEs+tvPsdp+2s9YuC=qS=uyhzNtqy3DW9-=rNQ@mail.gmail.com>
Subject: [Qemu-devel] [PATCH 02/5] hw/timer: qemu_system_reset() replaced by
 watchdog_perform_action()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Sohail Alvi <sohailalvi2236@gmail.com>

From: Sohail Alvi <sohailalvi2236@gmail.com>

Signed-off-by: SohailAlvi <sohailalvi2236@gmail.com>

The watchdog_perform_action() function has been added in place of qemu_system_reset where watchdog was triggered.
Changes have been made according to the previous suggestions given by Peter
Maydell.

The patch was tested with scripts/checkpatch.pl and no style errors were
found.
---
 hw/timer/etraxfs_timer.c | 3 ++-
 hw/timer/m48t59.c        | 3 ++-
 hw/timer/pxa2xx_timer.c  | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index 2280914b1d..9561113d0e 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -26,6 +26,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
+#include "sysemu/watchdog.h"
 
 #define D(x)
 
@@ -207,7 +208,7 @@ static void watchdog_hit(void *opaque)
         qemu_irq_raise(t->nmi);
     }
     else
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        watchdog_perform_action();
 
     t->wd_hits++;
 }
diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index ca3ed445de..ebe58e8dc7 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -30,6 +30,7 @@
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
 #include "qemu/bcd.h"
+#include "sysemu/watchdog.h"
 
 #include "m48t59-internal.h"
 
@@ -158,7 +159,7 @@ static void watchdog_cb (void *opaque)
 	NVRAM->buffer[0x1FF7] = 0x00;
 	NVRAM->buffer[0x1FFC] &= ~0x40;
         /* May it be a hw CPU Reset instead ? */
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        watchdog_perform_action();
     } else {
 	qemu_set_irq(NVRAM->IRQ, 1);
 	qemu_set_irq(NVRAM->IRQ, 0);
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index a489bf5159..2be680b5df 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -14,6 +14,7 @@
 #include "hw/arm/pxa.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
+#include "sysemu/watchdog.h"
 
 #define OSMR0	0x00
 #define OSMR1	0x04
@@ -414,7 +415,7 @@ static void pxa2xx_timer_tick(void *opaque)
     if (t->num == 3)
         if (i->reset3 & 1) {
             i->reset3 = 0;
-            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+            watchdog_perform_action();
         }
 }
 
-- 
2.17.1

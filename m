Received: from eggs.gnu.org ([209.51.188.92]:34671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9fM-0005Om-BP
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9fH-0006zA-2a
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:02:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:40394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9fD-0006bs-T7
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:02:01 -0400
Received: by mail-wm1-x32b.google.com with SMTP id h11so155332wmb.5
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.13
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:00:21 +0100
Message-Id: <20190429170030.11323-34-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 33/42] hw/display/tc6393xb: Remove unused
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <philmd@redhat.com>

No code used the tc6393xb_gpio_in_get() and tc6393xb_gpio_out_set()
functions since their introduction in commit 88d2c950b002. Time to
remove them.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190412165416.7977-4-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/devices.h  |  3 ---
 hw/display/tc6393xb.c | 16 ----------------
 2 files changed, 19 deletions(-)

diff --git a/include/hw/devices.h b/include/hw/devices.h
index 1ed5be32967..0850f697451 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -54,9 +54,6 @@ void retu_key_event(void *retu, int state);
 typedef struct TC6393xbState TC6393xbState;
 TC6393xbState *tc6393xb_init(struct MemoryRegion *sysmem,
                              uint32_t base, qemu_irq irq);
-void tc6393xb_gpio_out_set(TC6393xbState *s, int line,
-                    qemu_irq handler);
-qemu_irq *tc6393xb_gpio_in_get(TC6393xbState *s);
 qemu_irq tc6393xb_l3v_get(TC6393xbState *s);
 
 #endif
diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index e1b1e302f23..6d133d9a66c 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -137,11 +137,6 @@ struct TC6393xbState {
              blanked : 1;
 };
 
-qemu_irq *tc6393xb_gpio_in_get(TC6393xbState *s)
-{
-    return s->gpio_in;
-}
-
 static void tc6393xb_gpio_set(void *opaque, int line, int level)
 {
 //    TC6393xbState *s = opaque;
@@ -154,17 +149,6 @@ static void tc6393xb_gpio_set(void *opaque, int line, int level)
     // FIXME: how does the chip reflect the GPIO input level change?
 }
 
-void tc6393xb_gpio_out_set(TC6393xbState *s, int line,
-                    qemu_irq handler)
-{
-    if (line >= TC6393XB_GPIOS) {
-        fprintf(stderr, "TC6393xb: no GPIO pin %d\n", line);
-        return;
-    }
-
-    s->handler[line] = handler;
-}
-
 static void tc6393xb_gpio_handler_update(TC6393xbState *s)
 {
     uint32_t level, diff;
-- 
2.20.1

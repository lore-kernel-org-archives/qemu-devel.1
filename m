Received: from eggs.gnu.org ([209.51.188.92]:48990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gst9x-0004X1-7n
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 12:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gst9w-0007Oj-5a
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 12:44:53 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 10 Feb 2019 17:44:21 +0000
Message-Id: <20190210174421.22062-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH] cuda: decrease time delay before raising VIA
 SR interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, hsp.cat7@gmail.com

In order to handle a race condition in MacOS 9, a delay was introduced when
raising the VIA SR interrupt inspired by similar code in MacOnLinux.

During original testing of the MacOS 9 patches it was found that the 30us
delay used in MacOnLinux did not work reliably within QEMU, and a value of
300us was required to function correctly.

Recent experiments have shown that the previous reliability issues are no
longer present, and this value can be reduced down to 20us with no apparent
ill effects in my local tests. This has the benefit of considerably improving
the responsiveness of the ADB keyboard and mouse with the guest.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/cuda.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index c4f7a2f39b..3febacdd1e 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -97,17 +97,8 @@ static void cuda_set_sr_int(void *opaque)
 
 static void cuda_delay_set_sr_int(CUDAState *s)
 {
-    MOS6522CUDAState *mcs = &s->mos6522_cuda;
-    MOS6522State *ms = MOS6522(mcs);
-    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(ms);
     int64_t expire;
 
-    if (ms->dirb == 0xff || s->sr_delay_ns == 0) {
-        /* Disabled or not in Mac OS, fire the IRQ directly */
-        mdc->set_sr_int(ms);
-        return;
-    }
-
     trace_cuda_delay_set_sr_int();
 
     expire = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->sr_delay_ns;
@@ -542,7 +533,7 @@ static void cuda_realize(DeviceState *dev, Error **errp)
     s->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
 
     s->sr_delay_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_set_sr_int, s);
-    s->sr_delay_ns = 300 * SCALE_US;
+    s->sr_delay_ns = 20 * SCALE_US;
 
     s->adb_poll_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_adb_poll, s);
     s->adb_poll_mask = 0xffff;
-- 
2.11.0

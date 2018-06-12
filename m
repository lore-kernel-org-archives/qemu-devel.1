Received: from eggs.gnu.org ([2001:4830:134:3::10]:59114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3s-0002rb-KT
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3r-00020V-9P
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:48 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:51 +1000
Message-Id: <20180612064503.14282-22-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 21/33] mos6522: convert VMSTATE_TIMER_PTR_TEST
 to VMSTATE_TIMER_PTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The timers are configured in the mos6522 init function and therefore will
always exist, so the function can never return false.

Peter also pointed out that this is the only remaining user of
VMSTATE_TIMER_PTR_TEST in the codebase, so we might as well just convert it
over to VMSTATE_TIMER_PTR and remove mos6522_timer_exist() as it is no
longer required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/mos6522.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 2f58b9707f..44eb306cf1 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -369,13 +369,6 @@ static const MemoryRegionOps mos6522_ops = {
     },
 };
 
-static bool mos6522_timer_exist(void *opaque, int version_id)
-{
-    MOS6522Timer *s = opaque;
-
-    return s->timer != NULL;
-}
-
 static const VMStateDescription vmstate_mos6522_timer = {
     .name = "mos6522_timer",
     .version_id = 0,
@@ -385,7 +378,7 @@ static const VMStateDescription vmstate_mos6522_timer = {
         VMSTATE_UINT16(counter_value, MOS6522Timer),
         VMSTATE_INT64(load_time, MOS6522Timer),
         VMSTATE_INT64(next_irq_time, MOS6522Timer),
-        VMSTATE_TIMER_PTR_TEST(timer, MOS6522Timer, mos6522_timer_exist),
+        VMSTATE_TIMER_PTR(timer, MOS6522Timer),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.17.1

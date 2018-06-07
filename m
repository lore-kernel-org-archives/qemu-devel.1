Received: from eggs.gnu.org ([2001:4830:134:3::10]:35325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fQyY7-0002ZE-MM
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fQyY6-0001pM-KC
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:18:11 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  7 Jun 2018 18:17:51 +0100
Message-Id: <20180607171751.11510-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180607171751.11510-1-mark.cave-ayland@ilande.co.uk>
References: <20180607171751.11510-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 4/4] mos6522: convert VMSTATE_TIMER_PTR_TEST to
 VMSTATE_TIMER_PTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

The timers are configured in the mos6522 init function and therefore will
always exist, so the function can never return false.

Peter also pointed out that this is the only remaining user of
VMSTATE_TIMER_PTR_TEST in the codebase, so we might as well just convert it
over to VMSTATE_TIMER_PTR and remove mos6522_timer_exist() as it is no
longer required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/mos6522.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index d0a0c9e5d9..e9b686ac92 100644
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
2.11.0

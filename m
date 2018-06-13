Received: from eggs.gnu.org ([2001:4830:134:3::10]:52946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fT1Am-00013p-1q
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fT1Ai-0003ch-1p
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:30:31 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 13 Jun 2018 09:30:13 +0100
Message-Id: <20180613083015.15749-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180613083015.15749-1-mark.cave-ayland@ilande.co.uk>
References: <20180613083015.15749-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/3] mos6522: only clear the shift register
 interrupt upon write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, david@gibson.dropbear.id.au

According to the 6522 datasheet the shift register (SR) interrupt flag is
cleared upon write with no mention of any other interrupt flags.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/mos6522.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 44eb306cf1..ad5041d8c0 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -241,7 +241,7 @@ uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size)
         break;
     case VIA_REG_SR:
         val = s->sr;
-        s->ifr &= ~(SR_INT | CB1_INT | CB2_INT);
+        s->ifr &= ~SR_INT;
         mos6522_update_irq(s);
         break;
     case VIA_REG_ACR:
-- 
2.11.0

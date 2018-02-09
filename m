Received: from eggs.gnu.org ([2001:4830:134:3::10]:43379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekDmF-0001Km-UZ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekDmF-0004e9-9b
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:52:04 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  9 Feb 2018 18:51:33 +0000
Message-Id: <20180209185142.17151-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 03/12] cuda: don't call cuda_update() when
 writing to ACR register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, lvivier@redhat.com

The wire protocol for reading data to/from the VIA is triggered by changing
inputs on port B rather than changing the timer configuration via the ACR.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/cuda.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index eaa8924f49..1d0f7e8289 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -406,7 +406,6 @@ static void cuda_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
     case CUDA_REG_ACR:
         s->acr = val;
         cuda_timer_update(s, &s->timers[0], qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
-        cuda_update(s);
         break;
     case CUDA_REG_PCR:
         s->pcr = val;
-- 
2.11.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zN-0007iP-FZ
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zL-0006C2-Hd
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:09 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 12 Feb 2018 14:40:51 +1100
Message-Id: <20180212034054.23441-10-david@gibson.dropbear.id.au>
In-Reply-To: <20180212034054.23441-1-david@gibson.dropbear.id.au>
References: <20180212034054.23441-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 09/12] cuda: don't call cuda_update() when
 writing to ACR register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The wire protocol for reading data to/from the VIA is triggered by changing
inputs on port B rather than changing the timer configuration via the ACR.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/cuda.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 729905236c..355a2f2262 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -407,7 +407,6 @@ static void cuda_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
     case CUDA_REG_ACR:
         s->acr = val;
         cuda_timer_update(s, &s->timers[0], qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
-        cuda_update(s);
         break;
     case CUDA_REG_PCR:
         s->pcr = val;
-- 
2.14.3

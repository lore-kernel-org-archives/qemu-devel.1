Received: from eggs.gnu.org ([2001:4830:134:3::10]:50428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvCh-0001yo-NK
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:37:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvCg-0008T3-4o
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:37:51 -0500
Received: from chuckie.co.uk ([82.165.15.123]:36245
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ehvCf-0008RJ-R0
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:37:50 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat,  3 Feb 2018 10:37:20 +0000
Message-Id: <20180203103727.26457-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 03/10] cuda: don't call cuda_update() when
 writing to ACR register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lvivier@redhat.com

The wire protocol for reading data to/from the VIA is triggered by changing
inputs on port B rather than changing the timer configuration via the ACR.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/cuda.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 7214e7adcb..ba14dbeacd 100644
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

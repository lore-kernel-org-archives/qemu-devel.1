Received: from eggs.gnu.org ([2001:4830:134:3::10]:43426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekDmH-0001LK-Kj
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekDmG-0004f1-Ew
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:52:05 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  9 Feb 2018 18:51:34 +0000
Message-Id: <20180209185142.17151-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv2 04/12] cuda: introduce CUDAState parameter to
 get_counter()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, lvivier@redhat.com

This will be required shortly and also happens to match nicely with the
corresponding signature for set_counter().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/macio/cuda.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 1d0f7e8289..a88535fa66 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -150,7 +150,7 @@ static uint64_t get_tb(uint64_t time, uint64_t freq)
     return muldiv64(time, freq, NANOSECONDS_PER_SECOND);
 }
 
-static unsigned int get_counter(CUDATimer *ti)
+static unsigned int get_counter(CUDAState *s, CUDATimer *ti)
 {
     int64_t d;
     unsigned int counter;
@@ -295,12 +295,12 @@ static uint64_t cuda_read(void *opaque, hwaddr addr, unsigned size)
         val = s->dira;
         break;
     case CUDA_REG_T1CL:
-        val = get_counter(&s->timers[0]) & 0xff;
+        val = get_counter(s, &s->timers[0]) & 0xff;
         s->ifr &= ~T1_INT;
         cuda_update_irq(s);
         break;
     case CUDA_REG_T1CH:
-        val = get_counter(&s->timers[0]) >> 8;
+        val = get_counter(s, &s->timers[0]) >> 8;
         cuda_update_irq(s);
         break;
     case CUDA_REG_T1LL:
@@ -311,12 +311,12 @@ static uint64_t cuda_read(void *opaque, hwaddr addr, unsigned size)
         val = (s->timers[0].latch >> 8) & 0xff;
         break;
     case CUDA_REG_T2CL:
-        val = get_counter(&s->timers[1]) & 0xff;
+        val = get_counter(s, &s->timers[1]) & 0xff;
         s->ifr &= ~T2_INT;
         cuda_update_irq(s);
         break;
     case CUDA_REG_T2CH:
-        val = get_counter(&s->timers[1]) >> 8;
+        val = get_counter(s, &s->timers[1]) >> 8;
         break;
     case CUDA_REG_SR:
         val = s->sr;
-- 
2.11.0

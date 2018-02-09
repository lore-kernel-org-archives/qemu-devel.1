Received: from eggs.gnu.org ([2001:4830:134:3::10]:43375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekDmF-0001Kk-S5
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:52:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekDmC-0004cn-Q4
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:52:03 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  9 Feb 2018 18:51:32 +0000
Message-Id: <20180209185142.17151-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv2 02/12] cuda: don't allow writes to port
 output pins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, lvivier@redhat.com

Use the direction registers as a mask to ensure that only input pins are
updated upon write.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/macio/cuda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 6631017ca2..eaa8924f49 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -359,11 +359,11 @@ static void cuda_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
 
     switch(addr) {
     case CUDA_REG_B:
-        s->b = val;
+        s->b = (s->b & ~s->dirb) | (val & s->dirb);
         cuda_update(s);
         break;
     case CUDA_REG_A:
-        s->a = val;
+        s->a = (s->a & ~s->dira) | (val & s->dira);
         break;
     case CUDA_REG_DIRB:
         s->dirb = val;
-- 
2.11.0

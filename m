Received: from eggs.gnu.org ([2001:4830:134:3::10]:50438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvCi-0001zr-2M
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvCg-0008TB-Fp
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:37:52 -0500
Received: from chuckie.co.uk ([82.165.15.123]:36240
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ehvCg-0008Qk-5A
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:37:50 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat,  3 Feb 2018 10:37:19 +0000
Message-Id: <20180203103727.26457-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 02/10] cuda: don't allow writes to port output
 pins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lvivier@redhat.com

Use the direction registers as a mask to ensure that only input pins are
updated upon write.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/cuda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 23b7e0f5b0..7214e7adcb 100644
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

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9iu-0001fI-0Q
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9ip-0003g8-9k
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:23:00 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dc9ip-0003ax-2i
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:22:55 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9ig-0000s6-FD
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:22:46 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2017 13:22:39 +0100
Message-Id: <1501503765-15639-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1501503765-15639-1-git-send-email-peter.maydell@linaro.org>
References: <1501503765-15639-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 1/7] target/arm: Correct MPU trace handling of
 write vs execute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Correct off-by-one bug in the PSMAv7 MPU tracing where it would print
a write access as "reading", an insn fetch as "writing", and a read
access as "execute".

Since we have an MMUAccessType enum now, we can make the code clearer
in the process by using that rather than the raw 0/1/2 values.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-id: 1500906792-18010-1-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4ed32c5..9ed5096 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8558,8 +8558,8 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
                                    phys_ptr, prot, fsr);
         qemu_log_mask(CPU_LOG_MMU, "PMSAv7 MPU lookup for %s at 0x%08" PRIx32
                       " mmu_idx %u -> %s (prot %c%c%c)\n",
-                      access_type == 1 ? "reading" :
-                      (access_type == 2 ? "writing" : "execute"),
+                      access_type == MMU_DATA_LOAD ? "reading" :
+                      (access_type == MMU_DATA_STORE ? "writing" : "execute"),
                       (uint32_t)address, mmu_idx,
                       ret ? "Miss" : "Hit",
                       *prot & PAGE_READ ? 'r' : '-',
-- 
2.7.4

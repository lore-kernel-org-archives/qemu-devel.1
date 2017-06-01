Received: from eggs.gnu.org ([2001:4830:134:3::10]:35142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcW-00015j-Px
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcV-0006AI-Uq
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:48 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dGTcV-00068M-Lh
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:47 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcO-0007P9-UQ
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:10:40 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Jun 2017 18:10:15 +0100
Message-Id: <1496337035-30213-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
References: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/27] arm: Use the mmu_idx we're passed in
 arm_cpu_do_unaligned_access()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When identifying the DFSR format for an alignment fault, use
the mmu index that we are passed, rather than calling cpu_mmu_index()
to get the mmu index for the current CPU state. This doesn't actually
make any difference since the only cases where the current MMU index
differs from the index used for the load are the "unprivileged
load/store" instructions, and in that case the mmu index may
differ but the translation regime is the same (apart from the
"use from Hyp mode" case which is UNPREDICTABLE).
However it's the more logical thing to do.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1493122030-32191-2-git-send-email-peter.maydell@linaro.org
---
 target/arm/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 156b825..de24815 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -208,7 +208,7 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     /* the DFSR for an alignment fault depends on whether we're using
      * the LPAE long descriptor format, or the short descriptor format
      */
-    if (arm_s1_regime_using_lpae_format(env, cpu_mmu_index(env, false))) {
+    if (arm_s1_regime_using_lpae_format(env, mmu_idx)) {
         env->exception.fsr = (1 << 9) | 0x21;
     } else {
         env->exception.fsr = 0x1;
-- 
2.7.4

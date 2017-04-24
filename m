Received: from eggs.gnu.org ([2001:4830:134:3::10]:57807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d2gvx-0005Tu-32
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d2gvw-00036a-8t
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:33:53 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 17:33:33 +0100
Message-Id: <1493051615-30715-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1493051615-30715-1-git-send-email-peter.maydell@linaro.org>
References: <1493051615-30715-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [RFC 1/3] arm: Use the mmu_idx we're passed in
 arm_cpu_do_unaligned_access()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>

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

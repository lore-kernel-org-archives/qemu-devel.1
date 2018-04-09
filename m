Received: from eggs.gnu.org ([2001:4830:134:3::10]:54011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5UCL-00081q-5Y
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 06:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5UCK-0003mO-98
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 06:38:53 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Apr 2018 11:38:34 +0100
Message-Id: <20180409103834.11285-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.12] target/arm: Don't corrupt insn_start
 arguments on 32-bit hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, alarson@ddci.com, qemu-stable@nongnu.org

For the Arm target, we have a 3-operand tcg_insn_start,
where the 3 arguments are the PC, condexec bits, and
a syndrome value. We set it up like this:

    tcg_gen_insn_start(dc->pc,
                       (dc->condexec_cond << 4) | (dc->condexec_mask >> 1),
                       0);
    dc->insn_start = tcg_last_op();

and then we patch in the 3rd operand later in disas_set_insn_syndrome():
    tcg_set_insn_param(s->insn_start, 2, syn);

Unfortunately, if we're running on a setup where
TARGET_LONG_BITS > TCG_TARGET_REG_BITS (ie 64 bit guest
on 32 bit host), tcg_gen_insn_start() has under the hood
split the 3 operands we gave it into 6, and so we end
up patching a syndrome value into the condexec bits.
This means we'll end up with corrupted guest condexec
state if we have to do a cpu_restore_state(), which happens
often when using icount and occasionally for load/store
instructions that fault.

Fix the bug by using the correct operand offset for the
64-on-32 case.

Cc: qemu-stable@nongnu.org
Reported-by: alarson@ddci.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This doesn't apply as-is to the stable branch, but the
difference is minor (insn_start was insn_start_idx, but
the 2 vs 4 for argument 2 is still the same.)
---
 target/arm/translate.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index c47febf99d..f04ece9cfd 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -120,7 +120,15 @@ static inline void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
 
     /* We check and clear insn_start_idx to catch multiple updates.  */
     assert(s->insn_start != NULL);
+#if TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
     tcg_set_insn_param(s->insn_start, 2, syn);
+#else
+    /* tcg_gen_insn_start has split every target_ulong argument to
+     * op_insn_start into two 32-bit arguments, so we want the low
+     * half of the 3rd argument, which is at index 4.
+     */
+    tcg_set_insn_param(s->insn_start, 4, syn);
+#endif
     s->insn_start = NULL;
 }
 
-- 
2.16.2

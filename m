Received: from eggs.gnu.org ([2001:4830:134:3::10]:34938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7Neg-0006jd-7C
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7Nef-00059B-AE
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:36:14 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  2 Oct 2018 17:35:51 +0100
Message-Id: <20181002163556.10279-9-peter.maydell@linaro.org>
In-Reply-To: <20181002163556.10279-1-peter.maydell@linaro.org>
References: <20181002163556.10279-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 08/13] target/arm: Add v8M stack checks for
 LDRD/STRD (imm)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Add the v8M stack checks for:
 * LDRD (immediate)
 * STRD (immediate)

Loads and stores are more complicated than ADD/SUB/MOV, because we
must ensure that memory accesses below the stack limit are not
performed, so we can't simply do the check when we actually update
SP.

For these instructions, if the stack limit check triggers
we must not:
 * perform any memory access below the SP limit
 * update PC, SP or the load/store base register
but it is IMPDEF whether we:
 * perform any accesses above or equal to the SP limit
 * update destination registers for loads

For QEMU we choose to always check the limit before doing any other
part of the load or store, so we won't update any registers or
perform any memory accesses.

It is UNKNOWN whether the limit check triggers for a load or store
where the initial SP value is below the limit and one of the stores
would be below the limit, but the writeback moves SP to above the
limit.  For QEMU we choose to trigger the check in this situation.

Note that limit checks happen only for loads and stores which update
SP via writeback; they do not happen for loads and stores which
simply use SP as a base register.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index fcb33b8a503..c16d6075d94 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10278,6 +10278,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                  * 0b1111_1001_x11x_xxxx_xxxx_xxxx_xxxx_xxxx
                  *  - load/store dual (pre-indexed)
                  */
+                bool wback = extract32(insn, 21, 1);
+
                 if (rn == 15) {
                     if (insn & (1 << 21)) {
                         /* UNPREDICTABLE */
@@ -10289,8 +10291,29 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     addr = load_reg(s, rn);
                 }
                 offset = (insn & 0xff) * 4;
-                if ((insn & (1 << 23)) == 0)
+                if ((insn & (1 << 23)) == 0) {
                     offset = -offset;
+                }
+
+                if (s->v8m_stackcheck && rn == 13 && wback) {
+                    /*
+                     * Here 'addr' is the current SP; if offset is +ve we're
+                     * moving SP up, else down. It is UNKNOWN whether the limit
+                     * check triggers when SP starts below the limit and ends
+                     * up above it; check whichever of the current and final
+                     * SP is lower, so QEMU will trigger in that situation.
+                     */
+                    if ((int32_t)offset < 0) {
+                        TCGv_i32 newsp = tcg_temp_new_i32();
+
+                        tcg_gen_addi_i32(newsp, addr, offset);
+                        gen_helper_v8m_stackcheck(cpu_env, newsp);
+                        tcg_temp_free_i32(newsp);
+                    } else {
+                        gen_helper_v8m_stackcheck(cpu_env, addr);
+                    }
+                }
+
                 if (insn & (1 << 24)) {
                     tcg_gen_addi_i32(addr, addr, offset);
                     offset = 0;
@@ -10314,7 +10337,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     gen_aa32_st32(s, tmp, addr, get_mem_index(s));
                     tcg_temp_free_i32(tmp);
                 }
-                if (insn & (1 << 21)) {
+                if (wback) {
                     /* Base writeback.  */
                     tcg_gen_addi_i32(addr, addr, offset - 4);
                     store_reg(s, rn, addr);
-- 
2.19.0

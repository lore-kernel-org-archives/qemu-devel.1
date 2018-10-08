Received: from eggs.gnu.org ([2001:4830:134:3::10]:46665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W6O-0001oR-T5
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W6I-0007hQ-Ux
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:40 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1g9W6A-0006uy-2D
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:29 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5O-0003kq-MF
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:00:38 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  8 Oct 2018 14:59:59 +0100
Message-Id: <20181008140004.12612-29-peter.maydell@linaro.org>
In-Reply-To: <20181008140004.12612-1-peter.maydell@linaro.org>
References: <20181008140004.12612-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 28/33] target/arm: Add v8M stack checks for
 Thumb2 LDM/STM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add the v8M stack checks for:
 * LDM (T2 encoding)
 * STM (T2 encoding)

This includes the 32-bit encodings of the instructions listed
in v8M ARM ARM rule R_YVWT as
 * LDM, LDMIA, LDMFD
 * LDMDB, LDMEA
 * POP (multiple registers)
 * PUSH (muliple registers)
 * STM, STMIA, STMEA
 * STMDB, STMFD

We perform the stack limit before doing any other part
of the load or store.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181002163556.10279-10-peter.maydell@linaro.org
---
 target/arm/translate.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index c16d6075d94..3fb378a492d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10524,6 +10524,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             } else {
                 int i, loaded_base = 0;
                 TCGv_i32 loaded_var;
+                bool wback = extract32(insn, 21, 1);
                 /* Load/store multiple.  */
                 addr = load_reg(s, rn);
                 offset = 0;
@@ -10531,10 +10532,26 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     if (insn & (1 << i))
                         offset += 4;
                 }
+
                 if (insn & (1 << 24)) {
                     tcg_gen_addi_i32(addr, addr, -offset);
                 }
 
+                if (s->v8m_stackcheck && rn == 13 && wback) {
+                    /*
+                     * If the writeback is incrementing SP rather than
+                     * decrementing it, and the initial SP is below the
+                     * stack limit but the final written-back SP would
+                     * be above, then then we must not perform any memory
+                     * accesses, but it is IMPDEF whether we generate
+                     * an exception. We choose to do so in this case.
+                     * At this point 'addr' is the lowest address, so
+                     * either the original SP (if incrementing) or our
+                     * final SP (if decrementing), so that's what we check.
+                     */
+                    gen_helper_v8m_stackcheck(cpu_env, addr);
+                }
+
                 loaded_var = NULL;
                 for (i = 0; i < 16; i++) {
                     if ((insn & (1 << i)) == 0)
@@ -10562,7 +10579,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 if (loaded_base) {
                     store_reg(s, rn, loaded_var);
                 }
-                if (insn & (1 << 21)) {
+                if (wback) {
                     /* Base register writeback.  */
                     if (insn & (1 << 24)) {
                         tcg_gen_addi_i32(addr, addr, -offset);
-- 
2.19.0

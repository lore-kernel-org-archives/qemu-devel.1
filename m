Received: from eggs.gnu.org ([2001:4830:134:3::10]:50207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fTYnu-0002VW-5i
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fTYnt-0006BH-7w
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:25:10 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:40432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fTYns-0006AU-Vh
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:25:09 -0400
Received: by mail-lf0-x244.google.com with SMTP id q11-v6so11377417lfc.7
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 13:25:08 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 14 Jun 2018 22:25:02 +0200
Message-Id: <20180614202502.668-3-edgar.iglesias@gmail.com>
In-Reply-To: <20180614202502.668-1-edgar.iglesias@gmail.com>
References: <20180614202502.668-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 2/2] target-microblaze: Rework NOP/zero
 instruction handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Remove the abort on a sequence of NOP/zero instructions.
Always return early and avoid decoding NOP/zero instructions.

This fixes Coverity CID 1391443.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 6c64946398..78ca265b04 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -90,7 +90,6 @@ typedef struct DisasContext {
     uint32_t jmp_pc;
 
     int abort_at_next_insn;
-    int nr_nops;
     struct TranslationBlock *tb;
     int singlestep_enabled;
 } DisasContext;
@@ -1576,17 +1575,12 @@ static inline void decode(DisasContext *dc, uint32_t ir)
     dc->ir = ir;
     LOG_DIS("%8.8x\t", dc->ir);
 
-    if (dc->ir)
-        dc->nr_nops = 0;
-    else {
+    if (ir == 0) {
         trap_illegal(dc, dc->cpu->env.pvr.regs[2] & PVR2_OPCODE_0x0_ILL_MASK);
-
-        LOG_DIS("nr_nops=%d\t", dc->nr_nops);
-        dc->nr_nops++;
-        if (dc->nr_nops > 4) {
-            cpu_abort(CPU(dc->cpu), "fetching nop sequence\n");
-        }
+        /* Don't decode nop/zero instructions any further.  */
+        return;
     }
+
     /* bit 2 seems to indicate insn type.  */
     dc->type_b = ir & (1 << 29);
 
@@ -1633,7 +1627,6 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     dc->singlestep_enabled = cs->singlestep_enabled;
     dc->cpustate_changed = 0;
     dc->abort_at_next_insn = 0;
-    dc->nr_nops = 0;
 
     if (pc_start & 3) {
         cpu_abort(cs, "Microblaze: unaligned PC=%x\n", pc_start);
-- 
2.14.1

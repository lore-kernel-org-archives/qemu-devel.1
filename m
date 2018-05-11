Received: from eggs.gnu.org ([2001:4830:134:3::10]:55715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGzav-0000kx-Sq
	for qemu-devel@nongnu.org; Fri, 11 May 2018 00:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGzas-0008Ah-Qa
	for qemu-devel@nongnu.org; Fri, 11 May 2018 00:23:49 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:43685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGzas-0008AP-LS
	for qemu-devel@nongnu.org; Fri, 11 May 2018 00:23:46 -0400
Received: by mail-pl0-x243.google.com with SMTP id a39-v6so2536424pla.10
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 21:23:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 21:23:24 -0700
Message-Id: <20180511042324.5070-14-richard.henderson@linaro.org>
In-Reply-To: <20180511042324.5070-1-richard.henderson@linaro.org>
References: <20180511042324.5070-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 13/13] target/openrisc: Merge disas_openrisc_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, peter.maydell@linaro.org

Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 66e493220e..3866106bf6 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1373,14 +1373,6 @@ static bool trans_lf_sfle_s(DisasContext *dc, arg_ab *a, uint32_t insn)
     return true;
 }
 
-static void disas_openrisc_insn(DisasContext *dc, OpenRISCCPU *cpu)
-{
-    uint32_t insn = cpu_ldl_code(&cpu->env, dc->pc);
-    if (!decode(dc, insn)) {
-        gen_illegal_exception(dc);
-    }
-}
-
 void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
     CPUOpenRISCState *env = cs->env_ptr;
@@ -1388,6 +1380,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     struct DisasContext ctx, *dc = &ctx;
     uint32_t pc_start;
     uint32_t next_page_start;
+    uint32_t insn;
     int num_insns;
     int max_insns;
 
@@ -1449,7 +1442,11 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
-        disas_openrisc_insn(dc, cpu);
+
+        insn = cpu_ldl_code(&cpu->env, dc->pc);
+        if (!decode(dc, insn)) {
+            gen_illegal_exception(dc);
+        }
         dc->pc = dc->pc + 4;
 
         /* delay slot */
-- 
2.17.0

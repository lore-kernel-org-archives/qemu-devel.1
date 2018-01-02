Received: from eggs.gnu.org ([2001:4830:134:3::10]:52344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWWBO-00074V-RA
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWWBN-00038B-TS
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:22 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:53129)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWWBN-00037Z-It
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:21 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  3 Jan 2018 00:40:59 +0100
Message-Id: <20180102234108.32713-9-laurent@vivier.eu>
In-Reply-To: <20180102234108.32713-1-laurent@vivier.eu>
References: <20180102234108.32713-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v6 08/17] target/m68k: add move16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>

move16 moves the source line to the destination line. Lines are aligned
to 16-byte boundaries and are 16 bytes long.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v6: split move16 in two functions

 target/m68k/cpu.c       | 10 ++++++-
 target/m68k/cpu.h       |  1 +
 target/m68k/translate.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 57ffcb2114..1936efd170 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -137,7 +137,15 @@ static void m68020_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_CHK2);
 }
 #define m68030_cpu_initfn m68020_cpu_initfn
-#define m68040_cpu_initfn m68020_cpu_initfn
+
+static void m68040_cpu_initfn(Object *obj)
+{
+    M68kCPU *cpu = M68K_CPU(obj);
+    CPUM68KState *env = &cpu->env;
+
+    m68020_cpu_initfn(obj);
+    m68k_set_feature(env, M68K_FEATURE_M68040);
+}
 
 static void m68060_cpu_initfn(Object *obj)
 {
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 68396bdd70..2ac4ab191e 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -306,6 +306,7 @@ enum m68k_features {
     M68K_FEATURE_BKPT,
     M68K_FEATURE_RTD,
     M68K_FEATURE_CHK2,
+    M68K_FEATURE_M68040, /* instructions specific to MC68040 */
 };
 
 static inline int m68k_feature(CPUM68KState *env, int feature)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 62e955abc7..662a518f16 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4278,6 +4278,76 @@ DISAS_INSN(chk2)
     s->cc_op_synced = 1;
 }
 
+static void m68k_copy_line(TCGv dst, TCGv src, int index)
+{
+    TCGv addr;
+    TCGv_i64 t0, t1;
+
+    addr = tcg_temp_new();
+
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
+
+    tcg_gen_andi_i32(addr, src, ~15);
+    tcg_gen_qemu_ld64(t0, addr, index);
+    tcg_gen_addi_i32(addr, addr, 8);
+    tcg_gen_qemu_ld64(t1, addr, index);
+
+    tcg_gen_andi_i32(addr, dst, ~15);
+    tcg_gen_qemu_st64(t0, addr, index);
+    tcg_gen_addi_i32(addr, addr, 8);
+    tcg_gen_qemu_st64(t1, addr, index);
+
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free(addr);
+}
+
+DISAS_INSN(move16_reg)
+{
+    int index = IS_USER(s);
+    TCGv tmp;
+    uint16_t ext;
+
+    ext = read_im16(env, s);
+    if ((ext & (1 << 15)) == 0) {
+        gen_exception(s, s->insn_pc, EXCP_ILLEGAL);
+    }
+
+    m68k_copy_line(AREG(ext, 12), AREG(insn, 0), index);
+
+    /* Ax can be Ay, so save Ay before incrementing Ax */
+    tmp = tcg_temp_new();
+    tcg_gen_mov_i32(tmp, AREG(ext, 12));
+    tcg_gen_addi_i32(AREG(insn, 0), AREG(insn, 0), 16);
+    tcg_gen_addi_i32(AREG(ext, 12), tmp, 16);
+    tcg_temp_free(tmp);
+}
+
+DISAS_INSN(move16_mem)
+{
+    int index = IS_USER(s);
+    TCGv reg, addr;
+
+    reg = AREG(insn, 0);
+    addr = tcg_const_i32(read_im32(env, s));
+
+    if ((insn >> 3) & 1) {
+        /* MOVE16 (xxx).L, (Ay) */
+        m68k_copy_line(reg, addr, index);
+    } else {
+        /* MOVE16 (Ay), (xxx).L */
+        m68k_copy_line(addr, reg, index);
+    }
+
+    tcg_temp_free(addr);
+
+    if (((insn >> 3) & 2) == 0) {
+        /* (Ay)+ */
+        tcg_gen_addi_i32(reg, reg, 16);
+    }
+}
+
 static TCGv gen_get_sr(DisasContext *s)
 {
     TCGv ccr;
@@ -5579,6 +5649,8 @@ void register_m68k_insns (CPUM68KState *env)
     INSN(fsave,     f300, ffc0, FPU);
     INSN(intouch,   f340, ffc0, CF_ISA_A);
     INSN(cpushl,    f428, ff38, CF_ISA_A);
+    INSN(move16_mem, f600, ffe0, M68040);
+    INSN(move16_reg, f620, fff8, M68040);
     INSN(wddata,    fb00, ff00, CF_ISA_A);
     INSN(wdebug,    fbc0, ffc0, CF_ISA_A);
 #undef INSN
-- 
2.14.3

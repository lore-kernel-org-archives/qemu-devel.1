Received: from eggs.gnu.org ([2001:4830:134:3::10]:41508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs5tL-00024P-SL
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs5tI-0007Mx-7M
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:36:11 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34896 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fs5tH-0007Jn-4I
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:36:07 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 21 Aug 2018 14:35:30 +0200
Message-Id: <1534854951-6321-26-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534854951-6321-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534854951-6321-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 25/46] target/mips: Implement emulation of
 nanoMIPS LLWP/SCWP pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Implement support for nanoMIPS LLWP/SCWP instructions. Beside
adding core functionality of these instructions, this patch adds
support for availability control via configuration bit XNP.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Dimitrije Nikolic <dnikolic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/mips/cpu_loop.c | 25 +++++++++++---
 target/mips/cpu.h          |  2 ++
 target/mips/translate.c    | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 5 deletions(-)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 084ad6a..1d3dc9e 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -397,10 +397,13 @@ static int do_store_exclusive(CPUMIPSState *env)
     target_ulong addr;
     target_ulong page_addr;
     target_ulong val;
+    uint32_t val_wp = 0;
+    uint32_t llnewval_wp = 0;
     int flags;
     int segv = 0;
     int reg;
     int d;
+    int wp;
 
     addr = env->lladdr;
     page_addr = addr & TARGET_PAGE_MASK;
@@ -412,19 +415,31 @@ static int do_store_exclusive(CPUMIPSState *env)
     } else {
         reg = env->llreg & 0x1f;
         d = (env->llreg & 0x20) != 0;
-        if (d) {
-            segv = get_user_s64(val, addr);
+        wp = (env->llreg & 0x40) != 0;
+        if (!wp) {
+            if (d) {
+                segv = get_user_s64(val, addr);
+            } else {
+                segv = get_user_s32(val, addr);
+            }
         } else {
             segv = get_user_s32(val, addr);
+            segv |= get_user_s32(val_wp, addr);
+            llnewval_wp = env->llnewval_wp;
         }
         if (!segv) {
-            if (val != env->llval) {
+            if (val != env->llval && val_wp == llnewval_wp) {
                 env->active_tc.gpr[reg] = 0;
             } else {
-                if (d) {
-                    segv = put_user_u64(env->llnewval, addr);
+                if (!wp) {
+                    if (d) {
+                        segv = put_user_u64(env->llnewval, addr);
+                    } else {
+                        segv = put_user_u32(env->llnewval, addr);
+                    }
                 } else {
                     segv = put_user_u32(env->llnewval, addr);
+                    segv |= put_user_u32(env->llnewval_wp, addr + 4);
                 }
                 if (!segv) {
                     env->active_tc.gpr[reg] = 1;
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 009202c..28af4d1 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -506,6 +506,8 @@ struct CPUMIPSState {
     uint64_t lladdr;
     target_ulong llval;
     target_ulong llnewval;
+    uint64_t llval_wp;
+    uint32_t llnewval_wp;
     target_ulong llreg;
     uint64_t CP0_LLAddr_rw_bitmask;
     int CP0_LLAddr_shift;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index dc1760b..ebe56d5 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1916,6 +1916,18 @@ static inline void check_mvh(DisasContext *ctx)
 }
 #endif
 
+/*
+ * This code generates a "reserved instruction" exception if the
+ * Config5 XNP bit is set.
+ */
+static inline void check_xnp(DisasContext *ctx)
+{
+    if (unlikely(ctx->CP0_Config5 & (1 << CP0C5_XNP))) {
+        generate_exception_end(ctx, EXCP_RI);
+    }
+}
+
+
 /* Define small wrappers for gen_load_fpr* so that we have a uniform
    calling interface for 32 and 64-bit FPRs.  No sense in changing
    all callers for gen_load_fpr32 when we need the CTX parameter for
@@ -2362,6 +2374,31 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     tcg_temp_free(t0);
 }
 
+static void gen_llwp(DisasContext *ctx, uint32_t base, int16_t offset,
+                    uint32_t reg1, uint32_t reg2)
+{
+    TCGv taddr = tcg_temp_new();
+    TCGv_i64 tval = tcg_temp_new_i64();
+    TCGv tmp1 = tcg_temp_new();
+    TCGv tmp2 = tcg_temp_new();
+
+    gen_base_offset_addr(ctx, taddr, base, offset);
+    tcg_gen_qemu_ld64(tval, taddr, ctx->mem_idx);
+#ifdef TARGET_WORDS_BIGENDIAN
+    tcg_gen_extr_i64_tl(tmp2, tmp1, tval);
+#else
+    tcg_gen_extr_i64_tl(tmp1, tmp2, tval);
+#endif
+    gen_store_gpr(tmp1, reg1);
+    tcg_temp_free(tmp1);
+    gen_store_gpr(tmp2, reg2);
+    tcg_temp_free(tmp2);
+    tcg_gen_st_i64(tval, cpu_env, offsetof(CPUMIPSState, llval_wp));
+    tcg_temp_free_i64(tval);
+    tcg_gen_st_tl(taddr, cpu_env, offsetof(CPUMIPSState, lladdr));
+    tcg_temp_free(taddr);
+}
+
 /* Store */
 static void gen_st (DisasContext *ctx, uint32_t opc, int rt,
                     int base, int offset)
@@ -2458,6 +2495,51 @@ static void gen_st_cond (DisasContext *ctx, uint32_t opc, int rt,
     tcg_temp_free(t0);
 }
 
+static void gen_scwp(DisasContext *ctx, uint32_t base, int16_t offset,
+                    uint32_t reg1, uint32_t reg2)
+{
+    TCGv taddr = tcg_temp_local_new();
+    TCGv lladdr = tcg_temp_local_new();
+    TCGv_i64 tval = tcg_temp_new_i64();
+    TCGv_i64 llval = tcg_temp_new_i64();
+    TCGv_i64 val = tcg_temp_new_i64();
+    TCGv tmp1 = tcg_temp_new();
+    TCGv tmp2 = tcg_temp_new();
+    TCGLabel *lab_fail = gen_new_label();
+    TCGLabel *lab_done = gen_new_label();
+
+    gen_base_offset_addr(ctx, taddr, base, offset);
+
+    tcg_gen_ld_tl(lladdr, cpu_env, offsetof(CPUMIPSState, lladdr));
+    tcg_gen_brcond_tl(TCG_COND_NE, taddr, lladdr, lab_fail);
+
+    gen_load_gpr(tmp1, reg1);
+    gen_load_gpr(tmp2, reg2);
+
+#ifdef TARGET_WORDS_BIGENDIAN
+    tcg_gen_concat_tl_i64(tval, tmp2, tmp1);
+#else
+    tcg_gen_concat_tl_i64(tval, tmp1, tmp2);
+#endif
+
+    tcg_gen_ld_i64(llval, cpu_env, offsetof(CPUMIPSState, llval_wp));
+    tcg_gen_atomic_cmpxchg_i64(val, taddr, llval, tval,
+                               ctx->mem_idx, MO_64);
+    if (reg1 != 0) {
+        tcg_gen_movi_tl(cpu_gpr[reg1], 1);
+    }
+    tcg_gen_brcond_i64(TCG_COND_EQ, val, llval, lab_done);
+
+    gen_set_label(lab_fail);
+
+    if (reg1 != 0) {
+        tcg_gen_movi_tl(cpu_gpr[reg1], 0);
+    }
+    gen_set_label(lab_done);
+    tcg_gen_movi_tl(lladdr, -1);
+    tcg_gen_st_tl(lladdr, cpu_env, offsetof(CPUMIPSState, lladdr));
+}
+
 /* Load and store */
 static void gen_flt_ldst (DisasContext *ctx, uint32_t opc, int ft,
                           TCGv t0)
@@ -18118,6 +18200,8 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                         gen_ld(ctx, OPC_LL, rt, rs, s);
                         break;
                     case NM_LLWP:
+                        check_xnp(ctx);
+                        gen_llwp(ctx, rs, 0, rt, extract32(ctx->opcode, 3, 5));
                         break;
                     }
                     break;
@@ -18127,6 +18211,8 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                         gen_st_cond(ctx, OPC_SC, rt, rs, s);
                         break;
                     case NM_SCWP:
+                        check_xnp(ctx);
+                        gen_scwp(ctx, rs, 0, rt, extract32(ctx->opcode, 3, 5));
                         break;
                     }
                     break;
-- 
2.7.4

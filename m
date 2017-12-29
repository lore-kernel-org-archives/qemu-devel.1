Received: from eggs.gnu.org ([2001:4830:134:3::10]:50674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoD8-0002xe-Sz
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoD0-0004Xz-52
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:06 -0500
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:33002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoCz-0004XY-LO
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:31:58 -0500
Received: by mail-pg0-x22b.google.com with SMTP id g7so20711179pgs.0
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:31:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:12 -0800
Message-Id: <20171229063145.29167-6-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 05/38] target/hppa: Split address size from
 register size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

For system mode, we will need 64-bit virtual addresses even when
we have 32-bit register sizes.  Since the rest of QEMU equates
TARGET_LONG_BITS with the address size, redefine everything
related to register size in terms of a new TARGET_REGISTER_BITS.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h       |  48 ++-
 target/hppa/helper.h    |  26 +-
 target/hppa/gdbstub.c   |  19 +-
 target/hppa/helper.c    |  18 +-
 target/hppa/op_helper.c |  22 +-
 target/hppa/translate.c | 947 ++++++++++++++++++++++++++++++------------------
 6 files changed, 669 insertions(+), 411 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index d84af91860..1524ef91b6 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -23,10 +23,10 @@
 #include "qemu-common.h"
 #include "cpu-qom.h"
 
-/* We only support hppa-linux-user at present, so 32-bit only.  */
-#define TARGET_LONG_BITS 32
-#define TARGET_PHYS_ADDR_SPACE_BITS  32
-#define TARGET_VIRT_ADDR_SPACE_BITS  32
+#define TARGET_LONG_BITS            32
+#define TARGET_VIRT_ADDR_SPACE_BITS 32
+#define TARGET_REGISTER_BITS        32
+#define TARGET_PHYS_ADDR_SPACE_BITS 32
 
 #define CPUArchState struct CPUHPPAState
 
@@ -123,17 +123,29 @@
 
 typedef struct CPUHPPAState CPUHPPAState;
 
+#if TARGET_REGISTER_BITS == 32
+typedef uint32_t target_ureg;
+typedef int32_t  target_sreg;
+#define TREG_FMT_lx   "%08"PRIx32
+#define TREG_FMT_ld   "%"PRId32
+#else
+typedef uint64_t target_ureg;
+typedef int64_t  target_sreg;
+#define TREG_FMT_lx   "%016"PRIx64
+#define TREG_FMT_ld   "%"PRId64
+#endif
+
 struct CPUHPPAState {
-    target_ulong gr[32];
+    target_ureg gr[32];
     uint64_t fr[32];
 
-    target_ulong sar;
-    target_ulong cr26;
-    target_ulong cr27;
+    target_ureg sar;
+    target_ureg cr26;
+    target_ureg cr27;
 
-    target_long  psw;        /* All psw bits except the following:  */
-    target_ulong psw_n;      /* boolean */
-    target_long  psw_v;      /* in most significant bit */
+    target_ureg psw;         /* All psw bits except the following:  */
+    target_ureg psw_n;       /* boolean */
+    target_sreg psw_v;       /* in most significant bit */
 
     /* Splitting the carry-borrow field into the MSB and "the rest", allows
      * for "the rest" to be deleted when it is unused, but the MSB is in use.
@@ -142,13 +154,13 @@ struct CPUHPPAState {
      * host has the appropriate add-with-carry insn to compute the msb).
      * Therefore the carry bits are stored as: cb_msb : cb & 0x11111110.
      */
-    target_ulong psw_cb;     /* in least significant bit of next nibble */
-    target_ulong psw_cb_msb; /* boolean */
+    target_ureg psw_cb;      /* in least significant bit of next nibble */
+    target_ureg psw_cb_msb;  /* boolean */
 
-    target_ulong iaoq_f;     /* front */
-    target_ulong iaoq_b;     /* back, aka next instruction */
+    target_ureg iaoq_f;      /* front */
+    target_ureg iaoq_b;      /* back, aka next instruction */
 
-    target_ulong ior;        /* interrupt offset register */
+    target_ureg ior;         /* interrupt offset register */
 
     uint32_t fr0_shadow;     /* flags, c, ca/cq, rm, d, enables */
     float_status fp_status;
@@ -201,8 +213,8 @@ static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, target_ulong *pc,
     *pflags = env->psw_n;
 }
 
-target_ulong cpu_hppa_get_psw(CPUHPPAState *env);
-void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong);
+target_ureg cpu_hppa_get_psw(CPUHPPAState *env);
+void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg);
 void cpu_hppa_loaded_fr0(CPUHPPAState *env);
 
 #define cpu_signal_handler cpu_hppa_signal_handler
diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 0a6b900555..c720de523b 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -1,14 +1,24 @@
+#if TARGET_REGISTER_BITS == 64
+# define dh_alias_tr     i64
+# define dh_is_64bit_tr  1
+#else
+# define dh_alias_tr     i32
+# define dh_is_64bit_tr  0
+#endif
+#define dh_ctype_tr      target_ureg
+#define dh_is_signed_tr  0
+
 DEF_HELPER_2(excp, noreturn, env, int)
-DEF_HELPER_FLAGS_2(tsv, TCG_CALL_NO_WG, void, env, tl)
-DEF_HELPER_FLAGS_2(tcond, TCG_CALL_NO_WG, void, env, tl)
+DEF_HELPER_FLAGS_2(tsv, TCG_CALL_NO_WG, void, env, tr)
+DEF_HELPER_FLAGS_2(tcond, TCG_CALL_NO_WG, void, env, tr)
 
-DEF_HELPER_FLAGS_3(stby_b, TCG_CALL_NO_WG, void, env, tl, tl)
-DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
-DEF_HELPER_FLAGS_3(stby_e, TCG_CALL_NO_WG, void, env, tl, tl)
-DEF_HELPER_FLAGS_3(stby_e_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
+DEF_HELPER_FLAGS_3(stby_b, TCG_CALL_NO_WG, void, env, tl, tr)
+DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
+DEF_HELPER_FLAGS_3(stby_e, TCG_CALL_NO_WG, void, env, tl, tr)
+DEF_HELPER_FLAGS_3(stby_e_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
 
-DEF_HELPER_FLAGS_1(probe_r, TCG_CALL_NO_RWG_SE, tl, tl)
-DEF_HELPER_FLAGS_1(probe_w, TCG_CALL_NO_RWG_SE, tl, tl)
+DEF_HELPER_FLAGS_1(probe_r, TCG_CALL_NO_RWG_SE, tr, tl)
+DEF_HELPER_FLAGS_1(probe_w, TCG_CALL_NO_RWG_SE, tr, tl)
 
 DEF_HELPER_FLAGS_1(loaded_fr0, TCG_CALL_NO_RWG, void, env)
 
diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index c37a56f238..228d282fe9 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -26,7 +26,7 @@ int hppa_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
-    target_ulong val;
+    target_ureg val;
 
     switch (n) {
     case 0:
@@ -61,14 +61,25 @@ int hppa_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
         }
         break;
     }
-    return gdb_get_regl(mem_buf, val);
+
+    if (TARGET_REGISTER_BITS == 64) {
+        return gdb_get_reg64(mem_buf, val);
+    } else {
+        return gdb_get_reg32(mem_buf, val);
+    }
 }
 
 int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
-    target_ulong val = ldtul_p(mem_buf);
+    target_ureg val;
+
+    if (TARGET_REGISTER_BITS == 64) {
+        val = ldq_p(mem_buf);
+    } else {
+        val = ldl_p(mem_buf);
+    }
 
     switch (n) {
     case 0:
@@ -108,5 +119,5 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         }
         break;
     }
-    return sizeof(target_ulong);
+    return sizeof(target_ureg);
 }
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 6439179a0e..b6521f61fc 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -24,9 +24,9 @@
 #include "fpu/softfloat.h"
 #include "exec/helper-proto.h"
 
-target_ulong cpu_hppa_get_psw(CPUHPPAState *env)
+target_ureg cpu_hppa_get_psw(CPUHPPAState *env)
 {
-    target_ulong psw;
+    target_ureg psw;
 
     /* Fold carry bits down to 8 consecutive bits.  */
     /* ??? Needs tweaking for hppa64.  */
@@ -48,9 +48,9 @@ target_ulong cpu_hppa_get_psw(CPUHPPAState *env)
     return psw;
 }
 
-void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
+void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
 {
-    target_ulong cb = 0;
+    target_ureg cb = 0;
 
     env->psw = psw & ~(PSW_N | PSW_V | PSW_CB);
     env->psw_n = (psw / PSW_N) & 1;
@@ -135,13 +135,13 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f,
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
-    target_ulong psw = cpu_hppa_get_psw(env);
-    target_ulong psw_cb;
+    target_ureg psw = cpu_hppa_get_psw(env);
+    target_ureg psw_cb;
     char psw_c[20];
     int i;
 
     cpu_fprintf(f, "IA_F " TARGET_FMT_lx " IA_B " TARGET_FMT_lx "\n",
-                env->iaoq_f, env->iaoq_b);
+                (target_ulong)env->iaoq_f, (target_ulong)env->iaoq_b);
 
     psw_c[0]  = (psw & PSW_W ? 'W' : '-');
     psw_c[1]  = (psw & PSW_E ? 'E' : '-');
@@ -164,11 +164,11 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f,
     psw_c[18] = '\0';
     psw_cb = ((env->psw_cb >> 4) & 0x01111111) | (env->psw_cb_msb << 28);
 
-    cpu_fprintf(f, "PSW  " TARGET_FMT_lx " CB   " TARGET_FMT_lx " %s\n",
+    cpu_fprintf(f, "PSW  " TREG_FMT_lx " CB   " TREG_FMT_lx " %s\n",
                 psw, psw_cb, psw_c);
 
     for (i = 0; i < 32; i++) {
-        cpu_fprintf(f, "GR%02d " TARGET_FMT_lx " ", i, env->gr[i]);
+        cpu_fprintf(f, "GR%02d " TREG_FMT_lx " ", i, env->gr[i]);
         if ((i % 4) == 3) {
             cpu_fprintf(f, "\n");
         }
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index d6b86834c1..479bfc0fdf 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -41,14 +41,14 @@ static void QEMU_NORETURN dynexcp(CPUHPPAState *env, int excp, uintptr_t ra)
     cpu_loop_exit_restore(cs, ra);
 }
 
-void HELPER(tsv)(CPUHPPAState *env, target_ulong cond)
+void HELPER(tsv)(CPUHPPAState *env, target_ureg cond)
 {
-    if (unlikely((target_long)cond < 0)) {
+    if (unlikely((target_sreg)cond < 0)) {
         dynexcp(env, EXCP_OVERFLOW, GETPC());
     }
 }
 
-void HELPER(tcond)(CPUHPPAState *env, target_ulong cond)
+void HELPER(tcond)(CPUHPPAState *env, target_ureg cond)
 {
     if (unlikely(cond)) {
         dynexcp(env, EXCP_COND, GETPC());
@@ -77,7 +77,7 @@ static void atomic_store_3(CPUHPPAState *env, target_ulong addr, uint32_t val,
 #endif
 }
 
-static void do_stby_b(CPUHPPAState *env, target_ulong addr, target_ulong val,
+static void do_stby_b(CPUHPPAState *env, target_ulong addr, target_ureg val,
                       bool parallel)
 {
     uintptr_t ra = GETPC();
@@ -104,18 +104,18 @@ static void do_stby_b(CPUHPPAState *env, target_ulong addr, target_ulong val,
     }
 }
 
-void HELPER(stby_b)(CPUHPPAState *env, target_ulong addr, target_ulong val)
+void HELPER(stby_b)(CPUHPPAState *env, target_ulong addr, target_ureg val)
 {
     do_stby_b(env, addr, val, false);
 }
 
 void HELPER(stby_b_parallel)(CPUHPPAState *env, target_ulong addr,
-                             target_ulong val)
+                             target_ureg val)
 {
     do_stby_b(env, addr, val, true);
 }
 
-static void do_stby_e(CPUHPPAState *env, target_ulong addr, target_ulong val,
+static void do_stby_e(CPUHPPAState *env, target_ulong addr, target_ureg val,
                       bool parallel)
 {
     uintptr_t ra = GETPC();
@@ -146,18 +146,18 @@ static void do_stby_e(CPUHPPAState *env, target_ulong addr, target_ulong val,
     }
 }
 
-void HELPER(stby_e)(CPUHPPAState *env, target_ulong addr, target_ulong val)
+void HELPER(stby_e)(CPUHPPAState *env, target_ulong addr, target_ureg val)
 {
     do_stby_e(env, addr, val, false);
 }
 
 void HELPER(stby_e_parallel)(CPUHPPAState *env, target_ulong addr,
-                             target_ulong val)
+                             target_ureg val)
 {
     do_stby_e(env, addr, val, true);
 }
 
-target_ulong HELPER(probe_r)(target_ulong addr)
+target_ureg HELPER(probe_r)(target_ulong addr)
 {
 #ifdef CONFIG_USER_ONLY
     return page_check_range(addr, 1, PAGE_READ);
@@ -166,7 +166,7 @@ target_ulong HELPER(probe_r)(target_ulong addr)
 #endif
 }
 
-target_ulong HELPER(probe_w)(target_ulong addr)
+target_ureg HELPER(probe_w)(target_ulong addr)
 {
 #ifdef CONFIG_USER_ONLY
     return page_check_range(addr, 1, PAGE_WRITE);
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8d85ed9df3..b3996cfcdc 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -30,9 +30,235 @@
 #include "trace-tcg.h"
 #include "exec/log.h"
 
+/* Since we have a distinction between register size and address size,
+   we need to redefine all of these.  */
+
+#undef TCGv
+#undef tcg_temp_new
+#undef tcg_global_reg_new
+#undef tcg_global_mem_new
+#undef tcg_temp_local_new
+#undef tcg_temp_free
+
+#if TARGET_LONG_BITS == 64
+#define TCGv_tl              TCGv_i64
+#define tcg_temp_new_tl      tcg_temp_new_i64
+#define tcg_temp_free_tl     tcg_temp_free_i64
+#if TARGET_REGISTER_BITS == 64
+#define tcg_gen_extu_reg_tl  tcg_gen_mov_i64
+#else
+#define tcg_gen_extu_reg_tl  tcg_gen_extu_i32_i64
+#endif
+#else
+#define TCGv_tl              TCGv_i32
+#define tcg_temp_new_tl      tcg_temp_new_i32
+#define tcg_temp_free_tl     tcg_temp_free_i32
+#define tcg_gen_extu_reg_tl  tcg_gen_mov_i32
+#endif
+
+#if TARGET_REGISTER_BITS == 64
+#define TCGv_reg             TCGv_i64
+
+#define tcg_temp_new         tcg_temp_new_i64
+#define tcg_global_reg_new   tcg_global_reg_new_i64
+#define tcg_global_mem_new   tcg_global_mem_new_i64
+#define tcg_temp_local_new   tcg_temp_local_new_i64
+#define tcg_temp_free        tcg_temp_free_i64
+
+#define tcg_gen_movi_reg     tcg_gen_movi_i64
+#define tcg_gen_mov_reg      tcg_gen_mov_i64
+#define tcg_gen_ld8u_reg     tcg_gen_ld8u_i64
+#define tcg_gen_ld8s_reg     tcg_gen_ld8s_i64
+#define tcg_gen_ld16u_reg    tcg_gen_ld16u_i64
+#define tcg_gen_ld16s_reg    tcg_gen_ld16s_i64
+#define tcg_gen_ld32u_reg    tcg_gen_ld32u_i64
+#define tcg_gen_ld32s_reg    tcg_gen_ld32s_i64
+#define tcg_gen_ld_reg       tcg_gen_ld_i64
+#define tcg_gen_st8_reg      tcg_gen_st8_i64
+#define tcg_gen_st16_reg     tcg_gen_st16_i64
+#define tcg_gen_st32_reg     tcg_gen_st32_i64
+#define tcg_gen_st_reg       tcg_gen_st_i64
+#define tcg_gen_add_reg      tcg_gen_add_i64
+#define tcg_gen_addi_reg     tcg_gen_addi_i64
+#define tcg_gen_sub_reg      tcg_gen_sub_i64
+#define tcg_gen_neg_reg      tcg_gen_neg_i64
+#define tcg_gen_subfi_reg    tcg_gen_subfi_i64
+#define tcg_gen_subi_reg     tcg_gen_subi_i64
+#define tcg_gen_and_reg      tcg_gen_and_i64
+#define tcg_gen_andi_reg     tcg_gen_andi_i64
+#define tcg_gen_or_reg       tcg_gen_or_i64
+#define tcg_gen_ori_reg      tcg_gen_ori_i64
+#define tcg_gen_xor_reg      tcg_gen_xor_i64
+#define tcg_gen_xori_reg     tcg_gen_xori_i64
+#define tcg_gen_not_reg      tcg_gen_not_i64
+#define tcg_gen_shl_reg      tcg_gen_shl_i64
+#define tcg_gen_shli_reg     tcg_gen_shli_i64
+#define tcg_gen_shr_reg      tcg_gen_shr_i64
+#define tcg_gen_shri_reg     tcg_gen_shri_i64
+#define tcg_gen_sar_reg      tcg_gen_sar_i64
+#define tcg_gen_sari_reg     tcg_gen_sari_i64
+#define tcg_gen_brcond_reg   tcg_gen_brcond_i64
+#define tcg_gen_brcondi_reg  tcg_gen_brcondi_i64
+#define tcg_gen_setcond_reg  tcg_gen_setcond_i64
+#define tcg_gen_setcondi_reg tcg_gen_setcondi_i64
+#define tcg_gen_mul_reg      tcg_gen_mul_i64
+#define tcg_gen_muli_reg     tcg_gen_muli_i64
+#define tcg_gen_div_reg      tcg_gen_div_i64
+#define tcg_gen_rem_reg      tcg_gen_rem_i64
+#define tcg_gen_divu_reg     tcg_gen_divu_i64
+#define tcg_gen_remu_reg     tcg_gen_remu_i64
+#define tcg_gen_discard_reg  tcg_gen_discard_i64
+#define tcg_gen_trunc_reg_i32 tcg_gen_extrl_i64_i32
+#define tcg_gen_trunc_i64_reg tcg_gen_mov_i64
+#define tcg_gen_extu_i32_reg tcg_gen_extu_i32_i64
+#define tcg_gen_ext_i32_reg  tcg_gen_ext_i32_i64
+#define tcg_gen_extu_reg_i64 tcg_gen_mov_i64
+#define tcg_gen_ext_reg_i64  tcg_gen_mov_i64
+#define tcg_gen_ext8u_reg    tcg_gen_ext8u_i64
+#define tcg_gen_ext8s_reg    tcg_gen_ext8s_i64
+#define tcg_gen_ext16u_reg   tcg_gen_ext16u_i64
+#define tcg_gen_ext16s_reg   tcg_gen_ext16s_i64
+#define tcg_gen_ext32u_reg   tcg_gen_ext32u_i64
+#define tcg_gen_ext32s_reg   tcg_gen_ext32s_i64
+#define tcg_gen_bswap16_reg  tcg_gen_bswap16_i64
+#define tcg_gen_bswap32_reg  tcg_gen_bswap32_i64
+#define tcg_gen_bswap64_reg  tcg_gen_bswap64_i64
+#define tcg_gen_concat_reg_i64 tcg_gen_concat32_i64
+#define tcg_gen_andc_reg     tcg_gen_andc_i64
+#define tcg_gen_eqv_reg      tcg_gen_eqv_i64
+#define tcg_gen_nand_reg     tcg_gen_nand_i64
+#define tcg_gen_nor_reg      tcg_gen_nor_i64
+#define tcg_gen_orc_reg      tcg_gen_orc_i64
+#define tcg_gen_clz_reg      tcg_gen_clz_i64
+#define tcg_gen_ctz_reg      tcg_gen_ctz_i64
+#define tcg_gen_clzi_reg     tcg_gen_clzi_i64
+#define tcg_gen_ctzi_reg     tcg_gen_ctzi_i64
+#define tcg_gen_clrsb_reg    tcg_gen_clrsb_i64
+#define tcg_gen_ctpop_reg    tcg_gen_ctpop_i64
+#define tcg_gen_rotl_reg     tcg_gen_rotl_i64
+#define tcg_gen_rotli_reg    tcg_gen_rotli_i64
+#define tcg_gen_rotr_reg     tcg_gen_rotr_i64
+#define tcg_gen_rotri_reg    tcg_gen_rotri_i64
+#define tcg_gen_deposit_reg  tcg_gen_deposit_i64
+#define tcg_gen_deposit_z_reg tcg_gen_deposit_z_i64
+#define tcg_gen_extract_reg  tcg_gen_extract_i64
+#define tcg_gen_sextract_reg tcg_gen_sextract_i64
+#define tcg_const_reg        tcg_const_i64
+#define tcg_const_local_reg  tcg_const_local_i64
+#define tcg_gen_movcond_reg  tcg_gen_movcond_i64
+#define tcg_gen_add2_reg     tcg_gen_add2_i64
+#define tcg_gen_sub2_reg     tcg_gen_sub2_i64
+#define tcg_gen_qemu_ld_reg  tcg_gen_qemu_ld_i64
+#define tcg_gen_qemu_st_reg  tcg_gen_qemu_st_i64
+#define tcg_gen_atomic_xchg_reg tcg_gen_atomic_xchg_i64
+#if UINTPTR_MAX == UINT32_MAX
+# define tcg_gen_trunc_reg_ptr(p,r) tcg_gen_trunc_i64_i32(TCGV_PTR_TO_NAT(p),r)
+#else
+# define tcg_gen_trunc_reg_ptr(p,r) tcg_gen_mov_i64(TCGV_PTR_TO_NAT(p),r)
+#endif
+#else
+#define TCGv_reg             TCGv_i32
+#define tcg_temp_new         tcg_temp_new_i32
+#define tcg_global_reg_new   tcg_global_reg_new_i32
+#define tcg_global_mem_new   tcg_global_mem_new_i32
+#define tcg_temp_local_new   tcg_temp_local_new_i32
+#define tcg_temp_free        tcg_temp_free_i32
+
+#define tcg_gen_movi_reg     tcg_gen_movi_i32
+#define tcg_gen_mov_reg      tcg_gen_mov_i32
+#define tcg_gen_ld8u_reg     tcg_gen_ld8u_i32
+#define tcg_gen_ld8s_reg     tcg_gen_ld8s_i32
+#define tcg_gen_ld16u_reg    tcg_gen_ld16u_i32
+#define tcg_gen_ld16s_reg    tcg_gen_ld16s_i32
+#define tcg_gen_ld32u_reg    tcg_gen_ld_i32
+#define tcg_gen_ld32s_reg    tcg_gen_ld_i32
+#define tcg_gen_ld_reg       tcg_gen_ld_i32
+#define tcg_gen_st8_reg      tcg_gen_st8_i32
+#define tcg_gen_st16_reg     tcg_gen_st16_i32
+#define tcg_gen_st32_reg     tcg_gen_st32_i32
+#define tcg_gen_st_reg       tcg_gen_st_i32
+#define tcg_gen_add_reg      tcg_gen_add_i32
+#define tcg_gen_addi_reg     tcg_gen_addi_i32
+#define tcg_gen_sub_reg      tcg_gen_sub_i32
+#define tcg_gen_neg_reg      tcg_gen_neg_i32
+#define tcg_gen_subfi_reg    tcg_gen_subfi_i32
+#define tcg_gen_subi_reg     tcg_gen_subi_i32
+#define tcg_gen_and_reg      tcg_gen_and_i32
+#define tcg_gen_andi_reg     tcg_gen_andi_i32
+#define tcg_gen_or_reg       tcg_gen_or_i32
+#define tcg_gen_ori_reg      tcg_gen_ori_i32
+#define tcg_gen_xor_reg      tcg_gen_xor_i32
+#define tcg_gen_xori_reg     tcg_gen_xori_i32
+#define tcg_gen_not_reg      tcg_gen_not_i32
+#define tcg_gen_shl_reg      tcg_gen_shl_i32
+#define tcg_gen_shli_reg     tcg_gen_shli_i32
+#define tcg_gen_shr_reg      tcg_gen_shr_i32
+#define tcg_gen_shri_reg     tcg_gen_shri_i32
+#define tcg_gen_sar_reg      tcg_gen_sar_i32
+#define tcg_gen_sari_reg     tcg_gen_sari_i32
+#define tcg_gen_brcond_reg   tcg_gen_brcond_i32
+#define tcg_gen_brcondi_reg  tcg_gen_brcondi_i32
+#define tcg_gen_setcond_reg  tcg_gen_setcond_i32
+#define tcg_gen_setcondi_reg tcg_gen_setcondi_i32
+#define tcg_gen_mul_reg      tcg_gen_mul_i32
+#define tcg_gen_muli_reg     tcg_gen_muli_i32
+#define tcg_gen_div_reg      tcg_gen_div_i32
+#define tcg_gen_rem_reg      tcg_gen_rem_i32
+#define tcg_gen_divu_reg     tcg_gen_divu_i32
+#define tcg_gen_remu_reg     tcg_gen_remu_i32
+#define tcg_gen_discard_reg  tcg_gen_discard_i32
+#define tcg_gen_trunc_reg_i32 tcg_gen_mov_i32
+#define tcg_gen_trunc_i64_reg tcg_gen_extrl_i64_i32
+#define tcg_gen_extu_i32_reg tcg_gen_mov_i32
+#define tcg_gen_ext_i32_reg  tcg_gen_mov_i32
+#define tcg_gen_extu_reg_i64 tcg_gen_extu_i32_i64
+#define tcg_gen_ext_reg_i64  tcg_gen_ext_i32_i64
+#define tcg_gen_ext8u_reg    tcg_gen_ext8u_i32
+#define tcg_gen_ext8s_reg    tcg_gen_ext8s_i32
+#define tcg_gen_ext16u_reg   tcg_gen_ext16u_i32
+#define tcg_gen_ext16s_reg   tcg_gen_ext16s_i32
+#define tcg_gen_ext32u_reg   tcg_gen_mov_i32
+#define tcg_gen_ext32s_reg   tcg_gen_mov_i32
+#define tcg_gen_bswap16_reg  tcg_gen_bswap16_i32
+#define tcg_gen_bswap32_reg  tcg_gen_bswap32_i32
+#define tcg_gen_concat_reg_i64 tcg_gen_concat_i32_i64
+#define tcg_gen_andc_reg     tcg_gen_andc_i32
+#define tcg_gen_eqv_reg      tcg_gen_eqv_i32
+#define tcg_gen_nand_reg     tcg_gen_nand_i32
+#define tcg_gen_nor_reg      tcg_gen_nor_i32
+#define tcg_gen_orc_reg      tcg_gen_orc_i32
+#define tcg_gen_clz_reg      tcg_gen_clz_i32
+#define tcg_gen_ctz_reg      tcg_gen_ctz_i32
+#define tcg_gen_clzi_reg     tcg_gen_clzi_i32
+#define tcg_gen_ctzi_reg     tcg_gen_ctzi_i32
+#define tcg_gen_clrsb_reg    tcg_gen_clrsb_i32
+#define tcg_gen_ctpop_reg    tcg_gen_ctpop_i32
+#define tcg_gen_rotl_reg     tcg_gen_rotl_i32
+#define tcg_gen_rotli_reg    tcg_gen_rotli_i32
+#define tcg_gen_rotr_reg     tcg_gen_rotr_i32
+#define tcg_gen_rotri_reg    tcg_gen_rotri_i32
+#define tcg_gen_deposit_reg  tcg_gen_deposit_i32
+#define tcg_gen_deposit_z_reg tcg_gen_deposit_z_i32
+#define tcg_gen_extract_reg  tcg_gen_extract_i32
+#define tcg_gen_sextract_reg tcg_gen_sextract_i32
+#define tcg_const_reg        tcg_const_i32
+#define tcg_const_local_reg  tcg_const_local_i32
+#define tcg_gen_movcond_reg  tcg_gen_movcond_i32
+#define tcg_gen_add2_reg     tcg_gen_add2_i32
+#define tcg_gen_sub2_reg     tcg_gen_sub2_i32
+#define tcg_gen_qemu_ld_reg  tcg_gen_qemu_ld_i32
+#define tcg_gen_qemu_st_reg  tcg_gen_qemu_st_i32
+#define tcg_gen_atomic_xchg_reg tcg_gen_atomic_xchg_i32
+#if UINTPTR_MAX == UINT32_MAX
+# define tcg_gen_trunc_reg_ptr(p,r) tcg_gen_mov_i32(TCGV_PTR_TO_NAT(p),r)
+#else
+# define tcg_gen_trunc_reg_ptr(p,r) tcg_gen_extu_i32_i64(TCGV_PTR_TO_NAT(p),r)
+#endif
+#endif /* TARGET_REGISTER_BITS */
+
 typedef struct DisasCond {
     TCGCond c;
-    TCGv a0, a1;
+    TCGv_reg a0, a1;
     bool a0_is_n;
     bool a1_is_0;
 } DisasCond;
@@ -41,13 +267,13 @@ typedef struct DisasContext {
     DisasContextBase base;
     CPUState *cs;
 
-    target_ulong iaoq_f;
-    target_ulong iaoq_b;
-    target_ulong iaoq_n;
-    TCGv iaoq_n_var;
+    target_ureg iaoq_f;
+    target_ureg iaoq_b;
+    target_ureg iaoq_n;
+    TCGv_reg iaoq_n_var;
 
     int ntemps;
-    TCGv temps[8];
+    TCGv_reg temps[8];
 
     DisasCond null_cond;
     TCGLabel *null_lab;
@@ -72,7 +298,7 @@ typedef struct DisasInsn {
     DisasJumpType (*trans)(DisasContext *ctx, uint32_t insn,
                            const struct DisasInsn *f);
     union {
-        void (*ttt)(TCGv, TCGv, TCGv);
+        void (*ttt)(TCGv_reg, TCGv_reg, TCGv_reg);
         void (*weww)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32);
         void (*dedd)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64);
         void (*wew)(TCGv_i32, TCGv_env, TCGv_i32);
@@ -83,16 +309,16 @@ typedef struct DisasInsn {
 } DisasInsn;
 
 /* global register indexes */
-static TCGv cpu_gr[32];
-static TCGv cpu_iaoq_f;
-static TCGv cpu_iaoq_b;
-static TCGv cpu_sar;
-static TCGv cpu_psw_n;
-static TCGv cpu_psw_v;
-static TCGv cpu_psw_cb;
-static TCGv cpu_psw_cb_msb;
-static TCGv cpu_cr26;
-static TCGv cpu_cr27;
+static TCGv_reg cpu_gr[32];
+static TCGv_reg cpu_iaoq_f;
+static TCGv_reg cpu_iaoq_b;
+static TCGv_reg cpu_sar;
+static TCGv_reg cpu_psw_n;
+static TCGv_reg cpu_psw_v;
+static TCGv_reg cpu_psw_cb;
+static TCGv_reg cpu_psw_cb_msb;
+static TCGv_reg cpu_cr26;
+static TCGv_reg cpu_cr27;
 
 #include "exec/gen-icount.h"
 
@@ -100,7 +326,7 @@ void hppa_translate_init(void)
 {
 #define DEF_VAR(V)  { &cpu_##V, #V, offsetof(CPUHPPAState, V) }
 
-    typedef struct { TCGv *var; const char *name; int ofs; } GlobalVar;
+    typedef struct { TCGv_reg *var; const char *name; int ofs; } GlobalVar;
     static const GlobalVar vars[] = {
         DEF_VAR(sar),
         DEF_VAR(cr26),
@@ -158,26 +384,26 @@ static DisasCond cond_make_n(void)
     };
 }
 
-static DisasCond cond_make_0(TCGCond c, TCGv a0)
+static DisasCond cond_make_0(TCGCond c, TCGv_reg a0)
 {
     DisasCond r = { .c = c, .a1 = NULL, .a1_is_0 = true };
 
     assert (c != TCG_COND_NEVER && c != TCG_COND_ALWAYS);
     r.a0 = tcg_temp_new();
-    tcg_gen_mov_tl(r.a0, a0);
+    tcg_gen_mov_reg(r.a0, a0);
 
     return r;
 }
 
-static DisasCond cond_make(TCGCond c, TCGv a0, TCGv a1)
+static DisasCond cond_make(TCGCond c, TCGv_reg a0, TCGv_reg a1)
 {
     DisasCond r = { .c = c };
 
     assert (c != TCG_COND_NEVER && c != TCG_COND_ALWAYS);
     r.a0 = tcg_temp_new();
-    tcg_gen_mov_tl(r.a0, a0);
+    tcg_gen_mov_reg(r.a0, a0);
     r.a1 = tcg_temp_new();
-    tcg_gen_mov_tl(r.a1, a1);
+    tcg_gen_mov_reg(r.a1, a1);
 
     return r;
 }
@@ -186,7 +412,7 @@ static void cond_prep(DisasCond *cond)
 {
     if (cond->a1_is_0) {
         cond->a1_is_0 = false;
-        cond->a1 = tcg_const_tl(0);
+        cond->a1 = tcg_const_reg(0);
     }
 }
 
@@ -213,32 +439,32 @@ static void cond_free(DisasCond *cond)
     }
 }
 
-static TCGv get_temp(DisasContext *ctx)
+static TCGv_reg get_temp(DisasContext *ctx)
 {
     unsigned i = ctx->ntemps++;
     g_assert(i < ARRAY_SIZE(ctx->temps));
     return ctx->temps[i] = tcg_temp_new();
 }
 
-static TCGv load_const(DisasContext *ctx, target_long v)
+static TCGv_reg load_const(DisasContext *ctx, target_sreg v)
 {
-    TCGv t = get_temp(ctx);
-    tcg_gen_movi_tl(t, v);
+    TCGv_reg t = get_temp(ctx);
+    tcg_gen_movi_reg(t, v);
     return t;
 }
 
-static TCGv load_gpr(DisasContext *ctx, unsigned reg)
+static TCGv_reg load_gpr(DisasContext *ctx, unsigned reg)
 {
     if (reg == 0) {
-        TCGv t = get_temp(ctx);
-        tcg_gen_movi_tl(t, 0);
+        TCGv_reg t = get_temp(ctx);
+        tcg_gen_movi_reg(t, 0);
         return t;
     } else {
         return cpu_gr[reg];
     }
 }
 
-static TCGv dest_gpr(DisasContext *ctx, unsigned reg)
+static TCGv_reg dest_gpr(DisasContext *ctx, unsigned reg)
 {
     if (reg == 0 || ctx->null_cond.c != TCG_COND_NEVER) {
         return get_temp(ctx);
@@ -247,18 +473,18 @@ static TCGv dest_gpr(DisasContext *ctx, unsigned reg)
     }
 }
 
-static void save_or_nullify(DisasContext *ctx, TCGv dest, TCGv t)
+static void save_or_nullify(DisasContext *ctx, TCGv_reg dest, TCGv_reg t)
 {
     if (ctx->null_cond.c != TCG_COND_NEVER) {
         cond_prep(&ctx->null_cond);
-        tcg_gen_movcond_tl(ctx->null_cond.c, dest, ctx->null_cond.a0,
+        tcg_gen_movcond_reg(ctx->null_cond.c, dest, ctx->null_cond.a0,
                            ctx->null_cond.a1, dest, t);
     } else {
-        tcg_gen_mov_tl(dest, t);
+        tcg_gen_mov_reg(dest, t);
     }
 }
 
-static void save_gpr(DisasContext *ctx, unsigned reg, TCGv t)
+static void save_gpr(DisasContext *ctx, unsigned reg, TCGv_reg t)
 {
     if (reg != 0) {
         save_or_nullify(ctx, cpu_gr[reg], t);
@@ -350,17 +576,17 @@ static void nullify_over(DisasContext *ctx)
         if (ctx->null_cond.a0_is_n) {
             ctx->null_cond.a0_is_n = false;
             ctx->null_cond.a0 = tcg_temp_new();
-            tcg_gen_mov_tl(ctx->null_cond.a0, cpu_psw_n);
+            tcg_gen_mov_reg(ctx->null_cond.a0, cpu_psw_n);
         }
         /* ... we clear it before branching over the implementation,
            so that (1) it's clear after nullifying this insn and
            (2) if this insn nullifies the next, PSW[N] is valid.  */
         if (ctx->psw_n_nonzero) {
             ctx->psw_n_nonzero = false;
-            tcg_gen_movi_tl(cpu_psw_n, 0);
+            tcg_gen_movi_reg(cpu_psw_n, 0);
         }
 
-        tcg_gen_brcond_tl(ctx->null_cond.c, ctx->null_cond.a0,
+        tcg_gen_brcond_reg(ctx->null_cond.c, ctx->null_cond.a0,
                           ctx->null_cond.a1, ctx->null_lab);
         cond_free(&ctx->null_cond);
     }
@@ -371,13 +597,13 @@ static void nullify_save(DisasContext *ctx)
 {
     if (ctx->null_cond.c == TCG_COND_NEVER) {
         if (ctx->psw_n_nonzero) {
-            tcg_gen_movi_tl(cpu_psw_n, 0);
+            tcg_gen_movi_reg(cpu_psw_n, 0);
         }
         return;
     }
     if (!ctx->null_cond.a0_is_n) {
         cond_prep(&ctx->null_cond);
-        tcg_gen_setcond_tl(ctx->null_cond.c, cpu_psw_n,
+        tcg_gen_setcond_reg(ctx->null_cond.c, cpu_psw_n,
                            ctx->null_cond.a0, ctx->null_cond.a1);
         ctx->psw_n_nonzero = true;
     }
@@ -390,7 +616,7 @@ static void nullify_save(DisasContext *ctx)
 static void nullify_set(DisasContext *ctx, bool x)
 {
     if (ctx->psw_n_nonzero || x) {
-        tcg_gen_movi_tl(cpu_psw_n, x);
+        tcg_gen_movi_reg(cpu_psw_n, x);
     }
 }
 
@@ -429,16 +655,16 @@ static DisasJumpType nullify_end(DisasContext *ctx, DisasJumpType status)
     return status;
 }
 
-static void copy_iaoq_entry(TCGv dest, target_ulong ival, TCGv vval)
+static void copy_iaoq_entry(TCGv_reg dest, target_ureg ival, TCGv_reg vval)
 {
     if (unlikely(ival == -1)) {
-        tcg_gen_mov_tl(dest, vval);
+        tcg_gen_mov_reg(dest, vval);
     } else {
-        tcg_gen_movi_tl(dest, ival);
+        tcg_gen_movi_reg(dest, ival);
     }
 }
 
-static inline target_ulong iaoq_dest(DisasContext *ctx, target_long disp)
+static inline target_ureg iaoq_dest(DisasContext *ctx, target_sreg disp)
 {
     return ctx->iaoq_f + disp + 8;
 }
@@ -465,7 +691,7 @@ static DisasJumpType gen_illegal(DisasContext *ctx)
     return nullify_end(ctx, gen_excp(ctx, EXCP_ILL));
 }
 
-static bool use_goto_tb(DisasContext *ctx, target_ulong dest)
+static bool use_goto_tb(DisasContext *ctx, target_ureg dest)
 {
     /* Suppress goto_tb in the case of single-steping and IO.  */
     if ((tb_cflags(ctx->base.tb) & CF_LAST_IO) || ctx->base.singlestep_enabled) {
@@ -485,12 +711,12 @@ static bool use_nullify_skip(DisasContext *ctx)
 }
 
 static void gen_goto_tb(DisasContext *ctx, int which,
-                        target_ulong f, target_ulong b)
+                        target_ureg f, target_ureg b)
 {
     if (f != -1 && b != -1 && use_goto_tb(ctx, f)) {
         tcg_gen_goto_tb(which);
-        tcg_gen_movi_tl(cpu_iaoq_f, f);
-        tcg_gen_movi_tl(cpu_iaoq_b, b);
+        tcg_gen_movi_reg(cpu_iaoq_f, f);
+        tcg_gen_movi_reg(cpu_iaoq_b, b);
         tcg_gen_exit_tb((uintptr_t)ctx->base.tb + which);
     } else {
         copy_iaoq_entry(cpu_iaoq_f, f, cpu_iaoq_b);
@@ -505,9 +731,9 @@ static void gen_goto_tb(DisasContext *ctx, int which,
 
 /* PA has a habit of taking the LSB of a field and using that as the sign,
    with the rest of the field becoming the least significant bits.  */
-static target_long low_sextract(uint32_t val, int pos, int len)
+static target_sreg low_sextract(uint32_t val, int pos, int len)
 {
-    target_ulong x = -(target_ulong)extract32(val, pos, 1);
+    target_ureg x = -(target_ureg)extract32(val, pos, 1);
     x = (x << (len - 1)) | extract32(val, pos + 1, len - 1);
     return x;
 }
@@ -541,15 +767,15 @@ static unsigned assemble_rc64(uint32_t insn)
     return r2 * 32 + r1 * 4 + r0;
 }
 
-static target_long assemble_12(uint32_t insn)
+static target_sreg assemble_12(uint32_t insn)
 {
-    target_ulong x = -(target_ulong)(insn & 1);
+    target_ureg x = -(target_ureg)(insn & 1);
     x = (x <<  1) | extract32(insn, 2, 1);
     x = (x << 10) | extract32(insn, 3, 10);
     return x;
 }
 
-static target_long assemble_16(uint32_t insn)
+static target_sreg assemble_16(uint32_t insn)
 {
     /* Take the name from PA2.0, which produces a 16-bit number
        only with wide mode; otherwise a 14-bit number.  Since we don't
@@ -557,28 +783,28 @@ static target_long assemble_16(uint32_t insn)
     return low_sextract(insn, 0, 14);
 }
 
-static target_long assemble_16a(uint32_t insn)
+static target_sreg assemble_16a(uint32_t insn)
 {
     /* Take the name from PA2.0, which produces a 14-bit shifted number
        only with wide mode; otherwise a 12-bit shifted number.  Since we
        don't implement wide mode, this is always the 12-bit number.  */
-    target_ulong x = -(target_ulong)(insn & 1);
+    target_ureg x = -(target_ureg)(insn & 1);
     x = (x << 11) | extract32(insn, 2, 11);
     return x << 2;
 }
 
-static target_long assemble_17(uint32_t insn)
+static target_sreg assemble_17(uint32_t insn)
 {
-    target_ulong x = -(target_ulong)(insn & 1);
+    target_ureg x = -(target_ureg)(insn & 1);
     x = (x <<  5) | extract32(insn, 16, 5);
     x = (x <<  1) | extract32(insn, 2, 1);
     x = (x << 10) | extract32(insn, 3, 10);
     return x << 2;
 }
 
-static target_long assemble_21(uint32_t insn)
+static target_sreg assemble_21(uint32_t insn)
 {
-    target_ulong x = -(target_ulong)(insn & 1);
+    target_ureg x = -(target_ureg)(insn & 1);
     x = (x << 11) | extract32(insn, 1, 11);
     x = (x <<  2) | extract32(insn, 14, 2);
     x = (x <<  5) | extract32(insn, 16, 5);
@@ -586,9 +812,9 @@ static target_long assemble_21(uint32_t insn)
     return x << 11;
 }
 
-static target_long assemble_22(uint32_t insn)
+static target_sreg assemble_22(uint32_t insn)
 {
-    target_ulong x = -(target_ulong)(insn & 1);
+    target_ureg x = -(target_ureg)(insn & 1);
     x = (x << 10) | extract32(insn, 16, 10);
     x = (x <<  1) | extract32(insn, 2, 1);
     x = (x << 10) | extract32(insn, 3, 10);
@@ -602,10 +828,10 @@ static target_long assemble_22(uint32_t insn)
    as a whole it would appear that these relations are similar to what
    a traditional NZCV set of flags would produce.  */
 
-static DisasCond do_cond(unsigned cf, TCGv res, TCGv cb_msb, TCGv sv)
+static DisasCond do_cond(unsigned cf, TCGv_reg res, TCGv_reg cb_msb, TCGv_reg sv)
 {
     DisasCond cond;
-    TCGv tmp;
+    TCGv_reg tmp;
 
     switch (cf >> 1) {
     case 0: /* Never / TR */
@@ -625,8 +851,8 @@ static DisasCond do_cond(unsigned cf, TCGv res, TCGv cb_msb, TCGv sv)
         break;
     case 5: /* ZNV / VNZ     (!C | Z / C & !Z) */
         tmp = tcg_temp_new();
-        tcg_gen_neg_tl(tmp, cb_msb);
-        tcg_gen_and_tl(tmp, tmp, res);
+        tcg_gen_neg_reg(tmp, cb_msb);
+        tcg_gen_and_reg(tmp, tmp, res);
         cond = cond_make_0(TCG_COND_EQ, tmp);
         tcg_temp_free(tmp);
         break;
@@ -635,7 +861,7 @@ static DisasCond do_cond(unsigned cf, TCGv res, TCGv cb_msb, TCGv sv)
         break;
     case 7: /* OD / EV */
         tmp = tcg_temp_new();
-        tcg_gen_andi_tl(tmp, res, 1);
+        tcg_gen_andi_reg(tmp, res, 1);
         cond = cond_make_0(TCG_COND_NE, tmp);
         tcg_temp_free(tmp);
         break;
@@ -653,7 +879,7 @@ static DisasCond do_cond(unsigned cf, TCGv res, TCGv cb_msb, TCGv sv)
    can use the inputs directly.  This can allow other computation to be
    deleted as unused.  */
 
-static DisasCond do_sub_cond(unsigned cf, TCGv res, TCGv in1, TCGv in2, TCGv sv)
+static DisasCond do_sub_cond(unsigned cf, TCGv_reg res, TCGv_reg in1, TCGv_reg in2, TCGv_reg sv)
 {
     DisasCond cond;
 
@@ -686,7 +912,7 @@ static DisasCond do_sub_cond(unsigned cf, TCGv res, TCGv in1, TCGv in2, TCGv sv)
 /* Similar, but for logicals, where the carry and overflow bits are not
    computed, and use of them is undefined.  */
 
-static DisasCond do_log_cond(unsigned cf, TCGv res)
+static DisasCond do_log_cond(unsigned cf, TCGv_reg res)
 {
     switch (cf >> 1) {
     case 4: case 5: case 6:
@@ -698,7 +924,7 @@ static DisasCond do_log_cond(unsigned cf, TCGv res)
 
 /* Similar, but for shift/extract/deposit conditions.  */
 
-static DisasCond do_sed_cond(unsigned orig, TCGv res)
+static DisasCond do_sed_cond(unsigned orig, TCGv_reg res)
 {
     unsigned c, f;
 
@@ -716,10 +942,10 @@ static DisasCond do_sed_cond(unsigned orig, TCGv res)
 
 /* Similar, but for unit conditions.  */
 
-static DisasCond do_unit_cond(unsigned cf, TCGv res, TCGv in1, TCGv in2)
+static DisasCond do_unit_cond(unsigned cf, TCGv_reg res, TCGv_reg in1, TCGv_reg in2)
 {
     DisasCond cond;
-    TCGv tmp, cb = NULL;
+    TCGv_reg tmp, cb = NULL;
 
     if (cf & 8) {
         /* Since we want to test lots of carry-out bits all at once, do not
@@ -728,10 +954,10 @@ static DisasCond do_unit_cond(unsigned cf, TCGv res, TCGv in1, TCGv in2)
          */
         cb = tcg_temp_new();
         tmp = tcg_temp_new();
-        tcg_gen_or_tl(cb, in1, in2);
-        tcg_gen_and_tl(tmp, in1, in2);
-        tcg_gen_andc_tl(cb, cb, res);
-        tcg_gen_or_tl(cb, cb, tmp);
+        tcg_gen_or_reg(cb, in1, in2);
+        tcg_gen_and_reg(tmp, in1, in2);
+        tcg_gen_andc_reg(cb, cb, res);
+        tcg_gen_or_reg(cb, cb, tmp);
         tcg_temp_free(tmp);
     }
 
@@ -747,34 +973,34 @@ static DisasCond do_unit_cond(unsigned cf, TCGv res, TCGv in1, TCGv in2)
          * https://graphics.stanford.edu/~seander/bithacks.html#ZeroInWord
          */
         tmp = tcg_temp_new();
-        tcg_gen_subi_tl(tmp, res, 0x01010101u);
-        tcg_gen_andc_tl(tmp, tmp, res);
-        tcg_gen_andi_tl(tmp, tmp, 0x80808080u);
+        tcg_gen_subi_reg(tmp, res, 0x01010101u);
+        tcg_gen_andc_reg(tmp, tmp, res);
+        tcg_gen_andi_reg(tmp, tmp, 0x80808080u);
         cond = cond_make_0(TCG_COND_NE, tmp);
         tcg_temp_free(tmp);
         break;
 
     case 3: /* SHZ / NHZ */
         tmp = tcg_temp_new();
-        tcg_gen_subi_tl(tmp, res, 0x00010001u);
-        tcg_gen_andc_tl(tmp, tmp, res);
-        tcg_gen_andi_tl(tmp, tmp, 0x80008000u);
+        tcg_gen_subi_reg(tmp, res, 0x00010001u);
+        tcg_gen_andc_reg(tmp, tmp, res);
+        tcg_gen_andi_reg(tmp, tmp, 0x80008000u);
         cond = cond_make_0(TCG_COND_NE, tmp);
         tcg_temp_free(tmp);
         break;
 
     case 4: /* SDC / NDC */
-        tcg_gen_andi_tl(cb, cb, 0x88888888u);
+        tcg_gen_andi_reg(cb, cb, 0x88888888u);
         cond = cond_make_0(TCG_COND_NE, cb);
         break;
 
     case 6: /* SBC / NBC */
-        tcg_gen_andi_tl(cb, cb, 0x80808080u);
+        tcg_gen_andi_reg(cb, cb, 0x80808080u);
         cond = cond_make_0(TCG_COND_NE, cb);
         break;
 
     case 7: /* SHC / NHC */
-        tcg_gen_andi_tl(cb, cb, 0x80008000u);
+        tcg_gen_andi_reg(cb, cb, 0x80008000u);
         cond = cond_make_0(TCG_COND_NE, cb);
         break;
 
@@ -792,38 +1018,38 @@ static DisasCond do_unit_cond(unsigned cf, TCGv res, TCGv in1, TCGv in2)
 }
 
 /* Compute signed overflow for addition.  */
-static TCGv do_add_sv(DisasContext *ctx, TCGv res, TCGv in1, TCGv in2)
+static TCGv_reg do_add_sv(DisasContext *ctx, TCGv_reg res, TCGv_reg in1, TCGv_reg in2)
 {
-    TCGv sv = get_temp(ctx);
-    TCGv tmp = tcg_temp_new();
+    TCGv_reg sv = get_temp(ctx);
+    TCGv_reg tmp = tcg_temp_new();
 
-    tcg_gen_xor_tl(sv, res, in1);
-    tcg_gen_xor_tl(tmp, in1, in2);
-    tcg_gen_andc_tl(sv, sv, tmp);
+    tcg_gen_xor_reg(sv, res, in1);
+    tcg_gen_xor_reg(tmp, in1, in2);
+    tcg_gen_andc_reg(sv, sv, tmp);
     tcg_temp_free(tmp);
 
     return sv;
 }
 
 /* Compute signed overflow for subtraction.  */
-static TCGv do_sub_sv(DisasContext *ctx, TCGv res, TCGv in1, TCGv in2)
+static TCGv_reg do_sub_sv(DisasContext *ctx, TCGv_reg res, TCGv_reg in1, TCGv_reg in2)
 {
-    TCGv sv = get_temp(ctx);
-    TCGv tmp = tcg_temp_new();
+    TCGv_reg sv = get_temp(ctx);
+    TCGv_reg tmp = tcg_temp_new();
 
-    tcg_gen_xor_tl(sv, res, in1);
-    tcg_gen_xor_tl(tmp, in1, in2);
-    tcg_gen_and_tl(sv, sv, tmp);
+    tcg_gen_xor_reg(sv, res, in1);
+    tcg_gen_xor_reg(tmp, in1, in2);
+    tcg_gen_and_reg(sv, sv, tmp);
     tcg_temp_free(tmp);
 
     return sv;
 }
 
-static DisasJumpType do_add(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
+static DisasJumpType do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1, TCGv_reg in2,
                             unsigned shift, bool is_l, bool is_tsv, bool is_tc,
                             bool is_c, unsigned cf)
 {
-    TCGv dest, cb, cb_msb, sv, tmp;
+    TCGv_reg dest, cb, cb_msb, sv, tmp;
     unsigned c = cf >> 1;
     DisasCond cond;
 
@@ -833,27 +1059,27 @@ static DisasJumpType do_add(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
 
     if (shift) {
         tmp = get_temp(ctx);
-        tcg_gen_shli_tl(tmp, in1, shift);
+        tcg_gen_shli_reg(tmp, in1, shift);
         in1 = tmp;
     }
 
     if (!is_l || c == 4 || c == 5) {
-        TCGv zero = tcg_const_tl(0);
+        TCGv_reg zero = tcg_const_reg(0);
         cb_msb = get_temp(ctx);
-        tcg_gen_add2_tl(dest, cb_msb, in1, zero, in2, zero);
+        tcg_gen_add2_reg(dest, cb_msb, in1, zero, in2, zero);
         if (is_c) {
-            tcg_gen_add2_tl(dest, cb_msb, dest, cb_msb, cpu_psw_cb_msb, zero);
+            tcg_gen_add2_reg(dest, cb_msb, dest, cb_msb, cpu_psw_cb_msb, zero);
         }
         tcg_temp_free(zero);
         if (!is_l) {
             cb = get_temp(ctx);
-            tcg_gen_xor_tl(cb, in1, in2);
-            tcg_gen_xor_tl(cb, cb, dest);
+            tcg_gen_xor_reg(cb, in1, in2);
+            tcg_gen_xor_reg(cb, cb, dest);
         }
     } else {
-        tcg_gen_add_tl(dest, in1, in2);
+        tcg_gen_add_reg(dest, in1, in2);
         if (is_c) {
-            tcg_gen_add_tl(dest, dest, cpu_psw_cb_msb);
+            tcg_gen_add_reg(dest, dest, cpu_psw_cb_msb);
         }
     }
 
@@ -872,7 +1098,7 @@ static DisasJumpType do_add(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
     if (is_tc) {
         cond_prep(&cond);
         tmp = tcg_temp_new();
-        tcg_gen_setcond_tl(cond.c, tmp, cond.a0, cond.a1);
+        tcg_gen_setcond_reg(cond.c, tmp, cond.a0, cond.a1);
         gen_helper_tcond(cpu_env, tmp);
         tcg_temp_free(tmp);
     }
@@ -891,10 +1117,10 @@ static DisasJumpType do_add(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
     return DISAS_NEXT;
 }
 
-static DisasJumpType do_sub(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
+static DisasJumpType do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1, TCGv_reg in2,
                             bool is_tsv, bool is_b, bool is_tc, unsigned cf)
 {
-    TCGv dest, sv, cb, cb_msb, zero, tmp;
+    TCGv_reg dest, sv, cb, cb_msb, zero, tmp;
     unsigned c = cf >> 1;
     DisasCond cond;
 
@@ -902,21 +1128,21 @@ static DisasJumpType do_sub(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
     cb = tcg_temp_new();
     cb_msb = tcg_temp_new();
 
-    zero = tcg_const_tl(0);
+    zero = tcg_const_reg(0);
     if (is_b) {
         /* DEST,C = IN1 + ~IN2 + C.  */
-        tcg_gen_not_tl(cb, in2);
-        tcg_gen_add2_tl(dest, cb_msb, in1, zero, cpu_psw_cb_msb, zero);
-        tcg_gen_add2_tl(dest, cb_msb, dest, cb_msb, cb, zero);
-        tcg_gen_xor_tl(cb, cb, in1);
-        tcg_gen_xor_tl(cb, cb, dest);
+        tcg_gen_not_reg(cb, in2);
+        tcg_gen_add2_reg(dest, cb_msb, in1, zero, cpu_psw_cb_msb, zero);
+        tcg_gen_add2_reg(dest, cb_msb, dest, cb_msb, cb, zero);
+        tcg_gen_xor_reg(cb, cb, in1);
+        tcg_gen_xor_reg(cb, cb, dest);
     } else {
         /* DEST,C = IN1 + ~IN2 + 1.  We can produce the same result in fewer
            operations by seeding the high word with 1 and subtracting.  */
-        tcg_gen_movi_tl(cb_msb, 1);
-        tcg_gen_sub2_tl(dest, cb_msb, in1, cb_msb, in2, zero);
-        tcg_gen_eqv_tl(cb, in1, in2);
-        tcg_gen_xor_tl(cb, cb, dest);
+        tcg_gen_movi_reg(cb_msb, 1);
+        tcg_gen_sub2_reg(dest, cb_msb, in1, cb_msb, in2, zero);
+        tcg_gen_eqv_reg(cb, in1, in2);
+        tcg_gen_xor_reg(cb, cb, dest);
     }
     tcg_temp_free(zero);
 
@@ -940,7 +1166,7 @@ static DisasJumpType do_sub(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
     if (is_tc) {
         cond_prep(&cond);
         tmp = tcg_temp_new();
-        tcg_gen_setcond_tl(cond.c, tmp, cond.a0, cond.a1);
+        tcg_gen_setcond_reg(cond.c, tmp, cond.a0, cond.a1);
         gen_helper_tcond(cpu_env, tmp);
         tcg_temp_free(tmp);
     }
@@ -957,14 +1183,14 @@ static DisasJumpType do_sub(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
     return DISAS_NEXT;
 }
 
-static DisasJumpType do_cmpclr(DisasContext *ctx, unsigned rt, TCGv in1,
-                               TCGv in2, unsigned cf)
+static DisasJumpType do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
+                               TCGv_reg in2, unsigned cf)
 {
-    TCGv dest, sv;
+    TCGv_reg dest, sv;
     DisasCond cond;
 
     dest = tcg_temp_new();
-    tcg_gen_sub_tl(dest, in1, in2);
+    tcg_gen_sub_reg(dest, in1, in2);
 
     /* Compute signed overflow if required.  */
     sv = NULL;
@@ -976,7 +1202,7 @@ static DisasJumpType do_cmpclr(DisasContext *ctx, unsigned rt, TCGv in1,
     cond = do_sub_cond(cf, dest, in1, in2, sv);
 
     /* Clear.  */
-    tcg_gen_movi_tl(dest, 0);
+    tcg_gen_movi_reg(dest, 0);
     save_gpr(ctx, rt, dest);
     tcg_temp_free(dest);
 
@@ -986,10 +1212,10 @@ static DisasJumpType do_cmpclr(DisasContext *ctx, unsigned rt, TCGv in1,
     return DISAS_NEXT;
 }
 
-static DisasJumpType do_log(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
-                            unsigned cf, void (*fn)(TCGv, TCGv, TCGv))
+static DisasJumpType do_log(DisasContext *ctx, unsigned rt, TCGv_reg in1, TCGv_reg in2,
+                            unsigned cf, void (*fn)(TCGv_reg, TCGv_reg, TCGv_reg))
 {
-    TCGv dest = dest_gpr(ctx, rt);
+    TCGv_reg dest = dest_gpr(ctx, rt);
 
     /* Perform the operation, and writeback.  */
     fn(dest, in1, in2);
@@ -1003,11 +1229,11 @@ static DisasJumpType do_log(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
     return DISAS_NEXT;
 }
 
-static DisasJumpType do_unit(DisasContext *ctx, unsigned rt, TCGv in1,
-                             TCGv in2, unsigned cf, bool is_tc,
-                             void (*fn)(TCGv, TCGv, TCGv))
+static DisasJumpType do_unit(DisasContext *ctx, unsigned rt, TCGv_reg in1,
+                             TCGv_reg in2, unsigned cf, bool is_tc,
+                             void (*fn)(TCGv_reg, TCGv_reg, TCGv_reg))
 {
-    TCGv dest;
+    TCGv_reg dest;
     DisasCond cond;
 
     if (cf == 0) {
@@ -1022,9 +1248,9 @@ static DisasJumpType do_unit(DisasContext *ctx, unsigned rt, TCGv in1,
         cond = do_unit_cond(cf, dest, in1, in2);
 
         if (is_tc) {
-            TCGv tmp = tcg_temp_new();
+            TCGv_reg tmp = tcg_temp_new();
             cond_prep(&cond);
-            tcg_gen_setcond_tl(cond.c, tmp, cond.a0, cond.a1);
+            tcg_gen_setcond_reg(cond.c, tmp, cond.a0, cond.a1);
             gen_helper_tcond(cpu_env, tmp);
             tcg_temp_free(tmp);
         }
@@ -1042,10 +1268,10 @@ static DisasJumpType do_unit(DisasContext *ctx, unsigned rt, TCGv in1,
  * = 0 for no base register update.
  */
 static void do_load_32(DisasContext *ctx, TCGv_i32 dest, unsigned rb,
-                       unsigned rx, int scale, target_long disp,
+                       unsigned rx, int scale, target_sreg disp,
                        int modify, TCGMemOp mop)
 {
-    TCGv addr, base;
+    TCGv_reg addr, base;
 
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
@@ -1055,10 +1281,10 @@ static void do_load_32(DisasContext *ctx, TCGv_i32 dest, unsigned rb,
 
     /* Note that RX is mutually exclusive with DISP.  */
     if (rx) {
-        tcg_gen_shli_tl(addr, cpu_gr[rx], scale);
-        tcg_gen_add_tl(addr, addr, base);
+        tcg_gen_shli_reg(addr, cpu_gr[rx], scale);
+        tcg_gen_add_reg(addr, addr, base);
     } else {
-        tcg_gen_addi_tl(addr, base, disp);
+        tcg_gen_addi_reg(addr, base, disp);
     }
 
     if (modify == 0) {
@@ -1072,10 +1298,10 @@ static void do_load_32(DisasContext *ctx, TCGv_i32 dest, unsigned rb,
 }
 
 static void do_load_64(DisasContext *ctx, TCGv_i64 dest, unsigned rb,
-                       unsigned rx, int scale, target_long disp,
+                       unsigned rx, int scale, target_sreg disp,
                        int modify, TCGMemOp mop)
 {
-    TCGv addr, base;
+    TCGv_reg addr, base;
 
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
@@ -1085,10 +1311,10 @@ static void do_load_64(DisasContext *ctx, TCGv_i64 dest, unsigned rb,
 
     /* Note that RX is mutually exclusive with DISP.  */
     if (rx) {
-        tcg_gen_shli_tl(addr, cpu_gr[rx], scale);
-        tcg_gen_add_tl(addr, addr, base);
+        tcg_gen_shli_reg(addr, cpu_gr[rx], scale);
+        tcg_gen_add_reg(addr, addr, base);
     } else {
-        tcg_gen_addi_tl(addr, base, disp);
+        tcg_gen_addi_reg(addr, base, disp);
     }
 
     if (modify == 0) {
@@ -1102,10 +1328,10 @@ static void do_load_64(DisasContext *ctx, TCGv_i64 dest, unsigned rb,
 }
 
 static void do_store_32(DisasContext *ctx, TCGv_i32 src, unsigned rb,
-                        unsigned rx, int scale, target_long disp,
+                        unsigned rx, int scale, target_sreg disp,
                         int modify, TCGMemOp mop)
 {
-    TCGv addr, base;
+    TCGv_reg addr, base;
 
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
@@ -1115,10 +1341,10 @@ static void do_store_32(DisasContext *ctx, TCGv_i32 src, unsigned rb,
 
     /* Note that RX is mutually exclusive with DISP.  */
     if (rx) {
-        tcg_gen_shli_tl(addr, cpu_gr[rx], scale);
-        tcg_gen_add_tl(addr, addr, base);
+        tcg_gen_shli_reg(addr, cpu_gr[rx], scale);
+        tcg_gen_add_reg(addr, addr, base);
     } else {
-        tcg_gen_addi_tl(addr, base, disp);
+        tcg_gen_addi_reg(addr, base, disp);
     }
 
     tcg_gen_qemu_st_i32(src, (modify <= 0 ? addr : base), MMU_USER_IDX, mop);
@@ -1130,10 +1356,10 @@ static void do_store_32(DisasContext *ctx, TCGv_i32 src, unsigned rb,
 }
 
 static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
-                        unsigned rx, int scale, target_long disp,
+                        unsigned rx, int scale, target_sreg disp,
                         int modify, TCGMemOp mop)
 {
-    TCGv addr, base;
+    TCGv_reg addr, base;
 
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
@@ -1143,10 +1369,10 @@ static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
 
     /* Note that RX is mutually exclusive with DISP.  */
     if (rx) {
-        tcg_gen_shli_tl(addr, cpu_gr[rx], scale);
-        tcg_gen_add_tl(addr, addr, base);
+        tcg_gen_shli_reg(addr, cpu_gr[rx], scale);
+        tcg_gen_add_reg(addr, addr, base);
     } else {
-        tcg_gen_addi_tl(addr, base, disp);
+        tcg_gen_addi_reg(addr, base, disp);
     }
 
     tcg_gen_qemu_st_i64(src, (modify <= 0 ? addr : base), MMU_USER_IDX, mop);
@@ -1157,19 +1383,19 @@ static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
     tcg_temp_free(addr);
 }
 
-#if TARGET_LONG_BITS == 64
-#define do_load_tl  do_load_64
-#define do_store_tl do_store_64
+#if TARGET_REGISTER_BITS == 64
+#define do_load_reg   do_load_64
+#define do_store_reg  do_store_64
 #else
-#define do_load_tl  do_load_32
-#define do_store_tl do_store_32
+#define do_load_reg   do_load_32
+#define do_store_reg  do_store_32
 #endif
 
 static DisasJumpType do_load(DisasContext *ctx, unsigned rt, unsigned rb,
-                             unsigned rx, int scale, target_long disp,
+                             unsigned rx, int scale, target_sreg disp,
                              int modify, TCGMemOp mop)
 {
-    TCGv dest;
+    TCGv_reg dest;
 
     nullify_over(ctx);
 
@@ -1180,14 +1406,14 @@ static DisasJumpType do_load(DisasContext *ctx, unsigned rt, unsigned rb,
         /* Make sure if RT == RB, we see the result of the load.  */
         dest = get_temp(ctx);
     }
-    do_load_tl(ctx, dest, rb, rx, scale, disp, modify, mop);
+    do_load_reg(ctx, dest, rb, rx, scale, disp, modify, mop);
     save_gpr(ctx, rt, dest);
 
     return nullify_end(ctx, DISAS_NEXT);
 }
 
 static DisasJumpType do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
-                               unsigned rx, int scale, target_long disp,
+                               unsigned rx, int scale, target_sreg disp,
                                int modify)
 {
     TCGv_i32 tmp;
@@ -1207,7 +1433,7 @@ static DisasJumpType do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
 }
 
 static DisasJumpType do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
-                               unsigned rx, int scale, target_long disp,
+                               unsigned rx, int scale, target_sreg disp,
                                int modify)
 {
     TCGv_i64 tmp;
@@ -1227,15 +1453,15 @@ static DisasJumpType do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
 }
 
 static DisasJumpType do_store(DisasContext *ctx, unsigned rt, unsigned rb,
-                              target_long disp, int modify, TCGMemOp mop)
+                              target_sreg disp, int modify, TCGMemOp mop)
 {
     nullify_over(ctx);
-    do_store_tl(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, modify, mop);
+    do_store_reg(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, modify, mop);
     return nullify_end(ctx, DISAS_NEXT);
 }
 
 static DisasJumpType do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
-                                unsigned rx, int scale, target_long disp,
+                                unsigned rx, int scale, target_sreg disp,
                                 int modify)
 {
     TCGv_i32 tmp;
@@ -1250,7 +1476,7 @@ static DisasJumpType do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
 }
 
 static DisasJumpType do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
-                                unsigned rx, int scale, target_long disp,
+                                unsigned rx, int scale, target_sreg disp,
                                 int modify)
 {
     TCGv_i64 tmp;
@@ -1370,7 +1596,7 @@ static DisasJumpType do_fop_dedd(DisasContext *ctx, unsigned rt,
 
 /* Emit an unconditional branch to a direct target, which may or may not
    have already had nullification handled.  */
-static DisasJumpType do_dbranch(DisasContext *ctx, target_ulong dest,
+static DisasJumpType do_dbranch(DisasContext *ctx, target_ureg dest,
                                 unsigned link, bool is_n)
 {
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
@@ -1407,10 +1633,10 @@ static DisasJumpType do_dbranch(DisasContext *ctx, target_ulong dest,
 
 /* Emit a conditional branch to a direct target.  If the branch itself
    is nullified, we should have already used nullify_over.  */
-static DisasJumpType do_cbranch(DisasContext *ctx, target_long disp, bool is_n,
+static DisasJumpType do_cbranch(DisasContext *ctx, target_sreg disp, bool is_n,
                                 DisasCond *cond)
 {
-    target_ulong dest = iaoq_dest(ctx, disp);
+    target_ureg dest = iaoq_dest(ctx, disp);
     TCGLabel *taken = NULL;
     TCGCond c = cond->c;
     bool n;
@@ -1427,7 +1653,7 @@ static DisasJumpType do_cbranch(DisasContext *ctx, target_long disp, bool is_n,
 
     taken = gen_new_label();
     cond_prep(cond);
-    tcg_gen_brcond_tl(c, cond->a0, cond->a1, taken);
+    tcg_gen_brcond_reg(c, cond->a0, cond->a1, taken);
     cond_free(cond);
 
     /* Not taken: Condition not satisfied; nullify on backward branches. */
@@ -1468,10 +1694,10 @@ static DisasJumpType do_cbranch(DisasContext *ctx, target_long disp, bool is_n,
 
 /* Emit an unconditional branch to an indirect target.  This handles
    nullification of the branch itself.  */
-static DisasJumpType do_ibranch(DisasContext *ctx, TCGv dest,
+static DisasJumpType do_ibranch(DisasContext *ctx, TCGv_reg dest,
                                 unsigned link, bool is_n)
 {
-    TCGv a0, a1, next, tmp;
+    TCGv_reg a0, a1, next, tmp;
     TCGCond c;
 
     assert(ctx->null_lab == NULL);
@@ -1481,7 +1707,7 @@ static DisasJumpType do_ibranch(DisasContext *ctx, TCGv dest,
             copy_iaoq_entry(cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
         }
         next = get_temp(ctx);
-        tcg_gen_mov_tl(next, dest);
+        tcg_gen_mov_reg(next, dest);
         ctx->iaoq_n = -1;
         ctx->iaoq_n_var = next;
         if (is_n) {
@@ -1500,12 +1726,12 @@ static DisasJumpType do_ibranch(DisasContext *ctx, TCGv dest,
         /* We do have to handle the non-local temporary, DEST, before
            branching.  Since IOAQ_F is not really live at this point, we
            can simply store DEST optimistically.  Similarly with IAOQ_B.  */
-        tcg_gen_mov_tl(cpu_iaoq_f, dest);
-        tcg_gen_addi_tl(cpu_iaoq_b, dest, 4);
+        tcg_gen_mov_reg(cpu_iaoq_f, dest);
+        tcg_gen_addi_reg(cpu_iaoq_b, dest, 4);
 
         nullify_over(ctx);
         if (link != 0) {
-            tcg_gen_movi_tl(cpu_gr[link], ctx->iaoq_n);
+            tcg_gen_movi_reg(cpu_gr[link], ctx->iaoq_n);
         }
         tcg_gen_lookup_and_goto_ptr();
         return nullify_end(ctx, DISAS_NEXT);
@@ -1519,19 +1745,19 @@ static DisasJumpType do_ibranch(DisasContext *ctx, TCGv dest,
         next = get_temp(ctx);
 
         copy_iaoq_entry(tmp, ctx->iaoq_n, ctx->iaoq_n_var);
-        tcg_gen_movcond_tl(c, next, a0, a1, tmp, dest);
+        tcg_gen_movcond_reg(c, next, a0, a1, tmp, dest);
         ctx->iaoq_n = -1;
         ctx->iaoq_n_var = next;
 
         if (link != 0) {
-            tcg_gen_movcond_tl(c, cpu_gr[link], a0, a1, cpu_gr[link], tmp);
+            tcg_gen_movcond_reg(c, cpu_gr[link], a0, a1, cpu_gr[link], tmp);
         }
 
         if (is_n) {
             /* The branch nullifies the next insn, which means the state of N
                after the branch is the inverse of the state of N that applied
                to the branch.  */
-            tcg_gen_setcond_tl(tcg_invert_cond(c), cpu_psw_n, a0, a1);
+            tcg_gen_setcond_reg(tcg_invert_cond(c), cpu_psw_n, a0, a1);
             cond_free(&ctx->null_cond);
             ctx->null_cond = cond_make_n();
             ctx->psw_n_nonzero = true;
@@ -1560,7 +1786,7 @@ static DisasJumpType do_page_zero(DisasContext *ctx)
     case TCG_COND_NEVER:
         break;
     case TCG_COND_ALWAYS:
-        tcg_gen_movi_tl(cpu_psw_n, 0);
+        tcg_gen_movi_reg(cpu_psw_n, 0);
         goto do_sigill;
     default:
         /* Since this is always the first (and only) insn within the
@@ -1586,9 +1812,9 @@ static DisasJumpType do_page_zero(DisasContext *ctx)
         return DISAS_NORETURN;
 
     case 0xe0: /* SET_THREAD_POINTER */
-        tcg_gen_mov_tl(cpu_cr27, cpu_gr[26]);
-        tcg_gen_mov_tl(cpu_iaoq_f, cpu_gr[31]);
-        tcg_gen_addi_tl(cpu_iaoq_b, cpu_iaoq_f, 4);
+        tcg_gen_mov_reg(cpu_cr27, cpu_gr[26]);
+        tcg_gen_mov_reg(cpu_iaoq_f, cpu_gr[31]);
+        tcg_gen_addi_reg(cpu_iaoq_b, cpu_iaoq_f, 4);
         return DISAS_IAQ_N_UPDATED;
 
     case 0x100: /* SYSCALL */
@@ -1631,8 +1857,8 @@ static DisasJumpType trans_mfia(DisasContext *ctx, uint32_t insn,
                                 const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
-    TCGv tmp = dest_gpr(ctx, rt);
-    tcg_gen_movi_tl(tmp, ctx->iaoq_f);
+    TCGv_reg tmp = dest_gpr(ctx, rt);
+    tcg_gen_movi_reg(tmp, ctx->iaoq_f);
     save_gpr(ctx, rt, tmp);
 
     cond_free(&ctx->null_cond);
@@ -1643,10 +1869,10 @@ static DisasJumpType trans_mfsp(DisasContext *ctx, uint32_t insn,
                                 const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
-    TCGv tmp = dest_gpr(ctx, rt);
+    TCGv_reg tmp = dest_gpr(ctx, rt);
 
     /* ??? We don't implement space registers.  */
-    tcg_gen_movi_tl(tmp, 0);
+    tcg_gen_movi_reg(tmp, 0);
     save_gpr(ctx, rt, tmp);
 
     cond_free(&ctx->null_cond);
@@ -1658,7 +1884,7 @@ static DisasJumpType trans_mfctl(DisasContext *ctx, uint32_t insn,
 {
     unsigned rt = extract32(insn, 0, 5);
     unsigned ctl = extract32(insn, 21, 5);
-    TCGv tmp;
+    TCGv_reg tmp;
 
     switch (ctl) {
     case 11: /* SAR */
@@ -1666,7 +1892,7 @@ static DisasJumpType trans_mfctl(DisasContext *ctx, uint32_t insn,
         if (extract32(insn, 14, 1) == 0) {
             /* MFSAR without ,W masks low 5 bits.  */
             tmp = dest_gpr(ctx, rt);
-            tcg_gen_andi_tl(tmp, cpu_sar, 31);
+            tcg_gen_andi_reg(tmp, cpu_sar, 31);
             save_gpr(ctx, rt, tmp);
             break;
         }
@@ -1698,11 +1924,11 @@ static DisasJumpType trans_mtctl(DisasContext *ctx, uint32_t insn,
 {
     unsigned rin = extract32(insn, 16, 5);
     unsigned ctl = extract32(insn, 21, 5);
-    TCGv tmp;
+    TCGv_reg tmp;
 
     if (ctl == 11) { /* SAR */
         tmp = tcg_temp_new();
-        tcg_gen_andi_tl(tmp, load_gpr(ctx, rin), TARGET_LONG_BITS - 1);
+        tcg_gen_andi_reg(tmp, load_gpr(ctx, rin), TARGET_REGISTER_BITS - 1);
         save_or_nullify(ctx, cpu_sar, tmp);
         tcg_temp_free(tmp);
     } else {
@@ -1718,10 +1944,10 @@ static DisasJumpType trans_mtsarcm(DisasContext *ctx, uint32_t insn,
                                    const DisasInsn *di)
 {
     unsigned rin = extract32(insn, 16, 5);
-    TCGv tmp = tcg_temp_new();
+    TCGv_reg tmp = tcg_temp_new();
 
-    tcg_gen_not_tl(tmp, load_gpr(ctx, rin));
-    tcg_gen_andi_tl(tmp, tmp, TARGET_LONG_BITS - 1);
+    tcg_gen_not_reg(tmp, load_gpr(ctx, rin));
+    tcg_gen_andi_reg(tmp, tmp, TARGET_REGISTER_BITS - 1);
     save_or_nullify(ctx, cpu_sar, tmp);
     tcg_temp_free(tmp);
 
@@ -1733,10 +1959,10 @@ static DisasJumpType trans_ldsid(DisasContext *ctx, uint32_t insn,
                                  const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
-    TCGv dest = dest_gpr(ctx, rt);
+    TCGv_reg dest = dest_gpr(ctx, rt);
 
     /* Since we don't implement space registers, this returns zero.  */
-    tcg_gen_movi_tl(dest, 0);
+    tcg_gen_movi_reg(dest, 0);
     save_gpr(ctx, rt, dest);
 
     cond_free(&ctx->null_cond);
@@ -1761,12 +1987,12 @@ static DisasJumpType trans_base_idx_mod(DisasContext *ctx, uint32_t insn,
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rx = extract32(insn, 16, 5);
-    TCGv dest = dest_gpr(ctx, rb);
-    TCGv src1 = load_gpr(ctx, rb);
-    TCGv src2 = load_gpr(ctx, rx);
+    TCGv_reg dest = dest_gpr(ctx, rb);
+    TCGv_reg src1 = load_gpr(ctx, rb);
+    TCGv_reg src2 = load_gpr(ctx, rx);
 
     /* The only thing we need to do is the base register modification.  */
-    tcg_gen_add_tl(dest, src1, src2);
+    tcg_gen_add_reg(dest, src1, src2);
     save_gpr(ctx, rb, dest);
 
     cond_free(&ctx->null_cond);
@@ -1779,7 +2005,7 @@ static DisasJumpType trans_probe(DisasContext *ctx, uint32_t insn,
     unsigned rt = extract32(insn, 0, 5);
     unsigned rb = extract32(insn, 21, 5);
     unsigned is_write = extract32(insn, 6, 1);
-    TCGv dest;
+    TCGv_reg dest;
 
     nullify_over(ctx);
 
@@ -1821,7 +2047,7 @@ static DisasJumpType trans_add(DisasContext *ctx, uint32_t insn,
     unsigned ext = extract32(insn, 8, 4);
     unsigned shift = extract32(insn, 6, 2);
     unsigned rt = extract32(insn,  0, 5);
-    TCGv tcg_r1, tcg_r2;
+    TCGv_reg tcg_r1, tcg_r2;
     bool is_c = false;
     bool is_l = false;
     bool is_tc = false;
@@ -1864,7 +2090,7 @@ static DisasJumpType trans_sub(DisasContext *ctx, uint32_t insn,
     unsigned cf = extract32(insn, 12, 4);
     unsigned ext = extract32(insn, 6, 6);
     unsigned rt = extract32(insn,  0, 5);
-    TCGv tcg_r1, tcg_r2;
+    TCGv_reg tcg_r1, tcg_r2;
     bool is_b = false;
     bool is_tc = false;
     bool is_tsv = false;
@@ -1908,7 +2134,7 @@ static DisasJumpType trans_log(DisasContext *ctx, uint32_t insn,
     unsigned r1 = extract32(insn, 16, 5);
     unsigned cf = extract32(insn, 12, 4);
     unsigned rt = extract32(insn,  0, 5);
-    TCGv tcg_r1, tcg_r2;
+    TCGv_reg tcg_r1, tcg_r2;
     DisasJumpType ret;
 
     if (cf) {
@@ -1928,8 +2154,8 @@ static DisasJumpType trans_copy(DisasContext *ctx, uint32_t insn,
     unsigned rt = extract32(insn,  0, 5);
 
     if (r1 == 0) {
-        TCGv dest = dest_gpr(ctx, rt);
-        tcg_gen_movi_tl(dest, 0);
+        TCGv_reg dest = dest_gpr(ctx, rt);
+        tcg_gen_movi_reg(dest, 0);
         save_gpr(ctx, rt, dest);
     } else {
         save_gpr(ctx, rt, cpu_gr[r1]);
@@ -1945,7 +2171,7 @@ static DisasJumpType trans_cmpclr(DisasContext *ctx, uint32_t insn,
     unsigned r1 = extract32(insn, 16, 5);
     unsigned cf = extract32(insn, 12, 4);
     unsigned rt = extract32(insn,  0, 5);
-    TCGv tcg_r1, tcg_r2;
+    TCGv_reg tcg_r1, tcg_r2;
     DisasJumpType ret;
 
     if (cf) {
@@ -1964,7 +2190,7 @@ static DisasJumpType trans_uxor(DisasContext *ctx, uint32_t insn,
     unsigned r1 = extract32(insn, 16, 5);
     unsigned cf = extract32(insn, 12, 4);
     unsigned rt = extract32(insn,  0, 5);
-    TCGv tcg_r1, tcg_r2;
+    TCGv_reg tcg_r1, tcg_r2;
     DisasJumpType ret;
 
     if (cf) {
@@ -1972,7 +2198,7 @@ static DisasJumpType trans_uxor(DisasContext *ctx, uint32_t insn,
     }
     tcg_r1 = load_gpr(ctx, r1);
     tcg_r2 = load_gpr(ctx, r2);
-    ret = do_unit(ctx, rt, tcg_r1, tcg_r2, cf, false, tcg_gen_xor_tl);
+    ret = do_unit(ctx, rt, tcg_r1, tcg_r2, cf, false, tcg_gen_xor_reg);
     return nullify_end(ctx, ret);
 }
 
@@ -1984,7 +2210,7 @@ static DisasJumpType trans_uaddcm(DisasContext *ctx, uint32_t insn,
     unsigned cf = extract32(insn, 12, 4);
     unsigned is_tc = extract32(insn, 6, 1);
     unsigned rt = extract32(insn,  0, 5);
-    TCGv tcg_r1, tcg_r2, tmp;
+    TCGv_reg tcg_r1, tcg_r2, tmp;
     DisasJumpType ret;
 
     if (cf) {
@@ -1993,8 +2219,8 @@ static DisasJumpType trans_uaddcm(DisasContext *ctx, uint32_t insn,
     tcg_r1 = load_gpr(ctx, r1);
     tcg_r2 = load_gpr(ctx, r2);
     tmp = get_temp(ctx);
-    tcg_gen_not_tl(tmp, tcg_r2);
-    ret = do_unit(ctx, rt, tcg_r1, tmp, cf, is_tc, tcg_gen_add_tl);
+    tcg_gen_not_reg(tmp, tcg_r2);
+    ret = do_unit(ctx, rt, tcg_r1, tmp, cf, is_tc, tcg_gen_add_reg);
     return nullify_end(ctx, ret);
 }
 
@@ -2005,20 +2231,20 @@ static DisasJumpType trans_dcor(DisasContext *ctx, uint32_t insn,
     unsigned cf = extract32(insn, 12, 4);
     unsigned is_i = extract32(insn, 6, 1);
     unsigned rt = extract32(insn,  0, 5);
-    TCGv tmp;
+    TCGv_reg tmp;
     DisasJumpType ret;
 
     nullify_over(ctx);
 
     tmp = get_temp(ctx);
-    tcg_gen_shri_tl(tmp, cpu_psw_cb, 3);
+    tcg_gen_shri_reg(tmp, cpu_psw_cb, 3);
     if (!is_i) {
-        tcg_gen_not_tl(tmp, tmp);
+        tcg_gen_not_reg(tmp, tmp);
     }
-    tcg_gen_andi_tl(tmp, tmp, 0x11111111);
-    tcg_gen_muli_tl(tmp, tmp, 6);
+    tcg_gen_andi_reg(tmp, tmp, 0x11111111);
+    tcg_gen_muli_reg(tmp, tmp, 6);
     ret = do_unit(ctx, rt, tmp, load_gpr(ctx, r2), cf, false,
-                  is_i ? tcg_gen_add_tl : tcg_gen_sub_tl);
+                  is_i ? tcg_gen_add_reg : tcg_gen_sub_reg);
 
     return nullify_end(ctx, ret);
 }
@@ -2030,7 +2256,7 @@ static DisasJumpType trans_ds(DisasContext *ctx, uint32_t insn,
     unsigned r1 = extract32(insn, 16, 5);
     unsigned cf = extract32(insn, 12, 4);
     unsigned rt = extract32(insn,  0, 5);
-    TCGv dest, add1, add2, addc, zero, in1, in2;
+    TCGv_reg dest, add1, add2, addc, zero, in1, in2;
 
     nullify_over(ctx);
 
@@ -2041,19 +2267,19 @@ static DisasJumpType trans_ds(DisasContext *ctx, uint32_t insn,
     add2 = tcg_temp_new();
     addc = tcg_temp_new();
     dest = tcg_temp_new();
-    zero = tcg_const_tl(0);
+    zero = tcg_const_reg(0);
 
     /* Form R1 << 1 | PSW[CB]{8}.  */
-    tcg_gen_add_tl(add1, in1, in1);
-    tcg_gen_add_tl(add1, add1, cpu_psw_cb_msb);
+    tcg_gen_add_reg(add1, in1, in1);
+    tcg_gen_add_reg(add1, add1, cpu_psw_cb_msb);
 
     /* Add or subtract R2, depending on PSW[V].  Proper computation of
        carry{8} requires that we subtract via + ~R2 + 1, as described in
        the manual.  By extracting and masking V, we can produce the
        proper inputs to the addition without movcond.  */
-    tcg_gen_sari_tl(addc, cpu_psw_v, TARGET_LONG_BITS - 1);
-    tcg_gen_xor_tl(add2, in2, addc);
-    tcg_gen_andi_tl(addc, addc, 1);
+    tcg_gen_sari_reg(addc, cpu_psw_v, TARGET_REGISTER_BITS - 1);
+    tcg_gen_xor_reg(add2, in2, addc);
+    tcg_gen_andi_reg(addc, addc, 1);
     /* ??? This is only correct for 32-bit.  */
     tcg_gen_add2_i32(dest, cpu_psw_cb_msb, add1, zero, add2, zero);
     tcg_gen_add2_i32(dest, cpu_psw_cb_msb, dest, cpu_psw_cb_msb, addc, zero);
@@ -2065,16 +2291,16 @@ static DisasJumpType trans_ds(DisasContext *ctx, uint32_t insn,
     save_gpr(ctx, rt, dest);
 
     /* Write back PSW[CB].  */
-    tcg_gen_xor_tl(cpu_psw_cb, add1, add2);
-    tcg_gen_xor_tl(cpu_psw_cb, cpu_psw_cb, dest);
+    tcg_gen_xor_reg(cpu_psw_cb, add1, add2);
+    tcg_gen_xor_reg(cpu_psw_cb, cpu_psw_cb, dest);
 
     /* Write back PSW[V] for the division step.  */
-    tcg_gen_neg_tl(cpu_psw_v, cpu_psw_cb_msb);
-    tcg_gen_xor_tl(cpu_psw_v, cpu_psw_v, in2);
+    tcg_gen_neg_reg(cpu_psw_v, cpu_psw_cb_msb);
+    tcg_gen_xor_reg(cpu_psw_v, cpu_psw_v, in2);
 
     /* Install the new nullification.  */
     if (cf) {
-        TCGv sv = NULL;
+        TCGv_reg sv = NULL;
         if (cf >> 1 == 6) {
             /* ??? The lshift is supposed to contribute to overflow.  */
             sv = do_add_sv(ctx, dest, add1, add2);
@@ -2092,10 +2318,10 @@ static DisasJumpType trans_ds(DisasContext *ctx, uint32_t insn,
 static const DisasInsn table_arith_log[] = {
     { 0x08000240u, 0xfc00ffffu, trans_nop },  /* or x,y,0 */
     { 0x08000240u, 0xffe0ffe0u, trans_copy }, /* or x,0,t */
-    { 0x08000000u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_andc_tl },
-    { 0x08000200u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_and_tl },
-    { 0x08000240u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_or_tl },
-    { 0x08000280u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_xor_tl },
+    { 0x08000000u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_andc_reg },
+    { 0x08000200u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_and_reg },
+    { 0x08000240u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_or_reg },
+    { 0x08000280u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_xor_reg },
     { 0x08000880u, 0xfc000fe0u, trans_cmpclr },
     { 0x08000380u, 0xfc000fe0u, trans_uxor },
     { 0x08000980u, 0xfc000fa0u, trans_uaddcm },
@@ -2109,13 +2335,13 @@ static const DisasInsn table_arith_log[] = {
 
 static DisasJumpType trans_addi(DisasContext *ctx, uint32_t insn)
 {
-    target_long im = low_sextract(insn, 0, 11);
+    target_sreg im = low_sextract(insn, 0, 11);
     unsigned e1 = extract32(insn, 11, 1);
     unsigned cf = extract32(insn, 12, 4);
     unsigned rt = extract32(insn, 16, 5);
     unsigned r2 = extract32(insn, 21, 5);
     unsigned o1 = extract32(insn, 26, 1);
-    TCGv tcg_im, tcg_r2;
+    TCGv_reg tcg_im, tcg_r2;
     DisasJumpType ret;
 
     if (cf) {
@@ -2131,12 +2357,12 @@ static DisasJumpType trans_addi(DisasContext *ctx, uint32_t insn)
 
 static DisasJumpType trans_subi(DisasContext *ctx, uint32_t insn)
 {
-    target_long im = low_sextract(insn, 0, 11);
+    target_sreg im = low_sextract(insn, 0, 11);
     unsigned e1 = extract32(insn, 11, 1);
     unsigned cf = extract32(insn, 12, 4);
     unsigned rt = extract32(insn, 16, 5);
     unsigned r2 = extract32(insn, 21, 5);
-    TCGv tcg_im, tcg_r2;
+    TCGv_reg tcg_im, tcg_r2;
     DisasJumpType ret;
 
     if (cf) {
@@ -2152,11 +2378,11 @@ static DisasJumpType trans_subi(DisasContext *ctx, uint32_t insn)
 
 static DisasJumpType trans_cmpiclr(DisasContext *ctx, uint32_t insn)
 {
-    target_long im = low_sextract(insn, 0, 11);
+    target_sreg im = low_sextract(insn, 0, 11);
     unsigned cf = extract32(insn, 12, 4);
     unsigned rt = extract32(insn, 16, 5);
     unsigned r2 = extract32(insn, 21, 5);
-    TCGv tcg_im, tcg_r2;
+    TCGv_reg tcg_im, tcg_r2;
     DisasJumpType ret;
 
     if (cf) {
@@ -2224,7 +2450,7 @@ static DisasJumpType trans_ldcw(DisasContext *ctx, uint32_t insn,
     unsigned rx = extract32(insn, 16, 5);
     unsigned rb = extract32(insn, 21, 5);
     TCGMemOp mop = MO_TEUL | MO_ALIGN_16;
-    TCGv zero, addr, base, dest;
+    TCGv_reg zero, addr, base, dest;
     int modify, disp = 0, scale = 0;
 
     nullify_over(ctx);
@@ -2252,15 +2478,15 @@ static DisasJumpType trans_ldcw(DisasContext *ctx, uint32_t insn,
     addr = tcg_temp_new();
     base = load_gpr(ctx, rb);
     if (rx) {
-        tcg_gen_shli_tl(addr, cpu_gr[rx], scale);
-        tcg_gen_add_tl(addr, addr, base);
+        tcg_gen_shli_reg(addr, cpu_gr[rx], scale);
+        tcg_gen_add_reg(addr, addr, base);
     } else {
-        tcg_gen_addi_tl(addr, base, disp);
+        tcg_gen_addi_reg(addr, base, disp);
     }
 
-    zero = tcg_const_tl(0);
-    tcg_gen_atomic_xchg_tl(dest, (modify <= 0 ? addr : base),
-                           zero, MMU_USER_IDX, mop);
+    zero = tcg_const_reg(0);
+    tcg_gen_atomic_xchg_reg(dest, (modify <= 0 ? addr : base),
+                            zero, MMU_USER_IDX, mop);
     if (modify) {
         save_gpr(ctx, rb, addr);
     }
@@ -2272,20 +2498,20 @@ static DisasJumpType trans_ldcw(DisasContext *ctx, uint32_t insn,
 static DisasJumpType trans_stby(DisasContext *ctx, uint32_t insn,
                                 const DisasInsn *di)
 {
-    target_long disp = low_sextract(insn, 0, 5);
+    target_sreg disp = low_sextract(insn, 0, 5);
     unsigned m = extract32(insn, 5, 1);
     unsigned a = extract32(insn, 13, 1);
     unsigned rt = extract32(insn, 16, 5);
     unsigned rb = extract32(insn, 21, 5);
-    TCGv addr, val;
+    TCGv_reg addr, val;
 
     nullify_over(ctx);
 
     addr = tcg_temp_new();
     if (m || disp == 0) {
-        tcg_gen_mov_tl(addr, load_gpr(ctx, rb));
+        tcg_gen_mov_reg(addr, load_gpr(ctx, rb));
     } else {
-        tcg_gen_addi_tl(addr, load_gpr(ctx, rb), disp);
+        tcg_gen_addi_reg(addr, load_gpr(ctx, rb), disp);
     }
     val = load_gpr(ctx, rt);
 
@@ -2304,8 +2530,8 @@ static DisasJumpType trans_stby(DisasContext *ctx, uint32_t insn,
     }
 
     if (m) {
-        tcg_gen_addi_tl(addr, addr, disp);
-        tcg_gen_andi_tl(addr, addr, ~3);
+        tcg_gen_addi_reg(addr, addr, disp);
+        tcg_gen_andi_reg(addr, addr, ~3);
         save_gpr(ctx, rb, addr);
     }
     tcg_temp_free(addr);
@@ -2324,10 +2550,10 @@ static const DisasInsn table_index_mem[] = {
 static DisasJumpType trans_ldil(DisasContext *ctx, uint32_t insn)
 {
     unsigned rt = extract32(insn, 21, 5);
-    target_long i = assemble_21(insn);
-    TCGv tcg_rt = dest_gpr(ctx, rt);
+    target_sreg i = assemble_21(insn);
+    TCGv_reg tcg_rt = dest_gpr(ctx, rt);
 
-    tcg_gen_movi_tl(tcg_rt, i);
+    tcg_gen_movi_reg(tcg_rt, i);
     save_gpr(ctx, rt, tcg_rt);
     cond_free(&ctx->null_cond);
 
@@ -2337,11 +2563,11 @@ static DisasJumpType trans_ldil(DisasContext *ctx, uint32_t insn)
 static DisasJumpType trans_addil(DisasContext *ctx, uint32_t insn)
 {
     unsigned rt = extract32(insn, 21, 5);
-    target_long i = assemble_21(insn);
-    TCGv tcg_rt = load_gpr(ctx, rt);
-    TCGv tcg_r1 = dest_gpr(ctx, 1);
+    target_sreg i = assemble_21(insn);
+    TCGv_reg tcg_rt = load_gpr(ctx, rt);
+    TCGv_reg tcg_r1 = dest_gpr(ctx, 1);
 
-    tcg_gen_addi_tl(tcg_r1, tcg_rt, i);
+    tcg_gen_addi_reg(tcg_r1, tcg_rt, i);
     save_gpr(ctx, 1, tcg_r1);
     cond_free(&ctx->null_cond);
 
@@ -2352,15 +2578,15 @@ static DisasJumpType trans_ldo(DisasContext *ctx, uint32_t insn)
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = extract32(insn, 16, 5);
-    target_long i = assemble_16(insn);
-    TCGv tcg_rt = dest_gpr(ctx, rt);
+    target_sreg i = assemble_16(insn);
+    TCGv_reg tcg_rt = dest_gpr(ctx, rt);
 
     /* Special case rb == 0, for the LDI pseudo-op.
        The COPY pseudo-op is handled for free within tcg_gen_addi_tl.  */
     if (rb == 0) {
-        tcg_gen_movi_tl(tcg_rt, i);
+        tcg_gen_movi_reg(tcg_rt, i);
     } else {
-        tcg_gen_addi_tl(tcg_rt, cpu_gr[rb], i);
+        tcg_gen_addi_reg(tcg_rt, cpu_gr[rb], i);
     }
     save_gpr(ctx, rt, tcg_rt);
     cond_free(&ctx->null_cond);
@@ -2373,7 +2599,7 @@ static DisasJumpType trans_load(DisasContext *ctx, uint32_t insn,
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = extract32(insn, 16, 5);
-    target_long i = assemble_16(insn);
+    target_sreg i = assemble_16(insn);
 
     return do_load(ctx, rt, rb, 0, 0, i, is_mod ? (i < 0 ? -1 : 1) : 0, mop);
 }
@@ -2382,7 +2608,7 @@ static DisasJumpType trans_load_w(DisasContext *ctx, uint32_t insn)
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = extract32(insn, 16, 5);
-    target_long i = assemble_16a(insn);
+    target_sreg i = assemble_16a(insn);
     unsigned ext2 = extract32(insn, 1, 2);
 
     switch (ext2) {
@@ -2401,7 +2627,7 @@ static DisasJumpType trans_load_w(DisasContext *ctx, uint32_t insn)
 
 static DisasJumpType trans_fload_mod(DisasContext *ctx, uint32_t insn)
 {
-    target_long i = assemble_16a(insn);
+    target_sreg i = assemble_16a(insn);
     unsigned t1 = extract32(insn, 1, 1);
     unsigned a = extract32(insn, 2, 1);
     unsigned t0 = extract32(insn, 16, 5);
@@ -2416,7 +2642,7 @@ static DisasJumpType trans_store(DisasContext *ctx, uint32_t insn,
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = extract32(insn, 16, 5);
-    target_long i = assemble_16(insn);
+    target_sreg i = assemble_16(insn);
 
     return do_store(ctx, rt, rb, i, is_mod ? (i < 0 ? -1 : 1) : 0, mop);
 }
@@ -2425,7 +2651,7 @@ static DisasJumpType trans_store_w(DisasContext *ctx, uint32_t insn)
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = extract32(insn, 16, 5);
-    target_long i = assemble_16a(insn);
+    target_sreg i = assemble_16a(insn);
     unsigned ext2 = extract32(insn, 1, 2);
 
     switch (ext2) {
@@ -2443,7 +2669,7 @@ static DisasJumpType trans_store_w(DisasContext *ctx, uint32_t insn)
 
 static DisasJumpType trans_fstore_mod(DisasContext *ctx, uint32_t insn)
 {
-    target_long i = assemble_16a(insn);
+    target_sreg i = assemble_16a(insn);
     unsigned t1 = extract32(insn, 1, 1);
     unsigned a = extract32(insn, 2, 1);
     unsigned t0 = extract32(insn, 16, 5);
@@ -2525,12 +2751,12 @@ static DisasJumpType trans_copr_dw(DisasContext *ctx, uint32_t insn)
 static DisasJumpType trans_cmpb(DisasContext *ctx, uint32_t insn,
                                 bool is_true, bool is_imm, bool is_dw)
 {
-    target_long disp = assemble_12(insn) * 4;
+    target_sreg disp = assemble_12(insn) * 4;
     unsigned n = extract32(insn, 1, 1);
     unsigned c = extract32(insn, 13, 3);
     unsigned r = extract32(insn, 21, 5);
     unsigned cf = c * 2 + !is_true;
-    TCGv dest, in1, in2, sv;
+    TCGv_reg dest, in1, in2, sv;
     DisasCond cond;
 
     nullify_over(ctx);
@@ -2543,7 +2769,7 @@ static DisasJumpType trans_cmpb(DisasContext *ctx, uint32_t insn,
     in2 = load_gpr(ctx, r);
     dest = get_temp(ctx);
 
-    tcg_gen_sub_tl(dest, in1, in2);
+    tcg_gen_sub_reg(dest, in1, in2);
 
     sv = NULL;
     if (c == 6) {
@@ -2557,12 +2783,12 @@ static DisasJumpType trans_cmpb(DisasContext *ctx, uint32_t insn,
 static DisasJumpType trans_addb(DisasContext *ctx, uint32_t insn,
                                 bool is_true, bool is_imm)
 {
-    target_long disp = assemble_12(insn) * 4;
+    target_sreg disp = assemble_12(insn) * 4;
     unsigned n = extract32(insn, 1, 1);
     unsigned c = extract32(insn, 13, 3);
     unsigned r = extract32(insn, 21, 5);
     unsigned cf = c * 2 + !is_true;
-    TCGv dest, in1, in2, sv, cb_msb;
+    TCGv_reg dest, in1, in2, sv, cb_msb;
     DisasCond cond;
 
     nullify_over(ctx);
@@ -2579,15 +2805,15 @@ static DisasJumpType trans_addb(DisasContext *ctx, uint32_t insn,
 
     switch (c) {
     default:
-        tcg_gen_add_tl(dest, in1, in2);
+        tcg_gen_add_reg(dest, in1, in2);
         break;
     case 4: case 5:
         cb_msb = get_temp(ctx);
-        tcg_gen_movi_tl(cb_msb, 0);
-        tcg_gen_add2_tl(dest, cb_msb, in1, cb_msb, in2, cb_msb);
+        tcg_gen_movi_reg(cb_msb, 0);
+        tcg_gen_add2_reg(dest, cb_msb, in1, cb_msb, in2, cb_msb);
         break;
     case 6:
-        tcg_gen_add_tl(dest, in1, in2);
+        tcg_gen_add_reg(dest, in1, in2);
         sv = do_add_sv(ctx, dest, in1, in2);
         break;
     }
@@ -2598,13 +2824,13 @@ static DisasJumpType trans_addb(DisasContext *ctx, uint32_t insn,
 
 static DisasJumpType trans_bb(DisasContext *ctx, uint32_t insn)
 {
-    target_long disp = assemble_12(insn) * 4;
+    target_sreg disp = assemble_12(insn) * 4;
     unsigned n = extract32(insn, 1, 1);
     unsigned c = extract32(insn, 15, 1);
     unsigned r = extract32(insn, 16, 5);
     unsigned p = extract32(insn, 21, 5);
     unsigned i = extract32(insn, 26, 1);
-    TCGv tmp, tcg_r;
+    TCGv_reg tmp, tcg_r;
     DisasCond cond;
 
     nullify_over(ctx);
@@ -2612,9 +2838,9 @@ static DisasJumpType trans_bb(DisasContext *ctx, uint32_t insn)
     tmp = tcg_temp_new();
     tcg_r = load_gpr(ctx, r);
     if (i) {
-        tcg_gen_shli_tl(tmp, tcg_r, p);
+        tcg_gen_shli_reg(tmp, tcg_r, p);
     } else {
-        tcg_gen_shl_tl(tmp, tcg_r, cpu_sar);
+        tcg_gen_shl_reg(tmp, tcg_r, cpu_sar);
     }
 
     cond = cond_make_0(c ? TCG_COND_GE : TCG_COND_LT, tmp);
@@ -2624,23 +2850,23 @@ static DisasJumpType trans_bb(DisasContext *ctx, uint32_t insn)
 
 static DisasJumpType trans_movb(DisasContext *ctx, uint32_t insn, bool is_imm)
 {
-    target_long disp = assemble_12(insn) * 4;
+    target_sreg disp = assemble_12(insn) * 4;
     unsigned n = extract32(insn, 1, 1);
     unsigned c = extract32(insn, 13, 3);
     unsigned t = extract32(insn, 16, 5);
     unsigned r = extract32(insn, 21, 5);
-    TCGv dest;
+    TCGv_reg dest;
     DisasCond cond;
 
     nullify_over(ctx);
 
     dest = dest_gpr(ctx, r);
     if (is_imm) {
-        tcg_gen_movi_tl(dest, low_sextract(t, 0, 5));
+        tcg_gen_movi_reg(dest, low_sextract(t, 0, 5));
     } else if (t == 0) {
-        tcg_gen_movi_tl(dest, 0);
+        tcg_gen_movi_reg(dest, 0);
     } else {
-        tcg_gen_mov_tl(dest, cpu_gr[t]);
+        tcg_gen_mov_reg(dest, cpu_gr[t]);
     }
 
     cond = do_sed_cond(c, dest);
@@ -2654,7 +2880,7 @@ static DisasJumpType trans_shrpw_sar(DisasContext *ctx, uint32_t insn,
     unsigned c = extract32(insn, 13, 3);
     unsigned r1 = extract32(insn, 16, 5);
     unsigned r2 = extract32(insn, 21, 5);
-    TCGv dest;
+    TCGv_reg dest;
 
     if (c) {
         nullify_over(ctx);
@@ -2662,22 +2888,22 @@ static DisasJumpType trans_shrpw_sar(DisasContext *ctx, uint32_t insn,
 
     dest = dest_gpr(ctx, rt);
     if (r1 == 0) {
-        tcg_gen_ext32u_tl(dest, load_gpr(ctx, r2));
-        tcg_gen_shr_tl(dest, dest, cpu_sar);
+        tcg_gen_ext32u_reg(dest, load_gpr(ctx, r2));
+        tcg_gen_shr_reg(dest, dest, cpu_sar);
     } else if (r1 == r2) {
         TCGv_i32 t32 = tcg_temp_new_i32();
-        tcg_gen_trunc_tl_i32(t32, load_gpr(ctx, r2));
+        tcg_gen_trunc_reg_i32(t32, load_gpr(ctx, r2));
         tcg_gen_rotr_i32(t32, t32, cpu_sar);
-        tcg_gen_extu_i32_tl(dest, t32);
+        tcg_gen_extu_i32_reg(dest, t32);
         tcg_temp_free_i32(t32);
     } else {
         TCGv_i64 t = tcg_temp_new_i64();
         TCGv_i64 s = tcg_temp_new_i64();
 
-        tcg_gen_concat_tl_i64(t, load_gpr(ctx, r2), load_gpr(ctx, r1));
-        tcg_gen_extu_tl_i64(s, cpu_sar);
+        tcg_gen_concat_reg_i64(t, load_gpr(ctx, r2), load_gpr(ctx, r1));
+        tcg_gen_extu_reg_i64(s, cpu_sar);
         tcg_gen_shr_i64(t, t, s);
-        tcg_gen_trunc_i64_tl(dest, t);
+        tcg_gen_trunc_i64_reg(dest, t);
 
         tcg_temp_free_i64(t);
         tcg_temp_free_i64(s);
@@ -2701,7 +2927,7 @@ static DisasJumpType trans_shrpw_imm(DisasContext *ctx, uint32_t insn,
     unsigned r1 = extract32(insn, 16, 5);
     unsigned r2 = extract32(insn, 21, 5);
     unsigned sa = 31 - cpos;
-    TCGv dest, t2;
+    TCGv_reg dest, t2;
 
     if (c) {
         nullify_over(ctx);
@@ -2711,16 +2937,16 @@ static DisasJumpType trans_shrpw_imm(DisasContext *ctx, uint32_t insn,
     t2 = load_gpr(ctx, r2);
     if (r1 == r2) {
         TCGv_i32 t32 = tcg_temp_new_i32();
-        tcg_gen_trunc_tl_i32(t32, t2);
+        tcg_gen_trunc_reg_i32(t32, t2);
         tcg_gen_rotri_i32(t32, t32, sa);
-        tcg_gen_extu_i32_tl(dest, t32);
+        tcg_gen_extu_i32_reg(dest, t32);
         tcg_temp_free_i32(t32);
     } else if (r1 == 0) {
-        tcg_gen_extract_tl(dest, t2, sa, 32 - sa);
+        tcg_gen_extract_reg(dest, t2, sa, 32 - sa);
     } else {
-        TCGv t0 = tcg_temp_new();
-        tcg_gen_extract_tl(t0, t2, sa, 32 - sa);
-        tcg_gen_deposit_tl(dest, t0, cpu_gr[r1], 32 - sa, sa);
+        TCGv_reg t0 = tcg_temp_new();
+        tcg_gen_extract_reg(t0, t2, sa, 32 - sa);
+        tcg_gen_deposit_reg(dest, t0, cpu_gr[r1], 32 - sa, sa);
         tcg_temp_free(t0);
     }
     save_gpr(ctx, rt, dest);
@@ -2742,7 +2968,7 @@ static DisasJumpType trans_extrw_sar(DisasContext *ctx, uint32_t insn,
     unsigned rt = extract32(insn, 16, 5);
     unsigned rr = extract32(insn, 21, 5);
     unsigned len = 32 - clen;
-    TCGv dest, src, tmp;
+    TCGv_reg dest, src, tmp;
 
     if (c) {
         nullify_over(ctx);
@@ -2753,13 +2979,13 @@ static DisasJumpType trans_extrw_sar(DisasContext *ctx, uint32_t insn,
     tmp = tcg_temp_new();
 
     /* Recall that SAR is using big-endian bit numbering.  */
-    tcg_gen_xori_tl(tmp, cpu_sar, TARGET_LONG_BITS - 1);
+    tcg_gen_xori_reg(tmp, cpu_sar, TARGET_REGISTER_BITS - 1);
     if (is_se) {
-        tcg_gen_sar_tl(dest, src, tmp);
-        tcg_gen_sextract_tl(dest, dest, 0, len);
+        tcg_gen_sar_reg(dest, src, tmp);
+        tcg_gen_sextract_reg(dest, dest, 0, len);
     } else {
-        tcg_gen_shr_tl(dest, src, tmp);
-        tcg_gen_extract_tl(dest, dest, 0, len);
+        tcg_gen_shr_reg(dest, src, tmp);
+        tcg_gen_extract_reg(dest, dest, 0, len);
     }
     tcg_temp_free(tmp);
     save_gpr(ctx, rt, dest);
@@ -2783,7 +3009,7 @@ static DisasJumpType trans_extrw_imm(DisasContext *ctx, uint32_t insn,
     unsigned rr = extract32(insn, 21, 5);
     unsigned len = 32 - clen;
     unsigned cpos = 31 - pos;
-    TCGv dest, src;
+    TCGv_reg dest, src;
 
     if (c) {
         nullify_over(ctx);
@@ -2792,9 +3018,9 @@ static DisasJumpType trans_extrw_imm(DisasContext *ctx, uint32_t insn,
     dest = dest_gpr(ctx, rt);
     src = load_gpr(ctx, rr);
     if (is_se) {
-        tcg_gen_sextract_tl(dest, src, cpos, len);
+        tcg_gen_sextract_reg(dest, src, cpos, len);
     } else {
-        tcg_gen_extract_tl(dest, src, cpos, len);
+        tcg_gen_extract_reg(dest, src, cpos, len);
     }
     save_gpr(ctx, rt, dest);
 
@@ -2820,11 +3046,11 @@ static DisasJumpType trans_depw_imm_c(DisasContext *ctx, uint32_t insn,
     unsigned cpos = extract32(insn, 5, 5);
     unsigned nz = extract32(insn, 10, 1);
     unsigned c = extract32(insn, 13, 3);
-    target_long val = low_sextract(insn, 16, 5);
+    target_sreg val = low_sextract(insn, 16, 5);
     unsigned rt = extract32(insn, 21, 5);
     unsigned len = 32 - clen;
-    target_long mask0, mask1;
-    TCGv dest;
+    target_sreg mask0, mask1;
+    TCGv_reg dest;
 
     if (c) {
         nullify_over(ctx);
@@ -2838,14 +3064,14 @@ static DisasJumpType trans_depw_imm_c(DisasContext *ctx, uint32_t insn,
     mask1 = deposit64(-1, cpos, len, val);
 
     if (nz) {
-        TCGv src = load_gpr(ctx, rt);
+        TCGv_reg src = load_gpr(ctx, rt);
         if (mask1 != -1) {
-            tcg_gen_andi_tl(dest, src, mask1);
+            tcg_gen_andi_reg(dest, src, mask1);
             src = dest;
         }
-        tcg_gen_ori_tl(dest, src, mask0);
+        tcg_gen_ori_reg(dest, src, mask0);
     } else {
-        tcg_gen_movi_tl(dest, mask0);
+        tcg_gen_movi_reg(dest, mask0);
     }
     save_gpr(ctx, rt, dest);
 
@@ -2868,7 +3094,7 @@ static DisasJumpType trans_depw_imm(DisasContext *ctx, uint32_t insn,
     unsigned rt = extract32(insn, 21, 5);
     unsigned rs = nz ? rt : 0;
     unsigned len = 32 - clen;
-    TCGv dest, val;
+    TCGv_reg dest, val;
 
     if (c) {
         nullify_over(ctx);
@@ -2880,9 +3106,9 @@ static DisasJumpType trans_depw_imm(DisasContext *ctx, uint32_t insn,
     dest = dest_gpr(ctx, rt);
     val = load_gpr(ctx, rr);
     if (rs == 0) {
-        tcg_gen_deposit_z_tl(dest, val, cpos, len);
+        tcg_gen_deposit_z_reg(dest, val, cpos, len);
     } else {
-        tcg_gen_deposit_tl(dest, cpu_gr[rs], val, cpos, len);
+        tcg_gen_deposit_reg(dest, cpu_gr[rs], val, cpos, len);
     }
     save_gpr(ctx, rt, dest);
 
@@ -2904,7 +3130,7 @@ static DisasJumpType trans_depw_sar(DisasContext *ctx, uint32_t insn,
     unsigned rt = extract32(insn, 21, 5);
     unsigned rs = nz ? rt : 0;
     unsigned len = 32 - clen;
-    TCGv val, mask, tmp, shift, dest;
+    TCGv_reg val, mask, tmp, shift, dest;
     unsigned msb = 1U << (len - 1);
 
     if (c) {
@@ -2921,17 +3147,17 @@ static DisasJumpType trans_depw_sar(DisasContext *ctx, uint32_t insn,
     tmp = tcg_temp_new();
 
     /* Convert big-endian bit numbering in SAR to left-shift.  */
-    tcg_gen_xori_tl(shift, cpu_sar, TARGET_LONG_BITS - 1);
+    tcg_gen_xori_reg(shift, cpu_sar, TARGET_REGISTER_BITS - 1);
 
-    mask = tcg_const_tl(msb + (msb - 1));
-    tcg_gen_and_tl(tmp, val, mask);
+    mask = tcg_const_reg(msb + (msb - 1));
+    tcg_gen_and_reg(tmp, val, mask);
     if (rs) {
-        tcg_gen_shl_tl(mask, mask, shift);
-        tcg_gen_shl_tl(tmp, tmp, shift);
-        tcg_gen_andc_tl(dest, cpu_gr[rs], mask);
-        tcg_gen_or_tl(dest, dest, tmp);
+        tcg_gen_shl_reg(mask, mask, shift);
+        tcg_gen_shl_reg(tmp, tmp, shift);
+        tcg_gen_andc_reg(dest, cpu_gr[rs], mask);
+        tcg_gen_or_reg(dest, dest, tmp);
     } else {
-        tcg_gen_shl_tl(dest, tmp, shift);
+        tcg_gen_shl_reg(dest, tmp, shift);
     }
     tcg_temp_free(shift);
     tcg_temp_free(mask);
@@ -2956,7 +3182,7 @@ static DisasJumpType trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
 {
     unsigned n = extract32(insn, 1, 1);
     unsigned b = extract32(insn, 21, 5);
-    target_long disp = assemble_17(insn);
+    target_sreg disp = assemble_17(insn);
 
     /* unsigned s = low_uextract(insn, 13, 3); */
     /* ??? It seems like there should be a good way of using
@@ -2971,8 +3197,8 @@ static DisasJumpType trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
     if (b == 0) {
         return do_dbranch(ctx, disp, is_l ? 31 : 0, n);
     } else {
-        TCGv tmp = get_temp(ctx);
-        tcg_gen_addi_tl(tmp, load_gpr(ctx, b), disp);
+        TCGv_reg tmp = get_temp(ctx);
+        tcg_gen_addi_reg(tmp, load_gpr(ctx, b), disp);
         return do_ibranch(ctx, tmp, is_l ? 31 : 0, n);
     }
 }
@@ -2982,7 +3208,7 @@ static DisasJumpType trans_bl(DisasContext *ctx, uint32_t insn,
 {
     unsigned n = extract32(insn, 1, 1);
     unsigned link = extract32(insn, 21, 5);
-    target_long disp = assemble_17(insn);
+    target_sreg disp = assemble_17(insn);
 
     return do_dbranch(ctx, iaoq_dest(ctx, disp), link, n);
 }
@@ -2991,7 +3217,7 @@ static DisasJumpType trans_bl_long(DisasContext *ctx, uint32_t insn,
                                    const DisasInsn *di)
 {
     unsigned n = extract32(insn, 1, 1);
-    target_long disp = assemble_22(insn);
+    target_sreg disp = assemble_22(insn);
 
     return do_dbranch(ctx, iaoq_dest(ctx, disp), 2, n);
 }
@@ -3002,10 +3228,10 @@ static DisasJumpType trans_blr(DisasContext *ctx, uint32_t insn,
     unsigned n = extract32(insn, 1, 1);
     unsigned rx = extract32(insn, 16, 5);
     unsigned link = extract32(insn, 21, 5);
-    TCGv tmp = get_temp(ctx);
+    TCGv_reg tmp = get_temp(ctx);
 
-    tcg_gen_shli_tl(tmp, load_gpr(ctx, rx), 3);
-    tcg_gen_addi_tl(tmp, tmp, ctx->iaoq_f + 8);
+    tcg_gen_shli_reg(tmp, load_gpr(ctx, rx), 3);
+    tcg_gen_addi_reg(tmp, tmp, ctx->iaoq_f + 8);
     return do_ibranch(ctx, tmp, link, n);
 }
 
@@ -3015,14 +3241,14 @@ static DisasJumpType trans_bv(DisasContext *ctx, uint32_t insn,
     unsigned n = extract32(insn, 1, 1);
     unsigned rx = extract32(insn, 16, 5);
     unsigned rb = extract32(insn, 21, 5);
-    TCGv dest;
+    TCGv_reg dest;
 
     if (rx == 0) {
         dest = load_gpr(ctx, rb);
     } else {
         dest = get_temp(ctx);
-        tcg_gen_shli_tl(dest, load_gpr(ctx, rx), 3);
-        tcg_gen_add_tl(dest, dest, load_gpr(ctx, rb));
+        tcg_gen_shli_reg(dest, load_gpr(ctx, rx), 3);
+        tcg_gen_add_reg(dest, dest, load_gpr(ctx, rb));
     }
     return do_ibranch(ctx, dest, 0, n);
 }
@@ -3242,13 +3468,13 @@ static DisasJumpType trans_ftest_t(DisasContext *ctx, uint32_t insn,
 {
     unsigned y = extract32(insn, 13, 3);
     unsigned cbit = (y ^ 1) - 1;
-    TCGv t;
+    TCGv_reg t;
 
     nullify_over(ctx);
 
     t = tcg_temp_new();
-    tcg_gen_ld32u_tl(t, cpu_env, offsetof(CPUHPPAState, fr0_shadow));
-    tcg_gen_extract_tl(t, t, 21 - cbit, 1);
+    tcg_gen_ld32u_reg(t, cpu_env, offsetof(CPUHPPAState, fr0_shadow));
+    tcg_gen_extract_reg(t, t, 21 - cbit, 1);
     ctx->null_cond = cond_make_0(TCG_COND_NE, t);
     tcg_temp_free(t);
 
@@ -3261,16 +3487,16 @@ static DisasJumpType trans_ftest_q(DisasContext *ctx, uint32_t insn,
     unsigned c = extract32(insn, 0, 5);
     int mask;
     bool inv = false;
-    TCGv t;
+    TCGv_reg t;
 
     nullify_over(ctx);
 
     t = tcg_temp_new();
-    tcg_gen_ld32u_tl(t, cpu_env, offsetof(CPUHPPAState, fr0_shadow));
+    tcg_gen_ld32u_reg(t, cpu_env, offsetof(CPUHPPAState, fr0_shadow));
 
     switch (c) {
     case 0: /* simple */
-        tcg_gen_andi_tl(t, t, 0x4000000);
+        tcg_gen_andi_reg(t, t, 0x4000000);
         ctx->null_cond = cond_make_0(TCG_COND_NE, t);
         goto done;
     case 2: /* rej */
@@ -3298,11 +3524,11 @@ static DisasJumpType trans_ftest_q(DisasContext *ctx, uint32_t insn,
         return gen_illegal(ctx);
     }
     if (inv) {
-        TCGv c = load_const(ctx, mask);
-        tcg_gen_or_tl(t, t, c);
+        TCGv_reg c = load_const(ctx, mask);
+        tcg_gen_or_reg(t, t, c);
         ctx->null_cond = cond_make(TCG_COND_EQ, t, c);
     } else {
-        tcg_gen_andi_tl(t, t, mask);
+        tcg_gen_andi_reg(t, t, mask);
         ctx->null_cond = cond_make_0(TCG_COND_EQ, t);
     }
  done:
@@ -3805,7 +4031,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
         if (ctx->iaoq_b == -1) {
             ctx->iaoq_n = -1;
             ctx->iaoq_n_var = get_temp(ctx);
-            tcg_gen_addi_tl(ctx->iaoq_n_var, cpu_iaoq_b, 4);
+            tcg_gen_addi_reg(ctx->iaoq_n_var, cpu_iaoq_b, 4);
         } else {
             ctx->iaoq_n = ctx->iaoq_b + 4;
             ctx->iaoq_n_var = NULL;
@@ -3849,12 +4075,12 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
         return;
     }
     if (ctx->iaoq_f == -1) {
-        tcg_gen_mov_tl(cpu_iaoq_f, cpu_iaoq_b);
+        tcg_gen_mov_reg(cpu_iaoq_f, cpu_iaoq_b);
         copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
         nullify_save(ctx);
         ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
     } else if (ctx->iaoq_b == -1) {
-        tcg_gen_mov_tl(cpu_iaoq_b, ctx->iaoq_n_var);
+        tcg_gen_mov_reg(cpu_iaoq_b, ctx->iaoq_n_var);
     }
 }
 
@@ -3889,8 +4115,7 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 
 static void hppa_tr_disas_log(const DisasContextBase *dcbase, CPUState *cs)
 {
-    TranslationBlock *tb = dcbase->tb;
-    target_ulong pc = tb->pc;
+    target_ureg pc = dcbase->pc_first;
 
 #ifdef CONFIG_USER_ONLY
     switch (pc) {
@@ -3910,7 +4135,7 @@ static void hppa_tr_disas_log(const DisasContextBase *dcbase, CPUState *cs)
 #endif
 
     qemu_log("IN: %s\n", lookup_symbol(pc));
-    log_target_disas(cs, pc, tb->size);
+    log_target_disas(cs, pc, dcbase->tb->size);
 }
 
 static const TranslatorOps hppa_tr_ops = {
-- 
2.14.3

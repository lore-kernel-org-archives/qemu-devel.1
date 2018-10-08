Received: from eggs.gnu.org ([2001:4830:134:3::10]:46806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g9X1S-0005zi-3P
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g9X1E-0006wx-CD
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:00:31 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48119 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1g9X1D-0006wC-VW
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:00:24 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  8 Oct 2018 16:56:33 +0200
Message-Id: <1539010596-30858-10-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539010596-30858-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539010596-30858-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 09/12] target/mips: Implement MemoryMapID,
 SAARI, and SAAR registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, laurent@vivier.eu, riku.voipio@iki.fi

From: Yongbok Kim <yongbok.kim@mips.com>

SAARI (Special Address Access Register Index) provides an index
into the SAAR register to indicate whether the ITU or other block
is being accessed. SAAR (Special Address Access Register) stores
the base address where the ITU will be located, as well as the
block size.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       |  8 ++++++
 target/mips/helper.h    |  6 +++++
 target/mips/internal.h  |  2 ++
 target/mips/machine.c   |  6 +++++
 target/mips/op_helper.c | 51 +++++++++++++++++++++++++++++++++++++
 target/mips/translate.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++---
 6 files changed, 137 insertions(+), 4 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index e8ac057..87c0a93 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -252,6 +252,7 @@ struct CPUMIPSState {
 #define CP0GN_VPId 0
     target_ulong CP0_Context;
     target_ulong CP0_KScratch[MIPS_KSCRATCH_NUM];
+    int32_t CP0_MemoryMapID;
     int32_t CP0_PageMask;
     int32_t CP0_PageGrain_rw_bitmask;
     int32_t CP0_PageGrain;
@@ -325,6 +326,12 @@ struct CPUMIPSState {
     uint32_t CP0_BadInstrP;
     uint32_t CP0_BadInstrX;
     int32_t CP0_Count;
+#define CP0SAARI_IDX    0
+    uint32_t CP0_SAARI;
+#define CP0SAAR_BASE    12
+#define CP0SAAR_SIZE    1
+#define CP0SAAR_EN      0
+    uint64_t CP0_SAAR[2];
     target_ulong CP0_EntryHi;
 #define CP0EnHi_EHINV 10
     target_ulong CP0_EntryHi_ASID_mask;
@@ -616,6 +623,7 @@ struct CPUMIPSState {
     uint32_t CP0_Status_rw_bitmask; /* Read/write bits in CP0_Status */
     uint32_t CP0_TCStatus_rw_bitmask; /* Read/write bits in CP0_TCStatus */
     int insn_flags; /* Supported instruction set */
+    int saarp;
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
diff --git a/target/mips/helper.h b/target/mips/helper.h
index fe2607d..4725c34 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -65,6 +65,8 @@ DEF_HELPER_1(mftc0_tcschedule, tl, env)
 DEF_HELPER_1(mfc0_tcschefback, tl, env)
 DEF_HELPER_1(mftc0_tcschefback, tl, env)
 DEF_HELPER_1(mfc0_count, tl, env)
+DEF_HELPER_1(mfc0_saar, tl, env)
+DEF_HELPER_1(mfhc0_saar, tl, env)
 DEF_HELPER_1(mftc0_entryhi, tl, env)
 DEF_HELPER_1(mftc0_status, tl, env)
 DEF_HELPER_1(mftc0_cause, tl, env)
@@ -89,6 +91,7 @@ DEF_HELPER_1(dmfc0_lladdr, tl, env)
 DEF_HELPER_1(dmfc0_maar, tl, env)
 DEF_HELPER_2(dmfc0_watchlo, tl, env, i32)
 DEF_HELPER_2(dmfc0_watchhi, tl, env, i32)
+DEF_HELPER_1(dmfc0_saar, tl, env)
 #endif /* TARGET_MIPS64 */
 
 DEF_HELPER_2(mtc0_index, void, env, tl)
@@ -130,6 +133,9 @@ DEF_HELPER_2(mtc0_srsconf3, void, env, tl)
 DEF_HELPER_2(mtc0_srsconf4, void, env, tl)
 DEF_HELPER_2(mtc0_hwrena, void, env, tl)
 DEF_HELPER_2(mtc0_count, void, env, tl)
+DEF_HELPER_2(mtc0_saari, void, env, tl)
+DEF_HELPER_2(mtc0_saar, void, env, tl)
+DEF_HELPER_2(mthc0_saar, void, env, tl)
 DEF_HELPER_2(mtc0_entryhi, void, env, tl)
 DEF_HELPER_2(mttc0_entryhi, void, env, tl)
 DEF_HELPER_2(mtc0_compare, void, env, tl)
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 3c5867e..c0a1144 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -61,6 +61,7 @@ struct mips_def_t {
     target_ulong CP0_EBaseWG_rw_bitmask;
     int insn_flags;
     enum mips_mmu_types mmu_type;
+    int32_t SAARP;
 };
 
 extern const struct mips_def_t mips_defs[];
@@ -91,6 +92,7 @@ struct r4k_tlb_t {
     target_ulong VPN;
     uint32_t PageMask;
     uint16_t ASID;
+    uint32_t MMID;
     unsigned int G:1;
     unsigned int C0:3;
     unsigned int C1:3;
diff --git a/target/mips/machine.c b/target/mips/machine.c
index 8d7cecb..306e871 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -136,6 +136,7 @@ static int get_tlb(QEMUFile *f, void *pv, size_t size, VMStateField *field)
     qemu_get_betls(f, &v->VPN);
     qemu_get_be32s(f, &v->PageMask);
     qemu_get_be16s(f, &v->ASID);
+    qemu_get_be32s(f, &v->MMID);
     qemu_get_be16s(f, &flags);
     v->G = (flags >> 10) & 1;
     v->C0 = (flags >> 7) & 3;
@@ -161,6 +162,7 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size, VMStateField *field,
     r4k_tlb_t *v = pv;
 
     uint16_t asid = v->ASID;
+    uint32_t mmid = v->MMID;
     uint16_t flags = ((v->EHINV << 15) |
                       (v->RI1 << 14) |
                       (v->RI0 << 13) |
@@ -177,6 +179,7 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size, VMStateField *field,
     qemu_put_betls(f, &v->VPN);
     qemu_put_be32s(f, &v->PageMask);
     qemu_put_be16s(f, &asid);
+    qemu_put_be32s(f, &mmid);
     qemu_put_be16s(f, &flags);
     qemu_put_be64s(f, &v->PFN[0]);
     qemu_put_be64s(f, &v->PFN[1]);
@@ -251,6 +254,7 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_UINT64(env.CP0_EntryLo0, MIPSCPU),
         VMSTATE_UINT64(env.CP0_EntryLo1, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_Context, MIPSCPU),
+        VMSTATE_INT32(env.CP0_MemoryMapID, MIPSCPU),
         VMSTATE_INT32(env.CP0_PageMask, MIPSCPU),
         VMSTATE_INT32(env.CP0_PageGrain, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_SegCtl0, MIPSCPU),
@@ -268,6 +272,8 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_UINT32(env.CP0_BadInstrP, MIPSCPU),
         VMSTATE_UINT32(env.CP0_BadInstrX, MIPSCPU),
         VMSTATE_INT32(env.CP0_Count, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.CP0_SAAR, MIPSCPU, 2),
+        VMSTATE_UINT32(env.CP0_SAARI, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_EntryHi, MIPSCPU),
         VMSTATE_INT32(env.CP0_Compare, MIPSCPU),
         VMSTATE_INT32(env.CP0_Status, MIPSCPU),
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 14c9bcb..6f53757 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -938,6 +938,22 @@ target_ulong helper_mfc0_count(CPUMIPSState *env)
     return count;
 }
 
+target_ulong helper_mfc0_saar(CPUMIPSState *env)
+{
+    if ((env->CP0_SAARI & 0x3f) < 2) {
+        return (int32_t) env->CP0_SAAR[env->CP0_SAARI & 0x3f];
+    }
+    return 0;
+}
+
+target_ulong helper_mfhc0_saar(CPUMIPSState *env)
+{
+    if ((env->CP0_SAARI & 0x3f) < 2) {
+        return env->CP0_SAAR[env->CP0_SAARI & 0x3f] >> 32;
+    }
+    return 0;
+}
+
 target_ulong helper_mftc0_entryhi(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
@@ -1069,6 +1085,15 @@ target_ulong helper_dmfc0_watchhi(CPUMIPSState *env, uint32_t sel)
 {
     return env->CP0_WatchHi[sel];
 }
+
+target_ulong helper_dmfc0_saar(CPUMIPSState *env)
+{
+    if ((env->CP0_SAARI & 0x3f) < 2) {
+        return env->CP0_SAAR[env->CP0_SAARI & 0x3f];
+    }
+    return 0;
+}
+
 #endif /* TARGET_MIPS64 */
 
 void helper_mtc0_index(CPUMIPSState *env, target_ulong arg1)
@@ -1522,6 +1547,32 @@ void helper_mtc0_count(CPUMIPSState *env, target_ulong arg1)
     qemu_mutex_unlock_iothread();
 }
 
+void helper_mtc0_saari(CPUMIPSState *env, target_ulong arg1)
+{
+    uint32_t target = arg1 & 0x3f;
+    if (target <= 1) {
+        env->CP0_SAARI = target;
+    }
+}
+
+void helper_mtc0_saar(CPUMIPSState *env, target_ulong arg1)
+{
+    uint32_t target = env->CP0_SAARI & 0x3f;
+    if (target < 2) {
+        env->CP0_SAAR[target] = arg1 & 0x00000ffffffff03fULL;
+    }
+}
+
+void helper_mthc0_saar(CPUMIPSState *env, target_ulong arg1)
+{
+    uint32_t target = env->CP0_SAARI & 0x3f;
+    if (target < 2) {
+        env->CP0_SAAR[target] =
+            (((uint64_t) arg1 << 32) & 0x00000fff00000000ULL) |
+            (env->CP0_SAAR[target] & 0x00000000ffffffffULL);
+    }
+}
+
 void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
 {
     target_ulong old, val, mask;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index e42cfa6..1c51a01 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1473,6 +1473,7 @@ typedef struct DisasContext {
     bool mrp;
     bool nan2008;
     bool abs2008;
+    bool saar;
 } DisasContext;
 
 #define DISAS_STOP       DISAS_TARGET_0
@@ -5218,6 +5219,17 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
+    case 9:
+        switch (sel) {
+        case 7:
+            CP0_CHECK(ctx->saar);
+            gen_helper_mfhc0_saar(arg, cpu_env);
+            rn = "SAAR";
+            break;
+        default:
+            goto cp0_unimplemented;
+        }
+        break;
     case 17:
         switch (sel) {
         case 0:
@@ -5307,6 +5319,16 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
+    case 9:
+        switch (sel) {
+        case 7:
+            CP0_CHECK(ctx->saar);
+            gen_helper_mthc0_saar(cpu_env, arg);
+            rn = "SAAR";
+            break;
+        default:
+            goto cp0_unimplemented;
+        }
     case 17:
         switch (sel) {
         case 0:
@@ -5692,7 +5714,16 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             ctx->base.is_jmp = DISAS_EXIT;
             rn = "Count";
             break;
-        /* 6,7 are implementation dependent */
+        case 6:
+            CP0_CHECK(ctx->saar);
+            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SAARI));
+            rn = "SAARI";
+            break;
+        case 7:
+            CP0_CHECK(ctx->saar);
+            gen_helper_mfc0_saar(arg, cpu_env);
+            rn = "SAAR";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -6377,7 +6408,16 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_count(cpu_env, arg);
             rn = "Count";
             break;
-        /* 6,7 are implementation dependent */
+        case 6:
+            CP0_CHECK(ctx->saar);
+            gen_helper_mtc0_saari(cpu_env, arg);
+            rn = "SAARI";
+            break;
+        case 7:
+            CP0_CHECK(ctx->saar);
+            gen_helper_mtc0_saar(cpu_env, arg);
+            rn = "SAAR";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7102,7 +7142,16 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             ctx->base.is_jmp = DISAS_EXIT;
             rn = "Count";
             break;
-        /* 6,7 are implementation dependent */
+        case 6:
+            CP0_CHECK(ctx->saar);
+            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SAARI));
+            rn = "SAARI";
+            break;
+        case 7:
+            CP0_CHECK(ctx->saar);
+            gen_helper_dmfc0_saar(arg, cpu_env);
+            rn = "SAAR";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7770,7 +7819,16 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_count(cpu_env, arg);
             rn = "Count";
             break;
-        /* 6,7 are implementation dependent */
+        case 6:
+            CP0_CHECK(ctx->saar);
+            gen_helper_mtc0_saari(cpu_env, arg);
+            rn = "SAARI";
+            break;
+        case 7:
+            CP0_CHECK(ctx->saar);
+            gen_helper_mtc0_saar(cpu_env, arg);
+            rn = "SAAR";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -25470,6 +25528,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mrp = (env->CP0_Config5 >> CP0C5_MRP) & 1;
     ctx->nan2008 = (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
     ctx->abs2008 = (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
+    ctx->saar = (bool) env->saarp;
     restore_cpu_state(env, ctx);
 #ifdef CONFIG_USER_ONLY
         ctx->mem_idx = MIPS_HFLAG_UM;
@@ -25835,6 +25894,7 @@ void cpu_state_reset(CPUMIPSState *env)
     env->active_fpu.fcr31 = env->cpu_model->CP1_fcr31;
     env->msair = env->cpu_model->MSAIR;
     env->insn_flags = env->cpu_model->insn_flags;
+    env->saarp = env->cpu_model->SAARP;
 
 #if defined(CONFIG_USER_ONLY)
     env->CP0_Status = (MIPS_HFLAG_UM << CP0St_KSU);
-- 
2.7.4

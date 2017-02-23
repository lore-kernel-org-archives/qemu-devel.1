Received: from eggs.gnu.org ([2001:4830:134:3::10]:41272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVm-0005Ng-8N
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVi-0001kq-Py
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgzVi-0001kT-Gr
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:06 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1NJtDQZ061220
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:05 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28sp4jssk6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:04 -0500
Received: from localhost
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 01:27:01 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 01:26:31 +0530
In-Reply-To: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487879800-12352-7-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 06/15] target/ppc: remove xer split-out
 flags(so, ov, ca)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

Now get rid all the split out variables so, ca, ov. After this patch,
all the bits are stored in CPUPPCState::xer at appropriate places.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/cpu.c        |   8 +---
 target/ppc/cpu.h        |  26 ++++++------
 target/ppc/int_helper.c |  12 +++---
 target/ppc/translate.c  | 106 +++++++++++++++++++++++++-----------------------
 4 files changed, 78 insertions(+), 74 deletions(-)

diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index de3004b..3c08dac 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -23,14 +23,10 @@
 
 target_ulong cpu_read_xer(CPUPPCState *env)
 {
-    return env->xer | (env->so << XER_SO) | (env->ov << XER_OV) |
-        (env->ca << XER_CA);
+    return env->xer;
 }
 
 void cpu_write_xer(CPUPPCState *env, target_ulong xer)
 {
-    env->so = (xer >> XER_SO) & 1;
-    env->ov = (xer >> XER_OV) & 1;
-    env->ca = (xer >> XER_CA) & 1;
-    env->xer = xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA));
+    env->xer = xer;
 }
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index b559b67..f1a7ca0 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -962,9 +962,6 @@ struct CPUPPCState {
 #endif
     /* XER (with SO, OV, CA split out) */
     target_ulong xer;
-    target_ulong so;
-    target_ulong ov;
-    target_ulong ca;
     /* Reservation address */
     target_ulong reserve_addr;
     /* Reservation value */
@@ -1369,16 +1366,19 @@ int ppc_compat_max_threads(PowerPCCPU *cpu);
 #define CRF_CH_AND_CL (1 << CRF_SO_BIT)
 
 /* XER definitions */
-#define XER_SO  31
-#define XER_OV  30
-#define XER_CA  29
-#define XER_CMP  8
-#define XER_BC   0
-#define xer_so  (env->so)
-#define xer_ov  (env->ov)
-#define xer_ca  (env->ca)
-#define xer_cmp ((env->xer >> XER_CMP) & 0xFF)
-#define xer_bc  ((env->xer >> XER_BC)  & 0x7F)
+#define XER_SO_BIT  31
+#define XER_OV_BIT  30
+#define XER_CA_BIT  29
+#define XER_CMP_BIT  8
+#define XER_BC_BIT   0
+#define XER_SO  (1 << XER_SO_BIT)
+#define XER_OV  (1 << XER_OV_BIT)
+#define XER_CA  (1 << XER_CA_BIT)
+#define xer_so  ((env->xer & XER_SO) >> XER_SO_BIT)
+#define xer_ov  ((env->xer & XER_OV) >> XER_OV_BIT)
+#define xer_ca  ((env->xer & XER_CA) >> XER_CA_BIT)
+#define xer_cmp ((env->xer >> XER_CMP_BIT) & 0xFF)
+#define xer_bc  ((env->xer >> XER_BC_BIT)  & 0x7F)
 
 /* SPR definitions */
 #define SPR_MQ                (0x000)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index d7af671..b0c3c2b 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -30,16 +30,18 @@
 
 static inline void helper_update_ov_legacy(CPUPPCState *env, int ov)
 {
-    if (unlikely(ov)) {
-        env->so = env->ov = 1;
-    } else {
-        env->ov = 0;
+    env->xer = env->xer & ~(XER_OV);
+    if (ov) {
+        env->xer |= XER_SO | XER_OV;
     }
 }
 
 static inline void helper_update_ca(CPUPPCState *env, int ca)
 {
-    env->ca = ca;
+    env->xer = env->xer & ~(XER_CA);
+    if (ca) {
+        env->xer |= XER_CA;
+    }
 }
 
 target_ulong helper_divweu(CPUPPCState *env, target_ulong ra, target_ulong rb,
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4c0e985..5be1bb9 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -71,7 +71,7 @@ static TCGv cpu_lr;
 #if defined(TARGET_PPC64)
 static TCGv cpu_cfar;
 #endif
-static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca;
+static TCGv cpu_xer;
 static TCGv cpu_reserve;
 static TCGv cpu_fpscr;
 static TCGv_i32 cpu_access_type;
@@ -167,12 +167,6 @@ void ppc_translate_init(void)
 
     cpu_xer = tcg_global_mem_new(cpu_env,
                                  offsetof(CPUPPCState, xer), "xer");
-    cpu_so = tcg_global_mem_new(cpu_env,
-                                offsetof(CPUPPCState, so), "SO");
-    cpu_ov = tcg_global_mem_new(cpu_env,
-                                offsetof(CPUPPCState, ov), "OV");
-    cpu_ca = tcg_global_mem_new(cpu_env,
-                                offsetof(CPUPPCState, ca), "CA");
 
     cpu_reserve = tcg_global_mem_new(cpu_env,
                                      offsetof(CPUPPCState, reserve_addr),
@@ -607,8 +601,11 @@ static inline void gen_op_cmp(TCGv arg0, TCGv arg1, int s, int crf)
 {
     TCGv t0 = tcg_temp_new();
     TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv so = tcg_temp_new();
 
-    tcg_gen_trunc_tl_i32(cpu_crf[crf], cpu_so);
+    tcg_gen_extract_tl(so, cpu_xer, XER_SO_BIT, 1);
+    tcg_gen_trunc_tl_i32(cpu_crf[crf], so);
+    tcg_temp_free(so);
 
     tcg_gen_setcond_tl((s ? TCG_COND_LT: TCG_COND_LTU), t0, arg0, arg1);
     tcg_gen_trunc_tl_i32(t1, t0);
@@ -794,13 +791,24 @@ static void gen_cmpb(DisasContext *ctx)
 
 static inline void gen_op_update_ca_legacy(TCGv ca)
 {
-    tcg_gen_mov_tl(cpu_ca, ca);
+    TCGv t0 = tcg_temp_new();
+    tcg_gen_movi_tl(t0, XER_CA);
+    tcg_gen_andc_tl(cpu_xer, cpu_xer, t0);
+    tcg_gen_shli_tl(t0, ca, XER_CA_BIT);
+    tcg_gen_or_tl(cpu_xer, cpu_xer, t0);
+    tcg_temp_free(t0);
 }
 
 static inline void gen_op_update_ov_legacy(TCGv ov)
 {
-    tcg_gen_mov_tl(cpu_ov, ov);
-    tcg_gen_or_tl(cpu_so, ov);
+    TCGv t1 = tcg_temp_new();
+    TCGv zero = tcg_const_tl(0);
+    tcg_gen_movi_tl(t1, XER_OV);
+    tcg_gen_andc_tl(cpu_xer, cpu_xer, t1);
+    tcg_gen_movi_tl(t1, XER_OV | XER_SO);
+    tcg_gen_movcond_tl(TCG_COND_EQ, cpu_xer, ov, zero, cpu_xer, t1);
+    tcg_temp_free(t1);
+    tcg_temp_free(zero);
 }
 
 /* Sub functions with one operand and one immediate */
@@ -849,7 +857,7 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
     }
 
     if (add_ca) {
-        tcg_gen_mov_tl(ca, cpu_ca);
+        tcg_gen_extract_tl(ca, cpu_xer, XER_CA_BIT, 1);
     }
 
     if (compute_ca) {
@@ -3151,8 +3159,12 @@ static void gen_conditional_store(DisasContext *ctx, TCGv EA,
                                   int reg, int memop)
 {
     TCGLabel *l1;
+    TCGv so = tcg_temp_new();
+
+    tcg_gen_extract_tl(so, cpu_xer, XER_SO_BIT, 1);
+    tcg_gen_trunc_tl_i32(cpu_crf[0], so);
+    tcg_temp_free(so);
 
-    tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
     l1 = gen_new_label();
     tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, l1);
     tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], CRF_EQ);
@@ -3230,6 +3242,7 @@ static void gen_stqcx_(DisasContext *ctx)
 #if !defined(CONFIG_USER_ONLY)
     TCGLabel *l1;
     TCGv gpr1, gpr2;
+    TCGv so = tcg_temp_new();
 #endif
 
     if (unlikely((rD(ctx->opcode) & 1))) {
@@ -3246,7 +3259,10 @@ static void gen_stqcx_(DisasContext *ctx)
 #if defined(CONFIG_USER_ONLY)
     gen_conditional_store(ctx, EA, reg, 16);
 #else
-    tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
+    tcg_gen_extract_tl(so, cpu_xer, XER_SO_BIT, 1);
+    tcg_gen_trunc_tl_i32(cpu_crf[0], so);
+    tcg_temp_free(so);
+
     l1 = gen_new_label();
     tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, l1);
     tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], CRF_EQ);
@@ -3756,51 +3772,26 @@ static void gen_tdi(DisasContext *ctx)
 
 static void gen_read_xer(TCGv dst)
 {
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
     tcg_gen_mov_tl(dst, cpu_xer);
-    tcg_gen_shli_tl(t0, cpu_so, XER_SO);
-    tcg_gen_shli_tl(t1, cpu_ov, XER_OV);
-    tcg_gen_shli_tl(t2, cpu_ca, XER_CA);
-    tcg_gen_or_tl(t0, t0, t1);
-    tcg_gen_or_tl(dst, dst, t2);
-    tcg_gen_or_tl(dst, dst, t0);
-    tcg_temp_free(t0);
-    tcg_temp_free(t1);
-    tcg_temp_free(t2);
 }
 
 static void gen_write_xer(TCGv src)
 {
-    tcg_gen_andi_tl(cpu_xer, src,
-                    ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA)));
-    tcg_gen_extract_tl(cpu_so, src, XER_SO, 1);
-    tcg_gen_extract_tl(cpu_ov, src, XER_OV, 1);
-    tcg_gen_extract_tl(cpu_ca, src, XER_CA, 1);
+    tcg_gen_mov_tl(cpu_xer, src);
 }
 
 /* mcrxr */
 static void gen_mcrxr(DisasContext *ctx)
 {
-    TCGv_i32 t0 = tcg_temp_new_i32();
-    TCGv_i32 t1 = tcg_temp_new_i32();
     TCGv_i32 dst = cpu_crf[crfD(ctx->opcode)];
+    TCGv t0 = tcg_temp_new();
 
-    tcg_gen_trunc_tl_i32(t0, cpu_so);
-    tcg_gen_trunc_tl_i32(t1, cpu_ov);
-    tcg_gen_trunc_tl_i32(dst, cpu_ca);
-    tcg_gen_shli_i32(t0, t0, 3);
-    tcg_gen_shli_i32(t1, t1, 2);
-    tcg_gen_shli_i32(dst, dst, 1);
-    tcg_gen_or_i32(dst, dst, t0);
-    tcg_gen_or_i32(dst, dst, t1);
-    tcg_temp_free_i32(t0);
-    tcg_temp_free_i32(t1);
-
-    tcg_gen_movi_tl(cpu_so, 0);
-    tcg_gen_movi_tl(cpu_ov, 0);
-    tcg_gen_movi_tl(cpu_ca, 0);
+    tcg_gen_trunc_tl_i32(dst, cpu_xer);
+    tcg_gen_shri_i32(dst, dst, XER_CA_BIT - 1);
+    tcg_gen_andi_i32(dst, dst, 0xE);
+    tcg_gen_movi_tl(t0, XER_SO | XER_OV | XER_CA);
+    tcg_gen_andc_tl(cpu_xer, cpu_xer, t0);
+    tcg_temp_free(t0);
 }
 
 /* mfcr mfocrf */
@@ -4421,6 +4412,7 @@ static void gen_slbfee_(DisasContext *ctx)
     gen_inval_exception(ctx, POWERPC_EXCP_PRIV_REG);
 #else
     TCGLabel *l1, *l2;
+    TCGv so;
 
     if (unlikely(ctx->pr)) {
         gen_inval_exception(ctx, POWERPC_EXCP_PRIV_REG);
@@ -4430,7 +4422,11 @@ static void gen_slbfee_(DisasContext *ctx)
                              cpu_gpr[rB(ctx->opcode)]);
     l1 = gen_new_label();
     l2 = gen_new_label();
-    tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
+    so = tcg_temp_new();
+
+    tcg_gen_extract_tl(so, cpu_xer, XER_SO_BIT, 1);
+    tcg_gen_trunc_tl_i32(cpu_crf[0], so);
+    tcg_temp_free(so);
     tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_gpr[rS(ctx->opcode)], -1, l1);
     tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], CRF_EQ);
     tcg_gen_br(l2);
@@ -5854,7 +5850,12 @@ static void gen_tlbsx_40x(DisasContext *ctx)
     tcg_temp_free(t0);
     if (Rc(ctx->opcode)) {
         TCGLabel *l1 = gen_new_label();
-        tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
+        TCGv so = tcg_temp_new();
+
+        tcg_gen_extract_tl(so, cpu_xer, XER_SO_BIT, 1);
+        tcg_gen_trunc_tl_i32(cpu_crf[0], so);
+        tcg_temp_free(so);
+
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_gpr[rD(ctx->opcode)], -1, l1);
         tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], 0x02);
         gen_set_label(l1);
@@ -5929,7 +5930,12 @@ static void gen_tlbsx_440(DisasContext *ctx)
     tcg_temp_free(t0);
     if (Rc(ctx->opcode)) {
         TCGLabel *l1 = gen_new_label();
-        tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
+        TCGv so = tcg_temp_new();
+
+        tcg_gen_extract_tl(so, cpu_xer, XER_SO_BIT, 1);
+        tcg_gen_trunc_tl_i32(cpu_crf[0], so);
+        tcg_temp_free(so);
+
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_gpr[rD(ctx->opcode)], -1, l1);
         tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], 0x02);
         gen_set_label(l1);
-- 
2.7.4

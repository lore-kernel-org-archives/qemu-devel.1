Received: from eggs.gnu.org ([2001:4830:134:3::10]:58246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sandipan@linux.vnet.ibm.com>) id 1dyLTB-0000u2-3Y
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 13:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sandipan@linux.vnet.ibm.com>) id 1dyLT8-0006Ql-Ey
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 13:22:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58134
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sandipan@linux.vnet.ibm.com>)
	id 1dyLT8-0006QT-9j
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 13:22:26 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8UHIshx039258
	for <qemu-devel@nongnu.org>; Sat, 30 Sep 2017 13:22:22 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2da7970qbr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 30 Sep 2017 13:22:22 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sandipan@linux.vnet.ibm.com>;
	Sun, 1 Oct 2017 03:22:19 +1000
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
Date: Sat, 30 Sep 2017 22:52:10 +0530
Message-Id: <20170930172210.17532-1-sandipan@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2] target/ppc: Fix carry flag setting for
 shift algebraic instructions
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au, agraf@suse.de
Cc: nikunj@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

For POWER ISA v3.0, the XER bit CA32 needs to be set by the shift
right algebraic instructions whenever the CA bit is to be set. This
change affects the following instructions:
  * Shift Right Algebraic Word (sraw[.])
  * Shift Right Algebraic Word Immediate (srawi[.])
  * Shift Right Algebraic Doubleword (srad[.])
  * Shift Right Algebraic Doubleword Immediate (sradi[.])

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
v2: Add tcg_temp_free() required in gen_sraw() and gen_srad()
---
 target/ppc/helper.h     |  4 ++--
 target/ppc/int_helper.c | 10 ++++++++--
 target/ppc/translate.c  | 18 ++++++++++++++++--
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index bb6a94a8b3..069d65ad7b 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -40,12 +40,12 @@ DEF_HELPER_4(divwe, tl, env, tl, tl, i32)
 
 DEF_HELPER_FLAGS_1(popcntb, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(cmpb, TCG_CALL_NO_RWG_SE, tl, tl, tl)
-DEF_HELPER_3(sraw, tl, env, tl, tl)
+DEF_HELPER_4(sraw, tl, env, tl, tl, tl)
 #if defined(TARGET_PPC64)
 DEF_HELPER_FLAGS_2(cmpeqb, TCG_CALL_NO_RWG_SE, i32, tl, tl)
 DEF_HELPER_FLAGS_1(popcntw, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(bpermd, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_3(srad, tl, env, tl, tl)
+DEF_HELPER_4(srad, tl, env, tl, tl, tl)
 DEF_HELPER_0(darn32, tl)
 DEF_HELPER_0(darn64, tl)
 #endif
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index da4e1a62c9..4f270eb49d 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -210,7 +210,7 @@ target_ulong helper_cmpb(target_ulong rs, target_ulong rb)
 
 /* shift right arithmetic helper */
 target_ulong helper_sraw(CPUPPCState *env, target_ulong value,
-                         target_ulong shift)
+                         target_ulong shift, target_ulong is_isa300)
 {
     int32_t ret;
 
@@ -231,12 +231,15 @@ target_ulong helper_sraw(CPUPPCState *env, target_ulong value,
         ret = (int32_t)value >> 31;
         env->ca = (ret != 0);
     }
+    if (is_isa300) {
+        env->ca32 = env->ca;
+    }
     return (target_long)ret;
 }
 
 #if defined(TARGET_PPC64)
 target_ulong helper_srad(CPUPPCState *env, target_ulong value,
-                         target_ulong shift)
+                         target_ulong shift, target_ulong is_isa300)
 {
     int64_t ret;
 
@@ -257,6 +260,9 @@ target_ulong helper_srad(CPUPPCState *env, target_ulong value,
         ret = (int64_t)value >> 63;
         env->ca = (ret != 0);
     }
+    if (is_isa300) {
+        env->ca32 = env->ca;
+    }
     return ret;
 }
 #endif
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 606b605ba0..7618015ab7 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2166,8 +2166,12 @@ static void gen_slw(DisasContext *ctx)
 /* sraw & sraw. */
 static void gen_sraw(DisasContext *ctx)
 {
+    TCGv t0;
+
+    t0 = tcg_const_tl(is_isa300(ctx));
     gen_helper_sraw(cpu_gpr[rA(ctx->opcode)], cpu_env,
-                    cpu_gpr[rS(ctx->opcode)], cpu_gpr[rB(ctx->opcode)]);
+                    cpu_gpr[rS(ctx->opcode)], cpu_gpr[rB(ctx->opcode)], t0);
+    tcg_temp_free(t0);
     if (unlikely(Rc(ctx->opcode) != 0))
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
 }
@@ -2192,6 +2196,9 @@ static void gen_srawi(DisasContext *ctx)
         tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
         tcg_gen_sari_tl(dst, dst, sh);
     }
+    if (is_isa300(ctx)) {
+        tcg_gen_mov_tl(cpu_ca32, cpu_ca);
+    }
     if (unlikely(Rc(ctx->opcode) != 0)) {
         gen_set_Rc0(ctx, dst);
     }
@@ -2245,8 +2252,12 @@ static void gen_sld(DisasContext *ctx)
 /* srad & srad. */
 static void gen_srad(DisasContext *ctx)
 {
+    TCGv t0;
+
+    t0 = tcg_const_tl(is_isa300(ctx));
     gen_helper_srad(cpu_gpr[rA(ctx->opcode)], cpu_env,
-                    cpu_gpr[rS(ctx->opcode)], cpu_gpr[rB(ctx->opcode)]);
+                    cpu_gpr[rS(ctx->opcode)], cpu_gpr[rB(ctx->opcode)], t0);
+    tcg_temp_free(t0);
     if (unlikely(Rc(ctx->opcode) != 0))
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
 }
@@ -2269,6 +2280,9 @@ static inline void gen_sradi(DisasContext *ctx, int n)
         tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
         tcg_gen_sari_tl(dst, src, sh);
     }
+    if (is_isa300(ctx)) {
+        tcg_gen_mov_tl(cpu_ca32, cpu_ca);
+    }
     if (unlikely(Rc(ctx->opcode) != 0)) {
         gen_set_Rc0(ctx, dst);
     }
-- 
2.13.5

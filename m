Received: from eggs.gnu.org ([2001:4830:134:3::10]:59050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sandipan@linux.vnet.ibm.com>) id 1e0LNC-0006dL-Ev
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 01:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sandipan@linux.vnet.ibm.com>) id 1e0LN9-0005SE-Ac
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 01:40:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sandipan@linux.vnet.ibm.com>)
	id 1e0LN9-0005QX-1k
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 01:40:31 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v965cxjZ004405
	for <qemu-devel@nongnu.org>; Fri, 6 Oct 2017 01:40:23 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ddugu5d3d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 01:40:23 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sandipan@linux.vnet.ibm.com>;
	Fri, 6 Oct 2017 15:40:21 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v965eIcj46203116
	for <qemu-devel@nongnu.org>; Fri, 6 Oct 2017 16:40:18 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v965eLJX015445
	for <qemu-devel@nongnu.org>; Fri, 6 Oct 2017 16:40:21 +1100
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
Date: Fri,  6 Oct 2017 11:10:14 +0530
Message-Id: <20171006054014.17282-1-sandipan@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4] target/ppc: Fix carry flag setting for
 shift algebraic instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, david@gibson.dropbear.id.au
Cc: nikunj@linux.vnet.ibm.com, agraf@suse.de, qemu-devel@nongnu.org

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

v3: Remove explicit checking for ISA v3.0 when setting CA32

v4: Set CA32 only when CA is being modified (as Richard suggested)
    Set CA32 after checking for ISA300 in gen_* functions (as David suggested)
---
 target/ppc/int_helper.c | 16 ++++++++--------
 target/ppc/translate.c  | 12 ++++++++++++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index da4e1a62c9..1c013a0ee3 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -219,17 +219,17 @@ target_ulong helper_sraw(CPUPPCState *env, target_ulong value,
             shift &= 0x1f;
             ret = (int32_t)value >> shift;
             if (likely(ret >= 0 || (value & ((1 << shift) - 1)) == 0)) {
-                env->ca = 0;
+                env->ca32 = env->ca = 0;
             } else {
-                env->ca = 1;
+                env->ca32 = env->ca = 1;
             }
         } else {
             ret = (int32_t)value;
-            env->ca = 0;
+            env->ca32 = env->ca = 0;
         }
     } else {
         ret = (int32_t)value >> 31;
-        env->ca = (ret != 0);
+        env->ca32 = env->ca = (ret != 0);
     }
     return (target_long)ret;
 }
@@ -245,17 +245,17 @@ target_ulong helper_srad(CPUPPCState *env, target_ulong value,
             shift &= 0x3f;
             ret = (int64_t)value >> shift;
             if (likely(ret >= 0 || (value & ((1ULL << shift) - 1)) == 0)) {
-                env->ca = 0;
+                env->ca32 = env->ca = 0;
             } else {
-                env->ca = 1;
+                env->ca32 = env->ca = 1;
             }
         } else {
             ret = (int64_t)value;
-            env->ca = 0;
+            env->ca32 = env->ca = 0;
         }
     } else {
         ret = (int64_t)value >> 63;
-        env->ca = (ret != 0);
+        env->ca32 = env->ca = (ret != 0);
     }
     return ret;
 }
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 606b605ba0..a81ff69d75 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2181,6 +2181,9 @@ static void gen_srawi(DisasContext *ctx)
     if (sh == 0) {
         tcg_gen_ext32s_tl(dst, src);
         tcg_gen_movi_tl(cpu_ca, 0);
+        if (is_isa300(ctx)) {
+            tcg_gen_movi_tl(cpu_ca32, 0);
+        }
     } else {
         TCGv t0;
         tcg_gen_ext32s_tl(dst, src);
@@ -2190,6 +2193,9 @@ static void gen_srawi(DisasContext *ctx)
         tcg_gen_and_tl(cpu_ca, cpu_ca, t0);
         tcg_temp_free(t0);
         tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
+        if (is_isa300(ctx)) {
+            tcg_gen_mov_tl(cpu_ca32, cpu_ca);
+        }
         tcg_gen_sari_tl(dst, dst, sh);
     }
     if (unlikely(Rc(ctx->opcode) != 0)) {
@@ -2259,6 +2265,9 @@ static inline void gen_sradi(DisasContext *ctx, int n)
     if (sh == 0) {
         tcg_gen_mov_tl(dst, src);
         tcg_gen_movi_tl(cpu_ca, 0);
+        if (is_isa300(ctx)) {
+            tcg_gen_movi_tl(cpu_ca32, 0);
+        }
     } else {
         TCGv t0;
         tcg_gen_andi_tl(cpu_ca, src, (1ULL << sh) - 1);
@@ -2267,6 +2276,9 @@ static inline void gen_sradi(DisasContext *ctx, int n)
         tcg_gen_and_tl(cpu_ca, cpu_ca, t0);
         tcg_temp_free(t0);
         tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
+        if (is_isa300(ctx)) {
+            tcg_gen_mov_tl(cpu_ca32, cpu_ca);
+        }
         tcg_gen_sari_tl(dst, src, sh);
     }
     if (unlikely(Rc(ctx->opcode) != 0)) {
-- 
2.13.6

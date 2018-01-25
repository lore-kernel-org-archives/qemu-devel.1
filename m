Received: from eggs.gnu.org ([2001:4830:134:3::10]:33747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehok-0003J0-2T
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoc-00036c-WE
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:50 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eehoc-00033y-E2
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:42 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoU-0006rM-Qd
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:43:34 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 13:43:13 +0000
Message-Id: <1516887809-6265-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
References: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/21] target/arm: Use pointers in neon zip/uzp
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Rather than passing regnos to the helpers, pass pointers to the
vector registers directly.  This eliminates the need to pass in
the environment pointer and reduces the number of places that
directly access env->vfp.regs[].

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180119045438.28582-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h      |  20 +++---
 target/arm/neon_helper.c | 162 +++++++++++++++++++++++++----------------------
 target/arm/translate.c   |  42 ++++++------
 3 files changed, 120 insertions(+), 104 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 688380a..dbdc38f 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -511,16 +511,16 @@ DEF_HELPER_3(iwmmxt_muladdsl, i64, i64, i32, i32)
 DEF_HELPER_3(iwmmxt_muladdsw, i64, i64, i32, i32)
 DEF_HELPER_3(iwmmxt_muladdswl, i64, i64, i32, i32)
 
-DEF_HELPER_3(neon_unzip8, void, env, i32, i32)
-DEF_HELPER_3(neon_unzip16, void, env, i32, i32)
-DEF_HELPER_3(neon_qunzip8, void, env, i32, i32)
-DEF_HELPER_3(neon_qunzip16, void, env, i32, i32)
-DEF_HELPER_3(neon_qunzip32, void, env, i32, i32)
-DEF_HELPER_3(neon_zip8, void, env, i32, i32)
-DEF_HELPER_3(neon_zip16, void, env, i32, i32)
-DEF_HELPER_3(neon_qzip8, void, env, i32, i32)
-DEF_HELPER_3(neon_qzip16, void, env, i32, i32)
-DEF_HELPER_3(neon_qzip32, void, env, i32, i32)
+DEF_HELPER_FLAGS_2(neon_unzip8, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_2(neon_unzip16, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_2(neon_qunzip8, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_2(neon_qunzip16, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_2(neon_qunzip32, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_2(neon_zip8, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_2(neon_zip16, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_2(neon_qzip8, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_2(neon_qzip16, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_2(neon_qzip32, TCG_CALL_NO_RWG, void, ptr, ptr)
 
 DEF_HELPER_FLAGS_3(crypto_aese, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
index ebdf7c9..689491c 100644
--- a/target/arm/neon_helper.c
+++ b/target/arm/neon_helper.c
@@ -2027,12 +2027,12 @@ uint64_t HELPER(neon_acgt_f64)(uint64_t a, uint64_t b, void *fpstp)
 
 #define ELEM(V, N, SIZE) (((V) >> ((N) * (SIZE))) & ((1ull << (SIZE)) - 1))
 
-void HELPER(neon_qunzip8)(CPUARMState *env, uint32_t rd, uint32_t rm)
+void HELPER(neon_qunzip8)(void *vd, void *vm)
 {
-    uint64_t zm0 = float64_val(env->vfp.regs[rm]);
-    uint64_t zm1 = float64_val(env->vfp.regs[rm + 1]);
-    uint64_t zd0 = float64_val(env->vfp.regs[rd]);
-    uint64_t zd1 = float64_val(env->vfp.regs[rd + 1]);
+    uint64_t *rd = vd, *rm = vm;
+    uint64_t zd0 = rd[0], zd1 = rd[1];
+    uint64_t zm0 = rm[0], zm1 = rm[1];
+
     uint64_t d0 = ELEM(zd0, 0, 8) | (ELEM(zd0, 2, 8) << 8)
         | (ELEM(zd0, 4, 8) << 16) | (ELEM(zd0, 6, 8) << 24)
         | (ELEM(zd1, 0, 8) << 32) | (ELEM(zd1, 2, 8) << 40)
@@ -2049,18 +2049,19 @@ void HELPER(neon_qunzip8)(CPUARMState *env, uint32_t rd, uint32_t rm)
         | (ELEM(zm0, 5, 8) << 16) | (ELEM(zm0, 7, 8) << 24)
         | (ELEM(zm1, 1, 8) << 32) | (ELEM(zm1, 3, 8) << 40)
         | (ELEM(zm1, 5, 8) << 48) | (ELEM(zm1, 7, 8) << 56);
-    env->vfp.regs[rm] = make_float64(m0);
-    env->vfp.regs[rm + 1] = make_float64(m1);
-    env->vfp.regs[rd] = make_float64(d0);
-    env->vfp.regs[rd + 1] = make_float64(d1);
+
+    rm[0] = m0;
+    rm[1] = m1;
+    rd[0] = d0;
+    rd[1] = d1;
 }
 
-void HELPER(neon_qunzip16)(CPUARMState *env, uint32_t rd, uint32_t rm)
+void HELPER(neon_qunzip16)(void *vd, void *vm)
 {
-    uint64_t zm0 = float64_val(env->vfp.regs[rm]);
-    uint64_t zm1 = float64_val(env->vfp.regs[rm + 1]);
-    uint64_t zd0 = float64_val(env->vfp.regs[rd]);
-    uint64_t zd1 = float64_val(env->vfp.regs[rd + 1]);
+    uint64_t *rd = vd, *rm = vm;
+    uint64_t zd0 = rd[0], zd1 = rd[1];
+    uint64_t zm0 = rm[0], zm1 = rm[1];
+
     uint64_t d0 = ELEM(zd0, 0, 16) | (ELEM(zd0, 2, 16) << 16)
         | (ELEM(zd1, 0, 16) << 32) | (ELEM(zd1, 2, 16) << 48);
     uint64_t d1 = ELEM(zm0, 0, 16) | (ELEM(zm0, 2, 16) << 16)
@@ -2069,32 +2070,35 @@ void HELPER(neon_qunzip16)(CPUARMState *env, uint32_t rd, uint32_t rm)
         | (ELEM(zd1, 1, 16) << 32) | (ELEM(zd1, 3, 16) << 48);
     uint64_t m1 = ELEM(zm0, 1, 16) | (ELEM(zm0, 3, 16) << 16)
         | (ELEM(zm1, 1, 16) << 32) | (ELEM(zm1, 3, 16) << 48);
-    env->vfp.regs[rm] = make_float64(m0);
-    env->vfp.regs[rm + 1] = make_float64(m1);
-    env->vfp.regs[rd] = make_float64(d0);
-    env->vfp.regs[rd + 1] = make_float64(d1);
+
+    rm[0] = m0;
+    rm[1] = m1;
+    rd[0] = d0;
+    rd[1] = d1;
 }
 
-void HELPER(neon_qunzip32)(CPUARMState *env, uint32_t rd, uint32_t rm)
+void HELPER(neon_qunzip32)(void *vd, void *vm)
 {
-    uint64_t zm0 = float64_val(env->vfp.regs[rm]);
-    uint64_t zm1 = float64_val(env->vfp.regs[rm + 1]);
-    uint64_t zd0 = float64_val(env->vfp.regs[rd]);
-    uint64_t zd1 = float64_val(env->vfp.regs[rd + 1]);
+    uint64_t *rd = vd, *rm = vm;
+    uint64_t zd0 = rd[0], zd1 = rd[1];
+    uint64_t zm0 = rm[0], zm1 = rm[1];
+
     uint64_t d0 = ELEM(zd0, 0, 32) | (ELEM(zd1, 0, 32) << 32);
     uint64_t d1 = ELEM(zm0, 0, 32) | (ELEM(zm1, 0, 32) << 32);
     uint64_t m0 = ELEM(zd0, 1, 32) | (ELEM(zd1, 1, 32) << 32);
     uint64_t m1 = ELEM(zm0, 1, 32) | (ELEM(zm1, 1, 32) << 32);
-    env->vfp.regs[rm] = make_float64(m0);
-    env->vfp.regs[rm + 1] = make_float64(m1);
-    env->vfp.regs[rd] = make_float64(d0);
-    env->vfp.regs[rd + 1] = make_float64(d1);
+
+    rm[0] = m0;
+    rm[1] = m1;
+    rd[0] = d0;
+    rd[1] = d1;
 }
 
-void HELPER(neon_unzip8)(CPUARMState *env, uint32_t rd, uint32_t rm)
+void HELPER(neon_unzip8)(void *vd, void *vm)
 {
-    uint64_t zm = float64_val(env->vfp.regs[rm]);
-    uint64_t zd = float64_val(env->vfp.regs[rd]);
+    uint64_t *rd = vd, *rm = vm;
+    uint64_t zd = rd[0], zm = rm[0];
+
     uint64_t d0 = ELEM(zd, 0, 8) | (ELEM(zd, 2, 8) << 8)
         | (ELEM(zd, 4, 8) << 16) | (ELEM(zd, 6, 8) << 24)
         | (ELEM(zm, 0, 8) << 32) | (ELEM(zm, 2, 8) << 40)
@@ -2103,28 +2107,31 @@ void HELPER(neon_unzip8)(CPUARMState *env, uint32_t rd, uint32_t rm)
         | (ELEM(zd, 5, 8) << 16) | (ELEM(zd, 7, 8) << 24)
         | (ELEM(zm, 1, 8) << 32) | (ELEM(zm, 3, 8) << 40)
         | (ELEM(zm, 5, 8) << 48) | (ELEM(zm, 7, 8) << 56);
-    env->vfp.regs[rm] = make_float64(m0);
-    env->vfp.regs[rd] = make_float64(d0);
+
+    rm[0] = m0;
+    rd[0] = d0;
 }
 
-void HELPER(neon_unzip16)(CPUARMState *env, uint32_t rd, uint32_t rm)
+void HELPER(neon_unzip16)(void *vd, void *vm)
 {
-    uint64_t zm = float64_val(env->vfp.regs[rm]);
-    uint64_t zd = float64_val(env->vfp.regs[rd]);
+    uint64_t *rd = vd, *rm = vm;
+    uint64_t zd = rd[0], zm = rm[0];
+
     uint64_t d0 = ELEM(zd, 0, 16) | (ELEM(zd, 2, 16) << 16)
         | (ELEM(zm, 0, 16) << 32) | (ELEM(zm, 2, 16) << 48);
     uint64_t m0 = ELEM(zd, 1, 16) | (ELEM(zd, 3, 16) << 16)
         | (ELEM(zm, 1, 16) << 32) | (ELEM(zm, 3, 16) << 48);
-    env->vfp.regs[rm] = make_float64(m0);
-    env->vfp.regs[rd] = make_float64(d0);
+
+    rm[0] = m0;
+    rd[0] = d0;
 }
 
-void HELPER(neon_qzip8)(CPUARMState *env, uint32_t rd, uint32_t rm)
+void HELPER(neon_qzip8)(void *vd, void *vm)
 {
-    uint64_t zm0 = float64_val(env->vfp.regs[rm]);
-    uint64_t zm1 = float64_val(env->vfp.regs[rm + 1]);
-    uint64_t zd0 = float64_val(env->vfp.regs[rd]);
-    uint64_t zd1 = float64_val(env->vfp.regs[rd + 1]);
+    uint64_t *rd = vd, *rm = vm;
+    uint64_t zd0 = rd[0], zd1 = rd[1];
+    uint64_t zm0 = rm[0], zm1 = rm[1];
+
     uint64_t d0 = ELEM(zd0, 0, 8) | (ELEM(zm0, 0, 8) << 8)
         | (ELEM(zd0, 1, 8) << 16) | (ELEM(zm0, 1, 8) << 24)
         | (ELEM(zd0, 2, 8) << 32) | (ELEM(zm0, 2, 8) << 40)
@@ -2141,18 +2148,19 @@ void HELPER(neon_qzip8)(CPUARMState *env, uint32_t rd, uint32_t rm)
         | (ELEM(zd1, 5, 8) << 16) | (ELEM(zm1, 5, 8) << 24)
         | (ELEM(zd1, 6, 8) << 32) | (ELEM(zm1, 6, 8) << 40)
         | (ELEM(zd1, 7, 8) << 48) | (ELEM(zm1, 7, 8) << 56);
-    env->vfp.regs[rm] = make_float64(m0);
-    env->vfp.regs[rm + 1] = make_float64(m1);
-    env->vfp.regs[rd] = make_float64(d0);
-    env->vfp.regs[rd + 1] = make_float64(d1);
+
+    rm[0] = m0;
+    rm[1] = m1;
+    rd[0] = d0;
+    rd[1] = d1;
 }
 
-void HELPER(neon_qzip16)(CPUARMState *env, uint32_t rd, uint32_t rm)
+void HELPER(neon_qzip16)(void *vd, void *vm)
 {
-    uint64_t zm0 = float64_val(env->vfp.regs[rm]);
-    uint64_t zm1 = float64_val(env->vfp.regs[rm + 1]);
-    uint64_t zd0 = float64_val(env->vfp.regs[rd]);
-    uint64_t zd1 = float64_val(env->vfp.regs[rd + 1]);
+    uint64_t *rd = vd, *rm = vm;
+    uint64_t zd0 = rd[0], zd1 = rd[1];
+    uint64_t zm0 = rm[0], zm1 = rm[1];
+
     uint64_t d0 = ELEM(zd0, 0, 16) | (ELEM(zm0, 0, 16) << 16)
         | (ELEM(zd0, 1, 16) << 32) | (ELEM(zm0, 1, 16) << 48);
     uint64_t d1 = ELEM(zd0, 2, 16) | (ELEM(zm0, 2, 16) << 16)
@@ -2161,32 +2169,35 @@ void HELPER(neon_qzip16)(CPUARMState *env, uint32_t rd, uint32_t rm)
         | (ELEM(zd1, 1, 16) << 32) | (ELEM(zm1, 1, 16) << 48);
     uint64_t m1 = ELEM(zd1, 2, 16) | (ELEM(zm1, 2, 16) << 16)
         | (ELEM(zd1, 3, 16) << 32) | (ELEM(zm1, 3, 16) << 48);
-    env->vfp.regs[rm] = make_float64(m0);
-    env->vfp.regs[rm + 1] = make_float64(m1);
-    env->vfp.regs[rd] = make_float64(d0);
-    env->vfp.regs[rd + 1] = make_float64(d1);
+
+    rm[0] = m0;
+    rm[1] = m1;
+    rd[0] = d0;
+    rd[1] = d1;
 }
 
-void HELPER(neon_qzip32)(CPUARMState *env, uint32_t rd, uint32_t rm)
+void HELPER(neon_qzip32)(void *vd, void *vm)
 {
-    uint64_t zm0 = float64_val(env->vfp.regs[rm]);
-    uint64_t zm1 = float64_val(env->vfp.regs[rm + 1]);
-    uint64_t zd0 = float64_val(env->vfp.regs[rd]);
-    uint64_t zd1 = float64_val(env->vfp.regs[rd + 1]);
+    uint64_t *rd = vd, *rm = vm;
+    uint64_t zd0 = rd[0], zd1 = rd[1];
+    uint64_t zm0 = rm[0], zm1 = rm[1];
+
     uint64_t d0 = ELEM(zd0, 0, 32) | (ELEM(zm0, 0, 32) << 32);
     uint64_t d1 = ELEM(zd0, 1, 32) | (ELEM(zm0, 1, 32) << 32);
     uint64_t m0 = ELEM(zd1, 0, 32) | (ELEM(zm1, 0, 32) << 32);
     uint64_t m1 = ELEM(zd1, 1, 32) | (ELEM(zm1, 1, 32) << 32);
-    env->vfp.regs[rm] = make_float64(m0);
-    env->vfp.regs[rm + 1] = make_float64(m1);
-    env->vfp.regs[rd] = make_float64(d0);
-    env->vfp.regs[rd + 1] = make_float64(d1);
+
+    rm[0] = m0;
+    rm[1] = m1;
+    rd[0] = d0;
+    rd[1] = d1;
 }
 
-void HELPER(neon_zip8)(CPUARMState *env, uint32_t rd, uint32_t rm)
+void HELPER(neon_zip8)(void *vd, void *vm)
 {
-    uint64_t zm = float64_val(env->vfp.regs[rm]);
-    uint64_t zd = float64_val(env->vfp.regs[rd]);
+    uint64_t *rd = vd, *rm = vm;
+    uint64_t zd = rd[0], zm = rm[0];
+
     uint64_t d0 = ELEM(zd, 0, 8) | (ELEM(zm, 0, 8) << 8)
         | (ELEM(zd, 1, 8) << 16) | (ELEM(zm, 1, 8) << 24)
         | (ELEM(zd, 2, 8) << 32) | (ELEM(zm, 2, 8) << 40)
@@ -2195,20 +2206,23 @@ void HELPER(neon_zip8)(CPUARMState *env, uint32_t rd, uint32_t rm)
         | (ELEM(zd, 5, 8) << 16) | (ELEM(zm, 5, 8) << 24)
         | (ELEM(zd, 6, 8) << 32) | (ELEM(zm, 6, 8) << 40)
         | (ELEM(zd, 7, 8) << 48) | (ELEM(zm, 7, 8) << 56);
-    env->vfp.regs[rm] = make_float64(m0);
-    env->vfp.regs[rd] = make_float64(d0);
+
+    rm[0] = m0;
+    rd[0] = d0;
 }
 
-void HELPER(neon_zip16)(CPUARMState *env, uint32_t rd, uint32_t rm)
+void HELPER(neon_zip16)(void *vd, void *vm)
 {
-    uint64_t zm = float64_val(env->vfp.regs[rm]);
-    uint64_t zd = float64_val(env->vfp.regs[rd]);
+    uint64_t *rd = vd, *rm = vm;
+    uint64_t zd = rd[0], zm = rm[0];
+
     uint64_t d0 = ELEM(zd, 0, 16) | (ELEM(zm, 0, 16) << 16)
         | (ELEM(zd, 1, 16) << 32) | (ELEM(zm, 1, 16) << 48);
     uint64_t m0 = ELEM(zd, 2, 16) | (ELEM(zm, 2, 16) << 16)
         | (ELEM(zd, 3, 16) << 32) | (ELEM(zm, 3, 16) << 48);
-    env->vfp.regs[rm] = make_float64(m0);
-    env->vfp.regs[rd] = make_float64(d0);
+
+    rm[0] = m0;
+    rd[0] = d0;
 }
 
 /* Helper function for 64 bit polynomial multiply case:
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7b5db15..6f02c56 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4687,22 +4687,23 @@ static inline TCGv_i32 neon_get_scalar(int size, int reg)
 
 static int gen_neon_unzip(int rd, int rm, int size, int q)
 {
-    TCGv_i32 tmp, tmp2;
+    TCGv_ptr pd, pm;
+    
     if (!q && size == 2) {
         return 1;
     }
-    tmp = tcg_const_i32(rd);
-    tmp2 = tcg_const_i32(rm);
+    pd = vfp_reg_ptr(true, rd);
+    pm = vfp_reg_ptr(true, rm);
     if (q) {
         switch (size) {
         case 0:
-            gen_helper_neon_qunzip8(cpu_env, tmp, tmp2);
+            gen_helper_neon_qunzip8(pd, pm);
             break;
         case 1:
-            gen_helper_neon_qunzip16(cpu_env, tmp, tmp2);
+            gen_helper_neon_qunzip16(pd, pm);
             break;
         case 2:
-            gen_helper_neon_qunzip32(cpu_env, tmp, tmp2);
+            gen_helper_neon_qunzip32(pd, pm);
             break;
         default:
             abort();
@@ -4710,38 +4711,39 @@ static int gen_neon_unzip(int rd, int rm, int size, int q)
     } else {
         switch (size) {
         case 0:
-            gen_helper_neon_unzip8(cpu_env, tmp, tmp2);
+            gen_helper_neon_unzip8(pd, pm);
             break;
         case 1:
-            gen_helper_neon_unzip16(cpu_env, tmp, tmp2);
+            gen_helper_neon_unzip16(pd, pm);
             break;
         default:
             abort();
         }
     }
-    tcg_temp_free_i32(tmp);
-    tcg_temp_free_i32(tmp2);
+    tcg_temp_free_ptr(pd);
+    tcg_temp_free_ptr(pm);
     return 0;
 }
 
 static int gen_neon_zip(int rd, int rm, int size, int q)
 {
-    TCGv_i32 tmp, tmp2;
+    TCGv_ptr pd, pm;
+
     if (!q && size == 2) {
         return 1;
     }
-    tmp = tcg_const_i32(rd);
-    tmp2 = tcg_const_i32(rm);
+    pd = vfp_reg_ptr(true, rd);
+    pm = vfp_reg_ptr(true, rm);
     if (q) {
         switch (size) {
         case 0:
-            gen_helper_neon_qzip8(cpu_env, tmp, tmp2);
+            gen_helper_neon_qzip8(pd, pm);
             break;
         case 1:
-            gen_helper_neon_qzip16(cpu_env, tmp, tmp2);
+            gen_helper_neon_qzip16(pd, pm);
             break;
         case 2:
-            gen_helper_neon_qzip32(cpu_env, tmp, tmp2);
+            gen_helper_neon_qzip32(pd, pm);
             break;
         default:
             abort();
@@ -4749,17 +4751,17 @@ static int gen_neon_zip(int rd, int rm, int size, int q)
     } else {
         switch (size) {
         case 0:
-            gen_helper_neon_zip8(cpu_env, tmp, tmp2);
+            gen_helper_neon_zip8(pd, pm);
             break;
         case 1:
-            gen_helper_neon_zip16(cpu_env, tmp, tmp2);
+            gen_helper_neon_zip16(pd, pm);
             break;
         default:
             abort();
         }
     }
-    tcg_temp_free_i32(tmp);
-    tcg_temp_free_i32(tmp2);
+    tcg_temp_free_ptr(pd);
+    tcg_temp_free_ptr(pm);
     return 0;
 }
 
-- 
2.7.4

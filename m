Received: from eggs.gnu.org ([2001:4830:134:3::10]:37128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDY-0001o4-Rp
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDX-0004Fj-77
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:04 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcDW-0004FE-TW
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:03 -0400
Received: by mail-wm0-x235.google.com with SMTP id l1-v6so39334701wmb.2
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:51:02 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:50:02 +0200
Message-Id: <20180529105011.1914-30-edgar.iglesias@gmail.com>
In-Reply-To: <20180529105011.1914-1-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 29/38] target-microblaze: Add support for
 extended access to TLBLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add support for extended access to TLBLO's upper 32 bits.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/helper.h    |  4 ++--
 target/microblaze/mmu.c       | 18 ++++++++++++++----
 target/microblaze/mmu.h       |  4 ++--
 target/microblaze/op_helper.c |  8 ++++----
 target/microblaze/translate.c | 19 +++++++++++++------
 5 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index ce70353936..2f8bdea22b 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -25,8 +25,8 @@ DEF_HELPER_3(fcmp_ge, i32, env, i32, i32)
 
 DEF_HELPER_FLAGS_2(pcmpbf, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 #if !defined(CONFIG_USER_ONLY)
-DEF_HELPER_2(mmu_read, i32, env, i32)
-DEF_HELPER_3(mmu_write, void, env, i32, i32)
+DEF_HELPER_3(mmu_read, i32, env, i32, i32)
+DEF_HELPER_4(mmu_write, void, env, i32, i32, i32)
 #endif
 
 DEF_HELPER_5(memalign, void, env, tl, i32, i32, i32)
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 166c79908c..9ecffb2c9c 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -180,7 +180,7 @@ done:
 }
 
 /* Writes/reads to the MMU's special regs end up here.  */
-uint32_t mmu_read(CPUMBState *env, uint32_t rn)
+uint32_t mmu_read(CPUMBState *env, bool ext, uint32_t rn)
 {
     unsigned int i;
     uint32_t r = 0;
@@ -189,6 +189,10 @@ uint32_t mmu_read(CPUMBState *env, uint32_t rn)
         qemu_log_mask(LOG_GUEST_ERROR, "MMU access on MMU-less system\n");
         return 0;
     }
+    if (ext && rn != MMU_R_TLBLO) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Extended access only to TLBLO.\n");
+        return 0;
+    }
 
     switch (rn) {
         /* Reads to HI/LO trig reads from the mmu rams.  */
@@ -200,7 +204,7 @@ uint32_t mmu_read(CPUMBState *env, uint32_t rn)
             }
 
             i = env->mmu.regs[MMU_R_TLBX] & 0xff;
-            r = env->mmu.rams[rn & 1][i];
+            r = extract64(env->mmu.rams[rn & 1][i], ext * 32, 32);
             if (rn == MMU_R_TLBHI)
                 env->mmu.regs[MMU_R_PID] = env->mmu.tids[i];
             break;
@@ -226,9 +230,10 @@ uint32_t mmu_read(CPUMBState *env, uint32_t rn)
     return r;
 }
 
-void mmu_write(CPUMBState *env, uint32_t rn, uint32_t v)
+void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
 {
     MicroBlazeCPU *cpu = mb_env_get_cpu(env);
+    uint64_t tmp64;
     unsigned int i;
     D(qemu_log("%s rn=%d=%x old=%x\n", __func__, rn, v, env->mmu.regs[rn]));
 
@@ -236,6 +241,10 @@ void mmu_write(CPUMBState *env, uint32_t rn, uint32_t v)
         qemu_log_mask(LOG_GUEST_ERROR, "MMU access on MMU-less system\n");
         return;
     }
+    if (ext && rn != MMU_R_TLBLO) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Extended access only to TLBLO.\n");
+        return;
+    }
 
     switch (rn) {
         /* Writes to HI/LO trig writes to the mmu rams.  */
@@ -250,7 +259,8 @@ void mmu_write(CPUMBState *env, uint32_t rn, uint32_t v)
                 env->mmu.tids[i] = env->mmu.regs[MMU_R_PID] & 0xff;
                 mmu_flush_idx(env, i);
             }
-            env->mmu.rams[rn & 1][i] = v;
+            tmp64 = env->mmu.rams[rn & 1][i];
+            env->mmu.rams[rn & 1][i] = deposit64(tmp64, ext * 32, 32, v);
 
             D(qemu_log("%s ram[%d][%d]=%x\n", __func__, rn & 1, i, v));
             break;
diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
index 9fbdf38f36..a4272b6356 100644
--- a/target/microblaze/mmu.h
+++ b/target/microblaze/mmu.h
@@ -90,6 +90,6 @@ struct microblaze_mmu_lookup
 unsigned int mmu_translate(struct microblaze_mmu *mmu,
                            struct microblaze_mmu_lookup *lu,
                            target_ulong vaddr, int rw, int mmu_idx);
-uint32_t mmu_read(CPUMBState *env, uint32_t rn);
-void mmu_write(CPUMBState *env, uint32_t rn, uint32_t v);
+uint32_t mmu_read(CPUMBState *env, bool ea, uint32_t rn);
+void mmu_write(CPUMBState *env, bool ea, uint32_t rn, uint32_t v);
 void mmu_init(struct microblaze_mmu *mmu);
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 4dc3aff84b..ddc1f71d62 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -476,14 +476,14 @@ void helper_stackprot(CPUMBState *env, target_ulong addr)
 
 #if !defined(CONFIG_USER_ONLY)
 /* Writes/reads to the MMU's special regs end up here.  */
-uint32_t helper_mmu_read(CPUMBState *env, uint32_t rn)
+uint32_t helper_mmu_read(CPUMBState *env, uint32_t ext, uint32_t rn)
 {
-    return mmu_read(env, rn);
+    return mmu_read(env, ext, rn);
 }
 
-void helper_mmu_write(CPUMBState *env, uint32_t rn, uint32_t v)
+void helper_mmu_write(CPUMBState *env, uint32_t ext, uint32_t rn, uint32_t v)
 {
-    mmu_write(env, rn, v);
+    mmu_write(env, ext, rn, v);
 }
 
 void mb_cpu_unassigned_access(CPUState *cs, hwaddr addr,
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 756d901eba..bb6b5176c1 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -459,7 +459,7 @@ static void dec_msr(DisasContext *dc)
     CPUState *cs = CPU(dc->cpu);
     TCGv_i32 t0, t1;
     unsigned int sr, rn;
-    bool to, clrset, extended;
+    bool to, clrset, extended = false;
 
     sr = extract32(dc->imm, 0, 14);
     to = extract32(dc->imm, 14, 1);
@@ -467,9 +467,14 @@ static void dec_msr(DisasContext *dc)
     dc->type_b = 1;
     if (to) {
         dc->cpustate_changed = 1;
-        extended = extract32(dc->imm, 24, 1);
-    } else {
-        extended = extract32(dc->imm, 19, 1);
+    }
+
+    /* Extended MSRs are only available if addr_size > 32.  */
+    if (dc->cpu->cfg.addr_size > 32) {
+        /* The E-bit is encoded differently for To/From MSR.  */
+        static const unsigned int e_bit[] = { 19, 24 };
+
+        extended = extract32(dc->imm, e_bit[to], 1);
     }
 
     /* msrclr and msrset.  */
@@ -516,17 +521,19 @@ static void dec_msr(DisasContext *dc)
 #if !defined(CONFIG_USER_ONLY)
     /* Catch read/writes to the mmu block.  */
     if ((sr & ~0xff) == 0x1000) {
+        TCGv_i32 tmp_ext = tcg_const_i32(extended);
         TCGv_i32 tmp_sr;
 
         sr &= 7;
         tmp_sr = tcg_const_i32(sr);
         LOG_DIS("m%ss sr%d r%d imm=%x\n", to ? "t" : "f", sr, dc->ra, dc->imm);
         if (to) {
-            gen_helper_mmu_write(cpu_env, tmp_sr, cpu_R[dc->ra]);
+            gen_helper_mmu_write(cpu_env, tmp_ext, tmp_sr, cpu_R[dc->ra]);
         } else {
-            gen_helper_mmu_read(cpu_R[dc->rd], cpu_env, tmp_sr);
+            gen_helper_mmu_read(cpu_R[dc->rd], cpu_env, tmp_ext, tmp_sr);
         }
         tcg_temp_free_i32(tmp_sr);
+        tcg_temp_free_i32(tmp_ext);
         return;
     }
 #endif
-- 
2.14.1

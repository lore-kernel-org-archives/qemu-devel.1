Received: from eggs.gnu.org ([2001:4830:134:3::10]:46211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1er8vp-0005ee-Tf
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:06:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1er8vo-0000Tk-Dq
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:06:33 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:40366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1er8vn-0000Rj-TS
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:06:32 -0500
Received: by mail-lf0-x241.google.com with SMTP id 37so5615030lfs.7
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 13:06:31 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 28 Feb 2018 13:06:09 -0800
Message-Id: <20180228210616.2756-5-jcmvbkbc@gmail.com>
In-Reply-To: <20180228210616.2756-1-jcmvbkbc@gmail.com>
References: <20180228210616.2756-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 04/11] target/xtensa: support MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, "Emilio G . Cota" <cota@braap.org>

- emit TCG barriers for MEMW, EXTW, S32RI and L32AI;
- do atomic_cmpxchg_i32 for S32C1I.

Cc: Emilio G. Cota <cota@braap.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 configure                 |  1 +
 target/xtensa/cpu.h       |  3 +++
 target/xtensa/translate.c | 46 +++++++++++++++++++++++++++++++---------------
 3 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/configure b/configure
index 39f3a4300163..f83bdeb2a550 100755
--- a/configure
+++ b/configure
@@ -6813,6 +6813,7 @@ case "$target_name" in
   ;;
   xtensa|xtensaeb)
     TARGET_ARCH=xtensa
+    mttcg="yes"
   ;;
   *)
     error_exit "Unsupported target CPU"
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 255cc9e08ed9..d9d3b33a7052 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -31,6 +31,9 @@
 #define ALIGNED_ONLY
 #define TARGET_LONG_BITS 32
 
+/* Xtensa processors have a weak memory model */
+#define TCG_GUEST_DEFAULT_MO      (0)
+
 #define CPUArchState struct CPUXtensaState
 
 #include "qemu-common.h"
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 5969d7c3cd96..c06d30d17960 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1664,9 +1664,15 @@ static void translate_ldst(DisasContext *dc, const uint32_t arg[],
             gen_load_store_alignment(dc, par[0] & MO_SIZE, addr, par[1]);
         }
         if (par[2]) {
+            if (par[1]) {
+                tcg_gen_mb(TCG_BAR_STRL | TCG_MO_ALL);
+            }
             tcg_gen_qemu_st_tl(cpu_R[arg[0]], addr, dc->cring, par[0]);
         } else {
             tcg_gen_qemu_ld_tl(cpu_R[arg[0]], addr, dc->cring, par[0]);
+            if (par[1]) {
+                tcg_gen_mb(TCG_BAR_LDAQ | TCG_MO_ALL);
+            }
         }
         tcg_temp_free(addr);
     }
@@ -1823,6 +1829,12 @@ static void translate_mac16(DisasContext *dc, const uint32_t arg[],
     }
 }
 
+static void translate_memw(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
+}
+
 static void translate_minmax(DisasContext *dc, const uint32_t arg[],
                              const uint32_t par[])
 {
@@ -2193,29 +2205,33 @@ static void translate_setb_expstate(DisasContext *dc, const uint32_t arg[],
     tcg_gen_ori_i32(cpu_UR[EXPSTATE], cpu_UR[EXPSTATE], 1u << arg[0]);
 }
 
+#ifdef CONFIG_USER_ONLY
+static void gen_check_atomctl(DisasContext *dc, TCGv_i32 addr)
+{
+}
+#else
+static void gen_check_atomctl(DisasContext *dc, TCGv_i32 addr)
+{
+    TCGv_i32 tpc = tcg_const_i32(dc->pc);
+
+    gen_helper_check_atomctl(cpu_env, tpc, addr);
+    tcg_temp_free(tpc);
+}
+#endif
+
 static void translate_s32c1i(DisasContext *dc, const uint32_t arg[],
                              const uint32_t par[])
 {
     if (gen_window_check2(dc, arg[0], arg[1])) {
-        TCGLabel *label = gen_new_label();
         TCGv_i32 tmp = tcg_temp_local_new_i32();
         TCGv_i32 addr = tcg_temp_local_new_i32();
-        TCGv_i32 tpc;
 
         tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
         tcg_gen_addi_i32(addr, cpu_R[arg[1]], arg[2]);
         gen_load_store_alignment(dc, 2, addr, true);
-
-        tpc = tcg_const_i32(dc->pc);
-        gen_helper_check_atomctl(cpu_env, tpc, addr);
-        tcg_gen_qemu_ld32u(cpu_R[arg[0]], addr, dc->cring);
-        tcg_gen_brcond_i32(TCG_COND_NE, cpu_R[arg[0]],
-                           cpu_SR[SCOMPARE1], label);
-
-        tcg_gen_qemu_st32(tmp, addr, dc->cring);
-
-        gen_set_label(label);
-        tcg_temp_free(tpc);
+        gen_check_atomctl(dc, addr);
+        tcg_gen_atomic_cmpxchg_i32(cpu_R[arg[0]], addr, cpu_SR[SCOMPARE1],
+                                   tmp, dc->cring, MO_32);
         tcg_temp_free(addr);
         tcg_temp_free(tmp);
     }
@@ -2828,7 +2844,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_extui,
     }, {
         .name = "extw",
-        .translate = translate_nop,
+        .translate = translate_memw,
     }, {
         .name = "hwwdtlba",
         .translate = translate_ill,
@@ -2945,7 +2961,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .par = (const uint32_t[]){TCG_COND_GEU},
     }, {
         .name = "memw",
-        .translate = translate_nop,
+        .translate = translate_memw,
     }, {
         .name = "min",
         .translate = translate_minmax,
-- 
2.11.0

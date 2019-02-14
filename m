Received: from eggs.gnu.org ([209.51.188.92]:49688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ8n-0003LF-Qg
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:10:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ0B-0005Bo-DM
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:08 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:45692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1guQ0B-0005Az-6e
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:07 -0500
Received: by mail-lf1-x143.google.com with SMTP id h10so5573572lfc.12
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 15:01:07 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 14 Feb 2019 14:59:58 -0800
Message-Id: <20190214230000.24894-12-jcmvbkbc@gmail.com>
In-Reply-To: <20190214230000.24894-1-jcmvbkbc@gmail.com>
References: <20190214230000.24894-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 11/13] target/xtensa: reorganize access to
 boolean registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

libisa represents boolean registers b0..b16 as a BR register file and as
BR4 and BR8 register groups. Add these register files and use
OpcodeArg::{in,out} parameters to access boolean registers in
translators.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 50 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 065e3d01427b..276b435ce81e 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -80,6 +80,9 @@ static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_R[16];
 static TCGv_i32 cpu_FR[16];
 static TCGv_i32 cpu_MR[4];
+static TCGv_i32 cpu_BR[16];
+static TCGv_i32 cpu_BR4[4];
+static TCGv_i32 cpu_BR8[2];
 static TCGv_i32 cpu_SR[256];
 static TCGv_i32 cpu_UR[256];
 static TCGv_i32 cpu_windowbase_next;
@@ -227,6 +230,12 @@ void xtensa_translate_init(void)
     static const char * const mregnames[] = {
         "m0", "m1", "m2", "m3",
     };
+    static const char * const bregnames[] = {
+        "b0", "b1", "b2", "b3",
+        "b4", "b5", "b6", "b7",
+        "b8", "b9", "b10", "b11",
+        "b12", "b13", "b14", "b15",
+    };
     int i;
 
     cpu_pc = tcg_global_mem_new_i32(cpu_env,
@@ -252,6 +261,25 @@ void xtensa_translate_init(void)
                                            mregnames[i]);
     }
 
+    for (i = 0; i < 16; i++) {
+        cpu_BR[i] = tcg_global_mem_new_i32(cpu_env,
+                                           offsetof(CPUXtensaState,
+                                                    sregs[BR]),
+                                           bregnames[i]);
+        if (i % 4 == 0) {
+            cpu_BR4[i / 4] = tcg_global_mem_new_i32(cpu_env,
+                                                    offsetof(CPUXtensaState,
+                                                             sregs[BR]),
+                                                    bregnames[i]);
+        }
+        if (i % 8 == 0) {
+            cpu_BR8[i / 8] = tcg_global_mem_new_i32(cpu_env,
+                                                    offsetof(CPUXtensaState,
+                                                             sregs[BR]),
+                                                    bregnames[i]);
+        }
+    }
+
     for (i = 0; i < 256; ++i) {
         if (sregnames[i].name) {
             cpu_SR[i] = tcg_global_mem_new_i32(cpu_env,
@@ -284,6 +312,12 @@ void **xtensa_get_regfile_by_name(const char *name)
                             (void *)"MR", (void *)cpu_MR);
         g_hash_table_insert(xtensa_regfile_table,
                             (void *)"FR", (void *)cpu_FR);
+        g_hash_table_insert(xtensa_regfile_table,
+                            (void *)"BR", (void *)cpu_BR);
+        g_hash_table_insert(xtensa_regfile_table,
+                            (void *)"BR4", (void *)cpu_BR4);
+        g_hash_table_insert(xtensa_regfile_table,
+                            (void *)"BR8", (void *)cpu_BR8);
     }
     return (void **)g_hash_table_lookup(xtensa_regfile_table, (void *)name);
 }
@@ -1583,14 +1617,14 @@ static void translate_all(DisasContext *dc, const OpcodeArg arg[],
     TCGv_i32 mask = tcg_const_i32(((1 << shift) - 1) << arg[1].imm);
     TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_and_i32(tmp, cpu_SR[BR], mask);
+    tcg_gen_and_i32(tmp, arg[1].in, mask);
     if (par[0]) {
         tcg_gen_addi_i32(tmp, tmp, 1 << arg[1].imm);
     } else {
         tcg_gen_add_i32(tmp, tmp, mask);
     }
     tcg_gen_shri_i32(tmp, tmp, arg[1].imm + shift);
-    tcg_gen_deposit_i32(cpu_SR[BR], cpu_SR[BR],
+    tcg_gen_deposit_i32(arg[0].out, arg[0].out,
                         tmp, arg[0].imm, 1);
     tcg_temp_free(mask);
     tcg_temp_free(tmp);
@@ -1694,10 +1728,10 @@ static void translate_boolean(DisasContext *dc, const OpcodeArg arg[],
     TCGv_i32 tmp1 = tcg_temp_new_i32();
     TCGv_i32 tmp2 = tcg_temp_new_i32();
 
-    tcg_gen_shri_i32(tmp1, cpu_SR[BR], arg[1].imm);
-    tcg_gen_shri_i32(tmp2, cpu_SR[BR], arg[2].imm);
+    tcg_gen_shri_i32(tmp1, arg[1].in, arg[1].imm);
+    tcg_gen_shri_i32(tmp2, arg[2].in, arg[2].imm);
     op[par[0]](tmp1, tmp1, tmp2);
-    tcg_gen_deposit_i32(cpu_SR[BR], cpu_SR[BR], tmp1, arg[0].imm, 1);
+    tcg_gen_deposit_i32(arg[0].out, arg[0].out, tmp1, arg[0].imm, 1);
     tcg_temp_free(tmp1);
     tcg_temp_free(tmp2);
 }
@@ -1707,7 +1741,7 @@ static void translate_bp(DisasContext *dc, const OpcodeArg arg[],
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_andi_i32(tmp, cpu_SR[BR], 1 << arg[0].imm);
+    tcg_gen_andi_i32(tmp, arg[0].in, 1 << arg[0].imm);
     gen_brcondi(dc, par[0], tmp, 0, arg[1].imm);
     tcg_temp_free(tmp);
 }
@@ -2074,7 +2108,7 @@ static void translate_movp(DisasContext *dc, const OpcodeArg arg[],
     TCGv_i32 zero = tcg_const_i32(0);
     TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_andi_i32(tmp, cpu_SR[BR], 1 << arg[2].imm);
+    tcg_gen_andi_i32(tmp, arg[2].in, 1 << arg[2].imm);
     tcg_gen_movcond_i32(par[0],
                         arg[0].out, tmp, zero,
                         arg[1].in, arg[0].in);
@@ -5296,7 +5330,7 @@ static void translate_movp_s(DisasContext *dc, const OpcodeArg arg[],
     TCGv_i32 zero = tcg_const_i32(0);
     TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_andi_i32(tmp, cpu_SR[BR], 1 << arg[2].imm);
+    tcg_gen_andi_i32(tmp, arg[2].in, 1 << arg[2].imm);
     tcg_gen_movcond_i32(par[0],
                         arg[0].out, tmp, zero,
                         arg[1].in, arg[0].in);
-- 
2.11.0

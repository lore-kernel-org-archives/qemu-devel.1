Received: from eggs.gnu.org ([2001:4830:134:3::10]:42065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en99U-0000Mi-L9
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en99R-0000rZ-H9
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:32:08 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:35126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en99R-0000rS-88
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:32:05 -0500
Received: by mail-pl0-x244.google.com with SMTP id bb3so3538441plb.2
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 12:32:05 -0800 (PST)
Received: from cloudburst.twiddle.net ([50.0.192.64])
	by smtp.gmail.com with ESMTPSA id
	y7sm48203797pfe.26.2018.02.17.12.32.02 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 17 Feb 2018 12:32:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 12:31:30 -0800
Message-Id: <20180217203132.31780-18-richard.henderson@linaro.org>
In-Reply-To: <20180217203132.31780-1-richard.henderson@linaro.org>
References: <20180217203132.31780-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 17/19] target/hppa: Convert fp fused
 multiply-add insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c  | 79 ++++++++++++++++--------------------------------
 target/hppa/insns.decode | 12 ++++++++
 2 files changed, 38 insertions(+), 53 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 5abe4cd610..1d2134ac06 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -882,14 +882,6 @@ static unsigned assemble_rb64(uint32_t insn)
     return r1 * 32 + r0;
 }
 
-static unsigned assemble_rc64(uint32_t insn)
-{
-    unsigned r2 = extract32(insn, 8, 1);
-    unsigned r1 = extract32(insn, 13, 3);
-    unsigned r0 = extract32(insn, 9, 2);
-    return r2 * 32 + r1 * 4 + r0;
-}
-
 static inline unsigned assemble_sr3(uint32_t insn)
 {
     unsigned s2 = extract32(insn, 13, 1);
@@ -4033,67 +4025,52 @@ static void trans_fmpysub_d(DisasContext *ctx, arg_mpyadd *a, uint32_t insn)
     do_fmpyadd_d(ctx, a, true);
 }
 
-static void trans_fmpyfadd_s(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
+static void trans_fmpyfadd_f(DisasContext *ctx, arg_fmpyfadd_f *a,
+                             uint32_t insn)
 {
-    unsigned rt = assemble_rt64(insn);
-    unsigned neg = extract32(insn, 5, 1);
-    unsigned rm1 = assemble_ra64(insn);
-    unsigned rm2 = assemble_rb64(insn);
-    unsigned ra3 = assemble_rc64(insn);
-    TCGv_i32 a, b, c;
+    TCGv_i32 x, y, z;
 
     nullify_over(ctx);
-    a = load_frw0_i32(rm1);
-    b = load_frw0_i32(rm2);
-    c = load_frw0_i32(ra3);
+    x = load_frw0_i32(a->rm1);
+    y = load_frw0_i32(a->rm2);
+    z = load_frw0_i32(a->ra3);
 
-    if (neg) {
-        gen_helper_fmpynfadd_s(a, cpu_env, a, b, c);
+    if (a->neg) {
+        gen_helper_fmpynfadd_s(x, cpu_env, x, y, z);
     } else {
-        gen_helper_fmpyfadd_s(a, cpu_env, a, b, c);
+        gen_helper_fmpyfadd_s(x, cpu_env, x, y, z);
     }
 
-    tcg_temp_free_i32(b);
-    tcg_temp_free_i32(c);
-    save_frw_i32(rt, a);
-    tcg_temp_free_i32(a);
+    tcg_temp_free_i32(y);
+    tcg_temp_free_i32(z);
+    save_frw_i32(a->t, x);
+    tcg_temp_free_i32(x);
     nullify_end(ctx);
 }
 
-static void trans_fmpyfadd_d(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
+static void trans_fmpyfadd_d(DisasContext *ctx, arg_fmpyfadd_d *a,
+                             uint32_t insn)
 {
-    unsigned rt = extract32(insn, 0, 5);
-    unsigned neg = extract32(insn, 5, 1);
-    unsigned rm1 = extract32(insn, 21, 5);
-    unsigned rm2 = extract32(insn, 16, 5);
-    unsigned ra3 = assemble_rc64(insn);
-    TCGv_i64 a, b, c;
+    TCGv_i64 x, y, z;
 
     nullify_over(ctx);
-    a = load_frd0(rm1);
-    b = load_frd0(rm2);
-    c = load_frd0(ra3);
+    x = load_frd0(a->rm1);
+    y = load_frd0(a->rm2);
+    z = load_frd0(a->ra3);
 
-    if (neg) {
-        gen_helper_fmpynfadd_d(a, cpu_env, a, b, c);
+    if (a->neg) {
+        gen_helper_fmpynfadd_d(x, cpu_env, x, y, z);
     } else {
-        gen_helper_fmpyfadd_d(a, cpu_env, a, b, c);
+        gen_helper_fmpyfadd_d(x, cpu_env, x, y, z);
     }
 
-    tcg_temp_free_i64(b);
-    tcg_temp_free_i64(c);
-    save_frd(rt, a);
-    tcg_temp_free_i64(a);
+    tcg_temp_free_i64(y);
+    tcg_temp_free_i64(z);
+    save_frd(a->t, x);
+    tcg_temp_free_i64(x);
     nullify_end(ctx);
 }
 
-static const DisasInsn table_fp_fused[] = {
-    { 0xb8000000u, 0xfc000800u, trans_fmpyfadd_s },
-    { 0xb8000800u, 0xfc0019c0u, trans_fmpyfadd_d }
-};
-
 static void translate_table_int(DisasContext *ctx, uint32_t insn,
                                 const DisasInsn table[], size_t n)
 {
@@ -4129,10 +4106,6 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
     case 0x0E:
         translate_table(ctx, insn, table_float_0e);
         return;
-
-    case 0x2E:
-        translate_table(ctx, insn, table_fp_fused);
-        return;
     }
     gen_illegal(ctx);
 }
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index ddbbaefd83..83612c562e 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -39,6 +39,10 @@
 
 %rm64		1:1 16:5
 %rt64		6:1 0:5
+%ra64		7:1 21:5
+%rb64		12:1 16:5
+%rc64		8:1 13:3 9:2
+%rc32		13:3 9:2
 
 %im5_0		0:s1 1:4
 %im5_16		16:s1 17:4
@@ -336,3 +340,11 @@ blr		111010 l:5   x:5   010 00000000000 n:1 0
 bv		111010 b:5   x:5   110 00000000000 n:1 0
 bve		111010 b:5   00000 110 10000000000 n:1 -	l=0
 bve		111010 b:5   00000 111 10000000000 n:1 -	l=2
+
+####
+# FP Fused Multiple-Add
+####
+
+fmpyfadd_f	101110 ..... ..... ... . 0 ... . . neg:1 ..... \
+		rm1=%ra64 rm2=%rb64 ra3=%rc64 t=%rt64
+fmpyfadd_d	101110 rm1:5 rm2:5 ... 0 1 ..0 0 0 neg:1 t:5	ra3=%rc32
-- 
2.14.3

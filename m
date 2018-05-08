Received: from eggs.gnu.org ([2001:4830:134:3::10]:59496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fG4KD-0006YX-Tq
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fG4KC-00087t-PX
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:14:45 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:45547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fG4KC-00087N-Jb
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:14:44 -0400
Received: by mail-pf0-x242.google.com with SMTP id c10so24105242pfi.12
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 08:14:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  8 May 2018 08:14:30 -0700
Message-Id: <20180508151437.4232-4-richard.henderson@linaro.org>
In-Reply-To: <20180508151437.4232-1-richard.henderson@linaro.org>
References: <20180508151437.4232-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 03/10] target/xtensa: Use new min/max
 expanders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The generic expanders replace nearly identical code in the translator.

Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/translate.c | 50 ++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 4f6d03059f..bad5cdb009 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1527,10 +1527,8 @@ static void translate_clamps(DisasContext *dc, const uint32_t arg[],
         TCGv_i32 tmp1 = tcg_const_i32(-1u << arg[2]);
         TCGv_i32 tmp2 = tcg_const_i32((1 << arg[2]) - 1);
 
-        tcg_gen_movcond_i32(TCG_COND_GT, tmp1,
-                            cpu_R[arg[1]], tmp1, cpu_R[arg[1]], tmp1);
-        tcg_gen_movcond_i32(TCG_COND_LT, cpu_R[arg[0]],
-                            tmp1, tmp2, tmp1, tmp2);
+        tcg_gen_smax_i32(tmp1, tmp1, cpu_R[arg[1]]);
+        tcg_gen_smin_i32(cpu_R[arg[0]], tmp1, tmp2);
         tcg_temp_free(tmp1);
         tcg_temp_free(tmp2);
     }
@@ -1855,13 +1853,35 @@ static void translate_memw(DisasContext *dc, const uint32_t arg[],
     tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
 }
 
-static void translate_minmax(DisasContext *dc, const uint32_t arg[],
-                             const uint32_t par[])
+static void translate_smin(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
 {
     if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
-        tcg_gen_movcond_i32(par[0], cpu_R[arg[0]],
-                            cpu_R[arg[1]], cpu_R[arg[2]],
-                            cpu_R[arg[1]], cpu_R[arg[2]]);
+        tcg_gen_smin_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    }
+}
+
+static void translate_umin(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
+        tcg_gen_umin_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    }
+}
+
+static void translate_smax(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
+        tcg_gen_smax_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
+    }
+}
+
+static void translate_umax(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
+        tcg_gen_umax_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[2]]);
     }
 }
 
@@ -2984,23 +3004,19 @@ static const XtensaOpcodeOps core_ops[] = {
         .par = (const uint32_t[]){TCG_COND_NE},
     }, {
         .name = "max",
-        .translate = translate_minmax,
-        .par = (const uint32_t[]){TCG_COND_GE},
+        .translate = translate_smax,
     }, {
         .name = "maxu",
-        .translate = translate_minmax,
-        .par = (const uint32_t[]){TCG_COND_GEU},
+        .translate = translate_umax,
     }, {
         .name = "memw",
         .translate = translate_memw,
     }, {
         .name = "min",
-        .translate = translate_minmax,
-        .par = (const uint32_t[]){TCG_COND_LT},
+        .translate = translate_smin,
     }, {
         .name = "minu",
-        .translate = translate_minmax,
-        .par = (const uint32_t[]){TCG_COND_LTU},
+        .translate = translate_umin,
     }, {
         .name = "mov",
         .translate = translate_mov,
-- 
2.17.0

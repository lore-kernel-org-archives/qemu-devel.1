Received: from eggs.gnu.org ([2001:4830:134:3::10]:58018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMsL-0006D3-CG
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMsJ-0007Ci-2K
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:57 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233]:44916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxMsG-0006zO-Dk
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:53 -0400
Received: by mail-lj1-x233.google.com with SMTP id q127-v6so4785936ljq.11
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 18:44:45 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue,  4 Sep 2018 18:43:48 -0700
Message-Id: <20180905014352.970-12-jcmvbkbc@gmail.com>
In-Reply-To: <20180905014352.970-1-jcmvbkbc@gmail.com>
References: <20180905014352.970-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 11/15] target/xtensa: change SR number checks
 to assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Opcode decoding with libisa takes care about range of valid group SRs,
like CCOMPARE, IBREAKA, DBREAKA or DBREAKC. Turn range checks in wsr
implementations into assertions.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 65 +++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 93289fd37f1f..0af3f1b16792 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -634,38 +634,34 @@ static bool gen_wsr_atomctl(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 static bool gen_wsr_ibreaka(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     unsigned id = sr - IBREAKA;
+    TCGv_i32 tmp = tcg_const_i32(id);
 
-    if (id < dc->config->nibreak) {
-        TCGv_i32 tmp = tcg_const_i32(id);
-        gen_helper_wsr_ibreaka(cpu_env, tmp, v);
-        tcg_temp_free(tmp);
-        gen_jumpi_check_loop_end(dc, 0);
-        return true;
-    }
-    return false;
+    assert(id < dc->config->nibreak);
+    gen_helper_wsr_ibreaka(cpu_env, tmp, v);
+    tcg_temp_free(tmp);
+    gen_jumpi_check_loop_end(dc, 0);
+    return true;
 }
 
 static bool gen_wsr_dbreaka(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     unsigned id = sr - DBREAKA;
+    TCGv_i32 tmp = tcg_const_i32(id);
 
-    if (id < dc->config->ndbreak) {
-        TCGv_i32 tmp = tcg_const_i32(id);
-        gen_helper_wsr_dbreaka(cpu_env, tmp, v);
-        tcg_temp_free(tmp);
-    }
+    assert(id < dc->config->ndbreak);
+    gen_helper_wsr_dbreaka(cpu_env, tmp, v);
+    tcg_temp_free(tmp);
     return false;
 }
 
 static bool gen_wsr_dbreakc(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     unsigned id = sr - DBREAKC;
+    TCGv_i32 tmp = tcg_const_i32(id);
 
-    if (id < dc->config->ndbreak) {
-        TCGv_i32 tmp = tcg_const_i32(id);
-        gen_helper_wsr_dbreakc(cpu_env, tmp, v);
-        tcg_temp_free(tmp);
-    }
+    assert(id < dc->config->ndbreak);
+    gen_helper_wsr_dbreakc(cpu_env, tmp, v);
+    tcg_temp_free(tmp);
     return false;
 }
 
@@ -764,26 +760,23 @@ static bool gen_wsr_icountlevel(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 static bool gen_wsr_ccompare(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     uint32_t id = sr - CCOMPARE;
-    bool ret = false;
-
-    if (id < dc->config->nccompare) {
-        uint32_t int_bit = 1 << dc->config->timerint[id];
-        TCGv_i32 tmp = tcg_const_i32(id);
+    uint32_t int_bit = 1 << dc->config->timerint[id];
+    TCGv_i32 tmp = tcg_const_i32(id);
 
-        tcg_gen_mov_i32(cpu_SR[sr], v);
-        tcg_gen_andi_i32(cpu_SR[INTSET], cpu_SR[INTSET], ~int_bit);
-        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-        }
-        gen_helper_update_ccompare(cpu_env, tmp);
-        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
-            gen_jumpi_check_loop_end(dc, 0);
-            ret = true;
-        }
-        tcg_temp_free(tmp);
+    assert(id < dc->config->nccompare);
+    tcg_gen_mov_i32(cpu_SR[sr], v);
+    tcg_gen_andi_i32(cpu_SR[INTSET], cpu_SR[INTSET], ~int_bit);
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
     }
-    return ret;
+    gen_helper_update_ccompare(cpu_env, tmp);
+    tcg_temp_free(tmp);
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+        gen_io_end();
+        gen_jumpi_check_loop_end(dc, 0);
+        return true;
+    }
+    return false;
 }
 #else
 static void gen_check_interrupts(DisasContext *dc)
-- 
2.11.0

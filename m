Received: from eggs.gnu.org ([2001:4830:134:3::10]:58070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMsN-0006FW-U4
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMsL-0007Fj-QQ
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:59 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132]:35039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxMsL-00078n-B9
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:57 -0400
Received: by mail-lf1-x132.google.com with SMTP id q13-v6so4608435lfc.2
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 18:44:52 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue,  4 Sep 2018 18:43:51 -0700
Message-Id: <20180905014352.970-15-jcmvbkbc@gmail.com>
In-Reply-To: <20180905014352.970-1-jcmvbkbc@gmail.com>
References: <20180905014352.970-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 14/15] target/xtensa: make rsr/wsr helpers
 return void
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

Now that all logic for TB termination is extracted from rsr/wsr their
return value is not used and may be dropped.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 102 ++++++++++++++++------------------------------
 1 file changed, 36 insertions(+), 66 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 77ee3162b2a3..19a829286d22 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -496,7 +496,7 @@ static bool check_sr(DisasContext *dc, uint32_t sr, unsigned access)
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool gen_rsr_ccount(DisasContext *dc, TCGv_i32 d, uint32_t sr)
+static void gen_rsr_ccount(DisasContext *dc, TCGv_i32 d, uint32_t sr)
 {
     if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
@@ -506,22 +506,20 @@ static bool gen_rsr_ccount(DisasContext *dc, TCGv_i32 d, uint32_t sr)
     if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
     }
-    return true;
 }
 
-static bool gen_rsr_ptevaddr(DisasContext *dc, TCGv_i32 d, uint32_t sr)
+static void gen_rsr_ptevaddr(DisasContext *dc, TCGv_i32 d, uint32_t sr)
 {
     tcg_gen_shri_i32(d, cpu_SR[EXCVADDR], 10);
     tcg_gen_or_i32(d, d, cpu_SR[sr]);
     tcg_gen_andi_i32(d, d, 0xfffffffc);
-    return false;
 }
 #endif
 
-static bool gen_rsr(DisasContext *dc, TCGv_i32 d, uint32_t sr)
+static void gen_rsr(DisasContext *dc, TCGv_i32 d, uint32_t sr)
 {
-    static bool (* const rsr_handler[256])(DisasContext *dc,
-            TCGv_i32 d, uint32_t sr) = {
+    static void (* const rsr_handler[256])(DisasContext *dc,
+                                           TCGv_i32 d, uint32_t sr) = {
 #ifndef CONFIG_USER_ONLY
         [CCOUNT] = gen_rsr_ccount,
         [INTSET] = gen_rsr_ccount,
@@ -530,26 +528,23 @@ static bool gen_rsr(DisasContext *dc, TCGv_i32 d, uint32_t sr)
     };
 
     if (rsr_handler[sr]) {
-        return rsr_handler[sr](dc, d, sr);
+        rsr_handler[sr](dc, d, sr);
     } else {
         tcg_gen_mov_i32(d, cpu_SR[sr]);
-        return false;
     }
 }
 
-static bool gen_wsr_lbeg(DisasContext *dc, uint32_t sr, TCGv_i32 s)
+static void gen_wsr_lbeg(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
     gen_helper_wsr_lbeg(cpu_env, s);
-    return false;
 }
 
-static bool gen_wsr_lend(DisasContext *dc, uint32_t sr, TCGv_i32 s)
+static void gen_wsr_lend(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
     gen_helper_wsr_lend(cpu_env, s);
-    return false;
 }
 
-static bool gen_wsr_sar(DisasContext *dc, uint32_t sr, TCGv_i32 s)
+static void gen_wsr_sar(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
     tcg_gen_andi_i32(cpu_SR[sr], s, 0x3f);
     if (dc->sar_m32_5bit) {
@@ -557,77 +552,65 @@ static bool gen_wsr_sar(DisasContext *dc, uint32_t sr, TCGv_i32 s)
     }
     dc->sar_5bit = false;
     dc->sar_m32_5bit = false;
-    return false;
 }
 
-static bool gen_wsr_br(DisasContext *dc, uint32_t sr, TCGv_i32 s)
+static void gen_wsr_br(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
     tcg_gen_andi_i32(cpu_SR[sr], s, 0xffff);
-    return false;
 }
 
-static bool gen_wsr_litbase(DisasContext *dc, uint32_t sr, TCGv_i32 s)
+static void gen_wsr_litbase(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
     tcg_gen_andi_i32(cpu_SR[sr], s, 0xfffff001);
-    return true;
 }
 
-static bool gen_wsr_acchi(DisasContext *dc, uint32_t sr, TCGv_i32 s)
+static void gen_wsr_acchi(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
     tcg_gen_ext8s_i32(cpu_SR[sr], s);
-    return false;
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool gen_wsr_windowbase(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_windowbase(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     gen_helper_wsr_windowbase(cpu_env, v);
-    return true;
 }
 
-static bool gen_wsr_windowstart(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_windowstart(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_andi_i32(cpu_SR[sr], v, (1 << dc->config->nareg / 4) - 1);
-    return true;
 }
 
-static bool gen_wsr_ptevaddr(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_ptevaddr(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_andi_i32(cpu_SR[sr], v, 0xffc00000);
-    return false;
 }
 
-static bool gen_wsr_rasid(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_rasid(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     gen_helper_wsr_rasid(cpu_env, v);
-    return true;
 }
 
-static bool gen_wsr_tlbcfg(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_tlbcfg(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_andi_i32(cpu_SR[sr], v, 0x01130000);
-    return false;
 }
 
-static bool gen_wsr_ibreakenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_ibreakenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     gen_helper_wsr_ibreakenable(cpu_env, v);
-    return true;
 }
 
-static bool gen_wsr_memctl(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_memctl(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     gen_helper_wsr_memctl(cpu_env, v);
-    return false;
 }
 
-static bool gen_wsr_atomctl(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_atomctl(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_andi_i32(cpu_SR[sr], v, 0x3f);
-    return false;
 }
 
-static bool gen_wsr_ibreaka(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_ibreaka(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     unsigned id = sr - IBREAKA;
     TCGv_i32 tmp = tcg_const_i32(id);
@@ -635,10 +618,9 @@ static bool gen_wsr_ibreaka(DisasContext *dc, uint32_t sr, TCGv_i32 v)
     assert(id < dc->config->nibreak);
     gen_helper_wsr_ibreaka(cpu_env, tmp, v);
     tcg_temp_free(tmp);
-    return true;
 }
 
-static bool gen_wsr_dbreaka(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_dbreaka(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     unsigned id = sr - DBREAKA;
     TCGv_i32 tmp = tcg_const_i32(id);
@@ -646,10 +628,9 @@ static bool gen_wsr_dbreaka(DisasContext *dc, uint32_t sr, TCGv_i32 v)
     assert(id < dc->config->ndbreak);
     gen_helper_wsr_dbreaka(cpu_env, tmp, v);
     tcg_temp_free(tmp);
-    return false;
 }
 
-static bool gen_wsr_dbreakc(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_dbreakc(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     unsigned id = sr - DBREAKC;
     TCGv_i32 tmp = tcg_const_i32(id);
@@ -657,13 +638,11 @@ static bool gen_wsr_dbreakc(DisasContext *dc, uint32_t sr, TCGv_i32 v)
     assert(id < dc->config->ndbreak);
     gen_helper_wsr_dbreakc(cpu_env, tmp, v);
     tcg_temp_free(tmp);
-    return false;
 }
 
-static bool gen_wsr_cpenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_cpenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_andi_i32(cpu_SR[sr], v, 0xff);
-    return true;
 }
 
 static void gen_check_interrupts(DisasContext *dc)
@@ -677,15 +656,14 @@ static void gen_check_interrupts(DisasContext *dc)
     }
 }
 
-static bool gen_wsr_intset(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_intset(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_andi_i32(cpu_SR[sr], v,
             dc->config->inttype_mask[INTTYPE_SOFTWARE]);
     gen_check_interrupts(dc);
-    return true;
 }
 
-static bool gen_wsr_intclear(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_intclear(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
 
@@ -696,17 +674,15 @@ static bool gen_wsr_intclear(DisasContext *dc, uint32_t sr, TCGv_i32 v)
     tcg_gen_andc_i32(cpu_SR[INTSET], cpu_SR[INTSET], tmp);
     tcg_temp_free(tmp);
     gen_check_interrupts(dc);
-    return true;
 }
 
-static bool gen_wsr_intenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_intenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_mov_i32(cpu_SR[sr], v);
     gen_check_interrupts(dc);
-    return true;
 }
 
-static bool gen_wsr_ps(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_ps(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     uint32_t mask = PS_WOE | PS_CALLINC | PS_OWB |
         PS_UM | PS_EXCM | PS_INTLEVEL;
@@ -716,10 +692,9 @@ static bool gen_wsr_ps(DisasContext *dc, uint32_t sr, TCGv_i32 v)
     }
     tcg_gen_andi_i32(cpu_SR[sr], v, mask);
     gen_check_interrupts(dc);
-    return true;
 }
 
-static bool gen_wsr_ccount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_ccount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
@@ -728,26 +703,23 @@ static bool gen_wsr_ccount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
     if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
     }
-    return true;
 }
 
-static bool gen_wsr_icount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_icount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     if (dc->icount) {
         tcg_gen_mov_i32(dc->next_icount, v);
     } else {
         tcg_gen_mov_i32(cpu_SR[sr], v);
     }
-    return false;
 }
 
-static bool gen_wsr_icountlevel(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_icountlevel(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_andi_i32(cpu_SR[sr], v, 0xf);
-    return true;
 }
 
-static bool gen_wsr_ccompare(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static void gen_wsr_ccompare(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     uint32_t id = sr - CCOMPARE;
     uint32_t int_bit = 1 << dc->config->timerint[id];
@@ -764,7 +736,6 @@ static bool gen_wsr_ccompare(DisasContext *dc, uint32_t sr, TCGv_i32 v)
     if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
     }
-    return true;
 }
 #else
 static void gen_check_interrupts(DisasContext *dc)
@@ -772,10 +743,10 @@ static void gen_check_interrupts(DisasContext *dc)
 }
 #endif
 
-static bool gen_wsr(DisasContext *dc, uint32_t sr, TCGv_i32 s)
+static void gen_wsr(DisasContext *dc, uint32_t sr, TCGv_i32 s)
 {
-    static bool (* const wsr_handler[256])(DisasContext *dc,
-            uint32_t sr, TCGv_i32 v) = {
+    static void (* const wsr_handler[256])(DisasContext *dc,
+                                           uint32_t sr, TCGv_i32 v) = {
         [LBEG] = gen_wsr_lbeg,
         [LEND] = gen_wsr_lend,
         [SAR] = gen_wsr_sar,
@@ -813,10 +784,9 @@ static bool gen_wsr(DisasContext *dc, uint32_t sr, TCGv_i32 s)
     };
 
     if (wsr_handler[sr]) {
-        return wsr_handler[sr](dc, sr, s);
+        wsr_handler[sr](dc, sr, s);
     } else {
         tcg_gen_mov_i32(cpu_SR[sr], s);
-        return false;
     }
 }
 
-- 
2.11.0

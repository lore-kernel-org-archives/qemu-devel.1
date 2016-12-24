Received: from eggs.gnu.org ([2001:4830:134:3::10]:55595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWI-0006tf-2r
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWG-0005rN-Ua
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:18 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdWG-0005qz-NS
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:16 -0500
Received: by mail-pg0-x241.google.com with SMTP id b1so2475916pgc.1
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:16 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.01.15 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:01:15 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:15 -0800
Message-Id: <20161224040042.12654-39-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 38/65] target-arm: Use clz opcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/helper-a64.c    | 10 ----------
 target/arm/helper-a64.h    |  2 --
 target/arm/helper.c        |  5 -----
 target/arm/helper.h        |  1 -
 target/arm/translate-a64.c |  8 ++++----
 target/arm/translate.c     |  6 +++---
 6 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 98b97df..77999ff 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -54,11 +54,6 @@ int64_t HELPER(sdiv64)(int64_t num, int64_t den)
     return num / den;
 }
 
-uint64_t HELPER(clz64)(uint64_t x)
-{
-    return clz64(x);
-}
-
 uint64_t HELPER(cls64)(uint64_t x)
 {
     return clrsb64(x);
@@ -69,11 +64,6 @@ uint32_t HELPER(cls32)(uint32_t x)
     return clrsb32(x);
 }
 
-uint32_t HELPER(clz32)(uint32_t x)
-{
-    return clz32(x);
-}
-
 uint64_t HELPER(rbit64)(uint64_t x)
 {
     return revbit64(x);
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index dd32000..d320f96 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -18,10 +18,8 @@
  */
 DEF_HELPER_FLAGS_2(udiv64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(sdiv64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-DEF_HELPER_FLAGS_1(clz64, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(cls64, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(cls32, TCG_CALL_NO_RWG_SE, i32, i32)
-DEF_HELPER_FLAGS_1(clz32, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(rbit64, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_3(vfp_cmps_a64, i64, f32, f32, ptr)
 DEF_HELPER_3(vfp_cmpes_a64, i64, f32, f32, ptr)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b5b65ca..0cafdbc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5718,11 +5718,6 @@ uint32_t HELPER(uxtb16)(uint32_t x)
     return res;
 }
 
-uint32_t HELPER(clz)(uint32_t x)
-{
-    return clz32(x);
-}
-
 int32_t HELPER(sdiv)(int32_t num, int32_t den)
 {
     if (den == 0)
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 84aa637..df86bf7 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1,4 +1,3 @@
-DEF_HELPER_FLAGS_1(clz, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(sxtb16, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(uxtb16, TCG_CALL_NO_RWG_SE, i32, i32)
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5ba5c3e..7ef1548 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3953,11 +3953,11 @@ static void handle_clz(DisasContext *s, unsigned int sf,
     tcg_rn = cpu_reg(s, rn);
 
     if (sf) {
-        gen_helper_clz64(tcg_rd, tcg_rn);
+        tcg_gen_clzi_i64(tcg_rd, tcg_rn, 64);
     } else {
         TCGv_i32 tcg_tmp32 = tcg_temp_new_i32();
         tcg_gen_extrl_i64_i32(tcg_tmp32, tcg_rn);
-        gen_helper_clz(tcg_tmp32, tcg_tmp32);
+        tcg_gen_clzi_i32(tcg_tmp32, tcg_tmp32, 32);
         tcg_gen_extu_i32_i64(tcg_rd, tcg_tmp32);
         tcg_temp_free_i32(tcg_tmp32);
     }
@@ -7590,7 +7590,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
     switch (opcode) {
     case 0x4: /* CLS, CLZ */
         if (u) {
-            gen_helper_clz64(tcg_rd, tcg_rn);
+            tcg_gen_clzi_i64(tcg_rd, tcg_rn, 64);
         } else {
             gen_helper_cls64(tcg_rd, tcg_rn);
         }
@@ -10260,7 +10260,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     goto do_cmop;
                 case 0x4: /* CLS */
                     if (u) {
-                        gen_helper_clz32(tcg_res, tcg_op);
+                        tcg_gen_clzi_i32(tcg_res, tcg_op, 32);
                     } else {
                         gen_helper_cls32(tcg_res, tcg_op);
                     }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 08da9ac..c9186b6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7037,7 +7037,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             switch (size) {
                             case 0: gen_helper_neon_clz_u8(tmp, tmp); break;
                             case 1: gen_helper_neon_clz_u16(tmp, tmp); break;
-                            case 2: gen_helper_clz(tmp, tmp); break;
+                            case 2: tcg_gen_clzi_i32(tmp, tmp, 32); break;
                             default: abort();
                             }
                             break;
@@ -8219,7 +8219,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 ARCH(5);
                 rd = (insn >> 12) & 0xf;
                 tmp = load_reg(s, rm);
-                gen_helper_clz(tmp, tmp);
+                tcg_gen_clzi_i32(tmp, tmp, 32);
                 store_reg(s, rd, tmp);
             } else {
                 goto illegal_op;
@@ -9992,7 +9992,7 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
                     tcg_temp_free_i32(tmp2);
                     break;
                 case 0x18: /* clz */
-                    gen_helper_clz(tmp, tmp);
+                    tcg_gen_clzi_i32(tmp, tmp, 32);
                     break;
                 case 0x20:
                 case 0x21:
-- 
2.9.3

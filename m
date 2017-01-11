Received: from eggs.gnu.org ([2001:4830:134:3::10]:35290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Uw-0006HS-La
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Uv-0003I7-T5
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:46 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8Uv-0003Hg-Nt
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:45 -0500
Received: by mail-pf0-x241.google.com with SMTP id 127so31458056pfg.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:45 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:42 -0800
Message-Id: <20170111021820.24416-28-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 27/65] target-alpha: Use the ctz and clz opcodes
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

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/alpha/helper.h     |  2 --
 target/alpha/int_helper.c | 10 ----------
 target/alpha/translate.c  |  4 ++--
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/target/alpha/helper.h b/target/alpha/helper.h
index 004221d..eed3906 100644
--- a/target/alpha/helper.h
+++ b/target/alpha/helper.h
@@ -4,8 +4,6 @@ DEF_HELPER_FLAGS_1(load_pcc, TCG_CALL_NO_RWG_SE, i64, env)
 DEF_HELPER_FLAGS_3(check_overflow, TCG_CALL_NO_WG, void, env, i64, i64)
 
 DEF_HELPER_FLAGS_1(ctpop, TCG_CALL_NO_RWG_SE, i64, i64)
-DEF_HELPER_FLAGS_1(ctlz, TCG_CALL_NO_RWG_SE, i64, i64)
-DEF_HELPER_FLAGS_1(cttz, TCG_CALL_NO_RWG_SE, i64, i64)
 
 DEF_HELPER_FLAGS_2(zap, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(zapnot, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/alpha/int_helper.c b/target/alpha/int_helper.c
index 19bebfe..3c303bd 100644
--- a/target/alpha/int_helper.c
+++ b/target/alpha/int_helper.c
@@ -29,16 +29,6 @@ uint64_t helper_ctpop(uint64_t arg)
     return ctpop64(arg);
 }
 
-uint64_t helper_ctlz(uint64_t arg)
-{
-    return clz64(arg);
-}
-
-uint64_t helper_cttz(uint64_t arg)
-{
-    return ctz64(arg);
-}
-
 uint64_t helper_zapnot(uint64_t val, uint64_t mskb)
 {
     uint64_t mask;
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 5ac2277..6e2e563 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2555,14 +2555,14 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
             REQUIRE_TB_FLAG(TB_FLAGS_AMASK_CIX);
             REQUIRE_REG_31(ra);
             REQUIRE_NO_LIT;
-            gen_helper_ctlz(vc, vb);
+            tcg_gen_clzi_i64(vc, vb, 64);
             break;
         case 0x33:
             /* CTTZ */
             REQUIRE_TB_FLAG(TB_FLAGS_AMASK_CIX);
             REQUIRE_REG_31(ra);
             REQUIRE_NO_LIT;
-            gen_helper_cttz(vc, vb);
+            tcg_gen_ctzi_i64(vc, vb, 64);
             break;
         case 0x34:
             /* UNPKBW */
-- 
2.9.3

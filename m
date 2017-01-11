Received: from eggs.gnu.org ([2001:4830:134:3::10]:35730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VJ-0006ht-Kv
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VI-0003ZQ-TN
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:09 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8VI-0003Yx-Nz
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:08 -0500
Received: by mail-pf0-x242.google.com with SMTP id 127so31459592pfg.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:19:08 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:18:10 -0800
Message-Id: <20170111021820.24416-56-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 55/65] target-alpha: Use ctpop helper
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
 target/alpha/helper.h     | 2 --
 target/alpha/int_helper.c | 5 -----
 target/alpha/translate.c  | 2 +-
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/alpha/helper.h b/target/alpha/helper.h
index eed3906..d60f208 100644
--- a/target/alpha/helper.h
+++ b/target/alpha/helper.h
@@ -3,8 +3,6 @@ DEF_HELPER_FLAGS_1(load_pcc, TCG_CALL_NO_RWG_SE, i64, env)
 
 DEF_HELPER_FLAGS_3(check_overflow, TCG_CALL_NO_WG, void, env, i64, i64)
 
-DEF_HELPER_FLAGS_1(ctpop, TCG_CALL_NO_RWG_SE, i64, i64)
-
 DEF_HELPER_FLAGS_2(zap, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(zapnot, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 
diff --git a/target/alpha/int_helper.c b/target/alpha/int_helper.c
index 3c303bd..e43b50a 100644
--- a/target/alpha/int_helper.c
+++ b/target/alpha/int_helper.c
@@ -24,11 +24,6 @@
 #include "qemu/host-utils.h"
 
 
-uint64_t helper_ctpop(uint64_t arg)
-{
-    return ctpop64(arg);
-}
-
 uint64_t helper_zapnot(uint64_t val, uint64_t mskb)
 {
     uint64_t mask;
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 6e2e563..055286a 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2541,7 +2541,7 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
             REQUIRE_TB_FLAG(TB_FLAGS_AMASK_CIX);
             REQUIRE_REG_31(ra);
             REQUIRE_NO_LIT;
-            gen_helper_ctpop(vc, vb);
+            tcg_gen_ctpop_i64(vc, vb);
             break;
         case 0x31:
             /* PERR */
-- 
2.9.3

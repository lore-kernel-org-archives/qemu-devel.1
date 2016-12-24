Received: from eggs.gnu.org ([2001:4830:134:3::10]:55835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWU-00076E-VM
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWT-00062g-Tk
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:31 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdWT-00062C-PH
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:29 -0500
Received: by mail-pg0-x244.google.com with SMTP id i5so2480972pgh.2
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:29 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.01.28 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:01:28 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:32 -0800
Message-Id: <20161224040042.12654-56-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 55/65] target-alpha: Use ctpop helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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

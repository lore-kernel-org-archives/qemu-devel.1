Received: from eggs.gnu.org ([2001:4830:134:3::10]:57562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDZeF-0008Hs-Nx
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDZeB-0000aZ-98
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:05:07 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDZeB-0000Zt-3h
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:05:03 -0400
Received: by mail-pg0-x243.google.com with SMTP id j11-v6so8784915pgf.2
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 11:05:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  1 May 2018 11:04:55 -0700
Message-Id: <20180501180455.11214-3-richard.henderson@linaro.org>
In-Reply-To: <20180501180455.11214-1-richard.henderson@linaro.org>
References: <20180501180455.11214-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] target/arm: Tidy condition in
 disas_simd_two_reg_misc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Path analysis shows that size == 3 && !is_q has been eliminated.

Fixes: Coverity CID1385853
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 97950dce1a..6d49f30b4a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11473,7 +11473,11 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         /* All 64-bit element operations can be shared with scalar 2misc */
         int pass;
 
-        for (pass = 0; pass < (is_q ? 2 : 1); pass++) {
+        /* Coverity claims (size == 3 && !is_q) has been eliminated
+         * from all paths leading to here.
+         */
+        tcg_debug_assert(is_q);
+        for (pass = 0; pass < 2; pass++) {
             TCGv_i64 tcg_op = tcg_temp_new_i64();
             TCGv_i64 tcg_res = tcg_temp_new_i64();
 
-- 
2.14.3

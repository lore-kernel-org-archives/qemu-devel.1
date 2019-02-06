Received: from eggs.gnu.org ([209.51.188.92]:50797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grFbf-0007H2-0e
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grFQY-0003LC-4V
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:07:14 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grFQX-0003Kr-V1
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:07:14 -0500
Received: by mail-wr1-x444.google.com with SMTP id x10so6057004wrs.8
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 21:07:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Feb 2019 05:07:00 +0000
Message-Id: <20190206050701.11847-5-richard.henderson@linaro.org>
In-Reply-To: <20190206050701.11847-1-richard.henderson@linaro.org>
References: <20190206050701.11847-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 4/5] target/arm: Use tcg integer min/max
 primitives for neon
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

The 32-bit PMIN/PMAX has been decomposed to scalars,
and so can be trivially expanded inline.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index df1cd3fa3e..f0101d2788 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4760,10 +4760,10 @@ static inline void gen_neon_rsb(int size, TCGv_i32 t0, TCGv_i32 t1)
 }
 
 /* 32-bit pairwise ops end up the same as the elementwise versions.  */
-#define gen_helper_neon_pmax_s32  gen_helper_neon_max_s32
-#define gen_helper_neon_pmax_u32  gen_helper_neon_max_u32
-#define gen_helper_neon_pmin_s32  gen_helper_neon_min_s32
-#define gen_helper_neon_pmin_u32  gen_helper_neon_min_u32
+#define gen_helper_neon_pmax_s32  tcg_gen_smax_i32
+#define gen_helper_neon_pmax_u32  tcg_gen_umax_i32
+#define gen_helper_neon_pmin_s32  tcg_gen_smin_i32
+#define gen_helper_neon_pmin_u32  tcg_gen_umin_i32
 
 #define GEN_NEON_INTEGER_OP_ENV(name) do { \
     switch ((size << 1) | u) { \
-- 
2.17.2

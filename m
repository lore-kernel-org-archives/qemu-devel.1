Received: from eggs.gnu.org ([209.51.188.92]:42449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJTo-0006io-Kb
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJTn-0000U2-N8
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:00 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsJTn-0000Td-HT
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:38:59 -0500
Received: by mail-pl1-x643.google.com with SMTP id k15so2598642pls.8
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 19:38:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  8 Feb 2019 19:38:39 -0800
Message-Id: <20190209033847.9014-5-richard.henderson@linaro.org>
In-Reply-To: <20190209033847.9014-1-richard.henderson@linaro.org>
References: <20190209033847.9014-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 04/12] target/arm: Use tcg integer min/max
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

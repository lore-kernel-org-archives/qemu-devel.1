Received: from eggs.gnu.org ([209.51.188.92]:54020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLJ-00082m-Tk
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLH-0004sS-Rz
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:41 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:51855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMLF-0004nG-Rj
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:38 -0500
Received: by mail-wm1-x332.google.com with SMTP id b11so7522607wmj.1
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.26 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:05:54 +0000
Message-Id: <20190214190603.25030-19-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/27] target/arm: Use tcg integer min/max
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

From: Richard Henderson <richard.henderson@linaro.org>

The 32-bit PMIN/PMAX has been decomposed to scalars,
and so can be trivially expanded inline.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190209033847.9014-5-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 61760dab917..103b4f1821a 100644
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
2.20.1

Received: from eggs.gnu.org ([209.51.188.92]:43171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVba-0002qS-06
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbX-0007TH-3Y
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:45 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:46685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbW-0007Sb-PN
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:42 -0500
Received: by mail-wr1-x42f.google.com with SMTP id l9so15349112wrt.13
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.40 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:46 +0000
Message-Id: <20190118145805.6852-31-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 30/49] target/arm: Implement pauth_addpac
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

This is not really functional yet, because the crypto is not yet
implemented.  This, however follows the AddPAC pseudo function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190108223129.5570-27-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/pauth_helper.c | 42 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index fa7707e0bfc..bc89dd8c111 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -35,7 +35,47 @@ static uint64_t pauth_computepac(uint64_t data, uint64_t modifier,
 static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
                              ARMPACKey *key, bool data)
 {
-    g_assert_not_reached(); /* FIXME */
+    ARMMMUIdx mmu_idx = arm_stage1_mmu_idx(env);
+    ARMVAParameters param = aa64_va_parameters(env, ptr, mmu_idx, data);
+    uint64_t pac, ext_ptr, ext, test;
+    int bot_bit, top_bit;
+
+    /* If tagged pointers are in use, use ptr<55>, otherwise ptr<63>.  */
+    if (param.tbi) {
+        ext = sextract64(ptr, 55, 1);
+    } else {
+        ext = sextract64(ptr, 63, 1);
+    }
+
+    /* Build a pointer with known good extension bits.  */
+    top_bit = 64 - 8 * param.tbi;
+    bot_bit = 64 - param.tsz;
+    ext_ptr = deposit64(ptr, bot_bit, top_bit - bot_bit, ext);
+
+    pac = pauth_computepac(ext_ptr, modifier, *key);
+
+    /*
+     * Check if the ptr has good extension bits and corrupt the
+     * pointer authentication code if not.
+     */
+    test = sextract64(ptr, bot_bit, top_bit - bot_bit);
+    if (test != 0 && test != -1) {
+        pac ^= MAKE_64BIT_MASK(top_bit - 1, 1);
+    }
+
+    /*
+     * Preserve the determination between upper and lower at bit 55,
+     * and insert pointer authentication code.
+     */
+    if (param.tbi) {
+        ptr &= ~MAKE_64BIT_MASK(bot_bit, 55 - bot_bit + 1);
+        pac &= MAKE_64BIT_MASK(bot_bit, 54 - bot_bit + 1);
+    } else {
+        ptr &= MAKE_64BIT_MASK(0, bot_bit);
+        pac &= ~(MAKE_64BIT_MASK(55, 1) | MAKE_64BIT_MASK(0, bot_bit));
+    }
+    ext &= MAKE_64BIT_MASK(55, 1);
+    return pac | ext | ptr;
 }
 
 static uint64_t pauth_original_ptr(uint64_t ptr, ARMVAParameters param)
-- 
2.20.1

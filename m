Received: from eggs.gnu.org ([2001:4830:134:3::10]:59299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDVP-0008Mu-3h
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDVN-0007xm-6V
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:10 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:41787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gVDVM-0007vI-V5
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:09 -0500
Received: by mail-oi1-x22b.google.com with SMTP id j21so2985213oii.8
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:37:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Dec 2018 04:36:26 -0600
Message-Id: <20181207103631.28193-22-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-1-richard.henderson@linaro.org>
References: <20181207103631.28193-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 21/26] target/arm: Implement pauth_addpac
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ramana.radhakrishnan@arm.com

This is not really functional yet, because the crypto is not yet
implemented.  This, however follows the AddPAC pseudo function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 2c14a71f03..28bdf6f0b2 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -1066,7 +1066,45 @@ static uint64_t pauth_computepac(uint64_t data, uint64_t modifier,
 static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
                              uint64_t *key, bool data)
 {
-    g_assert_not_reached(); /* FIXME */
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
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
+    pac = pauth_computepac(ext_ptr, modifier, key[1], key[0]);
+
+    /* Check if the ptr has good extension bits and corrupt the
+     * pointer authentication code if not.
+     */
+    test = sextract64(ptr, bot_bit, top_bit - bot_bit);
+    if (test != 0 && test != -1) {
+        pac ^= 1ull << (top_bit - 1);
+    }
+
+    /* Preserve the determination between upper and lower at bit 55,
+     * and insert pointer authentication code.
+     */
+    if (param.tbi) {
+        ptr &= ~MAKE_64BIT_MASK(bot_bit, 55 - bot_bit);
+        pac &= MAKE_64BIT_MASK(bot_bit, 54 - bot_bit);
+    } else {
+        ptr &= MAKE_64BIT_MASK(0, bot_bit - 1);
+        pac &= ~(MAKE_64BIT_MASK(55, 1) | MAKE_64BIT_MASK(0, bot_bit - 1));
+    }
+    ext &= MAKE_64BIT_MASK(55, 1);
+    return pac | ext | ptr;
 }
 
 static uint64_t pauth_original_ptr(uint64_t ptr, ARMVAParameters param)
-- 
2.17.2

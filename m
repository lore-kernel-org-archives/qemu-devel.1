Received: from eggs.gnu.org ([209.51.188.92]:53003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzvP-0000ZR-KX
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzvO-0005CT-Re
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:43 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggzvO-0005BH-Jf
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:42 -0500
Received: by mail-pg1-x544.google.com with SMTP id z11so2376357pgu.0
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 14:32:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 Jan 2019 08:31:23 +1000
Message-Id: <20190108223129.5570-26-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-1-richard.henderson@linaro.org>
References: <20190108223129.5570-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 25/31] target/arm: Implement pauth_auth
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

This is not really functional yet, because the crypto is not yet
implemented.  This, however follows the Auth pseudo function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/pauth_helper.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index e02376a2d0..fa7707e0bf 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -50,7 +50,26 @@ static uint64_t pauth_original_ptr(uint64_t ptr, ARMVAParameters param)
 static uint64_t pauth_auth(CPUARMState *env, uint64_t ptr, uint64_t modifier,
                            ARMPACKey *key, bool data, int keynumber)
 {
-    g_assert_not_reached(); /* FIXME */
+    ARMMMUIdx mmu_idx = arm_stage1_mmu_idx(env);
+    ARMVAParameters param = aa64_va_parameters(env, ptr, mmu_idx, data);
+    int bot_bit, top_bit;
+    uint64_t pac, orig_ptr, test;
+
+    orig_ptr = pauth_original_ptr(ptr, param);
+    pac = pauth_computepac(orig_ptr, modifier, *key);
+    bot_bit = 64 - param.tsz;
+    top_bit = 64 - 8 * param.tbi;
+
+    test = (pac ^ ptr) & ~MAKE_64BIT_MASK(55, 1);
+    if (unlikely(extract64(test, bot_bit, top_bit - bot_bit))) {
+        int error_code = (keynumber << 1) | (keynumber ^ 1);
+        if (param.tbi) {
+            return deposit64(ptr, 53, 2, error_code);
+        } else {
+            return deposit64(ptr, 61, 2, error_code);
+        }
+    }
+    return orig_ptr;
 }
 
 static uint64_t pauth_strip(CPUARMState *env, uint64_t ptr, bool data)
-- 
2.17.2

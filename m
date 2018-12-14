Received: from eggs.gnu.org ([2001:4830:134:3::10]:55875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxu-0004mY-5o
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxq-0005V2-7Z
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:46 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXfxo-0005T8-9D
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:40 -0500
Received: by mail-ot1-x344.google.com with SMTP id k98so4328312otk.3
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 21:24:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 23:24:04 -0600
Message-Id: <20181214052410.11863-22-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-1-richard.henderson@linaro.org>
References: <20181214052410.11863-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 21/27] target/arm: Implement pauth_auth
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 329af51232..87cff7d96a 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -1081,7 +1081,26 @@ static uint64_t pauth_original_ptr(uint64_t ptr, ARMVAParameters param)
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

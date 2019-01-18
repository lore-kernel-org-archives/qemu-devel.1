Received: from eggs.gnu.org ([209.51.188.92]:43134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbY-0002ox-ST
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbW-0007Sd-43
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:44 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:50353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbV-0007RO-QC
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:41 -0500
Received: by mail-wm1-x32b.google.com with SMTP id n190so4796664wmd.0
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.39 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:45 +0000
Message-Id: <20190118145805.6852-30-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 29/49] target/arm: Implement pauth_auth
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
implemented.  This, however follows the Auth pseudo function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190108223129.5570-26-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/pauth_helper.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index e02376a2d02..fa7707e0bfc 100644
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
2.20.1

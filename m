Received: from eggs.gnu.org ([209.51.188.92]:52949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzvM-0000XJ-U7
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzvM-00058E-4N
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:40 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggzvL-000566-VF
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:40 -0500
Received: by mail-pf1-x441.google.com with SMTP id w73so2598965pfk.10
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 14:32:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 Jan 2019 08:31:22 +1000
Message-Id: <20190108223129.5570-25-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-1-richard.henderson@linaro.org>
References: <20190108223129.5570-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 24/31] target/arm: Implement pauth_strip
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

Stripping out the authentication data does not require any crypto,
it merely requires the virtual address parameters.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/pauth_helper.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index 902f68a24c..e02376a2d0 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -38,6 +38,15 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
     g_assert_not_reached(); /* FIXME */
 }
 
+static uint64_t pauth_original_ptr(uint64_t ptr, ARMVAParameters param)
+{
+    uint64_t extfield = -param.select;
+    int bot_pac_bit = 64 - param.tsz;
+    int top_pac_bit = 64 - 8 * param.tbi;
+
+    return deposit64(ptr, bot_pac_bit, top_pac_bit - bot_pac_bit, extfield);
+}
+
 static uint64_t pauth_auth(CPUARMState *env, uint64_t ptr, uint64_t modifier,
                            ARMPACKey *key, bool data, int keynumber)
 {
@@ -46,7 +55,10 @@ static uint64_t pauth_auth(CPUARMState *env, uint64_t ptr, uint64_t modifier,
 
 static uint64_t pauth_strip(CPUARMState *env, uint64_t ptr, bool data)
 {
-    g_assert_not_reached(); /* FIXME */
+    ARMMMUIdx mmu_idx = arm_stage1_mmu_idx(env);
+    ARMVAParameters param = aa64_va_parameters(env, ptr, mmu_idx, data);
+
+    return pauth_original_ptr(ptr, param);
 }
 
 static void QEMU_NORETURN pauth_trap(CPUARMState *env, int target_el,
-- 
2.17.2

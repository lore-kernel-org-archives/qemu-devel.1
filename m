Received: from eggs.gnu.org ([2001:4830:134:3::10]:55887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxu-0004mf-6W
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxo-0005UB-AH
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:46 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXfxo-0005Sa-2l
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:40 -0500
Received: by mail-oi1-x243.google.com with SMTP id j21so3624865oii.8
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 21:24:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 23:24:03 -0600
Message-Id: <20181214052410.11863-21-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-1-richard.henderson@linaro.org>
References: <20181214052410.11863-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 20/27] target/arm: Implement pauth_strip
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 79cc9cf47b..329af51232 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -1069,6 +1069,15 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
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
@@ -1077,7 +1086,10 @@ static uint64_t pauth_auth(CPUARMState *env, uint64_t ptr, uint64_t modifier,
 
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

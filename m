Received: from eggs.gnu.org ([2001:4830:134:3::10]:59281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDVN-0008J8-0z
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDVJ-0007uU-D2
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:08 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gVDVJ-0007tb-7O
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:05 -0500
Received: by mail-oi1-x244.google.com with SMTP id u18so2982962oie.10
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:37:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Dec 2018 04:36:24 -0600
Message-Id: <20181207103631.28193-20-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-1-richard.henderson@linaro.org>
References: <20181207103631.28193-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 19/26] target/arm: Implement pauth_strip
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

Stripping out the authentication data does not require any crypto,
it merely requires the virtual address parameters.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 0818fd5451..8860704720 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -1069,15 +1069,27 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
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
                            uint64_t *key, bool data, int keynumber)
 {
     g_assert_not_reached(); /* FIXME */
 }
 
-static uint64_t pauth_strip(CPUARMState *env, uint64_t a, bool data)
+static uint64_t pauth_strip(CPUARMState *env, uint64_t ptr, bool data)
 {
-    g_assert_not_reached(); /* FIXME */
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    ARMVAParameters param = aa64_va_parameters(env, ptr, mmu_idx, data);
+
+    return pauth_original_ptr(ptr, param);
 }
 
 static void QEMU_NORETURN pauth_trap(CPUARMState *env, int target_el,
-- 
2.17.2

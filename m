Received: from eggs.gnu.org ([209.51.188.92]:35025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu8If-0003DZ-Rs
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu8Ie-0005fM-LD
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:07:01 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gu8Id-0005ch-OE
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:07:00 -0500
Received: by mail-pf1-x442.google.com with SMTP id q1so2367435pfi.5
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 20:06:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 13 Feb 2019 20:06:51 -0800
Message-Id: <20190214040652.4811-4-richard.henderson@linaro.org>
In-Reply-To: <20190214040652.4811-1-richard.henderson@linaro.org>
References: <20190214040652.4811-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/4] target/arm: Assert hflags is correct in
 cpu_get_tb_cpu_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, cota@braap.org

Make sure that we are updating env->hflags everywhere required.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d8249f0eae..3c8724883d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13902,11 +13902,13 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     if (is_a64(env)) {
         *pc = env->pc;
         flags = rebuild_hflags_a64(env, current_el);
+        assert(flags == env->hflags);
         flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
         pstate_for_ss = env->pstate;
     } else {
         *pc = env->regs[15];
         flags = rebuild_hflags_a32(env, current_el);
+        assert(flags == env->hflags);
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
         flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
         pstate_for_ss = env->uncached_cpsr;
-- 
2.17.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpVT-0000gj-Hp
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpVP-0001cd-IV
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:21:54 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:44959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHpVM-00018Z-HX
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:21:50 -0400
Received: by mail-wr1-x429.google.com with SMTP id d17-v6so15938843wre.11
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 05:21:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 31 Oct 2018 12:21:11 +0000
Message-Id: <20181031122119.1669-3-richard.henderson@linaro.org>
In-Reply-To: <20181031122119.1669-1-richard.henderson@linaro.org>
References: <20181031122119.1669-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 02/10] cputlb: Remove tcg_enabled hack from
 tlb_flush_nocheck
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

The bugs this was working around were fixed with commits
022d6378c7fd  target/unicore32: remove tlb_flush from uc32_init_fn
6e11beecfde0  target/alpha: remove tlb_flush from alpha_cpu_initfn

Tested-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d4e07056be..d080769c83 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -122,13 +122,6 @@ static void tlb_flush_nocheck(CPUState *cpu)
 {
     CPUArchState *env = cpu->env_ptr;
 
-    /* The QOM tests will trigger tlb_flushes without setting up TCG
-     * so we bug out here in that case.
-     */
-    if (!tcg_enabled()) {
-        return;
-    }
-
     assert_cpu_is_self(cpu);
     atomic_set(&env->tlb_flush_count, env->tlb_flush_count + 1);
     tlb_debug("(count: %zu)\n", tlb_flush_count());
-- 
2.17.2

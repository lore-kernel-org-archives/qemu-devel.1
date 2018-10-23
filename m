Received: from eggs.gnu.org ([2001:4830:134:3::10]:59582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEqm4-0008OX-8W
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEqie-0003uN-9R
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:03:17 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEqid-0003k7-T3
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:03:12 -0400
Received: by mail-wm1-x343.google.com with SMTP id a8-v6so547621wmf.1
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 00:03:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 23 Oct 2018 08:02:45 +0100
Message-Id: <20181023070253.6407-4-richard.henderson@linaro.org>
In-Reply-To: <20181023070253.6407-1-richard.henderson@linaro.org>
References: <20181023070253.6407-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 02/10] cputlb: Remove tcg_enabled hack from
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
Cc: cota@braap.org

The bugs this was working around were fixed with commits
022d6378c7fd  target/unicore32: remove tlb_flush from uc32_init_fn
6e11beecfde0  target/alpha: remove tlb_flush from alpha_cpu_initfn

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

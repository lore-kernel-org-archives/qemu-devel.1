Received: from eggs.gnu.org ([2001:4830:134:3::10]:48890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpVe-0000nx-C9
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpVY-0001mb-HS
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:22:04 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:37339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHpVY-0001DF-98
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:22:00 -0400
Received: by mail-wr1-x433.google.com with SMTP id g9-v6so16240633wrq.4
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 05:21:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 31 Oct 2018 12:21:16 +0000
Message-Id: <20181031122119.1669-8-richard.henderson@linaro.org>
In-Reply-To: <20181031122119.1669-1-richard.henderson@linaro.org>
References: <20181031122119.1669-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 07/10] cputlb: Merge tlb_flush_page into
 tlb_flush_page_by_mmuidx
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

The difference between the two sets of APIs is now miniscule.

Tested-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 58 ++++++++++------------------------------------
 1 file changed, 12 insertions(+), 46 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a3a417e81a..1f7764de94 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -255,38 +255,6 @@ static void tlb_flush_page_locked(CPUArchState *env, int midx,
     }
 }
 
-static void tlb_flush_page_async_work(CPUState *cpu, run_on_cpu_data data)
-{
-    CPUArchState *env = cpu->env_ptr;
-    target_ulong addr = (target_ulong) data.target_ptr;
-    int mmu_idx;
-
-    assert_cpu_is_self(cpu);
-
-    tlb_debug("page addr:" TARGET_FMT_lx "\n", addr);
-
-    addr &= TARGET_PAGE_MASK;
-    qemu_spin_lock(&env->tlb_c.lock);
-    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-        tlb_flush_page_locked(env, mmu_idx, addr);
-    }
-    qemu_spin_unlock(&env->tlb_c.lock);
-
-    tb_flush_jmp_cache(cpu, addr);
-}
-
-void tlb_flush_page(CPUState *cpu, target_ulong addr)
-{
-    tlb_debug("page :" TARGET_FMT_lx "\n", addr);
-
-    if (!qemu_cpu_is_self(cpu)) {
-        async_run_on_cpu(cpu, tlb_flush_page_async_work,
-                         RUN_ON_CPU_TARGET_PTR(addr));
-    } else {
-        tlb_flush_page_async_work(cpu, RUN_ON_CPU_TARGET_PTR(addr));
-    }
-}
-
 /* As we are going to hijack the bottom bits of the page address for a
  * mmuidx bit mask we need to fail to build if we can't do that
  */
@@ -336,6 +304,11 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
     }
 }
 
+void tlb_flush_page(CPUState *cpu, target_ulong addr)
+{
+    tlb_flush_page_by_mmuidx(cpu, addr, ALL_MMUIDX_BITS);
+}
+
 void tlb_flush_page_by_mmuidx_all_cpus(CPUState *src_cpu, target_ulong addr,
                                        uint16_t idxmap)
 {
@@ -352,6 +325,11 @@ void tlb_flush_page_by_mmuidx_all_cpus(CPUState *src_cpu, target_ulong addr,
     fn(src_cpu, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
 }
 
+void tlb_flush_page_all_cpus(CPUState *src, target_ulong addr)
+{
+    tlb_flush_page_by_mmuidx_all_cpus(src, addr, ALL_MMUIDX_BITS);
+}
+
 void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
                                               target_ulong addr,
                                               uint16_t idxmap)
@@ -369,21 +347,9 @@ void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
     async_safe_run_on_cpu(src_cpu, fn, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
 }
 
-void tlb_flush_page_all_cpus(CPUState *src, target_ulong addr)
+void tlb_flush_page_all_cpus_synced(CPUState *src, target_ulong addr)
 {
-    const run_on_cpu_func fn = tlb_flush_page_async_work;
-
-    flush_all_helper(src, fn, RUN_ON_CPU_TARGET_PTR(addr));
-    fn(src, RUN_ON_CPU_TARGET_PTR(addr));
-}
-
-void tlb_flush_page_all_cpus_synced(CPUState *src,
-                                                  target_ulong addr)
-{
-    const run_on_cpu_func fn = tlb_flush_page_async_work;
-
-    flush_all_helper(src, fn, RUN_ON_CPU_TARGET_PTR(addr));
-    async_safe_run_on_cpu(src, fn, RUN_ON_CPU_TARGET_PTR(addr));
+    tlb_flush_page_by_mmuidx_all_cpus_synced(src, addr, ALL_MMUIDX_BITS);
 }
 
 /* update the TLBs so that writes to code in the virtual page 'addr'
-- 
2.17.2

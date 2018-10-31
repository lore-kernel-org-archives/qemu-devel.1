Received: from eggs.gnu.org ([2001:4830:134:3::10]:49034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpVk-0000sa-Uz
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpVe-0001tC-C8
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:22:12 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:39827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHpVa-0001Fw-Es
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:22:04 -0400
Received: by mail-wr1-x42a.google.com with SMTP id r10-v6so16263122wrv.6
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 05:21:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 31 Oct 2018 12:21:19 +0000
Message-Id: <20181031122119.1669-11-richard.henderson@linaro.org>
In-Reply-To: <20181031122119.1669-1-richard.henderson@linaro.org>
References: <20181031122119.1669-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 10/10] cputlb: Remove tlb_c.pending_flushes
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

This is essentially redundant with tlb_c.dirty.

Tested-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h |  6 ------
 accel/tcg/cputlb.c      | 16 ++--------------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index ca0fea8b27..6a60f94a41 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -160,12 +160,6 @@ typedef struct CPUTLBDesc {
 typedef struct CPUTLBCommon {
     /* Serialize updates to tlb_table and tlb_v_table, and others as noted. */
     QemuSpin lock;
-    /*
-     * Within pending_flush, for each bit N, there exists an outstanding
-     * cross-cpu flush for mmu_idx N.  Further cross-cpu flushes to that
-     * mmu_idx may be discarded.  Protected by tlb_c.lock.
-     */
-    uint16_t pending_flush;
     /*
      * Within dirty, for each bit N, modifications have been made to
      * mmu_idx N since the last time that mmu_idx was flushed.
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f6c37bc4db..af6bd8ccf9 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -174,20 +174,8 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
     tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
 
     if (cpu->created && !qemu_cpu_is_self(cpu)) {
-        CPUArchState *env = cpu->env_ptr;
-        uint16_t pending, to_clean;
-
-        qemu_spin_lock(&env->tlb_c.lock);
-        pending = env->tlb_c.pending_flush;
-        to_clean = idxmap & ~pending;
-        env->tlb_c.pending_flush = pending | idxmap;
-        qemu_spin_unlock(&env->tlb_c.lock);
-
-        if (to_clean) {
-            tlb_debug("reduced mmu_idx: 0x%" PRIx16 "\n", to_clean);
-            async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
-                             RUN_ON_CPU_HOST_INT(to_clean));
-        }
+        async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
+                         RUN_ON_CPU_HOST_INT(idxmap));
     } else {
         tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
     }
-- 
2.17.2

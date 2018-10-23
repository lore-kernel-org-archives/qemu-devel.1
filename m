Received: from eggs.gnu.org ([2001:4830:134:3::10]:59420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEqm3-0008Nf-HZ
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEqig-0003xk-3E
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:03:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEqif-0003wn-S2
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:03:14 -0400
Received: by mail-wr1-x444.google.com with SMTP id q6-v6so348027wrw.11
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 00:03:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 23 Oct 2018 08:02:53 +0100
Message-Id: <20181023070253.6407-12-richard.henderson@linaro.org>
In-Reply-To: <20181023070253.6407-1-richard.henderson@linaro.org>
References: <20181023070253.6407-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 10/10] cputlb: Remove tlb_c.pending_flushes
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

This is essentially redundant with tlb_c.dirty.
[??? Collect data to back up this supposition]

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
index c1b92083d4..fec37bd3bd 100644
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

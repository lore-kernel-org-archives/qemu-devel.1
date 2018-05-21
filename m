Received: from eggs.gnu.org ([2001:4830:134:3::10]:57885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fKuOv-0002eX-6R
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fKuOr-0005Yv-An
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:37 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56391)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fKuOq-0005XW-Fh
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:32 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 21 May 2018 19:39:25 -0400
Message-Id: <1526945967-9687-16-git-send-email-cota@braap.org>
In-Reply-To: <1526945967-9687-1-git-send-email-cota@braap.org>
References: <1526945967-9687-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 15/17] cputlb: remove tb_lock from tlb_flush
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

The acquisition of tb_lock was added when the async tlb_flush
was introduced in e3b9ca810 ("cputlb: introduce tlb_flush_* async work.")

tb_lock was there to allow us to do memset() on the tb_jmp_cache's.
However, since f3ced3c5928 ("tcg: consistently access cpu->tb_jmp_cache
atomically") all accesses to tb_jmp_cache are atomic, so tb_lock
is not needed here. Get rid of it.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cputlb.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 0543903..f5c3a09 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -125,8 +125,6 @@ static void tlb_flush_nocheck(CPUState *cpu)
     atomic_set(&env->tlb_flush_count, env->tlb_flush_count + 1);
     tlb_debug("(count: %zu)\n", tlb_flush_count());
 
-    tb_lock();
-
     memset(env->tlb_table, -1, sizeof(env->tlb_table));
     memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
     cpu_tb_jmp_cache_clear(cpu);
@@ -135,8 +133,6 @@ static void tlb_flush_nocheck(CPUState *cpu)
     env->tlb_flush_addr = -1;
     env->tlb_flush_mask = 0;
 
-    tb_unlock();
-
     atomic_mb_set(&cpu->pending_tlb_flush, 0);
 }
 
@@ -180,8 +176,6 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 
     assert_cpu_is_self(cpu);
 
-    tb_lock();
-
     tlb_debug("start: mmu_idx:0x%04lx\n", mmu_idx_bitmask);
 
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
@@ -197,8 +191,6 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
     cpu_tb_jmp_cache_clear(cpu);
 
     tlb_debug("done\n");
-
-    tb_unlock();
 }
 
 void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7nOI-0002cU-Ob
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7nOF-0006wO-G0
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:05:02 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36467)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g7nOF-0006u3-0g
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:04:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed,  3 Oct 2018 16:04:51 -0400
Message-Id: <20181003200454.18384-2-cota@braap.org>
In-Reply-To: <20181003200454.18384-1-cota@braap.org>
References: <20181003200454.18384-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 1/4] exec: introduce tlb_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Paves the way for the addition of a per-TLB lock.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h | 8 ++++++++
 accel/tcg/cputlb.c      | 4 ++++
 exec.c                  | 1 +
 3 files changed, 13 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 5f78125582..815e5b1e83 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -99,6 +99,11 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
 
 #if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
 /* cputlb.c */
+/**
+ * tlb_init - initialize a CPU's TLB
+ * @cpu: CPU whose TLB should be initialized
+ */
+void tlb_init(CPUState *cpu);
 /**
  * tlb_flush_page:
  * @cpu: CPU whose TLB should be flushed
@@ -258,6 +263,9 @@ void tlb_set_page(CPUState *cpu, target_ulong vaddr,
 void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
                  uintptr_t retaddr);
 #else
+static inline void tlb_init(CPUState *cpu)
+{
+}
 static inline void tlb_flush_page(CPUState *cpu, target_ulong addr)
 {
 }
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f4702ce91f..502eea2850 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -73,6 +73,10 @@ QEMU_BUILD_BUG_ON(sizeof(target_ulong) > sizeof(run_on_cpu_data));
 QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
+void tlb_init(CPUState *cpu)
+{
+}
+
 /* flush_all_helper: run fn across all cpus
  *
  * If the wait flag is set then the src cpu's helper will be queued as
diff --git a/exec.c b/exec.c
index d0821e69aa..4fd831ef06 100644
--- a/exec.c
+++ b/exec.c
@@ -965,6 +965,7 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
         tcg_target_initialized = true;
         cc->tcg_initialize();
     }
+    tlb_init(cpu);
 
 #ifndef CONFIG_USER_ONLY
     if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
-- 
2.17.1

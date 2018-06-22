Received: from eggs.gnu.org ([2001:4830:134:3::10]:56478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fWQ7s-0002mb-TX
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fWQ7p-0004XH-QF
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:45:36 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49005)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fWQ7p-0004X7-J9
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:45:33 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 22 Jun 2018 13:45:31 -0400
Message-Id: <1529689531-4024-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH] tcg: fix --disable-tcg build breakage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

Fix the --disable-tcg breakage introduced by tb_lock's removal by
relying on the fact that tcg_enabled() is set to 0 at
compile-time under --disable-tcg.

While at it, add further asserts to fix builds that enable both
--disable-tcg and --enable-debug, which were broken even before
tb_lock's removal.

Tested to build x86_64-softmmu and i386-softmmu targets.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/stubs/tcg-stub.c | 4 ----
 cpus.c                 | 4 ++++
 exec.c                 | 3 +++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index ee575a8..76ae461 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -21,10 +21,6 @@ void tb_flush(CPUState *cpu)
 {
 }
 
-void tb_unlock(void)
-{
-}
-
 void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
 {
 }
diff --git a/cpus.c b/cpus.c
index d1f1629..8cd552e 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1355,6 +1355,7 @@ static int tcg_cpu_exec(CPUState *cpu)
     int64_t ti;
 #endif
 
+    assert(tcg_enabled());
 #ifdef CONFIG_PROFILER
     ti = profile_getclock();
 #endif
@@ -1397,6 +1398,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
 {
     CPUState *cpu = arg;
 
+    assert(tcg_enabled());
     rcu_register_thread();
     tcg_register_thread();
 
@@ -1631,6 +1633,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
 {
     CPUState *cpu = arg;
 
+    assert(tcg_enabled());
     g_assert(!use_icount);
 
     rcu_register_thread();
@@ -1854,6 +1857,7 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
     static QemuThread *single_tcg_cpu_thread;
     static int tcg_region_inited;
 
+    assert(tcg_enabled());
     /*
      * Initialize TCG regions--once. Now is a good time, because:
      * (1) TCG's init context, prologue and target globals have been set up.
diff --git a/exec.c b/exec.c
index 28f9bdc..88edb59 100644
--- a/exec.c
+++ b/exec.c
@@ -1323,6 +1323,7 @@ static void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length)
     RAMBlock *block;
     ram_addr_t end;
 
+    assert(tcg_enabled());
     end = TARGET_PAGE_ALIGN(start + length);
     start &= TARGET_PAGE_MASK;
 
@@ -2655,6 +2656,7 @@ void memory_notdirty_write_prepare(NotDirtyInfo *ndi,
 void memory_notdirty_write_complete(NotDirtyInfo *ndi)
 {
     if (ndi->pages) {
+        assert(tcg_enabled());
         page_collection_unlock(ndi->pages);
         ndi->pages = NULL;
     }
@@ -3046,6 +3048,7 @@ static void tcg_commit(MemoryListener *listener)
     CPUAddressSpace *cpuas;
     AddressSpaceDispatch *d;
 
+    assert(tcg_enabled());
     /* since each CPU stores ram addresses in its TLB cache, we must
        reset the modified entries */
     cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
-- 
2.7.4

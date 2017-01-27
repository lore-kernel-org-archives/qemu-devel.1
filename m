Received: from eggs.gnu.org ([2001:4830:134:3::10]:49551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX40K-0007cI-37
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX40J-0004eq-3H
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:43:40 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX40I-0004eU-SN
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:43:38 -0500
Received: by mail-wm0-x229.google.com with SMTP id r126so111091921wmr.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 02:43:38 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 27 Jan 2017 10:34:53 +0000
Message-Id: <20170127103505.18606-14-alex.bennee@linaro.org>
In-Reply-To: <20170127103505.18606-1-alex.bennee@linaro.org>
References: <20170127103505.18606-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 13/25] cputlb: add assert_cpu_is_self checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>

For SoftMMU the TLB flushes are an example of a task that can be
triggered on one vCPU by another. To deal with this properly we need to
use safe work to ensure these changes are done safely. The new assert
can be enabled while debugging to catch these cases.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 cputlb.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/cputlb.c b/cputlb.c
index 1cc9d9da51..af0e65cd2c 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -58,6 +58,12 @@
     } \
 } while (0)
 
+#define assert_cpu_is_self(this_cpu) do {                         \
+        if (DEBUG_TLB_GATE) {                                     \
+            g_assert(!cpu->created || qemu_cpu_is_self(cpu));     \
+        }                                                         \
+    } while (0)
+
 /* statistics */
 int tlb_flush_count;
 
@@ -70,6 +76,9 @@ void tlb_flush(CPUState *cpu)
 {
     CPUArchState *env = cpu->env_ptr;
 
+    assert_cpu_is_self(cpu);
+    tlb_debug("(count: %d)\n", tlb_flush_count++);
+
     memset(env->tlb_table, -1, sizeof(env->tlb_table));
     memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
     memset(cpu->tb_jmp_cache, 0, sizeof(cpu->tb_jmp_cache));
@@ -77,13 +86,13 @@ void tlb_flush(CPUState *cpu)
     env->vtlb_index = 0;
     env->tlb_flush_addr = -1;
     env->tlb_flush_mask = 0;
-    tlb_flush_count++;
 }
 
 static inline void v_tlb_flush_by_mmuidx(CPUState *cpu, va_list argp)
 {
     CPUArchState *env = cpu->env_ptr;
 
+    assert_cpu_is_self(cpu);
     tlb_debug("start\n");
 
     for (;;) {
@@ -128,6 +137,7 @@ void tlb_flush_page(CPUState *cpu, target_ulong addr)
     int i;
     int mmu_idx;
 
+    assert_cpu_is_self(cpu);
     tlb_debug("page :" TARGET_FMT_lx "\n", addr);
 
     /* Check if we need to flush due to large pages.  */
@@ -165,6 +175,7 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, ...)
 
     va_start(argp, addr);
 
+    assert_cpu_is_self(cpu);
     tlb_debug("addr "TARGET_FMT_lx"\n", addr);
 
     /* Check if we need to flush due to large pages.  */
@@ -253,6 +264,8 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
 
     int mmu_idx;
 
+    assert_cpu_is_self(cpu);
+
     env = cpu->env_ptr;
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         unsigned int i;
@@ -284,6 +297,8 @@ void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
     int i;
     int mmu_idx;
 
+    assert_cpu_is_self(cpu);
+
     vaddr &= TARGET_PAGE_MASK;
     i = (vaddr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
@@ -343,6 +358,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     unsigned vidx = env->vtlb_index++ % CPU_VTLB_SIZE;
     int asidx = cpu_asidx_from_attrs(cpu, attrs);
 
+    assert_cpu_is_self(cpu);
     assert(size >= TARGET_PAGE_SIZE);
     if (size != TARGET_PAGE_SIZE) {
         tlb_add_large_page(env, vaddr, size);
-- 
2.11.0

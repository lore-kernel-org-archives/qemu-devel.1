Received: from eggs.gnu.org ([2001:4830:134:3::10]:50815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9YJI-0005vf-UF
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9YJH-0005rh-FP
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:50:52 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:37853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9YJH-0005qb-4a
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:50:51 -0400
Received: by mail-wr0-x242.google.com with SMTP id f14-v6so24222277wre.4
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 08:50:50 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 20 Apr 2018 16:50:41 +0100
Message-Id: <20180420155045.18862-3-alex.bennee@linaro.org>
In-Reply-To: <20180420155045.18862-1-alex.bennee@linaro.org>
References: <20180420155045.18862-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 2/6] accel/tcg: new softmmu.c with
 DATA_SIZE=1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, pbonzini@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Expand the results of softmmu-template.h with DATA_SIZE 1. Currently
there are no changes and areas will get dead-coded away. This is going
to form the basis of the re-factoring.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/Makefile.objs |   1 +
 accel/tcg/cputlb.c      |   6 -
 accel/tcg/softmmu.c     | 255 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 256 insertions(+), 6 deletions(-)
 create mode 100644 accel/tcg/softmmu.c

diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index d381a02f34..6b0b96633d 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -1,5 +1,6 @@
 obj-$(CONFIG_SOFTMMU) += tcg-all.o
 obj-$(CONFIG_SOFTMMU) += cputlb.o
+obj-$(CONFIG_SOFTMMU) += softmmu.o
 obj-y += tcg-runtime.o tcg-runtime-gvec.o
 obj-y += cpu-exec.o cpu-exec-common.o translate-all.o
 obj-y += translator.o
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 43a89d3010..7104bacc0f 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1032,9 +1032,6 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 
 #define MMUSUFFIX _mmu
 
-#define DATA_SIZE 1
-#include "softmmu_template.h"
-
 #define DATA_SIZE 2
 #include "softmmu_template.h"
 
@@ -1109,9 +1106,6 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 #define GETPC() ((uintptr_t)0)
 #define SOFTMMU_CODE_ACCESS
 
-#define DATA_SIZE 1
-#include "softmmu_template.h"
-
 #define DATA_SIZE 2
 #include "softmmu_template.h"
 
diff --git a/accel/tcg/softmmu.c b/accel/tcg/softmmu.c
new file mode 100644
index 0000000000..f09aff453a
--- /dev/null
+++ b/accel/tcg/softmmu.c
@@ -0,0 +1,255 @@
+/*
+ * Software MMU support
+ *
+ * Originally this was a set of generated helpers using macro magic.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cputlb.h"
+#include "exec/exec-all.h"
+#include "tcg/tcg.h"
+
+/* Macro to call the above, with local variables from the use context.  */
+#define VICTIM_TLB_HIT(TY, ADDR) \
+  victim_tlb_hit(env, mmu_idx, index, offsetof(CPUTLBEntry, TY), \
+                 (ADDR) & TARGET_PAGE_MASK)
+
+/* For the benefit of TCG generated code, we want to avoid the complication
+   of ABI-specific return type promotion and always return a value extended
+   to the register size of the host.  This is tcg_target_long, except in the
+   case of a 32-bit host and 64-bit data, and for that we always have
+   uint64_t.  Don't bother with this widened value for SOFTMMU_CODE_ACCESS.  */
+static inline uint8_t io_readb(CPUArchState *env,
+                                              size_t mmu_idx, size_t index,
+                                              target_ulong addr,
+                                              uintptr_t retaddr)
+{
+    CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
+    return io_readx(env, iotlbentry, mmu_idx, addr, retaddr, 1);
+}
+
+
+tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    unsigned mmu_idx = get_mmuidx(oi);
+    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_read;
+    unsigned a_bits = get_alignment_bits(get_memop(oi));
+    uintptr_t haddr;
+    uint8_t res;
+
+    if (addr & ((1 << a_bits) - 1)) {
+        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_LOAD,
+                             mmu_idx, retaddr);
+    }
+
+    /* If the TLB entry is for a different page, reload and try again.  */
+    if ((addr & TARGET_PAGE_MASK)
+         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
+        if (!VICTIM_TLB_HIT(addr_read, addr)) {
+            tlb_fill(ENV_GET_CPU(env), addr, 1, MMU_DATA_LOAD,
+                     mmu_idx, retaddr);
+        }
+        tlb_addr = env->tlb_table[mmu_idx][index].addr_read;
+    }
+
+    /* Handle an IO access.  */
+    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
+        if ((addr & (1 - 1)) != 0) {
+            goto do_unaligned_access;
+        }
+
+        /* ??? Note that the io helpers always read data in the target
+           byte ordering.  We should push the LE/BE request down into io.  */
+        res = io_readb(env, mmu_idx, index, addr, retaddr);
+        res = (res);
+        return res;
+    }
+
+    /* Handle slow unaligned access (it spans two pages or IO).  */
+    if (1 > 1
+        && unlikely((addr & ~TARGET_PAGE_MASK) + 1 - 1
+                    >= TARGET_PAGE_SIZE)) {
+        target_ulong addr1, addr2;
+        uint8_t res1, res2;
+        unsigned shift;
+    do_unaligned_access:
+        addr1 = addr & ~(1 - 1);
+        addr2 = addr1 + 1;
+        res1 = helper_ret_ldub_mmu(env, addr1, oi, retaddr);
+        res2 = helper_ret_ldub_mmu(env, addr2, oi, retaddr);
+        shift = (addr & (1 - 1)) * 8;
+
+        /* Little-endian combine.  */
+        res = (res1 >> shift) | (res2 << ((1 * 8) - shift));
+        return res;
+    }
+
+    haddr = addr + env->tlb_table[mmu_idx][index].addend;
+
+    res = ldub_p((uint8_t *)haddr);
+
+
+
+    return res;
+}
+/* Provide signed versions of the load routines as well.  We can of course
+   avoid this for 64-bit data, or for 32-bit data on 32-bit host.  */
+static inline void io_writeb(CPUArchState *env,
+                                          size_t mmu_idx, size_t index,
+                                          uint8_t val,
+                                          target_ulong addr,
+                                          uintptr_t retaddr)
+{
+    CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
+    return io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, 1);
+}
+
+void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
+                       TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    unsigned mmu_idx = get_mmuidx(oi);
+    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
+    unsigned a_bits = get_alignment_bits(get_memop(oi));
+    uintptr_t haddr;
+
+    if (addr & ((1 << a_bits) - 1)) {
+        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
+                             mmu_idx, retaddr);
+    }
+
+    /* If the TLB entry is for a different page, reload and try again.  */
+    if ((addr & TARGET_PAGE_MASK)
+        != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
+        if (!VICTIM_TLB_HIT(addr_write, addr)) {
+            tlb_fill(ENV_GET_CPU(env), addr, 1, MMU_DATA_STORE,
+                     mmu_idx, retaddr);
+        }
+        tlb_addr = env->tlb_table[mmu_idx][index].addr_write & ~TLB_INVALID_MASK;
+    }
+
+    /* Handle an IO access.  */
+    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
+        if ((addr & (1 - 1)) != 0) {
+            goto do_unaligned_access;
+        }
+
+        /* ??? Note that the io helpers always read data in the target
+           byte ordering.  We should push the LE/BE request down into io.  */
+        val = (val);
+        io_writeb(env, mmu_idx, index, val, addr, retaddr);
+        return;
+    }
+
+    /* Handle slow unaligned access (it spans two pages or IO).  */
+    if (1 > 1
+        && unlikely((addr & ~TARGET_PAGE_MASK) + 1 - 1
+                     >= TARGET_PAGE_SIZE)) {
+        int i, index2;
+        target_ulong page2, tlb_addr2;
+    do_unaligned_access:
+        /* Ensure the second page is in the TLB.  Note that the first page
+           is already guaranteed to be filled, and that the second page
+           cannot evict the first.  */
+        page2 = (addr + 1) & TARGET_PAGE_MASK;
+        index2 = (page2 >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+        tlb_addr2 = env->tlb_table[mmu_idx][index2].addr_write;
+        if (page2 != (tlb_addr2 & (TARGET_PAGE_MASK | TLB_INVALID_MASK))
+            && !VICTIM_TLB_HIT(addr_write, page2)) {
+            tlb_fill(ENV_GET_CPU(env), page2, 1, MMU_DATA_STORE,
+                     mmu_idx, retaddr);
+        }
+
+        /* XXX: not efficient, but simple.  */
+        /* This loop must go in the forward direction to avoid issues
+           with self-modifying code in Windows 64-bit.  */
+        for (i = 0; i < 1; ++i) {
+            /* Little-endian extract.  */
+            uint8_t val8 = val >> (i * 8);
+            helper_ret_stb_mmu(env, addr + i, val8,
+                                            oi, retaddr);
+        }
+        return;
+    }
+
+    haddr = addr + env->tlb_table[mmu_idx][index].addend;
+
+    stb_p((uint8_t *)haddr, val);
+
+
+
+}
+
+/* For the benefit of TCG generated code, we want to avoid the complication
+   of ABI-specific return type promotion and always return a value extended
+   to the register size of the host.  This is tcg_target_long, except in the
+   case of a 32-bit host and 64-bit data, and for that we always have
+   uint64_t.  Don't bother with this widened value for SOFTMMU_CODE_ACCESS.  */
+uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    unsigned mmu_idx = get_mmuidx(oi);
+    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
+    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_code;
+    unsigned a_bits = get_alignment_bits(get_memop(oi));
+    uintptr_t haddr;
+    uint8_t res;
+
+    if (addr & ((1 << a_bits) - 1)) {
+        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_INST_FETCH,
+                             mmu_idx, retaddr);
+    }
+
+    /* If the TLB entry is for a different page, reload and try again.  */
+    if ((addr & TARGET_PAGE_MASK)
+         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
+        if (!VICTIM_TLB_HIT(addr_code, addr)) {
+            tlb_fill(ENV_GET_CPU(env), addr, 1, MMU_INST_FETCH,
+                     mmu_idx, retaddr);
+        }
+        tlb_addr = env->tlb_table[mmu_idx][index].addr_code;
+    }
+
+    /* Handle an IO access.  */
+    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
+        if ((addr & (1 - 1)) != 0) {
+            goto do_unaligned_access;
+        }
+
+        /* ??? Note that the io helpers always read data in the target
+           byte ordering.  We should push the LE/BE request down into io.  */
+        res = io_readb(env, mmu_idx, index, addr, retaddr);
+        res = (res);
+        return res;
+    }
+
+    /* Handle slow unaligned access (it spans two pages or IO).  */
+    if (1 > 1
+        && unlikely((addr & ~TARGET_PAGE_MASK) + 1 - 1
+                    >= TARGET_PAGE_SIZE)) {
+        target_ulong addr1, addr2;
+        uint8_t res1, res2;
+        unsigned shift;
+    do_unaligned_access:
+        addr1 = addr & ~(1 - 1);
+        addr2 = addr1 + 1;
+        res1 = helper_ret_ldb_cmmu(env, addr1, oi, retaddr);
+        res2 = helper_ret_ldb_cmmu(env, addr2, oi, retaddr);
+        shift = (addr & (1 - 1)) * 8;
+
+        /* Little-endian combine.  */
+        res = (res1 >> shift) | (res2 << ((1 * 8) - shift));
+        return res;
+    }
+
+    haddr = addr + env->tlb_table[mmu_idx][index].addend;
+
+    res = ldub_p((uint8_t *)haddr);
+
+
+
+    return res;
+}
-- 
2.17.0

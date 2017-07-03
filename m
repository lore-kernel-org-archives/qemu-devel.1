Received: from eggs.gnu.org ([2001:4830:134:3::10]:51736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4KS-0000u4-5K
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4KQ-00089C-OZ
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:36:04 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:32816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dS4KQ-00088g-Ea
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:36:02 -0400
Received: by mail-wm0-x242.google.com with SMTP id j85so21515404wmj.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 09:36:02 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Jul 2017 18:34:45 +0200
Message-Id: <1499099693-22903-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 14/22] tcg: add CONFIG_TCG guards in headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

From: Yang Zhong <yang.zhong@intel.com>

Add the CONFIG_TCG for exec-all.h. Since function tlb_set_page_with_attrs()
is defined in ./accel/tcg/cputlb.c, which will be disabled if tcg is disabled.
This function need be implemented in accel/stubs/tcg-stub.c for disable-tcg.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/cpu-defs.h     |  4 +++-
 include/exec/cputlb.h       |  2 +-
 include/exec/exec-all.h     | 53 ++++++++++++++++++++++++---------------------
 include/exec/helper-proto.h |  2 ++
 4 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 5f4e303..bc8e7f8 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -25,7 +25,9 @@
 
 #include "qemu/host-utils.h"
 #include "qemu/queue.h"
+#ifdef CONFIG_TCG
 #include "tcg-target.h"
+#endif
 #ifndef CONFIG_USER_ONLY
 #include "exec/hwaddr.h"
 #endif
@@ -54,7 +56,7 @@ typedef uint64_t target_ulong;
 #error TARGET_LONG_SIZE undefined
 #endif
 
-#if !defined(CONFIG_USER_ONLY)
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
 /* use a fully associative victim tlb of 8 entries */
 #define CPU_VTLB_SIZE 8
 
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 3f94178..cf296d9 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -19,7 +19,7 @@
 #ifndef CPUTLB_H
 #define CPUTLB_H
 
-#if !defined(CONFIG_USER_ONLY)
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
 /* cputlb.c */
 void tlb_protect_code(ram_addr_t ram_addr);
 void tlb_unprotect_code(ram_addr_t ram_addr);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 0b56432..2f924f2 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -82,6 +82,34 @@ void cpu_reloading_memory_map(void);
  * Note that with KVM only one address space is supported.
  */
 void cpu_address_space_init(CPUState *cpu, AddressSpace *as, int asidx);
+/**
+ * tlb_set_page_with_attrs:
+ * @cpu: CPU to add this TLB entry for
+ * @vaddr: virtual address of page to add entry for
+ * @paddr: physical address of the page
+ * @attrs: memory transaction attributes
+ * @prot: access permissions (PAGE_READ/PAGE_WRITE/PAGE_EXEC bits)
+ * @mmu_idx: MMU index to insert TLB entry for
+ * @size: size of the page in bytes
+ *
+ * Add an entry to this CPU's TLB (a mapping from virtual address
+ * @vaddr to physical address @paddr) with the specified memory
+ * transaction attributes. This is generally called by the target CPU
+ * specific code after it has been called through the tlb_fill()
+ * entry point and performed a successful page table walk to find
+ * the physical address and attributes for the virtual address
+ * which provoked the TLB miss.
+ *
+ * At most one entry for a given virtual address is permitted. Only a
+ * single TARGET_PAGE_SIZE region is mapped; the supplied @size is only
+ * used by tlb_flush_page.
+ */
+void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
+                             hwaddr paddr, MemTxAttrs attrs,
+                             int prot, int mmu_idx, target_ulong size);
+#endif
+
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
 /* cputlb.c */
 /**
  * tlb_flush_page:
@@ -205,31 +233,6 @@ void tlb_flush_by_mmuidx_all_cpus(CPUState *cpu, uint16_t idxmap);
  * depend on when the guests translation ends the TB.
  */
 void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu, uint16_t idxmap);
-/**
- * tlb_set_page_with_attrs:
- * @cpu: CPU to add this TLB entry for
- * @vaddr: virtual address of page to add entry for
- * @paddr: physical address of the page
- * @attrs: memory transaction attributes
- * @prot: access permissions (PAGE_READ/PAGE_WRITE/PAGE_EXEC bits)
- * @mmu_idx: MMU index to insert TLB entry for
- * @size: size of the page in bytes
- *
- * Add an entry to this CPU's TLB (a mapping from virtual address
- * @vaddr to physical address @paddr) with the specified memory
- * transaction attributes. This is generally called by the target CPU
- * specific code after it has been called through the tlb_fill()
- * entry point and performed a successful page table walk to find
- * the physical address and attributes for the virtual address
- * which provoked the TLB miss.
- *
- * At most one entry for a given virtual address is permitted. Only a
- * single TARGET_PAGE_SIZE region is mapped; the supplied @size is only
- * used by tlb_flush_page.
- */
-void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
-                             hwaddr paddr, MemTxAttrs attrs,
-                             int prot, int mmu_idx, target_ulong size);
 /* tlb_set_page:
  *
  * This function is equivalent to calling tlb_set_page_with_attrs()
diff --git a/include/exec/helper-proto.h b/include/exec/helper-proto.h
index 954bef8..417c7b0 100644
--- a/include/exec/helper-proto.h
+++ b/include/exec/helper-proto.h
@@ -28,7 +28,9 @@ dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
 
 #include "helper.h"
 #include "trace/generated-helpers.h"
+#ifdef CONFIG_TCG
 #include "tcg-runtime.h"
+#endif
 
 #undef DEF_HELPER_FLAGS_0
 #undef DEF_HELPER_FLAGS_1
-- 
1.8.3.1

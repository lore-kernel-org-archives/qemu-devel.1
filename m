Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99FEC3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 21:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D682133F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 21:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rgeFwQ2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D682133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1dkc-0004W5-Op
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 17:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1dgg-0001M2-Hq
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 17:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1dge-00035e-Hm
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 17:35:06 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39704)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1dgc-00032p-HK
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 17:35:04 -0400
Received: by mail-pf1-x443.google.com with SMTP id y200so1357593pfb.6
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2019 14:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vNEsJcB2kukOuHiyOwZ4ZNcbnZh0P4uvd68CJElB0UM=;
 b=rgeFwQ2v34ZzDuPDQgHGQsCpSDKPRgIiGSdMipmsbSX+aheUfiumGIqtXKt/j1LaSf
 W2HHQO/ZHzIZfwYv8VewLyISpxPAcKFuEMH/x692np2eGFG2C2+jm/lquf+SeePGzDiX
 wKNAChlY4dPRgW9SnrtiMCb00HORwYNqBIbua7c2ZJReJte7u7S9Hvh9L+2+wzrwGVNV
 ol3Kd+Hltt5amD3xjyCDy18eKAZ3hXPdaNVfpHnjRSvzaYOT/epR51Ww9lw1nQPvvrkq
 2a++6bmxMAdWdQSjBa3mHW4KZ6r3Mzuskn575G/4NLJ6DDzBdsS8rq6vv78/K6JkZ1cX
 UWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vNEsJcB2kukOuHiyOwZ4ZNcbnZh0P4uvd68CJElB0UM=;
 b=tajVj3ra7S7ZRNsrXe+Bu6KeUfKRyQZ30i2nJAHNCmlzteY3psDXT4V6G61HPhjhvb
 7YPMgBGVMxNk+J0s9pKd/snjps3n9WFvddJuC33Nz9g0xzj0daTvE77GN1QyYoK0IeHo
 zrqR2OfbbqA2Fiv7qY6bXBMUpNxI6PHGdRQgxsfA6pShMUikWgUdY+RimaP1Lr41fCFN
 tJPipw8AEdy1+a48DGrzgtZH+ilvfvQCexZNkIjjr+wEUXq2uovRl+KCSm7NPUEfGn6c
 UfLr3DN+AZ/7gGKfkwAZ6hgQDftNvz+onVrKILDNrcdONBrFKVOLaYAKqwYZoj6wn8kU
 5IXw==
X-Gm-Message-State: APjAAAW0bxC9iUZBej2Wn83220e/4Ki9AxhW/r8f3EA6xJwuc++7+sBq
 oGXIh289bL1JQxHn6FEsgKaefWFYr5o=
X-Google-Smtp-Source: APXvYqx8451f+uKW+ygQwXO/bVu2qRkRBYiGVddMPsbSjnqsm26zphtmbh8+mu97O89ph1zrqVY5nw==
X-Received: by 2002:a17:90a:3266:: with SMTP id
 k93mr12250768pjb.46.1566682500442; 
 Sat, 24 Aug 2019 14:35:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 81sm6325753pfx.111.2019.08.24.14.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Aug 2019 14:34:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 14:34:50 -0700
Message-Id: <20190824213451.31118-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190824213451.31118-1-richard.henderson@linaro.org>
References: <20190824213451.31118-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 5/6] cputlb: Handle watchpoints via
 TLB_WATCHPOINT
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The raising of exceptions from check_watchpoint, buried inside
of the I/O subsystem, is fundamentally broken.  We do not have
the helper return address with which we can unwind guest state.

Replace PHYS_SECTION_WATCH and io_mem_watch with TLB_WATCHPOINT.
Move the call to cpu_check_watchpoint into the cputlb helpers
where we do have the helper return address.

This also allows us to handle watchpoints on RAM to bypass the
full i/o access path.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h |   5 +-
 accel/tcg/cputlb.c     |  83 +++++++++++++++++++++++++++---
 exec.c                 | 114 +++--------------------------------------
 3 files changed, 87 insertions(+), 115 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 8d07ae23a5..d2d443c4f9 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -329,11 +329,14 @@ CPUArchState *cpu_copy(CPUArchState *env);
 #define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS - 2))
 /* Set if TLB entry is an IO callback.  */
 #define TLB_MMIO            (1 << (TARGET_PAGE_BITS - 3))
+/* Set if TLB entry contains a watchpoint.  */
+#define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS - 4))
 
 /* Use this mask to check interception with an alignment mask
  * in a TCG backend.
  */
-#define TLB_FLAGS_MASK  (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO)
+#define TLB_FLAGS_MASK \
+    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO | TLB_WATCHPOINT)
 
 /**
  * tlb_hit_page: return true if page aligned @addr is a hit against the
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c9576bebcf..f7a414a131 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -710,6 +710,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     hwaddr iotlb, xlat, sz, paddr_page;
     target_ulong vaddr_page;
     int asidx = cpu_asidx_from_attrs(cpu, attrs);
+    int wp_flags;
 
     assert_cpu_is_self(cpu);
 
@@ -752,6 +753,8 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     code_address = address;
     iotlb = memory_region_section_get_iotlb(cpu, section, vaddr_page,
                                             paddr_page, xlat, prot, &address);
+    wp_flags = cpu_watchpoint_address_matches(cpu, vaddr_page,
+                                              TARGET_PAGE_SIZE);
 
     index = tlb_index(env, mmu_idx, vaddr_page);
     te = tlb_entry(env, mmu_idx, vaddr_page);
@@ -805,6 +808,9 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     tn.addend = addend - vaddr_page;
     if (prot & PAGE_READ) {
         tn.addr_read = address;
+        if (wp_flags & BP_MEM_READ) {
+            tn.addr_read |= TLB_WATCHPOINT;
+        }
     } else {
         tn.addr_read = -1;
     }
@@ -831,6 +837,9 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
         if (prot & PAGE_WRITE_INV) {
             tn.addr_write |= TLB_INVALID_MASK;
         }
+        if (wp_flags & BP_MEM_WRITE) {
+            tn.addr_write |= TLB_WATCHPOINT;
+        }
     }
 
     copy_tlb_helper_locked(te, &tn);
@@ -1264,13 +1273,33 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         tlb_addr &= ~TLB_INVALID_MASK;
     }
 
-    /* Handle an IO access.  */
+    /* Handle anything that isn't just a straight memory access.  */
     if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
+        CPUIOTLBEntry *iotlbentry;
+
+        /* For anything that is unaligned, recurse through full_load.  */
         if ((addr & (size - 1)) != 0) {
             goto do_unaligned_access;
         }
-        return io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
-                        mmu_idx, addr, retaddr, access_type, op);
+
+        iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
+
+        /* Handle watchpoints.  */
+        if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
+            /* On watchpoint hit, this will longjmp out.  */
+            cpu_check_watchpoint(env_cpu(env), addr, size,
+                                 iotlbentry->attrs, BP_MEM_READ, retaddr);
+
+            /* The backing page may or may not require I/O.  */
+            tlb_addr &= ~TLB_WATCHPOINT;
+            if ((tlb_addr & ~TARGET_PAGE_MASK) == 0) {
+                goto do_aligned_access;
+            }
+        }
+
+        /* Handle I/O access.  */
+        return io_readx(env, iotlbentry, mmu_idx, addr,
+                        retaddr, access_type, op);
     }
 
     /* Handle slow unaligned access (it spans two pages or IO).  */
@@ -1297,6 +1326,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         return res & MAKE_64BIT_MASK(0, size * 8);
     }
 
+ do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
     switch (op) {
     case MO_UB:
@@ -1486,13 +1516,32 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         tlb_addr = tlb_addr_write(entry) & ~TLB_INVALID_MASK;
     }
 
-    /* Handle an IO access.  */
+    /* Handle anything that isn't just a straight memory access.  */
     if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
+        CPUIOTLBEntry *iotlbentry;
+
+        /* For anything that is unaligned, recurse through byte stores.  */
         if ((addr & (size - 1)) != 0) {
             goto do_unaligned_access;
         }
-        io_writex(env, &env_tlb(env)->d[mmu_idx].iotlb[index], mmu_idx,
-                  val, addr, retaddr, op);
+
+        iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
+
+        /* Handle watchpoints.  */
+        if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
+            /* On watchpoint hit, this will longjmp out.  */
+            cpu_check_watchpoint(env_cpu(env), addr, size,
+                                 iotlbentry->attrs, BP_MEM_WRITE, retaddr);
+
+            /* The backing page may or may not require I/O.  */
+            tlb_addr &= ~TLB_WATCHPOINT;
+            if ((tlb_addr & ~TARGET_PAGE_MASK) == 0) {
+                goto do_aligned_access;
+            }
+        }
+
+        /* Handle I/O access.  */
+        io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, op);
         return;
     }
 
@@ -1504,6 +1553,8 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         uintptr_t index2;
         CPUTLBEntry *entry2;
         target_ulong page2, tlb_addr2;
+        size_t size2;
+
     do_unaligned_access:
         /*
          * Ensure the second page is in the TLB.  Note that the first page
@@ -1511,16 +1562,33 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
          * cannot evict the first.
          */
         page2 = (addr + size) & TARGET_PAGE_MASK;
+        size2 = (addr + size) & ~TARGET_PAGE_MASK;
         index2 = tlb_index(env, mmu_idx, page2);
         entry2 = tlb_entry(env, mmu_idx, page2);
         tlb_addr2 = tlb_addr_write(entry2);
         if (!tlb_hit_page(tlb_addr2, page2)
             && !victim_tlb_hit(env, mmu_idx, index2, tlb_off,
                                page2 & TARGET_PAGE_MASK)) {
-            tlb_fill(env_cpu(env), page2, size, MMU_DATA_STORE,
+            tlb_fill(env_cpu(env), page2, size2, MMU_DATA_STORE,
                      mmu_idx, retaddr);
         }
 
+        /*
+         * Handle watchpoints.  Since this may trap, all checks
+         * must happen before any store.
+         */
+        if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
+            cpu_check_watchpoint(env_cpu(env), addr,
+                                 -(addr | TARGET_PAGE_MASK),
+                                 env_tlb(env)->d[mmu_idx].iotlb[index].attrs,
+                                 BP_MEM_WRITE, retaddr);
+        }
+        if (unlikely(tlb_addr2 & TLB_WATCHPOINT)) {
+            cpu_check_watchpoint(env_cpu(env), page2, size2,
+                                 env_tlb(env)->d[mmu_idx].iotlb[index2].attrs,
+                                 BP_MEM_WRITE, retaddr);
+        }
+
         /*
          * XXX: not efficient, but simple.
          * This loop must go in the forward direction to avoid issues
@@ -1540,6 +1608,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         return;
     }
 
+ do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
     switch (op) {
     case MO_UB:
diff --git a/exec.c b/exec.c
index 8575ce51ad..ad0f4a598f 100644
--- a/exec.c
+++ b/exec.c
@@ -193,15 +193,12 @@ typedef struct subpage_t {
 #define PHYS_SECTION_UNASSIGNED 0
 #define PHYS_SECTION_NOTDIRTY 1
 #define PHYS_SECTION_ROM 2
-#define PHYS_SECTION_WATCH 3
 
 static void io_mem_init(void);
 static void memory_map_init(void);
 static void tcg_log_global_after_sync(MemoryListener *listener);
 static void tcg_commit(MemoryListener *listener);
 
-static MemoryRegion io_mem_watch;
-
 /**
  * CPUAddressSpace: all the information a CPU needs about an AddressSpace
  * @cpu: the CPU whose AddressSpace this is
@@ -1472,7 +1469,6 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
                                        target_ulong *address)
 {
     hwaddr iotlb;
-    int flags, match;
 
     if (memory_region_is_ram(section->mr)) {
         /* Normal RAM.  */
@@ -1490,19 +1486,6 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
         iotlb += xlat;
     }
 
-    /* Avoid trapping reads of pages with a write breakpoint. */
-    match = (prot & PAGE_READ ? BP_MEM_READ : 0)
-          | (prot & PAGE_WRITE ? BP_MEM_WRITE : 0);
-    flags = cpu_watchpoint_address_matches(cpu, vaddr, TARGET_PAGE_SIZE);
-    if (flags & match) {
-        /*
-         * Make accesses to pages with watchpoints go via the
-         * watchpoint trap routines.
-         */
-        iotlb = PHYS_SECTION_WATCH + paddr;
-        *address |= TLB_MMIO;
-    }
-
     return iotlb;
 }
 #endif /* defined(CONFIG_USER_ONLY) */
@@ -2810,10 +2793,14 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
 
     assert(tcg_enabled());
     if (cpu->watchpoint_hit) {
-        /* We re-entered the check after replacing the TB. Now raise
-         * the debug interrupt so that is will trigger after the
-         * current instruction. */
+        /*
+         * We re-entered the check after replacing the TB.
+         * Now raise the debug interrupt so that it will
+         * trigger after the current instruction.
+         */
+        qemu_mutex_lock_iothread();
         cpu_interrupt(cpu, CPU_INTERRUPT_DEBUG);
+        qemu_mutex_unlock_iothread();
         return;
     }
 
@@ -2858,88 +2845,6 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
     }
 }
 
-static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
-{
-    CPUState *cpu = current_cpu;
-    vaddr addr = (cpu->mem_io_vaddr & TARGET_PAGE_MASK) + offset;
-
-    cpu_check_watchpoint(cpu, addr, len, attrs, flags, 0);
-}
-
-/* Watchpoint access routines.  Watchpoints are inserted using TLB tricks,
-   so these check for a hit then pass through to the normal out-of-line
-   phys routines.  */
-static MemTxResult watch_mem_read(void *opaque, hwaddr addr, uint64_t *pdata,
-                                  unsigned size, MemTxAttrs attrs)
-{
-    MemTxResult res;
-    uint64_t data;
-    int asidx = cpu_asidx_from_attrs(current_cpu, attrs);
-    AddressSpace *as = current_cpu->cpu_ases[asidx].as;
-
-    check_watchpoint(addr & ~TARGET_PAGE_MASK, size, attrs, BP_MEM_READ);
-    switch (size) {
-    case 1:
-        data = address_space_ldub(as, addr, attrs, &res);
-        break;
-    case 2:
-        data = address_space_lduw(as, addr, attrs, &res);
-        break;
-    case 4:
-        data = address_space_ldl(as, addr, attrs, &res);
-        break;
-    case 8:
-        data = address_space_ldq(as, addr, attrs, &res);
-        break;
-    default: abort();
-    }
-    *pdata = data;
-    return res;
-}
-
-static MemTxResult watch_mem_write(void *opaque, hwaddr addr,
-                                   uint64_t val, unsigned size,
-                                   MemTxAttrs attrs)
-{
-    MemTxResult res;
-    int asidx = cpu_asidx_from_attrs(current_cpu, attrs);
-    AddressSpace *as = current_cpu->cpu_ases[asidx].as;
-
-    check_watchpoint(addr & ~TARGET_PAGE_MASK, size, attrs, BP_MEM_WRITE);
-    switch (size) {
-    case 1:
-        address_space_stb(as, addr, val, attrs, &res);
-        break;
-    case 2:
-        address_space_stw(as, addr, val, attrs, &res);
-        break;
-    case 4:
-        address_space_stl(as, addr, val, attrs, &res);
-        break;
-    case 8:
-        address_space_stq(as, addr, val, attrs, &res);
-        break;
-    default: abort();
-    }
-    return res;
-}
-
-static const MemoryRegionOps watch_mem_ops = {
-    .read_with_attrs = watch_mem_read,
-    .write_with_attrs = watch_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 8,
-        .unaligned = false,
-    },
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 8,
-        .unaligned = false,
-    },
-};
-
 static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
                                  MemTxAttrs attrs, uint8_t *buf, hwaddr len);
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
@@ -3115,9 +3020,6 @@ static void io_mem_init(void)
     memory_region_init_io(&io_mem_notdirty, NULL, &notdirty_mem_ops, NULL,
                           NULL, UINT64_MAX);
     memory_region_clear_global_locking(&io_mem_notdirty);
-
-    memory_region_init_io(&io_mem_watch, NULL, &watch_mem_ops, NULL,
-                          NULL, UINT64_MAX);
 }
 
 AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
@@ -3131,8 +3033,6 @@ AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
     assert(n == PHYS_SECTION_NOTDIRTY);
     n = dummy_section(&d->map, fv, &io_mem_rom);
     assert(n == PHYS_SECTION_ROM);
-    n = dummy_section(&d->map, fv, &io_mem_watch);
-    assert(n == PHYS_SECTION_WATCH);
 
     d->phys_map  = (PhysPageEntry) { .ptr = PHYS_MAP_NODE_NIL, .skip = 1 };
 
-- 
2.17.1



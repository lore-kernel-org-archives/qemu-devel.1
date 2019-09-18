Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B356C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09285208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nTU/ED6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09285208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAeQt-0001Xq-4c
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 14:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAeIG-000240-Va
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAeIE-0000Ui-Ct
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:03:08 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAeIA-0000TB-Ut
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:03:04 -0400
Received: by mail-pl1-x644.google.com with SMTP id 4so308112pld.10
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 11:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XLbwjWXO2o10cL5F/+EEPP36UeeSrQvwCcEMZEHp8Do=;
 b=nTU/ED6P7tx9oR8mjY6GuoWqAtdeLxB+hvbHKfkaBosbes8Q2JsZ9P27HwAzIOUB9P
 c5oC+NZDJn1QnwOkApyWRoX8lVkH5PW7Iggct9LXEah6C+V6UYHTt9/TUR9PY8HwAoTS
 RDzkr2aZDNsp3a1YjLSGDcMi5G8LsSi5qmdFG100qe0Q0o/tL8GBt3B5hXqeOcRRP7nx
 HAJdLVQUFnGKbIxOyTp7M3JVTVkbWjXrbqOJ5E3B6ctiKZQ0ZSu6Jezb6cS2lVCQ0fnT
 qM2s5QPtIlCDZtnVf71qmk/oTQTjV80HdfidOyRYjBkgB3mV/YcAJzlRJBVhWmOqadRg
 uwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XLbwjWXO2o10cL5F/+EEPP36UeeSrQvwCcEMZEHp8Do=;
 b=WVKKa7fXaLLom6QGYcpEsHga2HswrjL4C6I+Efn8LhWU0kh+yVp0G5VsF8meQXRT0E
 Ri5ZERlodtC0UGHf6CE9cjrGPXgVnWNeMWRmhhQ6hICRidLlPzeE3PIKuN7mO8T0fRsQ
 qhUY6iHCy8YfvuW8CcZuCJcz1tzl/UL52FqNpYbETjXoqf1M7CI/dXb0NFX/+OmAP0/p
 uXCsF0vFryqjsBbGxCuGzmW3qViqpvbkTPMDOXH+/unXDuS2YSrBdiyQL+zSGBbHxyOM
 lKokD38OgS/NDS7Ivw9mK+Y0DsBMsvaLz/e4BEfZG5CWRG4t998s4CK02ZpJaileSFnW
 6rww==
X-Gm-Message-State: APjAAAU4SF9OnaJ88q+AnSPvZHccTKj/OJuL/GpAmauBVtZGQXpBif8n
 h4tfhlRChgqIy0ytB2sYmZFnnSww6v8=
X-Google-Smtp-Source: APXvYqzFpuHokLmlPmCjcVcGyxXxURMwvXngdcmMAohomqXq7tY/eDteA3cEmzCzc+LRRunsQegtiw==
X-Received: by 2002:a17:902:8bca:: with SMTP id
 r10mr5407494plo.338.1568829780263; 
 Wed, 18 Sep 2019 11:03:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b16sm13319518pfb.54.2019.09.18.11.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 11:02:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 18 Sep 2019 11:02:51 -0700
Message-Id: <20190918180251.32003-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190918180251.32003-1-richard.henderson@linaro.org>
References: <20190918180251.32003-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [RFC v2 5/5] cputlb: Move NOTDIRTY handling from I/O
 path to TLB path
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pages that we want to track for NOTDIRTY are RAM.  We do not
really need to go through the I/O path to handle them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h |  1 -
 accel/tcg/cputlb.c        | 23 ++++++++++++++---
 exec.c                    | 54 +++------------------------------------
 memory.c                  | 16 ------------
 4 files changed, 23 insertions(+), 71 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index f7dbe75fbc..06c60c82be 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -101,7 +101,6 @@ void qemu_flush_coalesced_mmio_buffer(void);
 void cpu_flush_icache_range(hwaddr start, hwaddr len);
 
 extern struct MemoryRegion io_mem_rom;
-extern struct MemoryRegion io_mem_notdirty;
 
 typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7301f9e699..c6c66b40bb 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -904,7 +904,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
     cpu->mem_io_pc = retaddr;
-    if (mr != &io_mem_rom && mr != &io_mem_notdirty && !cpu->can_do_io) {
+    if (mr != &io_mem_rom && !cpu->can_do_io) {
         cpu_io_recompile(cpu, retaddr);
     }
 
@@ -945,7 +945,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
-    if (mr != &io_mem_rom && mr != &io_mem_notdirty && !cpu->can_do_io) {
+    if (mr != &io_mem_rom && !cpu->can_do_io) {
         cpu_io_recompile(cpu, retaddr);
     }
     cpu->mem_io_vaddr = addr;
@@ -1607,7 +1607,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         }
 
         /* Handle I/O access.  */
-        if (likely(tlb_addr & (TLB_MMIO | TLB_NOTDIRTY))) {
+        if (tlb_addr & TLB_MMIO) {
             io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr,
                       op ^ (tlb_addr & TLB_BSWAP ? MO_BSWAP : 0));
             return;
@@ -1615,6 +1615,23 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 
         haddr = (void *)((uintptr_t)addr + entry->addend);
 
+        /* Handle clean RAM pages.  */
+        if (tlb_addr & TLB_NOTDIRTY) {
+            NotDirtyInfo ndi;
+
+            memory_notdirty_write_prepare(&ndi, env_cpu(env), addr,
+                                          addr + iotlbentry->addr, size);
+
+            if (unlikely(tlb_addr & TLB_BSWAP)) {
+                direct_swap(haddr, val);
+            } else {
+                direct(haddr, val);
+            }
+
+            memory_notdirty_write_complete(&ndi);
+            return;
+        }
+
         if (unlikely(tlb_addr & TLB_BSWAP)) {
             direct_swap(haddr, val);
         } else {
diff --git a/exec.c b/exec.c
index 5f2587b621..4600292ee2 100644
--- a/exec.c
+++ b/exec.c
@@ -88,7 +88,7 @@ static MemoryRegion *system_io;
 AddressSpace address_space_io;
 AddressSpace address_space_memory;
 
-MemoryRegion io_mem_rom, io_mem_notdirty;
+MemoryRegion io_mem_rom;
 static MemoryRegion io_mem_unassigned;
 #endif
 
@@ -191,8 +191,7 @@ typedef struct subpage_t {
 } subpage_t;
 
 #define PHYS_SECTION_UNASSIGNED 0
-#define PHYS_SECTION_NOTDIRTY 1
-#define PHYS_SECTION_ROM 2
+#define PHYS_SECTION_ROM 1
 
 static void io_mem_init(void);
 static void memory_map_init(void);
@@ -1473,9 +1472,7 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
     if (memory_region_is_ram(section->mr)) {
         /* Normal RAM.  */
         iotlb = memory_region_get_ram_addr(section->mr) + xlat;
-        if (!section->readonly) {
-            iotlb |= PHYS_SECTION_NOTDIRTY;
-        } else {
+        if (section->readonly) {
             iotlb |= PHYS_SECTION_ROM;
         }
     } else {
@@ -2786,42 +2783,6 @@ void memory_notdirty_write_complete(NotDirtyInfo *ndi)
     }
 }
 
-/* Called within RCU critical section.  */
-static void notdirty_mem_write(void *opaque, hwaddr ram_addr,
-                               uint64_t val, unsigned size)
-{
-    NotDirtyInfo ndi;
-
-    memory_notdirty_write_prepare(&ndi, current_cpu, current_cpu->mem_io_vaddr,
-                         ram_addr, size);
-
-    stn_p(qemu_map_ram_ptr(NULL, ram_addr), size, val);
-    memory_notdirty_write_complete(&ndi);
-}
-
-static bool notdirty_mem_accepts(void *opaque, hwaddr addr,
-                                 unsigned size, bool is_write,
-                                 MemTxAttrs attrs)
-{
-    return is_write;
-}
-
-static const MemoryRegionOps notdirty_mem_ops = {
-    .write = notdirty_mem_write,
-    .valid.accepts = notdirty_mem_accepts,
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
 /* Generate a debug exception if a watchpoint has been hit.  */
 void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                           MemTxAttrs attrs, int flags, uintptr_t ra)
@@ -3051,13 +3012,6 @@ static void io_mem_init(void)
                           NULL, NULL, UINT64_MAX);
     memory_region_init_io(&io_mem_unassigned, NULL, &unassigned_mem_ops, NULL,
                           NULL, UINT64_MAX);
-
-    /* io_mem_notdirty calls tb_invalidate_phys_page_fast,
-     * which can be called without the iothread mutex.
-     */
-    memory_region_init_io(&io_mem_notdirty, NULL, &notdirty_mem_ops, NULL,
-                          NULL, UINT64_MAX);
-    memory_region_clear_global_locking(&io_mem_notdirty);
 }
 
 AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
@@ -3067,8 +3021,6 @@ AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
 
     n = dummy_section(&d->map, fv, &io_mem_unassigned);
     assert(n == PHYS_SECTION_UNASSIGNED);
-    n = dummy_section(&d->map, fv, &io_mem_notdirty);
-    assert(n == PHYS_SECTION_NOTDIRTY);
     n = dummy_section(&d->map, fv, &io_mem_rom);
     assert(n == PHYS_SECTION_ROM);
 
diff --git a/memory.c b/memory.c
index 57c44c97db..a99b8c0767 100644
--- a/memory.c
+++ b/memory.c
@@ -434,10 +434,6 @@ static MemTxResult  memory_region_read_accessor(MemoryRegion *mr,
     tmp = mr->ops->read(mr->opaque, addr, size);
     if (mr->subpage) {
         trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, size);
-    } else if (mr == &io_mem_notdirty) {
-        /* Accesses to code which has previously been translated into a TB show
-         * up in the MMIO path, as accesses to the io_mem_notdirty
-         * MemoryRegion. */
     } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size);
@@ -460,10 +456,6 @@ static MemTxResult memory_region_read_with_attrs_accessor(MemoryRegion *mr,
     r = mr->ops->read_with_attrs(mr->opaque, addr, &tmp, size, attrs);
     if (mr->subpage) {
         trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, size);
-    } else if (mr == &io_mem_notdirty) {
-        /* Accesses to code which has previously been translated into a TB show
-         * up in the MMIO path, as accesses to the io_mem_notdirty
-         * MemoryRegion. */
     } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size);
@@ -484,10 +476,6 @@ static MemTxResult memory_region_write_accessor(MemoryRegion *mr,
 
     if (mr->subpage) {
         trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp, size);
-    } else if (mr == &io_mem_notdirty) {
-        /* Accesses to code which has previously been translated into a TB show
-         * up in the MMIO path, as accesses to the io_mem_notdirty
-         * MemoryRegion. */
     } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp, size);
@@ -508,10 +496,6 @@ static MemTxResult memory_region_write_with_attrs_accessor(MemoryRegion *mr,
 
     if (mr->subpage) {
         trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp, size);
-    } else if (mr == &io_mem_notdirty) {
-        /* Accesses to code which has previously been translated into a TB show
-         * up in the MMIO path, as accesses to the io_mem_notdirty
-         * MemoryRegion. */
     } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp, size);
-- 
2.17.1



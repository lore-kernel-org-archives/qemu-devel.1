Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78149C432C1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E0EB20820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="glCrdzOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0EB20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCXQH-0002KB-5B
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 19:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJi-0005el-SL
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJe-00085r-MK
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:24 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37264)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCXJd-00084E-9k
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:21 -0400
Received: by mail-pg1-x541.google.com with SMTP id c17so8902251pgg.4
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 16:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NhzrS+UIOSFtL4L3OeVJ9R1mroLMMWk6BNqriyW4mtQ=;
 b=glCrdzOGjQNaW6nUpHPCy9c93a9mLapFQ0ADqqN+RkMVJtevQgwmju+Qqa5Y5vnubc
 PZKYlxz4JumUSuZZ/my4i/qbSRE+zixFC+WNbd1Uew+7P1LOqE7I5R9VG94lV0Mbb/ZM
 CJB+jaD2bfEo28//CqHrLpLA33l7plmmZ6bEyu3UeeFSr0+bZoZHzYKqBOltDMvLhm3k
 X7EThIfT2j0JSW1ktwXIp/Gfa+6gpfuOm0Hi185o3YEYV3hD8WErf/gkh8PqbY83tGzp
 uwLJGXDMMWbbBamKQMo9MfbfXkwiRgntf/s3rEef+kqSRBpeoJs+Ck/J0GMh8tJ3vDqG
 hcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=NhzrS+UIOSFtL4L3OeVJ9R1mroLMMWk6BNqriyW4mtQ=;
 b=IIZXzWzw+INUljKfkOAs5h+7RMNjDEkuEVN3bVuWdP3AgKL/NNJDSsHmDOoSGOCPh5
 XwFB2dBixm5edPdwp6UETMkFVaPk0ENDCZc7OrJ0hVcqp0Ycp04GR5EHzGrxOj4PaMZI
 dWptKHOG3KsGPdMUrUO7rnzJyLGURud92MnvXQ8othbFtvxSvUIXjw4D5dqj7TQEf0TZ
 HvZVtkQeL0ufVNtf1LWWkR90rDGysMWTkyouJtVDrMKH4z0gsG7SmaiRAmveE+xfMi9M
 vlI/L0efd2VcjlF5kERipL3+So84lrl2XE8zrZs08z4A1TRP2deLPr1mS5JAmes8G8L/
 tcow==
X-Gm-Message-State: APjAAAVzREH5tZTyJlJesnIYb9+2MpetUvlPoA23LlPJO+iInFN2iKCH
 IKmD+AbamEOdbApeHftzXKA06rhQfNQ=
X-Google-Smtp-Source: APXvYqxe4wAfQraMMEBSS27rpcg7iVFOJLqyidpmMFttY/4sUQ3aLq9i47mIs4amwafpztwvyiN7Xw==
X-Received: by 2002:a62:168e:: with SMTP id 136mr2217219pfw.144.1569279619856; 
 Mon, 23 Sep 2019 16:00:19 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id 74sm11674810pfy.78.2019.09.23.16.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 16:00:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/16] cputlb: Move ROM handling from I/O path to TLB path
Date: Mon, 23 Sep 2019 15:59:56 -0700
Message-Id: <20190923230004.9231-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923230004.9231-1-richard.henderson@linaro.org>
References: <20190923230004.9231-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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

It does not require going through the whole I/O path
in order to discard a write.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h    |  5 ++++-
 include/exec/cpu-common.h |  1 -
 accel/tcg/cputlb.c        | 35 +++++++++++++++++++--------------
 exec.c                    | 41 +--------------------------------------
 4 files changed, 25 insertions(+), 57 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index d148bded35..26547cd6dd 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -337,12 +337,15 @@ CPUArchState *cpu_copy(CPUArchState *env);
 #define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS_MIN - 4))
 /* Set if TLB entry requires byte swap.  */
 #define TLB_BSWAP           (1 << (TARGET_PAGE_BITS_MIN - 5))
+/* Set if TLB entry writes ignored.  */
+#define TLB_ROM             (1 << (TARGET_PAGE_BITS_MIN - 6))
 
 /* Use this mask to check interception with an alignment mask
  * in a TCG backend.
  */
 #define TLB_FLAGS_MASK \
-    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO | TLB_WATCHPOINT | TLB_BSWAP)
+    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
+    | TLB_WATCHPOINT | TLB_BSWAP | TLB_ROM)
 
 /**
  * tlb_hit_page: return true if page aligned @addr is a hit against the
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index f7dbe75fbc..1c0e03ddc2 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -100,7 +100,6 @@ void qemu_flush_coalesced_mmio_buffer(void);
 
 void cpu_flush_icache_range(hwaddr start, hwaddr len);
 
-extern struct MemoryRegion io_mem_rom;
 extern struct MemoryRegion io_mem_notdirty;
 
 typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f634edb4f4..af9a44a847 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -577,7 +577,7 @@ static void tlb_reset_dirty_range_locked(CPUTLBEntry *tlb_entry,
 {
     uintptr_t addr = tlb_entry->addr_write;
 
-    if ((addr & (TLB_INVALID_MASK | TLB_MMIO | TLB_NOTDIRTY)) == 0) {
+    if ((addr & (TLB_INVALID_MASK | TLB_MMIO | TLB_ROM | TLB_NOTDIRTY)) == 0) {
         addr &= TARGET_PAGE_MASK;
         addr += tlb_entry->addend;
         if ((addr - start) < length) {
@@ -745,7 +745,6 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
         address |= TLB_MMIO;
         addend = 0;
     } else {
-        /* TLB_MMIO for rom/romd handled below */
         addend = (uintptr_t)memory_region_get_ram_ptr(section->mr) + xlat;
     }
 
@@ -822,16 +821,17 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
 
     tn.addr_write = -1;
     if (prot & PAGE_WRITE) {
-        if ((memory_region_is_ram(section->mr) && section->readonly)
-            || memory_region_is_romd(section->mr)) {
-            /* Write access calls the I/O callback.  */
-            tn.addr_write = address | TLB_MMIO;
-        } else if (memory_region_is_ram(section->mr)
-                   && cpu_physical_memory_is_clean(
-                       memory_region_get_ram_addr(section->mr) + xlat)) {
-            tn.addr_write = address | TLB_NOTDIRTY;
-        } else {
-            tn.addr_write = address;
+        tn.addr_write = address;
+        if (memory_region_is_romd(section->mr)) {
+            /* Use the MMIO path so that the device can switch states. */
+            tn.addr_write |= TLB_MMIO;
+        } else if (memory_region_is_ram(section->mr)) {
+            if (section->readonly) {
+                tn.addr_write |= TLB_ROM;
+            } else if (cpu_physical_memory_is_clean(
+                        memory_region_get_ram_addr(section->mr) + xlat)) {
+                tn.addr_write |= TLB_NOTDIRTY;
+            }
         }
         if (prot & PAGE_WRITE_INV) {
             tn.addr_write |= TLB_INVALID_MASK;
@@ -904,7 +904,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
     cpu->mem_io_pc = retaddr;
-    if (mr != &io_mem_rom && mr != &io_mem_notdirty && !cpu->can_do_io) {
+    if (mr != &io_mem_notdirty && !cpu->can_do_io) {
         cpu_io_recompile(cpu, retaddr);
     }
 
@@ -945,7 +945,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
-    if (mr != &io_mem_rom && mr != &io_mem_notdirty && !cpu->can_do_io) {
+    if (mr != &io_mem_notdirty && !cpu->can_do_io) {
         cpu_io_recompile(cpu, retaddr);
     }
     cpu->mem_io_vaddr = addr;
@@ -1125,7 +1125,7 @@ void *probe_access(CPUArchState *env, target_ulong addr, int size,
     }
 
     /* Reject I/O access, or other required slow-path.  */
-    if (tlb_addr & (TLB_NOTDIRTY | TLB_MMIO | TLB_BSWAP)) {
+    if (tlb_addr & (TLB_NOTDIRTY | TLB_MMIO | TLB_BSWAP | TLB_ROM)) {
         return NULL;
     }
 
@@ -1613,6 +1613,11 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
             return;
         }
 
+        /* Ignore writes to ROM.  */
+        if (unlikely(tlb_addr & TLB_ROM)) {
+            return;
+        }
+
         haddr = (void *)((uintptr_t)addr + entry->addend);
 
         if (unlikely(need_swap)) {
diff --git a/exec.c b/exec.c
index 5f2587b621..ea8c0b18ac 100644
--- a/exec.c
+++ b/exec.c
@@ -88,7 +88,7 @@ static MemoryRegion *system_io;
 AddressSpace address_space_io;
 AddressSpace address_space_memory;
 
-MemoryRegion io_mem_rom, io_mem_notdirty;
+MemoryRegion io_mem_notdirty;
 static MemoryRegion io_mem_unassigned;
 #endif
 
@@ -192,7 +192,6 @@ typedef struct subpage_t {
 
 #define PHYS_SECTION_UNASSIGNED 0
 #define PHYS_SECTION_NOTDIRTY 1
-#define PHYS_SECTION_ROM 2
 
 static void io_mem_init(void);
 static void memory_map_init(void);
@@ -1475,8 +1474,6 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
         iotlb = memory_region_get_ram_addr(section->mr) + xlat;
         if (!section->readonly) {
             iotlb |= PHYS_SECTION_NOTDIRTY;
-        } else {
-            iotlb |= PHYS_SECTION_ROM;
         }
     } else {
         AddressSpaceDispatch *d;
@@ -3002,38 +2999,6 @@ static uint16_t dummy_section(PhysPageMap *map, FlatView *fv, MemoryRegion *mr)
     return phys_section_add(map, &section);
 }
 
-static void readonly_mem_write(void *opaque, hwaddr addr,
-                               uint64_t val, unsigned size)
-{
-    /* Ignore any write to ROM. */
-}
-
-static bool readonly_mem_accepts(void *opaque, hwaddr addr,
-                                 unsigned size, bool is_write,
-                                 MemTxAttrs attrs)
-{
-    return is_write;
-}
-
-/* This will only be used for writes, because reads are special cased
- * to directly access the underlying host ram.
- */
-static const MemoryRegionOps readonly_mem_ops = {
-    .write = readonly_mem_write,
-    .valid.accepts = readonly_mem_accepts,
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
 MemoryRegionSection *iotlb_to_section(CPUState *cpu,
                                       hwaddr index, MemTxAttrs attrs)
 {
@@ -3047,8 +3012,6 @@ MemoryRegionSection *iotlb_to_section(CPUState *cpu,
 
 static void io_mem_init(void)
 {
-    memory_region_init_io(&io_mem_rom, NULL, &readonly_mem_ops,
-                          NULL, NULL, UINT64_MAX);
     memory_region_init_io(&io_mem_unassigned, NULL, &unassigned_mem_ops, NULL,
                           NULL, UINT64_MAX);
 
@@ -3069,8 +3032,6 @@ AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
     assert(n == PHYS_SECTION_UNASSIGNED);
     n = dummy_section(&d->map, fv, &io_mem_notdirty);
     assert(n == PHYS_SECTION_NOTDIRTY);
-    n = dummy_section(&d->map, fv, &io_mem_rom);
-    assert(n == PHYS_SECTION_ROM);
 
     d->phys_map  = (PhysPageEntry) { .ptr = PHYS_MAP_NODE_NIL, .skip = 1 };
 
-- 
2.17.1



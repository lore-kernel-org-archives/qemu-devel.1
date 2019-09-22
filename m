Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF8AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F8020673
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLB7paZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F8020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBt9i-0004GW-1J
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 00:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsxz-0001jx-U1
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsxx-0008H6-GE
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:19 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33390)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBsxx-0008Gn-6T
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:17 -0400
Received: by mail-pg1-x543.google.com with SMTP id i30so266403pgl.0
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 20:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+uIocOn9VX/i7GnqHaWrqX+b4SaiUHijmC0FIzPROHE=;
 b=XLB7paZW8USoqtq1oG48bOcStD6Xn1S+IBwEQBm/3Bizq3L2PyopVXKxwM83lauig9
 sE53dKobdVWE/PzTTzYOe9G1Yd72SzozRNavwyBYucz6aR8AlHOArXVRg7oSMjqb3hYa
 kS0QIwCHlAsiFpjp/YoJO9dyDbmOTZQcDOj/z3y+7y5/VhX/5x+q7n7s0dkxp+rIZD0X
 pk1b/quzQfnsgRVJKDHU5JnOE/rRxYneK7bOcH9uYZd6IaR1uqu2+Vl5JmvFkCdInF0e
 8eVQo9Ot0S6z6BEvcBDt+vjr29PY5piA3sAamDFNeaYyet+wjevGU73oZvSsjb7ZkvOh
 5Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+uIocOn9VX/i7GnqHaWrqX+b4SaiUHijmC0FIzPROHE=;
 b=pLgBmSrZR3HiyyVotfJfvHBvWK10mz6OD/nK5MC0bbiaTSouOBAGkyoH2qxl6YMj+o
 ib3/Ub8/wYfNH2K8Z2PGCWJTgzyP7bcFOwe91jLCivHcdZb8x3vSzoJn8sRe8jGIVd2r
 SfqdDpthkUlKufOqLLp3CfKoljyMepFKllZ5Hs8Ed9TyN/yqm0ooWllHCQUvh1zGdQ6q
 U4Q1nGniQfC6Ww9qw7GlojPuy3cI3j8rVQ1zDJG9ul6oVTTRi0ArEzRhSZ8Php2qRjU6
 9sB0S30X1b9Yj9NgUxK9cbqxJDiq46jWYTwF5JjVbcrl4fUE6fCN4JuRTOqBbJ2MzPMS
 5dig==
X-Gm-Message-State: APjAAAXISB/Fi835aBYx8mkZFSORQrewLZ3661RNvAYc6gJ7Vb8tawX6
 RBsgnBCAuzSe24elmONtfJVb2MAJJvQ=
X-Google-Smtp-Source: APXvYqz05/gQGw7gkik7VN++tyucfLshev+aZ8O5g2aakphzfVDBoPHhhbaA4DXeCXqEPJcGdV6LAg==
X-Received: by 2002:a17:90a:8d84:: with SMTP id
 d4mr13473928pjo.139.1569124515935; 
 Sat, 21 Sep 2019 20:55:15 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z4sm6452921pjt.17.2019.09.21.20.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2019 20:55:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/20] cputlb: Move ROM handling from I/O path to TLB path
Date: Sat, 21 Sep 2019 20:54:50 -0700
Message-Id: <20190922035458.14879-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190922035458.14879-1-richard.henderson@linaro.org>
References: <20190922035458.14879-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h    |  5 ++++-
 include/exec/cpu-common.h |  1 -
 accel/tcg/cputlb.c        | 35 +++++++++++++++++++--------------
 exec.c                    | 41 +--------------------------------------
 4 files changed, 25 insertions(+), 57 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 1ebd1b59ab..9f0b17802e 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -348,12 +348,15 @@ CPUArchState *cpu_copy(CPUArchState *env);
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
index cb603917a2..7ab523d7ec 100644
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
 
@@ -1612,6 +1612,11 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
             return;
         }
 
+        /* Ignore writes to ROM.  */
+        if (unlikely(tlb_addr & TLB_ROM)) {
+            return;
+        }
+
         haddr = (void *)((uintptr_t)addr + entry->addend);
 
         if (unlikely(tlb_addr & TLB_BSWAP)) {
diff --git a/exec.c b/exec.c
index 7ce0515635..e21e068535 100644
--- a/exec.c
+++ b/exec.c
@@ -88,7 +88,7 @@ static MemoryRegion *system_io;
 AddressSpace address_space_io;
 AddressSpace address_space_memory;
 
-MemoryRegion io_mem_rom, io_mem_notdirty;
+MemoryRegion io_mem_notdirty;
 static MemoryRegion io_mem_unassigned;
 #endif
 
@@ -158,7 +158,6 @@ typedef struct subpage_t {
 
 #define PHYS_SECTION_UNASSIGNED 0
 #define PHYS_SECTION_NOTDIRTY 1
-#define PHYS_SECTION_ROM 2
 
 static void io_mem_init(void);
 static void memory_map_init(void);
@@ -1441,8 +1440,6 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
         iotlb = memory_region_get_ram_addr(section->mr) + xlat;
         if (!section->readonly) {
             iotlb |= PHYS_SECTION_NOTDIRTY;
-        } else {
-            iotlb |= PHYS_SECTION_ROM;
         }
     } else {
         AddressSpaceDispatch *d;
@@ -2968,38 +2965,6 @@ static uint16_t dummy_section(PhysPageMap *map, FlatView *fv, MemoryRegion *mr)
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
@@ -3013,8 +2978,6 @@ MemoryRegionSection *iotlb_to_section(CPUState *cpu,
 
 static void io_mem_init(void)
 {
-    memory_region_init_io(&io_mem_rom, NULL, &readonly_mem_ops,
-                          NULL, NULL, UINT64_MAX);
     memory_region_init_io(&io_mem_unassigned, NULL, &unassigned_mem_ops, NULL,
                           NULL, UINT64_MAX);
 
@@ -3035,8 +2998,6 @@ AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
     assert(n == PHYS_SECTION_UNASSIGNED);
     n = dummy_section(&d->map, fv, &io_mem_notdirty);
     assert(n == PHYS_SECTION_NOTDIRTY);
-    n = dummy_section(&d->map, fv, &io_mem_rom);
-    assert(n == PHYS_SECTION_ROM);
 
     d->phys_map  = (PhysPageEntry) { .ptr = PHYS_MAP_NODE_NIL, .skip = 1 };
 
-- 
2.17.1



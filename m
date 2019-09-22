Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FDEC3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3311720673
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9smUx9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3311720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBt9p-0004UI-4B
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 00:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsxx-0001gd-VL
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsxw-0008GQ-6C
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:17 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBsxv-0008G4-V3
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:16 -0400
Received: by mail-pg1-x544.google.com with SMTP id h17so3457796pgb.3
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 20:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dpN/rK4KxftzjyqayID53P95kBVBbhlVooKl6DB2vE0=;
 b=X9smUx9k0xG6l1/ESGihAGGwsL7wG9kHAlKQerk6LIqJOJhr3/sRgvl/wwoiEKBSHu
 ACdzgQk+TqHAn0pgQohUJUJ0vkpQZaK/O9/OuO/JX8yQYdlWyllpsd9viGAUjsNpJ7zf
 JVOZur0sbBgKBVqpVVg5xO1BymhBS96DNg34RgczJ/PtY/uGjOH7M6nCvanKOmzZEPZg
 vjG9gsUapw7Ph10KlWeJRwDBM6TeUsGXH7NoAeOv14fIrF1RmT8HQly+gf0hPhB9Jnzl
 mxBMmZAvCGVSdbyrqlPxMS1Lj+AjuVgGTsqYSmQoDLEItx/5LEnMxZuyTMXpFraJ3FSk
 /Dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dpN/rK4KxftzjyqayID53P95kBVBbhlVooKl6DB2vE0=;
 b=cfRuDUF755ndVwHSgFCxtA9cyx0e2xv4pX1NtoBq7vU2S3gH48716BbBUSZuWVC+vJ
 fp6sRhEIDb0c91TFfOFAFZdLBnSe80aGnDqXQZziDA2tLiLcPgru/zxyNehVf/AZD+qu
 UfQxQpASl++2LTP+/UA7mrThmMZ+zcBpXXyrGicXoWckqKC11CjO0cBlVhnbKjK0sSId
 Neik4y+apsrH3NMoWLsujWZpFkfO6We0F4J+BiIDsXEFd9oSLkhwgCVIMPuC99ULilI8
 GkSgIUg9VmOux3swB1F0+eS7VeCGEPTb4K2xnJKvEZvOXvoVwpmUijL4eqrQEZc6hXHN
 RE3A==
X-Gm-Message-State: APjAAAXucC/CnwMAK+qinKVsKKEcIjWVgYF2zbmXFLaxSCVS00hLACYH
 ZVPVbPh4ACGivfNZLESDO0j9I1DkUzU=
X-Google-Smtp-Source: APXvYqxm6KLawvZ0wTuK7gtyK7AkNmT2PfnUGKG2UxINQ6KBd9ngjUNGnML3aH3cE7XyHpbqs3mcbQ==
X-Received: by 2002:a62:7597:: with SMTP id
 q145mr25728808pfc.181.1569124514706; 
 Sat, 21 Sep 2019 20:55:14 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z4sm6452921pjt.17.2019.09.21.20.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2019 20:55:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/20] exec: Adjust notdirty tracing
Date: Sat, 21 Sep 2019 20:54:49 -0700
Message-Id: <20190922035458.14879-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190922035458.14879-1-richard.henderson@linaro.org>
References: <20190922035458.14879-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

The memory_region_tb_read tracepoint is unreachable, since notdirty
is supposed to apply only to writes.  The memory_region_tb_write
tracepoint is mis-named, because notdirty is not only used for TB
invalidation.  It is also used for e.g. VGA RAM updates and migration.

Replace memory_region_tb_write with memory_notdirty_write_access,
and place it in memory_notdirty_write_prepare where it can catch
all of the instances.  Add memory_notdirty_set_dirty to log when
we no longer intercept writes to a page.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 exec.c       | 3 +++
 memory.c     | 4 ----
 trace-events | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/exec.c b/exec.c
index 33bd0e36c1..7ce0515635 100644
--- a/exec.c
+++ b/exec.c
@@ -2721,6 +2721,8 @@ void memory_notdirty_write_prepare(NotDirtyInfo *ndi,
     ndi->size = size;
     ndi->pages = NULL;
 
+    trace_memory_notdirty_write_access(mem_vaddr, ram_addr, size);
+
     assert(tcg_enabled());
     if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)) {
         ndi->pages = page_collection_lock(ram_addr, ram_addr + size);
@@ -2745,6 +2747,7 @@ void memory_notdirty_write_complete(NotDirtyInfo *ndi)
     /* we remove the notdirty callback only if the code has been
        flushed */
     if (!cpu_physical_memory_is_clean(ndi->ram_addr)) {
+        trace_memory_notdirty_set_dirty(ndi->mem_vaddr);
         tlb_set_dirty(ndi->cpu, ndi->mem_vaddr);
     }
 }
diff --git a/memory.c b/memory.c
index b9dd6b94ca..57c44c97db 100644
--- a/memory.c
+++ b/memory.c
@@ -438,7 +438,6 @@ static MemTxResult  memory_region_read_accessor(MemoryRegion *mr,
         /* Accesses to code which has previously been translated into a TB show
          * up in the MMIO path, as accesses to the io_mem_notdirty
          * MemoryRegion. */
-        trace_memory_region_tb_read(get_cpu_index(), addr, tmp, size);
     } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size);
@@ -465,7 +464,6 @@ static MemTxResult memory_region_read_with_attrs_accessor(MemoryRegion *mr,
         /* Accesses to code which has previously been translated into a TB show
          * up in the MMIO path, as accesses to the io_mem_notdirty
          * MemoryRegion. */
-        trace_memory_region_tb_read(get_cpu_index(), addr, tmp, size);
     } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size);
@@ -490,7 +488,6 @@ static MemTxResult memory_region_write_accessor(MemoryRegion *mr,
         /* Accesses to code which has previously been translated into a TB show
          * up in the MMIO path, as accesses to the io_mem_notdirty
          * MemoryRegion. */
-        trace_memory_region_tb_write(get_cpu_index(), addr, tmp, size);
     } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp, size);
@@ -515,7 +512,6 @@ static MemTxResult memory_region_write_with_attrs_accessor(MemoryRegion *mr,
         /* Accesses to code which has previously been translated into a TB show
          * up in the MMIO path, as accesses to the io_mem_notdirty
          * MemoryRegion. */
-        trace_memory_region_tb_write(get_cpu_index(), addr, tmp, size);
     } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp, size);
diff --git a/trace-events b/trace-events
index 823a4ae64e..20821ba545 100644
--- a/trace-events
+++ b/trace-events
@@ -52,14 +52,14 @@ dma_map_wait(void *dbs) "dbs=%p"
 find_ram_offset(uint64_t size, uint64_t offset) "size: 0x%" PRIx64 " @ 0x%" PRIx64
 find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_t next, uint64_t mingap) "trying size: 0x%" PRIx64 " @ 0x%" PRIx64 ", offset: 0x%" PRIx64" next: 0x%" PRIx64 " mingap: 0x%" PRIx64
 ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
+memory_notdirty_write_access(uint64_t vaddr, uint64_t ram_addr, unsigned size) "0x%" PRIx64 " ram_addr 0x%" PRIx64 " size %u"
+memory_notdirty_set_dirty(uint64_t vaddr) "0x%" PRIx64
 
 # memory.c
 memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
-memory_region_tb_read(int cpu_index, uint64_t addr, uint64_t value, unsigned size) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
-memory_region_tb_write(int cpu_index, uint64_t addr, uint64_t value, unsigned size) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 flatview_new(void *view, void *root) "%p (root %p)"
-- 
2.17.1



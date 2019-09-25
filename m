Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF75C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 18:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44916222C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 18:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tPHRRPv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44916222C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDCPb-0008NV-1G
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 14:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIe-0001mU-2u
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIc-0004Fu-GV
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:03 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45205)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDCIc-0004Fd-Aw
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:02 -0400
Received: by mail-pl1-x642.google.com with SMTP id u12so2904050pls.12
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RKAV78KOhwa7cM2YUh+Cq3BXcX5AFdgHACRoOW8XrYE=;
 b=tPHRRPv3eAAti8D+Jn2FdazqpxaQ60EJLHJIBqVHuuCicY6JEsHrZKMLxfgQcG7toa
 lybbdUVwxXwAYsMc7yj9r4rIad9hOiyd9M0oR9yi0feXsNUKy+6s68yweLsAKfhTa0Hg
 4UYivvZzHoyKOw1UDCg6FwwGKkCqBGhFUUD4K0fwRh7ir1p4MOa2HM38dYYpwCQVzFeL
 JTz1CjHGEspuaVNgJvr7SzrKPKjyCUa+BOjF7UjzKO4MH/XMvVlYUgp8qoYKqAZp2PEJ
 GeHVnlHMEdTWvPdoSvzICE6mT3cwdXgXRcRrZsq+Fuls6I3pQO0jFc/0bTa/4wd/c1Jc
 2Kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RKAV78KOhwa7cM2YUh+Cq3BXcX5AFdgHACRoOW8XrYE=;
 b=lufWKTyGJqjWa+0dEeq8/bFfbxZxdCylI/tt/H1B780348rkI/zxrZefZiaJvWpEsv
 1NiUb2wORFHWhMS0zmOil4yKRGwbhOB8A9kUEPJgZ22fH71x52iaacXSt+82ESe+aSSi
 PeyC1Q+KbqM5nq4q3XAWfyx236EBU34+1/gbnZRn4RSDem5FB1LpHLTK60O0WZvJ2DQP
 HDrgdjOubhQafrlK0pJI8wQz/ixqToU11UVds4pGBPRphVivSSslpsk6JMz+340lsRs5
 GzOwrUhAkbQyk9cuPBThCOSUi/Ci6UlSpMM9bziqXZF4cdPwgx+nnZAuwBpau8yLpOyo
 s8ZQ==
X-Gm-Message-State: APjAAAVIGuH5ZKWEzi0qn8KBhNJx+mtEJ6sVeSBQA40sZ8eNWsw5FQ0K
 HmouFH2fU7l4ay5oq6RPiOrJrmbb3Dk=
X-Google-Smtp-Source: APXvYqydEtKyBo7XaPlCv3AfdmbbEPT7PuIm0h7KnqvVlqL/7TKN2MPQXDxoyDA8IYPE0EFVOI5ouA==
X-Received: by 2002:a17:902:850b:: with SMTP id
 bj11mr10890877plb.39.1569437160735; 
 Wed, 25 Sep 2019 11:46:00 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id l24sm6133229pff.151.2019.09.25.11.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 11:45:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/16] exec: Adjust notdirty tracing
Date: Wed, 25 Sep 2019 11:45:39 -0700
Message-Id: <20190925184548.30673-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925184548.30673-1-richard.henderson@linaro.org>
References: <20190925184548.30673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: peter.maydell@linaro.org
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 exec.c       | 3 +++
 memory.c     | 4 ----
 trace-events | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/exec.c b/exec.c
index 8b998974f8..5f2587b621 100644
--- a/exec.c
+++ b/exec.c
@@ -2755,6 +2755,8 @@ void memory_notdirty_write_prepare(NotDirtyInfo *ndi,
     ndi->size = size;
     ndi->pages = NULL;
 
+    trace_memory_notdirty_write_access(mem_vaddr, ram_addr, size);
+
     assert(tcg_enabled());
     if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)) {
         ndi->pages = page_collection_lock(ram_addr, ram_addr + size);
@@ -2779,6 +2781,7 @@ void memory_notdirty_write_complete(NotDirtyInfo *ndi)
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



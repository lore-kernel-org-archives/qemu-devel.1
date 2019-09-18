Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4092C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 05:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC1A21848
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 05:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+wLyu+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC1A21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAScG-0007Pq-Nr
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 01:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iASUM-0002LE-8E
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 01:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iASUK-00072F-9Y
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 01:26:50 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39105)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iASUK-00071G-0O
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 01:26:48 -0400
Received: by mail-pg1-x542.google.com with SMTP id u17so3301379pgi.6
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 22:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ofyFRD9BzLQX+w/pf8Sdqdw8HjQ7Yrs4+r4WgJtUSDw=;
 b=P+wLyu+SuDRFMOpwlWZ3V0rbe8ckD4kt+H5JiZjGy/FL+1T2D5gbX9EIoMy/7R24L9
 oKTFjtKMZRc6L+V2psfC5xYijtBVX9nd0NuOUCHRlOANXzy9fNTrdX7sQGm/hp3DXdqZ
 +CdfRuOaJmkL1dHxXJ8EI36720S31ZepH1cd0muCpOigigv8w7ImeaM4lWevrJG4jfRS
 YdoCh4dNkg3QQbW15DJXT1HnQd2+JS03EOdQqhQDW1puUBN2IYDcuDJ64I4KmGoy6UuH
 uOTTBr7e1j9nvMrAHQi6CvDFERng9S7Xw2aQOrNH+cD0Bui9/o24W+g5UK4OKansxxzL
 skIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ofyFRD9BzLQX+w/pf8Sdqdw8HjQ7Yrs4+r4WgJtUSDw=;
 b=iEz0Ihwme65JMPkaZY4n3yEn0wWn526JVVS81Mh0Hsjtb2nOIGE+Kdmr8B8CQVrJJI
 4BzhKWK2ZX425NJSSh1ERdEI5KqqGrkx0VWc6dsAEOBVMSYxrL5S8gpgv0Hcv02wV+V1
 Zo/9ISBpeouJ5XVZxxDtTkROkCAEIQ54L+SNX0v/3mttRtvU28RTn0OSKMoJxdo9U8y1
 02e0QsiWjLfjsKi7GeCV2HFZYQhUl7huZNy5waJJKnq13lpDzYIz6nVEJ73uyVYbwv1q
 m1m8YhQEwwoL6E6iSrEai3jdJNdqLvwjw52ujeIDCsT0hXsm8N8jo294yBY/6KRL69La
 c26g==
X-Gm-Message-State: APjAAAWaGjCI2H8qC0RNaqsTghUVI2XhNybTACZgTMhrmutv572BH3Oc
 +NUk7Zgjb1CQ1af2fiviTlVXyCFCqoU=
X-Google-Smtp-Source: APXvYqydj5yWU6CI4S+bctuCp/QqSK2LFmUWEx8gQnwsUq/nW2YdclF5mQ4l0+F3ZpYb9nzgruPLJA==
X-Received: by 2002:a63:34cb:: with SMTP id b194mr2276638pga.446.1568784405343; 
 Tue, 17 Sep 2019 22:26:45 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a1sm3457234pgd.74.2019.09.17.22.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 22:26:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 22:26:39 -0700
Message-Id: <20190918052641.21300-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190918052641.21300-1-richard.henderson@linaro.org>
References: <20190918052641.21300-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [RFC 1/3] exec: Adjust notdirty tracing
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The memory_region_tb_read tracepoint is unreachable, since notdirty
is supposed to apply only to reads.  The memory_region_tb_write
tracepoint is mis-named, because notdirty is not only used for TB
invalidation.  It is also used for e.g. VGA RAM updates.

Replace memory_region_tb_write with memory_notdirty_write, and
place it in memory_notdirty_write_prepare where it can catch all
of the instances.  Add memory_notdirty_dirty to log when we no
longer intercept writes to a page.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 exec.c       | 3 +++
 memory.c     | 4 ----
 trace-events | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/exec.c b/exec.c
index 8b998974f8..9babe57615 100644
--- a/exec.c
+++ b/exec.c
@@ -2755,6 +2755,8 @@ void memory_notdirty_write_prepare(NotDirtyInfo *ndi,
     ndi->size = size;
     ndi->pages = NULL;
 
+    trace_memory_notdirty_write(mem_vaddr, ram_addr, size);
+
     assert(tcg_enabled());
     if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)) {
         ndi->pages = page_collection_lock(ram_addr, ram_addr + size);
@@ -2779,6 +2781,7 @@ void memory_notdirty_write_complete(NotDirtyInfo *ndi)
     /* we remove the notdirty callback only if the code has been
        flushed */
     if (!cpu_physical_memory_is_clean(ndi->ram_addr)) {
+        trace_memory_notdirty_dirty(ndi->mem_vaddr);
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
index 823a4ae64e..5c9a1631e7 100644
--- a/trace-events
+++ b/trace-events
@@ -52,14 +52,14 @@ dma_map_wait(void *dbs) "dbs=%p"
 find_ram_offset(uint64_t size, uint64_t offset) "size: 0x%" PRIx64 " @ 0x%" PRIx64
 find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_t next, uint64_t mingap) "trying size: 0x%" PRIx64 " @ 0x%" PRIx64 ", offset: 0x%" PRIx64" next: 0x%" PRIx64 " mingap: 0x%" PRIx64
 ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
+memory_notdirty_write(uint64_t vaddr, uint64_t ram_addr, unsigned size) "0x%" PRIx64 " ram_addr 0x%" PRIx64 " size %u"
+memory_notdirty_dirty(uint64_t vaddr) "0x%" PRIx64
 
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



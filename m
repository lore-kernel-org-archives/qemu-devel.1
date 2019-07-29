Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1F7C76186
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 21:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBFF92070D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 21:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yjg0CBky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFF92070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsDVW-0007n8-4v
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 17:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33662)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hsDUn-0006vg-EK
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hsDUl-0003Kt-OJ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:47:53 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56165)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hsDUl-0003Jd-CS
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:47:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id a15so55172272wmj.5
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 14:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sa/mQp6emtqXRaB8V2BxR9P12B/uQ16VIM5jS+vD+YI=;
 b=Yjg0CBkynRZymphxC1QWn94gZXfQoIj/AcXwHMUdk9gaewNB3zxFG7GyTVeBIm+6dq
 ElTvdMzCoIXfbJLELR5cYXY6eLkHgb44VdcYLdeD9twXYeOIospo9yTIv4+q+CffByhM
 tpQ8Wn4wf8yypxleFZvuMNJRrsvJYaN0KB/ySi4Hy6RpQ8tKOOHANjc230rMG+EnNh6U
 8wpXZ7pMZU52LFuqB1aipTsZxb4/nT4hkL+uSL5rLzPEUd6tpIBdRsLT/3HFlwJYmyVV
 TAsUjtvzWIf/e5d1eifZCxjQe5i0kYZDcoRzKVuN0A5bS5JW0fVnjXa4wZR9iONU8W/o
 iMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=sa/mQp6emtqXRaB8V2BxR9P12B/uQ16VIM5jS+vD+YI=;
 b=oofTXGBoKXcYTh2GsycUgm8b4GTdgkbt1TTR6O5Kb1eYkWB0pHw+pYjxfCNkFnDujp
 WtTahFrye376jEaXIGk9aiFLc2rtPS72Y5P9byjTtRSm23mCluRGLHaS3HwF5bjShZPw
 mZl4QaLokx9uuhB2Jxla8ohr+v6Qou0rscp6se6WJmy1t96ug19lsRdnsEXoT0Rg6FtC
 g2NdfxIz/tRzAWRfuItM0UHhLjD9UfL5tnUcZkrpETFp5uQjfLs1eivAnzryxI3Kyv1d
 KxuQDsZkR2oRwV1dVoUjJUsdI/8n0bZOy/3qUqU/AZg0KuQUBjes3ktZmIAPWWAFfLW4
 y/IA==
X-Gm-Message-State: APjAAAVdbbMggKPCdxe0OOVvGuD5LIgYHMjU25Mw6QzkSocYQFDZ5dAw
 HEopzHTljmQ4vOLqGA2ob3jKKbwr8r8=
X-Google-Smtp-Source: APXvYqwMYpVhzLccr8lCEzPFLb0oRU4u6yuGMLCCY4KnPk7RcJvcW43HHIMrYwwucSFpiBAxk/gnQg==
X-Received: by 2002:a7b:c928:: with SMTP id h8mr65380634wml.93.1564436867965; 
 Mon, 29 Jul 2019 14:47:47 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
 by smtp.gmail.com with ESMTPSA id s3sm62983238wmh.27.2019.07.29.14.47.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 14:47:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 23:47:16 +0200
Message-Id: <20190729214717.6616-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH untested for-4.2] memory: fix race between TCG
 and accesses to dirty bitmap
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
Cc: peter.maydell@linaro.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The race is as follows:

      vCPU thread                  reader thread
      -----------------------      -----------------------
      TLB check -> slow path
        notdirty_mem_write
          write to RAM
          set dirty flag
                                   clear dirty flag
      TLB check -> fast path
                                   read memory
        write to RAM

and the second write is missed by the reader.

Fortunately, in order to fix it, no change is required to the
vCPU thread.  However, the reader thread must delay the read after
the vCPU thread has finished the write.  This can be approximated
conservatively by run_on_cpu, which waits for the end of the current
translation block.

A similar technique is used by KVM, which has to do a synchronous TLB
flush after doing a test-and-clear of the dirty-page flags.

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        I tested this some time ago, and enough has changed that I don't
        really trust those old results.  Nevertheless, I am throwing out
        the patch so that it is not forgotten.

 exec.c                | 31 +++++++++++++++++++++++++++++++
 include/exec/memory.h | 12 ++++++++++++
 memory.c              | 10 +++++++++-
 migration/ram.c       |  1 +
 4 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 3e78de3b8f..ae68f72da4 100644
--- a/exec.c
+++ b/exec.c
@@ -198,6 +198,7 @@ typedef struct subpage_t {
 
 static void io_mem_init(void);
 static void memory_map_init(void);
+static void tcg_log_global_after_sync(MemoryListener *listener);
 static void tcg_commit(MemoryListener *listener);
 
 static MemoryRegion io_mem_watch;
@@ -906,6 +907,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
     newas->cpu = cpu;
     newas->as = as;
     if (tcg_enabled()) {
+        newas->tcg_as_listener.log_global_after_sync = tcg_log_global_after_sync;
         newas->tcg_as_listener.commit = tcg_commit;
         memory_listener_register(&newas->tcg_as_listener, as);
     }
@@ -3143,6 +3145,35 @@ void address_space_dispatch_free(AddressSpaceDispatch *d)
     g_free(d);
 }
 
+static void do_nothing(CPUState *cpu, run_on_cpu_data d)
+{
+}
+
+static void tcg_log_global_after_sync(MemoryListener *listener)
+{
+    CPUAddressSpace *cpuas;
+
+    /* Wait for the CPU to end the current TB.  This avoids the following
+     * incorrect race:
+     *
+     *      vCPU                         migration
+     *      ----------------------       -------------------------
+     *      TLB check -> slow path
+     *        notdirty_mem_write
+     *          write to RAM
+     *          mark dirty
+     *                                   clear dirty flag
+     *      TLB check -> fast path
+     *                                   read memory
+     *        write to RAM
+     *
+     * by pushing the migration thread's memory read after the vCPU thread has
+     * written the memory.
+     */
+    cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
+    run_on_cpu(cpuas->cpu, do_nothing, RUN_ON_CPU_NULL);
+}
+
 static void tcg_commit(MemoryListener *listener)
 {
     CPUAddressSpace *cpuas;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index bb0961ddb9..b6bcf31b0a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -419,6 +419,7 @@ struct MemoryListener {
     void (*log_clear)(MemoryListener *listener, MemoryRegionSection *section);
     void (*log_global_start)(MemoryListener *listener);
     void (*log_global_stop)(MemoryListener *listener);
+    void (*log_global_after_sync)(MemoryListener *listener);
     void (*eventfd_add)(MemoryListener *listener, MemoryRegionSection *section,
                         bool match_data, uint64_t data, EventNotifier *e);
     void (*eventfd_del)(MemoryListener *listener, MemoryRegionSection *section,
@@ -1681,6 +1682,17 @@ MemoryRegionSection memory_region_find(MemoryRegion *mr,
  */
 void memory_global_dirty_log_sync(void);
 
+/**
+ * memory_global_dirty_log_sync: synchronize the dirty log for all memory
+ *
+ * Synchronizes the vCPUs with a thread that is reading the dirty bitmap.
+ * This function must be called after the dirty log bitmap is cleared, and
+ * before dirty guest memory pages are read.  If you are using
+ * #DirtyBitmapSnapshot, memory_region_snapshot_and_clear_dirty() takes
+ * care of doing this.
+ */
+void memory_global_after_dirty_log_sync(void);
+
 /**
  * memory_region_transaction_begin: Start a transaction.
  *
diff --git a/memory.c b/memory.c
index e42d63a3a0..edd0c13c38 100644
--- a/memory.c
+++ b/memory.c
@@ -2127,9 +2127,12 @@ DirtyBitmapSnapshot *memory_region_snapshot_and_clear_dirty(MemoryRegion *mr,
                                                             hwaddr size,
                                                             unsigned client)
 {
+    DirtyBitmapSnapshot *snapshot;
     assert(mr->ram_block);
     memory_region_sync_dirty_bitmap(mr);
-    return cpu_physical_memory_snapshot_and_clear_dirty(mr, addr, size, client);
+    snapshot = cpu_physical_memory_snapshot_and_clear_dirty(mr, addr, size, client);
+    memory_global_after_dirty_log_sync();
+    return snapshot;
 }
 
 bool memory_region_snapshot_get_dirty(MemoryRegion *mr, DirtyBitmapSnapshot *snap,
@@ -2620,6 +2623,11 @@ void memory_global_dirty_log_sync(void)
     memory_region_sync_dirty_bitmap(NULL);
 }
 
+void memory_global_after_dirty_log_sync(void)
+{
+    MEMORY_LISTENER_CALL_GLOBAL(log_global_after_sync, Forward);
+}
+
 static VMChangeStateEntry *vmstate_change;
 
 void memory_global_dirty_log_start(void)
diff --git a/migration/ram.c b/migration/ram.c
index 2b0774c2bf..b9d6a3921d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1801,6 +1801,7 @@ static void migration_bitmap_sync(RAMState *rs)
     rcu_read_unlock();
     qemu_mutex_unlock(&rs->bitmap_mutex);
 
+    memory_global_after_dirty_log_sync();
     trace_migration_bitmap_sync_end(rs->num_dirty_pages_period);
 
     end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-- 
2.21.0



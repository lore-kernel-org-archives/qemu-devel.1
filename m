Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B34C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F7C206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SN2MujVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F7C206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrF0-00011o-Ej
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDr8g-0000NP-6E
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:27:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35182
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDr8d-0000EC-1C
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599146817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7qNwKw3bP7jnzU4s7QDMSOC0XIYxDM97KbjcVzP6q/Q=;
 b=SN2MujVRtJN3cNRkGDkwHWkisHVriywgRPhcQFS4S1A9q6B5hb09bmqRAfphJycqwVNEm3
 I07/yE0HcU5+oITTN+xX+nnd7Cz8NXbaz6k6b+B9y9mNHmi3k1nTobDPLFIlz1cFu+m88C
 JRdBTU9/7kpIPWkQeebW1lJ0e3NVsa0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-Uiy9quutPPGFeVfTglBkqA-1; Thu, 03 Sep 2020 11:26:56 -0400
X-MC-Unique: Uiy9quutPPGFeVfTglBkqA-1
Received: by mail-qk1-f197.google.com with SMTP id s141so1770471qka.13
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 08:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7qNwKw3bP7jnzU4s7QDMSOC0XIYxDM97KbjcVzP6q/Q=;
 b=hTJ2XpT10WUATPQ0oKfF09jQCILA8imacj1e+xHwP6QsZHOgz+xM+lvbbZVRlU9yiw
 ARlv9lIPuz+Y+R081GAGBm9cZvLzZBO2pQ6TezdX9sq5gZ0uxpxrDXixszcG3vfBtsPL
 bj60R8ai4WBJ85CXR1DiVs226Iz3ZlR1y9iNTaellRjkl3VLMu5bZawYGW78T62PXdmd
 aFEu1SdKmokiSRlvnyAngD165MbNMfoQFHP2LbIfP8nJpYtdnQMA/Ob79bAR2a/EbRh/
 cDc+hFu5ECWnTuukmu69NCF47WLmuVXgvwg99XRigmJvFNyl0hG32l6VcH0Qpu3/fhFO
 DHVg==
X-Gm-Message-State: AOAM531uOzXgbFLz0HnbqvD7YBiti2r556lnq+8e7+Q22/hbQPH00zn+
 oU5f+gyA41c4S0WZj9HuvpeElHUoS4KcYoejXS3R0QGPtxjxLvhGDEMDlQDIomwDR/8yGtS3Y7i
 sG5JaoANvyokqTaQ=
X-Received: by 2002:a0c:e8c9:: with SMTP id m9mr3544002qvo.51.1599146815462;
 Thu, 03 Sep 2020 08:26:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWbXH6HXo7H+gxm2bIni2HTO1WNh0nnxCO+55B6eeyoEQx3e4CsvMaXYz4hM329OdRchSDjQ==
X-Received: by 2002:a0c:e8c9:: with SMTP id m9mr3543969qvo.51.1599146815114;
 Thu, 03 Sep 2020 08:26:55 -0700 (PDT)
Received: from xz-x1.redhat.com
 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id l38sm2319889qtl.58.2020.09.03.08.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 08:26:53 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] migration: Maintain postcopy faulted addresses
Date: Thu,  3 Sep 2020 11:26:45 -0400
Message-Id: <20200903152646.93336-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903152646.93336-1-peterx@redhat.com>
References: <20200903152646.93336-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Xiaohui Li <xiaohli@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maintain a list of faulted addresses on the destination host for which we're
waiting on.  This is implemented using a GTree rather than a real list to make
sure even there're plenty of vCPUs/threads that are faulting, the lookup will
still be fast with O(log(N)) (because we'll do that after placing each page).
It should bring a slight overhead, but ideally that shouldn't be a big problem
simply because in most cases the requested page list will be short.

Actually we did similar things for postcopy blocktime measurements.  This patch
didn't use that simply because:

  (1) blocktime measurement is towards vcpu threads only, but here we need to
      record all faulted addresses, including main thread and external
      thread (like, DPDK via vhost-user).

  (2) blocktime measurement will require UFFD_FEATURE_THREAD_ID, but here we
      don't want to add that extra dependency on the kernel version since not
      necessary.  E.g., we don't need to know which thread faulted on which
      page, we also don't care about multiple threads faulting on the same
      page.  But we only care about what addresses are faulted so waiting for a
      page copying from src.

  (3) blocktime measurement is not enabled by default.  However we need this by
      default especially for postcopy recover.

Another thing to mention is that this patch introduced a new mutex to serialize
the receivedmap and the page_requested tree, however that serialization does
not cover other procedures like UFFDIO_COPY.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c    | 41 +++++++++++++++++++++++++++++++++++++++-
 migration/migration.h    | 19 ++++++++++++++++++-
 migration/postcopy-ram.c | 18 +++++++++++++++---
 migration/trace-events   |  2 ++
 4 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 6b43ffddbd..e943d96c1b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -143,6 +143,13 @@ static int migration_maybe_pause(MigrationState *s,
                                  int new_state);
 static void migrate_fd_cancel(MigrationState *s);
 
+static gint page_request_addr_cmp(gconstpointer ap, gconstpointer bp)
+{
+    uint64_t a = (uint64_t) ap, b = (uint64_t) bp;
+
+    return (a > b) - (a < b);
+}
+
 void migration_object_init(void)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -165,6 +172,8 @@ void migration_object_init(void)
     qemu_event_init(&current_incoming->main_thread_load_event, false);
     qemu_sem_init(&current_incoming->postcopy_pause_sem_dst, 0);
     qemu_sem_init(&current_incoming->postcopy_pause_sem_fault, 0);
+    qemu_mutex_init(&current_incoming->page_request_mutex);
+    current_incoming->page_requested = g_tree_new(page_request_addr_cmp);
 
     if (!migration_object_check(current_migration, &err)) {
         error_report_err(err);
@@ -238,6 +247,11 @@ void migration_incoming_state_destroy(void)
         mis->postcopy_remote_fds = NULL;
     }
 
+    if (mis->page_requested) {
+        g_tree_destroy(mis->page_requested);
+        mis->page_requested = NULL;
+    }
+
     qemu_event_reset(&mis->main_thread_load_event);
 
     if (mis->socket_address_list) {
@@ -354,8 +368,33 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
 }
 
 int migrate_send_rp_req_pages(MigrationIncomingState *mis,
-                              RAMBlock *rb, ram_addr_t start)
+                              RAMBlock *rb, ram_addr_t start, uint64_t haddr)
 {
+    uint64_t aligned = haddr & (-qemu_target_page_size());
+    bool received;
+
+    qemu_mutex_lock(&mis->page_request_mutex);
+    received = ramblock_recv_bitmap_test_byte_offset(rb, start);
+    if (!received && !g_tree_lookup(mis->page_requested, (gpointer) aligned)) {
+        /*
+         * The page has not been received, and it's not yet in the page request
+         * list.  Queue it.  Set the value of element to 1, so that things like
+         * g_tree_lookup() will return TRUE (1) when found.
+         */
+        g_tree_insert(mis->page_requested, (gpointer) aligned, (gpointer) 1);
+        mis->page_requested_count++;
+        trace_postcopy_page_req_add(aligned, mis->page_requested_count);
+    }
+    qemu_mutex_unlock(&mis->page_request_mutex);
+
+    /*
+     * If the page is there, skip sending the message.  We don't even need the
+     * lock because as long as the page arrived, it'll be there forever.
+     */
+    if (received) {
+        return 0;
+    }
+
     return migrate_send_rp_message_req_pages(mis, rb, start);
 }
 
diff --git a/migration/migration.h b/migration/migration.h
index f552725305..81311dc154 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -103,6 +103,23 @@ struct MigrationIncomingState {
 
     /* List of listening socket addresses  */
     SocketAddressList *socket_address_list;
+
+    /* A tree of pages that we requested to the source VM */
+    GTree *page_requested;
+    /* For debugging purpose only, but would be nice to keep */
+    int page_requested_count;
+    /*
+     * The mutex helps to maintain the requested pages that we sent to the
+     * source, IOW, to guarantee coherent between the page_requests tree and
+     * the per-ramblock receivedmap.  Note! This does not guarantee consistency
+     * of the real page copy procedures (using UFFDIO_[ZERO]COPY).  E.g., even
+     * if one bit in receivedmap is cleared, UFFDIO_COPY could have happened
+     * for that page already.  This is intended so that the mutex won't
+     * serialize and blocked by slow operations like UFFDIO_* ioctls.  However
+     * this should be enough to make sure the page_requested tree always
+     * contains valid information.
+     */
+    QemuMutex page_request_mutex;
 };
 
 MigrationIncomingState *migration_incoming_get_current(void);
@@ -329,7 +346,7 @@ void migrate_send_rp_shut(MigrationIncomingState *mis,
 void migrate_send_rp_pong(MigrationIncomingState *mis,
                           uint32_t value);
 int migrate_send_rp_req_pages(MigrationIncomingState *mis, RAMBlock *rb,
-                              ram_addr_t start);
+                              ram_addr_t start, uint64_t haddr);
 int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
                                       RAMBlock *rb, ram_addr_t start);
 void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index d333c3fd0e..a30627e838 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -684,7 +684,7 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
                                         qemu_ram_get_idstr(rb), rb_offset);
         return postcopy_wake_shared(pcfd, client_addr, rb);
     }
-    migrate_send_rp_req_pages(mis, rb, aligned_rbo);
+    migrate_send_rp_req_pages(mis, rb, aligned_rbo, client_addr);
     return 0;
 }
 
@@ -979,7 +979,8 @@ retry:
              * Send the request to the source - we want to request one
              * of our host page sizes (which is >= TPS)
              */
-            ret = migrate_send_rp_req_pages(mis, rb, rb_offset);
+            ret = migrate_send_rp_req_pages(mis, rb, rb_offset,
+                                            msg.arg.pagefault.address);
             if (ret) {
                 /* May be network failure, try to wait for recovery */
                 if (ret == -EIO && postcopy_pause_fault_thread(mis)) {
@@ -1149,10 +1150,21 @@ static int qemu_ufd_copy_ioctl(MigrationIncomingState *mis, void *host_addr,
         ret = ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
     }
     if (!ret) {
+        qemu_mutex_lock(&mis->page_request_mutex);
         ramblock_recv_bitmap_set_range(rb, host_addr,
                                        pagesize / qemu_target_page_size());
+        /*
+         * If this page resolves a page fault for a previous recorded faulted
+         * address, take a special note to maintain the requested page list.
+         */
+        if (g_tree_lookup(mis->page_requested, (gconstpointer)host_addr)) {
+            g_tree_remove(mis->page_requested, (gconstpointer)host_addr);
+            mis->page_requested_count--;
+            trace_postcopy_page_req_del((uint64_t)host_addr,
+                                        mis->page_requested_count);
+        }
+        qemu_mutex_unlock(&mis->page_request_mutex);
         mark_postcopy_blocktime_end((uintptr_t)host_addr);
-
     }
     return ret;
 }
diff --git a/migration/trace-events b/migration/trace-events
index 4ab0a503d2..b89ce02cb0 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -157,6 +157,7 @@ postcopy_pause_return_path(void) ""
 postcopy_pause_return_path_continued(void) ""
 postcopy_pause_continued(void) ""
 postcopy_start_set_run(void) ""
+postcopy_page_req_add(uint64_t addr, int count) "new page req 0x%lx total %d"
 source_return_path_thread_bad_end(void) ""
 source_return_path_thread_end(void) ""
 source_return_path_thread_entry(void) ""
@@ -267,6 +268,7 @@ postcopy_ram_incoming_cleanup_blocktime(uint64_t total) "total blocktime %" PRIu
 postcopy_request_shared_page(const char *sharer, const char *rb, uint64_t rb_offset) "for %s in %s offset 0x%"PRIx64
 postcopy_request_shared_page_present(const char *sharer, const char *rb, uint64_t rb_offset) "%s already %s offset 0x%"PRIx64
 postcopy_wake_shared(uint64_t client_addr, const char *rb) "at 0x%"PRIx64" in %s"
+postcopy_page_req_del(uint64_t addr, int count) "resolved page req 0x%lx total %d"
 
 get_mem_fault_cpu_index(int cpu, uint32_t pid) "cpu: %d, pid: %u"
 
-- 
2.26.2



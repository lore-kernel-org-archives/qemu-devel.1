Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43804C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E690206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzsB7784"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E690206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrGW-0002dJ-8n
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDr8h-0000QU-5k
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDr8f-0000Fl-2J
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599146820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SN+zpDe63b9OXABJW135pgj4q08uRgy/TMocpHMnT88=;
 b=DzsB7784ZeG1akKNy10wM27wTNVSB2vHQuiAzU7IfGyPZycl95dK+h3gjjdXfMCagut1Gl
 0QgvqF8bT/8ztcMPledpDVwykO0+87n53S2n1y/JxHz7xUyygDuhbGwAj4HRpGfv5uCc3z
 T6NQPVFnfRCQFYsL/olg44AR7vU+YmM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-nndpTprDPEWybfrL-1_LBQ-1; Thu, 03 Sep 2020 11:26:58 -0400
X-MC-Unique: nndpTprDPEWybfrL-1_LBQ-1
Received: by mail-qk1-f197.google.com with SMTP id g6so1742683qko.21
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 08:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SN+zpDe63b9OXABJW135pgj4q08uRgy/TMocpHMnT88=;
 b=UzM8aa1dQX1ZYrQNqyi25p0qZUVbGmKYPoES+cLWpBg9NvSfg2CKQPJU29LLj/3MMr
 6zw2facEVAs6PwW4nuoYLq068wCIJsbH5QJ7D4+NdZQUXY6aUho6QrvonEgNOKzhHH2O
 1p7L7NgSXJzqAooK+1p920Xt7AFM0BvqUAxTzr64XIKXQOFsaixWGa35mUUlpfXySe93
 9w3U/PTBHM6COyJ43NB/ldbktj/Zq9KguzAWrVBu3ODQbwhpnayasZ5U0RmzmnvRc8D7
 HOZFg3wEJ/ZJLMI4lC66CzwPSTXvxDnTNEH3gjbrFjpYwTPh5hS4FWJEhRGmPrlOGCjp
 4qsw==
X-Gm-Message-State: AOAM533WrJ8SUrloNUZmTL0cxKsBxvAMY83yG5QlyFVoGp4xH3nWQjh9
 q8JoXOUhIIyBDOvCm9rzXvjR8jmtVqH/GRmtIGPCi93S/PIW8T3Tgt1LDAqHEWMoTUBXexcrpSA
 1BYIHd+wlDYQeMI8=
X-Received: by 2002:a0c:de0f:: with SMTP id t15mr3449302qvk.90.1599146817095; 
 Thu, 03 Sep 2020 08:26:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5VWYzIE3WiP4K3dcvtkqv9LeAY2SZSUaV46AuCecyFjoS83lup39Dwj7+QPW8Xw1mFlzGaA==
X-Received: by 2002:a0c:de0f:: with SMTP id t15mr3449277qvk.90.1599146816767; 
 Thu, 03 Sep 2020 08:26:56 -0700 (PDT)
Received: from xz-x1.redhat.com
 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id l38sm2319889qtl.58.2020.09.03.08.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 08:26:55 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] migration: Sync requested pages after postcopy recovery
Date: Thu,  3 Sep 2020 11:26:46 -0400
Message-Id: <20200903152646.93336-6-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903152646.93336-1-peterx@redhat.com>
References: <20200903152646.93336-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We synchronize the requested pages right after a postcopy recovery happens.
This helps to synchronize the prioritized pages on source so that the faulted
threads can be served faster.

Reported-by: Xiaohui Li <xiaohli@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c     | 56 ++++++++++++++++++++++++++++++++++++++++++
 migration/trace-events |  1 +
 2 files changed, 57 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 304d98ff78..f998dd230d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2011,6 +2011,48 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
     return LOADVM_QUIT;
 }
 
+/* We must be with page_request_mutex held */
+static gboolean postcopy_sync_page_req(gpointer key, gpointer value,
+                                       gpointer data)
+{
+    MigrationIncomingState *mis = data;
+    void *host_addr = (void *) key;
+    ram_addr_t rb_offset;
+    RAMBlock *rb;
+    int ret;
+
+    rb = qemu_ram_block_from_host(host_addr, true, &rb_offset);
+    if (!rb) {
+        /*
+         * This should _never_ happen.  However be nice for a migrating VM to
+         * not crash/assert.  Post an error (note: intended to not use *_once
+         * because we do want to see all the illegal addresses; and this can
+         * never be triggered by the guest so we're safe) and move on next.
+         */
+        error_report("%s: illegal host addr %p", __func__, host_addr);
+        /* Try the next entry */
+        return FALSE;
+    }
+
+    ret = migrate_send_rp_message_req_pages(mis, rb, rb_offset);
+    if (ret) {
+        /* Refer to above comment - just try our best to continue */
+        error_report("%s: send rp message failed for addr %p",
+                     __func__, host_addr);
+    }
+
+    trace_postcopy_page_req_sync((uint64_t)host_addr);
+
+    return FALSE;
+}
+
+static void migrate_send_rp_req_pages_pending(MigrationIncomingState *mis)
+{
+    qemu_mutex_lock(&mis->page_request_mutex);
+    g_tree_foreach(mis->page_requested, postcopy_sync_page_req, mis);
+    qemu_mutex_unlock(&mis->page_request_mutex);
+}
+
 static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
 {
     if (mis->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
@@ -2033,6 +2075,20 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
     /* Tell source that "we are ready" */
     migrate_send_rp_resume_ack(mis, MIGRATION_RESUME_ACK_VALUE);
 
+    /*
+     * After a postcopy recovery, the source should have lost the postcopy
+     * queue, or potentially the requested pages could have been lost during
+     * the network down phase.  Let's re-sync with the source VM by re-sending
+     * all the pending pages that we eagerly need, so these threads won't get
+     * blocked too long due to the recovery.
+     *
+     * Without this procedure, the faulted destination VM threads (waiting for
+     * page requests right before the postcopy is interrupted) can keep hanging
+     * until the pages are sent by the source during the background copying of
+     * pages, or another thread faulted on the same address accidentally.
+     */
+    migrate_send_rp_req_pages_pending(mis);
+
     return 0;
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index b89ce02cb0..54a6dd2761 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -49,6 +49,7 @@ vmstate_save(const char *idstr, const char *vmsd_name) "%s, %s"
 vmstate_load(const char *idstr, const char *vmsd_name) "%s, %s"
 postcopy_pause_incoming(void) ""
 postcopy_pause_incoming_continued(void) ""
+postcopy_page_req_sync(uint64_t host_addr) "sync page req 0x%"PRIx64
 
 # vmstate.c
 vmstate_load_field_error(const char *field, int ret) "field \"%s\" load failed, ret = %d"
-- 
2.26.2



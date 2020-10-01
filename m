Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA30BC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 651D920796
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuJ0EpHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651D920796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO3Tz-0005zH-Cd
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kO3I7-0002W0-0j
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kO3I4-0003gd-CB
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601576811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vTqG44HaVE95INGJpeolUfZAxcngngTH+B8YA3RSi24=;
 b=HuJ0EpHv3JY29nP+wXlADD+QU31WB70SK2YWyySQBp7cmerkL+klqpNUYqa/xSJyhPOr4y
 y7O5rDZ5oIllQaeXIbqffEc1Z2q25rYbScED2Ea3q1UD5p8glj1PpDIfJ3lBfCsN3EYoTU
 t3YGKwFb0JHPM0wQutFQC9IHYdXfbws=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-fR67MO-cPbedlvzMkhtPCA-1; Thu, 01 Oct 2020 14:26:49 -0400
X-MC-Unique: fR67MO-cPbedlvzMkhtPCA-1
Received: by mail-qt1-f200.google.com with SMTP id e6so4379359qtg.13
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 11:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vTqG44HaVE95INGJpeolUfZAxcngngTH+B8YA3RSi24=;
 b=tctKN0cslroQ8xfUo6A7/iCVb7cMm+KEUozfuyQeUXkkvPgBg9HpYDI3Ka1+nPsABI
 IjP8T7aI8JD7JfMoY1NU+1LPnA6GMksI2Aug2AtrxRW3361ZucAaUnaSaVbBF7ZbgSNr
 rxft8rtZ3RQ9yyfnet7PBq7b7sl8Y6nc3G5QcnAFa7I/2zGJvUc+08k0e/M82M+5leQl
 Mz+yfZw/cYYa6mG9HmjZe0tSQPINzUaLfIADZq91H7NYtKqqpCAdLXzbuvr5+Y8zV+D4
 ndiETdtMjo/t0arTcmDGMRBB6UII7tgy4En3pxHaeM0dnU4Xyvwr+Txq2zAZiw3oAunW
 6Rfg==
X-Gm-Message-State: AOAM5316FZyZUrA/QpQF0cRZMpdy1sf2Wj0phtm/xwUpuAVbMBk9Cgc0
 4iALRGMitS/u7xDj7SgeQBz29WZ+PEJQm8Ibj9otvTX3IbnuQseGpmK7bwpMvFAgSnotjZGoaHf
 pWKcceRjeFi9AOl0=
X-Received: by 2002:ac8:8c:: with SMTP id c12mr8905001qtg.72.1601576808925;
 Thu, 01 Oct 2020 11:26:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZDtLlQteYplbCpYsyGMZpI0mSLwagzwIGj6zkReI+fQYLffo+9t59vmzt9WfOpSiO06xpqA==
X-Received: by 2002:ac8:8c:: with SMTP id c12mr8904977qtg.72.1601576808633;
 Thu, 01 Oct 2020 11:26:48 -0700 (PDT)
Received: from xz-x1.redhat.com
 (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
 by smtp.gmail.com with ESMTPSA id v56sm7892699qtc.49.2020.10.01.11.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 11:26:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/4] migration: Sync requested pages after postcopy recovery
Date: Thu,  1 Oct 2020 14:26:41 -0400
Message-Id: <20201001182641.80232-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001182641.80232-1-peterx@redhat.com>
References: <20201001182641.80232-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
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
 migration/savevm.c     | 57 ++++++++++++++++++++++++++++++++++++++++++
 migration/trace-events |  1 +
 2 files changed, 58 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 34e4b71052..56a2bfb24c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2011,6 +2011,49 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
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
+        /* Please refer to above comment. */
+        error_report("%s: send rp message failed for addr %p",
+                     __func__, host_addr);
+        return FALSE;
+    }
+
+    trace_postcopy_page_req_sync((uint64_t)(uintptr_t)host_addr);
+
+    return FALSE;
+}
+
+static void migrate_send_rp_req_pages_pending(MigrationIncomingState *mis)
+{
+    WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex) {
+        g_tree_foreach(mis->page_requested, postcopy_sync_page_req, mis);
+    }
+}
+
 static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
 {
     if (mis->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
@@ -2033,6 +2076,20 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
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
index 9187b03725..5d0b0662a8 100644
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



Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772F8C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EED52080A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxE6o32E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EED52080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFkIn-0000jh-7A
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kFkGE-0004GM-LT
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:30:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46404
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kFkGC-0007xH-T3
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599597036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S9JOV0WBlguYwtR4pnvjIPBz9nBbT8zTYpwDfLLypjc=;
 b=VxE6o32E4RO+x4wTwEdtuuYifeeu/pxU2/UON+l3H8X0dB/FBZ4YLwiR4QNmzLIoLBAuwR
 dUVvVy0HALNDo5AAHMtyMqiS9mszt0CbMtkgM6U/l1WOT2nTpA+hlRnQO1GHvUHF2PT5Fc
 kypCh4wwRMlFk4SpvNrE/RG+hODpnrk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-hmrGZniCPS2hMtAF9qziWA-1; Tue, 08 Sep 2020 16:30:34 -0400
X-MC-Unique: hmrGZniCPS2hMtAF9qziWA-1
Received: by mail-qt1-f200.google.com with SMTP id m13so343822qtu.10
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 13:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S9JOV0WBlguYwtR4pnvjIPBz9nBbT8zTYpwDfLLypjc=;
 b=flENrpfQlGAoB088NV28266KTqSDnEeIQ9mC5NLV0rY0iqA5PLkXsQSTSs3alP96rR
 pKYjiNBR4gElbruhVsQMd92gfr0qQa1j05CCWVK7jLdFftVO/tXlQ0oh8M+npYM1/8ew
 6Dz6y0F5k73nJXjV1Q80ZOZhbmjZziSdnCg2Cyn5ueVmw1JXajQoWFI2EwpPC12grPk9
 3sjeF5m7AL7A4QfzI9+99tmglfVBOJlyy/gvdbffvr+mpqSOrxiG+VVcLeSEb0FkKNj0
 7pUNTlCsbFDnhiVaA3Pxx0FWqYgXTh4An+2TecLxKJx0HBZVk46Fzgw0wYj6eWUTF29v
 kZ+Q==
X-Gm-Message-State: AOAM533RMx86vQvGZ3o0a0Pet/rNaJbAIMOQSH0tSaLC7fF0SS2gfvtg
 USbHwDMcJ5V3vOlipggDfGcIY8IkodHN+wrUsyE4yalCFrqYk0CcCWX7BXG0T0c7xgZ4IhTq4d0
 kA5SoWvjiAi/O8l0=
X-Received: by 2002:ac8:2612:: with SMTP id u18mr172217qtu.363.1599597033826; 
 Tue, 08 Sep 2020 13:30:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxI8GBFpKLFYZ4U+8tnTvL2nViOdrM+O8x3xuhDIrC0oimxgf69+zTJdfktOPq+sOtSbZrVIg==
X-Received: by 2002:ac8:2612:: with SMTP id u18mr172188qtu.363.1599597033539; 
 Tue, 08 Sep 2020 13:30:33 -0700 (PDT)
Received: from xz-x1.redhat.com
 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id o28sm595397qtl.62.2020.09.08.13.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 13:30:32 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/6] migration: Sync requested pages after postcopy recovery
Date: Tue,  8 Sep 2020 16:30:22 -0400
Message-Id: <20200908203022.341615-7-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908203022.341615-1-peterx@redhat.com>
References: <20200908203022.341615-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
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

We synchronize the requested pages right after a postcopy recovery happens.
This helps to synchronize the prioritized pages on source so that the faulted
threads can be served faster.

Reported-by: Xiaohui Li <xiaohli@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c     | 57 ++++++++++++++++++++++++++++++++++++++++++
 migration/trace-events |  1 +
 2 files changed, 58 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 304d98ff78..a84ce512b9 100644
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
+    trace_postcopy_page_req_sync((uint64_t)host_addr);
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



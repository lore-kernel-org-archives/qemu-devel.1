Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F117C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD7A2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2xKyXnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD7A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLnW-0004gT-PO
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kVLe5-0003HX-7N
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:27:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39154)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kVLdz-00025l-7x
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603315652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNPjhXFw69k7I1uaRrlnu2Tl3UZw4+OZaB4P9a4opmU=;
 b=S2xKyXnLYn9sr8eyHN8yVDoBZaNYKYOU+UnUWvLzwLEv5NfUAmO0P0Hzv8j1fWG0daEuuD
 x5wAVCf/SwYlnyiYklgb+w3vHzpAN/7wYJVMRZ5MjyqXEyAp3zMvlT4hjznvYzPPtpwFw1
 ibtI+LT/Tf2NXHUgRTi93DqVDiv9Lcw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-TmWsOkTOMPamkTnLXQRIag-1; Wed, 21 Oct 2020 17:27:31 -0400
X-MC-Unique: TmWsOkTOMPamkTnLXQRIag-1
Received: by mail-qk1-f197.google.com with SMTP id g184so2628738qke.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 14:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UNPjhXFw69k7I1uaRrlnu2Tl3UZw4+OZaB4P9a4opmU=;
 b=rru+ycA7zRfZzgVNT62DQZzJiUrG9e49FaxR/KQYpVgtHgHfUlpGUloZzSWJefdYkt
 vjpTt4eTXfQc1B57Wo7YnPjuLrCe5Z8RbZhXUspb1B7fwKLmmG/u1TovRhceDlGL12zk
 lCOVJakLA6pbcr1vLgUgt6PNdHxxEJvZqe5Iv2Yj+eZ5QIf4KBtcSgBTuXlpJdFAlw/6
 Rep2H2dtYpAtRhpSuIZXE+TAjRGjD1S4eCZCkwLHtUwA5PkysukhiTwu468wJs/QCjvQ
 4W8/54AYX6/a+6hZy40pBVoDFY7gc8sFutOak4g9d4Bl7RvuS6KJWSm54QVmvgT7NTG0
 ePfg==
X-Gm-Message-State: AOAM531KcuLo6SZarbv7DKiroY1Z91B+Z1r2iALpEwcAbaLCVa4hePvD
 YEyM0tUPdpQOnv45n4JttDdfHwYlXqpZVM8JKhzJq1VWHMGvMvm4Jogu94Ln5AI1ReSeRWYZyUa
 pD0ry18D8z5VhROs=
X-Received: by 2002:a37:ad1a:: with SMTP id f26mr4978543qkm.1.1603315650500;
 Wed, 21 Oct 2020 14:27:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFpK/QNHMvS2X+Ioo61Sim5J5yjJ0yRZn6wyzj50T4fJzS6/ZYdI3GHNkyHkhD4VxM2xP6xA==
X-Received: by 2002:a37:ad1a:: with SMTP id f26mr4978529qkm.1.1603315650243;
 Wed, 21 Oct 2020 14:27:30 -0700 (PDT)
Received: from xz-x1.redhat.com
 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id p187sm2089145qkf.70.2020.10.21.14.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 14:27:29 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 4/6] migration: Sync requested pages after postcopy recovery
Date: Wed, 21 Oct 2020 17:27:19 -0400
Message-Id: <20201021212721.440373-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021212721.440373-1-peterx@redhat.com>
References: <20201021212721.440373-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Xiaohui Li <xiaohli@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
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
index d2e141f7b1..33acbba1a4 100644
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
+    trace_postcopy_page_req_sync(host_addr);
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
index e4d5eb94ca..0fbfd2da60 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -49,6 +49,7 @@ vmstate_save(const char *idstr, const char *vmsd_name) "%s, %s"
 vmstate_load(const char *idstr, const char *vmsd_name) "%s, %s"
 postcopy_pause_incoming(void) ""
 postcopy_pause_incoming_continued(void) ""
+postcopy_page_req_sync(void *host_addr) "sync page req %p"
 
 # vmstate.c
 vmstate_load_field_error(const char *field, int ret) "field \"%s\" load failed, ret = %d"
-- 
2.26.2



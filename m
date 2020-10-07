Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C25C4727F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:08:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 651E520789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnC0Paut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651E520789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQBzf-000277-6D
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kQBny-0001f0-3u
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:56:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kQBnu-0000K0-Am
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602086193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fqIuVZSLTsHJ7zWi6B3v7Jb9InR1IFs/G1h6Do57lEU=;
 b=dnC0PautI5yNmu8s9gLeLrDIQEcs2PyWrye+ZiUxs7bAqNdZssz9xzV3WRpaQgAB4c+ZQy
 +MFQEuj9hqZ+wkfUQP9y9h7gEa44YpgNvNT64u2UUJvQt/t7pT+aYd3o5LZu36/1/BjZtN
 zz9r3sEgjsRHbGBwS2AueuabcG2wlgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-Htcxs4ZtMCOJwrs_1KHyGg-1; Wed, 07 Oct 2020 11:56:29 -0400
X-MC-Unique: Htcxs4ZtMCOJwrs_1KHyGg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 818BD804018;
 Wed,  7 Oct 2020 15:56:28 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-112-50.ams2.redhat.com
 [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4E2710021AA;
 Wed,  7 Oct 2020 15:56:21 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, zhengchuan@huawei.com,
 stefanha@redhat.com, peterx@redhat.com
Subject: [PULL 08/10] migration: Sync requested pages after postcopy recovery
Date: Wed,  7 Oct 2020 16:55:58 +0100
Message-Id: <20201007155600.337316-9-dgilbert@redhat.com>
In-Reply-To: <20201007155600.337316-1-dgilbert@redhat.com>
References: <20201007155600.337316-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

We synchronize the requested pages right after a postcopy recovery happens.
This helps to synchronize the prioritized pages on source so that the faulted
threads can be served faster.

Reported-by: Xiaohui Li <xiaohli@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20201002175336.30858-5-peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
2.28.0



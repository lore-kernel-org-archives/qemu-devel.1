Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B74C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 20:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3F420870
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 20:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNpsRPTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3F420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZg3n-0003Pl-C4
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 15:04:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kZfxG-0003Ep-6g
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 14:57:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21429)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kZfxA-0002GC-4s
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 14:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604347032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O5iX5qnRsmgE19cr2YJogWeW0JbFHwetHbj13RNNblU=;
 b=CNpsRPTw+ZgoJczyn74n4KF2cQs9brcpPt5KE0nWYd0VEva82CdcChhF2VIxy+YV9CgfsG
 gsrXcapII1oUb0+Me0xGsKfXB+F6iJ3VWdQN1tVOESbB6cnuIDFkThjsiIKkDGloGlOlqJ
 Evc9OHkdwHU4eEaTFj5M4Rw63cNyKME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-XYcvEgmpPXyJpXUaZzy4VQ-1; Mon, 02 Nov 2020 14:57:10 -0500
X-MC-Unique: XYcvEgmpPXyJpXUaZzy4VQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BBAF8030DD;
 Mon,  2 Nov 2020 19:57:09 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-142.ams2.redhat.com
 [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B09D51002C1C;
 Mon,  2 Nov 2020 19:57:07 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, peterx@redhat.com, philmd@redhat.com,
 zhangjiachen.jaycee@bytedance.com, mreitz@redhat.com
Subject: [PULL 01/12] migration: Unify reset of last_rb on destination node
 when recover
Date: Mon,  2 Nov 2020 19:56:46 +0000
Message-Id: <20201102195657.219501-2-dgilbert@redhat.com>
In-Reply-To: <20201102195657.219501-1-dgilbert@redhat.com>
References: <20201102195657.219501-1-dgilbert@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
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
Cc: stefanha@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

When postcopy recover happens, we need to reset last_rb after each return of
postcopy_pause_fault_thread() because that means we just got the postcopy
migration continued.

Unify this reset to the place right before we want to kick the fault thread
again, when we get the command MIG_CMD_POSTCOPY_RESUME from source.

This is actually more than that - because the main thread on destination will
now be able to call migrate_send_rp_req_pages_pending() too, so the fault
thread is not the only user of last_rb now.  Move the reset earlier will allow
the first call to migrate_send_rp_req_pages_pending() to use the reset value
even if called from the main thread.

(NOTE: this is not a real fix to 0c26781c09 mentioned below, however it is just
 a mark that when picking up 0c26781c09 we'd better have this one too; the real
 fix will come later)

Fixes: 0c26781c09 ("migration: Sync requested pages after postcopy recovery")
Tested-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20201102153010.11979-2-peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 2 --
 migration/savevm.c       | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index d3bb3a744b..d99842eb1b 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -903,7 +903,6 @@ static void *postcopy_ram_fault_thread(void *opaque)
              * the channel is rebuilt.
              */
             if (postcopy_pause_fault_thread(mis)) {
-                mis->last_rb = NULL;
                 /* Continue to read the userfaultfd */
             } else {
                 error_report("%s: paused but don't allow to continue",
@@ -985,7 +984,6 @@ retry:
                 /* May be network failure, try to wait for recovery */
                 if (ret == -EIO && postcopy_pause_fault_thread(mis)) {
                     /* We got reconnected somehow, try to continue */
-                    mis->last_rb = NULL;
                     goto retry;
                 } else {
                     /* This is a unavoidable fault */
diff --git a/migration/savevm.c b/migration/savevm.c
index 21ccba9fb3..e8834991ec 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2061,6 +2061,12 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
         return 0;
     }
 
+    /*
+     * Reset the last_rb before we resend any page req to source again, since
+     * the source should have it reset already.
+     */
+    mis->last_rb = NULL;
+
     /*
      * This means source VM is ready to resume the postcopy migration.
      * It's time to switch state and release the fault thread to
-- 
2.28.0



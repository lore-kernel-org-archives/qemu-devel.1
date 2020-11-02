Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8623C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A2F2231B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZS7IrU+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A2F2231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZbnY-0007IS-5c
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 10:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kZbmn-0006KL-9O
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:30:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kZbml-0000Nb-47
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604331017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FP8yVEETL4Ew2/5HHR5lVUYAjkPWDJoQzIdVxQaFQAE=;
 b=ZS7IrU+L9yTnzYZjY/3TaN9H6VxfG6N07O6gy3RZVgTO19tX1XEGIGBh3OSioBJLSEldD/
 70gd4sugu8YNdYuL1HGbA18ZVOQn6PZoTnQgaJq6tGSAR+bsPdqKXvrUOVvgp6e+Wv5+I3
 FI7WmBmmtL2IDdJr35TSb7PoD50Erck=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-ICJh_V8SPiCiue_R7iFQNw-1; Mon, 02 Nov 2020 10:30:16 -0500
X-MC-Unique: ICJh_V8SPiCiue_R7iFQNw-1
Received: by mail-qk1-f200.google.com with SMTP id q18so5609252qke.9
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 07:30:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FP8yVEETL4Ew2/5HHR5lVUYAjkPWDJoQzIdVxQaFQAE=;
 b=E+CPXQhUqL+DSmt0of98z8wGvCdFn+M1J2qXZOTkXJ85B1NZ6EOCxI/hlA7rY5GS42
 SLknXPs3WIZnVs76412Yu9e35YrO1+brlLbFjUpp+Vh78GHFsJxGH2RqWFYi4ItwXiGc
 rdXl+DfmwtIY9KYDJpQ+xUAx3yzc53jW7xvnTQ+WdSju9btH6tfGH4U3gLDdsbhOGUhI
 gImoyX5wG1Ub7xGRP3s/mdydIbsWVzT+Q801NuIjHGpKc44R5aO7PnxEABwAU7YM5qql
 oMB8GKu47QBqcezjHIF2GBT0AaIC0ysvikSAv7GzQiOTr4K9D1G37GMO4/nqwJ0yEqCI
 LxAQ==
X-Gm-Message-State: AOAM533hM6ule8d0KPcUOOiwNFZSOxbZBa50I/L31WWanzp7XC2XYxsK
 AiUWEzkQBdRkTXMbuBtmlAljQrMiQdt44MVsTcMT1PdGoTKzaDuWkPOiGEfxSVIGfqLcYCEN7l4
 pbQodx4RwFizR920=
X-Received: by 2002:ac8:5307:: with SMTP id t7mr14870842qtn.273.1604331015662; 
 Mon, 02 Nov 2020 07:30:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwt/Fj7CuSsx3brlHf+Zin9U7yEl8AXrL23T5451wMY/iE9LjaIYqAfVGXcidsfl9OnR62BHQ==
X-Received: by 2002:ac8:5307:: with SMTP id t7mr14870819qtn.273.1604331015463; 
 Mon, 02 Nov 2020 07:30:15 -0800 (PST)
Received: from xz-x1.redhat.com
 (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
 by smtp.gmail.com with ESMTPSA id z125sm5936184qke.54.2020.11.02.07.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 07:30:14 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] migration: Postpone the kick of the fault thread after
 recover
Date: Mon,  2 Nov 2020 10:30:10 -0500
Message-Id: <20201102153010.11979-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201102153010.11979-1-peterx@redhat.com>
References: <20201102153010.11979-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The new migrate_send_rp_req_pages_pending() call should greatly improve
destination responsiveness because it will resync faulted address after
postcopy recovery.  However it is also the 1st place to initiate the page
request from the main thread.

One thing is overlooked on that migrate_send_rp_message_req_pages() is not
designed to be thread-safe.  So if we wake the fault thread before syncing all
the faulted pages in the main thread, it means they can race.

Postpone the wake up operation after the sync of faulted addresses.

Fixes: 0c26781c09 ("migration: Sync requested pages after postcopy recovery")
Tested-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index e8834991ec..5f937a2762 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2069,12 +2069,9 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
 
     /*
      * This means source VM is ready to resume the postcopy migration.
-     * It's time to switch state and release the fault thread to
-     * continue service page faults.
      */
     migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_RECOVER,
                       MIGRATION_STATUS_POSTCOPY_ACTIVE);
-    qemu_sem_post(&mis->postcopy_pause_sem_fault);
 
     trace_loadvm_postcopy_handle_resume();
 
@@ -2095,6 +2092,14 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
      */
     migrate_send_rp_req_pages_pending(mis);
 
+    /*
+     * It's time to switch state and release the fault thread to continue
+     * service page faults.  Note that this should be explicitly after the
+     * above call to migrate_send_rp_req_pages_pending().  In short:
+     * migrate_send_rp_message_req_pages() is not thread safe, yet.
+     */
+    qemu_sem_post(&mis->postcopy_pause_sem_fault);
+
     return 0;
 }
 
-- 
2.26.2



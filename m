Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AC6C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 01:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66BAF20B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 01:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66BAF20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIN4H-00016J-EM
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 21:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iIN2a-000868-K2
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 21:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iIN2Z-00066Y-Gc
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 21:14:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:16855)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iIN2Z-0005aN-8P
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 21:14:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Oct 2019 18:13:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; d="scan'208";a="197087540"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga003.jf.intel.com with ESMTP; 09 Oct 2019 18:13:45 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: quintela@redhat.com,
	dgilbert@redhat.com,
	peterx@redhat.com
Subject: [PATCH v2 2/2] migration/postcopy: check PostcopyState before setting
 to POSTCOPY_INCOMING_RUNNING
Date: Thu, 10 Oct 2019 09:13:16 +0800
Message-Id: <20191010011316.31363-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010011316.31363-1-richardw.yang@linux.intel.com>
References: <20191010011316.31363-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
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
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, we set PostcopyState blindly to RUNNING, even we found the
previous state is not LISTENING. This will lead to a corner case.

First let's look at the code flow:

qemu_loadvm_state_main()
    ret = loadvm_process_command()
        loadvm_postcopy_handle_run()
            return -1;
    if (ret < 0) {
        if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING)
            ...
    }

>From above snippet, the corner case is loadvm_postcopy_handle_run()
always sets state to RUNNING. And then it checks the previous state. If
the previous state is not LISTENING, it will return -1. But at this
moment, PostcopyState is already been set to RUNNING.

Then ret is checked in qemu_loadvm_state_main(), when it is -1
PostcopyState is checked. Current logic would pause postcopy and retry
if PostcopyState is RUNNING. This is not what we expect, because
postcopy is not active yet.

This patch makes sure state is set to RUNNING only previous state is
LISTENING by checking the state first.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Suggested by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 78c2965ca4..b9f30a7090 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1934,7 +1934,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 /* After all discards we can start running and asking for pages */
 static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
 {
-    PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
+    PostcopyState ps = postcopy_state_get();
 
     trace_loadvm_postcopy_handle_run();
     if (ps != POSTCOPY_INCOMING_LISTENING) {
@@ -1942,6 +1942,7 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
         return -1;
     }
 
+    postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
     mis->bh = qemu_bh_new(loadvm_postcopy_handle_run_bh, mis);
     qemu_bh_schedule(mis->bh);
 
-- 
2.17.1



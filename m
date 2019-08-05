Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DB7C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 05:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1742086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 05:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1742086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huVbv-0000sm-1O
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 01:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48849)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1huVbY-0000SS-Mc
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 01:32:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1huVbX-0001qr-OO
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 01:32:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:51590)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1huVbX-0001q1-GK
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 01:32:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Aug 2019 22:32:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,348,1559545200"; d="scan'208";a="372966663"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga005.fm.intel.com with ESMTP; 04 Aug 2019 22:32:16 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Mon,  5 Aug 2019 13:31:46 +0800
Message-Id: <20190805053146.32326-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
Subject: [Qemu-devel] [PATCH v3] migration/postcopy: use mis->bh instead of
 allocating a QEMUBH
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For migration incoming side, it either quit in precopy or postcopy. It
is safe to use the mis->bh for both instead of allocating a dedicated
QEMUBH for postcopy.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

---
v3: rebase on latest upstream
v2: fix a typo in change log
---
 migration/savevm.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 621b6c0465..9bf9d2e5fe 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1867,16 +1867,10 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     return 0;
 }
 
-
-typedef struct {
-    QEMUBH *bh;
-} HandleRunBhData;
-
 static void loadvm_postcopy_handle_run_bh(void *opaque)
 {
     Error *local_err = NULL;
-    HandleRunBhData *data = opaque;
-    MigrationIncomingState *mis = migration_incoming_get_current();
+    MigrationIncomingState *mis = opaque;
 
     /* TODO we should move all of this lot into postcopy_ram.c or a shared code
      * in migration.c
@@ -1908,15 +1902,13 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
         runstate_set(RUN_STATE_PAUSED);
     }
 
-    qemu_bh_delete(data->bh);
-    g_free(data);
+    qemu_bh_delete(mis->bh);
 }
 
 /* After all discards we can start running and asking for pages */
 static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
 {
     PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
-    HandleRunBhData *data;
 
     trace_loadvm_postcopy_handle_run();
     if (ps != POSTCOPY_INCOMING_LISTENING) {
@@ -1924,9 +1916,8 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
         return -1;
     }
 
-    data = g_new(HandleRunBhData, 1);
-    data->bh = qemu_bh_new(loadvm_postcopy_handle_run_bh, data);
-    qemu_bh_schedule(data->bh);
+    mis->bh = qemu_bh_new(loadvm_postcopy_handle_run_bh, mis);
+    qemu_bh_schedule(mis->bh);
 
     /* We need to finish reading the stream from the package
      * and also stop reading anything more from the stream that loaded the
-- 
2.17.1



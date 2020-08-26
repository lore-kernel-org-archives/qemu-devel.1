Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506B3C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20DC72080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DC72080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAuOu-0006qg-Fm
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 08:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1kAuMe-0003aO-77; Wed, 26 Aug 2020 08:17:16 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:18191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1kAuMb-0004Cj-JJ; Wed, 26 Aug 2020 08:17:15 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 91E08448B6;
 Wed, 26 Aug 2020 14:17:01 +0200 (CEST)
From: Stefan Reiter <s.reiter@proxmox.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/3] blockdev: add sequential mode to *-backup transactions
Date: Wed, 26 Aug 2020 14:13:58 +0200
Message-Id: <20200826121359.15450-3-s.reiter@proxmox.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200826121359.15450-1-s.reiter@proxmox.com>
References: <20200826121359.15450-1-s.reiter@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.186.127.180;
 envelope-from=s.reiter@proxmox.com; helo=proxmox-new.maurer-it.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 08:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: kwolf@redhat.com, w.bumiller@proxmox.com, armbru@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com,
 dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only supported with completion-mode 'grouped', since it relies on a
JobTxn to exist. This means that for now it is only available for
{drive,blockdev}-backup transactions.

Since only one job will be running at a time, bandwidth-limits can be
applied effectively. It can also prevent overloading a host's IO
capabilities in general.

Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
---
 blockdev.c            | 25 ++++++++++++++++++++++---
 qapi/transaction.json |  6 +++++-
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 3848a9c8ab..3691e5e791 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1826,7 +1826,10 @@ static void drive_backup_commit(BlkActionState *common)
     aio_context_acquire(aio_context);
 
     assert(state->job);
-    job_start(&state->job->job);
+
+    if (!common->txn_props->sequential) {
+        job_start(&state->job->job);
+    }
 
     aio_context_release(aio_context);
 }
@@ -1927,7 +1930,9 @@ static void blockdev_backup_commit(BlkActionState *common)
     aio_context_acquire(aio_context);
 
     assert(state->job);
-    job_start(&state->job->job);
+    if (!common->txn_props->sequential) {
+        job_start(&state->job->job);
+    }
 
     aio_context_release(aio_context);
 }
@@ -2303,6 +2308,11 @@ static TransactionProperties *get_transaction_properties(
         props->completion_mode = ACTION_COMPLETION_MODE_INDIVIDUAL;
     }
 
+    if (!props->has_sequential) {
+        props->has_sequential = true;
+        props->sequential = false;
+    }
+
     return props;
 }
 
@@ -2328,7 +2338,11 @@ void qmp_transaction(TransactionActionList *dev_list,
      */
     props = get_transaction_properties(props);
     if (props->completion_mode != ACTION_COMPLETION_MODE_INDIVIDUAL) {
-        block_job_txn = job_txn_new();
+        block_job_txn = props->sequential ? job_txn_new_seq() : job_txn_new();
+    } else if (props->sequential) {
+        error_setg(errp, "Sequential transaction mode is not supported with "
+                         "completion-mode = individual");
+        return;
     }
 
     /* drain all i/o before any operations */
@@ -2367,6 +2381,11 @@ void qmp_transaction(TransactionActionList *dev_list,
         }
     }
 
+    /* jobs in sequential txns don't start themselves on commit */
+    if (block_job_txn && props->sequential) {
+        job_txn_start_seq(block_job_txn);
+    }
+
     /* success */
     goto exit;
 
diff --git a/qapi/transaction.json b/qapi/transaction.json
index 15ddebdbc3..4808383088 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -84,11 +84,15 @@
 #                   Actions will complete or fail as a group.
 #                   See @ActionCompletionMode for details.
 #
+# @sequential: Run the jobs in the transaction one after the other, instead
+#              of all at once. Not supported for completion-mode 'individual'.
+#
 # Since: 2.5
 ##
 { 'struct': 'TransactionProperties',
   'data': {
-       '*completion-mode': 'ActionCompletionMode'
+       '*completion-mode': 'ActionCompletionMode',
+       '*sequential': 'bool'
   }
 }
 
-- 
2.20.1




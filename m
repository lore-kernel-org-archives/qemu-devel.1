Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A910C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BAAE2080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAAE2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAuNo-0004wl-A8
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 08:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1kAuMe-0003aQ-74; Wed, 26 Aug 2020 08:17:16 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:11365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1kAuMb-0004Ck-Nd; Wed, 26 Aug 2020 08:17:15 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7BE28432AA;
 Wed, 26 Aug 2020 14:17:01 +0200 (CEST)
From: Stefan Reiter <s.reiter@proxmox.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/3] job: add sequential transaction support
Date: Wed, 26 Aug 2020 14:13:57 +0200
Message-Id: <20200826121359.15450-2-s.reiter@proxmox.com>
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

Jobs in a sequential transaction should never be started with job_start
manually. job_txn_start_seq and the sequentially called job_start will
take care of it, 'assert'ing in case a job is already running or has
finished.

Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
---
 include/qemu/job.h | 12 ++++++++++++
 job.c              | 24 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/qemu/job.h b/include/qemu/job.h
index 32aabb1c60..f7a6a0926a 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -280,6 +280,18 @@ typedef enum JobCreateFlags {
  */
 JobTxn *job_txn_new(void);
 
+/**
+ * Create a new transaction and set it to sequential mode, i.e. run all jobs
+ * one after the other instead of at the same time.
+ */
+JobTxn *job_txn_new_seq(void);
+
+/**
+ * Helper method to start the first job in a sequential transaction to kick it
+ * off. Other jobs will be run after this one completes.
+ */
+void job_txn_start_seq(JobTxn *txn);
+
 /**
  * Release a reference that was previously acquired with job_txn_add_job or
  * job_txn_new. If it's the last reference to the object, it will be freed.
diff --git a/job.c b/job.c
index 8fecf38960..4df7c1d2ca 100644
--- a/job.c
+++ b/job.c
@@ -72,6 +72,8 @@ struct JobTxn {
 
     /* Reference count */
     int refcnt;
+
+    bool sequential;
 };
 
 /* Right now, this mutex is only needed to synchronize accesses to job->busy
@@ -102,6 +104,25 @@ JobTxn *job_txn_new(void)
     return txn;
 }
 
+JobTxn *job_txn_new_seq(void)
+{
+    JobTxn *txn = job_txn_new();
+    txn->sequential = true;
+    return txn;
+}
+
+void job_txn_start_seq(JobTxn *txn)
+{
+    assert(txn->sequential);
+    assert(!txn->aborting);
+
+    Job *first = QLIST_FIRST(&txn->jobs);
+    assert(first);
+    assert(first->status == JOB_STATUS_CREATED);
+
+    job_start(first);
+}
+
 static void job_txn_ref(JobTxn *txn)
 {
     txn->refcnt++;
@@ -840,6 +861,9 @@ static void job_completed_txn_success(Job *job)
      */
     QLIST_FOREACH(other_job, &txn->jobs, txn_list) {
         if (!job_is_completed(other_job)) {
+            if (txn->sequential) {
+                job_start(other_job);
+            }
             return;
         }
         assert(other_job->ret == 0);
-- 
2.20.1




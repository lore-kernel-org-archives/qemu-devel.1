Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC39EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA8E214F1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA8E214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAvRx-0002kH-At
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 09:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1kAvRO-0002Kt-06; Wed, 26 Aug 2020 09:26:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60870 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1kAvRJ-00059m-An; Wed, 26 Aug 2020 09:26:13 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 67FFFD0FFA45DC9DE000;
 Wed, 26 Aug 2020 21:25:51 +0800 (CST)
Received: from localhost.localdomain (10.175.104.175) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 26 Aug 2020 21:25:45 +0800
From: Peng Liang <liangpeng10@huawei.com>
To: <qemu-block@nongnu.org>, <kwolf@redhat.com>, <jsnow@redhat.com>
Subject: [PATCH] block/mirror: fix core when using iothreads
Date: Wed, 26 Aug 2020 21:19:10 +0800
Message-ID: <20200826131910.1879079-1-liangpeng10@huawei.com>
X-Mailer: git-send-email 2.18.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=liangpeng10@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 09:25:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: Peng Liang <liangpeng10@huawei.com>, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We found an issue when doing block-commit with iothreads, which tries to
dereference a NULL pointer.

<main thread>                      |<IO thread>
                                   |
mirror_start_job                   |
 1. bdrv_ref(mirror_top_bs);       |
    bdrv_drained_begin(bs);        |
    bdrv_append(mirror_top_bs,     |
                bs, &local_err);   |
    bdrv_drained_end(bs);          |
                                   |
 2. s = block_job_create(...);     |
                                   |bdrv_mirror_top_pwritev
                                   | MirrorBDSOpaque *s = bs->opaque;
                                   | bool copy_to_target;
                                   | copy_to_target = s->job->ret >= 0 &&
                                   |     s->job->copy_mode ==
                                   |     MIRROR_COPY_MODE_WRITE_BLOCKING;
                                   | (s->job is not NULL until 3!)
 3. bs_opaque->job = s;            |

Just moving step 2 & 3 before 1 can avoid this.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Peng Liang <liangpeng10@huawei.com>
---
 block/mirror.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index e8e8844afc40..7c872be71149 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1600,6 +1600,16 @@ static BlockJob *mirror_start_job(
     mirror_top_bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED |
                                           BDRV_REQ_NO_FALLBACK;
     bs_opaque = g_new0(MirrorBDSOpaque, 1);
+    /* Make sure that the source is not resized while the job is running */
+    s = block_job_create(job_id, driver, NULL, bs,
+                         BLK_PERM_CONSISTENT_READ,
+                         BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
+                         BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD, speed,
+                         creation_flags, cb, opaque, errp);
+    if (!s) {
+        goto fail;
+    }
+    bs_opaque->job = s;
     mirror_top_bs->opaque = bs_opaque;
 
     /* bdrv_append takes ownership of the mirror_top_bs reference, need to keep
@@ -1612,19 +1622,8 @@ static BlockJob *mirror_start_job(
     if (local_err) {
         bdrv_unref(mirror_top_bs);
         error_propagate(errp, local_err);
-        return NULL;
-    }
-
-    /* Make sure that the source is not resized while the job is running */
-    s = block_job_create(job_id, driver, NULL, mirror_top_bs,
-                         BLK_PERM_CONSISTENT_READ,
-                         BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
-                         BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD, speed,
-                         creation_flags, cb, opaque, errp);
-    if (!s) {
         goto fail;
     }
-    bs_opaque->job = s;
 
     /* The block job now has a reference to this node */
     bdrv_unref(mirror_top_bs);
-- 
2.18.4



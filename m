Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3763AC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FFDA20665
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFDA20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAG8u-0003Vp-C3
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 12:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAG0z-0004YE-BQ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAG0y-000756-9M
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:07:41 -0400
Received: from relay.sw.ru ([185.231.240.75]:53062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAG0t-00072R-7G; Tue, 17 Sep 2019 12:07:35 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAG0q-0003UJ-B3; Tue, 17 Sep 2019 19:07:32 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Tue, 17 Sep 2019 19:07:30 +0300
Message-Id: <20190917160731.10895-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190917160731.10895-1-vsementsov@virtuozzo.com>
References: <20190917160731.10895-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v12 1/2] block/backup: fix max_transfer
 handling for copy_range
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Of course, QEMU_ALIGN_UP is a typo, it should be QEMU_ALIGN_DOWN, as we
are trying to find aligned size which satisfy both source and target.
Also, don't ignore too small max_transfer. In this case seems safer to
disable copy_range.

Fixes: 9ded4a0114968e
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 763f0d7ff6..d8fdbfadfe 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -741,12 +741,16 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     job->cluster_size = cluster_size;
     job->copy_bitmap = copy_bitmap;
     copy_bitmap = NULL;
-    job->use_copy_range = !compress; /* compression isn't supported for it */
     job->copy_range_size = MIN_NON_ZERO(blk_get_max_transfer(job->common.blk),
                                         blk_get_max_transfer(job->target));
-    job->copy_range_size = MAX(job->cluster_size,
-                               QEMU_ALIGN_UP(job->copy_range_size,
-                                             job->cluster_size));
+    job->copy_range_size = QEMU_ALIGN_DOWN(job->copy_range_size,
+                                           job->cluster_size);
+    /*
+     * Compression is not supported for copy_range. Also, we don't want to
+     * handle small max_transfer for copy_range (which currently don't
+     * handle max_transfer at all).
+     */
+    job->use_copy_range = !compress && job->copy_range_size > 0;
 
     /* Required permissions are already taken with target's blk_new() */
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
-- 
2.21.0



Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C56C282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 17:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B5E3222E3
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 17:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5E3222E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59592 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHXfw-00081K-Cy
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 13:51:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHXcs-00067p-WC
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 13:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHXcq-0003xy-K8
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 13:48:38 -0400
Received: from relay.sw.ru ([185.231.240.75]:42184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hHXcq-0003wx-CY; Fri, 19 Apr 2019 13:48:36 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hHXcn-0001Mc-55; Fri, 19 Apr 2019 20:48:33 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri, 19 Apr 2019 20:48:32 +0300
Message-Id: <20190419174832.146377-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190419174832.146377-1-vsementsov@virtuozzo.com>
References: <20190419174832.146377-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 2/2] blockjob: use blk_new_pinned in
 block_job_create
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
	mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190419174832.Jd_SF9BCOFVJxXb8mzpRQ6c6yt-0jnBdCrnLnz8xksg@z>

child_role job already has .stay_at_node=true, so on bdrv_replace_node
operation these child are unchanged. Make block job blk behave in same
manner, to avoid inconsistent intermediate graph states and workarounds
like in mirror.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/mirror.c | 6 +-----
 blockjob.c     | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index ff15cfb197..c2cb6bccff 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -713,12 +713,8 @@ static int mirror_exit_common(Job *job)
                             &error_abort);
     bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_abort);
 
-    /* We just changed the BDS the job BB refers to (with either or both of the
-     * bdrv_replace_node() calls), so switch the BB back so the cleanup does
-     * the right thing. We don't need any permissions any more now. */
-    blk_remove_bs(bjob->blk);
+    /* We don't need any permissions any more now. */
     blk_set_perm(bjob->blk, 0, BLK_PERM_ALL, &error_abort);
-    blk_insert_bs(bjob->blk, mirror_top_bs, &error_abort);
 
     bs_opaque->job = NULL;
 
diff --git a/blockjob.c b/blockjob.c
index 730101d282..47466bdfcf 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -396,7 +396,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
         job_id = bdrv_get_device_name(bs);
     }
 
-    blk = blk_new(perm, shared_perm);
+    blk = blk_new_pinned(perm, shared_perm);
     ret = blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
         blk_unref(blk);
-- 
2.18.0



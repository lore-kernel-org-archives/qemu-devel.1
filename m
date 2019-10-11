Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDC6C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:15:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4010B2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4010B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIr0n-0007bQ-5U
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 05:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIqtM-0005xB-ED
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIqtL-0004Ba-Cv
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:07:20 -0400
Received: from relay.sw.ru ([185.231.240.75]:60318)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIqtH-000477-MU; Fri, 11 Oct 2019 05:07:15 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIqtF-0000XM-0j; Fri, 11 Oct 2019 12:07:13 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 5/5] Revert "mirror: Only mirror granularity-aligned chunks"
Date: Fri, 11 Oct 2019 12:07:11 +0300
Message-Id: <20191011090711.19940-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011090711.19940-1-vsementsov@virtuozzo.com>
References: <20191011090711.19940-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit 9adc1cb49af8d4e54f57980b1eed5c0a4b2dafa6.
    "mirror: Only mirror granularity-aligned chunks"

Since previous commit unaligned chunks are supported by
do_sync_target_write.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 1ed1d79ff8..eecb2d5793 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1488,15 +1488,6 @@ static void bdrv_mirror_top_child_perm(BlockDriverState *bs, BdrvChild *c,
     *nshared = BLK_PERM_ALL;
 }
 
-static void bdrv_mirror_top_refresh_limits(BlockDriverState *bs, Error **errp)
-{
-    MirrorBDSOpaque *s = bs->opaque;
-
-    if (s && s->job && s->job->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING) {
-        bs->bl.request_alignment = s->job->granularity;
-    }
-}
-
 /* Dummy node that provides consistent read to its users without requiring it
  * from its backing file and that allows writes on the backing file chain. */
 static BlockDriver bdrv_mirror_top = {
@@ -1509,7 +1500,6 @@ static BlockDriver bdrv_mirror_top = {
     .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_mirror_top_refresh_filename,
     .bdrv_child_perm            = bdrv_mirror_top_child_perm,
-    .bdrv_refresh_limits        = bdrv_mirror_top_refresh_limits,
 };
 
 static BlockJob *mirror_start_job(
@@ -1657,25 +1647,6 @@ static BlockJob *mirror_start_job(
         s->should_complete = true;
     }
 
-    /*
-     * Must be called before we start tracking writes, but after
-     *
-     *     ((MirrorBlockJob *)
-     *         ((MirrorBDSOpaque *)
-     *             mirror_top_bs->opaque
-     *         )->job
-     *     )->copy_mode
-     *
-     * has the correct value.
-     * (We start tracking writes as of the following
-     * bdrv_create_dirty_bitmap() call.)
-     */
-    bdrv_refresh_limits(mirror_top_bs, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        goto fail;
-    }
-
     s->dirty_bitmap = bdrv_create_dirty_bitmap(bs, granularity, NULL, errp);
     if (!s->dirty_bitmap) {
         goto fail;
-- 
2.21.0



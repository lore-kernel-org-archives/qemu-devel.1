Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC54FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04D7217BA
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="h2uBVrub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04D7217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOHg-0000Ks-Q4
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jrO5q-0003an-1u; Fri, 03 Jul 2020 11:59:14 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:41790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jrO5l-0007SI-7G; Fri, 03 Jul 2020 11:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=4RyZy5V804lVKxA8KqkjTU8F4A+oI5KX0VxrhskdhLk=; 
 b=h2uBVrubAdEJZgYZUE6z6qI8vBd/clRzehGdAmM5Bbj4h/ZF5VSpfKoiUKZ8R1Pxz6hBfgjPCV8m7wQVRdwys1remiInGpEmyHBVIPEKykqKELGuaZR0XkoYzGeKgHyPQHLqp15RfZAZsMIbhXtqa7+XSivf7S+K1vD0vYWoT0kMz5j6xuXBAXADImZPtZgl7djwZ1uSc/b7CwlV5qWINLZYAYuWxrkJK2XLTOX12rP0/JDUYVIhwFb0NuQLEp3dYtqBzLwFgQwsFlZZ8mMtM2aQRc7V1AfBC2dcqpyU5/vzt46Cr0MLC96lz6eiwZ/F2MgTU5IIlsKeqQsMXVi1NA==;
Received: from [81.0.49.0] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jrO5L-0001Qj-Sq; Fri, 03 Jul 2020 17:58:43 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jrO52-0007QQ-C3; Fri, 03 Jul 2020 17:58:24 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 27/34] qcow2: Add subcluster support to
 handle_alloc_space()
Date: Fri,  3 Jul 2020 17:58:13 +0200
Message-Id: <25a3d9ec77648942264f26aba320796acbd4c64b.1593791819.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1593791819.git.berto@igalia.com>
References: <cover.1593791819.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 11:21:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Derek Su <dereksu@qnap.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The bdrv_co_pwrite_zeroes() call here fills complete clusters with
zeroes, but it can happen that some subclusters are not part of the
write request or the copy-on-write. This patch makes sure that only
the affected subclusters are overwritten.

A potential improvement would be to also fill with zeroes the other
subclusters if we can guarantee that we are not overwriting existing
data. However this would waste more disk space, so we should first
evaluate if it's really worth doing.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index a3481cd85b..86258fbc22 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2411,6 +2411,9 @@ static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
 
     for (m = l2meta; m != NULL; m = m->next) {
         int ret;
+        uint64_t start_offset = m->alloc_offset + m->cow_start.offset;
+        unsigned nb_bytes = m->cow_end.offset + m->cow_end.nb_bytes -
+            m->cow_start.offset;
 
         if (!m->cow_start.nb_bytes && !m->cow_end.nb_bytes) {
             continue;
@@ -2425,16 +2428,14 @@ static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
          * efficiently zero out the whole clusters
          */
 
-        ret = qcow2_pre_write_overlap_check(bs, 0, m->alloc_offset,
-                                            m->nb_clusters * s->cluster_size,
+        ret = qcow2_pre_write_overlap_check(bs, 0, start_offset, nb_bytes,
                                             true);
         if (ret < 0) {
             return ret;
         }
 
         BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_SPACE);
-        ret = bdrv_co_pwrite_zeroes(s->data_file, m->alloc_offset,
-                                    m->nb_clusters * s->cluster_size,
+        ret = bdrv_co_pwrite_zeroes(s->data_file, start_offset, nb_bytes,
                                     BDRV_REQ_NO_FALLBACK);
         if (ret < 0) {
             if (ret != -ENOTSUP && ret != -EAGAIN) {
-- 
2.20.1



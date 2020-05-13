Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABA6CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9389C2078C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IzSGFy4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9389C2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpWV-00014S-Q7
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpEJ-0002ys-7D
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:07:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59896
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpEF-0003nh-PW
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589368031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RSCVHesIAaTiEhWL/Y61s3jeZ1G79+8x8m+gdDG6auI=;
 b=IzSGFy4Je3XLAehFl22tM7XP01bELPQxf6YGPVcClC184mppQ5WMdYbSdWDzdFF+scPik1
 QY/xSNI0H/fGQ0KIQk5+HsUV8S8jg8HdQAaX0ckSU8kOZZB1OclG5mA+OinLMiXhV/Rj36
 y8dpjENDi4p2ALk/iKZmMnDEcorZlnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-gaqKOggHP0eSK0QJQHCsyw-1; Wed, 13 May 2020 07:07:09 -0400
X-MC-Unique: gaqKOggHP0eSK0QJQHCsyw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A391A107AD91;
 Wed, 13 May 2020 11:07:08 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 361591010403;
 Wed, 13 May 2020 11:07:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 31/34] block: Drop bdrv_format_default_perms()
Date: Wed, 13 May 2020 13:05:41 +0200
Message-Id: <20200513110544.176672-32-mreitz@redhat.com>
In-Reply-To: <20200513110544.176672-1-mreitz@redhat.com>
References: <20200513110544.176672-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/block_int.h | 11 -----------
 block.c                   | 19 -------------------
 2 files changed, 30 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 6fc5f0d333..e791c40496 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1262,17 +1262,6 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
  */
 int bdrv_child_refresh_perms(BlockDriverState *bs, BdrvChild *c, Error **errp);
 
-/* Default implementation for BlockDriver.bdrv_child_perm() that can be used by
- * (non-raw) image formats: Like above for bs->backing, but for bs->file it
- * requires WRITE | RESIZE for read-write images, always requires
- * CONSISTENT_READ and doesn't share WRITE. */
-void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
-                               const BdrvChildClass *child_class,
-                               BdrvChildRole child_role,
-                               BlockReopenQueue *reopen_queue,
-                               uint64_t perm, uint64_t shared,
-                               uint64_t *nperm, uint64_t *nshared);
-
 bool bdrv_recurse_can_replace(BlockDriverState *bs,
                               BlockDriverState *to_replace);
 
diff --git a/block.c b/block.c
index 54bc1c3b2d..e79fe6e07e 100644
--- a/block.c
+++ b/block.c
@@ -2517,25 +2517,6 @@ static void bdrv_default_perms_for_storage(BlockDriverState *bs, BdrvChild *c,
     *nshared = shared;
 }
 
-void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
-                               const BdrvChildClass *child_class,
-                               BdrvChildRole role,
-                               BlockReopenQueue *reopen_queue,
-                               uint64_t perm, uint64_t shared,
-                               uint64_t *nperm, uint64_t *nshared)
-{
-    if (child_class == &child_of_bds) {
-        bdrv_default_perms(bs, c, child_class, role, reopen_queue,
-                           perm, shared, nperm, nshared);
-        return;
-    }
-
-    assert(child_class == &child_file);
-
-    bdrv_default_perms_for_storage(bs, c, child_class, role, reopen_queue,
-                                   perm, shared, nperm, nshared);
-}
-
 void bdrv_default_perms(BlockDriverState *bs, BdrvChild *c,
                         const BdrvChildClass *child_class, BdrvChildRole role,
                         BlockReopenQueue *reopen_queue,
-- 
2.26.2



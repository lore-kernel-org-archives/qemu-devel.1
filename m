Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38220C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:12:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C5C20657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A771+96h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C5C20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZa8H-0001Gy-Ua
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjX-0003kK-Ik
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26566
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjV-0002Rp-Bl
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LDGsnLDI8IaWcEnFssbldchDVX1hD20WpYF66NiSroU=;
 b=A771+96hoZDg16DDkTR4AofzsAJAKfixCSiAJjcUhtYQ+H2F5qhodGE0yJrBXwqY9d+D4O
 LyIyGAuGPer3lU8jiSzJl0wNKRlb6oJWtrIaYwmBdjDAgp3L/UXbhz7Zp3mukdn1qNEp3+
 j92ZVBFxuWipdWi7nOh5H547eBSfeFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-iBcRM3SeMNmpdgS9vEpcZA-1; Fri, 15 May 2020 08:46:30 -0400
X-MC-Unique: iBcRM3SeMNmpdgS9vEpcZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B194835B40;
 Fri, 15 May 2020 12:46:29 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8068B2E179;
 Fri, 15 May 2020 12:46:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 42/51] block: Make bdrv_filter_default_perms() static
Date: Fri, 15 May 2020 14:45:12 +0200
Message-Id: <20200515124521.335403-43-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200513110544.176672-31-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h | 10 ----------
 block.c                   | 17 +++++++++++------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 0781d43af5..6fc5f0d333 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1262,16 +1262,6 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
  */
 int bdrv_child_refresh_perms(BlockDriverState *bs, BdrvChild *c, Error **errp);
 
-/* Default implementation for BlockDriver.bdrv_child_perm() that can be used by
- * block filters: Forward CONSISTENT_READ, WRITE, WRITE_UNCHANGED and RESIZE to
- * all children */
-void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
-                               const BdrvChildClass *child_class,
-                               BdrvChildRole child_role,
-                               BlockReopenQueue *reopen_queue,
-                               uint64_t perm, uint64_t shared,
-                               uint64_t *nperm, uint64_t *nshared);
-
 /* Default implementation for BlockDriver.bdrv_child_perm() that can be used by
  * (non-raw) image formats: Like above for bs->backing, but for bs->file it
  * requires WRITE | RESIZE for read-write images, always requires
diff --git a/block.c b/block.c
index fb94adcca4..54bc1c3b2d 100644
--- a/block.c
+++ b/block.c
@@ -2382,12 +2382,17 @@ int bdrv_child_refresh_perms(BlockDriverState *bs, BdrvChild *c, Error **errp)
     return bdrv_child_try_set_perm(c, perms, shared, errp);
 }
 
-void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
-                               const BdrvChildClass *child_class,
-                               BdrvChildRole role,
-                               BlockReopenQueue *reopen_queue,
-                               uint64_t perm, uint64_t shared,
-                               uint64_t *nperm, uint64_t *nshared)
+/*
+ * Default implementation for .bdrv_child_perm() for block filters:
+ * Forward CONSISTENT_READ, WRITE, WRITE_UNCHANGED, and RESIZE to the
+ * filtered child.
+ */
+static void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
+                                      const BdrvChildClass *child_class,
+                                      BdrvChildRole role,
+                                      BlockReopenQueue *reopen_queue,
+                                      uint64_t perm, uint64_t shared,
+                                      uint64_t *nperm, uint64_t *nshared)
 {
     *nperm = perm & DEFAULT_PERM_PASSTHROUGH;
     *nshared = (shared & DEFAULT_PERM_PASSTHROUGH) | DEFAULT_PERM_UNCHANGED;
-- 
2.25.4



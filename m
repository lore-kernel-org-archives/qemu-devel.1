Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226B2CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:17:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D38206E5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHe3rj/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D38206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpNx-00035q-T5
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDj-00026E-4W
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20817
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDi-0003Tm-DC
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589367997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yLzC5M9cTE0CCCYwgChhXPorwz3KLz4Dc2cCbM7qYDE=;
 b=UHe3rj/V098OnUfEX/DZ1yqFPBMhUAx1KPvLWEVbg5SGN9hM7WRFO7g1OCPymsgwxf9oWj
 oKhnrJgFvembBXOSHZIjU8/9OgyrNddaihVnUOyV+TbPytE5gKl2bisUbhpb/iSle9EFQT
 4Un2LunLdOrhS3A45lAckTw6RczdPJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-74yB_mysMQS3vL_SdYd0Zw-1; Wed, 13 May 2020 07:06:33 -0400
X-MC-Unique: 74yB_mysMQS3vL_SdYd0Zw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06015107ACCD;
 Wed, 13 May 2020 11:06:33 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F15A2E035;
 Wed, 13 May 2020 11:06:32 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 17/34] block: Pull out bdrv_default_perms_for_storage()
Date: Wed, 13 May 2020 13:05:27 +0200
Message-Id: <20200513110544.176672-18-mreitz@redhat.com>
In-Reply-To: <20200513110544.176672-1-mreitz@redhat.com>
References: <20200513110544.176672-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Right now, bdrv_format_default_perms() is used by format parents
(generally). We want to switch to a model where most parents use a
single BdrvChildClass, which then decides the permissions based on the
child role. To do so, we have to split bdrv_format_default_perms() into
separate functions for each such role.

Note that bdrv_default_perms_for_storage() currently handles all DATA |
METADATA children.  A follow-up patch is going to split it further into
one function for each case.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c | 71 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/block.c b/block.c
index b12222a471..5d17aa1cc3 100644
--- a/block.c
+++ b/block.c
@@ -2506,6 +2506,50 @@ static void bdrv_default_perms_for_cow(BlockDriverState *bs, BdrvChild *c,
     *nshared = shared;
 }
 
+static void bdrv_default_perms_for_storage(BlockDriverState *bs, BdrvChild *c,
+                                           const BdrvChildClass *child_class,
+                                           BdrvChildRole role,
+                                           BlockReopenQueue *reopen_queue,
+                                           uint64_t perm, uint64_t shared,
+                                           uint64_t *nperm, uint64_t *nshared)
+{
+    int flags;
+
+    assert(child_class == &child_file ||
+           (child_class == &child_of_bds &&
+            (role & (BDRV_CHILD_METADATA | BDRV_CHILD_DATA))));
+
+    flags = bdrv_reopen_get_flags(reopen_queue, bs);
+
+    /*
+     * Apart from the modifications below, the same permissions are
+     * forwarded and left alone as for filters
+     */
+    bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
+                              perm, shared, &perm, &shared);
+
+    /* Format drivers may touch metadata even if the guest doesn't write */
+    if (bdrv_is_writable_after_reopen(bs, reopen_queue)) {
+        perm |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
+    }
+
+    /*
+     * bs->file always needs to be consistent because of the metadata. We
+     * can never allow other users to resize or write to it.
+     */
+    if (!(flags & BDRV_O_NO_IO)) {
+        perm |= BLK_PERM_CONSISTENT_READ;
+    }
+    shared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
+
+    if (bs->open_flags & BDRV_O_INACTIVE) {
+        shared |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
+    }
+
+    *nperm = perm;
+    *nshared = shared;
+}
+
 void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                                const BdrvChildClass *child_class,
                                BdrvChildRole role,
@@ -2517,31 +2561,8 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
     assert(child_class == &child_backing || child_class == &child_file);
 
     if (!backing) {
-        int flags = bdrv_reopen_get_flags(reopen_queue, bs);
-
-        /* Apart from the modifications below, the same permissions are
-         * forwarded and left alone as for filters */
-        bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
-                                  perm, shared, &perm, &shared);
-
-        /* Format drivers may touch metadata even if the guest doesn't write */
-        if (bdrv_is_writable_after_reopen(bs, reopen_queue)) {
-            perm |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
-        }
-
-        /* bs->file always needs to be consistent because of the metadata. We
-         * can never allow other users to resize or write to it. */
-        if (!(flags & BDRV_O_NO_IO)) {
-            perm |= BLK_PERM_CONSISTENT_READ;
-        }
-        shared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
-
-        if (bs->open_flags & BDRV_O_INACTIVE) {
-            shared |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
-        }
-
-        *nperm = perm;
-        *nshared = shared;
+        bdrv_default_perms_for_storage(bs, c, child_class, role, reopen_queue,
+                                       perm, shared, nperm, nshared);
     } else {
         bdrv_default_perms_for_cow(bs, c, child_class, role, reopen_queue,
                                    perm, shared, nperm, nshared);
-- 
2.26.2



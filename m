Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0341AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEFA320657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="av07ypym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFA320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZa22-0006B1-Ry
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjH-00033v-0i
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32984
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjE-0002NI-SR
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AuY+Dbh3/ukNTTpzfm0qDSVDwuPn80YJkfSix/LeENg=;
 b=av07ypymPE3DW/6f9p8bFkth1z8wilsOKwZ5719e3h9T4xM6cTWwmhbjy28SBmqGfkcMC9
 wthHI0A5U/29DSQfyWdeovPpEd2qb7F2LTGFlFu8ICmLk14bSS4lmJnGnw9cc+o3HIFotI
 +PWe+pvPrWg52JVQrs6wAJY9FXSGN68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-yL2xoS64OnS4vVgaTaMaNQ-1; Fri, 15 May 2020 08:46:13 -0400
X-MC-Unique: yL2xoS64OnS4vVgaTaMaNQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E13ED107ACF4;
 Fri, 15 May 2020 12:46:12 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E85FF2E024;
 Fri, 15 May 2020 12:46:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 29/51] block: Pull out bdrv_default_perms_for_storage()
Date: Fri, 15 May 2020 14:44:59 +0200
Message-Id: <20200515124521.335403-30-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

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
Message-Id: <20200513110544.176672-18-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.25.4



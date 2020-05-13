Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A292CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7A820753
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHzLeoTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7A820753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpTC-0003iQ-4a
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDe-0001ve-NQ
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25706
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDd-0003Sf-Rj
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589367993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0TBfGXMs/REbgJ6NBQHAuXVoH14f2pqq2B0CShDgMQc=;
 b=GHzLeoTT6pMBDxYKV6m0NpaMNx7MBNqMz3/Y8Jad+Gw8eomzaVPyCL2L5ceEuSVXI0tCbm
 gPE8nlqQuHwrfPCi6AQVxMgyfpRMUcCS13ORjv1OVbtNg8vVHhMrdyMFmIi9vmydS4Tkh7
 SzVDKyz00k2q2w3kQvzA47vWAdTIgPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-Bd5S2hB6OH6m4lBdG8duzQ-1; Wed, 13 May 2020 07:06:31 -0400
X-MC-Unique: Bd5S2hB6OH6m4lBdG8duzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B0F319200C4;
 Wed, 13 May 2020 11:06:30 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0205D62B1E;
 Wed, 13 May 2020 11:06:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 16/34] block: Pull out bdrv_default_perms_for_cow()
Date: Wed, 13 May 2020 13:05:26 +0200
Message-Id: <20200513110544.176672-17-mreitz@redhat.com>
In-Reply-To: <20200513110544.176672-1-mreitz@redhat.com>
References: <20200513110544.176672-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 03:05:18
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

Right now, bdrv_format_default_perms() is used by format parents
(generally). We want to switch to a model where most parents use a
single BdrvChildClass, which then decides the permissions based on the
child role. To do so, we have to split bdrv_format_default_perms() into
separate functions for each such role.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 62 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/block.c b/block.c
index b3e7ae70c7..b12222a471 100644
--- a/block.c
+++ b/block.c
@@ -2468,6 +2468,44 @@ void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
     *nshared = (shared & DEFAULT_PERM_PASSTHROUGH) | DEFAULT_PERM_UNCHANGED;
 }
 
+static void bdrv_default_perms_for_cow(BlockDriverState *bs, BdrvChild *c,
+                                       const BdrvChildClass *child_class,
+                                       BdrvChildRole role,
+                                       BlockReopenQueue *reopen_queue,
+                                       uint64_t perm, uint64_t shared,
+                                       uint64_t *nperm, uint64_t *nshared)
+{
+    assert(child_class == &child_backing ||
+           (child_class == &child_of_bds && (role & BDRV_CHILD_COW)));
+
+    /*
+     * We want consistent read from backing files if the parent needs it.
+     * No other operations are performed on backing files.
+     */
+    perm &= BLK_PERM_CONSISTENT_READ;
+
+    /*
+     * If the parent can deal with changing data, we're okay with a
+     * writable and resizable backing file.
+     * TODO Require !(perm & BLK_PERM_CONSISTENT_READ), too?
+     */
+    if (shared & BLK_PERM_WRITE) {
+        shared = BLK_PERM_WRITE | BLK_PERM_RESIZE;
+    } else {
+        shared = 0;
+    }
+
+    shared |= BLK_PERM_CONSISTENT_READ | BLK_PERM_GRAPH_MOD |
+              BLK_PERM_WRITE_UNCHANGED;
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
@@ -2505,28 +2543,8 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
         *nperm = perm;
         *nshared = shared;
     } else {
-        /* We want consistent read from backing files if the parent needs it.
-         * No other operations are performed on backing files. */
-        perm &= BLK_PERM_CONSISTENT_READ;
-
-        /* If the parent can deal with changing data, we're okay with a
-         * writable and resizable backing file. */
-        /* TODO Require !(perm & BLK_PERM_CONSISTENT_READ), too? */
-        if (shared & BLK_PERM_WRITE) {
-            shared = BLK_PERM_WRITE | BLK_PERM_RESIZE;
-        } else {
-            shared = 0;
-        }
-
-        shared |= BLK_PERM_CONSISTENT_READ | BLK_PERM_GRAPH_MOD |
-                  BLK_PERM_WRITE_UNCHANGED;
-
-        if (bs->open_flags & BDRV_O_INACTIVE) {
-            shared |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
-        }
-
-        *nperm = perm;
-        *nshared = shared;
+        bdrv_default_perms_for_cow(bs, c, child_class, role, reopen_queue,
+                                   perm, shared, nperm, nshared);
     }
 }
 
-- 
2.26.2



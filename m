Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01564C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC7E21D95
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="L7gh9t7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC7E21D95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKMtP-0005En-FY
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kKMqZ-0003g3-I6; Mon, 21 Sep 2020 10:31:15 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:47069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kKMqU-000485-Qd; Mon, 21 Sep 2020 10:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=Tw8Cc9SW+/2F9odwf3t7puTe414oOegZOiua3UDi2nU=; 
 b=L7gh9t7P9WP/9i9d5cnBCEP+oOtHRiXeSr8cdS31cHx8iM6aFGk1JfrogdX6tp9R6rTZAJD0RZ3NMpbwPpuX9QGE7B2mcTXN1YAPXCV1G61tnl4MkP4DicK8/J1wurrROIIPrkL3MJ4YrqfYhLxP6Ge/rCdqYqaZspBYfuB6HPTyCJFP1pMYr4ebIlpzFt6fh4zqlni/4CNCrpy7oskCIntkKyXQ+ZlGlOabp/NWrGtpOybZBnw1E9MRKuRRlOKbRyt5gpJ/GmGGvBwBXuQbghaYFyjtdn3Ume97f9A+j2AIr6/i9ZxSSPFA6G4GlJWZyrxfX/OHOQMj6wWJpzx3Tw==;
Received: from [81.0.34.134] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kKMqQ-0000Wf-9Z; Mon, 21 Sep 2020 16:31:06 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kKMqD-0005yV-3j; Mon, 21 Sep 2020 16:30:53 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/2] qcow2: Report BDRV_BLOCK_ZERO more accurately in
 bdrv_co_block_status()
Date: Mon, 21 Sep 2020 16:30:49 +0200
Message-Id: <e12fc2535199ce30c2674132dd62716bbd6359b3.1600698425.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1600698425.git.berto@igalia.com>
References: <cover.1600698425.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 10:31:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a BlockDriverState supports backing files but has none then any
unallocated area reads back as zeroes.

bdrv_co_block_status() is only reporting this is if want_zero is true,
but this is an inexpensive test and there is no reason not to do it in
all cases.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index a2389bb38c..ef1ea806e8 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2391,17 +2391,17 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
 
     if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
         ret |= BDRV_BLOCK_ALLOCATED;
-    } else if (want_zero && bs->drv->supports_backing) {
+    } else if (bs->drv->supports_backing) {
         BlockDriverState *cow_bs = bdrv_cow_bs(bs);
 
-        if (cow_bs) {
+        if (!cow_bs) {
+            ret |= BDRV_BLOCK_ZERO;
+        } else if (want_zero) {
             int64_t size2 = bdrv_getlength(cow_bs);
 
             if (size2 >= 0 && offset >= size2) {
                 ret |= BDRV_BLOCK_ZERO;
             }
-        } else {
-            ret |= BDRV_BLOCK_ZERO;
         }
     }
 
-- 
2.20.1



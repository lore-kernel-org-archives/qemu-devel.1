Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA7EC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFBD1238E6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iKYCE3v1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBD1238E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5qt-0003X2-0k
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kX5pt-0001vh-PF; Mon, 26 Oct 2020 12:59:09 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:49282)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kX5pr-0005YB-HO; Mon, 26 Oct 2020 12:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=U9wt3R+OsQZtKKQT9SwSzSD2L/6TuHPIm4Guch2dRSo=; 
 b=iKYCE3v1Ry0DovSh+Pasf3H83qmrY/s4awTDJNbMBvAloC54rH/HMuw+rpSCSwT8nfrJpLA5+KbrYgtK19qKnw6hP7QFIm9LN8rNS2PJ8GImlaF/55iQQiJ8WIzJ4WcPPB21oYB93h6HMKO4YHr6McPX8VyapByoFvSRulZJXXHQB/TxtUyZy4jc+IZfzEenT1jgzL3ij3aTNZAsymmDHRdcalObeT6MTdhMWX+UQ4jRPb/arwXH9nE5tqIr9D0pQsPnwY4lNXzawMdzG6dRTycJaI+8yvYSP6uPEl+df+tiiLZXTbO6TxcoFu30tsTnqnoXWJhkywkomlWx/gup/Q==;
Received: from [81.0.38.168] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kX5pU-0006VY-L4; Mon, 26 Oct 2020 17:58:44 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kX5pG-0004Pu-HE; Mon, 26 Oct 2020 17:58:30 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/2] qcow2: Report BDRV_BLOCK_ZERO more accurately in
 bdrv_co_block_status()
Date: Mon, 26 Oct 2020 17:58:26 +0100
Message-Id: <66fa0914a0e2b727ab6d1b63ca773d7cd29a9a9e.1603731354.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1603731354.git.berto@igalia.com>
References: <cover.1603731354.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 12:58:45
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
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index 02528b3823..6fe1b275b6 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2282,17 +2282,17 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
 
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



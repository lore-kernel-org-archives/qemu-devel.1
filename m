Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48CCC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D8020679
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfSY4gR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D8020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTph-0006qU-Tv
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiM-0005f8-1b
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:22:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34988
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiI-0000ny-Mc
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rIrPbyY3/n1D6dbiL+f9UqPH10R3oWNqYHhFDDh5Xn4=;
 b=MfSY4gR1gvjG++xTiyi8rhW85DGFcWz1GHio5zuZ2NwlEKivUAtrGoTLHLrA7hfT2ODFDV
 CRnU9V3LxgbfsuJ4+dKs3V01bWuF6E3SldPj/C2OVO8gxQ0IrWyPw4U4MxO0Mhn9i2ovqJ
 WOz4lm2TIYkHZxjEH1GF2t6JqGDrUxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-UispQZMJMDu3AsywrljdXA-1; Thu, 25 Jun 2020 11:22:48 -0400
X-MC-Unique: UispQZMJMDu3AsywrljdXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C86711800D4A;
 Thu, 25 Jun 2020 15:22:47 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D0B71944D;
 Thu, 25 Jun 2020 15:22:47 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 13/47] block: Use CAFs in block status functions
Date: Thu, 25 Jun 2020 17:21:41 +0200
Message-Id: <20200625152215.941773-14-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the child access functions in the block status inquiry functions as
appropriate.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/block/io.c b/block/io.c
index 385176b331..dc9891d6ce 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2407,11 +2407,12 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
     if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
         ret |= BDRV_BLOCK_ALLOCATED;
     } else if (want_zero) {
+        BlockDriverState *cow_bs = bdrv_cow_bs(bs);
+
         if (bdrv_unallocated_blocks_are_zero(bs)) {
             ret |= BDRV_BLOCK_ZERO;
-        } else if (bs->backing) {
-            BlockDriverState *bs2 = bs->backing->bs;
-            int64_t size2 = bdrv_getlength(bs2);
+        } else if (cow_bs) {
+            int64_t size2 = bdrv_getlength(cow_bs);
 
             if (size2 >= 0 && offset >= size2) {
                 ret |= BDRV_BLOCK_ZERO;
@@ -2477,7 +2478,7 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
     bool first = true;
 
     assert(bs != base);
-    for (p = bs; p != base; p = backing_bs(p)) {
+    for (p = bs; p != base; p = bdrv_filter_or_cow_bs(p)) {
         ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
                                    file);
         if (ret < 0) {
@@ -2551,7 +2552,7 @@ int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
 int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
                       int64_t *pnum, int64_t *map, BlockDriverState **file)
 {
-    return bdrv_block_status_above(bs, backing_bs(bs),
+    return bdrv_block_status_above(bs, bdrv_filter_or_cow_bs(bs),
                                    offset, bytes, pnum, map, file);
 }
 
@@ -2561,9 +2562,9 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
     int ret;
     int64_t dummy;
 
-    ret = bdrv_common_block_status_above(bs, backing_bs(bs), false, offset,
-                                         bytes, pnum ? pnum : &dummy, NULL,
-                                         NULL);
+    ret = bdrv_common_block_status_above(bs, bdrv_filter_or_cow_bs(bs), false,
+                                         offset, bytes, pnum ? pnum : &dummy,
+                                         NULL, NULL);
     if (ret < 0) {
         return ret;
     }
@@ -2626,7 +2627,7 @@ int bdrv_is_allocated_above(BlockDriverState *top,
             break;
         }
 
-        intermediate = backing_bs(intermediate);
+        intermediate = bdrv_filter_or_cow_bs(intermediate);
     }
 
     *pnum = n;
-- 
2.26.2



Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E8AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A29D20836
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAFIxWWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A29D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTtE-0002vo-FN
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTii-0006Fn-Ah
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42194
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTig-0001C4-CA
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v37fGsfrbuTQ9Bcll76bYjO7V2TcbCWlPhGmGpDfgdw=;
 b=ZAFIxWWwKNkpEHdK9qqypKnREtczwkRxG6wqFbov5pH6zDIqwNiLnJozgcRVVh97Oy54vY
 r1XDkp1A7qhFO8HNExwKtROa7yIeC5Z2HLCZpC7C058IZ6M4t7cEDqSqHnoKTNTwffWaym
 FJqd+q0hKFWs/FGSHGomOjDCc/NbDNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-xJW0KKM4MXWFkOG_4mG3Iw-1; Thu, 25 Jun 2020 11:23:13 -0400
X-MC-Unique: xJW0KKM4MXWFkOG_4mG3Iw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2629100960F;
 Thu, 25 Jun 2020 15:23:11 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 994EC79334;
 Thu, 25 Jun 2020 15:23:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 24/47] block: Use CAFs for debug breakpoints
Date: Thu, 25 Jun 2020 17:21:52 +0200
Message-Id: <20200625152215.941773-25-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
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

When looking for a blkdebug node (which implements debug breakpoints),
use bdrv_primary_bs() to iterate through the graph, because that is
where a blkdebug node would be.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/block.c b/block.c
index 7c827fefa0..1c71ecab7c 100644
--- a/block.c
+++ b/block.c
@@ -5562,17 +5562,7 @@ void bdrv_debug_event(BlockDriverState *bs, BlkdebugEvent event)
 static BlockDriverState *bdrv_find_debug_node(BlockDriverState *bs)
 {
     while (bs && bs->drv && !bs->drv->bdrv_debug_breakpoint) {
-        if (bs->file) {
-            bs = bs->file->bs;
-            continue;
-        }
-
-        if (bs->drv->is_filter && bs->backing) {
-            bs = bs->backing->bs;
-            continue;
-        }
-
-        break;
+        bs = bdrv_primary_bs(bs);
     }
 
     if (bs && bs->drv && bs->drv->bdrv_debug_breakpoint) {
@@ -5607,7 +5597,7 @@ int bdrv_debug_remove_breakpoint(BlockDriverState *bs, const char *tag)
 int bdrv_debug_resume(BlockDriverState *bs, const char *tag)
 {
     while (bs && (!bs->drv || !bs->drv->bdrv_debug_resume)) {
-        bs = bs->file ? bs->file->bs : NULL;
+        bs = bdrv_primary_bs(bs);
     }
 
     if (bs && bs->drv && bs->drv->bdrv_debug_resume) {
@@ -5620,7 +5610,7 @@ int bdrv_debug_resume(BlockDriverState *bs, const char *tag)
 bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag)
 {
     while (bs && bs->drv && !bs->drv->bdrv_debug_is_suspended) {
-        bs = bs->file ? bs->file->bs : NULL;
+        bs = bdrv_primary_bs(bs);
     }
 
     if (bs && bs->drv && bs->drv->bdrv_debug_is_suspended) {
-- 
2.26.2



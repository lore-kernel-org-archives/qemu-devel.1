Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA79C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA2320706
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zu323QG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA2320706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joU0k-0007df-Gf
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiQ-0005iI-RT
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20985
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiO-0000tz-1d
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sLtShjaBLZarYjMFYpOtzf8DGl/cdiY036TpaXA36N0=;
 b=Zu323QG28iUGsZ6XUU+OLiKU0tAxjUJdBAPlKsBgwRQbWIkOSl0ZZrYkhYt8ryzBJFZ5Rh
 BmEhlomEzL9DUxwNOjlwYzYDjLiXQnH1ygDpHG6THXZ0j1Azp2Ft0stMUdkakk+bJp/1lP
 npZTxXZulRqZNqCIxAUqh48Yg6zMwro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-bxdB9b8aOE69Ng3v53KQZg-1; Thu, 25 Jun 2020 11:22:55 -0400
X-MC-Unique: bxdB9b8aOE69Ng3v53KQZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 998AA1009456;
 Thu, 25 Jun 2020 15:22:54 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 276E15DD61;
 Thu, 25 Jun 2020 15:22:53 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 16/47] block: Use bdrv_cow_child() in bdrv_co_truncate()
Date: Thu, 25 Jun 2020 17:21:44 +0200
Message-Id: <20200625152215.941773-17-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

The condition modified here is not about potentially filtered children,
but only about COW sources (i.e. traditional backing files).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index dc9891d6ce..097a3861d8 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3308,7 +3308,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
                                   Error **errp)
 {
     BlockDriverState *bs = child->bs;
-    BdrvChild *filtered;
+    BdrvChild *filtered, *backing;
     BlockDriver *drv = bs->drv;
     BdrvTrackedRequest req;
     int64_t old_size, new_bytes;
@@ -3361,6 +3361,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
     }
 
     filtered = bdrv_filter_child(bs);
+    backing = bdrv_cow_child(bs);
 
     /*
      * If the image has a backing file that is large enough that it would
@@ -3372,10 +3373,10 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
      * backing file, taking care of keeping things consistent with that backing
      * file is the user's responsibility.
      */
-    if (new_bytes && bs->backing) {
+    if (new_bytes && backing) {
         int64_t backing_len;
 
-        backing_len = bdrv_getlength(backing_bs(bs));
+        backing_len = bdrv_getlength(backing->bs);
         if (backing_len < 0) {
             ret = backing_len;
             error_setg_errno(errp, -ret, "Could not get backing file size");
-- 
2.26.2



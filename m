Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7208CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A359207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1yBLMjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A359207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTuv-0006Ze-Gf
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiq-0006Hg-92
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27173
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTio-0001EL-2r
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b5StjsjJhsZsnZZzQfDp+9DI9Lw+3xyP1G23UeZlOeE=;
 b=I1yBLMjXiAyVIf1Ur8rigNots4Pn1y9w6HRwWZ9Yb5H61QH7VddAeu2NNofRkZwPMy8nps
 /l28p0MLmybpX7R5z66bi7rkC3N9vG1LNW7DKrnd3ooKbiBar3q4PhBX8fcxDiq9gr4vZy
 jE8XuLXDHMuJJc29A30L1Qq4qvH1af4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-iJ_gJPFAPeWReI4mfxLjig-1; Thu, 25 Jun 2020 11:23:17 -0400
X-MC-Unique: iJ_gJPFAPeWReI4mfxLjig-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B19A80400F;
 Thu, 25 Jun 2020 15:23:16 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1002779310;
 Thu, 25 Jun 2020 15:23:15 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 26/47] block: Improve get_allocated_file_size's default
Date: Thu, 25 Jun 2020 17:21:54 +0200
Message-Id: <20200625152215.941773-27-mreitz@redhat.com>
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

There are two practical problems with bdrv_get_allocated_file_size()'s
default right now:
(1) For drivers with children, we should generally sum all their sizes
    instead of just passing the request through to bs->file.  The latter
    is good for filters, but not so much for format drivers.

(2) Filters need not have bs->file, so we should actually go to the
    filtered child instead of hard-coding bs->file.

And we can make the whole default implementation more idiomatic by using
the three generic functions added by the previous patch.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index fc01ce90b3..a19f243997 100644
--- a/block.c
+++ b/block.c
@@ -4997,10 +4997,21 @@ int64_t bdrv_get_allocated_file_size(BlockDriverState *bs)
     if (drv->bdrv_get_allocated_file_size) {
         return drv->bdrv_get_allocated_file_size(bs);
     }
-    if (bs->file) {
-        return bdrv_get_allocated_file_size(bs->file->bs);
+
+    if (drv->bdrv_file_open) {
+        /*
+         * Protocol drivers default to -ENOTSUP (most of their data is
+         * not stored in any of their children (if they even have any),
+         * so there is no generic way to figure it out).
+         */
+        return bdrv_notsup_allocated_file_size(bs);
+    } else if (drv->is_filter) {
+        /* Filter drivers default to the size of their primary child */
+        return bdrv_primary_allocated_file_size(bs);
+    } else {
+        /* Other drivers default to summing their children's sizes */
+        return bdrv_sum_allocated_file_size(bs);
     }
-    return -ENOTSUP;
 }
 
 /**
-- 
2.26.2



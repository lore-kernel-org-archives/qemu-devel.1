Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6BFC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BCF3206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjz/T1Qe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCF3206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTk4-0007Hu-8F
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joThv-00057L-Vt
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:22:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38715
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTht-0000TA-61
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6b5+AhmJqfcAVLzmBshbRXCmakDyehOcVwSaIyUfs8=;
 b=gjz/T1Qe7VlOkwiqc/iZ3EibbjAlegHqt8u22SSsRjeLMUUZaFD7n1+D/APyeAB+dlXpqX
 FQk9r642tCVzlt/3d2eH9ZxLa5ouqt+SPVr5p/cF55GNydOfmCbnm0PYFcef8oeOYC7+0W
 hK21QMI96/H53597DAMXwTIpVcSsocM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-55exWMUNMyG9mehKiC9jwA-1; Thu, 25 Jun 2020 11:22:22 -0400
X-MC-Unique: 55exWMUNMyG9mehKiC9jwA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF581EC1A2;
 Thu, 25 Jun 2020 15:22:21 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9514F61169;
 Thu, 25 Jun 2020 15:22:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 02/47] block: Add chain helper functions
Date: Thu, 25 Jun 2020 17:21:30 +0200
Message-Id: <20200625152215.941773-3-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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

Add some helper functions for skipping filters in a chain of block
nodes.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |  3 +++
 block.c                   | 55 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index bb3457c5e8..5da793bfc3 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1382,6 +1382,9 @@ BdrvChild *bdrv_cow_child(BlockDriverState *bs);
 BdrvChild *bdrv_filter_child(BlockDriverState *bs);
 BdrvChild *bdrv_filter_or_cow_child(BlockDriverState *bs);
 BdrvChild *bdrv_primary_child(BlockDriverState *bs);
+BlockDriverState *bdrv_skip_implicit_filters(BlockDriverState *bs);
+BlockDriverState *bdrv_skip_filters(BlockDriverState *bs);
+BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs);
 
 static inline BlockDriverState *child_bs(BdrvChild *child)
 {
diff --git a/block.c b/block.c
index 5a42ef49fd..0a0b855261 100644
--- a/block.c
+++ b/block.c
@@ -7008,3 +7008,58 @@ BdrvChild *bdrv_primary_child(BlockDriverState *bs)
 
     return NULL;
 }
+
+static BlockDriverState *bdrv_do_skip_filters(BlockDriverState *bs,
+                                              bool stop_on_explicit_filter)
+{
+    BdrvChild *c;
+
+    if (!bs) {
+        return NULL;
+    }
+
+    while (!(stop_on_explicit_filter && !bs->implicit)) {
+        c = bdrv_filter_child(bs);
+        if (!c) {
+            break;
+        }
+        bs = c->bs;
+    }
+    /*
+     * Note that this treats nodes with bs->drv == NULL as not being
+     * filters (bs->drv == NULL should be replaced by something else
+     * anyway).
+     * The advantage of this behavior is that this function will thus
+     * always return a non-NULL value (given a non-NULL @bs).
+     */
+
+    return bs;
+}
+
+/*
+ * Return the first BDS that has not been added implicitly or that
+ * does not have a filtered child down the chain starting from @bs
+ * (including @bs itself).
+ */
+BlockDriverState *bdrv_skip_implicit_filters(BlockDriverState *bs)
+{
+    return bdrv_do_skip_filters(bs, true);
+}
+
+/*
+ * Return the first BDS that does not have a filtered child down the
+ * chain starting from @bs (including @bs itself).
+ */
+BlockDriverState *bdrv_skip_filters(BlockDriverState *bs)
+{
+    return bdrv_do_skip_filters(bs, false);
+}
+
+/*
+ * For a backing chain, return the first non-filter backing image of
+ * the first non-filter image.
+ */
+BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs)
+{
+    return bdrv_skip_filters(bdrv_cow_bs(bdrv_skip_filters(bs)));
+}
-- 
2.26.2



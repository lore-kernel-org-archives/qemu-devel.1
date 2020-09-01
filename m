Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F284C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A58E2220B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFWlmnaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A58E2220B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7bI-0002Br-BK
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7N3-0007Ts-IV
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7N1-00075h-Gh
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598970886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7jp1/61HrdNgG7sTMjvP0+rN1T+FNJWPv9SFCb3TIA=;
 b=ZFWlmnafpmviT8DIxStLbW+sBDInliH7GKEuQ4JYOrk8Xb08QReVSyH+iRTD+ZHcCGJwqK
 lk/KL/ki0qUbqi857y85Fmth0+/OG1w42xbNPluEeg8UxiCxyofoli+HbA6+pBBWrv0ESW
 D5uRgN29H+6utx0YXnvLDP+bAzKE/ZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-cvCONl6wNH2VLdBwxHuf8w-1; Tue, 01 Sep 2020 10:34:44 -0400
X-MC-Unique: cvCONl6wNH2VLdBwxHuf8w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00D5F1015CA3;
 Tue,  1 Sep 2020 14:34:43 +0000 (UTC)
Received: from localhost (ovpn-113-83.ams2.redhat.com [10.36.113.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54DAB19C78;
 Tue,  1 Sep 2020 14:34:42 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 07/43] block: Add bdrv_supports_compressed_writes()
Date: Tue,  1 Sep 2020 16:33:48 +0200
Message-Id: <20200901143424.884735-8-mreitz@redhat.com>
In-Reply-To: <20200901143424.884735-1-mreitz@redhat.com>
References: <20200901143424.884735-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 01:27:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Filters cannot compress data themselves but they have to implement
.bdrv_co_pwritev_compressed() still (or they cannot forward compressed
writes).  Therefore, checking whether
bs->drv->bdrv_co_pwritev_compressed is non-NULL is not sufficient to
know whether the node can actually handle compressed writes.  This
function looks down the filter chain to see whether there is a
non-filter that can actually convert the compressed writes into
compressed data (and thus normal writes).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  1 +
 block.c               | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index 2c09b93d07..981ab5b314 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -532,6 +532,7 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it);
 void bdrv_next_cleanup(BdrvNextIterator *it);
 
 BlockDriverState *bdrv_next_monitor_owned(BlockDriverState *bs);
+bool bdrv_supports_compressed_writes(BlockDriverState *bs);
 void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
                          void *opaque, bool read_only);
 const char *bdrv_get_node_name(const BlockDriverState *bs);
diff --git a/block.c b/block.c
index f5eabaa032..c09a766f54 100644
--- a/block.c
+++ b/block.c
@@ -5065,6 +5065,29 @@ bool bdrv_is_sg(BlockDriverState *bs)
     return bs->sg;
 }
 
+/**
+ * Return whether the given node supports compressed writes.
+ */
+bool bdrv_supports_compressed_writes(BlockDriverState *bs)
+{
+    BlockDriverState *filtered;
+
+    if (!bs->drv || !block_driver_can_compress(bs->drv)) {
+        return false;
+    }
+
+    filtered = bdrv_filter_bs(bs);
+    if (filtered) {
+        /*
+         * Filters can only forward compressed writes, so we have to
+         * check the child.
+         */
+        return bdrv_supports_compressed_writes(filtered);
+    }
+
+    return true;
+}
+
 const char *bdrv_get_format_name(BlockDriverState *bs)
 {
     return bs->drv ? bs->drv->format_name : NULL;
-- 
2.26.2



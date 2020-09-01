Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9F0C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:48:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DE421D6C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbD6tybp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DE421D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7Zr-0007ae-2H
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7N0-0007KW-3P
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7My-00074W-3F
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598970883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=odSQmb9s9KXco5mMR3GU74UzWu1nPAwwWRBWJODxDl4=;
 b=MbD6tybpTonLHQX/WZ+nBJl2Rm+WdPXEKlVmh3LZwzbOAScUgT3hwoqRJLC2Zhj27VVBLw
 W/zNpcXtgnqFMNuTiagCZFlSa1m7eNUyOjlOACJ9SW4xMro/IK3stSxJdvr9buhH6GtJK5
 lCE0S5Qlj/teS6K0G/ssf3injl+Z30Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-zYkvMtSENJS631O3_cqB2A-1; Tue, 01 Sep 2020 10:34:41 -0400
X-MC-Unique: zYkvMtSENJS631O3_cqB2A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7674218B9F41;
 Tue,  1 Sep 2020 14:34:40 +0000 (UTC)
Received: from localhost (ovpn-113-83.ams2.redhat.com [10.36.113.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1643E78B57;
 Tue,  1 Sep 2020 14:34:39 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 06/43] block: Drop bdrv_is_encrypted()
Date: Tue,  1 Sep 2020 16:33:47 +0200
Message-Id: <20200901143424.884735-7-mreitz@redhat.com>
In-Reply-To: <20200901143424.884735-1-mreitz@redhat.com>
References: <20200901143424.884735-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.002
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

The original purpose of bdrv_is_encrypted() was to inquire whether a BDS
can be used without the user entering a password or not.  It has not
been used for that purpose for quite some time.

Actually, it is not even fit for that purpose, because to answer that
question, it would have recursively query all of the given node's
children.

So now we have to decide in which direction we want to fix
bdrv_is_encrypted(): Recursively query all children, or drop it and just
use bs->encrypted to get the current node's status?

Nowadays, its only purpose is to report through bdrv_query_image_info()
whether the given image is encrypted or not.  For this purpose, it is
probably more interesting to see whether a given node itself is
encrypted or not (otherwise, a management application cannot discern for
certain which nodes are really encrypted and which just have encrypted
children).

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h | 1 -
 block.c               | 8 --------
 block/qapi.c          | 2 +-
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 6e36154061..2c09b93d07 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -532,7 +532,6 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it);
 void bdrv_next_cleanup(BdrvNextIterator *it);
 
 BlockDriverState *bdrv_next_monitor_owned(BlockDriverState *bs);
-bool bdrv_is_encrypted(BlockDriverState *bs);
 void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
                          void *opaque, bool read_only);
 const char *bdrv_get_node_name(const BlockDriverState *bs);
diff --git a/block.c b/block.c
index edef6273b8..f5eabaa032 100644
--- a/block.c
+++ b/block.c
@@ -5065,14 +5065,6 @@ bool bdrv_is_sg(BlockDriverState *bs)
     return bs->sg;
 }
 
-bool bdrv_is_encrypted(BlockDriverState *bs)
-{
-    if (bs->backing && bs->backing->bs->encrypted) {
-        return true;
-    }
-    return bs->encrypted;
-}
-
 const char *bdrv_get_format_name(BlockDriverState *bs)
 {
     return bs->drv ? bs->drv->format_name : NULL;
diff --git a/block/qapi.c b/block/qapi.c
index afd9f3b4a7..4807a2b344 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -288,7 +288,7 @@ void bdrv_query_image_info(BlockDriverState *bs,
     info->virtual_size    = size;
     info->actual_size     = bdrv_get_allocated_file_size(bs);
     info->has_actual_size = info->actual_size >= 0;
-    if (bdrv_is_encrypted(bs)) {
+    if (bs->encrypted) {
         info->encrypted = true;
         info->has_encrypted = true;
     }
-- 
2.26.2



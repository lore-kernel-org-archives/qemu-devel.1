Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E6EC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 10:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A3520663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 10:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="li5LNSTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A3520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifLJn-0003X4-Eo
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 05:03:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1ifLIg-0002R5-HE
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 05:02:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1ifLId-00076i-A0
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 05:02:26 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:56693)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1ifLIc-0006Wp-ME; Thu, 12 Dec 2019 05:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=UMboNIpM9Pc78IbDMq/NwOVDG82ceynpGZAYDEzIBpY=; 
 b=li5LNSTQMvlYVgsphspMuzWuIbNeo6MoQroAume/V2V+pH0T6cYOkMbKIXS1GAAx8Gac2KhTSiZQ3W46bsUt6z0DTQwW9fWfrk7UmDXVOp39bxg+gmCOmH0E/F4ZRWQK+fHIgPaw4ocNtE/QarClfgrV54ESK63l/+yTLytDvC7upSUnDMQBALnQ25oD4jihde9sfUTBfAIjbwzk1U8zbC9X2+/M5awzybRl6/pfl68IYoBNqUoMNoKjnbN4VmD4KLm7hqQ5OlGmvtKpIp/+O7KngaPwf/secLKjqbI0dzVRoeyKvN3DUycz6ne5Qa2qGxGjcVzf46EdoDYeUPa7TQ==;
Received: from 82-181-217-9.bb.dnainternet.fi ([82.181.217.9]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1ifLII-0006iz-Q1; Thu, 12 Dec 2019 11:02:02 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1ifLHq-0007iW-1N; Thu, 12 Dec 2019 12:01:34 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qcow2: Use offset_into_cluster()
Date: Thu, 12 Dec 2019 12:01:21 +0200
Message-Id: <20191212100121.29621-1-berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There's a couple of places left in the qcow2 code that still do the
calculation manually, so let's replace them.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7c18721741..3866b47946 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -367,7 +367,7 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
                 return -EINVAL;
             }
 
-            if (bitmaps_ext.bitmap_directory_offset & (s->cluster_size - 1)) {
+            if (offset_into_cluster(s, bitmaps_ext.bitmap_directory_offset)) {
                 error_setg(errp, "bitmaps_ext: "
                                  "invalid bitmap directory offset");
                 return -EINVAL;
@@ -1958,9 +1958,8 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t cluster_offset;
-    int index_in_cluster, ret;
     unsigned int bytes;
-    int status = 0;
+    int ret, status = 0;
 
     qemu_co_mutex_lock(&s->lock);
 
@@ -1981,8 +1980,7 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
 
     if ((ret == QCOW2_CLUSTER_NORMAL || ret == QCOW2_CLUSTER_ZERO_ALLOC) &&
         !s->crypto) {
-        index_in_cluster = offset & (s->cluster_size - 1);
-        *map = cluster_offset | index_in_cluster;
+        *map = cluster_offset | offset_into_cluster(s, offset);
         *file = s->data_file->bs;
         status |= BDRV_BLOCK_OFFSET_VALID;
     }
-- 
2.20.1



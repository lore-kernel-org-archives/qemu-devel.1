Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEC3C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 13:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7452147A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 13:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="G+Mq3KO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7452147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48609 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQXxF-00072m-Iz
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 09:58:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hQXwS-0006h9-08
	for qemu-devel@nongnu.org; Tue, 14 May 2019 09:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hQXwQ-0002FR-Ag
	for qemu-devel@nongnu.org; Tue, 14 May 2019 09:58:03 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:35945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hQXwP-0002B0-HD; Tue, 14 May 2019 09:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Message-Id:Date:Subject:Cc:To:From;
	bh=HWzv6sRcnzm4U/TLcTdcM9s8PCpd1qPmZTvKIICZcUk=; 
	b=G+Mq3KO2sEarouMxmlDRPS3dpLt2oDm+Ao+srtY9ZkfEDh9JU9zA8VgrZXyZvSRgXyY6agk6JGfT7gxCE/hq6/hY1tMXQe9lOWMowQva2PchPdEuuGV1T86ymmX6YOT8A3RGI5dWjXARdpGFwCxNPcwQQnWTugcH+Yf++X8BEJNnHxueqFCjKZFGB1bEjLP78Zj4vTh6bWAfj+J+zf2Lw6f1a94JuswFG93Tl0bsjJ/39RHy7H3f7Thot5z/CJlphxNufkL3QkHrKdL3Scf6T6RWfr/r+ClxfW0o08XatUERStp7Jkpxv5WWPRwefBnnh4x9TI8PrNR0IQbqHDHvAA==;
Received: from mobile-access-bcee32-86.dhcp.inet.fi ([188.238.50.86]
	helo=perseus.local) by fanzine.igalia.com with esmtpsa 
	(Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
	id 1hQXwN-0002Xc-3z; Tue, 14 May 2019 15:57:59 +0200
Received: from berto by perseus.local with local (Exim 4.89)
	(envelope-from <berto@igalia.com>)
	id 1hQXw9-0003mY-Eu; Tue, 14 May 2019 16:57:45 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 16:57:35 +0300
Message-Id: <20190514135735.14497-1-berto@igalia.com>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH] block: Use BDRV_REQUEST_MAX_BYTES instead of
 BDRV_REQUEST_MAX_SECTORS
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are a few places in which we turn a number of bytes into sectors
in order to compare the result against BDRV_REQUEST_MAX_SECTORS
instead of using BDRV_REQUEST_MAX_BYTES directly.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/io.c     | 6 +++---
 qemu-io-cmds.c | 7 +++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/io.c b/block/io.c
index aeebc9c23c..3134a60a48 100644
--- a/block/io.c
+++ b/block/io.c
@@ -769,7 +769,7 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
 static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
                                    size_t size)
 {
-    if (size > BDRV_REQUEST_MAX_SECTORS << BDRV_SECTOR_BITS) {
+    if (size > BDRV_REQUEST_MAX_BYTES) {
         return -EIO;
     }
 
@@ -1017,7 +1017,7 @@ static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
 
     assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
     assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
-    assert((bytes >> BDRV_SECTOR_BITS) <= BDRV_REQUEST_MAX_SECTORS);
+    assert(bytes <= BDRV_REQUEST_MAX_BYTES);
     assert(drv->bdrv_co_readv);
 
     return drv->bdrv_co_readv(bs, sector_num, nb_sectors, qiov);
@@ -1070,7 +1070,7 @@ static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
 
     assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
     assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
-    assert((bytes >> BDRV_SECTOR_BITS) <= BDRV_REQUEST_MAX_SECTORS);
+    assert(bytes <= BDRV_REQUEST_MAX_BYTES);
 
     assert(drv->bdrv_co_writev);
     ret = drv->bdrv_co_writev(bs, sector_num, nb_sectors, qiov,
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 8826bebaf6..30a7d9a13b 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -538,7 +538,7 @@ static int do_write_compressed(BlockBackend *blk, char *buf, int64_t offset,
 {
     int ret;
 
-    if (bytes >> 9 > BDRV_REQUEST_MAX_SECTORS) {
+    if (bytes > BDRV_REQUEST_MAX_BYTES) {
         return -ERANGE;
     }
 
@@ -1781,10 +1781,9 @@ static int discard_f(BlockBackend *blk, int argc, char **argv)
     if (bytes < 0) {
         print_cvtnum_err(bytes, argv[optind]);
         return bytes;
-    } else if (bytes >> BDRV_SECTOR_BITS > BDRV_REQUEST_MAX_SECTORS) {
+    } else if (bytes > BDRV_REQUEST_MAX_BYTES) {
         printf("length cannot exceed %"PRIu64", given %s\n",
-               (uint64_t)BDRV_REQUEST_MAX_SECTORS << BDRV_SECTOR_BITS,
-               argv[optind]);
+               (uint64_t)BDRV_REQUEST_MAX_BYTES, argv[optind]);
         return -EINVAL;
     }
 
-- 
2.11.0



Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FB3C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085252070B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085252070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2bvW-0002EJ-8s
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 09:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i2bu8-0001H9-Q1
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i2bu5-0006it-RI
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:52:59 -0400
Received: from relay.sw.ru ([185.231.240.75]:56650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i2bu5-0006ge-KZ; Tue, 27 Aug 2019 09:52:57 -0400
Received: from [172.16.25.136] (helo=dhcp-172-16-25-136.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i2bu2-0001p9-I5; Tue, 27 Aug 2019 16:52:54 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue, 27 Aug 2019 16:52:53 +0300
Message-Id: <1566913973-15490-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2] block: workaround for unaligned byte range
 in fallocate()
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 mreitz@redhat.com, stefanha@redhat.com, andrey.shinkevich@virtuozzo.com,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Revert the commit 118f99442d 'block/io.c: fix for the allocation failure'
and use better error handling for file systems that do not support
fallocate() for an unaligned byte range. Allow falling back to pwrite
in case fallocate() returns EINVAL.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/file-posix.c | 7 +++++++
 block/io.c         | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index fbeb006..b00259f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1588,6 +1588,13 @@ static int handle_aiocb_write_zeroes(void *opaque)
     if (s->has_write_zeroes) {
         int ret = do_fallocate(s->fd, FALLOC_FL_ZERO_RANGE,
                                aiocb->aio_offset, aiocb->aio_nbytes);
+        if (ret == -EINVAL) {
+            /*
+             * Allow falling back to pwrite for file systems that
+             * do not support fallocate() for an unaligned byte range.
+             */
+            return -ENOTSUP;
+        }
         if (ret == 0 || ret != -ENOTSUP) {
             return ret;
         }
diff --git a/block/io.c b/block/io.c
index 56bbf19..58f08cd 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1558,7 +1558,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
             assert(!bs->supported_zero_flags);
         }
 
-        if (ret < 0 && !(flags & BDRV_REQ_NO_FALLBACK)) {
+        if (ret == -ENOTSUP && !(flags & BDRV_REQ_NO_FALLBACK)) {
             /* Fall back to bounce buffer if write zeroes is unsupported */
             BdrvRequestFlags write_flags = flags & ~BDRV_REQ_ZERO_WRITE;
 
-- 
1.8.3.1



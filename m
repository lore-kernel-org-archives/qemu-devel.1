Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC68ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:44:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E9B205C9
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E9B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFO46-0000sW-9u
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 15:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iFNo8-0004i9-Gp
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iFNo6-0001S6-UT
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:27:36 -0400
Received: from relay.sw.ru ([185.231.240.75]:45292)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iFNo6-0001Qj-N8; Tue, 01 Oct 2019 15:27:34 -0400
Received: from [172.16.25.136] (helo=dhcp-172-16-25-136.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iFNo3-00060a-Ay; Tue, 01 Oct 2019 22:27:31 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH 3/6] block: support compressed write for copy-on-read
Date: Tue,  1 Oct 2019 22:27:17 +0300
Message-Id: <1569958040-697220-4-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569958040-697220-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1569958040-697220-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
 jsnow@redhat.com, armbru@redhat.com, dgilbert@redhat.com, stefanha@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/io.c         | 21 ++++++++++++++++-----
 block/trace-events |  2 +-
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/block/io.c b/block/io.c
index f8c3596..a7cd24f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1264,12 +1264,13 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
      * allocating cluster in the image file.  Note that this value may exceed
      * BDRV_REQUEST_MAX_BYTES (even when the original read did not), which
      * is one reason we loop rather than doing it all at once.
+     * Also, this is crucial for compressed copy-on-read.
      */
     bdrv_round_to_clusters(bs, offset, bytes, &cluster_offset, &cluster_bytes);
     skip_bytes = offset - cluster_offset;
 
     trace_bdrv_co_do_copy_on_readv(bs, offset, bytes,
-                                   cluster_offset, cluster_bytes);
+                                   cluster_offset, cluster_bytes, flags);
 
     while (cluster_bytes) {
         int64_t pnum;
@@ -1328,9 +1329,15 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
                 /* This does not change the data on the disk, it is not
                  * necessary to flush even in cache=writethrough mode.
                  */
-                ret = bdrv_driver_pwritev(bs, cluster_offset, pnum,
-                                          &local_qiov, 0,
-                                          BDRV_REQ_WRITE_UNCHANGED);
+                if (flags & BDRV_REQ_WRITE_COMPRESSED) {
+                    ret = bdrv_driver_pwritev_compressed(bs, cluster_offset,
+                                                         pnum, &local_qiov,
+                                                         qiov_offset);
+                } else {
+                    ret = bdrv_driver_pwritev(bs, cluster_offset, pnum,
+                                              &local_qiov, 0,
+                                              BDRV_REQ_WRITE_UNCHANGED);
+                }
             }
 
             if (ret < 0) {
@@ -1396,7 +1403,11 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
      * to pass through to drivers.  For now, there aren't any
      * passthrough flags.  */
     assert(!(flags & ~(BDRV_REQ_NO_SERIALISING | BDRV_REQ_COPY_ON_READ |
-                       BDRV_REQ_PREFETCH)));
+                       BDRV_REQ_PREFETCH | BDRV_REQ_WRITE_COMPRESSED)));
+
+    /* write compressed only makes sense with copy on read */
+    assert(!(flags & BDRV_REQ_WRITE_COMPRESSED) ||
+           (flags & BDRV_REQ_COPY_ON_READ));
 
     /* Handle Copy on Read and associated serialisation */
     if (flags & BDRV_REQ_COPY_ON_READ) {
diff --git a/block/trace-events b/block/trace-events
index 3aa27e6..f444548 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -14,7 +14,7 @@ blk_root_detach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
 bdrv_co_preadv(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
 bdrv_co_pwritev(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
 bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p offset %"PRId64" count %d flags 0x%x"
-bdrv_co_do_copy_on_readv(void *bs, int64_t offset, unsigned int bytes, int64_t cluster_offset, int64_t cluster_bytes) "bs %p offset %"PRId64" bytes %u cluster_offset %"PRId64" cluster_bytes %"PRId64
+bdrv_co_do_copy_on_readv(void *bs, int64_t offset, unsigned int bytes, int64_t cluster_offset, int64_t cluster_bytes, int flags) "bs %p offset %"PRId64" bytes %u cluster_offset %"PRId64" cluster_bytes %"PRId64" flags 0x%x"
 bdrv_co_copy_range_from(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
 bdrv_co_copy_range_to(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
 
-- 
1.8.3.1



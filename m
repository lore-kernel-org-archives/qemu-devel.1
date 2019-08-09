Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAE1C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8A8208C4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8A8208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw6wK-0002OY-RV
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 11:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49081)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hw6sN-00041c-I3
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:32:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hw6sL-0002pb-7k
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:32:19 -0400
Received: from relay.sw.ru ([185.231.240.75]:57598)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hw6sI-0002ik-10; Fri, 09 Aug 2019 11:32:14 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hw6sC-0004Cp-NW; Fri, 09 Aug 2019 18:32:08 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:32:03 +0300
Message-Id: <20190809153207.49288-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190809153207.49288-1-vsementsov@virtuozzo.com>
References: <20190809153207.49288-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 3/7] block/io: handle alignment and
 max_transfer for copy_range
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

copy_range ignores these limitations, let's improve it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/block/io.c b/block/io.c
index 06305c6ea6..a5efb2200f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3005,11 +3005,24 @@ static int coroutine_fn bdrv_co_copy_range_internal(
 {
     BdrvTrackedRequest req;
     int ret;
+    uint32_t align = MAX(src->bs->bl.request_alignment,
+                         dst->bs->bl.request_alignment);
+    uint32_t max_transfer =
+            QEMU_ALIGN_DOWN(MIN_NON_ZERO(MIN_NON_ZERO(src->bs->bl.max_transfer,
+                                                      dst->bs->bl.max_transfer),
+                                         INT_MAX), align);
 
     /* TODO We can support BDRV_REQ_NO_FALLBACK here */
     assert(!(read_flags & BDRV_REQ_NO_FALLBACK));
     assert(!(write_flags & BDRV_REQ_NO_FALLBACK));
 
+    if (max_transfer == 0 && bytes > 0) {
+        /*
+         * For example, if source max_transfer is smaller than target alignment.
+         */
+        return -ENOTSUP;
+    }
+
     if (!dst || !dst->bs) {
         return -ENOMEDIUM;
     }
@@ -3031,7 +3044,10 @@ static int coroutine_fn bdrv_co_copy_range_internal(
 
     if (!src->bs->drv->bdrv_co_copy_range_from
         || !dst->bs->drv->bdrv_co_copy_range_to
-        || src->bs->encrypted || dst->bs->encrypted) {
+        || src->bs->encrypted || dst->bs->encrypted ||
+        !QEMU_IS_ALIGNED(src_offset, src->bs->bl.request_alignment) ||
+        !QEMU_IS_ALIGNED(dst_offset, dst->bs->bl.request_alignment) ||
+        !QEMU_IS_ALIGNED(bytes, align)) {
         return -ENOTSUP;
     }
 
@@ -3046,11 +3062,22 @@ static int coroutine_fn bdrv_co_copy_range_internal(
             wait_serialising_requests(&req);
         }
 
-        ret = src->bs->drv->bdrv_co_copy_range_from(src->bs,
-                                                    src, src_offset,
-                                                    dst, dst_offset,
-                                                    bytes,
-                                                    read_flags, write_flags);
+        while (bytes) {
+            int num = MIN(bytes, max_transfer);
+
+            ret = src->bs->drv->bdrv_co_copy_range_from(src->bs,
+                                                        src, src_offset,
+                                                        dst, dst_offset,
+                                                        num,
+                                                        read_flags,
+                                                        write_flags);
+            if (ret < 0) {
+                break;
+            }
+            bytes -= num;
+            src_offset += num;
+            dst_offset += num;
+        }
 
         tracked_request_end(&req);
         bdrv_dec_in_flight(src->bs);
@@ -3060,12 +3087,17 @@ static int coroutine_fn bdrv_co_copy_range_internal(
                               BDRV_TRACKED_WRITE);
         ret = bdrv_co_write_req_prepare(dst, dst_offset, bytes, &req,
                                         write_flags);
-        if (!ret) {
+        while (!ret && bytes) {
+            int num = MIN(bytes, max_transfer);
+
             ret = dst->bs->drv->bdrv_co_copy_range_to(dst->bs,
                                                       src, src_offset,
                                                       dst, dst_offset,
-                                                      bytes,
+                                                      num,
                                                       read_flags, write_flags);
+            bytes -= num;
+            src_offset += num;
+            dst_offset += num;
         }
         bdrv_co_write_req_finish(dst, dst_offset, bytes, &req, ret);
         tracked_request_end(&req);
-- 
2.18.0



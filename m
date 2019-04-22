Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D05EC10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 15:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6697020859
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 15:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6697020859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38778 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIaof-0006W7-A3
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 11:25:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIamv-0005LZ-8n
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 11:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIamu-0006GK-2f
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 11:23:21 -0400
Received: from relay.sw.ru ([185.231.240.75]:56448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hIamt-0006FV-R3; Mon, 22 Apr 2019 11:23:20 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hIamr-0003vg-6R; Mon, 22 Apr 2019 18:23:17 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon, 22 Apr 2019 18:23:14 +0300
Message-Id: <20190422152315.74361-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190422152315.74361-1-vsementsov@virtuozzo.com>
References: <20190422152315.74361-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v4 2/3] block/io: bdrv_pdiscard: support
 int64_t bytes parameter
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
	den@virtuozzo.com, mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422152314.WiOsZXkdhnUziRYmom0EmDXQaDEOy7l2Qd17PegDmNM@z>

This fixes at least one overflow in qcow2_process_discards, which
passes 64bit region length to bdrv_pdiscard where bytes (or sectors in
the past) parameter is int since its introduction in 0b919fae.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/block.h |  4 ++--
 block/io.c            | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index c7a26199aa..69fa18867e 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -432,8 +432,8 @@ void bdrv_drain_all(void);
     AIO_WAIT_WHILE(bdrv_get_aio_context(bs_),              \
                    cond); })
 
-int bdrv_pdiscard(BdrvChild *child, int64_t offset, int bytes);
-int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes);
+int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
+int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
 int bdrv_has_zero_init_1(BlockDriverState *bs);
 int bdrv_has_zero_init(BlockDriverState *bs);
 bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
diff --git a/block/io.c b/block/io.c
index dfc153b8d8..35c4157669 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2653,7 +2653,7 @@ int bdrv_flush(BlockDriverState *bs)
 typedef struct DiscardCo {
     BdrvChild *child;
     int64_t offset;
-    int bytes;
+    int64_t bytes;
     int ret;
 } DiscardCo;
 static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
@@ -2664,14 +2664,15 @@ static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
     aio_wait_kick();
 }
 
-int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
+int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
+                                  int64_t bytes)
 {
     BdrvTrackedRequest req;
     int max_pdiscard, ret;
     int head, tail, align;
     BlockDriverState *bs = child->bs;
 
-    if (!bs || !bs->drv) {
+    if (!bs || !bs->drv || !bdrv_is_inserted(bs)) {
         return -ENOMEDIUM;
     }
 
@@ -2679,9 +2680,8 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
         return -EPERM;
     }
 
-    ret = bdrv_check_byte_request(bs, offset, bytes);
-    if (ret < 0) {
-        return ret;
+    if (offset < 0) {
+        return -EIO;
     }
 
     /* Do nothing if disabled.  */
@@ -2716,7 +2716,7 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
     assert(max_pdiscard >= bs->bl.request_alignment);
 
     while (bytes > 0) {
-        int num = bytes;
+        int64_t num = bytes;
 
         if (head) {
             /* Make small requests to get to alignment boundaries. */
@@ -2778,7 +2778,7 @@ out:
     return ret;
 }
 
-int bdrv_pdiscard(BdrvChild *child, int64_t offset, int bytes)
+int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes)
 {
     Coroutine *co;
     DiscardCo rwco = {
-- 
2.18.0



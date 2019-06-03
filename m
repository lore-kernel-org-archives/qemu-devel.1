Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F9FC28CC6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0F6D27912
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F6D27912
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36665 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXor1-0002GQ-TW
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:26:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoWJ-0001lO-IB
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoWI-0001xJ-6B
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:05:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXoW8-0001ar-0s; Mon, 03 Jun 2019 11:04:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45EF9308794D;
	Mon,  3 Jun 2019 15:04:53 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-129.ams2.redhat.com
	[10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5CBB261B6A;
	Mon,  3 Jun 2019 15:04:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 17:02:32 +0200
Message-Id: <20190603150233.6614-28-kwolf@redhat.com>
In-Reply-To: <20190603150233.6614-1-kwolf@redhat.com>
References: <20190603150233.6614-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 03 Jun 2019 15:04:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 27/28] block/io: bdrv_pdiscard: support int64_t
 bytes parameter
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This fixes at least one overflow in qcow2_process_discards, which
passes 64bit region length to bdrv_pdiscard where bytes (or sectors in
the past) parameter is int since its introduction in 0b919fae.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  4 ++--
 block/io.c            | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 13ea050a5b..f9415ed740 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -434,8 +434,8 @@ void bdrv_drain_all(void);
     AIO_WAIT_WHILE(bdrv_get_aio_context(bs_),              \
                    cond); })
=20
-int bdrv_pdiscard(BdrvChild *child, int64_t offset, int bytes);
-int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes);
+int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
+int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
 int bdrv_has_zero_init_1(BlockDriverState *bs);
 int bdrv_has_zero_init(BlockDriverState *bs);
 bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
diff --git a/block/io.c b/block/io.c
index 0f6ebd001c..9ba1bada36 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2632,7 +2632,7 @@ int bdrv_flush(BlockDriverState *bs)
 typedef struct DiscardCo {
     BdrvChild *child;
     int64_t offset;
-    int bytes;
+    int64_t bytes;
     int ret;
 } DiscardCo;
 static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
@@ -2643,14 +2643,15 @@ static void coroutine_fn bdrv_pdiscard_co_entry(v=
oid *opaque)
     aio_wait_kick();
 }
=20
-int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int =
bytes)
+int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
+                                  int64_t bytes)
 {
     BdrvTrackedRequest req;
     int max_pdiscard, ret;
     int head, tail, align;
     BlockDriverState *bs =3D child->bs;
=20
-    if (!bs || !bs->drv) {
+    if (!bs || !bs->drv || !bdrv_is_inserted(bs)) {
         return -ENOMEDIUM;
     }
=20
@@ -2658,9 +2659,8 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child,=
 int64_t offset, int bytes)
         return -EPERM;
     }
=20
-    ret =3D bdrv_check_byte_request(bs, offset, bytes);
-    if (ret < 0) {
-        return ret;
+    if (offset < 0 || bytes < 0 || bytes > INT64_MAX - offset) {
+        return -EIO;
     }
=20
     /* Do nothing if disabled.  */
@@ -2695,7 +2695,7 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child,=
 int64_t offset, int bytes)
     assert(max_pdiscard >=3D bs->bl.request_alignment);
=20
     while (bytes > 0) {
-        int num =3D bytes;
+        int64_t num =3D bytes;
=20
         if (head) {
             /* Make small requests to get to alignment boundaries. */
@@ -2757,7 +2757,7 @@ out:
     return ret;
 }
=20
-int bdrv_pdiscard(BdrvChild *child, int64_t offset, int bytes)
+int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes)
 {
     Coroutine *co;
     DiscardCo rwco =3D {
--=20
2.20.1



Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CA6C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B6920673
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B6920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXKT-00078H-NB
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWrP-00077e-TN
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWrO-0008LY-Nc
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40416)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWrM-0008Kd-88; Thu, 10 Oct 2019 07:43:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7930A18CB8E5;
 Thu, 10 Oct 2019 11:43:55 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DBEC5D6A5;
 Thu, 10 Oct 2019 11:43:54 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 24/36] file-posix: account discard operations
Date: Thu, 10 Oct 2019 13:42:48 +0200
Message-Id: <20191010114300.7746-25-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 10 Oct 2019 11:43:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

This will help to identify how many of the user-issued discard operations
(accounted on a device level) have actually suceeded down on the host fil=
e
(even though the numbers will not be exactly the same if non-raw format
driver is used (e.g. qcow2 sending metadata discards)).

Note that these numbers will not include discards triggered by
write-zeroes + MAY_UNMAP calls.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190923121737.83281-9-anton.nefedov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index f12c06de2d..f3934c4e10 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -161,6 +161,11 @@ typedef struct BDRVRawState {
     bool needs_alignment;
     bool drop_cache;
     bool check_cache_dropped;
+    struct {
+        uint64_t discard_nb_ok;
+        uint64_t discard_nb_failed;
+        uint64_t discard_bytes_ok;
+    } stats;
=20
     PRManager *pr_mgr;
 } BDRVRawState;
@@ -2660,11 +2665,22 @@ static void coroutine_fn raw_co_invalidate_cache(=
BlockDriverState *bs,
 #endif /* !__linux__ */
 }
=20
+static void raw_account_discard(BDRVRawState *s, uint64_t nbytes, int re=
t)
+{
+    if (ret) {
+        s->stats.discard_nb_failed++;
+    } else {
+        s->stats.discard_nb_ok++;
+        s->stats.discard_bytes_ok +=3D nbytes;
+    }
+}
+
 static coroutine_fn int
 raw_do_pdiscard(BlockDriverState *bs, int64_t offset, int bytes, bool bl=
kdev)
 {
     BDRVRawState *s =3D bs->opaque;
     RawPosixAIOData acb;
+    int ret;
=20
     acb =3D (RawPosixAIOData) {
         .bs             =3D bs,
@@ -2678,7 +2694,9 @@ raw_do_pdiscard(BlockDriverState *bs, int64_t offse=
t, int bytes, bool blkdev)
         acb.aio_type |=3D QEMU_AIO_BLKDEV;
     }
=20
-    return raw_thread_pool_submit(bs, handle_aiocb_discard, &acb);
+    ret =3D raw_thread_pool_submit(bs, handle_aiocb_discard, &acb);
+    raw_account_discard(s, bytes, ret);
+    return ret;
 }
=20
 static coroutine_fn int
@@ -3301,10 +3319,12 @@ static int fd_open(BlockDriverState *bs)
 static coroutine_fn int
 hdev_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
 {
+    BDRVRawState *s =3D bs->opaque;
     int ret;
=20
     ret =3D fd_open(bs);
     if (ret < 0) {
+        raw_account_discard(s, bytes, ret);
         return ret;
     }
     return raw_do_pdiscard(bs, offset, bytes, true);
--=20
2.21.0



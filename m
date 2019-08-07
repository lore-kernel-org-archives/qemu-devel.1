Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B203FC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869B42199C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869B42199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNEa-0005qB-Kt
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44065)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hvNDA-0004Qy-Fl
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hvND9-0005OP-AU
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:46:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45612)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hvND6-0005Mg-S6; Wed, 07 Aug 2019 10:46:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A67230016E4;
 Wed,  7 Aug 2019 14:46:40 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-121.ams2.redhat.com
 [10.36.117.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72D725D71C;
 Wed,  7 Aug 2019 14:46:38 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  7 Aug 2019 16:46:26 +0200
Message-Id: <20190807144628.4988-2-kwolf@redhat.com>
In-Reply-To: <20190807144628.4988-1-kwolf@redhat.com>
References: <20190807144628.4988-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 07 Aug 2019 14:46:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/3] block: Remove blk_pread_unthrottled()
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, dplotnikov@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functionality offered by blk_pread_unthrottled() goes back to commit
498e386c584. Then, we couldn't perform I/O throttling with synchronous
requests because timers wouldn't be executed in polling loops. So the
commit automatically disabled I/O throttling as soon as a synchronous
request was issued.

However, for geometry detection during disk initialisation, we always
used (and still use) synchronous requests even if guest requests use AIO
later. Geometry detection was not wanted to disable I/O throttling, so
bdrv_pread_unthrottled() was introduced which disabled throttling only
temporarily.

All of this isn't necessary any more because we do run timers in polling
loop and even synchronous requests are now using coroutine
infrastructure internally. For this reason, commit 90c78624f already
removed the automatic disabling of I/O throttling.

It's time to get rid of the workaround for the removed code, and its
abuse of blk_root_drained_begin()/end(), as well.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/sysemu/block-backend.h |  2 --
 block/block-backend.c          | 16 ----------------
 hw/block/hd-geometry.c         |  7 +------
 3 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backen=
d.h
index 733c4957eb..7320b58467 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -117,8 +117,6 @@ char *blk_get_attached_dev_id(BlockBackend *blk);
 BlockBackend *blk_by_dev(void *dev);
 BlockBackend *blk_by_qdev_id(const char *id, Error **errp);
 void blk_set_dev_ops(BlockBackend *blk, const BlockDevOps *ops, void *op=
aque);
-int blk_pread_unthrottled(BlockBackend *blk, int64_t offset, uint8_t *bu=
f,
-                          int bytes);
 int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
                                unsigned int bytes, QEMUIOVector *qiov,
                                BdrvRequestFlags flags);
diff --git a/block/block-backend.c b/block/block-backend.c
index 0056b526b8..fdd6b01ecf 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1237,22 +1237,6 @@ static int blk_prw(BlockBackend *blk, int64_t offs=
et, uint8_t *buf,
     return rwco.ret;
 }
=20
-int blk_pread_unthrottled(BlockBackend *blk, int64_t offset, uint8_t *bu=
f,
-                          int count)
-{
-    int ret;
-
-    ret =3D blk_check_byte_request(blk, offset, count);
-    if (ret < 0) {
-        return ret;
-    }
-
-    blk_root_drained_begin(blk->root);
-    ret =3D blk_pread(blk, offset, buf, count);
-    blk_root_drained_end(blk->root, NULL);
-    return ret;
-}
-
 int blk_pwrite_zeroes(BlockBackend *blk, int64_t offset,
                       int bytes, BdrvRequestFlags flags)
 {
diff --git a/hw/block/hd-geometry.c b/hw/block/hd-geometry.c
index 79384a2b0a..dcbccee294 100644
--- a/hw/block/hd-geometry.c
+++ b/hw/block/hd-geometry.c
@@ -63,12 +63,7 @@ static int guess_disk_lchs(BlockBackend *blk,
=20
     blk_get_geometry(blk, &nb_sectors);
=20
-    /**
-     * The function will be invoked during startup not only in sync I/O =
mode,
-     * but also in async I/O mode. So the I/O throttling function has to
-     * be disabled temporarily here, not permanently.
-     */
-    if (blk_pread_unthrottled(blk, 0, buf, BDRV_SECTOR_SIZE) < 0) {
+    if (blk_pread(blk, 0, buf, BDRV_SECTOR_SIZE) < 0) {
         return -1;
     }
     /* test msdos magic */
--=20
2.20.1



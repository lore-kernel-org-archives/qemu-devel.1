Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ED7C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:33:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37AFF208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AFF208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41524 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVhqI-0002uG-De
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:33:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhnr-0001Tw-RV
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhnj-0001g4-9u
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVhnS-0000Hi-Ro; Tue, 28 May 2019 15:30:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 315C73003A4E;
	Tue, 28 May 2019 19:29:04 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B8DAC611D9;
	Tue, 28 May 2019 19:29:03 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:28:32 +0200
Message-Id: <20190528192847.2730-7-mreitz@redhat.com>
In-Reply-To: <20190528192847.2730-1-mreitz@redhat.com>
References: <20190528192847.2730-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 28 May 2019 19:29:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 06/21] qcow2: qcow2_co_preadv: improve locking
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Background: decryption will be done in threads, to take benefit of it,
we should move it out of the lock first.

But let's go further: it turns out, that only
qcow2_get_cluster_offset() needs locking, so reduce locking to it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190506142741.41731-7-vsementsov@virtuozzo.com
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 1413df1389..4a89850389 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1969,8 +1969,6 @@ static coroutine_fn int qcow2_co_preadv(BlockDriver=
State *bs, uint64_t offset,
=20
     qemu_iovec_init(&hd_qiov, qiov->niov);
=20
-    qemu_co_mutex_lock(&s->lock);
-
     while (bytes !=3D 0) {
=20
         /* prepare next request */
@@ -1980,7 +1978,9 @@ static coroutine_fn int qcow2_co_preadv(BlockDriver=
State *bs, uint64_t offset,
                             QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
         }
=20
+        qemu_co_mutex_lock(&s->lock);
         ret =3D qcow2_get_cluster_offset(bs, offset, &cur_bytes, &cluste=
r_offset);
+        qemu_co_mutex_unlock(&s->lock);
         if (ret < 0) {
             goto fail;
         }
@@ -1995,10 +1995,8 @@ static coroutine_fn int qcow2_co_preadv(BlockDrive=
rState *bs, uint64_t offset,
=20
             if (bs->backing) {
                 BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
-                qemu_co_mutex_unlock(&s->lock);
                 ret =3D bdrv_co_preadv(bs->backing, offset, cur_bytes,
                                      &hd_qiov, 0);
-                qemu_co_mutex_lock(&s->lock);
                 if (ret < 0) {
                     goto fail;
                 }
@@ -2014,11 +2012,9 @@ static coroutine_fn int qcow2_co_preadv(BlockDrive=
rState *bs, uint64_t offset,
             break;
=20
         case QCOW2_CLUSTER_COMPRESSED:
-            qemu_co_mutex_unlock(&s->lock);
             ret =3D qcow2_co_preadv_compressed(bs, cluster_offset,
                                              offset, cur_bytes,
                                              &hd_qiov);
-            qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
                 goto fail;
             }
@@ -2055,11 +2051,9 @@ static coroutine_fn int qcow2_co_preadv(BlockDrive=
rState *bs, uint64_t offset,
             }
=20
             BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-            qemu_co_mutex_unlock(&s->lock);
             ret =3D bdrv_co_preadv(s->data_file,
                                  cluster_offset + offset_in_cluster,
                                  cur_bytes, &hd_qiov, 0);
-            qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
                 goto fail;
             }
@@ -2094,8 +2088,6 @@ static coroutine_fn int qcow2_co_preadv(BlockDriver=
State *bs, uint64_t offset,
     ret =3D 0;
=20
 fail:
-    qemu_co_mutex_unlock(&s->lock);
-
     qemu_iovec_destroy(&hd_qiov);
     qemu_vfree(cluster_data);
=20
--=20
2.21.0



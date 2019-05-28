Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9448C04E84
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98DAE208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DAE208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41566 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVhsl-0004mY-JQ
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:35:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhnr-0001TK-5K
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhnf-0001dH-VJ
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVhnS-0000KF-CD; Tue, 28 May 2019 15:30:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D63530593D8;
	Tue, 28 May 2019 19:29:06 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 26C405C8A4;
	Tue, 28 May 2019 19:29:05 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:28:33 +0200
Message-Id: <20190528192847.2730-8-mreitz@redhat.com>
In-Reply-To: <20190528192847.2730-1-mreitz@redhat.com>
References: <20190528192847.2730-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 28 May 2019 19:29:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 07/21] qcow2: bdrv_co_pwritev: move encryption
 code out of the lock
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

Encryption will be done in threads, to take benefit of it, we should
move it out of the lock first.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190506142741.41731-8-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 4a89850389..4b4a0ce6e0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2168,11 +2168,20 @@ static coroutine_fn int qcow2_co_pwritev(BlockDri=
verState *bs, uint64_t offset,
         ret =3D qcow2_alloc_cluster_offset(bs, offset, &cur_bytes,
                                          &cluster_offset, &l2meta);
         if (ret < 0) {
-            goto fail;
+            goto out_locked;
         }
=20
         assert((cluster_offset & 511) =3D=3D 0);
=20
+        ret =3D qcow2_pre_write_overlap_check(bs, 0,
+                                            cluster_offset + offset_in_c=
luster,
+                                            cur_bytes, true);
+        if (ret < 0) {
+            goto out_locked;
+        }
+
+        qemu_co_mutex_unlock(&s->lock);
+
         qemu_iovec_reset(&hd_qiov);
         qemu_iovec_concat(&hd_qiov, qiov, bytes_done, cur_bytes);
=20
@@ -2184,7 +2193,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDrive=
rState *bs, uint64_t offset,
                                                    * s->cluster_size);
                 if (cluster_data =3D=3D NULL) {
                     ret =3D -ENOMEM;
-                    goto fail;
+                    goto out_unlocked;
                 }
             }
=20
@@ -2199,40 +2208,34 @@ static coroutine_fn int qcow2_co_pwritev(BlockDri=
verState *bs, uint64_t offset,
                                       cluster_data,
                                       cur_bytes, NULL) < 0) {
                 ret =3D -EIO;
-                goto fail;
+                goto out_unlocked;
             }
=20
             qemu_iovec_reset(&hd_qiov);
             qemu_iovec_add(&hd_qiov, cluster_data, cur_bytes);
         }
=20
-        ret =3D qcow2_pre_write_overlap_check(bs, 0,
-                cluster_offset + offset_in_cluster, cur_bytes, true);
-        if (ret < 0) {
-            goto fail;
-        }
-
         /* If we need to do COW, check if it's possible to merge the
          * writing of the guest data together with that of the COW regio=
ns.
          * If it's not possible (or not necessary) then write the
          * guest data now. */
         if (!merge_cow(offset, cur_bytes, &hd_qiov, l2meta)) {
-            qemu_co_mutex_unlock(&s->lock);
             BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
             trace_qcow2_writev_data(qemu_coroutine_self(),
                                     cluster_offset + offset_in_cluster);
             ret =3D bdrv_co_pwritev(s->data_file,
                                   cluster_offset + offset_in_cluster,
                                   cur_bytes, &hd_qiov, 0);
-            qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
-                goto fail;
+                goto out_unlocked;
             }
         }
=20
+        qemu_co_mutex_lock(&s->lock);
+
         ret =3D qcow2_handle_l2meta(bs, &l2meta, true);
         if (ret) {
-            goto fail;
+            goto out_locked;
         }
=20
         bytes -=3D cur_bytes;
@@ -2241,8 +2244,12 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriv=
erState *bs, uint64_t offset,
         trace_qcow2_writev_done_part(qemu_coroutine_self(), cur_bytes);
     }
     ret =3D 0;
+    goto out_locked;
=20
-fail:
+out_unlocked:
+    qemu_co_mutex_lock(&s->lock);
+
+out_locked:
     qcow2_handle_l2meta(bs, &l2meta, false);
=20
     qemu_co_mutex_unlock(&s->lock);
--=20
2.21.0



Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E1EC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACAC42077B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAC42077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2i63-0002xC-Tk
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 16:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i2hus-0006ja-28
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i2huo-00012p-28
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:18:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34372)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i2hul-0000yI-4R; Tue, 27 Aug 2019 16:18:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5F31018C892C;
 Tue, 27 Aug 2019 20:18:02 +0000 (UTC)
Received: from localhost (ovpn-116-148.ams2.redhat.com [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92C3260F82;
 Tue, 27 Aug 2019 20:17:56 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 21:16:37 +0100
Message-Id: <20190827201639.30368-11-stefanha@redhat.com>
In-Reply-To: <20190827201639.30368-1-stefanha@redhat.com>
References: <20190827201639.30368-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 27 Aug 2019 20:18:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/12] block/qcow2: refactor qcow2_co_preadv to
 use buffer-based io
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Use buffer based io in encrypted case.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190604161514.262241-11-vsementsov@virtuozzo.com
Message-Id: <20190604161514.262241-11-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qcow2.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7c5a4859f7..b2b87d1a8d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2059,19 +2059,15 @@ static coroutine_fn int qcow2_co_preadv(BlockDriv=
erState *bs, uint64_t offset,
                 }
=20
                 assert(cur_bytes <=3D QCOW_MAX_CRYPT_CLUSTERS * s->clust=
er_size);
-                qemu_iovec_reset(&hd_qiov);
-                qemu_iovec_add(&hd_qiov, cluster_data, cur_bytes);
-            }
=20
-            BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-            ret =3D bdrv_co_preadv(s->data_file,
-                                 cluster_offset + offset_in_cluster,
-                                 cur_bytes, &hd_qiov, 0);
-            if (ret < 0) {
-                goto fail;
-            }
-            if (bs->encrypted) {
-                assert(s->crypto);
+                BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
+                ret =3D bdrv_co_pread(s->data_file,
+                                    cluster_offset + offset_in_cluster,
+                                    cur_bytes, cluster_data, 0);
+                if (ret < 0) {
+                    goto fail;
+                }
+
                 assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
                 assert((cur_bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
                 if (qcow2_co_decrypt(bs, cluster_offset, offset,
@@ -2080,6 +2076,14 @@ static coroutine_fn int qcow2_co_preadv(BlockDrive=
rState *bs, uint64_t offset,
                     goto fail;
                 }
                 qemu_iovec_from_buf(qiov, bytes_done, cluster_data, cur_=
bytes);
+            } else {
+                BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
+                ret =3D bdrv_co_preadv(s->data_file,
+                                     cluster_offset + offset_in_cluster,
+                                     cur_bytes, &hd_qiov, 0);
+                if (ret < 0) {
+                    goto fail;
+                }
             }
             break;
=20
--=20
2.21.0



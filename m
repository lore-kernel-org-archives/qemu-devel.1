Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64990C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 15:00:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34A8520656
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 15:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A8520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38443 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIaQr-000218-4w
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 11:00:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP5-0000nn-ND
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP4-00037u-KX
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:43 -0400
Received: from relay.sw.ru ([185.231.240.75]:55314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hIaP4-00036J-BB; Mon, 22 Apr 2019 10:58:42 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hIaP1-0003k3-Cr; Mon, 22 Apr 2019 17:58:39 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon, 22 Apr 2019 17:58:31 +0300
Message-Id: <20190422145838.70903-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190422145838.70903-1-vsementsov@virtuozzo.com>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 2/9] block/qcow2: use buffer-based io
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com,
	stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422145831.g6xFSSQk0dn8U7Xyjt4vXVhwyOsaYnXib3-it_7XAck@z>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 3ace3b2209..c3b2ea294d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4088,7 +4088,6 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
                             uint64_t bytes, QEMUIOVector *qiov)
 {
     BDRVQcow2State *s = bs->opaque;
-    QEMUIOVector hd_qiov;
     int ret;
     size_t out_len;
     uint8_t *buf, *out_buf;
@@ -4155,10 +4154,8 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         goto fail;
     }
 
-    qemu_iovec_init_buf(&hd_qiov, out_buf, out_len);
-
     BLKDBG_EVENT(s->data_file, BLKDBG_WRITE_COMPRESSED);
-    ret = bdrv_co_pwritev(s->data_file, cluster_offset, out_len, &hd_qiov, 0);
+    ret = bdrv_co_pwrite(s->data_file, cluster_offset, out_len, out_buf, 0);
     if (ret < 0) {
         goto fail;
     }
@@ -4181,7 +4178,6 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
     int ret = 0, csize, nb_csectors;
     uint64_t coffset;
     uint8_t *buf, *out_buf;
-    QEMUIOVector local_qiov;
     int offset_in_cluster = offset_into_cluster(s, offset);
 
     coffset = file_cluster_offset & s->cluster_offset_mask;
@@ -4192,12 +4188,11 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
     if (!buf) {
         return -ENOMEM;
     }
-    qemu_iovec_init_buf(&local_qiov, buf, csize);
 
     out_buf = qemu_blockalign(bs, s->cluster_size);
 
     BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
-    ret = bdrv_co_preadv(bs->file, coffset, csize, &local_qiov, 0);
+    ret = bdrv_co_pread(bs->file, coffset, csize, buf, 0);
     if (ret < 0) {
         goto fail;
     }
-- 
2.18.0



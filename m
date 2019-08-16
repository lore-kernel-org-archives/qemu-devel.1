Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1D1C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C23062086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23062086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hylrk-0001rL-S8
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 19:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hylQ2-00076M-VW
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hylQ1-0006MX-9n
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:14:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54840)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hylPy-0006I8-5K; Fri, 16 Aug 2019 19:13:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0D29E1E1E6F;
 Fri, 16 Aug 2019 23:13:55 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46F9D19C6A;
 Fri, 16 Aug 2019 23:13:54 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 19:13:17 -0400
Message-Id: <20190816231318.8650-36-jsnow@redhat.com>
In-Reply-To: <20190816231318.8650-1-jsnow@redhat.com>
References: <20190816231318.8650-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Fri, 16 Aug 2019 23:13:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 35/36] block/backup: refactor write_flags
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
Cc: peter.maydell@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

write flags are constant, let's store it in BackupBlockJob instead of
recalculating. It also makes two boolean fields to be unused, so,
drop them.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190730163251.755248-4-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 083fc189af9..2baf7bed65a 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -50,14 +50,13 @@ typedef struct BackupBlockJob {
     uint64_t len;
     uint64_t bytes_read;
     int64_t cluster_size;
-    bool compress;
     NotifierWithReturn before_write;
     QLIST_HEAD(, CowRequest) inflight_reqs;
=20
     bool use_copy_range;
     int64_t copy_range_size;
=20
-    bool serialize_target_writes;
+    BdrvRequestFlags write_flags;
     bool initializing_bitmap;
 } BackupBlockJob;
=20
@@ -113,10 +112,6 @@ static int coroutine_fn backup_cow_with_bounce_buffe=
r(BackupBlockJob *job,
     BlockBackend *blk =3D job->common.blk;
     int nbytes;
     int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
-    int write_flags =3D
-            (job->serialize_target_writes ? BDRV_REQ_SERIALISING : 0) |
-            (job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
-
=20
     assert(QEMU_IS_ALIGNED(start, job->cluster_size));
     bdrv_reset_dirty_bitmap(job->copy_bitmap, start, job->cluster_size);
@@ -135,7 +130,7 @@ static int coroutine_fn backup_cow_with_bounce_buffer=
(BackupBlockJob *job,
     }
=20
     ret =3D blk_co_pwrite(job->target, start, nbytes, *bounce_buffer,
-                        write_flags);
+                        job->write_flags);
     if (ret < 0) {
         trace_backup_do_cow_write_fail(job, start, ret);
         if (error_is_read) {
@@ -163,7 +158,6 @@ static int coroutine_fn backup_cow_with_offload(Backu=
pBlockJob *job,
     BlockBackend *blk =3D job->common.blk;
     int nbytes;
     int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
-    int write_flags =3D job->serialize_target_writes ? BDRV_REQ_SERIALIS=
ING : 0;
=20
     assert(QEMU_IS_ALIGNED(job->copy_range_size, job->cluster_size));
     assert(QEMU_IS_ALIGNED(start, job->cluster_size));
@@ -172,7 +166,7 @@ static int coroutine_fn backup_cow_with_offload(Backu=
pBlockJob *job,
     bdrv_reset_dirty_bitmap(job->copy_bitmap, start,
                             job->cluster_size * nr_clusters);
     ret =3D blk_co_copy_range(blk, start, job->target, start, nbytes,
-                            read_flags, write_flags);
+                            read_flags, job->write_flags);
     if (ret < 0) {
         trace_backup_do_cow_copy_range_fail(job, start, ret);
         bdrv_set_dirty_bitmap(job->copy_bitmap, start,
@@ -751,10 +745,16 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
     job->sync_mode =3D sync_mode;
     job->sync_bitmap =3D sync_bitmap;
     job->bitmap_mode =3D bitmap_mode;
-    job->compress =3D compress;
=20
-    /* Detect image-fleecing (and similar) schemes */
-    job->serialize_target_writes =3D bdrv_chain_contains(target, bs);
+    /*
+     * Set write flags:
+     * 1. Detect image-fleecing (and similar) schemes
+     * 2. Handle compression
+     */
+    job->write_flags =3D
+        (bdrv_chain_contains(target, bs) ? BDRV_REQ_SERIALISING : 0) |
+        (compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
+
     job->cluster_size =3D cluster_size;
     job->copy_bitmap =3D copy_bitmap;
     copy_bitmap =3D NULL;
--=20
2.21.0



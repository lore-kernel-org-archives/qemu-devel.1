Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4017C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 965A52086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965A52086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hylod-0006MQ-Mk
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 19:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hylPv-0006sN-Iz
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hylPu-0006EH-3t
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55642)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hylPq-00068s-FJ; Fri, 16 Aug 2019 19:13:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C82D230833B0;
 Fri, 16 Aug 2019 23:13:49 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2101519C6A;
 Fri, 16 Aug 2019 23:13:49 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 19:13:11 -0400
Message-Id: <20190816231318.8650-30-jsnow@redhat.com>
In-Reply-To: <20190816231318.8650-1-jsnow@redhat.com>
References: <20190816231318.8650-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 16 Aug 2019 23:13:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 29/36] block/backup: add
 backup_is_cluster_allocated
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
Cc: peter.maydell@linaro.org, jsnow@redhat.com, qemu-stable@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Modify bdrv_is_unallocated_range to utilize the pnum return from
bdrv_is_allocated, and in the process change the semantics from
"is unallocated" to "is allocated."

Optionally returns a full number of clusters that share the same
allocation status.

This will be used to carefully toggle bits in the bitmap for sync=3Dtop
initialization in the following commits.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190716000117.25219-9-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c | 62 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 305f9b3468b..f6bf32c9438 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -185,6 +185,48 @@ static int coroutine_fn backup_cow_with_offload(Back=
upBlockJob *job,
     return nbytes;
 }
=20
+/*
+ * Check if the cluster starting at offset is allocated or not.
+ * return via pnum the number of contiguous clusters sharing this alloca=
tion.
+ */
+static int backup_is_cluster_allocated(BackupBlockJob *s, int64_t offset=
,
+                                       int64_t *pnum)
+{
+    BlockDriverState *bs =3D blk_bs(s->common.blk);
+    int64_t count, total_count =3D 0;
+    int64_t bytes =3D s->len - offset;
+    int ret;
+
+    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
+
+    while (true) {
+        ret =3D bdrv_is_allocated(bs, offset, bytes, &count);
+        if (ret < 0) {
+            return ret;
+        }
+
+        total_count +=3D count;
+
+        if (ret || count =3D=3D 0) {
+            /*
+             * ret: partial segment(s) are considered allocated.
+             * otherwise: unallocated tail is treated as an entire segme=
nt.
+             */
+            *pnum =3D DIV_ROUND_UP(total_count, s->cluster_size);
+            return ret;
+        }
+
+        /* Unallocated segment(s) with uncertain following segment(s) */
+        if (total_count >=3D s->cluster_size) {
+            *pnum =3D total_count / s->cluster_size;
+            return 0;
+        }
+
+        offset +=3D count;
+        bytes -=3D count;
+    }
+}
+
 static int coroutine_fn backup_do_cow(BackupBlockJob *job,
                                       int64_t offset, uint64_t bytes,
                                       bool *error_is_read,
@@ -398,34 +440,18 @@ static bool coroutine_fn yield_and_check(BackupBloc=
kJob *job)
     return false;
 }
=20
-static bool bdrv_is_unallocated_range(BlockDriverState *bs,
-                                      int64_t offset, int64_t bytes)
-{
-    int64_t end =3D offset + bytes;
-
-    while (offset < end && !bdrv_is_allocated(bs, offset, bytes, &bytes)=
) {
-        if (bytes =3D=3D 0) {
-            return true;
-        }
-        offset +=3D bytes;
-        bytes =3D end - offset;
-    }
-
-    return offset >=3D end;
-}
-
 static int coroutine_fn backup_loop(BackupBlockJob *job)
 {
     bool error_is_read;
     int64_t offset;
     BdrvDirtyBitmapIter *bdbi;
-    BlockDriverState *bs =3D blk_bs(job->common.blk);
     int ret =3D 0;
+    int64_t dummy;
=20
     bdbi =3D bdrv_dirty_iter_new(job->copy_bitmap);
     while ((offset =3D bdrv_dirty_iter_next(bdbi)) !=3D -1) {
         if (job->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP &&
-            bdrv_is_unallocated_range(bs, offset, job->cluster_size))
+            !backup_is_cluster_allocated(job, offset, &dummy))
         {
             bdrv_reset_dirty_bitmap(job->copy_bitmap, offset,
                                     job->cluster_size);
--=20
2.21.0



Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B72C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5A820896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5A820896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35766 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbCA9-0001ik-4b
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 18:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46212)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBSz-000071-0P
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBSx-0008F5-35
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:11:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45468)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBSo-00085n-Fb; Wed, 12 Jun 2019 18:11:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 79DEA30C31A6;
 Wed, 12 Jun 2019 22:11:19 +0000 (UTC)
Received: from localhost (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08F7A1710F;
 Wed, 12 Jun 2019 22:11:18 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 13 Jun 2019 00:09:50 +0200
Message-Id: <20190612221004.2317-29-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-1-mreitz@redhat.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 12 Jun 2019 22:11:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 28/42] stream: Deal with filters
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json |  4 ++++
 block/stream.c       | 23 +++++++++++++++--------
 blockdev.c           |  2 +-
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index df52a90736..a3c5298cf5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2518,6 +2518,10 @@
 # On successful completion the image file is updated to drop the backing=
 file
 # and the BLOCK_JOB_COMPLETED event is emitted.
 #
+# In case @device is a filter node, block-stream modifies the first non-=
filter
+# overlay node below it to point to base's backing node (or NULL if @bas=
e was
+# not specified) instead of modifying @device itself.
+#
 # @job-id: identifier for the newly-created block job. If
 #          omitted, the device name will be used. (Since 2.7)
 #
diff --git a/block/stream.c b/block/stream.c
index 1a906fd860..9271e1821a 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -63,6 +63,7 @@ static int stream_prepare(Job *job)
     StreamBlockJob *s =3D container_of(job, StreamBlockJob, common.job);
     BlockJob *bjob =3D &s->common;
     BlockDriverState *bs =3D blk_bs(bjob->blk);
+    BlockDriverState *unfiltered_bs =3D bdrv_skip_rw_filters(bs);
     BlockDriverState *base =3D s->base;
     Error *local_err =3D NULL;
     int ret =3D 0;
@@ -70,7 +71,7 @@ static int stream_prepare(Job *job)
     bdrv_unfreeze_backing_chain(bs, base);
     s->chain_frozen =3D false;
=20
-    if (bs->backing) {
+    if (bdrv_filtered_cow_child(unfiltered_bs)) {
         const char *base_id =3D NULL, *base_fmt =3D NULL;
         if (base) {
             base_id =3D s->backing_file_str;
@@ -78,8 +79,8 @@ static int stream_prepare(Job *job)
                 base_fmt =3D base->drv->format_name;
             }
         }
-        ret =3D bdrv_change_backing_file(bs, base_id, base_fmt);
-        bdrv_set_backing_hd(bs, base, &local_err);
+        ret =3D bdrv_change_backing_file(unfiltered_bs, base_id, base_fm=
t);
+        bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
         if (local_err) {
             error_report_err(local_err);
             return -EPERM;
@@ -110,7 +111,9 @@ static int coroutine_fn stream_run(Job *job, Error **=
errp)
     StreamBlockJob *s =3D container_of(job, StreamBlockJob, common.job);
     BlockBackend *blk =3D s->common.blk;
     BlockDriverState *bs =3D blk_bs(blk);
+    BlockDriverState *unfiltered_bs =3D bdrv_skip_rw_filters(bs);
     BlockDriverState *base =3D s->base;
+    BlockDriverState *filtered_base;
     int64_t len;
     int64_t offset =3D 0;
     uint64_t delay_ns =3D 0;
@@ -119,10 +122,12 @@ static int coroutine_fn stream_run(Job *job, Error =
**errp)
     int64_t n =3D 0; /* bytes */
     void *buf;
=20
-    if (!bs->backing) {
+    if (!bdrv_filtered_cow_child(unfiltered_bs)) {
         goto out;
     }
=20
+    filtered_base =3D bdrv_filtered_cow_bs(bdrv_find_overlay(bs, base));
+
     len =3D bdrv_getlength(bs);
     if (len < 0) {
         ret =3D len;
@@ -154,14 +159,14 @@ static int coroutine_fn stream_run(Job *job, Error =
**errp)
=20
         copy =3D false;
=20
-        ret =3D bdrv_is_allocated(bs, offset, STREAM_BUFFER_SIZE, &n);
+        ret =3D bdrv_is_allocated(unfiltered_bs, offset, STREAM_BUFFER_S=
IZE, &n);
         if (ret =3D=3D 1) {
             /* Allocated in the top, no need to copy.  */
         } else if (ret >=3D 0) {
             /* Copy if allocated in the intermediate images.  Limit to t=
he
              * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE=
).  */
-            ret =3D bdrv_is_allocated_above(backing_bs(bs), base,
-                                          offset, n, &n);
+            ret =3D bdrv_is_allocated_above(bdrv_filtered_cow_bs(unfilte=
red_bs),
+                                          filtered_base, offset, n, &n);
=20
             /* Finish early if end of backing file has been reached */
             if (ret =3D=3D 0 && n =3D=3D 0) {
@@ -266,7 +271,9 @@ void stream_start(const char *job_id, BlockDriverStat=
e *bs,
      * disappear from the chain after this operation. The streaming job =
reads
      * every block only once, assuming that it doesn't change, so block =
writes
      * and resizes. */
-    for (iter =3D backing_bs(bs); iter && iter !=3D base; iter =3D backi=
ng_bs(iter)) {
+    for (iter =3D bdrv_filtered_bs(bs); iter && iter !=3D base;
+         iter =3D bdrv_filtered_bs(iter))
+    {
         block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
                            BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNC=
HANGED,
                            &error_abort);
diff --git a/blockdev.c b/blockdev.c
index 5036d064d4..a464cabf9e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3235,7 +3235,7 @@ void qmp_block_stream(bool has_job_id, const char *=
job_id, const char *device,
     }
=20
     /* Check for op blockers in the whole chain between bs and base */
-    for (iter =3D bs; iter && iter !=3D base_bs; iter =3D backing_bs(ite=
r)) {
+    for (iter =3D bs; iter && iter !=3D base_bs; iter =3D bdrv_filtered_=
bs(iter)) {
         if (bdrv_op_is_blocked(iter, BLOCK_OP_TYPE_STREAM, errp)) {
             goto out;
         }
--=20
2.21.0



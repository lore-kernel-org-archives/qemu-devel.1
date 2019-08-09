Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71741C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1929320C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1929320C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7ht-00008E-A6
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57523)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7Y3-0003ST-7c
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7Y1-0004Xt-LE
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36373)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7Xy-0004Ue-8c; Fri, 09 Aug 2019 12:15:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 91805796ED;
 Fri,  9 Aug 2019 16:15:17 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6F445DC1E;
 Fri,  9 Aug 2019 16:15:16 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:53 +0200
Message-Id: <20190809161407.11920-29-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 09 Aug 2019 16:15:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 28/42] stream: Deal with filters
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

Because of the recent changes that make the stream job independent of
the base node and instead track the node above it, we have to split that
"bottom" node into two cases: The bottom COW node, and the node directly
above the base node (which may be an R/W filter or the bottom COW node).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json |  4 ++++
 block/stream.c       | 52 ++++++++++++++++++++++++++++----------------
 blockdev.c           |  2 +-
 3 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 38c4dbd7c3..3c54717870 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2516,6 +2516,10 @@
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
index 4c8b89884a..bd4a351dae 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -31,7 +31,8 @@ enum {
=20
 typedef struct StreamBlockJob {
     BlockJob common;
-    BlockDriverState *bottom;
+    BlockDriverState *bottom_cow_node;
+    BlockDriverState *above_base;
     BlockdevOnError on_error;
     char *backing_file_str;
     bool bs_read_only;
@@ -54,7 +55,7 @@ static void stream_abort(Job *job)
=20
     if (s->chain_frozen) {
         BlockJob *bjob =3D &s->common;
-        bdrv_unfreeze_chain(blk_bs(bjob->blk), s->bottom);
+        bdrv_unfreeze_chain(blk_bs(bjob->blk), s->above_base);
     }
 }
=20
@@ -63,14 +64,15 @@ static int stream_prepare(Job *job)
     StreamBlockJob *s =3D container_of(job, StreamBlockJob, common.job);
     BlockJob *bjob =3D &s->common;
     BlockDriverState *bs =3D blk_bs(bjob->blk);
-    BlockDriverState *base =3D backing_bs(s->bottom);
+    BlockDriverState *unfiltered_bs =3D bdrv_skip_rw_filters(bs);
+    BlockDriverState *base =3D bdrv_filtered_bs(s->above_base);
     Error *local_err =3D NULL;
     int ret =3D 0;
=20
-    bdrv_unfreeze_chain(bs, s->bottom);
+    bdrv_unfreeze_chain(bs, s->above_base);
     s->chain_frozen =3D false;
=20
-    if (bs->backing) {
+    if (bdrv_filtered_cow_child(unfiltered_bs)) {
         const char *base_id =3D NULL, *base_fmt =3D NULL;
         if (base) {
             base_id =3D s->backing_file_str;
@@ -78,8 +80,8 @@ static int stream_prepare(Job *job)
                 base_fmt =3D base->drv->format_name;
             }
         }
-        bdrv_set_backing_hd(bs, base, &local_err);
-        ret =3D bdrv_change_backing_file(bs, base_id, base_fmt);
+        bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
+        ret =3D bdrv_change_backing_file(unfiltered_bs, base_id, base_fm=
t);
         if (local_err) {
             error_report_err(local_err);
             return -EPERM;
@@ -110,7 +112,8 @@ static int coroutine_fn stream_run(Job *job, Error **=
errp)
     StreamBlockJob *s =3D container_of(job, StreamBlockJob, common.job);
     BlockBackend *blk =3D s->common.blk;
     BlockDriverState *bs =3D blk_bs(blk);
-    bool enable_cor =3D !backing_bs(s->bottom);
+    BlockDriverState *unfiltered_bs =3D bdrv_skip_rw_filters(bs);
+    bool enable_cor =3D !bdrv_filtered_bs(s->above_base);
     int64_t len;
     int64_t offset =3D 0;
     uint64_t delay_ns =3D 0;
@@ -119,7 +122,7 @@ static int coroutine_fn stream_run(Job *job, Error **=
errp)
     int64_t n =3D 0; /* bytes */
     void *buf;
=20
-    if (bs =3D=3D s->bottom) {
+    if (unfiltered_bs =3D=3D s->bottom_cow_node) {
         /* Nothing to stream */
         return 0;
     }
@@ -154,13 +157,14 @@ static int coroutine_fn stream_run(Job *job, Error =
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
-            ret =3D bdrv_is_allocated_above(backing_bs(bs), s->bottom, t=
rue,
+            ret =3D bdrv_is_allocated_above(bdrv_filtered_cow_bs(unfilte=
red_bs),
+                                          s->bottom_cow_node, true,
                                           offset, n, &n);
             /* Finish early if end of backing file has been reached */
             if (ret =3D=3D 0 && n =3D=3D 0) {
@@ -231,9 +235,16 @@ void stream_start(const char *job_id, BlockDriverSta=
te *bs,
     BlockDriverState *iter;
     bool bs_read_only;
     int basic_flags =3D BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHAN=
GED;
-    BlockDriverState *bottom =3D bdrv_find_overlay(bs, base);
+    BlockDriverState *bottom_cow_node =3D bdrv_find_overlay(bs, base);
+    BlockDriverState *above_base;
=20
-    if (bdrv_freeze_chain(bs, bottom, errp) < 0) {
+    /* Find the node directly above @base */
+    for (above_base =3D bottom_cow_node;
+         bdrv_filtered_bs(above_base) !=3D base;
+         above_base =3D bdrv_filtered_bs(above_base))
+    {}
+
+    if (bdrv_freeze_chain(bs, above_base, errp) < 0) {
         return;
     }
=20
@@ -261,16 +272,19 @@ void stream_start(const char *job_id, BlockDriverSt=
ate *bs,
      * disappear from the chain after this operation. The streaming job =
reads
      * every block only once, assuming that it doesn't change, so forbid=
 writes
      * and resizes. Reassign the base node pointer because the backing B=
S of the
-     * bottom node might change after the call to bdrv_reopen_set_read_o=
nly()
-     * due to parallel block jobs running.
+     * above_base node might change after the call to
+     * bdrv_reopen_set_read_only() due to parallel block jobs running.
      */
-    base =3D backing_bs(bottom);
-    for (iter =3D backing_bs(bs); iter && iter !=3D base; iter =3D backi=
ng_bs(iter)) {
+    base =3D bdrv_filtered_bs(above_base);
+    for (iter =3D bdrv_filtered_bs(bs); iter && iter !=3D base;
+         iter =3D bdrv_filtered_bs(iter))
+    {
         block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
                            basic_flags, &error_abort);
     }
=20
-    s->bottom =3D bottom;
+    s->bottom_cow_node =3D bottom_cow_node;
+    s->above_base =3D above_base;
     s->backing_file_str =3D g_strdup(backing_file_str);
     s->bs_read_only =3D bs_read_only;
     s->chain_frozen =3D true;
@@ -284,5 +298,5 @@ fail:
     if (bs_read_only) {
         bdrv_reopen_set_read_only(bs, true, NULL);
     }
-    bdrv_unfreeze_chain(bs, bottom);
+    bdrv_unfreeze_chain(bs, above_base);
 }
diff --git a/blockdev.c b/blockdev.c
index 7bef41c0b0..ee8b951154 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3297,7 +3297,7 @@ void qmp_block_stream(bool has_job_id, const char *=
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



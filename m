Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE4CC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 17:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B88FA21911
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 17:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88FA21911
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqKpt-00079b-Db
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 13:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49436)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hqKp0-0003go-C2
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 13:12:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hqKov-0004kN-OY
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 13:12:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34396)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hqKor-0004TU-UF; Wed, 24 Jul 2019 13:12:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3E1B53086262;
 Wed, 24 Jul 2019 17:12:49 +0000 (UTC)
Received: from localhost (ovpn-204-115.brq.redhat.com [10.40.204.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CCB75C22D;
 Wed, 24 Jul 2019 17:12:48 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 24 Jul 2019 19:12:30 +0200
Message-Id: <20190724171239.8764-3-mreitz@redhat.com>
In-Reply-To: <20190724171239.8764-1-mreitz@redhat.com>
References: <20190724171239.8764-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 24 Jul 2019 17:12:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 02/11] mirror: Fix bdrv_has_zero_init() use
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_has_zero_init() only has meaning for newly created images or image
areas.  If the mirror job itself did not create the image, it cannot
rely on bdrv_has_zero_init()'s result to carry any meaning.

This is the case for drive-mirror with mode=3Dexisting and always for
blockdev-mirror.

Note that we only have to zero-initialize the target with sync=3Dfull,
because other modes actually do not promise that the target will contain
the same data as the source after the job -- sync=3Dtop only promises to
copy anything allocated in the top layer, and sync=3Dnone will only copy
new I/O.  (Which is how mirror has always handled it.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h   |  2 ++
 block/mirror.c              | 11 ++++++++---
 blockdev.c                  | 16 +++++++++++++---
 tests/test-block-iothread.c |  2 +-
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 3aa1e832a8..6a0b1b5008 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1116,6 +1116,7 @@ BlockJob *commit_active_start(const char *job_id, B=
lockDriverState *bs,
  * @buf_size: The amount of data that can be in flight at one time.
  * @mode: Whether to collapse all images in the chain to the target.
  * @backing_mode: How to establish the target's backing chain after comp=
letion.
+ * @zero_target: Whether the target should be explicitly zero-initialize=
d
  * @on_source_error: The action to take upon error reading from the sour=
ce.
  * @on_target_error: The action to take upon error writing to the target=
.
  * @unmap: Whether to unmap target where source sectors only contain zer=
oes.
@@ -1135,6 +1136,7 @@ void mirror_start(const char *job_id, BlockDriverSt=
ate *bs,
                   int creation_flags, int64_t speed,
                   uint32_t granularity, int64_t buf_size,
                   MirrorSyncMode mode, BlockMirrorBackingMode backing_mo=
de,
+                  bool zero_target,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   bool unmap, const char *filter_node_name,
diff --git a/block/mirror.c b/block/mirror.c
index 8cb75fb409..50188ce6e9 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -51,6 +51,8 @@ typedef struct MirrorBlockJob {
     Error *replace_blocker;
     bool is_none_mode;
     BlockMirrorBackingMode backing_mode;
+    /* Whether the target image requires explicit zero-initialization */
+    bool zero_target;
     MirrorCopyMode copy_mode;
     BlockdevOnError on_source_error, on_target_error;
     bool synced;
@@ -763,7 +765,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlock=
Job *s)
     int ret;
     int64_t count;
=20
-    if (base =3D=3D NULL && !bdrv_has_zero_init(target_bs)) {
+    if (s->zero_target) {
         if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
             bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
             return 0;
@@ -1501,6 +1503,7 @@ static BlockJob *mirror_start_job(
                              const char *replaces, int64_t speed,
                              uint32_t granularity, int64_t buf_size,
                              BlockMirrorBackingMode backing_mode,
+                             bool zero_target,
                              BlockdevOnError on_source_error,
                              BlockdevOnError on_target_error,
                              bool unmap,
@@ -1628,6 +1631,7 @@ static BlockJob *mirror_start_job(
     s->on_target_error =3D on_target_error;
     s->is_none_mode =3D is_none_mode;
     s->backing_mode =3D backing_mode;
+    s->zero_target =3D zero_target;
     s->copy_mode =3D copy_mode;
     s->base =3D base;
     s->granularity =3D granularity;
@@ -1713,6 +1717,7 @@ void mirror_start(const char *job_id, BlockDriverSt=
ate *bs,
                   int creation_flags, int64_t speed,
                   uint32_t granularity, int64_t buf_size,
                   MirrorSyncMode mode, BlockMirrorBackingMode backing_mo=
de,
+                  bool zero_target,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   bool unmap, const char *filter_node_name,
@@ -1728,7 +1733,7 @@ void mirror_start(const char *job_id, BlockDriverSt=
ate *bs,
     is_none_mode =3D mode =3D=3D MIRROR_SYNC_MODE_NONE;
     base =3D mode =3D=3D MIRROR_SYNC_MODE_TOP ? backing_bs(bs) : NULL;
     mirror_start_job(job_id, bs, creation_flags, target, replaces,
-                     speed, granularity, buf_size, backing_mode,
+                     speed, granularity, buf_size, backing_mode, zero_ta=
rget,
                      on_source_error, on_target_error, unmap, NULL, NULL=
,
                      &mirror_job_driver, is_none_mode, base, false,
                      filter_node_name, true, copy_mode, errp);
@@ -1755,7 +1760,7 @@ BlockJob *commit_active_start(const char *job_id, B=
lockDriverState *bs,
=20
     ret =3D mirror_start_job(
                      job_id, bs, creation_flags, base, NULL, speed, 0, 0=
,
-                     MIRROR_LEAVE_BACKING_CHAIN,
+                     MIRROR_LEAVE_BACKING_CHAIN, false,
                      on_error, on_error, true, cb, opaque,
                      &commit_active_job_driver, false, base, auto_comple=
te,
                      filter_node_name, false, MIRROR_COPY_MODE_BACKGROUN=
D,
diff --git a/blockdev.c b/blockdev.c
index 4d141e9a1f..0323f77850 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3705,6 +3705,7 @@ static void blockdev_mirror_common(const char *job_=
id, BlockDriverState *bs,
                                    bool has_replaces, const char *replac=
es,
                                    enum MirrorSyncMode sync,
                                    BlockMirrorBackingMode backing_mode,
+                                   bool zero_target,
                                    bool has_speed, int64_t speed,
                                    bool has_granularity, uint32_t granul=
arity,
                                    bool has_buf_size, int64_t buf_size,
@@ -3813,7 +3814,7 @@ static void blockdev_mirror_common(const char *job_=
id, BlockDriverState *bs,
      */
     mirror_start(job_id, bs, target,
                  has_replaces ? replaces : NULL, job_flags,
-                 speed, granularity, buf_size, sync, backing_mode,
+                 speed, granularity, buf_size, sync, backing_mode, zero_=
target,
                  on_source_error, on_target_error, unmap, filter_node_na=
me,
                  copy_mode, errp);
 }
@@ -3829,6 +3830,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
     int flags;
     int64_t size;
     const char *format =3D arg->format;
+    bool zero_target;
     int ret;
=20
     bs =3D qmp_get_root_bs(arg->device, errp);
@@ -3930,6 +3932,10 @@ void qmp_drive_mirror(DriveMirror *arg, Error **er=
rp)
         goto out;
     }
=20
+    zero_target =3D (arg->sync =3D=3D MIRROR_SYNC_MODE_FULL &&
+                   (arg->mode =3D=3D NEW_IMAGE_MODE_EXISTING ||
+                    !bdrv_has_zero_init(target_bs)));
+
     ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
     if (ret < 0) {
         bdrv_unref(target_bs);
@@ -3938,7 +3944,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
=20
     blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, tar=
get_bs,
                            arg->has_replaces, arg->replaces, arg->sync,
-                           backing_mode, arg->has_speed, arg->speed,
+                           backing_mode, zero_target,
+                           arg->has_speed, arg->speed,
                            arg->has_granularity, arg->granularity,
                            arg->has_buf_size, arg->buf_size,
                            arg->has_on_source_error, arg->on_source_erro=
r,
@@ -3978,6 +3985,7 @@ void qmp_blockdev_mirror(bool has_job_id, const cha=
r *job_id,
     AioContext *aio_context;
     BlockMirrorBackingMode backing_mode =3D MIRROR_LEAVE_BACKING_CHAIN;
     Error *local_err =3D NULL;
+    bool zero_target;
     int ret;
=20
     bs =3D qmp_get_root_bs(device, errp);
@@ -3990,6 +3998,8 @@ void qmp_blockdev_mirror(bool has_job_id, const cha=
r *job_id,
         return;
     }
=20
+    zero_target =3D (sync =3D=3D MIRROR_SYNC_MODE_FULL);
+
     aio_context =3D bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
=20
@@ -4000,7 +4010,7 @@ void qmp_blockdev_mirror(bool has_job_id, const cha=
r *job_id,
=20
     blockdev_mirror_common(has_job_id ? job_id : NULL, bs, target_bs,
                            has_replaces, replaces, sync, backing_mode,
-                           has_speed, speed,
+                           zero_target, has_speed, speed,
                            has_granularity, granularity,
                            has_buf_size, buf_size,
                            has_on_source_error, on_source_error,
diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index 1949d5e61a..debfb69bfb 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -611,7 +611,7 @@ static void test_propagate_mirror(void)
=20
     /* Start a mirror job */
     mirror_start("job0", src, target, NULL, JOB_DEFAULT, 0, 0, 0,
-                 MIRROR_SYNC_MODE_NONE, MIRROR_OPEN_BACKING_CHAIN,
+                 MIRROR_SYNC_MODE_NONE, MIRROR_OPEN_BACKING_CHAIN, false=
,
                  BLOCKDEV_ON_ERROR_REPORT, BLOCKDEV_ON_ERROR_REPORT,
                  false, "filter_node", MIRROR_COPY_MODE_BACKGROUND,
                  &error_abort);
--=20
2.21.0



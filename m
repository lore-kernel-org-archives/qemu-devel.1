Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A46C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D72022CE9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D72022CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzkOE-0004lt-0Q
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 12:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hzkLl-0002nS-V8
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hzkLk-0006Gd-9n
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:17:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54882)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hzkLg-0006Ea-RY; Mon, 19 Aug 2019 12:17:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31D92317528A;
 Mon, 19 Aug 2019 16:17:36 +0000 (UTC)
Received: from localhost (ovpn-204-64.brq.redhat.com [10.40.204.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 12E4790F48;
 Mon, 19 Aug 2019 16:17:33 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 19 Aug 2019 18:17:09 +0200
Message-Id: <20190819161723.7746-4-mreitz@redhat.com>
In-Reply-To: <20190819161723.7746-1-mreitz@redhat.com>
References: <20190819161723.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 19 Aug 2019 16:17:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/17] mirror: Fix bdrv_has_zero_init() use
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
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
Message-id: 20190724171239.8764-3-mreitz@redhat.com
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h   |  2 ++
 block/mirror.c              | 11 ++++++++---
 blockdev.c                  | 16 +++++++++++++---
 tests/test-block-iothread.c |  2 +-
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index aa697f1f69..8fa011654a 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1115,6 +1115,7 @@ BlockJob *commit_active_start(const char *job_id, B=
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
@@ -1134,6 +1135,7 @@ void mirror_start(const char *job_id, BlockDriverSt=
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
index 2b870683f1..853e2c7510 100644
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
@@ -767,7 +769,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlock=
Job *s)
     int ret;
     int64_t count;
=20
-    if (base =3D=3D NULL && !bdrv_has_zero_init(target_bs)) {
+    if (s->zero_target) {
         if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
             bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
             return 0;
@@ -1515,6 +1517,7 @@ static BlockJob *mirror_start_job(
                              const char *replaces, int64_t speed,
                              uint32_t granularity, int64_t buf_size,
                              BlockMirrorBackingMode backing_mode,
+                             bool zero_target,
                              BlockdevOnError on_source_error,
                              BlockdevOnError on_target_error,
                              bool unmap,
@@ -1643,6 +1646,7 @@ static BlockJob *mirror_start_job(
     s->on_target_error =3D on_target_error;
     s->is_none_mode =3D is_none_mode;
     s->backing_mode =3D backing_mode;
+    s->zero_target =3D zero_target;
     s->copy_mode =3D copy_mode;
     s->base =3D base;
     s->granularity =3D granularity;
@@ -1747,6 +1751,7 @@ void mirror_start(const char *job_id, BlockDriverSt=
ate *bs,
                   int creation_flags, int64_t speed,
                   uint32_t granularity, int64_t buf_size,
                   MirrorSyncMode mode, BlockMirrorBackingMode backing_mo=
de,
+                  bool zero_target,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   bool unmap, const char *filter_node_name,
@@ -1764,7 +1769,7 @@ void mirror_start(const char *job_id, BlockDriverSt=
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
@@ -1791,7 +1796,7 @@ BlockJob *commit_active_start(const char *job_id, B=
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
index 2e536dde3e..fbef6845c8 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3782,6 +3782,7 @@ static void blockdev_mirror_common(const char *job_=
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
@@ -3890,7 +3891,7 @@ static void blockdev_mirror_common(const char *job_=
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
@@ -3906,6 +3907,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
     int flags;
     int64_t size;
     const char *format =3D arg->format;
+    bool zero_target;
     int ret;
=20
     bs =3D qmp_get_root_bs(arg->device, errp);
@@ -4007,6 +4009,10 @@ void qmp_drive_mirror(DriveMirror *arg, Error **er=
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
@@ -4015,7 +4021,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
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
@@ -4055,6 +4062,7 @@ void qmp_blockdev_mirror(bool has_job_id, const cha=
r *job_id,
     AioContext *aio_context;
     BlockMirrorBackingMode backing_mode =3D MIRROR_LEAVE_BACKING_CHAIN;
     Error *local_err =3D NULL;
+    bool zero_target;
     int ret;
=20
     bs =3D qmp_get_root_bs(device, errp);
@@ -4067,6 +4075,8 @@ void qmp_blockdev_mirror(bool has_job_id, const cha=
r *job_id,
         return;
     }
=20
+    zero_target =3D (sync =3D=3D MIRROR_SYNC_MODE_FULL);
+
     aio_context =3D bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
=20
@@ -4077,7 +4087,7 @@ void qmp_blockdev_mirror(bool has_job_id, const cha=
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
index e81b5b8dc4..926577b1f9 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -612,7 +612,7 @@ static void test_propagate_mirror(void)
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



Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CD3C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB3C2175B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB3C2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40004 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTqHb-0002HR-M5
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 12:09:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hTqAC-0004N5-E6
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hTqA8-0001xm-Ax
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:01:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2183)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hTq9v-0001fG-Gn; Thu, 23 May 2019 12:01:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C30A811DE;
	Thu, 23 May 2019 16:01:20 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-143.ams2.redhat.com
	[10.36.116.143])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1E6CB1001E84;
	Thu, 23 May 2019 16:01:18 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 23 May 2019 18:00:51 +0200
Message-Id: <20190523160104.21258-3-kwolf@redhat.com>
In-Reply-To: <20190523160104.21258-1-kwolf@redhat.com>
References: <20190523160104.21258-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 23 May 2019 16:01:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 02/15] block: Add Error to blk_set_aio_context()
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an Error parameter to blk_set_aio_context() and use
bdrv_child_try_set_aio_context() internally to check whether all
involved nodes can actually support the AioContext switch.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/sysemu/block-backend.h  |  3 ++-
 block/block-backend.c           | 26 ++++++++++++++++----------
 hw/block/dataplane/virtio-blk.c | 12 +++++++++---
 hw/block/dataplane/xen-block.c  |  6 ++++--
 hw/scsi/virtio-scsi.c           | 10 +++++++---
 tests/test-bdrv-drain.c         |  8 ++++----
 tests/test-block-iothread.c     | 22 +++++++++++-----------
 7 files changed, 53 insertions(+), 34 deletions(-)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backen=
d.h
index 938de34fe9..228fb3fb83 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -208,7 +208,8 @@ void blk_op_unblock(BlockBackend *blk, BlockOpType op=
, Error *reason);
 void blk_op_block_all(BlockBackend *blk, Error *reason);
 void blk_op_unblock_all(BlockBackend *blk, Error *reason);
 AioContext *blk_get_aio_context(BlockBackend *blk);
-void blk_set_aio_context(BlockBackend *blk, AioContext *new_context);
+int blk_set_aio_context(BlockBackend *blk, AioContext *new_context,
+                        Error **errp);
 void blk_add_aio_context_notifier(BlockBackend *blk,
         void (*attached_aio_context)(AioContext *new_context, void *opaq=
ue),
         void (*detach_aio_context)(void *opaque), void *opaque);
diff --git a/block/block-backend.c b/block/block-backend.c
index 4c0a8ef88d..dfb6bf017a 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1866,30 +1866,36 @@ static AioContext *blk_aiocb_get_aio_context(Bloc=
kAIOCB *acb)
     return blk_get_aio_context(blk_acb->blk);
 }
=20
-static void blk_do_set_aio_context(BlockBackend *blk, AioContext *new_co=
ntext,
-                                   bool update_root_node)
+static int blk_do_set_aio_context(BlockBackend *blk, AioContext *new_con=
text,
+                                  bool update_root_node, Error **errp)
 {
     BlockDriverState *bs =3D blk_bs(blk);
     ThrottleGroupMember *tgm =3D &blk->public.throttle_group_member;
+    int ret;
=20
     if (bs) {
+        if (update_root_node) {
+            ret =3D bdrv_child_try_set_aio_context(bs, new_context, blk-=
>root,
+                                                 errp);
+            if (ret < 0) {
+                return ret;
+            }
+        }
         if (tgm->throttle_state) {
             bdrv_drained_begin(bs);
             throttle_group_detach_aio_context(tgm);
             throttle_group_attach_aio_context(tgm, new_context);
             bdrv_drained_end(bs);
         }
-        if (update_root_node) {
-            GSList *ignore =3D g_slist_prepend(NULL, blk->root);
-            bdrv_set_aio_context_ignore(bs, new_context, &ignore);
-            g_slist_free(ignore);
-        }
     }
+
+    return 0;
 }
=20
-void blk_set_aio_context(BlockBackend *blk, AioContext *new_context)
+int blk_set_aio_context(BlockBackend *blk, AioContext *new_context,
+                        Error **errp)
 {
-    blk_do_set_aio_context(blk, new_context, true);
+    return blk_do_set_aio_context(blk, new_context, true, errp);
 }
=20
 static bool blk_root_can_set_aio_ctx(BdrvChild *child, AioContext *ctx,
@@ -1916,7 +1922,7 @@ static void blk_root_set_aio_ctx(BdrvChild *child, =
AioContext *ctx,
                                  GSList **ignore)
 {
     BlockBackend *blk =3D child->opaque;
-    blk_do_set_aio_context(blk, ctx, false);
+    blk_do_set_aio_context(blk, ctx, false, &error_abort);
 }
=20
 void blk_add_aio_context_notifier(BlockBackend *blk,
diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-=
blk.c
index 8c37bd314a..158c78f852 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -173,6 +173,7 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
     VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
     unsigned i;
     unsigned nvqs =3D s->conf->num_queues;
+    Error *local_err =3D NULL;
     int r;
=20
     if (vblk->dataplane_started || s->starting) {
@@ -212,7 +213,11 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
     vblk->dataplane_started =3D true;
     trace_virtio_blk_data_plane_start(s);
=20
-    blk_set_aio_context(s->conf->conf.blk, s->ctx);
+    r =3D blk_set_aio_context(s->conf->conf.blk, s->ctx, &local_err);
+    if (r < 0) {
+        error_report_err(local_err);
+        goto fail_guest_notifiers;
+    }
=20
     /* Kick right away to begin processing requests already in vring */
     for (i =3D 0; i < nvqs; i++) {
@@ -281,8 +286,9 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
     aio_context_acquire(s->ctx);
     aio_wait_bh_oneshot(s->ctx, virtio_blk_data_plane_stop_bh, s);
=20
-    /* Drain and switch bs back to the QEMU main loop */
-    blk_set_aio_context(s->conf->conf.blk, qemu_get_aio_context());
+    /* Drain and try to switch bs back to the QEMU main loop. If other u=
sers
+     * keep the BlockBackend in the iothread, that's ok */
+    blk_set_aio_context(s->conf->conf.blk, qemu_get_aio_context(), NULL)=
;
=20
     aio_context_release(s->ctx);
=20
diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-bloc=
k.c
index bb8f1186e4..f7ad452bbd 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -682,7 +682,8 @@ void xen_block_dataplane_stop(XenBlockDataPlane *data=
plane)
     }
=20
     aio_context_acquire(dataplane->ctx);
-    blk_set_aio_context(dataplane->blk, qemu_get_aio_context());
+    /* Xen doesn't have multiple users for nodes, so this can't fail */
+    blk_set_aio_context(dataplane->blk, qemu_get_aio_context(), &error_a=
bort);
     aio_context_release(dataplane->ctx);
=20
     xendev =3D dataplane->xendev;
@@ -811,7 +812,8 @@ void xen_block_dataplane_start(XenBlockDataPlane *dat=
aplane,
     }
=20
     aio_context_acquire(dataplane->ctx);
-    blk_set_aio_context(dataplane->blk, dataplane->ctx);
+    /* If other users keep the BlockBackend in the iothread, that's ok *=
/
+    blk_set_aio_context(dataplane->blk, dataplane->ctx, NULL);
     aio_context_release(dataplane->ctx);
     return;
=20
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 839f120256..01c2b85f90 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -795,6 +795,7 @@ static void virtio_scsi_hotplug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
     VirtIODevice *vdev =3D VIRTIO_DEVICE(hotplug_dev);
     VirtIOSCSI *s =3D VIRTIO_SCSI(vdev);
     SCSIDevice *sd =3D SCSI_DEVICE(dev);
+    int ret;
=20
     if (s->ctx && !s->dataplane_fenced) {
         AioContext *ctx;
@@ -808,9 +809,11 @@ static void virtio_scsi_hotplug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
             return;
         }
         virtio_scsi_acquire(s);
-        blk_set_aio_context(sd->conf.blk, s->ctx);
+        ret =3D blk_set_aio_context(sd->conf.blk, s->ctx, errp);
         virtio_scsi_release(s);
-
+        if (ret < 0) {
+            return;
+        }
     }
=20
     if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
@@ -839,7 +842,8 @@ static void virtio_scsi_hotunplug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
=20
     if (s->ctx) {
         virtio_scsi_acquire(s);
-        blk_set_aio_context(sd->conf.blk, qemu_get_aio_context());
+        /* If other users keep the BlockBackend in the iothread, that's =
ok */
+        blk_set_aio_context(sd->conf.blk, qemu_get_aio_context(), NULL);
         virtio_scsi_release(s);
     }
=20
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index eda90750eb..6d5565e8e7 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -678,7 +678,7 @@ static void test_iothread_common(enum drain_type drai=
n_type, int drain_thread)
     s =3D bs->opaque;
     blk_insert_bs(blk, bs, &error_abort);
=20
-    blk_set_aio_context(blk, ctx_a);
+    blk_set_aio_context(blk, ctx_a, &error_abort);
     aio_context_acquire(ctx_a);
=20
     s->bh_indirection_ctx =3D ctx_b;
@@ -742,7 +742,7 @@ static void test_iothread_common(enum drain_type drai=
n_type, int drain_thread)
     }
=20
     aio_context_acquire(ctx_a);
-    blk_set_aio_context(blk, qemu_get_aio_context());
+    blk_set_aio_context(blk, qemu_get_aio_context(), &error_abort);
     aio_context_release(ctx_a);
=20
     bdrv_unref(bs);
@@ -903,7 +903,7 @@ static void test_blockjob_common_drain_node(enum drai=
n_type drain_type,
     if (use_iothread) {
         iothread =3D iothread_new();
         ctx =3D iothread_get_aio_context(iothread);
-        blk_set_aio_context(blk_src, ctx);
+        blk_set_aio_context(blk_src, ctx, &error_abort);
     } else {
         ctx =3D qemu_get_aio_context();
     }
@@ -1001,7 +1001,7 @@ static void test_blockjob_common_drain_node(enum dr=
ain_type drain_type,
     g_assert_cmpint(ret, =3D=3D, (result =3D=3D TEST_JOB_SUCCESS ? 0 : -=
EIO));
=20
     if (use_iothread) {
-        blk_set_aio_context(blk_src, qemu_get_aio_context());
+        blk_set_aio_context(blk_src, qemu_get_aio_context(), &error_abor=
t);
     }
     aio_context_release(ctx);
=20
diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index e424d360c8..1d47ea9895 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -342,14 +342,14 @@ static void test_sync_op(const void *opaque)
     blk_insert_bs(blk, bs, &error_abort);
     c =3D QLIST_FIRST(&bs->parents);
=20
-    blk_set_aio_context(blk, ctx);
+    blk_set_aio_context(blk, ctx, &error_abort);
     aio_context_acquire(ctx);
     t->fn(c);
     if (t->blkfn) {
         t->blkfn(blk);
     }
     aio_context_release(ctx);
-    blk_set_aio_context(blk, qemu_get_aio_context());
+    blk_set_aio_context(blk, qemu_get_aio_context(), &error_abort);
=20
     bdrv_unref(bs);
     blk_unref(blk);
@@ -428,7 +428,7 @@ static void test_attach_blockjob(void)
         aio_poll(qemu_get_aio_context(), false);
     }
=20
-    blk_set_aio_context(blk, ctx);
+    blk_set_aio_context(blk, ctx, &error_abort);
=20
     tjob->n =3D 0;
     while (tjob->n =3D=3D 0) {
@@ -436,7 +436,7 @@ static void test_attach_blockjob(void)
     }
=20
     aio_context_acquire(ctx);
-    blk_set_aio_context(blk, qemu_get_aio_context());
+    blk_set_aio_context(blk, qemu_get_aio_context(), &error_abort);
     aio_context_release(ctx);
=20
     tjob->n =3D 0;
@@ -444,7 +444,7 @@ static void test_attach_blockjob(void)
         aio_poll(qemu_get_aio_context(), false);
     }
=20
-    blk_set_aio_context(blk, ctx);
+    blk_set_aio_context(blk, ctx, &error_abort);
=20
     tjob->n =3D 0;
     while (tjob->n =3D=3D 0) {
@@ -453,7 +453,7 @@ static void test_attach_blockjob(void)
=20
     aio_context_acquire(ctx);
     job_complete_sync(&tjob->common.job, &error_abort);
-    blk_set_aio_context(blk, qemu_get_aio_context());
+    blk_set_aio_context(blk, qemu_get_aio_context(), &error_abort);
     aio_context_release(ctx);
=20
     bdrv_unref(bs);
@@ -497,7 +497,7 @@ static void test_propagate_basic(void)
     bs_verify =3D bdrv_open(NULL, NULL, options, BDRV_O_RDWR, &error_abo=
rt);
=20
     /* Switch the AioContext */
-    blk_set_aio_context(blk, ctx);
+    blk_set_aio_context(blk, ctx, &error_abort);
     g_assert(blk_get_aio_context(blk) =3D=3D ctx);
     g_assert(bdrv_get_aio_context(bs_a) =3D=3D ctx);
     g_assert(bdrv_get_aio_context(bs_verify) =3D=3D ctx);
@@ -505,7 +505,7 @@ static void test_propagate_basic(void)
=20
     /* Switch the AioContext back */
     ctx =3D qemu_get_aio_context();
-    blk_set_aio_context(blk, ctx);
+    blk_set_aio_context(blk, ctx, &error_abort);
     g_assert(blk_get_aio_context(blk) =3D=3D ctx);
     g_assert(bdrv_get_aio_context(bs_a) =3D=3D ctx);
     g_assert(bdrv_get_aio_context(bs_verify) =3D=3D ctx);
@@ -565,7 +565,7 @@ static void test_propagate_diamond(void)
     blk_insert_bs(blk, bs_verify, &error_abort);
=20
     /* Switch the AioContext */
-    blk_set_aio_context(blk, ctx);
+    blk_set_aio_context(blk, ctx, &error_abort);
     g_assert(blk_get_aio_context(blk) =3D=3D ctx);
     g_assert(bdrv_get_aio_context(bs_verify) =3D=3D ctx);
     g_assert(bdrv_get_aio_context(bs_a) =3D=3D ctx);
@@ -574,7 +574,7 @@ static void test_propagate_diamond(void)
=20
     /* Switch the AioContext back */
     ctx =3D qemu_get_aio_context();
-    blk_set_aio_context(blk, ctx);
+    blk_set_aio_context(blk, ctx, &error_abort);
     g_assert(blk_get_aio_context(blk) =3D=3D ctx);
     g_assert(bdrv_get_aio_context(bs_verify) =3D=3D ctx);
     g_assert(bdrv_get_aio_context(bs_a) =3D=3D ctx);
@@ -654,7 +654,7 @@ static void test_propagate_mirror(void)
     job_cancel_sync_all();
=20
     aio_context_acquire(ctx);
-    blk_set_aio_context(blk, main_ctx);
+    blk_set_aio_context(blk, main_ctx, &error_abort);
     bdrv_try_set_aio_context(target, main_ctx, &error_abort);
     aio_context_release(ctx);
=20
--=20
2.20.1



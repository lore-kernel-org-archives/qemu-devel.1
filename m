Received: from eggs.gnu.org ([2001:4830:134:3::10]:39459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coxXa-0000XP-DW
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 15:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coxXW-0004hQ-Dt
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 15:27:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1coxXW-0004fp-3a
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 15:27:54 -0400
References: <CAO_EM_kn4QEw=+j23F7e+LzLW2_TPwNENoopqyBb-hdKYAow9w@mail.gmail.com>
	<f8f478b3-70a0-b67b-c4df-3f68ac66308a@redhat.com>
	<d54e7c6e-d261-dff0-9038-8f62283c91a4@redhat.com>
	<CAO_EM_=8-nnrz+BygPUnhkgrrRzYiPwE=ji7ncUXyHwZxVkAkw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a98bb8fd-c087-5cb2-92bc-76f255330e3d@redhat.com>
Date: Fri, 17 Mar 2017 20:27:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAO_EM_=8-nnrz+BygPUnhkgrrRzYiPwE=ji7ncUXyHwZxVkAkw@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------61F7B9849A7CE6047F005289"
Subject: Re: [Qemu-devel] Assertion failure taking external snapshot with
 virtio drive + iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is a multi-part message in MIME format.
--------------61F7B9849A7CE6047F005289
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 17/03/2017 18:32, Ed Swierk wrote:
> On Fri, Mar 17, 2017 at 10:15 AM, Paolo Bonzini <pbonzini@redhat.com> w=
rote:
>>
>>
>> On 17/03/2017 18:11, Paolo Bonzini wrote:
>>>
>>>
>>> On 17/03/2017 17:55, Ed Swierk wrote:
>>>> I'm running into the same problem taking an external snapshot with a
>>>> virtio-blk drive with iothread, so it's not specific to virtio-scsi.
>>>> Run a Linux guest on qemu master
>>>>
>>>>   qemu-system-x86_64 -nographic -enable-kvm -monitor
>>>> telnet:0.0.0.0:1234,server,nowait -m 1024 -object
>>>> iothread,id=3Diothread1 -drive file=3D/x/drive.qcow2,if=3Dnone,id=3D=
drive0
>>>> -device virtio-blk-pci,iothread=3Diothread1,drive=3Ddrive0
>>>>
>>>> Then in the monitor
>>>>
>>>>   snapshot_blkdev drive0 /x/snap1.qcow2
>>>>
>>>> qemu bombs with
>>>>
>>>>   qemu-system-x86_64: /x/qemu/include/block/aio.h:457:
>>>> aio_enable_external: Assertion `ctx->external_disable_cnt > 0' faile=
d.
>>>>
>>>> whereas without the iothread the assertion failure does not occur.
>>>
>>> Please try this patch:
>>
>> Hmm, no.  I'll post the full fix on top of John Snow's patches.
>=20
> OK. Incidentally, testing with virtio-blk I bisected the assertion
> failure to b2c2832c6140cfe3ddc0de2d77eeb0b77dea8fd3 ("block: Add Error
> parameter to bdrv_append()").

And this is a fix, but I have no idea why/how it works and what else it=20
may break.

Patches 1 and 2 are pretty obvious and would be the first step towards=20
eliminating aio_disable/enable_external altogether.

However I got patch 3 more or less by trial and error, and when I=20
thought I had the reasoning right I noticed this:

        bdrv_drained_end(state->old_bs);

in external_snapshot_clean which makes no sense given the

        bdrv_drained_begin(bs_new);

that I added to bdrv_append.  So take this with a ton of salt.

The basic idea is that calling child->role->drained_begin and=20
child->role->drained_end is not necessary and in fact actively wrong=20
when both the old and the new child should be in a drained section. =20
But maybe instead it should be asserted that they are, except for the=20
special case of adding or removing a child.  i.e. after

    int drain =3D !!(old_bs && old_bs->quiesce_counter) - !!(new_bs && ne=
w_bs->quiesce_counter);

add

    assert(!(drain && old_bs && new_bs));

Throwing this out because it's Friday evening... Maybe Fam can pick
it up on Monday.

Paolo

--------------61F7B9849A7CE6047F005289
Content-Type: text/x-patch;
 name="ff.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="ff.patch"

=46rom f399388896c49fae4fd3f4837520d58b704c024a Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 17 Mar 2017 19:05:44 +0100
Subject: [PATCH 1/3] scsi: add drained_begin/drained_end callbacks to bus=


Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c     | 14 ++++++++++++++
 hw/scsi/scsi-disk.c    | 24 ++++++++++++++++++++++++
 include/hw/scsi/scsi.h |  5 +++++
 3 files changed, 43 insertions(+)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index f557446..fcad82b 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -97,6 +97,20 @@ void scsi_bus_new(SCSIBus *bus, size_t bus_size, Devic=
eState *host,
     qbus_set_bus_hotplug_handler(BUS(bus), &error_abort);
 }
=20
+void scsi_bus_drained_begin(SCSIBus *bus)
+{
+    if (bus->info->drained_begin) {
+        bus->info->drained_begin(bus);
+    }
+}
+
+void scsi_bus_drained_end(SCSIBus *bus)
+{
+    if (bus->info->drained_end) {
+        bus->info->drained_end(bus);
+    }
+}
+
 static void scsi_dma_restart_bh(void *opaque)
 {
     SCSIDevice *s =3D opaque;
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a53f058..faca77c 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2281,6 +2281,24 @@ static bool scsi_cd_is_medium_locked(void *opaque)=

     return ((SCSIDiskState *)opaque)->tray_locked;
 }
=20
+static void scsi_disk_drained_begin(void *opaque)
+{
+    SCSIDiskState *s =3D opaque;
+    SCSIDevice *sdev =3D SCSI_DEVICE(s);
+    SCSIBus *bus =3D DO_UPCAST(SCSIBus, qbus, sdev->qdev.parent_bus);
+
+    scsi_bus_drained_begin(bus);
+}
+
+static void scsi_disk_drained_end(void *opaque)
+{
+    SCSIDiskState *s =3D opaque;
+    SCSIDevice *sdev =3D SCSI_DEVICE(s);
+    SCSIBus *bus =3D DO_UPCAST(SCSIBus, qbus, sdev->qdev.parent_bus);
+
+    scsi_bus_drained_end(bus);
+}
+
 static const BlockDevOps scsi_disk_removable_block_ops =3D {
     .change_media_cb =3D scsi_cd_change_media_cb,
     .eject_request_cb =3D scsi_cd_eject_request_cb,
@@ -2288,10 +2306,16 @@ static const BlockDevOps scsi_disk_removable_bloc=
k_ops =3D {
     .is_medium_locked =3D scsi_cd_is_medium_locked,
=20
     .resize_cb =3D scsi_disk_resize_cb,
+
+    .drained_begin =3D scsi_disk_drained_begin,
+    .drained_end =3D scsi_disk_drained_end,
 };
=20
 static const BlockDevOps scsi_disk_block_ops =3D {
     .resize_cb =3D scsi_disk_resize_cb,
+
+    .drained_begin =3D scsi_disk_drained_begin,
+    .drained_end =3D scsi_disk_drained_end,
 };
=20
 static void scsi_disk_unit_attention_reported(SCSIDevice *dev)
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 6b85786..915c1bb 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -153,6 +153,9 @@ struct SCSIBusInfo {
     void (*save_request)(QEMUFile *f, SCSIRequest *req);
     void *(*load_request)(QEMUFile *f, SCSIRequest *req);
     void (*free_request)(SCSIBus *bus, void *priv);
+
+    void (*drained_begin)(SCSIBus *bus);
+    void (*drained_end)(SCSIBus *bus);
 };
=20
 #define TYPE_SCSI_BUS "SCSI"
@@ -257,6 +260,8 @@ void scsi_req_unref(SCSIRequest *req);
=20
 int scsi_bus_parse_cdb(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
                        void *hba_private);
+void scsi_bus_drained_begin(SCSIBus *bus);
+void scsi_bus_drained_end(SCSIBus *bus);
 int scsi_req_parse_cdb(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf);=

 void scsi_req_build_sense(SCSIRequest *req, SCSISense sense);
 void scsi_req_print(SCSIRequest *req);
--=20
2.9.3


=46rom b150bf792721b6bbd652aa9017ffde083a075a0d Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 17 Mar 2017 18:31:41 +0100
Subject: [PATCH 2/3] block: move aio_disable_external/aio_enable_external=
 to
 virtio devices

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c            |  4 ----
 hw/block/virtio-blk.c | 16 ++++++++++++++++
 hw/scsi/virtio-scsi.c | 19 +++++++++++++++++++
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index 2709a70..d6c19f9 100644
--- a/block/io.c
+++ b/block/io.c
@@ -224,7 +224,6 @@ void bdrv_drained_begin(BlockDriverState *bs)
     }
=20
     if (!bs->quiesce_counter++) {
-        aio_disable_external(bdrv_get_aio_context(bs));
         bdrv_parent_drained_begin(bs);
     }
=20
@@ -239,7 +238,6 @@ void bdrv_drained_end(BlockDriverState *bs)
     }
=20
     bdrv_parent_drained_end(bs);
-    aio_enable_external(bdrv_get_aio_context(bs));
 }
=20
 /*
@@ -300,7 +298,6 @@ void bdrv_drain_all_begin(void)
=20
         aio_context_acquire(aio_context);
         bdrv_parent_drained_begin(bs);
-        aio_disable_external(aio_context);
         aio_context_release(aio_context);
=20
         if (!g_slist_find(aio_ctxs, aio_context)) {
@@ -343,7 +340,6 @@ void bdrv_drain_all_end(void)
         AioContext *aio_context =3D bdrv_get_aio_context(bs);
=20
         aio_context_acquire(aio_context);
-        aio_enable_external(aio_context);
         bdrv_parent_drained_end(bs);
         aio_context_release(aio_context);
     }
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 98c16a7..de061c0 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -902,7 +902,23 @@ static void virtio_blk_resize(void *opaque)
     virtio_notify_config(vdev);
 }
=20
+static void virtio_blk_drained_begin(void *opaque)
+{
+    VirtIOBlock *s =3D VIRTIO_BLK(opaque);
+
+    aio_disable_external(blk_get_aio_context(s->conf.conf.blk));
+}
+
+static void virtio_blk_drained_end(void *opaque)
+{
+    VirtIOBlock *s =3D VIRTIO_BLK(opaque);
+
+    aio_enable_external(blk_get_aio_context(s->conf.conf.blk));
+}
+
 static const BlockDevOps virtio_block_ops =3D {
+    .drained_begin =3D virtio_blk_drained_begin,
+    .drained_end =3D virtio_blk_drained_end,
     .resize_cb =3D virtio_blk_resize,
 };
=20
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index bd62d08..788d36a 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -826,6 +826,22 @@ static void virtio_scsi_hotunplug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
     qdev_simple_device_unplug_cb(hotplug_dev, dev, errp);
 }
=20
+static void virtio_scsi_drained_begin(SCSIBus *bus)
+{
+    VirtIOSCSI *s =3D container_of(bus, VirtIOSCSI, bus);
+    if (s->ctx) {
+        aio_disable_external(s->ctx);
+    }
+}
+
+static void virtio_scsi_drained_end(SCSIBus *bus)
+{
+    VirtIOSCSI *s =3D container_of(bus, VirtIOSCSI, bus);
+    if (s->ctx) {
+        aio_enable_external(s->ctx);
+    }
+}
+
 static struct SCSIBusInfo virtio_scsi_scsi_info =3D {
     .tcq =3D true,
     .max_channel =3D VIRTIO_SCSI_MAX_CHANNEL,
@@ -839,6 +855,9 @@ static struct SCSIBusInfo virtio_scsi_scsi_info =3D {=

     .get_sg_list =3D virtio_scsi_get_sg_list,
     .save_request =3D virtio_scsi_save_request,
     .load_request =3D virtio_scsi_load_request,
+
+    .drained_begin =3D virtio_scsi_drained_begin,
+    .drained_end =3D virtio_scsi_drained_end,
 };
=20
 void virtio_scsi_common_realize(DeviceState *dev, Error **errp,
--=20
2.9.3


=46rom ba29c0d2665f88f9ba158da424f3d9bdca56062b Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 17 Mar 2017 18:31:15 +0100
Subject: [PATCH 3/3] fix

---
 block.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 6e906ec..b3d42ef 100644
--- a/block.c
+++ b/block.c
@@ -1736,9 +1736,10 @@ static void bdrv_replace_child_noperm(BdrvChild *c=
hild,
                                       BlockDriverState *new_bs)
 {
     BlockDriverState *old_bs =3D child->bs;
+    int drain =3D !!(old_bs && old_bs->quiesce_counter) - !!(new_bs && n=
ew_bs->quiesce_counter);
=20
     if (old_bs) {
-        if (old_bs->quiesce_counter && child->role->drained_end) {
+        if (drain < 0 && child->role->drained_end) {
             child->role->drained_end(child);
         }
         if (child->role->detach) {
@@ -1751,7 +1752,7 @@ static void bdrv_replace_child_noperm(BdrvChild *ch=
ild,
=20
     if (new_bs) {
         QLIST_INSERT_HEAD(&new_bs->parents, child, next_parent);
-        if (new_bs->quiesce_counter && child->role->drained_begin) {
+        if (drain > 0 && child->role->drained_begin) {
             child->role->drained_begin(child);
         }
=20
@@ -3026,6 +3027,10 @@ void bdrv_append(BlockDriverState *bs_new, BlockDr=
iverState *bs_top,
 {
     Error *local_err =3D NULL;
=20
+    assert(bs_new->quiesce_counter =3D=3D 0);
+    assert(bs_top->quiesce_counter =3D=3D 1);
+    bdrv_drained_begin(bs_new);
+
     bdrv_set_backing_hd(bs_new, bs_top, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -3036,9 +3041,13 @@ void bdrv_append(BlockDriverState *bs_new, BlockDr=
iverState *bs_top,
     if (local_err) {
         error_propagate(errp, local_err);
         bdrv_set_backing_hd(bs_new, NULL, &error_abort);
+        bdrv_drained_end(bs_new);
         goto out;
     }
=20
+    assert(bs_new->quiesce_counter =3D=3D 1);
+    assert(bs_top->quiesce_counter =3D=3D 1);
+
     /* bs_new is now referenced by its new parents, we don't need the
      * additional reference any more. */
 out:
--=20
2.9.3


--------------61F7B9849A7CE6047F005289--

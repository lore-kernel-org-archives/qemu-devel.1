Received: from eggs.gnu.org ([2001:4830:134:3::10]:40323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gZHNi-0005ax-Oi
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:34:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gZHNf-0001f6-1g
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:34:02 -0500
Received: from forwardcorp1o.cmail.yandex.net ([2a02:6b8:0:1a72::290]:46568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1gZHNe-0001cU-BK
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:33:58 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <CAONzpcbM+mhpGPqv8nHjx5-cdJ0bP8SCc7nsRZpfhAagFhkmnw@mail.gmail.com>
References: <20181218100002.11219-1-xieyongji@baidu.com>
	<20181218100002.11219-7-xieyongji@baidu.com>
	<649661545136221@sas1-bf4ab558af9f.qloud-c.yandex.net>
	<CAONzpcaUjNMd=EWZG51-91mwpRyKy0siQW6LKi82NQrDZ-FUXg@mail.gmail.com>
	<698131545143714@sas1-bf4ab558af9f.qloud-c.yandex.net>
	<CAONzpcbM+mhpGPqv8nHjx5-cdJ0bP8SCc7nsRZpfhAagFhkmnw@mail.gmail.com>
MIME-Version: 1.0
Date: Tue, 18 Dec 2018 18:33:55 +0300
Message-Id: <976451545147235@iva8-f16495710718.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-4.0 6/7] vhost-user-blk: Add support
 to reconnect backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <elohimes@gmail.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "zhangyu31@baidu.com" <zhangyu31@baidu.com>, "chaiwen@baidu.com" <chaiwen@baidu.com>, "nixun@baidu.com" <nixun@baidu.com>, "lilin24@baidu.com" <lilin24@baidu.com>, Xie Yongji <xieyongji@baidu.com>, =?utf-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>



18.12.2018, 17:59, "Yongji Xie" <elohimes@gmail.com>:
> On Tue, 18 Dec 2018 at 22:35, Yury Kotov <yury-kotov@yandex-team.ru> wr=
ote:
>> =C2=A018.12.2018, 17:16, "Yongji Xie" <elohimes@gmail.com>:
>> =C2=A0> On Tue, 18 Dec 2018 at 20:30, Yury Kotov <yury-kotov@yandex-te=
am.ru> wrote:
>> =C2=A0>> + wrfsh@
>> =C2=A0>>
>> =C2=A0>> Hi,
>> =C2=A0>>
>> =C2=A0>> 18.12.2018, 13:01, "elohimes@gmail.com" <elohimes@gmail.com>:
>> =C2=A0>> > From: Xie Yongji <xieyongji@baidu.com>
>> =C2=A0>> >
>> =C2=A0>> > Since we now support the message VHOST_USER_GET_SHM_SIZE
>> =C2=A0>> > and VHOST_USER_SET_SHM_FD. The backend is able to restart
>> =C2=A0>> > safely because it can record inflight I/O in shared memory.
>> =C2=A0>> > This patch allows qemu to reconnect the backend after
>> =C2=A0>> > connection closed.
>> =C2=A0>> >
>> =C2=A0>> > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
>> =C2=A0>> > Signed-off-by: Ni Xun <nixun@baidu.com>
>> =C2=A0>> > Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
>> =C2=A0>> > ---
>> =C2=A0>> > hw/block/vhost-user-blk.c | 183 ++++++++++++++++++++++++---=
--
>> =C2=A0>> > include/hw/virtio/vhost-user-blk.h | 4 +
>> =C2=A0>> > 2 files changed, 160 insertions(+), 27 deletions(-)
>> =C2=A0>> >
>> =C2=A0>> > diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-use=
r-blk.c
>> =C2=A0>> > index 27028cf996..80f2e2d765 100644
>> =C2=A0>> > --- a/hw/block/vhost-user-blk.c
>> =C2=A0>> > +++ b/hw/block/vhost-user-blk.c
>> =C2=A0>> > @@ -101,7 +101,7 @@ const VhostDevConfigOps blk_ops =3D {
>> =C2=A0>> > .vhost_dev_config_notifier =3D vhost_user_blk_handle_config=
_change,
>> =C2=A0>> > };
>> =C2=A0>> >
>> =C2=A0>> > -static void vhost_user_blk_start(VirtIODevice *vdev)
>> =C2=A0>> > +static int vhost_user_blk_start(VirtIODevice *vdev)
>> =C2=A0>> > {
>> =C2=A0>> > VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>> =C2=A0>> > BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
>> =C2=A0>> > @@ -110,13 +110,13 @@ static void vhost_user_blk_start(Virt=
IODevice *vdev)
>> =C2=A0>> >
>> =C2=A0>> > if (!k->set_guest_notifiers) {
>> =C2=A0>> > error_report("binding does not support guest notifiers");
>> =C2=A0>> > - return;
>> =C2=A0>> > + return -ENOSYS;
>> =C2=A0>> > }
>> =C2=A0>> >
>> =C2=A0>> > ret =3D vhost_dev_enable_notifiers(&s->dev, vdev);
>> =C2=A0>> > if (ret < 0) {
>> =C2=A0>> > error_report("Error enabling host notifiers: %d", -ret);
>> =C2=A0>> > - return;
>> =C2=A0>> > + return ret;
>> =C2=A0>> > }
>> =C2=A0>> >
>> =C2=A0>> > ret =3D k->set_guest_notifiers(qbus->parent, s->dev.nvqs, t=
rue);
>> =C2=A0>> > @@ -147,12 +147,13 @@ static void vhost_user_blk_start(Virt=
IODevice *vdev)
>> =C2=A0>> > vhost_virtqueue_mask(&s->dev, vdev, i, false);
>> =C2=A0>> > }
>> =C2=A0>> >
>> =C2=A0>> > - return;
>> =C2=A0>> > + return ret;
>> =C2=A0>> >
>> =C2=A0>> > err_guest_notifiers:
>> =C2=A0>> > k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
>> =C2=A0>> > err_host_notifiers:
>> =C2=A0>> > vhost_dev_disable_notifiers(&s->dev, vdev);
>> =C2=A0>> > + return ret;
>> =C2=A0>> > }
>> =C2=A0>> >
>> =C2=A0>> > static void vhost_user_blk_stop(VirtIODevice *vdev)
>> =C2=A0>> > @@ -171,7 +172,6 @@ static void vhost_user_blk_stop(VirtIOD=
evice *vdev)
>> =C2=A0>> > ret =3D k->set_guest_notifiers(qbus->parent, s->dev.nvqs, f=
alse);
>> =C2=A0>> > if (ret < 0) {
>> =C2=A0>> > error_report("vhost guest notifier cleanup failed: %d", ret=
);
>> =C2=A0>> > - return;
>> =C2=A0>> > }
>> =C2=A0>> >
>> =C2=A0>> > vhost_dev_disable_notifiers(&s->dev, vdev);
>> =C2=A0>> > @@ -181,21 +181,43 @@ static void vhost_user_blk_set_status=
(VirtIODevice *vdev, uint8_t status)
>> =C2=A0>> > {
>> =C2=A0>> > VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>> =C2=A0>> > bool should_start =3D status & VIRTIO_CONFIG_S_DRIVER_OK;
>> =C2=A0>> > + int ret;
>> =C2=A0>> >
>> =C2=A0>> > if (!vdev->vm_running) {
>> =C2=A0>> > should_start =3D false;
>> =C2=A0>> > }
>> =C2=A0>> >
>> =C2=A0>> > - if (s->dev.started =3D=3D should_start) {
>> =C2=A0>> > + if (s->should_start =3D=3D should_start) {
>> =C2=A0>> > + return;
>> =C2=A0>> > + }
>> =C2=A0>> > +
>> =C2=A0>> > + if (!s->connected || s->dev.started =3D=3D should_start) =
{
>> =C2=A0>> > + s->should_start =3D should_start;
>> =C2=A0>> > return;
>> =C2=A0>> > }
>> =C2=A0>> >
>> =C2=A0>> > if (should_start) {
>> =C2=A0>> > - vhost_user_blk_start(vdev);
>> =C2=A0>> > + s->should_start =3D true;
>> =C2=A0>> > + /*
>> =C2=A0>> > + * make sure vhost_user_blk_handle_output() ignores fake
>> =C2=A0>> > + * guest kick by vhost_dev_enable_notifiers()
>> =C2=A0>> > + */
>> =C2=A0>> > + barrier();
>> =C2=A0>> > + ret =3D vhost_user_blk_start(vdev);
>> =C2=A0>> > + if (ret < 0) {
>> =C2=A0>> > + error_report("vhost-user-blk: vhost start failed: %s",
>> =C2=A0>> > + strerror(-ret));
>> =C2=A0>> > + qemu_chr_fe_disconnect(&s->chardev);
>> =C2=A0>> > + }
>> =C2=A0>> > } else {
>> =C2=A0>> > vhost_user_blk_stop(vdev);
>> =C2=A0>> > + /*
>> =C2=A0>> > + * make sure vhost_user_blk_handle_output() ignore fake
>> =C2=A0>> > + * guest kick by vhost_dev_disable_notifiers()
>> =C2=A0>> > + */
>> =C2=A0>> > + barrier();
>> =C2=A0>> > + s->should_start =3D false;
>> =C2=A0>> > }
>> =C2=A0>> > -
>> =C2=A0>> > }
>> =C2=A0>> >
>> =C2=A0>> > static uint64_t vhost_user_blk_get_features(VirtIODevice *v=
dev,
>> =C2=A0>> > @@ -225,13 +247,22 @@ static uint64_t vhost_user_blk_get_fe=
atures(VirtIODevice *vdev,
>> =C2=A0>> > static void vhost_user_blk_handle_output(VirtIODevice *vdev=
, VirtQueue *vq)
>> =C2=A0>> > {
>> =C2=A0>> > VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>> =C2=A0>> > - int i;
>> =C2=A0>> > + int i, ret;
>> =C2=A0>> >
>> =C2=A0>> > if (!(virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
>> =C2=A0>> > !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1))) {
>> =C2=A0>> > return;
>> =C2=A0>> > }
>> =C2=A0>> >
>> =C2=A0>> > + if (s->should_start) {
>> =C2=A0>> > + return;
>> =C2=A0>> > + }
>> =C2=A0>> > + s->should_start =3D true;
>> =C2=A0>> > +
>> =C2=A0>> > + if (!s->connected) {
>> =C2=A0>> > + return;
>> =C2=A0>> > + }
>> =C2=A0>> > +
>> =C2=A0>> > if (s->dev.started) {
>> =C2=A0>> > return;
>> =C2=A0>> > }
>> =C2=A0>> > @@ -239,7 +270,13 @@ static void vhost_user_blk_handle_outp=
ut(VirtIODevice *vdev, VirtQueue *vq)
>> =C2=A0>> > /* Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_O=
K so start
>> =C2=A0>> > * vhost here instead of waiting for .set_status().
>> =C2=A0>> > */
>> =C2=A0>> > - vhost_user_blk_start(vdev);
>> =C2=A0>> > + ret =3D vhost_user_blk_start(vdev);
>> =C2=A0>> > + if (ret < 0) {
>> =C2=A0>> > + error_report("vhost-user-blk: vhost start failed: %s",
>> =C2=A0>> > + strerror(-ret));
>> =C2=A0>> > + qemu_chr_fe_disconnect(&s->chardev);
>> =C2=A0>> > + return;
>> =C2=A0>> > + }
>> =C2=A0>> >
>> =C2=A0>> > /* Kick right away to begin processing requests already in =
vring */
>> =C2=A0>> > for (i =3D 0; i < s->dev.nvqs; i++) {
>> =C2=A0>> > @@ -259,12 +296,105 @@ static void vhost_user_blk_reset(Vir=
tIODevice *vdev)
>> =C2=A0>> > vhost_dev_reset_shm(s->shm);
>> =C2=A0>> > }
>> =C2=A0>> >
>> =C2=A0>> > +static int vhost_user_blk_connect(DeviceState *dev)
>> =C2=A0>> > +{
>> =C2=A0>> > + VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>> =C2=A0>> > + VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>> =C2=A0>> > + int ret =3D 0;
>> =C2=A0>> > +
>> =C2=A0>> > + if (s->connected) {
>> =C2=A0>> > + return 0;
>> =C2=A0>> > + }
>> =C2=A0>> > + s->connected =3D true;
>> =C2=A0>> > +
>> =C2=A0>> > + s->dev.nvqs =3D s->num_queues;
>> =C2=A0>> > + s->dev.vqs =3D s->vqs;
>> =C2=A0>> > + s->dev.vq_index =3D 0;
>> =C2=A0>> > + s->dev.backend_features =3D 0;
>> =C2=A0>> > +
>> =C2=A0>> > + vhost_dev_set_config_notifier(&s->dev, &blk_ops);
>> =C2=A0>> > +
>> =C2=A0>> > + ret =3D vhost_dev_init(&s->dev, s->vhost_user, VHOST_BACK=
END_TYPE_USER, 0);
>> =C2=A0>> > + if (ret < 0) {
>> =C2=A0>> > + error_report("vhost-user-blk: vhost initialization failed=
: %s",
>> =C2=A0>> > + strerror(-ret));
>> =C2=A0>> > + return ret;
>> =C2=A0>> > + }
>> =C2=A0>> > +
>> =C2=A0>> > + /* restore vhost state */
>> =C2=A0>> > + if (s->should_start) {
>> =C2=A0>> > + ret =3D vhost_user_blk_start(vdev);
>> =C2=A0>> > + if (ret < 0) {
>> =C2=A0>> > + error_report("vhost-user-blk: vhost start failed: %s",
>> =C2=A0>> > + strerror(-ret));
>> =C2=A0>> > + return ret;
>> =C2=A0>> > + }
>> =C2=A0>> > + }
>> =C2=A0>> > +
>> =C2=A0>> > + return 0;
>> =C2=A0>> > +}
>> =C2=A0>> > +
>> =C2=A0>> > +static void vhost_user_blk_disconnect(DeviceState *dev)
>> =C2=A0>> > +{
>> =C2=A0>> > + VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>> =C2=A0>> > + VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>> =C2=A0>> > +
>> =C2=A0>> > + if (!s->connected) {
>> =C2=A0>> > + return;
>> =C2=A0>> > + }
>> =C2=A0>> > + s->connected =3D false;
>> =C2=A0>> > +
>> =C2=A0>> > + if (s->dev.started) {
>> =C2=A0>> > + vhost_user_blk_stop(vdev);
>> =C2=A0>> > + }
>> =C2=A0>> > +
>> =C2=A0>> > + vhost_dev_cleanup(&s->dev);
>> =C2=A0>> > +}
>> =C2=A0>> > +
>> =C2=A0>> > +static gboolean vhost_user_blk_watch(GIOChannel *chan, GIO=
Condition cond,
>> =C2=A0>> > + void *opaque)
>> =C2=A0>> > +{
>> =C2=A0>> > + DeviceState *dev =3D opaque;
>> =C2=A0>> > + VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>> =C2=A0>> > + VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>> =C2=A0>> > +
>> =C2=A0>> > + qemu_chr_fe_disconnect(&s->chardev);
>> =C2=A0>> > +
>> =C2=A0>> > + return true;
>> =C2=A0>> > +}
>> =C2=A0>> > +
>> =C2=A0>> > +static void vhost_user_blk_event(void *opaque, int event)
>> =C2=A0>> > +{
>> =C2=A0>> > + DeviceState *dev =3D opaque;
>> =C2=A0>> > + VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>> =C2=A0>> > + VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>> =C2=A0>> > +
>> =C2=A0>> > + switch (event) {
>> =C2=A0>> > + case CHR_EVENT_OPENED:
>> =C2=A0>> > + if (vhost_user_blk_connect(dev) < 0) {
>> =C2=A0>> > + qemu_chr_fe_disconnect(&s->chardev);
>> =C2=A0>> > + return;
>> =C2=A0>> > + }
>> =C2=A0>> > + s->watch =3D qemu_chr_fe_add_watch(&s->chardev, G_IO_HUP,
>> =C2=A0>> > + vhost_user_blk_watch, dev);
>> =C2=A0>> > + break;
>> =C2=A0>> > + case CHR_EVENT_CLOSED:
>> =C2=A0>> > + vhost_user_blk_disconnect(dev);
>> =C2=A0>> > + if (s->watch) {
>> =C2=A0>> > + g_source_remove(s->watch);
>> =C2=A0>> > + s->watch =3D 0;
>> =C2=A0>> > + }
>> =C2=A0>> > + break;
>> =C2=A0>> > + }
>> =C2=A0>> > +}
>> =C2=A0>> > +
>> =C2=A0>> > static void vhost_user_blk_device_realize(DeviceState *dev,=
 Error **errp)
>> =C2=A0>> > {
>> =C2=A0>> > VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>> =C2=A0>> > VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>> =C2=A0>> > VhostUserState *user;
>> =C2=A0>> > int i, ret;
>> =C2=A0>> > + Error *err =3D NULL;
>> =C2=A0>> >
>> =C2=A0>> > if (!s->chardev.chr) {
>> =C2=A0>> > error_setg(errp, "vhost-user-blk: chardev is mandatory");
>> =C2=A0>> > @@ -299,23 +429,21 @@ static void vhost_user_blk_device_rea=
lize(DeviceState *dev, Error **errp)
>> =C2=A0>> > }
>> =C2=A0>> >
>> =C2=A0>> > s->shm =3D g_new0(struct vhost_shm, 1);
>> =C2=A0>> > -
>> =C2=A0>> > - s->dev.nvqs =3D s->num_queues;
>> =C2=A0>> > - s->dev.vqs =3D g_new(struct vhost_virtqueue, s->dev.nvqs)=
;
>> =C2=A0>> > - s->dev.vq_index =3D 0;
>> =C2=A0>> > - s->dev.backend_features =3D 0;
>> =C2=A0>> > -
>> =C2=A0>> > - vhost_dev_set_config_notifier(&s->dev, &blk_ops);
>> =C2=A0>> > -
>> =C2=A0>> > - ret =3D vhost_dev_init(&s->dev, s->vhost_user, VHOST_BACK=
END_TYPE_USER, 0);
>> =C2=A0>> > - if (ret < 0) {
>> =C2=A0>> > - error_setg(errp, "vhost-user-blk: vhost initialization fa=
iled: %s",
>> =C2=A0>> > - strerror(-ret));
>> =C2=A0>> > - goto virtio_err;
>> =C2=A0>> > + s->vqs =3D g_new(struct vhost_virtqueue, s->num_queues);
>> =C2=A0>> > + s->watch =3D 0;
>> =C2=A0>> > + s->should_start =3D false;
>> =C2=A0>> > + s->connected =3D false;
>> =C2=A0>> > +
>> =C2=A0>> > + while (qemu_chr_fe_wait_connected(&s->chardev, &err) < 0)=
 {
>> =C2=A0>> > + error_report_err(err);
>> =C2=A0>> > + err =3D NULL;
>> =C2=A0>> > + sleep(1);
>> =C2=A0>> > }
>> =C2=A0>>
>> =C2=A0>> After the reconnect loop we have some function calls to vhost=
 backend:
>> =C2=A0>> * qemu_chr_fe_set_handlers implicit calls vhost_dev_init
>> =C2=A0>> * vhost_dev_get_config
>> =C2=A0>> * vhost_dev_init_shm
>> =C2=A0>>
>> =C2=A0>> If vhost backend will restart during their execution the init=
ialzation will be
>> =C2=A0>> failed. What do you think? May be we can call these functions=
 inside of
>> =C2=A0>> the reconnect loop to fix it?
>> =C2=A0>
>> =C2=A0> qemu_chr_fe_wait_connected() should be called only when we are=
 in
>> =C2=A0> disconnected state. Otherwise, it will be conflicted with reco=
nnect
>> =C2=A0> thread.
>> =C2=A0>
>>
>> =C2=A0Reconnect thread is started by reconnet timer callback from the =
main loop but
>> =C2=A0vhost_user_blk_device_realize is also runs in the main loop, so =
we don't a race
>> =C2=A0in this case I think.
>
> The reconnet timer callback have an assert: assert(s->connected =3D=3D =
0).
> And it's odd to call qemu_chr_fe_wait_connected() when reconnect
> thread is running.
>

Reconnect timer callback is a function socket_reconnect_timeout. This fun=
ction
doesn't have any asserts. Do you mean qemu_chr_socket_restart_timer? It h=
as an
assert, yes. But it is called from tcp_chr_disconnect in the same thread.

E.g. vhost_user_get_config ->
     vhost_user_read ->
     qemu_chr_fe_read_all ->
     tcp_chr_sync_read ->
     tcp_chr_disconnect ->
     qemu_chr_socket_restart_timer

May be I misunderstand something, but don't see any problems here...

I see that reconnect timer callback is postponed until main loop run and =
we may
safely call qemu_chr_fe_wait_connected.

Regards,
Yury

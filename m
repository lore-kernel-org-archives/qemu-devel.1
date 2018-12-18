Received: from eggs.gnu.org ([2001:4830:134:3::10]:60225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gZGDO-0001WY-Av
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:19:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gZGDL-0005Rt-5s
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:19:18 -0500
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:49094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1gZGDK-0005RD-L9
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:19:15 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20181218100002.11219-7-xieyongji@baidu.com>
References: <20181218100002.11219-1-xieyongji@baidu.com>
	<20181218100002.11219-7-xieyongji@baidu.com>
MIME-Version: 1.0
Date: Tue, 18 Dec 2018 15:30:21 +0300
Message-Id: <649661545136221@sas1-bf4ab558af9f.qloud-c.yandex.net>
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
To: "elohimes@gmail.com" <elohimes@gmail.com>, "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "zhangyu31@baidu.com" <zhangyu31@baidu.com>, "chaiwen@baidu.com" <chaiwen@baidu.com>, "nixun@baidu.com" <nixun@baidu.com>, "lilin24@baidu.com" <lilin24@baidu.com>, Xie Yongji <xieyongji@baidu.com>, =?utf-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>

+ wrfsh@

Hi,

18.12.2018, 13:01, "elohimes@gmail.com" <elohimes@gmail.com>:
> From: Xie Yongji <xieyongji@baidu.com>
>
> Since we now support the message VHOST_USER_GET_SHM_SIZE
> and VHOST_USER_SET_SHM_FD. The backend is able to restart
> safely because it can record inflight I/O in shared memory.
> This patch allows qemu to reconnect the backend after
> connection closed.
>
> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> Signed-off-by: Ni Xun <nixun@baidu.com>
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> ---
> =C2=A0hw/block/vhost-user-blk.c | 183 ++++++++++++++++++++++++-----
> =C2=A0include/hw/virtio/vhost-user-blk.h | 4 +
> =C2=A02 files changed, 160 insertions(+), 27 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 27028cf996..80f2e2d765 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -101,7 +101,7 @@ const VhostDevConfigOps blk_ops =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.vhost_dev_config_notifier =3D vhost_user=
_blk_handle_config_change,
> =C2=A0};
>
> -static void vhost_user_blk_start(VirtIODevice *vdev)
> +static int vhost_user_blk_start(VirtIODevice *vdev)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BusState *qbus =3D BUS(qdev_get_parent_bu=
s(DEVICE(vdev)));
> @@ -110,13 +110,13 @@ static void vhost_user_blk_start(VirtIODevice *vd=
ev)
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!k->set_guest_notifiers) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_report("bin=
ding does not support guest notifiers");
> - return;
> + return -ENOSYS;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D vhost_dev_enable_notifiers(&s->de=
v, vdev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret < 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_report("Err=
or enabling host notifiers: %d", -ret);
> - return;
> + return ret;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D k->set_guest_notifiers(qbus->pare=
nt, s->dev.nvqs, true);
> @@ -147,12 +147,13 @@ static void vhost_user_blk_start(VirtIODevice *vd=
ev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vhost_virtqueue_m=
ask(&s->dev, vdev, i, false);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>
> - return;
> + return ret;
>
> =C2=A0err_guest_notifiers:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0k->set_guest_notifiers(qbus->parent, s->d=
ev.nvqs, false);
> =C2=A0err_host_notifiers:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vhost_dev_disable_notifiers(&s->dev, vdev=
);
> + return ret;
> =C2=A0}
>
> =C2=A0static void vhost_user_blk_stop(VirtIODevice *vdev)
> @@ -171,7 +172,6 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D k->set_guest_notifiers(qbus->pare=
nt, s->dev.nvqs, false);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret < 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_report("vho=
st guest notifier cleanup failed: %d", ret);
> - return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vhost_dev_disable_notifiers(&s->dev, vdev=
);
> @@ -181,21 +181,43 @@ static void vhost_user_blk_set_status(VirtIODevic=
e *vdev, uint8_t status)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool should_start =3D status & VIRTIO_CON=
FIG_S_DRIVER_OK;
> + int ret;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!vdev->vm_running) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0should_start =3D =
false;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>
> - if (s->dev.started =3D=3D should_start) {
> + if (s->should_start =3D=3D should_start) {
> + return;
> + }
> +
> + if (!s->connected || s->dev.started =3D=3D should_start) {
> + s->should_start =3D should_start;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (should_start) {
> - vhost_user_blk_start(vdev);
> + s->should_start =3D true;
> + /*
> + * make sure vhost_user_blk_handle_output() ignores fake
> + * guest kick by vhost_dev_enable_notifiers()
> + */
> + barrier();
> + ret =3D vhost_user_blk_start(vdev);
> + if (ret < 0) {
> + error_report("vhost-user-blk: vhost start failed: %s",
> + strerror(-ret));
> + qemu_chr_fe_disconnect(&s->chardev);
> + }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vhost_user_blk_st=
op(vdev);
> + /*
> + * make sure vhost_user_blk_handle_output() ignore fake
> + * guest kick by vhost_dev_disable_notifiers()
> + */
> + barrier();
> + s->should_start =3D false;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> -
> =C2=A0}
>
> =C2=A0static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
> @@ -225,13 +247,22 @@ static uint64_t vhost_user_blk_get_features(VirtI=
ODevice *vdev,
> =C2=A0static void vhost_user_blk_handle_output(VirtIODevice *vdev, Virt=
Queue *vq)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> - int i;
> + int i, ret;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!(virtio_host_has_feature(vdev, VIRTI=
O_F_VERSION_1) &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0!virtio_vdev_has_=
feature(vdev, VIRTIO_F_VERSION_1))) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>
> + if (s->should_start) {
> + return;
> + }
> + s->should_start =3D true;
> +
> + if (!s->connected) {
> + return;
> + }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (s->dev.started) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> @@ -239,7 +270,13 @@ static void vhost_user_blk_handle_output(VirtIODev=
ice *vdev, VirtQueue *vq)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Some guests kick before setting VIRTIO=
_CONFIG_S_DRIVER_OK so start
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* vhost here instead of waiting for=
 .set_status().
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> - vhost_user_blk_start(vdev);
> + ret =3D vhost_user_blk_start(vdev);
> + if (ret < 0) {
> + error_report("vhost-user-blk: vhost start failed: %s",
> + strerror(-ret));
> + qemu_chr_fe_disconnect(&s->chardev);
> + return;
> + }
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Kick right away to begin processing re=
quests already in vring */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < s->dev.nvqs; i++) {
> @@ -259,12 +296,105 @@ static void vhost_user_blk_reset(VirtIODevice *v=
dev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vhost_dev_reset_shm(s->shm);
> =C2=A0}
>
> +static int vhost_user_blk_connect(DeviceState *dev)
> +{
> + VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> + VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> + int ret =3D 0;
> +
> + if (s->connected) {
> + return 0;
> + }
> + s->connected =3D true;
> +
> + s->dev.nvqs =3D s->num_queues;
> + s->dev.vqs =3D s->vqs;
> + s->dev.vq_index =3D 0;
> + s->dev.backend_features =3D 0;
> +
> + vhost_dev_set_config_notifier(&s->dev, &blk_ops);
> +
> + ret =3D vhost_dev_init(&s->dev, s->vhost_user, VHOST_BACKEND_TYPE_USE=
R, 0);
> + if (ret < 0) {
> + error_report("vhost-user-blk: vhost initialization failed: %s",
> + strerror(-ret));
> + return ret;
> + }
> +
> + /* restore vhost state */
> + if (s->should_start) {
> + ret =3D vhost_user_blk_start(vdev);
> + if (ret < 0) {
> + error_report("vhost-user-blk: vhost start failed: %s",
> + strerror(-ret));
> + return ret;
> + }
> + }
> +
> + return 0;
> +}
> +
> +static void vhost_user_blk_disconnect(DeviceState *dev)
> +{
> + VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> + VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> +
> + if (!s->connected) {
> + return;
> + }
> + s->connected =3D false;
> +
> + if (s->dev.started) {
> + vhost_user_blk_stop(vdev);
> + }
> +
> + vhost_dev_cleanup(&s->dev);
> +}
> +
> +static gboolean vhost_user_blk_watch(GIOChannel *chan, GIOCondition co=
nd,
> + void *opaque)
> +{
> + DeviceState *dev =3D opaque;
> + VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> + VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> +
> + qemu_chr_fe_disconnect(&s->chardev);
> +
> + return true;
> +}
> +
> +static void vhost_user_blk_event(void *opaque, int event)
> +{
> + DeviceState *dev =3D opaque;
> + VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> + VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> +
> + switch (event) {
> + case CHR_EVENT_OPENED:
> + if (vhost_user_blk_connect(dev) < 0) {
> + qemu_chr_fe_disconnect(&s->chardev);
> + return;
> + }
> + s->watch =3D qemu_chr_fe_add_watch(&s->chardev, G_IO_HUP,
> + vhost_user_blk_watch, dev);
> + break;
> + case CHR_EVENT_CLOSED:
> + vhost_user_blk_disconnect(dev);
> + if (s->watch) {
> + g_source_remove(s->watch);
> + s->watch =3D 0;
> + }
> + break;
> + }
> +}
> +
> =C2=A0static void vhost_user_blk_device_realize(DeviceState *dev, Error=
 **errp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VirtIODevice *vdev =3D VIRTIO_DEVICE(dev)=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VhostUserState *user;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i, ret;
> + Error *err =3D NULL;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!s->chardev.chr) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_setg(errp, =
"vhost-user-blk: chardev is mandatory");
> @@ -299,23 +429,21 @@ static void vhost_user_blk_device_realize(DeviceS=
tate *dev, Error **errp)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->shm =3D g_new0(struct vhost_shm, 1);
> -
> - s->dev.nvqs =3D s->num_queues;
> - s->dev.vqs =3D g_new(struct vhost_virtqueue, s->dev.nvqs);
> - s->dev.vq_index =3D 0;
> - s->dev.backend_features =3D 0;
> -
> - vhost_dev_set_config_notifier(&s->dev, &blk_ops);
> -
> - ret =3D vhost_dev_init(&s->dev, s->vhost_user, VHOST_BACKEND_TYPE_USE=
R, 0);
> - if (ret < 0) {
> - error_setg(errp, "vhost-user-blk: vhost initialization failed: %s",
> - strerror(-ret));
> - goto virtio_err;
> + s->vqs =3D g_new(struct vhost_virtqueue, s->num_queues);
> + s->watch =3D 0;
> + s->should_start =3D false;
> + s->connected =3D false;
> +
> + while (qemu_chr_fe_wait_connected(&s->chardev, &err) < 0) {
> + error_report_err(err);
> + err =3D NULL;
> + sleep(1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}

After the reconnect loop we have some function calls to vhost backend:
* qemu_chr_fe_set_handlers implicit calls vhost_dev_init
* vhost_dev_get_config
* vhost_dev_init_shm

If vhost backend will restart during their execution the initialzation wi=
ll be
failed. What do you think? May be we can call these functions inside of
the reconnect loop to fix it?

> + qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, vhost_user_blk_even=
t,
> + NULL, (void *)dev, NULL, true);
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D vhost_dev_get_config(&s->dev, (ui=
nt8_t *)&s->blkcfg,
> - sizeof(struct virtio_blk_config));
> + sizeof(struct virtio_blk_config));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret < 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_setg(errp, =
"vhost-user-blk: get block config failed");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto vhost_err;
> @@ -335,8 +463,7 @@ static void vhost_user_blk_device_realize(DeviceSta=
te *dev, Error **errp)
>
> =C2=A0vhost_err:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vhost_dev_cleanup(&s->dev);
> -virtio_err:
> - g_free(s->dev.vqs);
> + g_free(s->vqs);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_free(s->shm);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0virtio_cleanup(vdev);
>
> @@ -351,9 +478,11 @@ static void vhost_user_blk_device_unrealize(Device=
State *dev, Error **errp)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VHostUserBlk *s =3D VHOST_USER_BLK(dev);
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vhost_user_blk_set_status(vdev, 0);
> + qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, NULL,
> + NULL, NULL, NULL, false);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vhost_dev_cleanup(&s->dev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vhost_dev_free_shm(s->shm);
> - g_free(s->dev.vqs);
> + g_free(s->vqs);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_free(s->shm);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0virtio_cleanup(vdev);
>
> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vho=
st-user-blk.h
> index bb706d70b3..c17d47402b 100644
> --- a/include/hw/virtio/vhost-user-blk.h
> +++ b/include/hw/virtio/vhost-user-blk.h
> @@ -38,6 +38,10 @@ typedef struct VHostUserBlk {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct vhost_dev dev;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct vhost_shm *shm;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VhostUserState *vhost_user;
> + struct vhost_virtqueue *vqs;
> + guint watch;
> + bool should_start;
> + bool connected;
> =C2=A0} VHostUserBlk;
>
> =C2=A0#endif
> --
> 2.17.1

Regards,
Yury

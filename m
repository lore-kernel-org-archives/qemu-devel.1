Received: from eggs.gnu.org ([2001:4830:134:3::10]:59397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZGB3-0007e0-II
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:16:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZGB0-0004zM-Kd
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:16:53 -0500
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:37899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gZGAx-0004yd-KV
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:16:48 -0500
Received: by mail-yw1-xc41.google.com with SMTP id d16so4186430ywa.5
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 06:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20181218100002.11219-1-xieyongji@baidu.com>
	<20181218100002.11219-7-xieyongji@baidu.com>
	<649661545136221@sas1-bf4ab558af9f.qloud-c.yandex.net>
In-Reply-To: <649661545136221@sas1-bf4ab558af9f.qloud-c.yandex.net>
From: Yongji Xie <elohimes@gmail.com>
Date: Tue, 18 Dec 2018 22:16:31 +0800
Message-ID: <CAONzpcaUjNMd=EWZG51-91mwpRyKy0siQW6LKi82NQrDZ-FUXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "zhangyu31@baidu.com" <zhangyu31@baidu.com>, "chaiwen@baidu.com" <chaiwen@baidu.com>, "nixun@baidu.com" <nixun@baidu.com>, "lilin24@baidu.com" <lilin24@baidu.com>, Xie Yongji <xieyongji@baidu.com>, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>

On Tue, 18 Dec 2018 at 20:30, Yury Kotov <yury-kotov@yandex-team.ru> wrote:
>
> + wrfsh@
>
> Hi,
>
> 18.12.2018, 13:01, "elohimes@gmail.com" <elohimes@gmail.com>:
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > Since we now support the message VHOST_USER_GET_SHM_SIZE
> > and VHOST_USER_SET_SHM_FD. The backend is able to restart
> > safely because it can record inflight I/O in shared memory.
> > This patch allows qemu to reconnect the backend after
> > connection closed.
> >
> > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > Signed-off-by: Ni Xun <nixun@baidu.com>
> > Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> > ---
> >  hw/block/vhost-user-blk.c | 183 ++++++++++++++++++++++++-----
> >  include/hw/virtio/vhost-user-blk.h | 4 +
> >  2 files changed, 160 insertions(+), 27 deletions(-)
> >
> > diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> > index 27028cf996..80f2e2d765 100644
> > --- a/hw/block/vhost-user-blk.c
> > +++ b/hw/block/vhost-user-blk.c
> > @@ -101,7 +101,7 @@ const VhostDevConfigOps blk_ops = {
> >      .vhost_dev_config_notifier = vhost_user_blk_handle_config_change,
> >  };
> >
> > -static void vhost_user_blk_start(VirtIODevice *vdev)
> > +static int vhost_user_blk_start(VirtIODevice *vdev)
> >  {
> >      VHostUserBlk *s = VHOST_USER_BLK(vdev);
> >      BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
> > @@ -110,13 +110,13 @@ static void vhost_user_blk_start(VirtIODevice *vdev)
> >
> >      if (!k->set_guest_notifiers) {
> >          error_report("binding does not support guest notifiers");
> > - return;
> > + return -ENOSYS;
> >      }
> >
> >      ret = vhost_dev_enable_notifiers(&s->dev, vdev);
> >      if (ret < 0) {
> >          error_report("Error enabling host notifiers: %d", -ret);
> > - return;
> > + return ret;
> >      }
> >
> >      ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, true);
> > @@ -147,12 +147,13 @@ static void vhost_user_blk_start(VirtIODevice *vdev)
> >          vhost_virtqueue_mask(&s->dev, vdev, i, false);
> >      }
> >
> > - return;
> > + return ret;
> >
> >  err_guest_notifiers:
> >      k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
> >  err_host_notifiers:
> >      vhost_dev_disable_notifiers(&s->dev, vdev);
> > + return ret;
> >  }
> >
> >  static void vhost_user_blk_stop(VirtIODevice *vdev)
> > @@ -171,7 +172,6 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
> >      ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
> >      if (ret < 0) {
> >          error_report("vhost guest notifier cleanup failed: %d", ret);
> > - return;
> >      }
> >
> >      vhost_dev_disable_notifiers(&s->dev, vdev);
> > @@ -181,21 +181,43 @@ static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
> >  {
> >      VHostUserBlk *s = VHOST_USER_BLK(vdev);
> >      bool should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;
> > + int ret;
> >
> >      if (!vdev->vm_running) {
> >          should_start = false;
> >      }
> >
> > - if (s->dev.started == should_start) {
> > + if (s->should_start == should_start) {
> > + return;
> > + }
> > +
> > + if (!s->connected || s->dev.started == should_start) {
> > + s->should_start = should_start;
> >          return;
> >      }
> >
> >      if (should_start) {
> > - vhost_user_blk_start(vdev);
> > + s->should_start = true;
> > + /*
> > + * make sure vhost_user_blk_handle_output() ignores fake
> > + * guest kick by vhost_dev_enable_notifiers()
> > + */
> > + barrier();
> > + ret = vhost_user_blk_start(vdev);
> > + if (ret < 0) {
> > + error_report("vhost-user-blk: vhost start failed: %s",
> > + strerror(-ret));
> > + qemu_chr_fe_disconnect(&s->chardev);
> > + }
> >      } else {
> >          vhost_user_blk_stop(vdev);
> > + /*
> > + * make sure vhost_user_blk_handle_output() ignore fake
> > + * guest kick by vhost_dev_disable_notifiers()
> > + */
> > + barrier();
> > + s->should_start = false;
> >      }
> > -
> >  }
> >
> >  static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
> > @@ -225,13 +247,22 @@ static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
> >  static void vhost_user_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> >  {
> >      VHostUserBlk *s = VHOST_USER_BLK(vdev);
> > - int i;
> > + int i, ret;
> >
> >      if (!(virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
> >          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1))) {
> >          return;
> >      }
> >
> > + if (s->should_start) {
> > + return;
> > + }
> > + s->should_start = true;
> > +
> > + if (!s->connected) {
> > + return;
> > + }
> > +
> >      if (s->dev.started) {
> >          return;
> >      }
> > @@ -239,7 +270,13 @@ static void vhost_user_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> >      /* Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so start
> >       * vhost here instead of waiting for .set_status().
> >       */
> > - vhost_user_blk_start(vdev);
> > + ret = vhost_user_blk_start(vdev);
> > + if (ret < 0) {
> > + error_report("vhost-user-blk: vhost start failed: %s",
> > + strerror(-ret));
> > + qemu_chr_fe_disconnect(&s->chardev);
> > + return;
> > + }
> >
> >      /* Kick right away to begin processing requests already in vring */
> >      for (i = 0; i < s->dev.nvqs; i++) {
> > @@ -259,12 +296,105 @@ static void vhost_user_blk_reset(VirtIODevice *vdev)
> >      vhost_dev_reset_shm(s->shm);
> >  }
> >
> > +static int vhost_user_blk_connect(DeviceState *dev)
> > +{
> > + VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > + VHostUserBlk *s = VHOST_USER_BLK(vdev);
> > + int ret = 0;
> > +
> > + if (s->connected) {
> > + return 0;
> > + }
> > + s->connected = true;
> > +
> > + s->dev.nvqs = s->num_queues;
> > + s->dev.vqs = s->vqs;
> > + s->dev.vq_index = 0;
> > + s->dev.backend_features = 0;
> > +
> > + vhost_dev_set_config_notifier(&s->dev, &blk_ops);
> > +
> > + ret = vhost_dev_init(&s->dev, s->vhost_user, VHOST_BACKEND_TYPE_USER, 0);
> > + if (ret < 0) {
> > + error_report("vhost-user-blk: vhost initialization failed: %s",
> > + strerror(-ret));
> > + return ret;
> > + }
> > +
> > + /* restore vhost state */
> > + if (s->should_start) {
> > + ret = vhost_user_blk_start(vdev);
> > + if (ret < 0) {
> > + error_report("vhost-user-blk: vhost start failed: %s",
> > + strerror(-ret));
> > + return ret;
> > + }
> > + }
> > +
> > + return 0;
> > +}
> > +
> > +static void vhost_user_blk_disconnect(DeviceState *dev)
> > +{
> > + VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > + VHostUserBlk *s = VHOST_USER_BLK(vdev);
> > +
> > + if (!s->connected) {
> > + return;
> > + }
> > + s->connected = false;
> > +
> > + if (s->dev.started) {
> > + vhost_user_blk_stop(vdev);
> > + }
> > +
> > + vhost_dev_cleanup(&s->dev);
> > +}
> > +
> > +static gboolean vhost_user_blk_watch(GIOChannel *chan, GIOCondition cond,
> > + void *opaque)
> > +{
> > + DeviceState *dev = opaque;
> > + VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > + VHostUserBlk *s = VHOST_USER_BLK(vdev);
> > +
> > + qemu_chr_fe_disconnect(&s->chardev);
> > +
> > + return true;
> > +}
> > +
> > +static void vhost_user_blk_event(void *opaque, int event)
> > +{
> > + DeviceState *dev = opaque;
> > + VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > + VHostUserBlk *s = VHOST_USER_BLK(vdev);
> > +
> > + switch (event) {
> > + case CHR_EVENT_OPENED:
> > + if (vhost_user_blk_connect(dev) < 0) {
> > + qemu_chr_fe_disconnect(&s->chardev);
> > + return;
> > + }
> > + s->watch = qemu_chr_fe_add_watch(&s->chardev, G_IO_HUP,
> > + vhost_user_blk_watch, dev);
> > + break;
> > + case CHR_EVENT_CLOSED:
> > + vhost_user_blk_disconnect(dev);
> > + if (s->watch) {
> > + g_source_remove(s->watch);
> > + s->watch = 0;
> > + }
> > + break;
> > + }
> > +}
> > +
> >  static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
> >  {
> >      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> >      VHostUserBlk *s = VHOST_USER_BLK(vdev);
> >      VhostUserState *user;
> >      int i, ret;
> > + Error *err = NULL;
> >
> >      if (!s->chardev.chr) {
> >          error_setg(errp, "vhost-user-blk: chardev is mandatory");
> > @@ -299,23 +429,21 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
> >      }
> >
> >      s->shm = g_new0(struct vhost_shm, 1);
> > -
> > - s->dev.nvqs = s->num_queues;
> > - s->dev.vqs = g_new(struct vhost_virtqueue, s->dev.nvqs);
> > - s->dev.vq_index = 0;
> > - s->dev.backend_features = 0;
> > -
> > - vhost_dev_set_config_notifier(&s->dev, &blk_ops);
> > -
> > - ret = vhost_dev_init(&s->dev, s->vhost_user, VHOST_BACKEND_TYPE_USER, 0);
> > - if (ret < 0) {
> > - error_setg(errp, "vhost-user-blk: vhost initialization failed: %s",
> > - strerror(-ret));
> > - goto virtio_err;
> > + s->vqs = g_new(struct vhost_virtqueue, s->num_queues);
> > + s->watch = 0;
> > + s->should_start = false;
> > + s->connected = false;
> > +
> > + while (qemu_chr_fe_wait_connected(&s->chardev, &err) < 0) {
> > + error_report_err(err);
> > + err = NULL;
> > + sleep(1);
> >      }
>
> After the reconnect loop we have some function calls to vhost backend:
> * qemu_chr_fe_set_handlers implicit calls vhost_dev_init
> * vhost_dev_get_config
> * vhost_dev_init_shm
>
> If vhost backend will restart during their execution the initialzation will be
> failed. What do you think? May be we can call these functions inside of
> the reconnect loop to fix it?
>

qemu_chr_fe_wait_connected() should be called only when we are in
disconnected state. Otherwise, it will be conflicted with reconnect
thread.

Thanks,
Yongji

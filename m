Received: from eggs.gnu.org ([2001:4830:134:3::10]:41581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUtgJ-0004pV-V1
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:27:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUtgC-00078V-14
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:27:07 -0500
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:42330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gUtgA-00077O-3k
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:26:58 -0500
Received: by mail-yb1-xb41.google.com with SMTP id s8so315857ybe.9
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 05:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20181206063552.6701-1-xieyongji@baidu.com>
	<20181206063552.6701-6-xieyongji@baidu.com>
	<932521544098909@sas1-fc7737ec834f.qloud-c.yandex.net>
In-Reply-To: <932521544098909@sas1-fc7737ec834f.qloud-c.yandex.net>
From: Yongji Xie <elohimes@gmail.com>
Date: Thu, 6 Dec 2018 21:26:44 +0800
Message-ID: <CAONzpcZJ94OjAg+nOf_WbFSZOPJ8XcYP89_kWV+qTRQjy=sTpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.0 5/6] vhost-user-blk: Add support
 for reconnecting backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yury-kotov@yandex-team.ru
Cc: marcandre.lureau@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, nixun@baidu.com, qemu-devel@nongnu.org, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Thu, 6 Dec 2018 at 20:21, Yury Kotov <yury-kotov@yandex-team.ru> wrote:
>
> 06.12.2018, 09:38, "elohimes@gmail.com" <elohimes@gmail.com>:
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > Since the new message VHOST_USER_SET_VRING_INFLIGHT,
> > the backend is able to restart safely. This patch
> > allow qemu to reconnect the backend after connection
> > closed.
> >
> > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > Signed-off-by: Ni Xun <nixun@baidu.com>
> > Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> > ---
> >  hw/block/vhost-user-blk.c | 169 +++++++++++++++++++++++++++--
> >  include/hw/virtio/vhost-user-blk.h | 4 +
> >  2 files changed, 161 insertions(+), 12 deletions(-)
> >
> > diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> > index 1451940845..663e91bcf6 100644
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
> > @@ -140,12 +140,13 @@ static void vhost_user_blk_start(VirtIODevice *vdev)
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
> > @@ -164,7 +165,6 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
> >      ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
> >      if (ret < 0) {
> >          error_report("vhost guest notifier cleanup failed: %d", ret);
> > - return;
> >      }
> >
> >      vhost_dev_disable_notifiers(&s->dev, vdev);
> > @@ -174,21 +174,39 @@ static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
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
> > + /* make sure we ignore fake guest kick by
> > + * vhost_dev_enable_notifiers() */
> > + barrier();
> > + ret = vhost_user_blk_start(vdev);
> > + if (ret < 0) {
> > + error_report("vhost-user-blk: vhost start failed: %s",
> > + strerror(-ret));
> > + qemu_chr_fe_disconnect(&s->chardev);
> > + }
> >      } else {
> >          vhost_user_blk_stop(vdev);
> > + /* make sure we ignore fake guest kick by
> > + * vhost_dev_disable_notifiers() */
> > + barrier();
> > + s->should_start = false;
> >      }
> > -
> >  }
> >
> >  static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
> > @@ -218,13 +236,22 @@ static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
> >  static void vhost_user_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> >  {
> >      VHostUserBlk *s = VHOST_USER_BLK(vdev);
> > - int i;
> > + int i, ret;
> >
> >      if (!(virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
> >          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1))) {
>
> This condition looks complicated. Is it correct? I'm not sure but may be
> the second '!' is odd. Sorry, I know that it isn't part of this patch, but it
> looks like this cond was added in one of your old patches.
>

This means we only support that case when guest driver is virtio-0.9 and host
device is virtio-1.0.

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
> > @@ -232,7 +259,13 @@ static void vhost_user_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
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
> > @@ -245,6 +278,106 @@ static void vhost_user_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> >      }
> >  }
> >
> > +static void vhost_user_blk_reset(VirtIODevice *vdev)
> > +{
> > + VHostUserBlk *s = VHOST_USER_BLK(vdev);
> > +
> > + if (s->vhost_user) {
> > + vhost_user_inflight_reset(s->vhost_user);
> > + }
> > +}
> > +
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
> > + if (s->should_start && !s->dev.started) {
>
> It seems that `!s->dev.started` is always true here because
> vhost_dev_init sets dev.started = 0 on success.
>

Good catch! Will fix it in v2.

Thanks,
Yongji

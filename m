Received: from eggs.gnu.org ([2001:4830:134:3::10]:54614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g7HOD-00040B-2S
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g7HOB-0006nM-W5
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:54:48 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g7HOA-0006iB-49
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:54:47 -0400
Received: by mail-wm1-x342.google.com with SMTP id y140-v6so4485039wmd.0
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 02:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180927143338.GA56570@bogon>
In-Reply-To: <20180927143338.GA56570@bogon>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Oct 2018 13:54:25 +0400
Message-ID: <CAJ+F1CKf5625pUPBvxv6gCX0eVeDEYBj9s08phpGe8sh4LvWaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost-user: fix qemu crash caused by
 failed backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Thu, Sep 27, 2018 at 7:37 PM Liang Li <liliangleo@didiglobal.com> wrote:
>
> During live migration, when stopping vhost-user device, 'vhost_dev_stop'
> will be called, 'vhost_dev_stop' will call a batch of 'vhost_user_read'
> and 'vhost_user_write'. If a previous 'vhost_user_read' or 'vhost_user_wr=
ite'
> failed because the vhost user backend failed, the 'CHR_EVENT_CLOSED' even=
t
> will be triggerd, followed by the call chain chr_closed_bh()->vhost_user_=
stop()->
> vhost_net_cleanup()->vhost_dev_cleanup()
>
> vhost_dev_cleanup will clear vhost_dev struct, so the later 'vhost_user_r=
ead'
> or 'vhost_user_read' will reference null pointer and cause qemu crash

Do you have a backtrace to help understand the issue?
thanks

>
> Signed-off-by: Liang Li <liliangleo@didiglobal.com>
> ---
>  hw/net/vhost_net.c        |  6 ++++++
>  hw/virtio/vhost-user.c    | 15 +++++++++++++--
>  include/hw/virtio/vhost.h |  1 +
>  include/net/vhost_net.h   |  1 +
>  net/vhost-user.c          |  3 +++
>  5 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index e037db6..77994e9 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -113,6 +113,11 @@ uint64_t vhost_net_get_features(struct vhost_net *ne=
t, uint64_t features)
>              features);
>  }
>
> +void vhost_net_mark_break_down(struct vhost_net *net)
> +{
> +    net->dev.break_down =3D true;
> +}
> +
>  void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
>  {
>      net->dev.acked_features =3D net->dev.backend_features;
> @@ -156,6 +161,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *opt=
ions)
>      net->dev.max_queues =3D 1;
>      net->dev.nvqs =3D 2;
>      net->dev.vqs =3D net->vqs;
> +    net->dev.break_down =3D false;
>
>      if (backend_kernel) {
>          r =3D vhost_net_get_fd(options->net_backend);
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index b041343..1394719 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -213,14 +213,20 @@ static bool ioeventfd_enabled(void)
>  static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
>  {
>      struct vhost_user *u =3D dev->opaque;
> -    CharBackend *chr =3D u->user->chr;
> +    CharBackend *chr;
>      uint8_t *p =3D (uint8_t *) msg;
>      int r, size =3D VHOST_USER_HDR_SIZE;
>
> +    if (dev->break_down) {
> +        goto fail;
> +    }
> +
> +    chr =3D u->user->chr;
>      r =3D qemu_chr_fe_read_all(chr, p, size);
>      if (r !=3D size) {
>          error_report("Failed to read msg header. Read %d instead of %d."
>                       " Original request %d.", r, size, msg->hdr.request)=
;
> +        dev->break_down =3D true;
>          goto fail;
>      }
>
> @@ -299,9 +305,12 @@ static int vhost_user_write(struct vhost_dev *dev, V=
hostUserMsg *msg,
>                              int *fds, int fd_num)
>  {
>      struct vhost_user *u =3D dev->opaque;
> -    CharBackend *chr =3D u->user->chr;
> +    CharBackend *chr;
>      int ret, size =3D VHOST_USER_HDR_SIZE + msg->hdr.size;
>
> +    if (dev->break_down) {
> +        return -1;
> +    }
>      /*
>       * For non-vring specific requests, like VHOST_USER_SET_MEM_TABLE,
>       * we just need send it once in the first time. For later such
> @@ -312,6 +321,7 @@ static int vhost_user_write(struct vhost_dev *dev, Vh=
ostUserMsg *msg,
>          return 0;
>      }
>
> +    chr =3D u->user->chr;
>      if (qemu_chr_fe_set_msgfds(chr, fds, fd_num) < 0) {
>          error_report("Failed to set msg fds.");
>          return -1;
> @@ -319,6 +329,7 @@ static int vhost_user_write(struct vhost_dev *dev, Vh=
ostUserMsg *msg,
>
>      ret =3D qemu_chr_fe_write_all(chr, (const uint8_t *) msg, size);
>      if (ret !=3D size) {
> +        dev->break_down =3D true;
>          error_report("Failed to write msg."
>                       " Wrote %d instead of %d.", ret, size);
>          return -1;
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index a7f449f..86d0dc5 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -74,6 +74,7 @@ struct vhost_dev {
>      bool started;
>      bool log_enabled;
>      uint64_t log_size;
> +    bool break_down;
>      Error *migration_blocker;
>      const VhostOps *vhost_ops;
>      void *opaque;
> diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
> index 77e4739..06f2c08 100644
> --- a/include/net/vhost_net.h
> +++ b/include/net/vhost_net.h
> @@ -27,6 +27,7 @@ void vhost_net_cleanup(VHostNetState *net);
>
>  uint64_t vhost_net_get_features(VHostNetState *net, uint64_t features);
>  void vhost_net_ack_features(VHostNetState *net, uint64_t features);
> +void vhost_net_mark_break_down(VHostNetState *net);
>
>  bool vhost_net_virtqueue_pending(VHostNetState *net, int n);
>  void vhost_net_virtqueue_mask(VHostNetState *net, VirtIODevice *dev,
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index a39f9c9..b99e20b 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -270,6 +270,9 @@ static void net_vhost_user_event(void *opaque, int ev=
ent)
>          if (s->watch) {
>              AioContext *ctx =3D qemu_get_current_aio_context();
>
> +            if (s->vhost_net) {
> +                vhost_net_mark_break_down(s->vhost_net);
> +            }
>              g_source_remove(s->watch);
>              s->watch =3D 0;
>              qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL,
> --
> 1.8.3.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF5Hl-0004NT-VA
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF5He-0000El-4X
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:36:23 -0400
Received: from [185.30.24.106] (port=15782
	helo=hotspot.internet-for-guests.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF5Hb-0008PV-VP
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:36:17 -0400
Date: Tue, 23 Oct 2018 18:36:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181023183454-mutt-send-email-mst@kernel.org>
References: <20180927143338.GA56570@bogon>
	<CAJ+F1CKf5625pUPBvxv6gCX0eVeDEYBj9s08phpGe8sh4LvWaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKf5625pUPBvxv6gCX0eVeDEYBj9s08phpGe8sh4LvWaQ@mail.gmail.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, QEMU <qemu-devel@nongnu.org>, liliangleo@didiglobal.com

On Tue, Oct 02, 2018 at 01:54:25PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Thu, Sep 27, 2018 at 7:37 PM Liang Li <liliangleo@didiglobal.com> wr=
ote:
> >
> > During live migration, when stopping vhost-user device, 'vhost_dev_st=
op'
> > will be called, 'vhost_dev_stop' will call a batch of 'vhost_user_rea=
d'
> > and 'vhost_user_write'. If a previous 'vhost_user_read' or 'vhost_use=
r_write'
> > failed because the vhost user backend failed, the 'CHR_EVENT_CLOSED' =
event
> > will be triggerd, followed by the call chain chr_closed_bh()->vhost_u=
ser_stop()->
> > vhost_net_cleanup()->vhost_dev_cleanup()
> >
> > vhost_dev_cleanup will clear vhost_dev struct, so the later 'vhost_us=
er_read'
> > or 'vhost_user_read' will reference null pointer and cause qemu crash
>=20
> Do you have a backtrace to help understand the issue?
> thanks


Marc-Andr=E9 you forgot to Cc the contributor with your question.
Liang Li, could you please answer Marc-Andr=E9?
It is unfortunate that we need more state, maybe there
is a way to avoid that.

Thanks!

> >
> > Signed-off-by: Liang Li <liliangleo@didiglobal.com>
> > ---
> >  hw/net/vhost_net.c        |  6 ++++++
> >  hw/virtio/vhost-user.c    | 15 +++++++++++++--
> >  include/hw/virtio/vhost.h |  1 +
> >  include/net/vhost_net.h   |  1 +
> >  net/vhost-user.c          |  3 +++
> >  5 files changed, 24 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index e037db6..77994e9 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -113,6 +113,11 @@ uint64_t vhost_net_get_features(struct vhost_net=
 *net, uint64_t features)
> >              features);
> >  }
> >
> > +void vhost_net_mark_break_down(struct vhost_net *net)
> > +{
> > +    net->dev.break_down =3D true;
> > +}
> > +
> >  void vhost_net_ack_features(struct vhost_net *net, uint64_t features=
)
> >  {
> >      net->dev.acked_features =3D net->dev.backend_features;
> > @@ -156,6 +161,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions =
*options)
> >      net->dev.max_queues =3D 1;
> >      net->dev.nvqs =3D 2;
> >      net->dev.vqs =3D net->vqs;
> > +    net->dev.break_down =3D false;
> >
> >      if (backend_kernel) {
> >          r =3D vhost_net_get_fd(options->net_backend);
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index b041343..1394719 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -213,14 +213,20 @@ static bool ioeventfd_enabled(void)
> >  static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
> >  {
> >      struct vhost_user *u =3D dev->opaque;
> > -    CharBackend *chr =3D u->user->chr;
> > +    CharBackend *chr;
> >      uint8_t *p =3D (uint8_t *) msg;
> >      int r, size =3D VHOST_USER_HDR_SIZE;
> >
> > +    if (dev->break_down) {
> > +        goto fail;
> > +    }
> > +
> > +    chr =3D u->user->chr;
> >      r =3D qemu_chr_fe_read_all(chr, p, size);
> >      if (r !=3D size) {
> >          error_report("Failed to read msg header. Read %d instead of =
%d."
> >                       " Original request %d.", r, size, msg->hdr.requ=
est);
> > +        dev->break_down =3D true;
> >          goto fail;
> >      }
> >
> > @@ -299,9 +305,12 @@ static int vhost_user_write(struct vhost_dev *de=
v, VhostUserMsg *msg,
> >                              int *fds, int fd_num)
> >  {
> >      struct vhost_user *u =3D dev->opaque;
> > -    CharBackend *chr =3D u->user->chr;
> > +    CharBackend *chr;
> >      int ret, size =3D VHOST_USER_HDR_SIZE + msg->hdr.size;
> >
> > +    if (dev->break_down) {
> > +        return -1;
> > +    }
> >      /*
> >       * For non-vring specific requests, like VHOST_USER_SET_MEM_TABL=
E,
> >       * we just need send it once in the first time. For later such
> > @@ -312,6 +321,7 @@ static int vhost_user_write(struct vhost_dev *dev=
, VhostUserMsg *msg,
> >          return 0;
> >      }
> >
> > +    chr =3D u->user->chr;
> >      if (qemu_chr_fe_set_msgfds(chr, fds, fd_num) < 0) {
> >          error_report("Failed to set msg fds.");
> >          return -1;
> > @@ -319,6 +329,7 @@ static int vhost_user_write(struct vhost_dev *dev=
, VhostUserMsg *msg,
> >
> >      ret =3D qemu_chr_fe_write_all(chr, (const uint8_t *) msg, size);
> >      if (ret !=3D size) {
> > +        dev->break_down =3D true;
> >          error_report("Failed to write msg."
> >                       " Wrote %d instead of %d.", ret, size);
> >          return -1;
> > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > index a7f449f..86d0dc5 100644
> > --- a/include/hw/virtio/vhost.h
> > +++ b/include/hw/virtio/vhost.h
> > @@ -74,6 +74,7 @@ struct vhost_dev {
> >      bool started;
> >      bool log_enabled;
> >      uint64_t log_size;
> > +    bool break_down;
> >      Error *migration_blocker;
> >      const VhostOps *vhost_ops;
> >      void *opaque;
> > diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
> > index 77e4739..06f2c08 100644
> > --- a/include/net/vhost_net.h
> > +++ b/include/net/vhost_net.h
> > @@ -27,6 +27,7 @@ void vhost_net_cleanup(VHostNetState *net);
> >
> >  uint64_t vhost_net_get_features(VHostNetState *net, uint64_t feature=
s);
> >  void vhost_net_ack_features(VHostNetState *net, uint64_t features);
> > +void vhost_net_mark_break_down(VHostNetState *net);
> >
> >  bool vhost_net_virtqueue_pending(VHostNetState *net, int n);
> >  void vhost_net_virtqueue_mask(VHostNetState *net, VirtIODevice *dev,
> > diff --git a/net/vhost-user.c b/net/vhost-user.c
> > index a39f9c9..b99e20b 100644
> > --- a/net/vhost-user.c
> > +++ b/net/vhost-user.c
> > @@ -270,6 +270,9 @@ static void net_vhost_user_event(void *opaque, in=
t event)
> >          if (s->watch) {
> >              AioContext *ctx =3D qemu_get_current_aio_context();
> >
> > +            if (s->vhost_net) {
> > +                vhost_net_mark_break_down(s->vhost_net);
> > +            }
> >              g_source_remove(s->watch);
> >              s->watch =3D 0;
> >              qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL=
,
> > --
> > 1.8.3.1
> >
> >
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau

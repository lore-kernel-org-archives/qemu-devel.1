Received: from eggs.gnu.org ([209.51.188.92]:37199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1gvfhh-00048Y-MA
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1gvfhf-0006v1-GH
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:59:13 -0500
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:40941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
	id 1gvfhd-0006ob-GI
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:59:09 -0500
Received: by mail-yw1-xc41.google.com with SMTP id c67so6217607ywa.7
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 01:59:01 -0800 (PST)
MIME-Version: 1.0
References: <20190213145116.20654-1-yuri.benditovich@daynix.com>
	<0801b4b7-ac54-1374-3d97-a59a10579218@redhat.com>
In-Reply-To: <0801b4b7-ac54-1374-3d97-a59a10579218@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 18 Feb 2019 11:58:51 +0200
Message-ID: <CAOEp5Od-1AY=6ARRD9J=W2ZhYqEgKpmMBMcm1fiqSCjLRVREyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-net: do not start queues that are
 not enabled by the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Yan Vugenfirer <yan@daynix.com>

On Mon, Feb 18, 2019 at 5:49 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2019/2/13 =E4=B8=8B=E5=8D=8810:51, Yuri Benditovich wrote:
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1608226
> > On startup/link-up in multiqueue configuration the virtio-net
> > tries to starts all the queues, including those that the guest
> > will not enable by VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET.
> > If the guest driver does not allocate queues that it will not
> > use (for example, Windows driver does not) and number of actually
> > used queues is less that maximal number supported by the device,
>
>
> Is this a requirement of e.g NDIS? If not, could we simply allocate all
> queues in this case. This is usually what normal Linux driver did.
>
>
> > this causes vhost_net_start to fail and actually disables vhost
> > for all the queues, reducing the performance.
> > Current commit fixes this: initially only first queue is started,
> > upon VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET started all the queues
> > requested by the guest.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >   hw/net/virtio-net.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 3f319ef723..d3b1ac6d3a 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -174,7 +174,7 @@ static void virtio_net_vhost_status(VirtIONet *n, u=
int8_t status)
> >   {
> >       VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> >       NetClientState *nc =3D qemu_get_queue(n->nic);
> > -    int queues =3D n->multiqueue ? n->max_queues : 1;
> > +    int queues =3D n->multiqueue ? n->curr_queues : 1;
> >
> >       if (!get_vhost_net(nc->peer)) {
> >           return;
> > @@ -1016,9 +1016,12 @@ static int virtio_net_handle_mq(VirtIONet *n, ui=
nt8_t cmd,
> >           return VIRTIO_NET_ERR;
> >       }
> >
> > -    n->curr_queues =3D queues;
> >       /* stop the backend before changing the number of queues to avoid=
 handling a
> >        * disabled queue */
> > +    virtio_net_set_status(vdev, 0);
>
>
> Any reason for doing this?

I think there are 2 reasons:
1. The spec does not require guest SW to allocate unused queues.
2. We spend guest's physical memory to just make vhost happy when it
touches queues that it should not use.

Thanks,
Yuri Benditovich

>
> Thanks
>
>
> > +
> > +    n->curr_queues =3D queues;
> > +
> >       virtio_net_set_status(vdev, vdev->status);
> >       virtio_net_set_queues(n);
> >

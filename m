Received: from eggs.gnu.org ([209.51.188.92]:60789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=996b1c52f=Paul.Durrant@citrix.com>)
	id 1hEFBl-0004oS-JW
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=996b1c52f=Paul.Durrant@citrix.com>)
	id 1hEFBk-0006gx-Fz
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:31:01 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 10 Apr 2019 15:20:05 +0000
Message-ID: <582f92f1ddf24985b75c32fe913784df@AMSPEX02CL01.citrite.net>
References: <20190408151617.13025-1-paul.durrant@citrix.com>
	<20190408151617.13025-3-paul.durrant@citrix.com>
	<20190410125708.GE1435@perard.uk.xensource.com>
In-Reply-To: <20190410125708.GE1435@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/3] xen-bus: allow AioContext to be
 specified for each event channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 10 April 2019 13:57
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-devel@lists.xenproj=
ect.org; Stefano Stabellini
> <sstabellini@kernel.org>; Stefan Hajnoczi <stefanha@redhat.com>; Kevin Wo=
lf <kwolf@redhat.com>; Max
> Reitz <mreitz@redhat.com>
> Subject: Re: [PATCH 2/3] xen-bus: allow AioContext to be specified for ea=
ch event channel
>=20
> On Mon, Apr 08, 2019 at 04:16:16PM +0100, Paul Durrant wrote:
> > This patch adds an AioContext parameter to xen_device_bind_event_channe=
l()
> > and then uses aio_set_fd_handler() to set the callback rather than
> > qemu_set_fd_handler().
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > ---
> > @@ -943,6 +944,7 @@ static void xen_device_event(void *opaque)
> >  }
> >
> >  XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
> > +                                               AioContext *ctx,
> >                                                 unsigned int port,
> >                                                 XenEventHandler handler=
,
> >                                                 void *opaque, Error **e=
rrp)
> > @@ -968,8 +970,9 @@ XenEventChannel *xen_device_bind_event_channel(XenD=
evice *xendev,
> >      channel->handler =3D handler;
> >      channel->opaque =3D opaque;
> >
> > -    qemu_set_fd_handler(xenevtchn_fd(channel->xeh), xen_device_event, =
NULL,
> > -                        channel);
> > +    channel->ctx =3D ctx;
> > +    aio_set_fd_handler(channel->ctx, xenevtchn_fd(channel->xeh), false=
,
> > +                       xen_device_event, NULL, NULL, channel);
>=20
> I wonder if the `'is_external' parameter of aio_set_fd_handler shoud be
> `true' here, instead. That flag seems to be used when making a snapshot
> of a blockdev, for example.
>=20
> That was introduced by:
> dca21ef23ba48f6f1428c59f295a857e5dc203c8^..c07bc2c1658fffeee08eb46402b2f6=
6d55b07586
>=20
> What do you think?

Interesting. I admit I was merely transcribing what qemu_set_fd_handler() p=
asses without really looking into the values. Looking at the arguments that=
 virtio-blk passes to aio_set_event_notifier() though, and what 'is_externa=
l' means, it would appear that setting it to true is probably the right thi=
ng to do. Do you want me to send a v2 of the series or can you fix it up?

  Cheers,

    Paul

>=20
>=20
> --
> Anthony PERARD

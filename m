Received: from eggs.gnu.org ([209.51.188.92]:58760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hEF49-0000XG-8r
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hEF48-0002pp-7m
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:23:09 -0400
Date: Wed, 10 Apr 2019 16:22:58 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190410152258.GG1435@perard.uk.xensource.com>
References: <20190408151617.13025-1-paul.durrant@citrix.com>
	<20190408151617.13025-3-paul.durrant@citrix.com>
	<20190410125708.GE1435@perard.uk.xensource.com>
	<582f92f1ddf24985b75c32fe913784df@AMSPEX02CL01.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <582f92f1ddf24985b75c32fe913784df@AMSPEX02CL01.citrite.net>
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
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, Apr 10, 2019 at 04:20:05PM +0100, Paul Durrant wrote:
> > -----Original Message-----
> > From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> > Sent: 10 April 2019 13:57
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-devel@lists.xenproject.org; Stefano Stabellini
> > <sstabellini@kernel.org>; Stefan Hajnoczi <stefanha@redhat.com>; Kevin Wolf <kwolf@redhat.com>; Max
> > Reitz <mreitz@redhat.com>
> > Subject: Re: [PATCH 2/3] xen-bus: allow AioContext to be specified for each event channel
> > 
> > On Mon, Apr 08, 2019 at 04:16:16PM +0100, Paul Durrant wrote:
> > > This patch adds an AioContext parameter to xen_device_bind_event_channel()
> > > and then uses aio_set_fd_handler() to set the callback rather than
> > > qemu_set_fd_handler().
> > >
> > > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > > ---
> > > @@ -943,6 +944,7 @@ static void xen_device_event(void *opaque)
> > >  }
> > >
> > >  XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
> > > +                                               AioContext *ctx,
> > >                                                 unsigned int port,
> > >                                                 XenEventHandler handler,
> > >                                                 void *opaque, Error **errp)
> > > @@ -968,8 +970,9 @@ XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
> > >      channel->handler = handler;
> > >      channel->opaque = opaque;
> > >
> > > -    qemu_set_fd_handler(xenevtchn_fd(channel->xeh), xen_device_event, NULL,
> > > -                        channel);
> > > +    channel->ctx = ctx;
> > > +    aio_set_fd_handler(channel->ctx, xenevtchn_fd(channel->xeh), false,
> > > +                       xen_device_event, NULL, NULL, channel);
> > 
> > I wonder if the `'is_external' parameter of aio_set_fd_handler shoud be
> > `true' here, instead. That flag seems to be used when making a snapshot
> > of a blockdev, for example.
> > 
> > That was introduced by:
> > dca21ef23ba48f6f1428c59f295a857e5dc203c8^..c07bc2c1658fffeee08eb46402b2f66d55b07586
> > 
> > What do you think?
> 
> Interesting. I admit I was merely transcribing what qemu_set_fd_handler() passes without really looking into the values. Looking at the arguments that virtio-blk passes to aio_set_event_notifier() though, and what 'is_external' means, it would appear that setting it to true is probably the right thing to do. Do you want me to send a v2 of the series or can you fix it up?

I'll fix that up.

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

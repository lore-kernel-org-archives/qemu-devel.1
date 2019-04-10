Received: from eggs.gnu.org ([209.51.188.92]:53883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hECmx-0000cM-3p
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hECmw-0003LM-3X
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:57:15 -0400
Date: Wed, 10 Apr 2019 13:57:08 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190410125708.GE1435@perard.uk.xensource.com>
References: <20190408151617.13025-1-paul.durrant@citrix.com>
	<20190408151617.13025-3-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190408151617.13025-3-paul.durrant@citrix.com>
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
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Mon, Apr 08, 2019 at 04:16:16PM +0100, Paul Durrant wrote:
> This patch adds an AioContext parameter to xen_device_bind_event_channel()
> and then uses aio_set_fd_handler() to set the callback rather than
> qemu_set_fd_handler().
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> @@ -943,6 +944,7 @@ static void xen_device_event(void *opaque)
>  }
>  
>  XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
> +                                               AioContext *ctx,
>                                                 unsigned int port,
>                                                 XenEventHandler handler,
>                                                 void *opaque, Error **errp)
> @@ -968,8 +970,9 @@ XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
>      channel->handler = handler;
>      channel->opaque = opaque;
>  
> -    qemu_set_fd_handler(xenevtchn_fd(channel->xeh), xen_device_event, NULL,
> -                        channel);
> +    channel->ctx = ctx;
> +    aio_set_fd_handler(channel->ctx, xenevtchn_fd(channel->xeh), false,
> +                       xen_device_event, NULL, NULL, channel);

I wonder if the `'is_external' parameter of aio_set_fd_handler shoud be
`true' here, instead. That flag seems to be used when making a snapshot
of a blockdev, for example.

That was introduced by:
dca21ef23ba48f6f1428c59f295a857e5dc203c8^..c07bc2c1658fffeee08eb46402b2f66d55b07586

What do you think?


-- 
Anthony PERARD

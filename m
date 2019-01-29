Received: from eggs.gnu.org ([209.51.188.92]:59804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=925d89a54=Paul.Durrant@citrix.com>)
	id 1goTR4-0007YB-AI
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:28:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=925d89a54=Paul.Durrant@citrix.com>)
	id 1goTR3-0007yL-EX
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:28:18 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 29 Jan 2019 13:27:57 +0000
Message-ID: <d90fbb449fa04875ae7ec44d645c076a@AMSPEX02CL03.citrite.net>
References: <20190123090849.7758-1-paul.durrant@citrix.com>
	<20190129122514.GB2306@perard.uk.xensource.com>
In-Reply-To: <20190129122514.GB2306@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] xen-block: handle resize callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano
	Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 29 January 2019 12:25
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: xen-devel@lists.xenproject.org; qemu-block@nongnu.org; qemu-
> devel@nongnu.org; Stefan Hajnoczi <stefanha@redhat.com>; Stefano
> Stabellini <sstabellini@kernel.org>; Kevin Wolf <kwolf@redhat.com>; Max
> Reitz <mreitz@redhat.com>
> Subject: Re: [PATCH] xen-block: handle resize callback
>=20
> On Wed, Jan 23, 2019 at 09:08:49AM +0000, Paul Durrant wrote:
> > Some frontend drivers will handle dynamic resizing of PV disks, so set
> up
> > the BlockDevOps resize_cb() method during xen_block_realize() to allow
> > this to be done.
>=20
> "will": which drivers are you thinking about? The Linux one seems to be
> able to handle resize already.

Yes, that's what I meant by 'will'... it wasn't supposed to imply future te=
nse. English can be confusing :-/

>=20
> About the Linux one, it check the new size only when the backend set
> its "state" to "connected" again.
> It's frontend seems to implement resize with
> 1fa73be6be65028a7543bba8f14474b42e064a1b.
> There is this is the source code:
>     static void blkfront_connect(struct blkfront_info *info)
>     {
>         // ...
>         switch (info->connected) {
>         case BLKIF_STATE_CONNECTED:
>                 /*
>                  * Potentially, the back-end may be signalling
>                  * a capacity change; update the capacity.
>                  */
>=20
> In the backend, Linux does this:
>     xenbus_printf(xbt, dev->nodename, "sectors", "%llu", ...
>     /*
>      * Write the current state; we will use this to synchronize
>      * the front-end. If the current state is "connected" the
>      * front-end will get the new size information online.
>      */
>      xenbus_printf(xbt, dev->nodename, "state", "%d", dev->state);
>=20
> Maybe the QEMU backend needs do to the same thing, and write its current
> state again?

Yes, that can easily be done. The Windows frontend simply re-reads 'sectors=
' whenever it sees any change in the backend area (it watches the top level=
 key rather than just the 'state' key).

>=20
> FreeBSD doesn't seems to care about resize.
>=20
> And there is nothing in blkif.h about resizing :(.

Nope, hence the discrepancy between the frontend implementations. I can sen=
d a patch to xen-devel to note the existing state of affairs and perhaps st=
andardize on the re-writing of 'state' being the official way to inform the=
 frontend.

  Paul

>=20
> Thanks,
>=20
> --
> Anthony PERARD

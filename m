Received: from eggs.gnu.org ([2001:4830:134:3::10]:54228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=875e259b5=Paul.Durrant@citrix.com>)
	id 1gWI5x-0003zq-0C
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 04:43:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=875e259b5=Paul.Durrant@citrix.com>)
	id 1gWI5t-00059Z-Qg
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 04:43:20 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Mon, 10 Dec 2018 09:43:13 +0000
Message-ID: <d9341649ac2a40fd97c848a2d5187d58@AMSPEX02CL03.citrite.net>
References: <1544108924-10841-1-git-send-email-paul.durrant@citrix.com>
	<1544108924-10841-6-git-send-email-paul.durrant@citrix.com>
	<20181207155745.GI18875@perard.uk.xensource.com>
In-Reply-To: <20181207155745.GI18875@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 05/18] xen: add xenstore watcher
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 07 December 2018 15:58
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-
> devel@lists.xenproject.org; Kevin Wolf <kwolf@redhat.com>; Max Reitz
> <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH v2 05/18] xen: add xenstore watcher infrastructure
>=20
> On Thu, Dec 06, 2018 at 03:08:31PM +0000, Paul Durrant wrote:
> > @@ -36,6 +54,12 @@ static void xen_block_unrealize(XenDevice *xendev,
> Error **errp)
> >
> >      trace_xen_block_unrealize(type, vdev->disk, vdev->partition);
> >
> > +    /* Disconnect from the frontend in case this has not already
> happened */
> > +    xen_block_disconnect(xendev, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
>=20
> If xen_block_disconnect fails, local_err is going to be reuse below. If
> it's fine to try unrealize, then `local_err=3DNULL` is probably enough.
>=20

Actually, on this path there is nothing useful to be done with an error... =
disconnect really really should not fail, so I'll pass NULL instead to igno=
re any error.

> > +    }
> > +
> >      if (blockdev_class->unrealize) {
> >          blockdev_class->unrealize(blockdev, &local_err);
> >          if (local_err) {
>=20
> [...]
>=20
> > +static void xen_bus_remove_watch(XenBus *xenbus, XenWatch *watch,
> > +                                 Error **errp)
> > +{
> > +    Error *local_err =3D NULL;
> > +
> > +    trace_xen_bus_remove_watch(watch->node, watch->key, watch->token);
> > +
> > +    xs_node_unwatch(xenbus->xsh, watch->node, watch->key, watch->token=
,
> > +                    &local_err);
>=20
> You could simply pass `errp' directly instead of having `local_err'.
>=20

Indeed.

  Paul

> > +
> > +    notifier_remove(&watch->notifier);
> > +    free_watch(watch);
> > +
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +    }
> > +}
> > +
>=20
> --
> Anthony PERARD

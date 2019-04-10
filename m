Received: from eggs.gnu.org ([209.51.188.92]:37881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=996b1c52f=Paul.Durrant@citrix.com>)
	id 1hEFZQ-0006TS-Hr
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=996b1c52f=Paul.Durrant@citrix.com>)
	id 1hEFZP-0004z0-Aa
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:55:28 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 10 Apr 2019 15:55:24 +0000
Message-ID: <f76a3a96fabc4afbb96586a9b5fe682f@AMSPEX02CL01.citrite.net>
References: <20190409164038.25484-1-paul.durrant@citrix.com>
	<20190410155217.GH1435@perard.uk.xensource.com>
In-Reply-To: <20190410155217.GH1435@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] xen-block: support
 feature-large-sector-size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 10 April 2019 16:52
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; qemu-block@non=
gnu.org; Stefano Stabellini
> <sstabellini@kernel.org>; Stefan Hajnoczi <stefanha@redhat.com>; Kevin Wo=
lf <kwolf@redhat.com>; Max
> Reitz <mreitz@redhat.com>
> Subject: Re: [PATCH] xen-block: support feature-large-sector-size
>=20
> On Tue, Apr 09, 2019 at 05:40:38PM +0100, Paul Durrant wrote:
> > A recent Xen commit [1] clarified the semantics of sector based quantit=
ies
> > used in the blkif protocol such that it is now safe to create a xen-blo=
ck
> > device with a logical_block_size !=3D 512, as long as the device only
> > connects to a frontend advertizing 'feature-large-block-size'.
> >
> > This patch modifies xen-block accordingly. It also uses a stack variabl=
e
> > for the BlockBackend in xen_block_realize() to avoid repeated dereferen=
cing
> > of the BlockConf pointer, and changes the parameters of
> > xen_block_dataplane_create() so that the BlockBackend pointer and secto=
r
> > size are passed expicitly rather than implicitly via the BlockConf.
> >
> > These modifications have been tested against a recent Windows PV XENVBD
> > driver [2] using a xen-disk device with a 4kB logical block size.
> >
> > [1] http://xenbits.xen.org/gitweb/?p=3Dxen.git;a=3Dcommit;h=3D67e1c050e=
36b2c9900cca83618e56189effbad98
> > [2] https://winpvdrvbuild.xenproject.org:8080/job/XENVBD-master/126
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > ---
> > diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> > index ef635be4c2..05e890ad78 100644
> > --- a/hw/block/xen-block.c
> > +++ b/hw/block/xen-block.c
> > @@ -51,11 +51,25 @@ static void xen_block_connect(XenDevice *xendev, Er=
ror **errp)
> [...]
> > +    if (xen_device_frontend_scanf(xendev, "feature-large-sector-size",=
 "%u",
> > +                                  &feature_large_sector_size) !=3D 1) =
{
> > +        feature_large_sector_size =3D 0;
> > +    }
> > +
> > +    if (feature_large_sector_size !=3D 1 &&
> > +        conf->logical_block_size !=3D XEN_BLKIF_SECTOR_SIZE) {
> > +        error_setg(errp, "logical_block_size !=3D %u not supported",
>=20
> Maybe add "by frontend" to the error message?

Yes, I'm fine with that addition.

>=20
> > +                   XEN_BLKIF_SECTOR_SIZE);
> > +        return;
> > +    }
> > +
>=20
> With the question answered:
> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
>=20

Thanks,

  Paul

> Thanks,
>=20
> --
> Anthony PERARD

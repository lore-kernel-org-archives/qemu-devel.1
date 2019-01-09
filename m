Received: from eggs.gnu.org ([209.51.188.92]:38086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=90559c3de=Paul.Durrant@citrix.com>)
	id 1ghD0L-0001Ov-PW
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=90559c3de=Paul.Durrant@citrix.com>)
	id 1ghD0K-0006jz-QD
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:30:41 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 9 Jan 2019 12:30:32 +0000
Message-ID: <0793685d4bb64aeeb425ec867cc189bb@AMSPEX02CL03.citrite.net>
References: <20190108144903.8249-1-paul.durrant@citrix.com>
	<20190108144903.8249-17-paul.durrant@citrix.com>
	<20190109120916.GI1508@perard.uk.xensource.com>
In-Reply-To: <20190109120916.GI1508@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v9 16/18] xen: automatically create
 XenBlockDevice-s
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
> Sent: 09 January 2019 12:09
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-
> devel@lists.xenproject.org; Kevin Wolf <kwolf@redhat.com>; Max Reitz
> <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH v9 16/18] xen: automatically create XenBlockDevice-s
>=20
> On Tue, Jan 08, 2019 at 02:49:01PM +0000, Paul Durrant wrote:
> > This patch adds create and destroy function for XenBlockDevice-s so tha=
t
> > they can be created automatically when the Xen toolstack instantiates a
> new
> > PV backend via xenstore. When the XenBlockDevice is created this way it
> is
> > also necessary to create a 'drive' which matches the configuration that
> the
> > Xen toolstack has written into xenstore. This is done by formulating th=
e
> > parameters necessary for each 'blockdev' layer of the drive and then
> using
> > qmp_blockdev_add() to create the layers. Also, for compatibility with
> the
> > legacy 'xen_disk' implementation, an iothread is automatically created
> for
> > the new XenBlockDevice. This, like the driver layers, will be destroyed
> > after the XenBlockDevice is unrealized.
> >
> > The legacy backend scan for 'qdisk' is removed by this patch, which
> makes
> > the 'xen_disk' code is redundant. The code will be removed by a
> subsequent
> > patch.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > Signed-off-by: Anthony Perard <anthony.perard@citrix.com>
> > ---
>=20
> > diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> > index a7c37c185a..c6ec1d9543 100644
> > --- a/hw/block/xen-block.c
> > +++ b/hw/block/xen-block.c
> > @@ -7,12 +7,20 @@
> ...
>=20
> > +static XenBlockDrive *xen_block_drive_create(const char *id,
> > +                                             const char *device_type,
> > +                                             QDict *opts, Error **errp=
)
> > +{
> ...
> > +    Error *local_err =3D NULL;
> ...
> > +    if (!filename) {
> > +        error_setg(errp, "no filename");
> > +        goto done;
> > +    }
> ...
> > +    drive->node_name =3D xen_block_blockdev_add(drive->id, driver_laye=
r,
> > +                                              &local_err);
> > +
> > +done:
> > +    g_free(driver);
> > +    g_free(filename);
> > +
> > +    if (local_err) {
>=20
> When xen_block_blockdev_add failed, it sets local_err, but nothing after
> sets errp. I'm going to add this while preparing the pull request:
>=20
>     error_propagate(errp, local_err);
>=20
> Is this fine with you?

Yes, that's fine... the error should have indeed been propagated.

>=20
> With that fix, I think the series is ready, so:
> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
>=20

Thanks.

> > +        xen_block_drive_destroy(drive, NULL);
> > +        return NULL;
> > +    }
> > +
> > +    return drive;
> > +}
>=20
> There is still the warning about using the 'file' driver when
> 'host_device' should be use, but I think we can try to fix that later.

TBH I'm hoping this code can go away before we have to worry about it. We n=
eed to teach libxl how to issue the necessary QMP commands directly; it sho=
uld know the difference between a file and a device.

  Paul

>=20
> Thanks,
>=20
> --
> Anthony PERARD

Received: from eggs.gnu.org ([208.118.235.92]:58333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=900e14805=Paul.Durrant@citrix.com>)
	id 1gfSWa-00074F-U2
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:40:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=900e14805=Paul.Durrant@citrix.com>)
	id 1gfSWX-0005DT-Pj
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:40:44 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Fri, 4 Jan 2019 16:40:39 +0000
Message-ID: <da727b0b8a9a4f9baa47a660298a9cba@AMSPEX02CL03.citrite.net>
References: <20181220171439.11159-1-paul.durrant@citrix.com>
	<20181220171439.11159-17-paul.durrant@citrix.com>
	<20190104163124.GE1508@perard.uk.xensource.com>
In-Reply-To: <20190104163124.GE1508@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 16/18] xen: automatically create
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
> Sent: 04 January 2019 16:31
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-
> devel@lists.xenproject.org; Kevin Wolf <kwolf@redhat.com>; Max Reitz
> <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH v7 16/18] xen: automatically create XenBlockDevice-s
>=20
> Almost done, there is one thing left which I believe is an issue.
> Whenever I attach a raw file to QEMU, it print:
>     qemu-system-i386: warning: Opening a block device as a file using the
> 'file' driver is deprecated

Oh, I'd not noticed that... but then I only use raw files occasionally.

>=20
> So, I think the comment below isn't true. We should create a "raw"
> driver for "raw" files.
>=20
> On Thu, Dec 20, 2018 at 05:14:37PM +0000, Paul Durrant wrote:
> > +static XenBlockDrive *xen_block_drive_create(const char *id,
> > +                                             const char *device_type,
> > +                                             QDict *opts, Error **errp=
)
> > +{
> ...
>=20
> > +    if (params) {
> > +        char **v =3D g_strsplit(params, ":", 2);
> > +
> > +        if (v[1] =3D=3D NULL) {
> > +            filename =3D g_strdup(v[0]);
> > +            driver =3D g_strdup("file");
> > +        } else {
> > +            if (strcmp(v[0], "aio") =3D=3D 0) {
> > +                driver =3D g_strdup("file");
> > +            } else if (strcmp(v[0], "vhd") =3D=3D 0) {
> > +                driver =3D g_strdup("vpc");
> > +            } else {
> > +                driver =3D g_strdup(v[0]);
> > +            }
> > +            filename =3D g_strdup(v[1]);
> > +        }
> > +
> > +        g_strfreev(v);
> > +    }
> > +
> ...
>=20
> > +    /* If the image is a raw file then we are done */
>=20
> raw files should use the "raw" driver, so we aren't done yet.
>=20

Ok. Having a strictly 2-layer stack actually makes things simpler anyway :-=
)

  Paul

> > +    if (!strcmp(driver, "file")) {
> > +        goto done;
> > +    }
>=20
> --
> Anthony PERARD

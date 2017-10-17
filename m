Received: from eggs.gnu.org ([2001:4830:134:3::10]:39848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1e4T7V-0004Co-3q
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1e4T7S-0001cB-0n
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:45:25 -0400
Date: Tue, 17 Oct 2017 16:44:55 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20171017144455.GH6127@andariel.pipo.sk>
References: <bdbb9d79839f3149db9cf2ff11a2cc04977e0a64.1507817548.git.pkrempa@redhat.com>
	<20171017144100.GC7660@dhcp-200-186.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="io440R/5/oAEBxrM"
Content-Disposition: inline
In-Reply-To: <20171017144100.GC7660@dhcp-200-186.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: don't add 'driver' to options when
 refering to backing via node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org


--io440R/5/oAEBxrM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2017 at 16:41:00 +0200, Kevin Wolf wrote:
> Am 12.10.2017 um 16:14 hat Peter Krempa geschrieben:
> > When refering to a backing file of an image via node name
> > bdrv_open_backing_file would add the 'driver' option to the option list
> > filling it with the backing format driver. This breaks construction of
> > the backing chain via -blockdev, as bdrv_open_inherit reports an error
> > if both 'reference' and 'options' are provided.
> >=20
> > Signed-off-by: Peter Krempa <pkrempa@redhat.com>
>=20
> If you don't mind, I'd add a specific example to the commit message:

I certainly don't mind. I was frustrated after some attempts to find
bugs in my code using it before looking into qemu so I forgot to add
the info. (Also it would take me some time to figure out that I have the
backing format specified in the overlay image).

>=20
> $ qemu-img create -f raw /tmp/backing.raw 64M
> $ qemu-img create -f qcow2 -F raw -b /tmp/backing.raw /tmp/test.qcow2
> $ qemu-system-x86_64 \
>   -blockdev driver=3Dfile,filename=3D/tmp/backing.raw,node-name=3Dbacking=
 \
>   -blockdev driver=3Dqcow2,file.driver=3Dfile,file.filename=3D/tmp/test.q=
cow2,node-name=3Droot,backing=3Dbacking
> qemu-system-x86_64: -blockdev driver=3Dqcow2,file.driver=3Dfile,file.file=
name=3D/tmp/test.qcow2,node-name=3Droot,backing=3Dbacking: Could not open b=
acking file: Cannot reference an existing block device with additional opti=
ons or a new filename
>=20
> > diff --git a/block.c b/block.c
> > index 46eb1728da..684cb018da 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -2245,7 +2245,8 @@ int bdrv_open_backing_file(BlockDriverState *bs, =
QDict *parent_options,
> >          goto free_exit;
> >      }
> >=20
> > -    if (bs->backing_format[0] !=3D '\0' && !qdict_haskey(options, "dri=
ver")) {
> > +    if (!reference &&
> > +        bs->backing_format[0] !=3D '\0' && !qdict_haskey(options, "dri=
ver")) {
> >          qdict_put_str(options, "driver", bs->backing_format);
> >      }
>=20
> Looks good to me.

Thanks.

--io440R/5/oAEBxrM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlnmF2EACgkQHGwCByjY
1GpiNRAAyWPzFUSBgICpw3ZxajHN2gwavPKkg29LrP03/kBSAjUDcEREgfrH3I2k
5MhSFnEWQVONLJlf6dHAtpn7lhCD2v9cUAwRv066a5FTtUaVekMfnc0g79xjj0o1
+hpFuo0kHiU6noAPdYnWX9AzY3RXNos+p1Hh8Irc8XWBY/3nY0wsOB2B3qwZoUsF
clOMi8JayxShNaEnwe4TlSE8+SkjUwOScVGbl4sKmLBRzHXYoyaVfP3nER6fJ0l3
OZv0K0sbyA5rs/vOB3ONuI/wyE/1T0S8t6UPFxPn6eFukIrOJkJTyaePHdkh32tG
pHpJfbC9Clq65aSjPF+Gu0FlJVdeRGDuktOIznn8OJbUjg0QkDSvb6cPVkTjXqOS
djI+LPBcE/egzEAe/+tznMrl+6VeDUiznlIdsbcLZn/Ju7jOYhnB6dqP26aHWiHW
Ek1kwRfba0Y2IVLKKnwAbM3YIapeGoz9oB/u2v8t8Hd98Mj6D3gZYpylTvjnaV3D
tVIoGjmm+dOA5sBwJoYawuUilF+uFiyiagfmkzRhZhFrfDltwDvgGihfh5m2sZnP
+ir9Na7SKTGb9R62WJAwbMEg0AS2/vrPBQIFJA4cw7oeyr5xnZid3v4aEApCfO4p
c+oY5IP275o51PhcvhLJ0BlalbuWYB2Tt3tNwlWY8ThlfTalLXM=
=6DRj
-----END PGP SIGNATURE-----

--io440R/5/oAEBxrM--

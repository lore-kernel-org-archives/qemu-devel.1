Received: from eggs.gnu.org ([209.51.188.92]:59497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxGOc-0002bG-JR
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:22:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxGOa-00052N-Hr
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:22:06 -0500
References: <20190219125044.5416-1-berrange@redhat.com>
	<20190219125044.5416-3-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8b0ac3aa-259e-da75-e2d0-d5e72959cdbf@redhat.com>
Date: Fri, 22 Feb 2019 20:21:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190219125044.5416-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="juFwilkHb68GTfupFMqcHzfQ4el4lS4Oe"
Subject: Re: [Qemu-devel] [PATCH 2/2] qcow2: mark image as corrupt if
 failing during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--juFwilkHb68GTfupFMqcHzfQ4el4lS4Oe
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <8b0ac3aa-259e-da75-e2d0-d5e72959cdbf@redhat.com>
Subject: Re: [PATCH 2/2] qcow2: mark image as corrupt if failing during create
References: <20190219125044.5416-1-berrange@redhat.com>
 <20190219125044.5416-3-berrange@redhat.com>
In-Reply-To: <20190219125044.5416-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.02.19 13:50, Daniel P. Berrang=C3=A9 wrote:
> During creation we write a minimal qcow2 header and then update it with=

> extra features. If the updating fails for some reason we might still be=

> left with a valid qcow2 image that will be mistakenly used for I/O. We
> cannot delete the image, since we don't know if we created the
> underlying storage or not. Thus we mark the header as corrupt to
> prevents its later usage.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  block/qcow2.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index ecc577175f..338513e652 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3104,6 +3104,9 @@ qcow2_co_create(BlockdevCreateOptions *create_opt=
ions, Error **errp)
> =20
>      ret =3D 0;
>  out:
> +    if (ret < 0) {
> +        qcow2_mark_corrupt(blk_bs(blk));

First, blk_bs(blk) may be the qcow2 BDS, or it may the protocol BDS here
(it is the latter before the first blk_new_open() call).  Calling
qcow2_mark_corrupt() unconditionally may mean an invalid access to
bs->opaque (which is not going to be of type BDRVQcow2State if the BDS
is not a qcow2 BDS).

Second, blk may be NULL (at various points, e.g. after blk_new_open()
failed).  Then this would yield a segfault in in blk_bs().

Third, blk_bs(blk) may be NULL (if blk_insert_bs() failed).  Then this
would yield a segfault in qcow2_mark_corrupt().

On a minor note, it is rather probably that blk_new_open() fails.  In
that case, there is currently no way to mark the image corrupt.  Would
it be useful and possible to have a function to mark a qcow2 image
corrupt without relying on qcow2 features, i.e. by writing directly to
the protocol layer (which is always @bs)?  This would be unsafe to use
as long as the protocol layer is opened by the qcow2 driver in some
other node, but we could invoke this function safely after @blk has been
freed.


Or maybe Eric's suggestion really is for the best, i.e. mark the image
corrupt from the start and then clean that after we're all done.  You
don't need a new flag for that, we already have BDRV_O_CHECK.

Max

> +    }
>      blk_unref(blk);
>      bdrv_unref(bs);
>      return ret;
>=20



--juFwilkHb68GTfupFMqcHzfQ4el4lS4Oe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxwS7YACgkQ9AfbAGHV
z0DRIAf/Qdkcjr5jnOE7NubNVYS+TY9is0dNxJ5ZjSo8VES3bNhf2f19yP8Bi+h3
UiGPXSqrhln1C5IeYf4jhxWCNTnK4kiHpzI/ZwKc9mlCsy4f3lhodfa1Lj27eK9a
GOx6PXqRP2vi5Snj3ubojdKByYpU+lj8StesBkTVGVtnE7QpgjWgd+GvxpDEmZB1
Pc3D6Im9WXjUIOEJ+oFqWrUSc8T2zH+b350jutF4ymKH4XZjyjBrMB2+7CpFltFy
cGWGxbMWiJdF+CDRZfuKupTOTGqq8tsxf3Sy4TecbQI2cj6CFrjjDZ22a+/3VLcT
6JHW8kSNgI6ZNzbQNjmtDi/Rwsa3ag==
=PcxX
-----END PGP SIGNATURE-----

--juFwilkHb68GTfupFMqcHzfQ4el4lS4Oe--

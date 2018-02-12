Received: from eggs.gnu.org ([2001:4830:134:3::10]:58582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elHDE-0002yR-8R
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elHDB-0000DL-Oe
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:44:14 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-20-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3a3134a8-19c8-0d9a-15d0-3b904998abd7@redhat.com>
Date: Mon, 12 Feb 2018 17:43:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-20-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6D6YPuCRyElNN8qsZf332pUZQ98u6WC8p"
Subject: Re: [Qemu-devel] [PATCH 19/27] sheepdog: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6D6YPuCRyElNN8qsZf332pUZQ98u6WC8p
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <3a3134a8-19c8-0d9a-15d0-3b904998abd7@redhat.com>
Subject: Re: [PATCH 19/27] sheepdog: Support .bdrv_co_create
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-20-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-20-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to sheepdog, which enable=
s
> image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  24 +++++-
>  block/sheepdog.c     | 209 ++++++++++++++++++++++++++++++++++++-------=
--------
>  2 files changed, 170 insertions(+), 63 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 7d004dddf9..08217e3e38 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3492,6 +3492,28 @@
>              'erasure-coded': 'SheepdogRedundancyErasureCoded' } }
> =20
>  ##
> +# @BlockdevCreateOptionsSheepdog:
> +#
> +# Driver specific image creation options for Sheepdog.
> +#
> +# @location         Where to store the new image file
> +# @size             Size of the virtual disk in bytes
> +# @backing_file     File name of a base image

s/_/-/

With that fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +# @preallocation    Preallocation mode (allowed values: off, full)
> +# @redundancy       Redundancy of the image
> +# @object-size      Object size of the image
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'BlockdevCreateOptionsSheepdog',
> +  'data': { 'location':         'BlockdevOptionsSheepdog',
> +            'size':             'size',
> +            '*backing-file':    'str',
> +            '*preallocation':   'PreallocMode',
> +            '*redundancy':      'SheepdogRedundancy',
> +            '*object-size':     'size' } }
> +
> +##
>  # @BlockdevCreateNotSupported:
>  #
>  # This is used for all drivers that don't support creating images.

[...]

> index dc0348f120..05129dc809 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c

[...]

> @@ -2142,15 +2144,95 @@ static int sd_create(const char *filename, Qemu=
Opts *opts,

[...]

> +static int sd_create(const char *filename, QemuOpts *opts,
> +                     Error **errp)
> +{

[...]

> +    v =3D qobject_input_visitor_new_keyval(crumpled);
> +    visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_=
err);
> +    visit_free(v);
> +    qobject_decref(crumpled);
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        ret =3D -EINVAL;
> +        goto fail;
> +    }
> +
> +    create_options->u.sheepdog.size =3D
> +        ROUND_UP(create_options->u.sheepdog.size, BDRV_SECTOR_SIZE);

I think I'd prefer an assertion that the type is indeed sheepdog before
this.

> +
> +    if (redundancy) {
> +        create_options->u.sheepdog.has_redundancy =3D true;
> +        create_options->u.sheepdog.redundancy =3D
> +            parse_redundancy_str(redundancy);
> +        if (create_options->u.sheepdog.redundancy =3D=3D NULL) {
> +            error_setg(errp, "Invalid redundancy mode");
> +            ret =3D -EINVAL;
> +            goto fail;
> +        }
> +    }


--6D6YPuCRyElNN8qsZf332pUZQ98u6WC8p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqBxEsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AqMgH/jI6Tk/WhK7kx5hVCA0Rp0QeErcKZeNV
npTtqFYsCkLNJvCqW8jgNtKuxrTVvuTndD1yRFMqUl1WGSZ+8XaN9o8F2zHMy9hR
luUJ37QuLB4T2QasGLuCNGdJVGlx8nMXzmELklax3YwWraVTOR0wowBxJE/GvYar
+0BKodvhwkj/EPSpfdkrMBKmjzscP3hFjza8cwDh1iA4FQTMAnebdqtTae8D53To
K/n1Rp2UNcZhAkLsCuU6eyOL+RTZM5pNjQoq+UPrE8rM/qLYsSNm8qT51Kik/11H
vbMfq9e/yqm+NauFyUgKeUY1gy5UY7wVlbSEEYTZlaYcSG2NQKIc6EY=
=16pw
-----END PGP SIGNATURE-----

--6D6YPuCRyElNN8qsZf332pUZQ98u6WC8p--

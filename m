Received: from eggs.gnu.org ([2001:4830:134:3::10]:49093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elETh-0006VB-49
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elETg-0005q4-AQ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:49:05 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-12-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f56a0308-0677-0890-c43c-6791dc0f11e4@redhat.com>
Date: Mon, 12 Feb 2018 14:48:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-12-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="J2OcmCqSUSIlO684ueZTnH9sdTfSiS9op"
Subject: Re: [Qemu-devel] [PATCH 11/27] block: x-blockdev-create QMP command
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
--J2OcmCqSUSIlO684ueZTnH9sdTfSiS9op
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <f56a0308-0677-0890-c43c-6791dc0f11e4@redhat.com>
Subject: Re: [PATCH 11/27] block: x-blockdev-create QMP command
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-12-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-12-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> This adds a synchronous x-blockdev-create QMP command that can create
> qcow2 images on a given node name.
>=20
> We don't want to block while creating an image, so this is not the fina=
l
> interface in all aspects, but BlockdevCreateOptionsQcow2 and
> .bdrv_co_create() are what they actually might look like in the end. In=

> any case, this should be good enough to test whether we interpret
> BlockdevCreateOptions as we should.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json      | 12 ++++++++
>  include/block/block.h     |  1 +
>  include/block/block_int.h |  2 ++
>  block.c                   |  2 +-
>  block/create.c            | 75 +++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c             |  3 +-
>  block/Makefile.objs       |  2 +-
>  7 files changed, 94 insertions(+), 3 deletions(-)
>  create mode 100644 block/create.c

[...]

> diff --git a/block/create.c b/block/create.c
> new file mode 100644
> index 0000000000..e95446a0f3
> --- /dev/null
> +++ b/block/create.c
> @@ -0,0 +1,75 @@

[...]

> +void qmp_x_blockdev_create(BlockdevCreateOptions *options, Error **err=
p)
> +{
> +    const char *fmt =3D BlockdevDriver_str(options->driver);
> +    BlockDriver *drv =3D bdrv_find_format(fmt);
> +    Coroutine *co;
> +    BlockdevCreateCo cco;
> +
> +    /* If the driver is in the schema, we know that it exists. But it =
may not
> +     * be whitelisted. */
> +    assert(drv);
> +    if (bdrv_uses_whitelist() && !bdrv_is_whitelisted(drv, true)) {

Isn't this more of an R/W case than RO?

Max

> +        error_setg(errp, "Driver is not whitelisted");
> +        return;
> +    }


--J2OcmCqSUSIlO684ueZTnH9sdTfSiS9op
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqBmzkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ADzgIAKzeeB/7y2FXv4KIoqvnKEjrPGblj281
tHuhLhMAz7YnmiR16nPQqX7WiZ5eXi8ys0N0wgC2xEncMgV8PhNmIGeZRi8tWe3/
QB3riG13oZ/JSR790+CGQtXGNKeVT3L+Q1MJGdS95Yi7NJc+8cbfdQoz1DRtXRZ1
gVLxZ/XzNLHYVOJRcyFbNGUOZOxZqepujGtHXy2Tts2Da8AUvfsRp5qBYyr3rT70
uHoY0t+OgLfNxtkPFP6ND7hDbZDodKejOfUW0YpdfWuecnKvqM2ekpNymC1hurvj
xD14DXrvH0xA9IsVsJmpXmcFPNnPYzZFAV3GKfUkKtlprwqkUVYhaBU=
=NmoJ
-----END PGP SIGNATURE-----

--J2OcmCqSUSIlO684ueZTnH9sdTfSiS9op--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elFqK-0005bN-TJ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elFqJ-0007gD-OP
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:16:32 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-16-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <444b46ae-865a-ca6b-cacf-9898cf044891@redhat.com>
Date: Mon, 12 Feb 2018 16:16:03 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-16-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d37KvWGuD1E2rSrUKpkV4DJOnoEJM8kP9"
Subject: Re: [Qemu-devel] [PATCH 15/27] rbd: Support .bdrv_co_create
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
--d37KvWGuD1E2rSrUKpkV4DJOnoEJM8kP9
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <444b46ae-865a-ca6b-cacf-9898cf044891@redhat.com>
Subject: Re: [PATCH 15/27] rbd: Support .bdrv_co_create
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-16-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-16-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to rbd, which enables
> image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  20 +++++++-
>  block/rbd.c          | 137 +++++++++++++++++++++++++++++++++----------=
--------
>  2 files changed, 108 insertions(+), 49 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

Some comments below.

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 5b4cd6bd12..370fcd9584 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3415,6 +3415,24 @@
>              '*refcount-bits':   'int' } }
> =20
>  ##
> +# @BlockdevCreateOptionsRbd:
> +#
> +# Driver specific image creation options for rbd/Ceph.
> +#
> +# @location         Where to store the new image file

Maybe this should mention that location.snapshot is not allowed?

(And that location.server is ignored.  But is that even intended?)

> +# @size             Size of the virtual disk in bytes
> +# @password-secret  ID of secret providing the password
> +# @cluster_size     RBD object size

s/_/-/

> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'BlockdevCreateOptionsRbd',
> +  'data': { 'location':         'BlockdevOptionsRbd',
> +            'size':             'size',
> +            '*password-secret': 'str',
> +            '*cluster-size' :   'size' } }
> +
> +##
>  # @BlockdevCreateNotSupported:
>  #
>  # This is used for all drivers that don't support creating images.

[...]

> diff --git a/block/rbd.c b/block/rbd.c
> index a76a5e8755..c164f70167 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c

[...]

> @@ -432,24 +409,87 @@ static int qemu_rbd_create(const char *filename, =
QemuOpts *opts, Error **errp)

[...]

> +static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error=
 **errp)
> +{
> +    BlockdevCreateOptions *create_options;
> +    BlockdevCreateOptionsRbd *rbd_opts;
> +    BlockdevOptionsRbd *loc;
> +    Error *local_err =3D NULL;
> +    const char *keypairs;
> +    QDict *options =3D NULL;
> +    int ret =3D 0;
> +
> +    create_options =3D g_new0(BlockdevCreateOptions, 1);
> +    create_options->driver =3D BLOCKDEV_DRIVER_RBD;
> +    rbd_opts =3D &create_options->u.rbd;
> +
> +    rbd_opts->location =3D g_new0(BlockdevOptionsRbd, 1);
> +
> +    rbd_opts->password_secret =3D (char *) qemu_opt_get(opts, "passwor=
d-secret");
> +
> +    /* Read out options */
> +    rbd_opts->size =3D ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_=
SIZE, 0),
> +                              BDRV_SECTOR_SIZE);
> +    rbd_opts->cluster_size =3D qemu_opt_get_size_del(opts,
> +                                                   BLOCK_OPT_CLUSTER_S=
IZE, 0);
> +    rbd_opts->has_cluster_size =3D (rbd_opts->cluster_size !=3D 0);
> +
> +    options =3D qdict_new();
> +    qemu_rbd_parse_filename(filename, options, &local_err);
> +    if (local_err) {
> +        ret =3D -EINVAL;
> +        error_propagate(errp, local_err);
> +        goto exit;
> +    }
> +
> +    /*
> +     * Caution: while qdict_get_try_str() is fine, getting non-string
> +     * types would require more care.  When @options come from -blockd=
ev
> +     * or blockdev_add, its members are typed according to the QAPI
> +     * schema, but when they come from -drive, they're all QString.
> +     */
> +    loc =3D rbd_opts->location;
> +    loc->pool     =3D g_strdup(qdict_get_try_str(options, "pool"));
> +    loc->conf     =3D g_strdup(qdict_get_try_str(options, "conf"));
> +    loc->has_conf =3D !!rbd_opts->location->conf;
> +    loc->user     =3D g_strdup(qdict_get_try_str(options, "user"));
> +    loc->has_user =3D !!rbd_opts->location->user;

"!!loc->conf" and "!!loc->user" would be shorter and maybe a bit easier
to get.

Max

> +    loc->image    =3D g_strdup(qdict_get_try_str(options, "image"));
> +    keypairs      =3D qdict_get_try_str(options, "=3Dkeyvalue-pairs");=

> +
> +    ret =3D qemu_rbd_do_create(create_options, keypairs, errp);
> +    if (ret < 0) {
> +        goto exit;
> +    }
> =20
>  exit:
>      QDECREF(options);
> +    qapi_free_BlockdevCreateOptions(create_options);
>      return ret;
>  }


--d37KvWGuD1E2rSrUKpkV4DJOnoEJM8kP9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqBr7MSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AJTsH/RnBaJExAJoJfIY55PYItJqloG+RMLER
qoSAiXzKWRWzmByYajeiqrA31Jxw9kSTiHZnAE9L5IK0lu47x1rhT1wp+9WWclzN
UgGW+Vk/Zp2Xrbai8M4NvNxe99AscArStAb9BK96Ra9ueuCbvBMPPCpB1eIXoiUW
+FiDu3jcBLEYScFRpeenqK+CeIwNA6fnYpL9q5To3TV8klmbPYWpVVyWcGWI8pd0
beMIQfq6X/4WOuC+z2khywL4m6GLA/mFLxUBqInehLRHXhOZEKReODPte/JvAhKH
lJLTpOKes8vmQnZ1Ib7dFHGJAWkyqPFTI3w088Sy3Ij/yumEL1kUOIw=
=9o1N
-----END PGP SIGNATURE-----

--d37KvWGuD1E2rSrUKpkV4DJOnoEJM8kP9--

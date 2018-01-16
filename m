Received: from eggs.gnu.org ([2001:4830:134:3::10]:47575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebWns-0004Q9-Rb
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:21:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebWnr-0000eL-SP
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:21:48 -0500
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-5-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <84d4b881-8c8f-f4cb-f282-3ac6d892bca3@redhat.com>
Date: Tue, 16 Jan 2018 13:21:37 -0600
MIME-Version: 1.0
In-Reply-To: <20180111195225.4226-5-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SHUL6nXJeEnfW8FTkGfOyGamAxZ4cfyXb"
Subject: Re: [Qemu-devel] [RFC PATCH 04/10] qcow2: Pass
 BlockdevCreateOptions to qcow2_create2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SHUL6nXJeEnfW8FTkGfOyGamAxZ4cfyXb
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <84d4b881-8c8f-f4cb-f282-3ac6d892bca3@redhat.com>
Subject: Re: [RFC PATCH 04/10] qcow2: Pass BlockdevCreateOptions to
 qcow2_create2()
References: <20180111195225.4226-1-kwolf@redhat.com>
 <20180111195225.4226-5-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2018 01:52 PM, Kevin Wolf wrote:
> All of the simple options are now passed to qcow2_create2() in a
> BlockdevCreateOptions object. Still missing: node-name and the
> encryption options.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c | 186 ++++++++++++++++++++++++++++++++++++++++++++++----=
--------
>  1 file changed, 148 insertions(+), 38 deletions(-)
>=20

> +    if (!qcow2_opts->has_lazy_refcounts) {
> +        qcow2_opts->lazy_refcounts =3D false;
> +    }
> +    if (version < 3 && qcow2_opts->lazy_refcounts) {
> +        error_setg(errp, "Lazy refcounts only supported with compatibi=
lity "
> +                   "level 1.1 and above (use compat=3D1.1 or greater)"=
);

Does this error message need tweaking given that the QMP spelling for
the compat level is slightly different?


> =20
>      /* Want a backing file? There you go.*/
> -    if (backing_file) {
> -        ret =3D bdrv_change_backing_file(blk_bs(blk), backing_file, ba=
cking_format);
> +    if (qcow2_opts->has_backing_file) {
> +        const char *backing_format =3D NULL;
> +
> +        if (qcow2_opts->has_backing_fmt) {
> +            backing_format =3D BlockdevDriver_str(qcow2_opts->backing_=
fmt);
> +        }

Do we want to declare it an error to specify backing_fmt without a
backing file (string)?

> @@ -2970,9 +3056,33 @@ static int qcow2_create(const char *filename, Qe=
muOpts *opts, Error **errp)
>      }
> =20
>      /* Create the qcow2 image (format layer) */
> -    ret =3D qcow2_create2(bs, size, backing_file, backing_fmt, flags,
> -                        cluster_size, prealloc, opts, version, refcoun=
t_order,
> -                        encryptfmt, errp);
> +    create_options =3D (BlockdevCreateOptions) {
> +        .driver         =3D BLOCKDEV_DRIVER_QCOW2,
> +        .node           =3D & (BlockdevRef) {
> +            .type               =3D QTYPE_QSTRING,
> +            .u.reference        =3D bs->node_name,
> +        },
> +        .u.qcow2        =3D {
> +            .size               =3D size,
> +            .has_compat         =3D true,
> +            .compat             =3D version =3D=3D 2
> +                                  ? BLOCKDEV_QCOW2_COMPAT_LEVEL_0_10
> +                                  : BLOCKDEV_QCOW2_COMPAT_LEVEL_1_1,
> +            .has_backing_file   =3D (backing_file !=3D NULL),
> +            .backing_file       =3D backing_file,
> +            .has_backing_fmt    =3D (backing_fmt !=3D NULL),

I would have used .has_backing_fmt =3D !!backing_fmt; but your way works =
too.

Overall looks like a good refactoring.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SHUL6nXJeEnfW8FTkGfOyGamAxZ4cfyXb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeUMEACgkQp6FrSiUn
Q2qDrAf/V5t92ky2cUnBJqkE5M1i3YNvukS75NKBRL/OQ8r6s++2nrsVdgIdgXmu
g/aBAb5ZzF/hCZ89wh7WNjzkLB3CVBE0NUhM9poQCsHTVJitc9JgRVHYfNJ6pQCD
DIf4GRIgchqF+ZG6YHSpFC9bwUCvXoPC+pzX2XaOabWTJ2ppc9yW5yvje3l4klNx
kbHGUJlYbN8Pohp/2cu5aHR+2WNWnO3duAD0LrPpURizCmYjaTCCRb7WCdE/STsF
kwHoU+ozGKs248d7RaQ58fjPE/Ld9zc89VP6J1qS+CI2rHptWOWXlA2/nhP/zIoZ
og0BECvb0xWEgavHjKKicC3F/Qqluw==
=MWqg
-----END PGP SIGNATURE-----

--SHUL6nXJeEnfW8FTkGfOyGamAxZ4cfyXb--

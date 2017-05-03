Received: from eggs.gnu.org ([2001:4830:134:3::10]:53022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d5zVO-00039q-Fb
	for qemu-devel@nongnu.org; Wed, 03 May 2017 15:00:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d5zVN-0008Ql-J5
	for qemu-devel@nongnu.org; Wed, 03 May 2017 15:00:06 -0400
References: <20170429191419.30051-1-eblake@redhat.com>
	<20170429191419.30051-8-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <106645b1-81e0-398d-88ab-2b1573171c1d@redhat.com>
Date: Wed, 3 May 2017 20:59:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170429191419.30051-8-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Bh23wbHLCDS0oS26lI3F7HmbNvhfW9vC9"
Subject: Re: [Qemu-devel] [PATCH v11 7/9] blkdebug: Simplify override logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bh23wbHLCDS0oS26lI3F7HmbNvhfW9vC9
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <106645b1-81e0-398d-88ab-2b1573171c1d@redhat.com>
Subject: Re: [PATCH v11 7/9] blkdebug: Simplify override logic
References: <20170429191419.30051-1-eblake@redhat.com>
 <20170429191419.30051-8-eblake@redhat.com>
In-Reply-To: <20170429191419.30051-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.04.2017 21:14, Eric Blake wrote:
> Rather than store into a local variable, then copy to the struct
> if the value is valid, then reporting errors otherwise, it is
> simpler to just store into the struct and report errors if the
> value is invalid.  This however requires that the struct store
> a 64-bit number, rather than a narrower type.  Likewise, setting
> a sane errno value in ret prior to the sequence of parsing and
> jumping to out: on error makes it easier for the next patch to
> add a chain of similar checks.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v11: rebase to master, enough changed to drop R-b
> v10: no change
> v9: no change
> v7-v8: not submitted (earlier half of series sent for 2.9)
> v6: tweak error message, but R-b kept
> v5: no change
> v4: fix typo in commit message, move errno assignment
> v3: new patch
> ---
>  block/blkdebug.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>=20
> diff --git a/block/blkdebug.c b/block/blkdebug.c
> index 6414f1c..8e0f596 100644
> --- a/block/blkdebug.c
> +++ b/block/blkdebug.c
> @@ -38,7 +38,7 @@
>  typedef struct BDRVBlkdebugState {
>      int state;
>      int new_state;
> -    int align;
> +    uint64_t align;
>=20
>      /* For blkdebug_refresh_filename() */
>      char *config_file;
> @@ -353,7 +353,6 @@ static int blkdebug_open(BlockDriverState *bs, QDic=
t *options, int flags,
>      BDRVBlkdebugState *s =3D bs->opaque;
>      QemuOpts *opts;
>      Error *local_err =3D NULL;
> -    uint64_t align;
>      int ret;
>=20
>      opts =3D qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
> @@ -387,20 +386,17 @@ static int blkdebug_open(BlockDriverState *bs, QD=
ict *options, int flags,
>          bs->file->bs->supported_write_flags;
>      bs->supported_zero_flags =3D (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &=

>          bs->file->bs->supported_zero_flags;
> +    ret =3D -EINVAL;
>=20
>      /* Set request alignment */
> -    align =3D qemu_opt_get_size(opts, "align", 0);
> -    if (align < INT_MAX && is_power_of_2(align)) {
> -        s->align =3D align;
> -    } else if (align) {
> -        error_setg(errp, "Invalid alignment");
> -        ret =3D -EINVAL;
> +    s->align =3D qemu_opt_get_size(opts, "align", 0);
> +    if (s->align && (s->align >=3D INT_MAX || !is_power_of_2(s->align)=
)) {
> +        error_setg(errp, "Cannot meet constraints with align %" PRIu64=
,
> +                   s->align);

Why don't you just keep the ret =3D -EINVAL here and not add it above?
It's not wrong, I just think it makes the code a bit weird to read.

Max

>          goto out;
>      }
>=20
>      ret =3D 0;
> -    goto out;
> -
>  out:
>      if (ret < 0) {
>          g_free(s->config_file);
>=20



--Bh23wbHLCDS0oS26lI3F7HmbNvhfW9vC9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkKKKkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AclcH/1TY5bOshuKY3wIJBKzSnA+sUDjXAHGf
TswPl6guL37mbkW9u0lWOyqT8qMrsW22LryYUjitQSLehHTdyGRmzIOKaUyVw400
wVC0RsnQ9xF160DQXY3ZD3hODMNWJqSZcdm43nf0hcAVEmSTuzwHKBOwRk9Gx612
vzmO0MZ/rnW1GkrGbsVjqjq+n95j7kEbKaY42GGcUpRUnWVMgz1QltmpnvgOLvZv
CN9SwT1b/V7BRe3sBjL1TI4UP4Ug37WvKDFkn1gr0T4oIeMb0hh6nJhhTL7aj30o
liWrBuu2CKFAG31ZKVVK/cVUxBZDkxHWFnh6t2uYs0f4HBFwCXVSGDM=
=GmAv
-----END PGP SIGNATURE-----

--Bh23wbHLCDS0oS26lI3F7HmbNvhfW9vC9--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVcDN-0002ZZ-KJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVcDM-00014M-Eh
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:23:25 -0400
References: <20170713100117.11961-1-el13635@mail.ntua.gr>
	<20170713100117.11961-2-el13635@mail.ntua.gr>
From: Eric Blake <eblake@redhat.com>
Message-ID: <61c88e57-e607-a0fc-6441-175b24d55b74@redhat.com>
Date: Thu, 13 Jul 2017 06:23:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170713100117.11961-2-el13635@mail.ntua.gr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OxtAHgw8tWh1mxg13PetxemCiqmXNDIpM"
Subject: Re: [Qemu-devel] [PATCH v5 1/4] block: pass bdrv_* methods to
 bs->file by default in block filters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OxtAHgw8tWh1mxg13PetxemCiqmXNDIpM
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <61c88e57-e607-a0fc-6441-175b24d55b74@redhat.com>
Subject: Re: [PATCH v5 1/4] block: pass bdrv_* methods to bs->file by default
 in block filters
References: <20170713100117.11961-1-el13635@mail.ntua.gr>
 <20170713100117.11961-2-el13635@mail.ntua.gr>
In-Reply-To: <20170713100117.11961-2-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2017 05:01 AM, Manos Pitsidianakis wrote:
> The following functions fail if bs->drv is a filter and does not
> implement them:
>=20
> bdrv_probe_blocksizes
> bdrv_probe_geometry
> bdrv_truncate
> bdrv_has_zero_init
> bdrv_get_info
>=20
> Instead, the call should be passed to bs->file if it exists, to allow
> filter drivers to support those methods without implementing them. This=

> commit makes `drv->is_filter =3D true` imply that these callbacks will =
be
> forwarded to bs->file by default, so disabling support for these
> functions must be done explicitly.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

I would have dropped R-b on the grounds that you added comments to
'is_filter' (good! but non-trivial), to make sure it gets a
grammar/wording review of the new content.  Furthermore, your patch had
a semantic change due to the rebase, and looking at that change...

> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---

> @@ -3420,11 +3424,15 @@ int bdrv_truncate(BdrvChild *child, int64_t off=
set, PreallocMode prealloc,
> =20
>      assert(child->perm & BLK_PERM_RESIZE);
> =20
> +    /* if bs->drv =3D=3D NULL, bs is closed, so there's nothing to do =
here */
>      if (!drv) {
>          error_setg(errp, "No medium inserted");
>          return -ENOMEDIUM;
>      }
>      if (!drv->bdrv_truncate) {
> +        if (bs->file && drv->is_filter) {
> +            return bdrv_truncate(bs->file, prealloc, offset, errp);

=2E..ouch - you got it wrong.  s/prealloc, offset/offset, prealloc/

> +++ b/include/block/block_int.h
> @@ -87,7 +87,11 @@ struct BlockDriver {
>      const char *format_name;
>      int instance_size;
> =20
> -    /* set to true if the BlockDriver is a block filter */
> +    /* set to true if the BlockDriver is a block filter. Block filters=
 pass
> +     * certain callbacks that refer to data (see block.c) to their bs-=
>file if
> +     * the driver doesn't implement them. Drivers that do not wish to =
forward
> +     * must implement them and return -ENOTSUP.
> +     */
>      bool is_filter;

I'm okay with the new comment.

With the swapped parameter order fixed (the maintainer can probably do
that),
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OxtAHgw8tWh1mxg13PetxemCiqmXNDIpM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ1giAAoJEKeha0olJ0Nq638IAJykHhrSRUpEBTpxXBLajeFJ
eJVpAiMaphOgzDYOsD0GHIpri+sLnsoQjT9Bs3uy7YfWTSleVkg855Ditj8h76+O
reS/XXqAU4CKz09/8UwN3J+l5AMAfp86LsIGnvqcjY/pDrIXnv7Jsq7mcZPsVMnz
nfnTRQFAFEmENnIT9GS0KmVefUvs3+5U9ZMGd9E9VN/qwqVEHWIcZo0h2hSg1zmN
jAQV1HT+47uMZeLybvTgkytFkbN/74S0JKT2aql2X3EtwVM1HgZyTV8Dmlbp/coz
ibAHa9507QnfkaY6NhXQVAvoUU6b13nBJmM/nY3y1AeG11V1uDbujswo8fY7now=
=6cTh
-----END PGP SIGNATURE-----

--OxtAHgw8tWh1mxg13PetxemCiqmXNDIpM--

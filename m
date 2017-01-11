Received: from eggs.gnu.org ([2001:4830:134:3::10]:42001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cRLmw-0003Un-Un
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cRLmt-0004VR-OF
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:30:14 -0500
References: <20161130011851.24696-1-mreitz@redhat.com>
	<20161130011851.24696-23-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <75808f28-d7c0-122d-9046-d5bbed2b4ce2@redhat.com>
Date: Wed, 11 Jan 2017 17:29:45 +0100
MIME-Version: 1.0
In-Reply-To: <20161130011851.24696-23-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jQ4DQVcQgBxVf40abGnkPNfCFKi0Bvu3h"
Subject: Re: [Qemu-devel] [PATCH v3 22/25] block: Do not copy exact_filename
 from format file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jQ4DQVcQgBxVf40abGnkPNfCFKi0Bvu3h
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>
Message-ID: <75808f28-d7c0-122d-9046-d5bbed2b4ce2@redhat.com>
Subject: Re: [PATCH v3 22/25] block: Do not copy exact_filename from format
 file
References: <20161130011851.24696-1-mreitz@redhat.com>
 <20161130011851.24696-23-mreitz@redhat.com>
In-Reply-To: <20161130011851.24696-23-mreitz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 30.11.2016 02:18, Max Reitz wrote:
> If the a format BDS's file BDS is in turn a format BDS, we cannot simpl=
y
> use the same filename, because when opening a BDS tree based on a
> filename alone, qemu will create only one format node on top of one
> protocol node (disregarding a potential backing file).
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index ec25cbf..71c14f4 100644
> --- a/block.c
> +++ b/block.c
> @@ -4095,9 +4095,20 @@ void bdrv_refresh_filename(BlockDriverState *bs)=

> =20
>          bs->exact_filename[0] =3D '\0';
> =20
> -        /* If no specific options have been given for this BDS, the fi=
lename of
> -         * the underlying file should suffice for this one as well */
> -        if (bs->file->bs->exact_filename[0] && !generate_json_filename=
) {
> +        /* We can use the underlying file's filename if:
> +         * - it has a filename,
> +         * - the file is a protocol BDS, and
> +         * - opening that file (as this BDS's format) will automatical=
ly create
> +         *   the BDS tree we have right now, that is:
> +         *   - the user did not significantly change this BDS's behavi=
or with
> +         *     some explicit options
> +         *   - no non-file child of this BDS has been overridden by th=
e user
> +         *   Both of these conditions are represented by generate_json=
_filename.
> +         */
> +        if (bs->file->bs->exact_filename[0] &&
> +            (bs->file->bs->open_flags & BDRV_O_PROTOCOL) &&

This was a nice try, but as it turns out, this flag does not have to
always set for protocol BDSs. A more reliable test is:

!bs->file->bs->file

This test may also be a bit more intuitive: We can copy exact_filename
in one layer from bs->file, but not through two layers.

Max

> +            !generate_json_filename)
> +        {
>              strcpy(bs->exact_filename, bs->file->bs->exact_filename);
>          }
>      }
>=20



--jQ4DQVcQgBxVf40abGnkPNfCFKi0Bvu3h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh2XYQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ar08IAMSOpetrrDU1EzOj9xrvPevMbGU6yV39
7E015rUdgZd0oZP2Y9W9S5Ycyv4zciIlnbCjNjc4QZtJMLokmjqwKVpZOir+0C7s
m3sveJWlR3DLD4TIB0Zank0fYWLnvcN2dWi9p21A1dPktT3ltZ7nL4whsOQik1QK
R1cTVFsEXJMyqvVcjrsjjW4X2HTB1dY75jvkGozQQKt6QnHs8Fa1ciWfkkW6lWAZ
YrUh6nO23PbEFk/j4p7X2amHJka+0SBLTm363NqKGimXf8V3/zLPIobX8Kbv4IOF
K6483XNgKLd6G5QJG4vE1kdC4PZ8fNfQhlIYomArLemeztAQpXKeEd4=
=fL2V
-----END PGP SIGNATURE-----

--jQ4DQVcQgBxVf40abGnkPNfCFKi0Bvu3h--

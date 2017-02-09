Received: from eggs.gnu.org ([2001:4830:134:3::10]:54540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbqoH-00057P-3P
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:39:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbqoF-0007JR-Uh
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:39:01 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-18-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <119ea962-4746-6563-5133-e2063bc34567@redhat.com>
Date: Thu, 9 Feb 2017 09:38:51 -0600
MIME-Version: 1.0
In-Reply-To: <20170203154757.36140-18-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KKbOKQ9DAPqXxLLk6qcMif0naHkX37Kbm"
Subject: Re: [Qemu-devel] [PATCH 17/18] nbd: BLOCK_STATUS for standard
 get_block_status function: server part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KKbOKQ9DAPqXxLLk6qcMif0naHkX37Kbm
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com,
 stefanha@redhat.com
Message-ID: <119ea962-4746-6563-5133-e2063bc34567@redhat.com>
Subject: Re: [PATCH 17/18] nbd: BLOCK_STATUS for standard get_block_status
 function: server part
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-18-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-18-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> Minimal realization: only one extent in server answer is supported.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/nbd.h |  3 ++
>  nbd/nbd-internal.h  |  1 +
>  nbd/server.c        | 80 +++++++++++++++++++++++++++++++++++++++++++++=
+++-----
>  3 files changed, 77 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 08d5e51f21..69aee1eda1 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -181,6 +181,9 @@ enum {
>  #define NBD_REPLY_TYPE_ERROR ((1 << 15) + 1)
>  #define NBD_REPLY_TYPE_ERROR_OFFSET ((1 << 15) + 2)
> =20
> +#define NBD_STATE_HOLE 1
> +#define NBD_STATE_ZERO (1 << 1)

Why not (1 << 0) for NBD_STATE_HOLE?

I almost wonder if it is better to rebase the series to implement
base:allocation first, rather than last, just for easier
interoperability testing with other implementations that still need to
implement structured replies; but I don't think it's a show-stopper.

> =20
> +static int blockstatus_to_extent(BlockDriverState *bs, uint64_t offset=
,
> +                                  uint64_t length, NBDExtent *extent)
> +{
> +    BlockDriverState *file;
> +    uint64_t start_sector =3D offset >> BDRV_SECTOR_BITS;
> +    uint64_t last_sector =3D (offset + length - 1) >> BDRV_SECTOR_BITS=
;

Converting from bytes to sectors by rounding...

> +    uint64_t begin =3D start_sector;
> +    uint64_t end =3D last_sector + 1;
> +
> +    int nb =3D MIN(INT_MAX, end - begin);
> +    int64_t ret =3D bdrv_get_block_status_above(bs, NULL, begin, nb, &=
nb, &file);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    extent->flags =3D
> +        cpu_to_be32((ret & BDRV_BLOCK_ALLOCATED ? 0 : NBD_STATE_HOLE) =
|
> +                    (ret & BDRV_BLOCK_ZERO      ? NBD_STATE_ZERO : 0))=
;
> +    extent->length =3D cpu_to_be32((nb << BDRV_SECTOR_BITS) -
> +                                 (offset - (start_sector << BDRV_SECTO=
R_BITS)));

=2E..then computing the length by undoing the rounding. I really think we=

should consider fixing bdrv_get_block_status_above() to be byte-based,
but that's a separate series.  Your calculations look correct in the
meantime, although '(offset & (BDRV_SECTOR_SIZE - 1))' may be a bit
easier to read than '(offset - (start_sector << BDRV_SECTOR_BITS))'.

> @@ -1869,13 +1930,18 @@ static void nbd_trip(void *opaque)
>          break;
>      case NBD_CMD_BLOCK_STATUS:
>          TRACE("Request type is BLOCK_STATUS");
> -        if (client->export_bitmap =3D=3D NULL) {
> +        if (!!client->export_bitmap) {

!! is not necessary here.

> +            ret =3D nbd_co_send_bitmap(req->client, request.handle,
> +                                     client->export_bitmap, request.fr=
om,
> +                                     request.len, 0);
> +        } else if (client->export_block_status) {
> +            ret =3D nbd_co_send_block_status(req->client, request.hand=
le,
> +                                           blk_bs(exp->blk), request.f=
rom,
> +                                           request.len, 0);

Umm, why are we sending only one status? If the client requests two ids
during NBD_OPT_SET_META_CONTEXT, we should be able to provide both
pieces of information at once.  For a minimal implementation, it works
for proof of concept, but it is pretty restrictive to tell clients that
they can only request a single status context.  I'm fine if we add that
functionality in a later patch, but we'd better have the implementation
ready for the same release as this patch (I still think 2.9 is a
reasonable goal).


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--KKbOKQ9DAPqXxLLk6qcMif0naHkX37Kbm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYnI0LAAoJEKeha0olJ0NqkW0H/j1lbXl5CVTm2u2DVx02jxBz
MnXDt6CufwNSAgsDe7Q4T/3lA0Ns1UCb1LBX8ZvCERNnWVi21JV6stPQEsfFj8xi
YOqo4EfUnsw9/bLFU8z2nNaktrWYWNtGOwm23soOhVSFIWcTYkRmKRJKLF4kaRWi
RGdzsTwLwhK/O5ocfl7yCZKfXAdmfKjjKsRMbwt9P0DTOI0ekgtvQbS0nrVz2+Fc
ItOy5HHn9Sj3asao64g70CR2YjUVQRDiTZw9FFwUviVNyCWTpUFCycvv43amojSD
ZlevVNAULuAONzD8L3Yw1hahDLm3WKf6QDNUM0dN7yUCDQ8yjEGt0xLOtgPfbog=
=yMvy
-----END PGP SIGNATURE-----

--KKbOKQ9DAPqXxLLk6qcMif0naHkX37Kbm--

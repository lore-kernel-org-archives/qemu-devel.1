Received: from eggs.gnu.org ([2001:4830:134:3::10]:51577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctwu7-00068r-HT
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctwu6-0007Rm-IX
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:47:51 -0400
References: <1490965980-513-1-git-send-email-peter.maydell@linaro.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9e359c38-a2aa-64e8-6c7c-0b793d2f2bb4@redhat.com>
Date: Fri, 31 Mar 2017 15:47:39 +0200
MIME-Version: 1.0
In-Reply-To: <1490965980-513-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wfRoxwo16bTIAVv5AIOB0aoiRbVcwLfWl"
Subject: Re: [Qemu-devel] [PATCH] block/parallels.c: avoid integer overflow
 in allocate_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wfRoxwo16bTIAVv5AIOB0aoiRbVcwLfWl
From: Max Reitz <mreitz@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <9e359c38-a2aa-64e8-6c7c-0b793d2f2bb4@redhat.com>
Subject: Re: [PATCH] block/parallels.c: avoid integer overflow in
 allocate_clusters()
References: <1490965980-513-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1490965980-513-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 31.03.2017 15:13, Peter Maydell wrote:
> Coverity (CID 1307776) points out that in the multiply:
>   space =3D to_allocate * s->tracks;
> we are trying to calculate a 64 bit result but the types
> of to_allocate and s->tracks mean that we actually calculate
> a 32 bit result. Add an explicit cast to force a 64 bit
> multiply.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> NB: compile-and-make-check tested only...
> ---
>  block/parallels.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/parallels.c b/block/parallels.c
> index 4173b3f..3886c30 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -206,7 +206,7 @@ static int64_t allocate_clusters(BlockDriverState *=
bs, int64_t sector_num,
>      }
> =20
>      to_allocate =3D DIV_ROUND_UP(sector_num + *pnum, s->tracks) - idx;=

> -    space =3D to_allocate * s->tracks;
> +    space =3D (int64_t)to_allocate * s->tracks;
>      if (s->data_end + space > bdrv_getlength(bs->file->bs) >> BDRV_SEC=
TOR_BITS) {
>          int ret;
>          space +=3D s->prealloc_size;

I think the division is technically fine because to_allocate will
roughly be *pnum / s->tracks (and since *pnum is an int, the
multiplication cannot overflow).

However, it's still good to fix this, but I would do it differently:
Make idx, to_allocate, and i all uint64_t or int64_t instead of
uint32_t. This would also prevent accidental overflow when storing the
result of the division in:

idx =3D sector_num / s->tracks;
if (idx >=3D s->bat_size) {
    [...]

The much greater problem to me appears to be that we don't check that
idx + to_allocate <=3D s->bat_size. I'm not sure whether there can be a
buffer overflow in the for loop below, but I'm not sure I really want to
know either... I think the block_status() call limits *pnum so that
there will not be an overflow, but then we should at least assert this.

Max


--wfRoxwo16bTIAVv5AIOB0aoiRbVcwLfWl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljeXfsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A7A8IALXjoMX9cwt7MRlhQaIqFg0GMiSnUyBI
ByUV0jSw1qYrp63H8PAYdawQDsPw9VHiSGfPArFWKqxWb6cC2wBkYw5JXQTVO/MK
d7WzKsXP10KFIW9RYV4hp45M3/qYHY4M6h1MKUUrvnhUbnu4PFf+Zyg/11dHhRf4
Ddwp1B24ehKSmK/rFNPrIIat4w/7f9dF/sCtazlolinEt7IKrxl+fheZ7rzgNEwg
fuh7shzbW/qeqLXNy4LKRQrrUpJwL4MoDDlFdlrkA6TdyvUAeaoUWHhKnkNFLVvs
Ocj0vzdqLpeAKPd8oiqULHkjtmJf8Ib/vRvr8lCQfXafNO2wuKCj/NE=
=WKrR
-----END PGP SIGNATURE-----

--wfRoxwo16bTIAVv5AIOB0aoiRbVcwLfWl--

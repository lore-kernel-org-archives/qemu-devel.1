Received: from eggs.gnu.org ([2001:4830:134:3::10]:58113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cckZi-0002wA-K0
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 22:11:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cckZh-0001aX-Ep
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 22:11:42 -0500
References: <20170203094018.15493-1-vsementsov@virtuozzo.com>
	<20170203094018.15493-8-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <32953738-a060-f3e8-bb36-e427fcfb48ad@redhat.com>
Date: Sun, 12 Feb 2017 04:11:30 +0100
MIME-Version: 1.0
In-Reply-To: <20170203094018.15493-8-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kpJuhxVcT7raxFcddEgQUwqHDDpwcfkAp"
Subject: Re: [Qemu-devel] [PATCH 07/24] qcow2: add bitmaps extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kpJuhxVcT7raxFcddEgQUwqHDDpwcfkAp
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <32953738-a060-f3e8-bb36-e427fcfb48ad@redhat.com>
Subject: Re: [PATCH 07/24] qcow2: add bitmaps extension
References: <20170203094018.15493-1-vsementsov@virtuozzo.com>
 <20170203094018.15493-8-vsementsov@virtuozzo.com>
In-Reply-To: <20170203094018.15493-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.02.2017 10:40, Vladimir Sementsov-Ogievskiy wrote:
> Add bitmap extension as specified in docs/specs/qcow2.txt.
> For now, just mirror extension header into Qcow2 state and check
> constraints.
>=20
> For now, disable image resize if it has bitmaps. It will be fixed later=
=2E
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2.c | 127 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++---
>  block/qcow2.h |  24 +++++++++++
>  2 files changed, 145 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 96fb8a8f16..d263ab1ed7 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -1151,9 +1237,13 @@ static int qcow2_open(BlockDriverState *bs, QDic=
t *options, int flags,
>          goto fail;
>      }
> =20
> -    /* Clear unknown autoclear feature bits */
> -    if (!bs->read_only && !(flags & BDRV_O_INACTIVE) && s->autoclear_f=
eatures) {
> -        s->autoclear_features =3D 0;
> +    if (!need_update_header) {
> +        /* Clear unknown autoclear feature bits */
> +        need_update_header =3D s->autoclear_features & ~QCOW2_AUTOCLEA=
R_MASK;
> +    }

Alternatively,

need_update_header |=3D s->autoclear_features & ~QCOW2_AUTOCLEAR_MASK;

would have worked just as well and might have been a bit easier to read.

Anyway:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +
> +    if (need_update_header && !bs->read_only && !(flags & BDRV_O_INACT=
IVE)) {
> +        s->autoclear_features &=3D QCOW2_AUTOCLEAR_MASK;
>          ret =3D qcow2_update_header(bs);
>          if (ret < 0) {
>              error_setg_errno(errp, -ret, "Could not update qcow2 heade=
r");


--kpJuhxVcT7raxFcddEgQUwqHDDpwcfkAp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlif0mISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A8r4IAIHe4i8v0YVaqJSORRy5wkA39DZm7RIZ
/ySNHL9K31ainwsZDBML1VXqVydVMkY22oxL8N5bpNdVEGgaA5Pq299xNOPTD4Lt
/PKQmG7PbATmU7NeoiryuSEAihZbc3N5cqP/U3V+mCW0CAbHSic2kBbPSbwZHcZF
tpGNz1o2Bt/2QzHsOvur0lkSimMEapjv2zENBQl/QLHF5AXiDjAANhL7O6dSzoSf
huSeKyhSA8s064a6h9W9xKa7RStwakHpl6/9vHZVZC2u8P9Xx0d8keIe//ZVpWBG
2ewKtMXaGIkahmh5BcnknhaTGI+NCIhaln2tQCivGJJKlnrkxEFGcxs=
=7TEc
-----END PGP SIGNATURE-----

--kpJuhxVcT7raxFcddEgQUwqHDDpwcfkAp--

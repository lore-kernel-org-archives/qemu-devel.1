Received: from eggs.gnu.org ([2001:4830:134:3::10]:51834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFOsu-0004mh-4C
	for qemu-devel@nongnu.org; Mon, 29 May 2017 13:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFOst-0007fu-DJ
	for qemu-devel@nongnu.org; Mon, 29 May 2017 13:55:16 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-26-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2329cfc4-d5b3-9fe2-668d-fd6ba1f5d316@redhat.com>
Date: Mon, 29 May 2017 19:54:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170503122539.282182-26-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="07p1nN0xRfGa2AIJhwiWeuAmOH3hp1HPa"
Subject: Re: [Qemu-devel] [PATCH 25/25] block: release persistent bitmaps on
 inactivate
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
--07p1nN0xRfGa2AIJhwiWeuAmOH3hp1HPa
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <2329cfc4-d5b3-9fe2-668d-fd6ba1f5d316@redhat.com>
Subject: Re: [PATCH 25/25] block: release persistent bitmaps on inactivate
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
 <20170503122539.282182-26-vsementsov@virtuozzo.com>
In-Reply-To: <20170503122539.282182-26-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-03 14:25, Vladimir Sementsov-Ogievskiy wrote:
> We should release them here to reload on invalidate cache.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c                      |  4 ++++
>  block/dirty-bitmap.c         | 29 +++++++++++++++++++++++------
>  include/block/dirty-bitmap.h |  1 +
>  3 files changed, 28 insertions(+), 6 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 795d36bb64..14896c65fa 100644
> --- a/block.c
> +++ b/block.c
> @@ -4001,6 +4001,10 @@ static int bdrv_inactivate_recurse(BlockDriverSt=
ate *bs,
>      if (setting_flag) {
>          bs->open_flags |=3D BDRV_O_INACTIVE;
>      }
> +
> +    /* At this point persistent bitmaps should be stored by format dri=
ver */

s/by format driver/by the format driver/

> +    bdrv_release_persistent_dirty_bitmaps(bs);

Also, as far as I can see, this doesn't store the bitmaps but just
releases them (without storing them). I'm not sure whether that is
right, but it definitely contradicts the comment above.

Max

> +
>      return 0;
>  }
>=20


--07p1nN0xRfGa2AIJhwiWeuAmOH3hp1HPa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLGBrEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQApC
CACltAXbleipIEe8UZ/Wpb3lq0NL2BtXpoDU7+N3Rvfkh5rZNFfnXvoOkRDJpsZs
dIVcFh/I5ahKoMS8oFKELMmJPj6pXR94z/wlBvKl1NetlKaQfkjC668ouOF9XRQP
WJ3ahh62ATsffpsEMdeW+wKmTiAO6H/aD6NLqlpy8bKWSrlbhEBbWTG3FSSLrdMf
v9jxALbsX8+Lcerh2b7i7341vZBn0op/F2K/i+QaA/M9JQVIT+x2OxfaBUJsDCPZ
vHZoJDmFF1iWfjYjfZi1VB1e49hZJMaks6mlkK728IHyBC3QAX3sq+gXnjMpuPm6
VlNvdSjqXwfAdog+g5WxVg2Z
=ZKt+
-----END PGP SIGNATURE-----

--07p1nN0xRfGa2AIJhwiWeuAmOH3hp1HPa--

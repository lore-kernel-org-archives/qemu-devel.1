Received: from eggs.gnu.org ([209.51.188.92]:52676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3Xf7-0001py-RG
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3Xf6-0007lv-PS
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:01:05 -0400
References: <20190311185147.52309-1-vsementsov@virtuozzo.com>
	<20190311185147.52309-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <de12647d-746b-fe40-63b5-6ce7e8e1c54b@redhat.com>
Date: Mon, 11 Mar 2019 22:00:54 -0500
MIME-Version: 1.0
In-Reply-To: <20190311185147.52309-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="I9EqTL0aeB6QZQHLYrIIAMT69EFvciyf4"
Subject: Re: [Qemu-devel] [PATCH v2 1/4] docs/interop/qcow2: Improve bitmap
 flag in_use specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I9EqTL0aeB6QZQHLYrIIAMT69EFvciyf4
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@virtuozzo.com
Message-ID: <de12647d-746b-fe40-63b5-6ce7e8e1c54b@redhat.com>
Subject: Re: [PATCH v2 1/4] docs/interop/qcow2: Improve bitmap flag in_use
 specification
References: <20190311185147.52309-1-vsementsov@virtuozzo.com>
 <20190311185147.52309-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190311185147.52309-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/11/19 1:51 PM, Vladimir Sementsov-Ogievskiy wrote:
> We already use (we didn't notice it) IN_USE flag for marking bitmap
> metadata outdated, such as AUTO flag, which mirrors enabled/disabled
> bitmaps. No we are going to support bitmap resize, so it's good to

s/No/Now/

> write IN_USE meaning with more details.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  docs/interop/qcow2.txt | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index fb5cb47245..575a5f25e2 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -589,7 +589,19 @@ Structure of a bitmap directory entry:
>                      Bit
>                        0: in_use
>                           The bitmap was not saved correctly and may be=

> -                         inconsistent.
> +                         inconsistent. This inconsitency may touch bot=
h bitmap

inconsistency

> +                         data and metadata, and this mean that bitmap =
state
> +                         (its data and metadata) was changed but not s=
tored
> +                         back to the image. This flag doesn't relate t=
o format
> +                         corruption, all fields are still correct from=
 qcow2
> +                         point of view, they just may be outdated.
> +
> +                         Note: Currently, Qemu may change (additionall=
y to
> +                         bitmap data) @auto flag and size of the bitma=
p during
> +                         image resize. This mean, that not only bitmap=
 data
> +                         may be outdated if @in_use flag set, but also=
 value of
> +                         @auto flag and bitmap size (which is indirect=
ly
> +                         referenced by @bitmap_table_size).

Feels wordy. Maybe drop the second paragraph starting with Note, and
merely use this for the first paragraph:

The bitmap was not saved correctly and may be inconsistent. Although the
bitmap metadata is still well-formed from a qcow2 perspective, the
metadata (such as the auto flag or bitmap size) or data contents may be
outdated.

> =20
>                        1: auto
>                           The bitmap must reflect all changes of the vi=
rtual
> @@ -717,8 +729,8 @@ corresponding range of the virtual disk (see above)=
 was written to while the
>  bitmap was 'enabled'. An unset bit means that this range was not writt=
en to.
> =20
>  The software doesn't have to sync the bitmap in the image file with it=
s
> -representation in RAM after each write. Flag 'in_use' should be set wh=
ile the
> -bitmap is not synced.
> +representation in RAM after each write or metadata change. Flag 'in_us=
e'
> +should be set while the bitmap is not synced.
> =20
>  In the image file the 'enabled' state is reflected by the 'auto' flag.=
 If this
>  flag is set, the software must consider the bitmap as 'enabled' and st=
art
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--I9EqTL0aeB6QZQHLYrIIAMT69EFvciyf4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyHIOYACgkQp6FrSiUn
Q2q3AwgAjb3NgVwPo5bsDzXlkx5i/koM9ZyGBviUh2KJm8eS1OGDMOP94hNLvfDv
ilqAn2gppC5fo1edDJHPICR9W4Mom8uOb16dXn0CRQgXzDKPoVc44XvHdFKzeCJv
4EwIwaGu6iZTJ1oc2DUexk2NV1pJKyGx8TNqm9QMOIrgUQJdMPnTJVjCeKHJiXnw
enWiLj2ZSEFfTNDcvDDt4PwJgBV+S55UNa02RNBivXTc7XbnZ42STrQGfxVng3pA
SokgIYDGmWXaySJdMdVwl6ZNgvP+DPbMAqLKAjv0LXmMoJSQ6DZPXW5YUmtqva+x
0+Z/e0Ce6VSjcQnrRb+uBzn6bs/GWA==
=bW7J
-----END PGP SIGNATURE-----

--I9EqTL0aeB6QZQHLYrIIAMT69EFvciyf4--

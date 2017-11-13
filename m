Received: from eggs.gnu.org ([2001:4830:134:3::10]:36678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEIt1-0005Zk-7r
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEIt0-0003eY-Bc
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:51:07 -0500
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<20171113162053.58795-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <12463b01-41eb-4d17-65c0-a94de499e753@redhat.com>
Date: Mon, 13 Nov 2017 11:50:50 -0600
MIME-Version: 1.0
In-Reply-To: <20171113162053.58795-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bpAfEjNjU9Ku4HeajLlJPcTqiBTBxIOkV"
Subject: Re: [Qemu-devel] [PATCH 1/4 for-2.11?] block/dirty-bitmap: add lock
 to bdrv_enable/disable_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, stefanha@redhat.com, armbru@redhat.com, pbonzini@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bpAfEjNjU9Ku4HeajLlJPcTqiBTBxIOkV
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com,
 stefanha@redhat.com, armbru@redhat.com, pbonzini@redhat.com, den@openvz.org,
 nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com
Message-ID: <12463b01-41eb-4d17-65c0-a94de499e753@redhat.com>
Subject: Re: [PATCH 1/4 for-2.11?] block/dirty-bitmap: add lock to
 bdrv_enable/disable_dirty_bitmap
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
 <20171113162053.58795-2-vsementsov@virtuozzo.com>
In-Reply-To: <20171113162053.58795-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/13/2017 10:20 AM, Vladimir Sementsov-Ogievskiy wrote:
> Like other setters here these functions should take a lock.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/dirty-bitmap.c | 4 ++++
>  1 file changed, 4 insertions(+)

Should this patch be in 2.11?

>=20
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index bd04e991b1..2a0bcd9e51 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -397,15 +397,19 @@ void bdrv_remove_persistent_dirty_bitmap(BlockDri=
verState *bs,
>  /* Called with BQL taken.  */
>  void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
>  {
> +    bdrv_dirty_bitmap_lock(bitmap);
>      assert(!bdrv_dirty_bitmap_frozen(bitmap));
>      bitmap->disabled =3D true;
> +    bdrv_dirty_bitmap_unlock(bitmap);

Why do we need this lock in addition to BQL?

>  }
> =20
>  /* Called with BQL taken.  */
>  void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
>  {
> +    bdrv_dirty_bitmap_lock(bitmap);
>      assert(!bdrv_dirty_bitmap_frozen(bitmap));
>      bitmap->disabled =3D false;
> +    bdrv_dirty_bitmap_unlock(bitmap);

Again, why do we need this in addition to BQL?

The commit message needs more details about a scenario where our
existing BQL lock is insufficient to prevent misuse of bitmap->disabled.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bpAfEjNjU9Ku4HeajLlJPcTqiBTBxIOkV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloJ23oACgkQp6FrSiUn
Q2qHOAf+OAQSeQCPtw7zeEnkX0MbpBr21Ifj6TiNXMO4W+xOXKnjY0z41JlnCY4t
l45IIPXCJY0XL89NC+EQGyJ6TSsMnGHnw22zV5O5FCYRQqM9Yv8o5Q6NjWwov8GN
7mgv9MrWPqRur1/0Osj83GmvcUMaAgzGSnuuDvypvt4farfFR+hyOMHNEJVxaSRZ
dWAQkLFx+P/OAERGdTjMpFk/lCAmQXG/CH/R4CBFvx8pHldzflQhGPIWiSxrRK4+
TsgRaXIcuoBoFYwSACMPlUZUQUdhm8O3HfppNqujp7TMiWP1S5YHWdZkOPBvZq9K
TiYo1hdB5lEf1NrugEmSjOb5C5tJKA==
=RNXZ
-----END PGP SIGNATURE-----

--bpAfEjNjU9Ku4HeajLlJPcTqiBTBxIOkV--

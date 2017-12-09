Received: from eggs.gnu.org ([2001:4830:134:3::10]:39786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNiAS-0002o8-TK
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 11:40:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNiAR-0003EU-TG
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 11:40:00 -0500
References: <20171207203036.14993-1-eblake@redhat.com>
	<20171207203036.14993-10-eblake@redhat.com>
	<c0b4ca07-0404-963a-bd1f-9d182eebf469@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bc667ec3-4107-4578-d236-5b914d1291a5@redhat.com>
Date: Sat, 9 Dec 2017 10:39:45 -0600
MIME-Version: 1.0
In-Reply-To: <c0b4ca07-0404-963a-bd1f-9d182eebf469@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uQmaQ7mF5qNEcfTkgPgH4qE0JcaMjxWsf"
Subject: Re: [Qemu-devel] [PATCH v6 09/20] parallels: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uQmaQ7mF5qNEcfTkgPgH4qE0JcaMjxWsf
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <bc667ec3-4107-4578-d236-5b914d1291a5@redhat.com>
Subject: Re: [PATCH v6 09/20] parallels: Switch to .bdrv_co_block_status()
References: <20171207203036.14993-1-eblake@redhat.com>
 <20171207203036.14993-10-eblake@redhat.com>
 <c0b4ca07-0404-963a-bd1f-9d182eebf469@virtuozzo.com>
In-Reply-To: <c0b4ca07-0404-963a-bd1f-9d182eebf469@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/09/2017 06:31 AM, Vladimir Sementsov-Ogievskiy wrote:
> 07.12.2017 23:30, Eric Blake wrote:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.=C2=A0 Update the parallels driver accordingly.=C2=A0 Note =
that
>> the internal function block_status() is still sector-based, because
>> it is still in use by other sector-based functions; but that's okay
>> because request_alignment is 512 as a result of those functions.
>> For now, no optimizations are added based on the mapping hint.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVParallelsState *s =3D bs->opaque;
>> -=C2=A0=C2=A0=C2=A0 int64_t offset;
>> +=C2=A0=C2=A0=C2=A0 int count;
>>
>> +=C2=A0=C2=A0=C2=A0 assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR=
_SIZE));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_mutex_lock(&s->lock);
>> -=C2=A0=C2=A0=C2=A0 offset =3D block_status(s, sector_num, nb_sectors,=
 pnum);
>> +=C2=A0=C2=A0=C2=A0 offset =3D block_status(s, offset >> BDRV_SECTOR_B=
ITS,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 bytes >> BDRV_SECTOR_BITS, &count);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_mutex_unlock(&s->lock);
>>
>> +=C2=A0=C2=A0=C2=A0 *pnum =3D count * BDRV_SECTOR_SIZE;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (offset < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> +=C2=A0=C2=A0=C2=A0 *map =3D offset;
>=20
> oh, didn't notice previous time :(, should be
>=20
> *map =3D offset * BDRV_SECTOR_SIZE
>

Oh, right.

> (also, if you already use ">> BDRV_SECTOR_BITS" in this function,
> would not it be more consistent to use "<< BDRV_SECTOR_BITS"
> for sector-to-byte conversion?)
>=20
> with that fixed (with "<<" or "*", up to you),

'>> BDRV_SECTOR_BITS' always works.  You could also write '/
BDRV_SECTOR_SIZE' (the compiler should figure out that you are dividing
by a power of 2, and use the shift instruction under the hood), but I
find that a bit harder to reason about.

On the other hand, '<< BDRV_SECTOR_BITS' only produces the same size
output as the input; if the left side is 32 bits, it risks overflowing.
But '* BDRV_SECTOR_SIZE' always produces a 64-bit value.  So I've
learned (from past mistakes in other byte-conversion series) that the
multiply form is less likely to introduce unintended truncation bugs.

> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--uQmaQ7mF5qNEcfTkgPgH4qE0JcaMjxWsf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlosEdIACgkQp6FrSiUn
Q2r/0wgAm30T+tLO7k1oaVQrgRSOJ9bqWLf9w4Xo4aNWcf86xW8SxOTWJCo8COUj
bs4epmhECxtnoOsWwQX1+gz9ui9ZPunk2hdmJKJ7yK/GiXVS4eWUrpce9AQrHTUR
otznar4tANX66L4VMot7gMQn3j+JUb+00NYdaX3wAM6ZwknsxatMFyl+i7M3PeIt
kKRVVlr/AflzaIEdkxuWTeAcPZmmoHTr/Uw1fqgh4EoNxlk3SezwSrnSyrygAMIO
Eh8I8xZJJAloRu8vXooBK4XO0gZLoFPGzwJxfioM/wkyL8+rAcfIQkL++r18Oqw4
FAZIkPV2MiB/J7f3g+gihXWQ7ce57Q==
=WWl6
-----END PGP SIGNATURE-----

--uQmaQ7mF5qNEcfTkgPgH4qE0JcaMjxWsf--

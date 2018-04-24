Received: from eggs.gnu.org ([2001:4830:134:3::10]:52518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB1OW-0000oJ-SK
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB1OV-0004KK-I8
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:06:20 -0400
References: <20180215192829.9944-1-eblake@redhat.com>
	<20180215192829.9944-2-eblake@redhat.com>
	<20180424154026.GC4080@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7e74c08c-9086-ac07-fac4-8a75fb716f29@redhat.com>
Date: Tue, 24 Apr 2018 12:06:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180424154026.GC4080@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k2aOACazSSJic975NQalTPvDUXsFzJE4J"
Subject: Re: [Qemu-devel] [PATCH 1/6] block: Support byte-based aio callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k2aOACazSSJic975NQalTPvDUXsFzJE4J
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <7e74c08c-9086-ac07-fac4-8a75fb716f29@redhat.com>
Subject: Re: [PATCH 1/6] block: Support byte-based aio callbacks
References: <20180215192829.9944-1-eblake@redhat.com>
 <20180215192829.9944-2-eblake@redhat.com>
 <20180424154026.GC4080@localhost.localdomain>
In-Reply-To: <20180424154026.GC4080@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2018 10:40 AM, Kevin Wolf wrote:
> Am 15.02.2018 um 20:28 hat Eric Blake geschrieben:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.  Add new sector-based aio callbacks for read and write,
>> to match the fact that bdrv_aio_pdiscard is already byte-based.
>>
>> Ideally, drivers should be converted to use coroutine callbacks
>> rather than aio; but that is not quite as trivial (if we do that
>> conversion, the null-aio driver will disappear), so for the
>> short term, converting the signature but keeping things with aio
>> is easier.  Once all drivers are converted, the sector-based aio
>> callbacks will be removed.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  include/block/block_int.h |  6 ++++++
>>  block/io.c                | 37 +++++++++++++++++++++++++++----------
>>  2 files changed, 33 insertions(+), 10 deletions(-)
>>

>> +++ b/block/io.c
>> @@ -934,9 +934,11 @@ static int coroutine_fn bdrv_driver_preadv(BlockD=
riverState *bs,
>>      sector_num =3D offset >> BDRV_SECTOR_BITS;
>>      nb_sectors =3D bytes >> BDRV_SECTOR_BITS;
>>
>> -    assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
>> -    assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
>> -    assert((bytes >> BDRV_SECTOR_BITS) <=3D BDRV_REQUEST_MAX_SECTORS)=
;
>> +    if (!drv->bdrv_aio_preadv) {
>> +        assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
>> +        assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
>> +        assert((bytes >> BDRV_SECTOR_BITS) <=3D BDRV_REQUEST_MAX_SECT=
ORS);
>> +    }
>=20
> Hm, this is kind of ugly. Previously, we handled everything byte-aligne=
d
> in the first section, now we mix both in the second section.
>=20
> I can see that you do this so you don't have to duplicate the acb and
> coroutine yielding code below, but can we move things into the right
> place in the final patch at least? That is, calculate sector_num and
> nb_sectors only if all the byte-based interfaces weren't available.

Yeah, that's easy enough to squash into patch 6:

diff --git i/block/io.c w/block/io.c
index ba767612931..49fabe8eeb1 100644
--- i/block/io.c
+++ w/block/io.c
@@ -924,16 +924,13 @@ static int coroutine_fn
bdrv_driver_preadv(BlockDriverState *bs,
         return drv->bdrv_co_preadv(bs, offset, bytes, qiov, flags);
     }

-    sector_num =3D offset >> BDRV_SECTOR_BITS;
-    nb_sectors =3D bytes >> BDRV_SECTOR_BITS;
-
-    if (!drv->bdrv_aio_preadv) {
-        assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
-        assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
-        assert((bytes >> BDRV_SECTOR_BITS) <=3D BDRV_REQUEST_MAX_SECTORS=
);
-    }
-
     if (drv->bdrv_co_readv) {
+        sector_num =3D offset >> BDRV_SECTOR_BITS;
+        nb_sectors =3D bytes >> BDRV_SECTOR_BITS;
+
+        assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
+        assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
+        assert((bytes >> BDRV_SECTOR_BITS) <=3D BDRV_REQUEST_MAX_SECTORS=
);
         return drv->bdrv_co_readv(bs, sector_num, nb_sectors, qiov);
     } else {
         BlockAIOCB *acb;

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--k2aOACazSSJic975NQalTPvDUXsFzJE4J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrfY/sACgkQp6FrSiUn
Q2pAgwf+Oht143BIRbngk/5BFMVQEevSj4oW1LLPK/GbY7QkI1cSxSgmcDukZvzS
1RZk2lVZ6E5BHquSXuoAeY0Wur5Bh/8NmurAwOJ1KaCXusjCPBaF1j3quvkw1NT3
0ShcxBw709kRN/sH/Ty/OxHO4MPcEEm0ygeofdI9287bh/1CAVJsdTL9/FPjKqJT
ZOIbtY5wljmx8L3X573XABvykEoMB9ftTMaDNg0pib/w7gRU4x6uT6ic2h9AXaMP
W55a/LOeKF68Ff1/msDFmZbMYg8Mkm8KLNAEpqa6lZpgdAr7B8cYIPVGuph5g+cj
SO6ROSRT+25XcoZywNrTH8f28vMJxA==
=95/v
-----END PGP SIGNATURE-----

--k2aOACazSSJic975NQalTPvDUXsFzJE4J--

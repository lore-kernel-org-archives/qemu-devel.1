Received: from eggs.gnu.org ([2001:4830:134:3::10]:34124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCsn7-00081u-9W
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCsn5-0001Ce-GE
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:14:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCsn5-0001CP-6M
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:14:51 -0400
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495186480-114192-3-git-send-email-anton.nefedov@virtuozzo.com>
	<7fbddc0e-298b-5973-8f0e-47b753ab41a8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <903458e3-c82e-67d5-85f6-e1b67b829ec7@redhat.com>
Date: Mon, 22 May 2017 14:14:42 -0500
MIME-Version: 1.0
In-Reply-To: <7fbddc0e-298b-5973-8f0e-47b753ab41a8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nG7eEBrDKswIoSiF9sEkgoE1lrs48ItQa"
Subject: Re: [Qemu-devel] [PATCH v1 02/13] qcow2: is_zero_sectors(): return
 true if area is outside of backing file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nG7eEBrDKswIoSiF9sEkgoE1lrs48ItQa
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, mreitz@redhat.com
Message-ID: <903458e3-c82e-67d5-85f6-e1b67b829ec7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 02/13] qcow2: is_zero_sectors(): return
 true if area is outside of backing file
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1495186480-114192-3-git-send-email-anton.nefedov@virtuozzo.com>
 <7fbddc0e-298b-5973-8f0e-47b753ab41a8@redhat.com>
In-Reply-To: <7fbddc0e-298b-5973-8f0e-47b753ab41a8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/22/2017 02:12 PM, Eric Blake wrote:

>> +++ b/block/qcow2.c
>> @@ -2482,7 +2482,7 @@ static bool is_zero_sectors(BlockDriverState *bs=
, int64_t start,
>>      int64_t res;
>> =20
>>      if (start + count > bs->total_sectors) {
>> -        count =3D bs->total_sectors - start;
>> +        count =3D start < bs->total_sectors ? bs->total_sectors - sta=
rt : 0;
>>      }
>> =20
>>      if (!count) {
>> @@ -2490,7 +2490,9 @@ static bool is_zero_sectors(BlockDriverState *bs=
, int64_t start,
>>      }
>>      res =3D bdrv_get_block_status_above(bs, NULL, start, count,
>>                                        &nr, &file);
>> -    return res >=3D 0 && (res & BDRV_BLOCK_ZERO) && nr =3D=3D count;
>> +    return res >=3D 0
>> +        && (((res & BDRV_BLOCK_ZERO) && nr =3D=3D count)
>> +            || nr =3D=3D 0);
>=20
> The logic makes sense to me, although the formatting is unusual (we ten=
d
> to split && and || with the operator at the tail of the previous line,
> not the head of the new line).
>=20
> This quick check may make me revisit whether it is worth my my RFC
> series about adding BDRV_BLOCK_EOF for more quickly tracking reads
> beyond EOF (my solution in that series was able to make the same change=

> to test 154, but by doing it at the block layer instead of the qcow2.c
> code).  https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01127.=
html

Actually, re-reading my RFC - I was able to change 6 instances in test
154, while your tweak only affected 2 instances (you still left four
instances that were allocating).  So my approach may still be more
optimal in the long run.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nG7eEBrDKswIoSiF9sEkgoE1lrs48ItQa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIziiAAoJEKeha0olJ0Nqp5gIAJjo42vEVtWWeYgOxnJXFFnk
zn8xZsb1YKCl2H80cMQP6bnydQLQxVLqfVQMjK4hrGuoqosXsx9O1Ifbybmqd8AO
Ab7uI0bmJa6elT4W48ae91NDZtqak96ubZFhP4pMUkbY4VghQ2G4cFCl1hQhd8Xa
YF45rtkR1Plkqu9n7mybKrdX/05wPhL6+YOx7Lp21Utcf0EX+9MN6/fClMfVY3cv
2Z6dpda4LuRwRkgLkFEZZ58TK4H+T8YsT0Bx8HFf6UR7RAzZ+my+L4u7MZc5sDeD
wyfk7RoP/GzIKwkh8prYgsKBLMC5aaWNuwSV3qzqv421TswGkktSRmym09L8NoI=
=1GeZ
-----END PGP SIGNATURE-----

--nG7eEBrDKswIoSiF9sEkgoE1lrs48ItQa--

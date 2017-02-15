Received: from eggs.gnu.org ([2001:4830:134:3::10]:46826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ce2yT-0006Bk-Jh
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ce2yS-0003n3-JH
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:02:37 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-18-vsementsov@virtuozzo.com>
	<119ea962-4746-6563-5133-e2063bc34567@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dfc2c6a2-692f-ecd3-3e2b-4318eacf302e@redhat.com>
Date: Wed, 15 Feb 2017 18:02:28 +0100
MIME-Version: 1.0
In-Reply-To: <119ea962-4746-6563-5133-e2063bc34567@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bBkxRIjcelDgfKHDKjAWnbgq1jTD7c2eU"
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
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bBkxRIjcelDgfKHDKjAWnbgq1jTD7c2eU
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com
Message-ID: <dfc2c6a2-692f-ecd3-3e2b-4318eacf302e@redhat.com>
Subject: Re: [PATCH 17/18] nbd: BLOCK_STATUS for standard get_block_status
 function: server part
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-18-vsementsov@virtuozzo.com>
 <119ea962-4746-6563-5133-e2063bc34567@redhat.com>
In-Reply-To: <119ea962-4746-6563-5133-e2063bc34567@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/02/2017 16:38, Eric Blake wrote:
>> +static int blockstatus_to_extent(BlockDriverState *bs, uint64_t offse=
t,
>> +                                  uint64_t length, NBDExtent *extent)=

>> +{
>> +    BlockDriverState *file;
>> +    uint64_t start_sector =3D offset >> BDRV_SECTOR_BITS;
>> +    uint64_t last_sector =3D (offset + length - 1) >> BDRV_SECTOR_BIT=
S;
> Converting from bytes to sectors by rounding...
>=20
>> +    uint64_t begin =3D start_sector;
>> +    uint64_t end =3D last_sector + 1;
>> +
>> +    int nb =3D MIN(INT_MAX, end - begin);
>> +    int64_t ret =3D bdrv_get_block_status_above(bs, NULL, begin, nb, =
&nb, &file);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    extent->flags =3D
>> +        cpu_to_be32((ret & BDRV_BLOCK_ALLOCATED ? 0 : NBD_STATE_HOLE)=
 |
>> +                    (ret & BDRV_BLOCK_ZERO      ? NBD_STATE_ZERO : 0)=
);
>> +    extent->length =3D cpu_to_be32((nb << BDRV_SECTOR_BITS) -
>> +                                 (offset - (start_sector << BDRV_SECT=
OR_BITS)));
> ...then computing the length by undoing the rounding. I really think we=

> should consider fixing bdrv_get_block_status_above() to be byte-based,
> but that's a separate series.  Your calculations look correct in the
> meantime, although '(offset & (BDRV_SECTOR_SIZE - 1))' may be a bit
> easier to read than '(offset - (start_sector << BDRV_SECTOR_BITS))'.

Agreed.  And please make it a separate variable, i.e.

    uint64_t length;

    length =3D (nb << BDRV_SECTOR_BITS) - (offset & BDRV_SECTOR_SIZE - 1)=
;
    ...
    extent->length =3D cpu_to_be32(length);

Paolo

Paolo


--bBkxRIjcelDgfKHDKjAWnbgq1jTD7c2eU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYpImlAAoJEL/70l94x66DdpoH/j89C7N68cwubQAP/lnx+vuB
u7AeLuUTazGIzITOWDYW7P8oII8KhQAiR+8PbgCPorZPNkuic5xbVemxi8bOjmCF
K17Fi2tWbJOWv9j/UQ4hqPEDr5eG24kzAqCM2xNjFfgzdJ9aqCwiiM1s8/iuH308
Gtj2uBr6sWQKPOXoGYDyBA6ypcjdYaUpeXcsD1qtrkdMmdY7+dP3H/ZezBAc1uaN
QKk/dr2jZ1YwsKJBBsgoryWcOV1XsCkfRadd3IeVknyCeXaw+2LOiqohP3syb++X
6s0sbi4atJ9lVwm1aZd0bnyAoVYXUY0Ktzi3+8wndXQgfA2x1F2AdooUflTvZ6g=
=9xE0
-----END PGP SIGNATURE-----

--bBkxRIjcelDgfKHDKjAWnbgq1jTD7c2eU--

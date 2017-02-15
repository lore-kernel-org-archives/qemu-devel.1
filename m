Received: from eggs.gnu.org ([2001:4830:134:3::10]:47410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ce30X-0007k2-GV
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ce30U-0004Ug-Ap
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:04:45 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-19-vsementsov@virtuozzo.com>
	<01d5a5fd-3ac8-0122-a07a-859bef4f3deb@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <689f7bff-f430-d7d8-d8a2-705091d5a2fc@redhat.com>
Date: Wed, 15 Feb 2017 18:04:37 +0100
MIME-Version: 1.0
In-Reply-To: <01d5a5fd-3ac8-0122-a07a-859bef4f3deb@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Sv92GjsqAJ9KtFBSJAokfcWtGrA7ukPeV"
Subject: Re: [Qemu-devel] [PATCH 18/18] nbd: BLOCK_STATUS for standard
 get_block_status function: client part
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
--Sv92GjsqAJ9KtFBSJAokfcWtGrA7ukPeV
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com
Message-ID: <689f7bff-f430-d7d8-d8a2-705091d5a2fc@redhat.com>
Subject: Re: [PATCH 18/18] nbd: BLOCK_STATUS for standard get_block_status
 function: client part
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-19-vsementsov@virtuozzo.com>
 <01d5a5fd-3ac8-0122-a07a-859bef4f3deb@redhat.com>
In-Reply-To: <01d5a5fd-3ac8-0122-a07a-859bef4f3deb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/02/2017 17:00, Eric Blake wrote:
>> +    if (!client->block_status_ok) {
>> +        *pnum =3D nb_sectors;
>> +        ret =3D BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
>> +        if (bs->drv->protocol_name) {

This condition is always true, I think?

>> +            ret |=3D BDRV_BLOCK_OFFSET_VALID | (sector_num * BDRV_SEC=
TOR_SIZE);
>> +        }
>> +        return ret;
>> +    }
> Looks like a sane fallback when we don't have anything more accurate.

>> +
>> +    ret =3D nbd_client_co_cmd_block_status(bs, sector_num << BDRV_SEC=
TOR_BITS,
>> +                                         nb_sectors << BDRV_SECTOR_BI=
TS,
>> +                                         &extents, &nb_extents);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    *pnum =3D extents[0].length >> BDRV_SECTOR_BITS;
>> +    ret =3D (extents[0].flags & NBD_STATE_HOLE ? 0 : BDRV_BLOCK_ALLOC=
ATED) |
>> +          (extents[0].flags & NBD_STATE_ZERO ? BDRV_BLOCK_ZERO : 0);
>> +
>> +    if ((ret & BDRV_BLOCK_ALLOCATED) && !(ret & BDRV_BLOCK_ZERO)) {
>> +        ret |=3D BDRV_BLOCK_DATA;
>> +    }

You can always return BDRV_BLOCK_OFFSET_VALID here, too.

Paolo


--Sv92GjsqAJ9KtFBSJAokfcWtGrA7ukPeV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYpIolAAoJEL/70l94x66DX9MIAJ4YVc6juE8Of5/3M4f7Jpxx
EPx7xp7Vyv2EBpH38b2g0PqsRFBJyOCgOkpD88cM1OKi3CaJBIt0hJKlm7JRSzoL
3by7t9QS5yYdhJMIBgqAyF4g40OY9uVXvy/QIi+Rfex2bU3+51ibEzo+mHvZO6LD
ea69saIbJKqjgvzOk2Irhu5O6lD5wEzcdAlrAmwNsqfpeMTbU4CVxLBMf5hJXe30
UBTB0wElcceIoyJo51MBtJZsDXPqG2BqoVIjc5RRy/krg/+Y4FF9Uwyzh4gx7mae
mMueBVkQpZtufiAU7x8FNTudnDKola1X7nEoLng24r+HKlhkH+BXG+xf19LMH3w=
=YYXQ
-----END PGP SIGNATURE-----

--Sv92GjsqAJ9KtFBSJAokfcWtGrA7ukPeV--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwvz9-0000Eh-Qp
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwvz8-00028G-Vv
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:57:39 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-8-eblake@redhat.com>
	<00c44c8d-479b-b954-e605-56a3ed00651f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9dd34363-1f30-8c38-979b-32cc53b5d252@redhat.com>
Date: Tue, 26 Sep 2017 14:57:21 -0500
MIME-Version: 1.0
In-Reply-To: <00c44c8d-479b-b954-e605-56a3ed00651f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6UKSnInKonnJUT1fxshi5cHd2Q9ApTnVa"
Subject: Re: [Qemu-devel] [PATCH v4 07/23] block: Convert
 bdrv_get_block_status() to bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6UKSnInKonnJUT1fxshi5cHd2Q9ApTnVa
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <9dd34363-1f30-8c38-979b-32cc53b5d252@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 07/23] block: Convert
 bdrv_get_block_status() to bytes
References: <20170913160333.23622-1-eblake@redhat.com>
 <20170913160333.23622-8-eblake@redhat.com>
 <00c44c8d-479b-b954-e605-56a3ed00651f@redhat.com>
In-Reply-To: <00c44c8d-479b-b954-e605-56a3ed00651f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/26/2017 02:39 PM, John Snow wrote:
>> -int64_t bdrv_get_block_status(BlockDriverState *bs,
>> -                              int64_t sector_num,
>> -                              int nb_sectors, int *pnum,
>> -                              BlockDriverState **file)
>> +int64_t bdrv_block_status(BlockDriverState *bs,
>> +                          int64_t offset, int64_t bytes, int64_t *pnu=
m,
>> +                          BlockDriverState **file)
>>  {
>> -    return bdrv_get_block_status_above(bs, backing_bs(bs),
>> -                                       sector_num, nb_sectors, pnum, =
file);
>> +    int64_t ret;
>> +    int n;
>> +
>> +    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
>> +    bytes =3D MIN(bytes, BDRV_REQUEST_MAX_BYTES);
>> +    ret =3D bdrv_get_block_status_above(bs, backing_bs(bs),
>> +                                      offset >> BDRV_SECTOR_BITS,
>> +                                      bytes >> BDRV_SECTOR_BITS, &n, =
file);
>> +    if (pnum) {
>> +        *pnum =3D n * BDRV_SECTOR_SIZE;
>> +    }
>=20
> Is it safe to truncate the request in the event that the caller did not=

> provide a pnum target? that is, how will they know for what range we ar=
e
> answering?

Hmm. I think I have some rebase cruft here. At one point, I was playing
with the idea of allowing pnum =3D=3D NULL for ALL get_status() callers,
similar to the existing block/vvfat.c:cluster_was_modified():

block/vvfat.c:                    res =3D bdrv_is_allocated(s->qcow->bs,
block/vvfat.c-                                            (offset + i) *
BDRV_SECTOR_SIZE,
block/vvfat.c-
BDRV_SECTOR_SIZE, NULL);

but looking further, only bdrv_is_allocated() (and NOT
bdrv_[get_]block_status) is ever used in that manner.  Or, in terms of
the 'mapping' variable, a NULL pnum only makes sense when mapping =3D=3D
false.  So the conditional on 'if (pnum)' should be dropped here.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6UKSnInKonnJUT1fxshi5cHd2Q9ApTnVa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnKsSEACgkQp6FrSiUn
Q2rzOQf9EBqlOEBxH7GyHrYezOvqDVWlGJb6bMiZJPIkCqLBrTiungHd3YW4Rmx3
bcXLWCHjQ94URiMMpPUnB+pi0mos01wP61zr3Ie4xrJ5DDpvS4cGGjQq1RLROPx2
W/HnjvAy2vYC7etED15Vcn/vM60ppRno4c1RLzYvG8Y8uCwK5nO3aS5i1wZxkIGG
/1oBUxdHDXZdEV3s90myCm02QHlvX6CN9IYaBi9GB4CHIaugbVyaPtBkD37Tw6JS
mHI8zAkysKQ10Zn0C+FFg7YvyMyRkFssNMbPLNWzmbXIMhAK5+7sBndOroAOiUfa
SECZaMFLKv2N/xqOBNh5Ho4GnDMiWQ==
=jZT1
-----END PGP SIGNATURE-----

--6UKSnInKonnJUT1fxshi5cHd2Q9ApTnVa--

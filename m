Received: from eggs.gnu.org ([2001:4830:134:3::10]:59257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cvjeW-0000VG-Tf
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cvjeV-0002MT-Qb
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:03:08 -0400
References: <20170403160936.28293-1-mreitz@redhat.com>
	<20170403160936.28293-10-mreitz@redhat.com>
	<f0a15731-1561-6d4d-c4f5-55c6a66b23a3@amsat.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3989bcc1-b6f9-ea32-4282-a028e3cab803@redhat.com>
Date: Wed, 5 Apr 2017 14:02:39 +0200
MIME-Version: 1.0
In-Reply-To: <f0a15731-1561-6d4d-c4f5-55c6a66b23a3@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vWJS82LMBfsv3lXCebpPKdTWwhewiq2MR"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 09/16] block/qcow2: Generalize
 preallocate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vWJS82LMBfsv3lXCebpPKdTWwhewiq2MR
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <3989bcc1-b6f9-ea32-4282-a028e3cab803@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 09/16] block/qcow2: Generalize
 preallocate()
References: <20170403160936.28293-1-mreitz@redhat.com>
 <20170403160936.28293-10-mreitz@redhat.com>
 <f0a15731-1561-6d4d-c4f5-55c6a66b23a3@amsat.org>
In-Reply-To: <f0a15731-1561-6d4d-c4f5-55c6a66b23a3@amsat.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03.04.2017 21:19, Philippe Mathieu-Daud=E9 wrote:
> Hi Max,
>=20
> On 04/03/2017 01:09 PM, Max Reitz wrote:
>> This patch adds two new parameters to the preallocate() function so we=

>> will be able to use it not just for preallocating a new image but also=

>> for preallocated image growth.
>>
>> The offset parameter allows the caller to specify a virtual offset fro=
m
>> which to start preallocating. For newly created images this is always =
0,
>> but for preallocating growth this will be the old image length.
>>
>> The new_length parameter specifies the supposed new length of the imag=
e
>> (basically the "end offset" for preallocation). During image truncatio=
n,
>> bdrv_getlength() will return the old image length so we cannot rely on=

>> its return value then.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/qcow2.c | 16 +++++++++++-----
>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 9fd220ec34..163d51ec65 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -2034,17 +2034,23 @@ static int
>> qcow2_change_backing_file(BlockDriverState *bs,
>>      return qcow2_update_header(bs);
>>  }
>>
>> -static int preallocate(BlockDriverState *bs)
>> +/**
>> + * Preallocates metadata structures for data clusters between @offset=

>> (in the
>> + * guest disk) and @new_length (which is thus generally the new guest=

>> disk
>> + * size).
>> + *
>> + * Returns: 0 on success, -errno on failure.
>> + */
>> +static int preallocate(BlockDriverState *bs, int64_t offset, int64_t
>> new_length)
>>  {
>>      uint64_t bytes;
>> -    uint64_t offset;
>>      uint64_t host_offset =3D 0;
>>      unsigned int cur_bytes;
>>      int ret;
>>      QCowL2Meta *meta;
>>
>> -    bytes =3D bdrv_getlength(bs);
>> -    offset =3D 0;
>=20
> why use `int64_t`? is it ok to have a negative offset?
> preallocate a negative length sound weird... even `bytes` is unsigned.

Right. That's actually a very good question. I can't remember why I
chose them to be signed.

Generally, it won't be an issue because the QEMU block layer will
generally not permit files to be longer than 2^63 (e.g.
bdrv_co_pwritev() and bdrv_co_preadv() take int64_t offsets).

But you're right, there is no reason for those parameters to be signed
here. I'll make them unsigned, thanks!

Max

>> +    assert(offset <=3D new_length);
>> +    bytes =3D new_length - offset;
>>
>>      while (bytes) {
>>          cur_bytes =3D MIN(bytes, INT_MAX);
>> @@ -2314,7 +2320,7 @@ static int qcow2_create2(const char *filename,
>> int64_t total_size,
>>      if (prealloc !=3D PREALLOC_MODE_OFF) {
>>          BDRVQcow2State *s =3D blk_bs(blk)->opaque;
>>          qemu_co_mutex_lock(&s->lock);
>> -        ret =3D preallocate(blk_bs(blk));
>> +        ret =3D preallocate(blk_bs(blk), 0, total_size);
>>          qemu_co_mutex_unlock(&s->lock);
>>          if (ret < 0) {
>>              error_setg_errno(errp, -ret, "Could not preallocate
>> metadata");
>>



--vWJS82LMBfsv3lXCebpPKdTWwhewiq2MR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljk3N8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A8P0IAK8iiA9J250HWX4MiqoPqTwVmbWlv4yo
H7B22VuyUut4baZybFrz0+xH7QDcA0coq6R88+RN8iDSmYLeau7sVv3vMAA3xsG1
0y/P2o/Ln1LPcXufBOQ4RUPkbnJ7izAWqHt3+ShzKMNb56lU8/uzwh6mEc2iOVpr
ju8uvQHDI//u1EHGQPow7/p2srsXUCNFqELV3r//nqMMTGRXLiOERGJnRdMhSlLF
cbGuNbHZwERQXK3P/DsfC28/ZhfqH+ecSxOk/a4v9XPJWIt2RM58xa6uGksnQHAb
aJAiWS+MhUcUPTFP7qP+1BPrD9PywVfXThUHkDzEFMvw3DU3oDJ+AjA=
=Z/51
-----END PGP SIGNATURE-----

--vWJS82LMBfsv3lXCebpPKdTWwhewiq2MR--

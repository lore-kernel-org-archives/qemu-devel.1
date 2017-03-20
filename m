Received: from eggs.gnu.org ([2001:4830:134:3::10]:58612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cpz10-00070g-Ew
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cpz0u-0007ST-QX
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:14:34 -0400
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214117.27350-4-mreitz@redhat.com>
	<20170320112637.GM17887@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c84b9653-d89f-2baa-a92c-9332ce072b6d@redhat.com>
Date: Mon, 20 Mar 2017 16:14:21 +0100
MIME-Version: 1.0
In-Reply-To: <20170320112637.GM17887@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w1XpJA5G5IlRfpk8Ai943URkP6pafm8CL"
Subject: Re: [Qemu-devel] [PATCH for-2.10 13/16] block/qcow2:
 qcow2_calc_size_usage() for truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w1XpJA5G5IlRfpk8Ai943URkP6pafm8CL
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <c84b9653-d89f-2baa-a92c-9332ce072b6d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 13/16] block/qcow2:
 qcow2_calc_size_usage() for truncate
References: <20170313214001.26339-1-mreitz@redhat.com>
 <20170313214117.27350-4-mreitz@redhat.com>
 <20170320112637.GM17887@stefanha-x1.localdomain>
In-Reply-To: <20170320112637.GM17887@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20.03.2017 12:26, Stefan Hajnoczi wrote:
> On Mon, Mar 13, 2017 at 10:41:14PM +0100, Max Reitz wrote:
>> This patch extends qcow2_calc_size_usage() so it can calculate the
>> additional space needed for preallocating image growth.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/qcow2.c | 137 +++++++++++++++++++++++++++++++++++++++++--------=
---------
>>  1 file changed, 98 insertions(+), 39 deletions(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 21b2b3cd53..80fb815b15 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -2101,7 +2101,15 @@ done:
>>      return ret;
>>  }
>> =20
>> -static uint64_t qcow2_calc_size_usage(uint64_t new_size,
>> +/**
>> + * Returns the number of bytes that must be allocated in the underlyi=
ng file
>> + * to accomodate an image growth from @current_size to @new_size.
>> + *
>> + * @current_size must be 0 when creating a new image. In that case, @=
bs is
>> + * ignored; otherwise it must be valid.
>> + */
>> +static uint64_t qcow2_calc_size_usage(BlockDriverState *bs,
>> +                                      uint64_t current_size, uint64_t=
 new_size,
>>                                        int cluster_bits, int refcount_=
order)
>>  {
>>      size_t cluster_size =3D 1u << cluster_bits;
>> @@ -2122,47 +2130,97 @@ static uint64_t qcow2_calc_size_usage(uint64_t=
 new_size,
>>      refblock_bits =3D cluster_bits - (refcount_order - 3);
>>      refblock_size =3D 1 << refblock_bits;
>> =20
>> -    /* header: 1 cluster */
>> -    meta_size +=3D cluster_size;
>> -
>> -    /* total size of L2 tables */
>> -    nl2e =3D aligned_total_size / cluster_size;
>> -    nl2e =3D align_offset(nl2e, cluster_size / sizeof(uint64_t));
>> -    meta_size +=3D nl2e * sizeof(uint64_t);
>> +    if (!current_size) {
>=20
> This massive if statement effectively makes two functions: the old
> qcow2_calc_size_usage() and the new qcow2_calc_size_change(bs) function=
=2E
>=20
> It might be nicer to split the two functions.

Hm, yes, but at that point I might as well just write two completely
separate functions. I'll see what I can do, maybe I'll just put the new
logic that's needed into a completely new function after all.

Max


--w1XpJA5G5IlRfpk8Ai943URkP6pafm8CL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljP8c0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ASyQH/ifXA2GvAqX/wEoxvyz1UbqWo3hDDRfV
qBLe0Ja1Dd2UY3i0Y0PCaxB3Hwz+6ywGjhCx4MlbhP6ryihmgmxAK908dpU3B6lF
+XnISP+UuJqg1UT0uxRLOkaADUdkXrbrLTqPOaEzFPM9sBGbjln/MLz9d/PDw5nz
Flqk8Yuk6O+uI6IffLsprps9Uo/ZlyCG79nfg2JlOmlldWXz0+JkjmQqSlSHYulV
f9lgTkQ1r3/oadIcaigmwP4dSaHTdbbZjF7hbw/k/dcUlr7ETJow0AtS+48Um6Sa
xuqYbHU5kBLtQJuSxxMRXWXA90c91JsJSx9Sv7PNVXr0ecOtSg8cBvM=
=uj1U
-----END PGP SIGNATURE-----

--w1XpJA5G5IlRfpk8Ai943URkP6pafm8CL--

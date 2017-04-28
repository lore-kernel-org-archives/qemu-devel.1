Received: from eggs.gnu.org ([2001:4830:134:3::10]:37174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4BC7-0005T6-Uc
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4BC6-0000ug-Ly
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:04:43 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-3-eblake@redhat.com>
	<de3f94c3-5941-5301-5408-93c43adc1543@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <88d9a7ed-7740-e967-2c61-21a304032cfe@redhat.com>
Date: Fri, 28 Apr 2017 14:04:33 -0500
MIME-Version: 1.0
In-Reply-To: <de3f94c3-5941-5301-5408-93c43adc1543@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4GiQmL2cm188pj291m7j9CK0JdDAGD29S"
Subject: Re: [Qemu-devel] [PATCH v10 02/17] qcow2: Correctly report status
 of preallocated zero clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4GiQmL2cm188pj291m7j9CK0JdDAGD29S
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <88d9a7ed-7740-e967-2c61-21a304032cfe@redhat.com>
Subject: Re: [PATCH v10 02/17] qcow2: Correctly report status of preallocated
 zero clusters
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-3-eblake@redhat.com>
 <de3f94c3-5941-5301-5408-93c43adc1543@redhat.com>
In-Reply-To: <de3f94c3-5941-5301-5408-93c43adc1543@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2017 12:35 PM, Max Reitz wrote:
> On 27.04.2017 03:46, Eric Blake wrote:
>> We were throwing away the preallocation information associated with
>> zero clusters.  But we should be matching the well-defined semantics
>> in bdrv_get_block_status(), where (BDRV_BLOCK_ZERO |
>> BDRV_BLOCK_OFFSET_VALID) informs the user which offset is reserved,
>> while still reminding the user that reading from that offset is
>> likely to read garbage.
>>
>> Making this change lets us see which portions of an image are zero
>> but preallocated, when using qemu-img map --output=3Djson.  The
>> --output=3Dhuman side intentionally ignores all zero clusters, whether=

>> or not they are preallocated.
>>
>> The fact that there is no change to qemu-iotests './check -qcow2'
>> merely means that we aren't yet testing this aspect of qemu-img;
>> a later patch will add a test.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v10: new patch
>> ---
>>  block/qcow2-cluster.c | 32 +++++++++++++++++++++++++++-----
>>  1 file changed, 27 insertions(+), 5 deletions(-)
>=20
> I'd propose you split the qcow2 changes off of this series.

Yeah, it's sort of morphed into a well-tested later part and an earlier
part that is still undergoing heavy review.  I don't know how much churn
there would be to rebase things to do the blkdebug changes first (it may
invalidate portions of my test 177; but I could always tag such spots as
FIXME while waiting on the qcow2 part to settle and land).  I'll see
what I can do, as I've now got multiple series queued up, and should at
least get SOMETHING to land to start clearing up the logjam.


>> @@ -335,9 +339,10 @@ static int count_contiguous_clusters_by_type(int =
nb_clusters,
>>      int i;
>>
>>      for (i =3D 0; i < nb_clusters; i++) {
>> -        int type =3D qcow2_get_cluster_type(be64_to_cpu(l2_table[i]))=
;
>> +        uint64_t entry =3D be64_to_cpu(l2_table[i]);
>> +        int type =3D qcow2_get_cluster_type(entry);
>>
>> -        if (type !=3D wanted_type) {
>> +        if (type !=3D wanted_type || entry & L2E_OFFSET_MASK) {
>=20
> This works only for wanted_type \in \{ ZERO, UNALLOCATED \} -- which is=

> what the comment you added describes, but this may still warrant a
> renaming of this function (count_contiguous_unallocated_clusters?) and
> probably an assertion that wanted_type is ZERO or UNALLOCATED.

Good idea.


>> @@ -559,9 +564,26 @@ int qcow2_get_cluster_offset(BlockDriverState *bs=
, uint64_t offset,
>>              ret =3D -EIO;
>>              goto fail;
>>          }
>> -        c =3D count_contiguous_clusters_by_type(nb_clusters, &l2_tabl=
e[l2_index],
>> -                                              QCOW2_CLUSTER_ZERO);
>> -        *cluster_offset =3D 0;
>> +        /* Distinguish between pure zero clusters and pre-allocated o=
nes */
>> +        if (*cluster_offset & L2E_OFFSET_MASK) {
>> +            c =3D count_contiguous_clusters(nb_clusters, s->cluster_s=
ize,
>> +                                          &l2_table[l2_index], QCOW_O=
FLAG_ZERO);
>=20
> You should probably switch this patch and the next one -- or I just sen=
d
> my patches myself and you base your series on top of it...

I tested with your patches in, then rebased with your patches out to see
what broke, and...

>=20
> Because before the next patch, this happens:
>=20

> $ ./qemu-img map foo.qcow2
> Offset          Length          Mapped to       File
> qemu-img: block/qcow2-cluster.c:319: count_contiguous_clusters:
> Assertion `qcow2_get_cluster_type(first_entry) =3D=3D QCOW2_CLUSTER_NOR=
MAL'
> failed.

got that same assert. So I realized that your patch was necessary and
rebased it back in, but obviously forgot to re-test at all points in the
series. Yes, your should go first, and I'd be more than happy if you
post yours formally and I rebase my qcow2 portions on top of yours (all
the more reason for me to split this series into two, and get the
blkdebug portions in now while we still hammer on the qcow2 stuff).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4GiQmL2cm188pj291m7j9CK0JdDAGD29S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA5JCAAoJEKeha0olJ0Nq0JIH/iGTzXlD+567Yu8QrCYGJJo9
43QOHQVvN5LiKvkKE/fHOTJFnWgrPigJd1jlJVtVpDoKExxVCpIT0nwrTmxl3l6A
JReAAmtos4apQ3nIYmuldgwcLTmVXeXq9yurTWHNxHxIqHQ8rOkdQJ7KdG+mK64P
fU0MWCR3Cuy5i+vI0RtBnNKHRZYnZ43LCTUg2INlma4poT5EcDgeLX1jGFDXwVgq
blDaoPgXYileqpkAjdQotJ4baeA8BR2mEhznrMLSBpb2Mn1yWNXqE00UwCCDS/b5
Av7ioDzia3fTD0GfOGV1TkXQbHPI0h4PAllvi8/POE0zOyCqEqYnZ026/pvm++8=
=6ctA
-----END PGP SIGNATURE-----

--4GiQmL2cm188pj291m7j9CK0JdDAGD29S--

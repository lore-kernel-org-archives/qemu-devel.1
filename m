Received: from eggs.gnu.org ([2001:4830:134:3::10]:53698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dVKyQ-0007fW-Ak
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dVKyP-0006tC-Ce
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:58:50 -0400
References: <20170712114700.20008-1-pbutsykin@virtuozzo.com>
	<20170712114700.20008-4-pbutsykin@virtuozzo.com>
	<20170712145251.GE4917@noname.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ca2e112d-23d7-48c1-07a9-b60ee8ab743f@redhat.com>
Date: Wed, 12 Jul 2017 18:58:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170712145251.GE4917@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gqQ4l5g8MNgr2ME4jxwBMKfi2wh8069N5"
Subject: Re: [Qemu-devel] [PATCH v5 3/4] qcow2: add shrink image support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gqQ4l5g8MNgr2ME4jxwBMKfi2wh8069N5
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com,
 armbru@redhat.com, den@openvz.org
Message-ID: <ca2e112d-23d7-48c1-07a9-b60ee8ab743f@redhat.com>
Subject: Re: [PATCH v5 3/4] qcow2: add shrink image support
References: <20170712114700.20008-1-pbutsykin@virtuozzo.com>
 <20170712114700.20008-4-pbutsykin@virtuozzo.com>
 <20170712145251.GE4917@noname.str.redhat.com>
In-Reply-To: <20170712145251.GE4917@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-12 16:52, Kevin Wolf wrote:
> Am 12.07.2017 um 13:46 hat Pavel Butsykin geschrieben:
>> This patch add shrinking of the image file for qcow2. As a result, thi=
s allows
>> us to reduce the virtual image size and free up space on the disk with=
out
>> copying the image. Image can be fragmented and shrink is done by punch=
ing holes
>> in the image file.
>>
>> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/qcow2-cluster.c  |  40 ++++++++++++++++++
>>  block/qcow2-refcount.c | 110 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  block/qcow2.c          |  43 +++++++++++++++----
>>  block/qcow2.h          |  14 +++++++
>>  qapi/block-core.json   |   3 +-
>>  5 files changed, 200 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>> index f06c08f64c..518429c64b 100644
>> --- a/block/qcow2-cluster.c
>> +++ b/block/qcow2-cluster.c
>> @@ -32,6 +32,46 @@
>>  #include "qemu/bswap.h"
>>  #include "trace.h"
>> =20
>> +int qcow2_shrink_l1_table(BlockDriverState *bs, uint64_t exact_size)
>> +{
>> +    BDRVQcow2State *s =3D bs->opaque;
>> +    int new_l1_size, i, ret;
>> +
>> +    if (exact_size >=3D s->l1_size) {
>> +        return 0;
>> +    }
>> +
>> +    new_l1_size =3D exact_size;
>> +
>> +#ifdef DEBUG_ALLOC2
>> +    fprintf(stderr, "shrink l1_table from %d to %d\n", s->l1_size, ne=
w_l1_size);
>> +#endif
>> +
>> +    BLKDBG_EVENT(bs->file, BLKDBG_L1_SHRINK_WRITE_TABLE);
>> +    ret =3D bdrv_pwrite_zeroes(bs->file, s->l1_table_offset +
>> +                                       sizeof(uint64_t) * new_l1_size=
,
>> +                             (s->l1_size - new_l1_size) * sizeof(uint=
64_t), 0);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    ret =3D bdrv_flush(bs->file->bs);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>=20
> If we have an error here (or after a partial bdrv_pwrite_zeroes()), we
> have entries zeroed out on disk, but in memory we still have the
> original L1 table.
>=20
> Should the in-memory L1 table be zeroed first? Then we can't
> accidentally reuse stale entries, but would have to allocate new ones,
> which would get on-disk state and in-memory state back in sync again.

Yes, I thought of the same.  But this implies that the allocation is
able to modify the L1 table, and I find that unlikely if that
bdrv_flush() failed already...

So I concluded not to have an opinion on which order is better.

>> +    BLKDBG_EVENT(bs->file, BLKDBG_L1_SHRINK_FREE_L2_CLUSTERS);
>> +    for (i =3D s->l1_size - 1; i > new_l1_size - 1; i--) {
>> +        if ((s->l1_table[i] & L1E_OFFSET_MASK) =3D=3D 0) {
>> +            continue;
>> +        }
>> +        qcow2_free_clusters(bs, s->l1_table[i] & L1E_OFFSET_MASK,
>> +                            s->cluster_size, QCOW2_DISCARD_ALWAYS);
>> +        s->l1_table[i] =3D 0;
>> +    }
>> +    return 0;
>> +}
>> +
>>  int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
>>                          bool exact_size)
>>  {
>=20
> I haven't checked qcow2_shrink_reftable() for similar kinds of problems=
,
> I hope Max has.

Well, it's exactly the same there.

Max


--gqQ4l5g8MNgr2ME4jxwBMKfi2wh8069N5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZZlU8EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQAa4
B/9yz/LN/7lH4DbgOgpQgijmNap751VEfCxMYAYZ8ohZN4uSDrxmC5Wwn7MD4BXD
DAjiuyzu/J04rB0MOSXba9d/FFms3vi1uRCTaNVPGw6/DOCZ/ru8QoaBRYJByLMJ
yeYGocKoteoWLwrxgpK8GNddJLn8Pq1nwHhGGZtjOJnUhgfnxXsQEsGSyfEU8xXs
t3BEIMUaLp+flPgn917nuShSDqPSxkm053+pfhRHbil280bCYDowwL7SgMf1qLjt
970BE3TCeHkT6wyEbEIMYxRCROzueWVoXAi0fOWB1FF6iu7XbG5gHRTkg7f3PEee
Sedc4EFftGMEpj8Fm5JdPe90
=7tv5
-----END PGP SIGNATURE-----

--gqQ4l5g8MNgr2ME4jxwBMKfi2wh8069N5--

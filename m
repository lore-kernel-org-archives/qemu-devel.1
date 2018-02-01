Received: from eggs.gnu.org ([2001:4830:134:3::10]:53026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehJKK-0006h8-9l
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehJKJ-0003tJ-69
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:11:12 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<5e98f636670e1741b9bafae624efb0052d9d0b71.1516978645.git.berto@igalia.com>
	<d21ddbab-921c-3cc9-05dd-5113cb16fd8f@redhat.com>
	<w51tvv156xi.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3fd568fa-3b42-fff7-d531-bce6d938f1de@redhat.com>
Date: Thu, 1 Feb 2018 19:10:58 +0100
MIME-Version: 1.0
In-Reply-To: <w51tvv156xi.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nYCSnklABRzIlGtyqktzSmFh4e9vaREeF"
Subject: Re: [Qemu-devel] [PATCH v3 18/39] qcow2: Refactor
 get_cluster_table()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nYCSnklABRzIlGtyqktzSmFh4e9vaREeF
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <3fd568fa-3b42-fff7-d531-bce6d938f1de@redhat.com>
Subject: Re: [PATCH v3 18/39] qcow2: Refactor get_cluster_table()
References: <cover.1516978645.git.berto@igalia.com>
 <5e98f636670e1741b9bafae624efb0052d9d0b71.1516978645.git.berto@igalia.com>
 <d21ddbab-921c-3cc9-05dd-5113cb16fd8f@redhat.com>
 <w51tvv156xi.fsf@maestria.local.igalia.com>
In-Reply-To: <w51tvv156xi.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-01 11:40, Alberto Garcia wrote:
> On Wed 31 Jan 2018 09:11:48 PM CET, Max Reitz wrote:
>> On 2018-01-26 15:59, Alberto Garcia wrote:
>>> After the previous patch we're now always using l2_load() in
>>> get_cluster_table() regardless of whether a new L2 table has to be
>>> allocated or not.
>>>
>>> This patch refactors that part of the code to use one single l2_load(=
)
>>> call.
>>>
>>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>>> ---
>>>  block/qcow2-cluster.c | 21 +++++++--------------
>>>  1 file changed, 7 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>>> index 2a53c1dc5f..0c0cab85e8 100644
>>> --- a/block/qcow2-cluster.c
>>> +++ b/block/qcow2-cluster.c
>>> @@ -695,15 +695,7 @@ static int get_cluster_table(BlockDriverState *b=
s, uint64_t offset,
>>>          return -EIO;
>>>      }
>>> =20
>>> -    /* seek the l2 table of the given l2 offset */
>>> -
>>> -    if (s->l1_table[l1_index] & QCOW_OFLAG_COPIED) {
>>> -        /* load the l2 table in memory */
>>> -        ret =3D l2_load(bs, offset, l2_offset, &l2_table);
>>> -        if (ret < 0) {
>>> -            return ret;
>>> -        }
>>> -    } else {
>>> +    if (!(s->l1_table[l1_index] & QCOW_OFLAG_COPIED)) {
>>>          /* First allocate a new L2 table (and do COW if needed) */
>>>          ret =3D l2_allocate(bs, l1_index);
>>>          if (ret < 0) {
>>> @@ -719,11 +711,12 @@ static int get_cluster_table(BlockDriverState *=
bs, uint64_t offset,
>>>          /* Get the offset of the newly-allocated l2 table */
>>>          l2_offset =3D s->l1_table[l1_index] & L1E_OFFSET_MASK;
>>>          assert(offset_into_cluster(s, l2_offset) =3D=3D 0);
>>> -        /* Load the l2 table in memory */
>>> -        ret =3D l2_load(bs, offset, l2_offset, &l2_table);
>>> -        if (ret < 0) {
>>> -            return ret;
>>> -        }
>>> +    }
>>> +
>>> +    /* load the l2 table in memory */
>>> +    ret =3D l2_load(bs, offset, l2_offset, &l2_table);
>>> +    if (ret < 0) {
>>> +        return ret;
>>>      }
>>
>> I'd pull the l2_offset assignment (and alignment check) down below the=

>> QCOW_OFLAG_COPIED check, saving us another two lines (!!1!) which we
>> could then spend on an
>>
>> assert(s->l1_table[l1_index] & QCOW_OFLAG_COPIED);
>=20
> I'm not sure if I'm following you. We need to set l2_offset before and
> after allocating a new L2 table.
>=20
> Before, because we need the offset of the old table (if there was one)
> in order to decrease its refcount.
>=20
> And after, because we need the offset of the new table in order to load=

> it.

Ah, right, yeah... Well, too bad.  Then I probably can't ask for the
assert() that badly.

Reviewed-by: Max Reitz <mreitz@redhat.com>


--nYCSnklABRzIlGtyqktzSmFh4e9vaREeF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzWDISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AVJkH/jjkswnCVukcERlvkhaEuF8Beb+U7y6I
02nKtxFR6yr2ozgW9X+OebQgpUS6M47Gdti2kk0qI7KxICkdoV7F5Bq67fn2Wd0r
N0ias3t0WHVHInVKWo+MLDoTvKtq5PjNcH/0xyaSItjLaTHA+lRyBGTCyNq+YOln
LRhY/ua4Zrc7LORHMEeQWgumtZI6SwMfwUjuDAn+q4CK6/s3BmxOqiEeMvkhNaHa
osCG6G0EPclYyRkkIqQCC9CtIR9INS84yV9K1gxJSOnMudpjN2VKnKCvEm2Bg/fg
2Doody+juf8A1XIachIefr2pdKk9Z/nkpyLeWKKz4U7gHRMop8tQ3Xk=
=K2+p
-----END PGP SIGNATURE-----

--nYCSnklABRzIlGtyqktzSmFh4e9vaREeF--

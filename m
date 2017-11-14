Received: from eggs.gnu.org ([2001:4830:134:3::10]:35744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEd8F-0000bo-Nw
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:28:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEd8E-00034U-UD
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:28:11 -0500
References: <20171110203111.7666-1-mreitz@redhat.com>
	<20171110203111.7666-5-mreitz@redhat.com>
	<w511sl0299i.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b6811e30-abd5-5f91-7b2b-7f10bd7feba5@redhat.com>
Date: Tue, 14 Nov 2017 16:27:56 +0100
MIME-Version: 1.0
In-Reply-To: <w511sl0299i.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7HdcXPPc87UI8o2nWVuG1FHlD8BPfiVo1"
Subject: Re: [Qemu-devel] [PATCH for-2.11 4/5] qcow2: Add bounds check to
 get_refblock_offset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7HdcXPPc87UI8o2nWVuG1FHlD8BPfiVo1
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <b6811e30-abd5-5f91-7b2b-7f10bd7feba5@redhat.com>
Subject: Re: [PATCH for-2.11 4/5] qcow2: Add bounds check to
 get_refblock_offset()
References: <20171110203111.7666-1-mreitz@redhat.com>
 <20171110203111.7666-5-mreitz@redhat.com>
 <w511sl0299i.fsf@maestria.local.igalia.com>
In-Reply-To: <w511sl0299i.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-14 16:02, Alberto Garcia wrote:
> On Fri 10 Nov 2017 09:31:10 PM CET, Max Reitz wrote:
>> +static int64_t get_refblock_offset(BlockDriverState *bs, uint64_t off=
set)
>> +{
>> +    BDRVQcow2State *s =3D bs->opaque;
>> +    uint32_t index =3D offset_to_reftable_index(s, offset);
>> +    int64_t covering_refblock_offset =3D 0;
>> +
>> +    if (index < s->refcount_table_size) {
>> +        covering_refblock_offset =3D s->refcount_table[index] & REFT_=
OFFSET_MASK;
>> +    }
>> +    if (!covering_refblock_offset) {
>> +        qcow2_signal_corruption(bs, true, -1, -1, "Refblock at %#" PR=
Ix64 " is "
>> +                                "not covered by the refcount structur=
es",
>> +                                offset);
>> +        return -EIO;
>> +    }
>> +
>> +    return covering_refblock_offset;
>> +}
>=20
> Isn't it simpler to do something like this instead?
>=20
>    if (index >=3D s->refcount_table_size) {
>        qcow2_signal_corruption(...);
>        return -EIO;
>    }
>    return s->refcount_table[index] & REFT_OFFSET_MASK;

But that doesn't cover the case were s->refcount_table[index] &
REFT_OFFSET_MASK is 0.

Max


--7HdcXPPc87UI8o2nWVuG1FHlD8BPfiVo1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloLC3wSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A6uoH/3/Yi11TIWtav5iRnKfyFT+bjB0vDkqh
Umot5Q4BWhD3HvqtRz9WN0E9k5Eg1M39pMvmbrCxixrl97Ai21ku+DRJpfw4/ShM
xKiQkQBdeXWo4EooXypGCZQqeMKLBoUzvz5GHLwX8VTi1NhPKxKRGie21BS0N2x0
pZnzK3YmkwwKROgKmvLxZx43tXDjefby9kqt7w5QWLPqaMJhmALsxhWsZfAoC2oq
co/sz+6lc88SO5flmyMd7Ij3HL2xsjehsTm7o2KlTIdiiJFl5KMBMc73rDcL303y
CBqgf9mIMA+ow4C24+tH2pO/JMk2BOR08D1/TFQkx1nWWz0IfCG2wtQ=
=q177
-----END PGP SIGNATURE-----

--7HdcXPPc87UI8o2nWVuG1FHlD8BPfiVo1--

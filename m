Received: from eggs.gnu.org ([2001:4830:134:3::10]:42589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEdKx-0001sA-Ik
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEdKt-0005ph-9I
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:41:19 -0500
References: <20171110203111.7666-1-mreitz@redhat.com>
	<20171110203111.7666-5-mreitz@redhat.com>
	<w511sl0299i.fsf@maestria.local.igalia.com>
	<b6811e30-abd5-5f91-7b2b-7f10bd7feba5@redhat.com>
	<w51po8kzx8f.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ec65689d-94c0-d7f9-831e-7c28f95855b2@redhat.com>
Date: Tue, 14 Nov 2017 16:40:55 +0100
MIME-Version: 1.0
In-Reply-To: <w51po8kzx8f.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m7SQRp7taX9A0bCv6R8MMPKPw56NLogIq"
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
--m7SQRp7taX9A0bCv6R8MMPKPw56NLogIq
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <ec65689d-94c0-d7f9-831e-7c28f95855b2@redhat.com>
Subject: Re: [PATCH for-2.11 4/5] qcow2: Add bounds check to
 get_refblock_offset()
References: <20171110203111.7666-1-mreitz@redhat.com>
 <20171110203111.7666-5-mreitz@redhat.com>
 <w511sl0299i.fsf@maestria.local.igalia.com>
 <b6811e30-abd5-5f91-7b2b-7f10bd7feba5@redhat.com>
 <w51po8kzx8f.fsf@maestria.local.igalia.com>
In-Reply-To: <w51po8kzx8f.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-14 16:38, Alberto Garcia wrote:
> On Tue 14 Nov 2017 04:27:56 PM CET, Max Reitz wrote:
>>>> +static int64_t get_refblock_offset(BlockDriverState *bs, uint64_t o=
ffset)
>>>> +{
>>>> +    BDRVQcow2State *s =3D bs->opaque;
>>>> +    uint32_t index =3D offset_to_reftable_index(s, offset);
>>>> +    int64_t covering_refblock_offset =3D 0;
>>>> +
>>>> +    if (index < s->refcount_table_size) {
>>>> +        covering_refblock_offset =3D s->refcount_table[index] & REF=
T_OFFSET_MASK;
>>>> +    }
>>>> +    if (!covering_refblock_offset) {
>>>> +        qcow2_signal_corruption(bs, true, -1, -1, "Refblock at %#" =
PRIx64 " is "
>>>> +                                "not covered by the refcount struct=
ures",
>>>> +                                offset);
>>>> +        return -EIO;
>>>> +    }
>>>> +
>>>> +    return covering_refblock_offset;
>>>> +}
>>>
>>> Isn't it simpler to do something like this instead?
>>>
>>>    if (index >=3D s->refcount_table_size) {
>>>        qcow2_signal_corruption(...);
>>>        return -EIO;
>>>    }
>>>    return s->refcount_table[index] & REFT_OFFSET_MASK;
>>
>> But that doesn't cover the case were s->refcount_table[index] &
>> REFT_OFFSET_MASK is 0.
>=20
> Ah, you're right. That would be detected by the qcow2_cache_get() call
> though, but it's fine to do the check here as well.

After patch 5, yes, but it would lead to a failed assertion.

Before this series, there is no protection in place; the cache will
happily serve you any empty entry (because offset 0 is used for empty
entries) and pretend it's the correct block.

Only when you try to dirty it is when you run into problems (because
then you'll get an assertion failure).

Max

> Reviewed-by: Alberto Garcia <berto@igalia.com>
>=20
> Berto
>=20



--m7SQRp7taX9A0bCv6R8MMPKPw56NLogIq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloLDocSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A0EkIAI17TxG1h/OyooGUX3Nj9I+NRCWJQ/Pp
TVbF5Gn16fjrly4ciADEQ+Z43EGeN0iK3Rp8rN/MPYkWOvLE5pYiraMn4GuTDyrj
aAaPhTQ6eTI2/qUClEhFo7n7ssX1p2DJFCB+/YFFUmdXvfs1ea7TjFJxK6Tnmh1j
msHp8AL/7uR5ZCCZk9qjznYfxsUh6tD9gJdxBRlsjQyKEF0QYjeLVRCti1TPSTmV
E2QIrHk8irdCpXitkTBI7lo7bCIB/rwiB8w4aSa20mb2q0PBg0txmVgbPBuogLlO
+1CUlFwbRMg/9HCjzkPq5W12FzswR46+7zcvvCOb/7v3o5m6AA7T3ro=
=AeLf
-----END PGP SIGNATURE-----

--m7SQRp7taX9A0bCv6R8MMPKPw56NLogIq--

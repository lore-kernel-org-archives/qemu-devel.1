Received: from eggs.gnu.org ([2001:4830:134:3::10]:45237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG3oe-00044q-8S
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG3od-0004pF-CZ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:37:36 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-26-vsementsov@virtuozzo.com>
	<2329cfc4-d5b3-9fe2-668d-fd6ba1f5d316@redhat.com>
	<48da970c-8400-346b-6ade-543e9f314197@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fd318432-5da7-6554-91a2-38deb78adcf1@redhat.com>
Date: Wed, 31 May 2017 15:37:18 +0200
MIME-Version: 1.0
In-Reply-To: <48da970c-8400-346b-6ade-543e9f314197@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hk30kO84cWlVvrvORIqVHHW3p7bF5sA2p"
Subject: Re: [Qemu-devel] [PATCH 25/25] block: release persistent bitmaps on
 inactivate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hk30kO84cWlVvrvORIqVHHW3p7bF5sA2p
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <fd318432-5da7-6554-91a2-38deb78adcf1@redhat.com>
Subject: Re: [PATCH 25/25] block: release persistent bitmaps on inactivate
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
 <20170503122539.282182-26-vsementsov@virtuozzo.com>
 <2329cfc4-d5b3-9fe2-668d-fd6ba1f5d316@redhat.com>
 <48da970c-8400-346b-6ade-543e9f314197@virtuozzo.com>
In-Reply-To: <48da970c-8400-346b-6ade-543e9f314197@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-30 08:30, Vladimir Sementsov-Ogievskiy wrote:
> 29.05.2017 20:54, Max Reitz wrote:
>> On 2017-05-03 14:25, Vladimir Sementsov-Ogievskiy wrote:
>>> We should release them here to reload on invalidate cache.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block.c                      |  4 ++++
>>>   block/dirty-bitmap.c         | 29 +++++++++++++++++++++++------
>>>   include/block/dirty-bitmap.h |  1 +
>>>   3 files changed, 28 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/block.c b/block.c
>>> index 795d36bb64..14896c65fa 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -4001,6 +4001,10 @@ static int
>>> bdrv_inactivate_recurse(BlockDriverState *bs,
>>>       if (setting_flag) {
>>>           bs->open_flags |=3D BDRV_O_INACTIVE;
>>>       }
>>> +
>>> +    /* At this point persistent bitmaps should be stored by format
>>> driver */
>> s/by format driver/by the format driver/
>>
>>> +    bdrv_release_persistent_dirty_bitmaps(bs);
>> Also, as far as I can see, this doesn't store the bitmaps but just
>> releases them (without storing them). I'm not sure whether that is
>> right, but it definitely contradicts the comment above.
>=20
> I mean they should be _already_ stored.. They actually are stored in=20
> qcow2_inactivate.

Ah, right, that makes more sense.

However, to be more clear the comment should then read "By this point"
instead of "At this point"; maybe even "By this point the persistent
bitmaps should have been stored by the format driver already", or a
totally different "The format driver's bdrv_inactivate() implementation
should have stored all persistent bitmaps".

Max


--hk30kO84cWlVvrvORIqVHHW3p7bF5sA2p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLscOEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQI4D
CACdHY8LrTKbGtIkqKn5aKrzh8VNa/Iqrnnk+2IMHDI6Pa7omcHKzsks12Y2gVVQ
M/HzbsdKFUIoOmswqXWC68S9QAlNCgZqO4ukLixpqnlRerI4ynPGccHl+Npt6DCY
uYVn5LuLdtIkoTS7SVLvFpHVmMwlx/jUeesTd2pymGsHDb+SXBrai0llLNlvUIjQ
pmFQprh43jUp9EB4kD1M+7bSQwjr4ItbBhL3PsArCXGaejAg+aGMpoLSSCbYfChb
VSsyN1C/vFiDUKOJqUwpxSAtWOvy0AUjfSTsmQ9nbRXp4z7llmwp3UTIR/PDj8KD
/dynySp97QNIi7wH7RrVmemO
=swiS
-----END PGP SIGNATURE-----

--hk30kO84cWlVvrvORIqVHHW3p7bF5sA2p--

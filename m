Received: from eggs.gnu.org ([2001:4830:134:3::10]:47113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ14j-0000lr-Jz
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:00:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ14i-0000cq-NI
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:00:17 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-24-vsementsov@virtuozzo.com>
	<6ff8e50e-c6d8-d3b6-f900-3700bbe30dee@redhat.com>
	<cceeb174-5fae-9012-a430-209d59a0bac7@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cec0227c-77b3-ad02-d245-ca852b0981d9@redhat.com>
Date: Wed, 1 Feb 2017 21:00:06 +0100
MIME-Version: 1.0
In-Reply-To: <cceeb174-5fae-9012-a430-209d59a0bac7@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uiE01K8DhdIGvHLutmOB3emsmBiLJndh1"
Subject: Re: [Qemu-devel] [PATCH 23/24] qcow2: add
 .bdrv_remove_persistent_dirty_bitmap
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
--uiE01K8DhdIGvHLutmOB3emsmBiLJndh1
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <cec0227c-77b3-ad02-d245-ca852b0981d9@redhat.com>
Subject: Re: [PATCH 23/24] qcow2: add .bdrv_remove_persistent_dirty_bitmap
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
 <20170123121036.4823-24-vsementsov@virtuozzo.com>
 <6ff8e50e-c6d8-d3b6-f900-3700bbe30dee@redhat.com>
 <cceeb174-5fae-9012-a430-209d59a0bac7@virtuozzo.com>
In-Reply-To: <cceeb174-5fae-9012-a430-209d59a0bac7@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 01.02.2017 14:57, Vladimir Sementsov-Ogievskiy wrote:
> 01.02.2017 02:20, Max Reitz wrote:
>> On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
>>> Realize .bdrv_remove_persistent_dirty_bitmap interface.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block/qcow2-bitmap.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>>   block/qcow2.c        |  1 +
>>>   block/qcow2.h        |  3 +++
>>>   3 files changed, 44 insertions(+)
>>>
>>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>>> index 2687a3acd5..be026fc80e 100644
>>> --- a/block/qcow2-bitmap.c
>>> +++ b/block/qcow2-bitmap.c
>>> @@ -1064,6 +1064,46 @@ static Qcow2Bitmap
>>> *find_bitmap_by_name(Qcow2BitmapList *bm_list,
>>>       return NULL;
>>>   }
>>>   +void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>> +                                          const char *name,
>>> +                                          Error **errp)
>>> +{
>>> +    int ret;
>>> +    BDRVQcow2State *s =3D bs->opaque;
>>> +    Qcow2Bitmap *bm;
>>> +    Qcow2BitmapList *bm_list;
>>> +
>>> +    if (s->nb_bitmaps =3D=3D 0) {
>>> +        /* No bitmaps - nothing to do */
>> Shouldn't it be an error? I.e. "bitmap not found"?
>>
>>> +        return;
>>> +    }
>>> +
>>> +    bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
>>> +                               s->bitmap_directory_size, errp);
>>> +    if (bm_list =3D=3D NULL) {
>>> +        return;
>>> +    }
>>> +
>>> +    bm =3D find_bitmap_by_name(bm_list, name);
>>> +    if (bm =3D=3D NULL) {
>>> +        goto fail;
>> What about setting errp? Or do you not consider this an error?
>>
>> I think it should be an error.
>=20
> Hmm. The following scenery should not be an error:
> 1. qmp create dirty bitmap with persistent =3D true (bitmap not exists =
and
> not created  in the storage, it will be saved only on storage close)
> 2. qmp remove dirty bitmap. persistent =3D true, so we will try to remo=
ve
> it from storage..

That's a good point.

> So, I see following variants:
> 1. as is, just add comment "remove if exists"
> 2. add return value to this function, return ENOENT if bitmap not found=

> and ignore this ENOENT in qmp_remove_bitmap
> 3. add additional bool field 'exist_in_storage' to BdrvDirtyBitmap.

1 sounds the best to me. I don't think there is a reason why a bitmap
may not be found other than the scenario you've described.

It would be good if the comment included that explanation as for why
it's not an error.

Max


--uiE01K8DhdIGvHLutmOB3emsmBiLJndh1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliSPkYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A7iIH/04SKfDfLO/LvIgHwUNh8xGf6uV+YctT
AaiS5YthuExJCkADp2ORznPXtVMuUu6oXmnQVa4rwi/qGiHF+KzlN8Wn23sxtfAd
s/96wWjeQfLYKWKEnra2j+PZfUupheWOSWf2OE7cnLy+5j+uIE3qqJKohjgDefyD
fk/4aJV21QPYa92/sR4xDwI3P2+ywWgK4saKNZFZrUpI7kVhQLaDEnUyPaUxlcxf
RWog/jSoEqcvMmuUUB6LLdr01UZmPtI6u71Hj2afx8bBekchJ8LdIprDbLylPu6O
Zwf/Lytq5XbN6dytP1ONtxIXN+GPdYrsg3bO8IuCwUz7v5TSUay803U=
=Morc
-----END PGP SIGNATURE-----

--uiE01K8DhdIGvHLutmOB3emsmBiLJndh1--

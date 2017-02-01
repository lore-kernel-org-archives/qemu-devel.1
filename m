Received: from eggs.gnu.org ([2001:4830:134:3::10]:47487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ15A-00013S-UC
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:00:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ159-0000oC-Ke
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:00:44 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-24-vsementsov@virtuozzo.com>
	<6ff8e50e-c6d8-d3b6-f900-3700bbe30dee@redhat.com>
	<cceeb174-5fae-9012-a430-209d59a0bac7@virtuozzo.com>
	<b1d67ded-214f-89b1-7a11-1a96942b9b0b@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bd49d081-52f8-ea0b-04b6-ee728458647e@redhat.com>
Date: Wed, 1 Feb 2017 21:00:32 +0100
MIME-Version: 1.0
In-Reply-To: <b1d67ded-214f-89b1-7a11-1a96942b9b0b@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iNEws9M2jReONT0V3whPHGRTuqVUV6Dvu"
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
--iNEws9M2jReONT0V3whPHGRTuqVUV6Dvu
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <bd49d081-52f8-ea0b-04b6-ee728458647e@redhat.com>
Subject: Re: [PATCH 23/24] qcow2: add .bdrv_remove_persistent_dirty_bitmap
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
 <20170123121036.4823-24-vsementsov@virtuozzo.com>
 <6ff8e50e-c6d8-d3b6-f900-3700bbe30dee@redhat.com>
 <cceeb174-5fae-9012-a430-209d59a0bac7@virtuozzo.com>
 <b1d67ded-214f-89b1-7a11-1a96942b9b0b@virtuozzo.com>
In-Reply-To: <b1d67ded-214f-89b1-7a11-1a96942b9b0b@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 01.02.2017 15:23, Vladimir Sementsov-Ogievskiy wrote:
> 01.02.2017 16:57, Vladimir Sementsov-Ogievskiy wrote:
>> 01.02.2017 02:20, Max Reitz wrote:
>>> On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
>>>> Realize .bdrv_remove_persistent_dirty_bitmap interface.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>> ---
>>>>   block/qcow2-bitmap.c | 40 ++++++++++++++++++++++++++++++++++++++++=

>>>>   block/qcow2.c        |  1 +
>>>>   block/qcow2.h        |  3 +++
>>>>   3 files changed, 44 insertions(+)
>>>>
>>>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>>>> index 2687a3acd5..be026fc80e 100644
>>>> --- a/block/qcow2-bitmap.c
>>>> +++ b/block/qcow2-bitmap.c
>>>> @@ -1064,6 +1064,46 @@ static Qcow2Bitmap
>>>> *find_bitmap_by_name(Qcow2BitmapList *bm_list,
>>>>       return NULL;
>>>>   }
>>>>   +void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>>> +                                          const char *name,
>>>> +                                          Error **errp)
>>>> +{
>>>> +    int ret;
>>>> +    BDRVQcow2State *s =3D bs->opaque;
>>>> +    Qcow2Bitmap *bm;
>>>> +    Qcow2BitmapList *bm_list;
>>>> +
>>>> +    if (s->nb_bitmaps =3D=3D 0) {
>>>> +        /* No bitmaps - nothing to do */
>>> Shouldn't it be an error? I.e. "bitmap not found"?
>>>
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
>>>> +                               s->bitmap_directory_size, errp);
>>>> +    if (bm_list =3D=3D NULL) {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    bm =3D find_bitmap_by_name(bm_list, name);
>>>> +    if (bm =3D=3D NULL) {
>>>> +        goto fail;
>>> What about setting errp? Or do you not consider this an error?
>>>
>>> I think it should be an error.
>>
>> Hmm. The following scenery should not be an error:
>> 1. qmp create dirty bitmap with persistent =3D true (bitmap not exists=

>> and not created  in the storage, it will be saved only on storage clos=
e)
>> 2. qmp remove dirty bitmap. persistent =3D true, so we will try to
>> remove it from storage..
>>
>> So, I see following variants:
>> 1. as is, just add comment "remove if exists"
>> 2. add return value to this function, return ENOENT if bitmap not
>> found and ignore this ENOENT in qmp_remove_bitmap
>> 3. add additional bool field 'exist_in_storage' to BdrvDirtyBitmap.
>=20
> Also, I can call remove_persistent...() from
> bdrv_dirty_bitmap_set_persistance( ..., false), and use this function i=
n
> qmp block-remove-dirty-bitmap

Right, that would make sense.

Max


--iNEws9M2jReONT0V3whPHGRTuqVUV6Dvu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliSPmASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9APLAH+wUKZHzSutvBK+HdkDAS8XebprZ7dji9
+mWd0SaU7/GSoaTgH4/JxN6jtCqVdJRuoFtn/T5ah4LI4UcbzNnYiZSnQjRlabln
g21Ld2EAEcq5CCFYtzG05FJqVP8Z2CkoBGwk9ifHcbySq1+KrtWeAuhTXo1s2+h2
tzYVkinnD45qJgckFzeqaCwFbsV1PFSoGNvcabUnD2mhOUHt7Oh6E3t2BoVwQSVV
0MMSVJ04gu+p+KllQfNYa9kln6AJLQ1J8xMElvsx+/mRnmeW7pIi7HFoc7P+7//6
ngY8D9CwJ8gAko0ylP3CU/QdHv5rDMwN3IYNYYuI6tZIeK9Z73e60dI=
=h14d
-----END PGP SIGNATURE-----

--iNEws9M2jReONT0V3whPHGRTuqVUV6Dvu--

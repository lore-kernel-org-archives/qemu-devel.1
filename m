Received: from eggs.gnu.org ([2001:4830:134:3::10]:57350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZj7Y-0000q0-MJ
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 14:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZj7X-0008F9-SQ
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 14:02:08 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-24-vsementsov@virtuozzo.com>
	<6ff8e50e-c6d8-d3b6-f900-3700bbe30dee@redhat.com>
	<05da5132-8667-156d-cd49-e7cea504bcd0@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <58f7e746-a55c-a133-a31b-b713190e9e25@redhat.com>
Date: Fri, 3 Feb 2017 20:01:56 +0100
MIME-Version: 1.0
In-Reply-To: <05da5132-8667-156d-cd49-e7cea504bcd0@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TgHTc2XmELu6NSAvPaRGRNrl7rd8oUnW1"
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
--TgHTc2XmELu6NSAvPaRGRNrl7rd8oUnW1
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <58f7e746-a55c-a133-a31b-b713190e9e25@redhat.com>
Subject: Re: [PATCH 23/24] qcow2: add .bdrv_remove_persistent_dirty_bitmap
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
 <20170123121036.4823-24-vsementsov@virtuozzo.com>
 <6ff8e50e-c6d8-d3b6-f900-3700bbe30dee@redhat.com>
 <05da5132-8667-156d-cd49-e7cea504bcd0@virtuozzo.com>
In-Reply-To: <05da5132-8667-156d-cd49-e7cea504bcd0@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 02.02.2017 11:41, Vladimir Sementsov-Ogievskiy wrote:
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
>>
>>> +    }
>>> +
>>> +    QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
>> bm->name is leaked here.
>=20
> No, bitmap_free(bm) below will free it.

Oops, right. Well then:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--TgHTc2XmELu6NSAvPaRGRNrl7rd8oUnW1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliU06QSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A4mIH/0Cz0Fl6LGQN2L+ZnM1lNGrb6Gl65TOF
ceLBlVx5cOJeiuuAGi5a3Zz9EaGdSw6/M2Yw8bMj3s9EuXd2HAxRtR4GH5GWzISz
OpGZmpP/i9V6cCEi1Sb4e11GgsQLKwThR45VBBvqcHvbhj85XccZIFTUfw59xTpk
86iuOGvIx7gX0nFE+sQBAJBMe8vMaQhu7S5BmkipRi9msqEmUYDJAdTWd1xwDPCY
CkufbsSVqX+zVzoKXSV8hVnuYmLITcsrSHwbvA3I6WOTDiSMbTW5pYw6R5b80Kwu
ZTpLYz3U9Sp3FN/AW26/0FowPJf2rukFt0juDfK7/azNbBJYPhluGXI=
=+Upl
-----END PGP SIGNATURE-----

--TgHTc2XmELu6NSAvPaRGRNrl7rd8oUnW1--

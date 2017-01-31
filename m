Received: from eggs.gnu.org ([2001:4830:134:3::10]:56002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYhMh-0008MR-Ph
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 17:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYhMh-0002zv-2C
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 17:57:31 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-10-vsementsov@virtuozzo.com>
	<1d513ca9-a005-4870-7819-981a121e1939@redhat.com>
	<1a45d58a-6ad9-3fa8-bac7-8b519dcaa6a3@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a285e416-d9e7-2420-5e1a-af714ba7fd1c@redhat.com>
Date: Tue, 31 Jan 2017 23:57:18 +0100
MIME-Version: 1.0
In-Reply-To: <1a45d58a-6ad9-3fa8-bac7-8b519dcaa6a3@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="68mTHdmBxHqM3w5FjoHmmdAWoPGPldBXr"
Subject: Re: [Qemu-devel] [PATCH 09/24] qcow2: add
 .bdrv_load_autoloading_dirty_bitmaps
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
--68mTHdmBxHqM3w5FjoHmmdAWoPGPldBXr
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <a285e416-d9e7-2420-5e1a-af714ba7fd1c@redhat.com>
Subject: Re: [PATCH 09/24] qcow2: add .bdrv_load_autoloading_dirty_bitmaps
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
 <20170123121036.4823-10-vsementsov@virtuozzo.com>
 <1d513ca9-a005-4870-7819-981a121e1939@redhat.com>
 <1a45d58a-6ad9-3fa8-bac7-8b519dcaa6a3@virtuozzo.com>
In-Reply-To: <1a45d58a-6ad9-3fa8-bac7-8b519dcaa6a3@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 31.01.2017 16:11, Vladimir Sementsov-Ogievskiy wrote:
> 29.01.2017 01:20, Max Reitz wrote:
>> On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
>>> Auto loading bitmaps are bitmaps in Qcow2, with the AUTO flag set. Th=
ey
>>> are loaded when the image is opened and become BdrvDirtyBitmaps for t=
he
>>> corresponding drive.
>>>
>>> Extra data in bitmaps is not supported for now.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>  block/Makefile.objs  |   2 +-
>>>  block/qcow2-bitmap.c | 712 +++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>>  block/qcow2.c        |   2 +
>>>  block/qcow2.h        |   3 +
>>>  4 files changed, 718 insertions(+), 1 deletion(-)
>>>  create mode 100644 block/qcow2-bitmap.c
>> [...]
>>
>>> new file mode 100644
>>> index 0000000000..758622dcfc
>>> --- /dev/null
>>> +++ b/block/qcow2-bitmap.c
>> [...]
>>
>>> +
>>> +/*
>>> + * Bitmap List end
>>> + */
>>> +
>>> +static int update_ext_header_and_dir_in_place(BlockDriverState *bs,
>>> +                                              Qcow2BitmapList *bm_li=
st)
>>> +{
>>> +    BDRVQcow2State *s =3D bs->opaque;
>>> +    int ret;
>>> +
>>> +    if (!(s->autoclear_features & QCOW2_AUTOCLEAR_BITMAPS) ||
>>> +        bm_list =3D=3D NULL || QSIMPLEQ_EMPTY(bm_list) ||
>>> +        bitmap_list_count(bm_list) !=3D s->nb_bitmaps)
>>> +    {
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    s->autoclear_features &=3D ~(uint64_t)QCOW2_AUTOCLEAR_BITMAPS;
>>> +    ret =3D update_header_sync(bs);
>> This function is defined only in patch 13, until then the code won't
>> compile; the definition should be moved into this patch.
>>
>> Max
>>
>=20
> Stupid omission, sorry =3D(. I'll move it and add your r-b, ok?

Yep, that's fine.

Max


--68mTHdmBxHqM3w5FjoHmmdAWoPGPldBXr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliRFk4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ai9sH/3wh7/VwhaJP/2KsEmQRG9yiKnOdiQ77
KCZxj/8hKzaRfKm6cG5iz++MEp3r/mFByLxejoYbOkEjVXBxqfbOaRiEfxlhyuna
rzNZ+wqoXFCwhzl7YTAon1PqWYVTA8g7D5FSllxavqA/brUYK70d/CHLKOhpVwDx
8Tjfjuc+uGNDI6HEtZrre4J29zXL3+ZPj+OBbhMT1vvp93BbyYKRrdwHHP+5Tpu9
4t5YIP2H4rO6858HQ59pKh7oLlz/r6S0ULVu1GsEtfist0I4exHA1+0cvEbBGYEl
IJZKjsyY+PHi6rpCa/J07tdTjxvVNbi1L3hDQWgmR53YK2WGYrxzeLw=
=GpZC
-----END PGP SIGNATURE-----

--68mTHdmBxHqM3w5FjoHmmdAWoPGPldBXr--

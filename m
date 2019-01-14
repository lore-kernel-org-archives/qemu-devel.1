Received: from eggs.gnu.org ([209.51.188.92]:51259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gj2zo-0001G5-D1
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:13:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gj2zm-0003IU-HC
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:13:44 -0500
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-2-vsementsov@virtuozzo.com>
	<cc033e38-2790-6dcd-6401-191ce9bf8d81@redhat.com>
	<5accce39-2c94-ca4e-5afc-2fec242836a8@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <29032c00-29cf-a8a4-d18e-fcaa7651636a@redhat.com>
Date: Mon, 14 Jan 2019 15:13:24 +0100
MIME-Version: 1.0
In-Reply-To: <5accce39-2c94-ca4e-5afc-2fec242836a8@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ki8bOe5pxdPMPlowcdgYXJqUaBoW8eBNm"
Subject: Re: [Qemu-devel] [PATCH v5 01/11] block/backup: simplify
 backup_incremental_init_copy_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "eblake@redhat.com" <eblake@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ki8bOe5pxdPMPlowcdgYXJqUaBoW8eBNm
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "eblake@redhat.com" <eblake@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>
Message-ID: <29032c00-29cf-a8a4-d18e-fcaa7651636a@redhat.com>
Subject: Re: [PATCH v5 01/11] block/backup: simplify
 backup_incremental_init_copy_bitmap
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-2-vsementsov@virtuozzo.com>
 <cc033e38-2790-6dcd-6401-191ce9bf8d81@redhat.com>
 <5accce39-2c94-ca4e-5afc-2fec242836a8@virtuozzo.com>
In-Reply-To: <5accce39-2c94-ca4e-5afc-2fec242836a8@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.01.19 15:01, Vladimir Sementsov-Ogievskiy wrote:
> 14.01.2019 16:10, Max Reitz wrote:
>> On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:
>>> Simplify backup_incremental_init_copy_bitmap using the function
>>> bdrv_dirty_bitmap_next_dirty_area.
>>>
>>> Note: move to job->len instead of bitmap size: it should not matter b=
ut
>>> less code.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block/backup.c | 40 ++++++++++++----------------------------
>>>   1 file changed, 12 insertions(+), 28 deletions(-)
>>
>> Overall: What is this function even supposed to do?  To me, it looks
>> like it marks all areas in job->copy_bitmap dirty that are dirty in
>> job->sync_bitmap.
>>
>> If so, wouldn't just replacing this by hbitmap_merge() simplify things=

>> further?
>>
>>> diff --git a/block/backup.c b/block/backup.c
>>> index 435414e964..fbe7ce19e1 100644
>>> --- a/block/backup.c
>>> +++ b/block/backup.c
>>> @@ -406,43 +406,27 @@ static int coroutine_fn backup_run_incremental(=
BackupBlockJob *job)
>>
>> [...]
>>
>>> +    while (bdrv_dirty_bitmap_next_dirty_area(job->sync_bitmap,
>>> +                                             &offset, &bytes))
>>> +    {
>>> +        uint64_t cluster =3D offset / job->cluster_size;
>>> +        uint64_t last_cluster =3D (offset + bytes) / job->cluster_si=
ze;
>>>  =20
>>> -        next_cluster =3D DIV_ROUND_UP(offset, job->cluster_size);
>>> -        hbitmap_set(job->copy_bitmap, cluster, next_cluster - cluste=
r);
>>> -        if (next_cluster >=3D end) {
>>> +        hbitmap_set(job->copy_bitmap, cluster, last_cluster - cluste=
r + 1);
>>
>> Why the +1?  Shouldn't the division for last_cluster round up instead?=

>>
>>> +
>>> +        offset =3D (last_cluster + 1) * job->cluster_size;
>>
>> Same here.
>=20
> last cluster is not "end", but it's last dirty cluster. so number of di=
rty clusters is last_cluster - cluster + 1, and next offset is calculated=
 through +1 too.
>=20
> If I round up division result, I'll get last for most cases, but "end" =
(next after the last), for the case when offset % job->cluster_size =3D=3D=
 0, so, how to use it?

Doesn't bdrv_dirty_bitmap_next_dirty_area() return a range [offset,
offset + bytes), i.e. where "offset + bytes" is the first clean offset?

Max


--Ki8bOe5pxdPMPlowcdgYXJqUaBoW8eBNm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw8mQQACgkQ9AfbAGHV
z0C4Fwf+LaPZVVLE67I9U5+T0XJqmG4u2QjHQ2NxPR5etgaVHiSGtuYg3RfQGgqo
rkbpz3bCeXAq5hd5Y+UZ7oFoSviIMBpgDYsU3QQIuzG0f6O1iPzx8AHqhkIIoAXk
zfAchVnrc/EVGgdFtTyuKG5did585PALxNVCMOv6ByvyYDHF0nMCcZ+WYPKmkgwu
QWH6xqm99O1ix6Nd7EXYEY+FwXliF9rAcSOXVFSwuR4nkeWJzcmgg979IRqYBbrF
I2UbtZGiEEqAr/jy/a9GepSNqYT6Omlg/xgczn7GHSIHKerV7Ttp7ZHs/9inSJ02
utECbLJ95LqL6PbWN1lsNDhVa0D/pg==
=+NHG
-----END PGP SIGNATURE-----

--Ki8bOe5pxdPMPlowcdgYXJqUaBoW8eBNm--

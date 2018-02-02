Received: from eggs.gnu.org ([2001:4830:134:3::10]:37993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ehcYb-0008QB-On
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:43:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ehcYa-0001pp-Li
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:43:13 -0500
References: <20171130164750.47320-1-vsementsov@virtuozzo.com>
	<20171130164750.47320-2-vsementsov@virtuozzo.com>
	<8073fbad-e209-f7c7-d788-4f9eed529b56@redhat.com>
	<8e702a93-0447-6a0d-ddb1-1b447962669a@virtuozzo.com>
	<3fbf534f-fcbc-5cf5-4690-b0142a54a760@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a32490e7-9e21-1b53-87b1-d5d503103765@virtuozzo.com>
Date: Fri, 2 Feb 2018 16:48:22 +0300
MIME-Version: 1.0
In-Reply-To: <3fbf534f-fcbc-5cf5-4690-b0142a54a760@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/2] qcow2: add overlap check for bitmap
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com

02.02.2018 16:00, Max Reitz wrote:
> On 2018-02-02 13:07, Vladimir Sementsov-Ogievskiy wrote:
>> 29.01.2018 18:34, Max Reitz wrote:
>>> On 2017-11-30 17:47, Vladimir Sementsov-Ogievskiy wrote:
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>  =C2=A0 block/qcow2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 7 +++++--
>>>>  =C2=A0 block/qcow2-refcount.c | 12 ++++++++++++
>>>>  =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 6 ++++++
>>>>  =C2=A0 3 files changed, 23 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/block/qcow2.h b/block/qcow2.h
>>>> index 6f0ff15dd0..8f226a3609 100644
>>>> --- a/block/qcow2.h
>>>> +++ b/block/qcow2.h
>>>> @@ -98,6 +98,7 @@
>>>>  =C2=A0 #define QCOW2_OPT_OVERLAP_SNAPSHOT_TABLE
>>>> "overlap-check.snapshot-table"
>>>>  =C2=A0 #define QCOW2_OPT_OVERLAP_INACTIVE_L1 "overlap-check.inactive-=
l1"
>>>>  =C2=A0 #define QCOW2_OPT_OVERLAP_INACTIVE_L2 "overlap-check.inactive-=
l2"
>>>> +#define QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY
>>>> "overlap-check.bitmap-directory"
>>>>  =C2=A0 #define QCOW2_OPT_CACHE_SIZE "cache-size"
>>>>  =C2=A0 #define QCOW2_OPT_L2_CACHE_SIZE "l2-cache-size"
>>>>  =C2=A0 #define QCOW2_OPT_REFCOUNT_CACHE_SIZE "refcount-cache-size"
>>>> @@ -406,8 +407,9 @@ typedef enum QCow2MetadataOverlap {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_OL_SNAPSHOT_TABLE_BITNR =3D 5,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_OL_INACTIVE_L1_BITNR=C2=A0=C2=A0=
=C2=A0 =3D 6,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_OL_INACTIVE_L2_BITNR=C2=A0=C2=A0=
=C2=A0 =3D 7,
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_BITMAP_DIRECTORY_BITNR =3D 8,
>>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 QCOW2_OL_MAX_BITNR=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 8,
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_MAX_BITNR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 9,
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_OL_NONE=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_OL_MAIN_HEADER=C2=A0=C2=A0=C2=A0=
 =3D (1 << QCOW2_OL_MAIN_HEADER_BITNR),
>>>> @@ -420,12 +422,13 @@ typedef enum QCow2MetadataOverlap {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* NOTE: Checking overlaps with inacti=
ve L2 tables will result
>>>> in bdrv
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * reads. */
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_OL_INACTIVE_L2=C2=A0=C2=A0=C2=A0=
 =3D (1 << QCOW2_OL_INACTIVE_L2_BITNR),
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_BITMAP_DIRECTORY =3D (1 << QCOW2_OL_BITMA=
P_DIRECTORY_BITNR),
>>>>  =C2=A0 } QCow2MetadataOverlap;
>>>>  =C2=A0 =C2=A0 /* Perform all overlap checks which can be done in cons=
tant time */
>>>>  =C2=A0 #define QCOW2_OL_CONSTANT \
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (QCOW2_OL_MAIN_HEADER | QCOW2_OL_ACTIV=
E_L1 |
>>>> QCOW2_OL_REFCOUNT_TABLE | \
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_OL_SNAPSHOT_TABLE)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_OL_SNAPSHOT_TABLE | QCOW2_OL_BITMAP_DI=
RECTORY)
>>>>  =C2=A0 =C2=A0 /* Perform all overlap checks which don't require disk =
access */
>>>>  =C2=A0 #define QCOW2_OL_CACHED \
>>>> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
>>>> index 3de1ab51ba..a7a2703f26 100644
>>>> --- a/block/qcow2-refcount.c
>>>> +++ b/block/qcow2-refcount.c
>>>> @@ -2585,6 +2585,18 @@ int
>>>> qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t
>>>> offset,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>  =C2=A0 +=C2=A0=C2=A0=C2=A0 if ((chk & QCOW2_OL_BITMAP_DIRECTORY) &&
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (s->autoclear_features & Q=
COW2_AUTOCLEAR_BITMAPS))
>>>> +=C2=A0=C2=A0=C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* update_ext_header_and_d=
ir_in_place firstly drop autoclear
>>>> flag,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * so it will not fai=
l */
>>> That's really not an argument.=C2=A0 bitmap_list_store() has to pass
>>> QCOW2_OL_BITMAP_DIRECTORY to @ign anyway.=C2=A0 (Because there is no re=
ason
>>> not to.)
>> in_place is a reason. When we store directory in_place, it definitely
>> overlaps with current directory.
> Well, then you just pass QCOW2_OL_BITMAP_DIRECTORY to @ign, which is
> what that argument is for? :-)

hmm. but actually, I should not, because of zeroed autoclear flag. So,
do you think, it is better to pass it, anyway?

>
> Max
>
>> But this is done with cleared autoclear flag (to make it safe), so we
>> will skip this check and will not
>> fail.


--=20
Best regards,
Vladimir

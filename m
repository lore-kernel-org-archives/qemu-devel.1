Received: from eggs.gnu.org ([2001:4830:134:3::10]:47224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fPt9c-0007rf-4a
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fPt9a-0001ok-Op
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:20:24 -0400
References: <20180319080705.10310-1-vsementsov@virtuozzo.com>
	<8416e4e1-da91-8631-164f-cca680cb8d20@redhat.com>
	<534fe1b0-b9b3-d4d8-63cb-913f98d607a5@virtuozzo.com>
	<6c2882e3-8f0f-875e-5aa0-ed6ccd356b33@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <dc7182c5-6b9d-6da8-8751-a3eccfc5b2cb@redhat.com>
Date: Mon, 4 Jun 2018 13:20:15 -0400
MIME-Version: 1.0
In-Reply-To: <6c2882e3-8f0f-875e-5aa0-ed6ccd356b33@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qcow2: add overlap check for bitmap
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com



On 06/04/2018 12:11 PM, Vladimir Sementsov-Ogievskiy wrote:
> 20.04.2018 15:12, Vladimir Sementsov-Ogievskiy wrote:
>> 19.04.2018 23:57, John Snow wrote:
>>>
>>> On 03/19/2018 04:07 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>> ---
>>>>
>>>> If it appropriate for 2.12, let's push it. If not - then for 2.13.
>>>>
>>> I wonder if I can make the case that this should be in 2.12.1; arguab=
ly
>>> it is important to prevent corruption no matter how unlikely it is to
>>> ever happen.
>>>
>>> Moving it into stable increases the likelihood it shows up in
>>> downstreams, so maybe let's see what we can get away with.
>>>
>>>> v2: - squash 02 (indentation fix) to 01
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - drop comment from qcow2_check_metadata_ov=
erlap()
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - set @ign to QCOW2_OL_BITMAP_DIRECTORY for=
 in-place case in
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap_list_store. I don't thin=
k non-inplace case should be
>>>> changed,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as it don't touch active bitmap=
 directory.
>>>>
>>>> =C2=A0 block/qcow2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 45
>>>> ++++++++++++++++++++++++---------------------
>>>> =C2=A0 block/qcow2-bitmap.c=C2=A0=C2=A0 |=C2=A0 7 ++++++-
>>>> =C2=A0 block/qcow2-refcount.c | 10 ++++++++++
>>>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 22 ++++++++++++++--------
>>>> =C2=A0 4 files changed, 54 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/block/qcow2.h b/block/qcow2.h
>>>> index 6f0ff15dd0..896ad08e5b 100644
>>>> --- a/block/qcow2.h
>>>> +++ b/block/qcow2.h
>>>> @@ -98,6 +98,7 @@
>>>> =C2=A0 #define QCOW2_OPT_OVERLAP_SNAPSHOT_TABLE
>>>> "overlap-check.snapshot-table"
>>>> =C2=A0 #define QCOW2_OPT_OVERLAP_INACTIVE_L1 "overlap-check.inactive=
-l1"
>>>> =C2=A0 #define QCOW2_OPT_OVERLAP_INACTIVE_L2 "overlap-check.inactive=
-l2"
>>>> +#define QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY
>>>> "overlap-check.bitmap-directory"
>>>> =C2=A0 #define QCOW2_OPT_CACHE_SIZE "cache-size"
>>>> =C2=A0 #define QCOW2_OPT_L2_CACHE_SIZE "l2-cache-size"
>>>> =C2=A0 #define QCOW2_OPT_REFCOUNT_CACHE_SIZE "refcount-cache-size"
>>>> @@ -398,34 +399,36 @@ typedef enum QCow2ClusterType {
>>>> =C2=A0 } QCow2ClusterType;
>>>> =C2=A0 =C2=A0 typedef enum QCow2MetadataOverlap {
>>>> -=C2=A0=C2=A0=C2=A0 QCOW2_OL_MAIN_HEADER_BITNR=C2=A0=C2=A0=C2=A0 =3D=
 0,
>>>> -=C2=A0=C2=A0=C2=A0 QCOW2_OL_ACTIVE_L1_BITNR=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D 1,
>>>> -=C2=A0=C2=A0=C2=A0 QCOW2_OL_ACTIVE_L2_BITNR=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D 2,
>>>> -=C2=A0=C2=A0=C2=A0 QCOW2_OL_REFCOUNT_TABLE_BITNR =3D 3,
>>>> -=C2=A0=C2=A0=C2=A0 QCOW2_OL_REFCOUNT_BLOCK_BITNR =3D 4,
>>>> -=C2=A0=C2=A0=C2=A0 QCOW2_OL_SNAPSHOT_TABLE_BITNR =3D 5,
>>>> -=C2=A0=C2=A0=C2=A0 QCOW2_OL_INACTIVE_L1_BITNR=C2=A0=C2=A0=C2=A0 =3D=
 6,
>>>> -=C2=A0=C2=A0=C2=A0 QCOW2_OL_INACTIVE_L2_BITNR=C2=A0=C2=A0=C2=A0 =3D=
 7,
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0 QCOW2_OL_MAX_BITNR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 8,
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0 QCOW2_OL_NONE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0,
>>>> -=C2=A0=C2=A0=C2=A0 QCOW2_OL_MAIN_HEADER=C2=A0=C2=A0=C2=A0 =3D (1 <<=
 QCOW2_OL_MAIN_HEADER_BITNR),
>>>> -=C2=A0=C2=A0=C2=A0 QCOW2_OL_ACTIVE_L1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D (1 << QCOW2_OL_ACTIVE_L1_BITNR),
>>>> -=C2=A0=C2=A0=C2=A0 QCOW2_OL_ACTIVE_L2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D (1 << QCOW2_OL_ACTIVE_L2_BITNR),
>>>> -=C2=A0=C2=A0=C2=A0 QCOW2_OL_REFCOUNT_TABLE =3D (1 << QCOW2_OL_REFCO=
UNT_TABLE_BITNR),
>>>> -=C2=A0=C2=A0=C2=A0 QCOW2_OL_REFCOUNT_BLOCK =3D (1 << QCOW2_OL_REFCO=
UNT_BLOCK_BITNR),
>>>> -=C2=A0=C2=A0=C2=A0 QCOW2_OL_SNAPSHOT_TABLE =3D (1 << QCOW2_OL_SNAPS=
HOT_TABLE_BITNR),
>>>> -=C2=A0=C2=A0=C2=A0 QCOW2_OL_INACTIVE_L1=C2=A0=C2=A0=C2=A0 =3D (1 <<=
 QCOW2_OL_INACTIVE_L1_BITNR),
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_MAIN_HEADER_BITNR=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D 0,
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_ACTIVE_L1_BITNR=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D 1,
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_ACTIVE_L2_BITNR=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D 2,
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_REFCOUNT_TABLE_BITNR=C2=A0=C2=A0 =3D 3,
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_REFCOUNT_BLOCK_BITNR=C2=A0=C2=A0 =3D 4,
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_SNAPSHOT_TABLE_BITNR=C2=A0=C2=A0 =3D 5,
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_INACTIVE_L1_BITNR=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D 6,
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_INACTIVE_L2_BITNR=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D 7,
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_BITMAP_DIRECTORY_BITNR =3D 8,
>>>> +
>>> A bit hard to read due to the formatting, but you've added #8 here, a=
nd
>>>
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_MAX_BITNR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 9,
>>>> +> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_NONE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0,
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_MAIN_HEADER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D (1 << QCOW2_OL_MAIN_HEADER_BITNR),
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_ACTIVE_L1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D (1 << QCOW2_OL_ACTIVE_L1_BITNR),
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_ACTIVE_L2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D (1 << QCOW2_OL_ACTIVE_L2_BITNR),
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_REFCOUNT_TABLE=C2=A0=C2=A0 =3D (1 << QC=
OW2_OL_REFCOUNT_TABLE_BITNR),
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_REFCOUNT_BLOCK=C2=A0=C2=A0 =3D (1 << QC=
OW2_OL_REFCOUNT_BLOCK_BITNR),
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_SNAPSHOT_TABLE=C2=A0=C2=A0 =3D (1 << QC=
OW2_OL_SNAPSHOT_TABLE_BITNR),
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_INACTIVE_L1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D (1 << QCOW2_OL_INACTIVE_L1_BITNR),
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* NOTE: Checking overlaps with inact=
ive L2 tables will result
>>>> in bdrv
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * reads. */
>>>> -=C2=A0=C2=A0=C2=A0 QCOW2_OL_INACTIVE_L2=C2=A0=C2=A0=C2=A0 =3D (1 <<=
 QCOW2_OL_INACTIVE_L2_BITNR),
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_INACTIVE_L2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D (1 << QCOW2_OL_INACTIVE_L2_BITNR),
>>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_BITMAP_DIRECTORY =3D (1 <<
>>>> QCOW2_OL_BITMAP_DIRECTORY_BITNR),
>>> and this one down here.
>>>
>>>> =C2=A0 } QCow2MetadataOverlap;
>>>> =C2=A0 =C2=A0 /* Perform all overlap checks which can be done in con=
stant time */
>>>> =C2=A0 #define QCOW2_OL_CONSTANT \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (QCOW2_OL_MAIN_HEADER | QCOW2_OL_ACTI=
VE_L1 |
>>>> QCOW2_OL_REFCOUNT_TABLE | \
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_OL_SNAPSHOT_TABLE)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_OL_SNAPSHOT_TABLE | QCOW2_OL_BITMAP_=
DIRECTORY)
>>>> =C2=A0 =C2=A0 /* Perform all overlap checks which don't require disk=
 access */
>>>> =C2=A0 #define QCOW2_OL_CACHED \
>>>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>>>> index f45e46cfbd..fb750ba8d3 100644
>>>> --- a/block/qcow2-bitmap.c
>>>> +++ b/block/qcow2-bitmap.c
>>>> @@ -776,7 +776,12 @@ static int bitmap_list_store(BlockDriverState
>>>> *bs, Qcow2BitmapList *bm_list,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 ret =3D qcow2_pre_write_overlap_check(bs,=
 0, dir_offset,
>>>> dir_size);
>>>> +=C2=A0=C2=A0=C2=A0 /* Actually, even in in-place case ignoring
>>>> QCOW2_OL_BITMAP_DIRECTORY is not
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * necessary, because we drop QCOW2_AUTOCLE=
AR_BITMAPS when
>>>> updating bitmap
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * directory in-place (actually, turn-off t=
he extension), which
>>>> is checked
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * in qcow2_check_metadata_overlap() */
>>> I might need you to rephrase this for me.
>>>
>>> I guess we're ignoring QCOW2_OL_BITMAP_DIRECTORY if in_place is true,
>>> but only as an optimization. Why is it not required?
>>
>> because, actually, we don't have any dirty bitmaps extension at the
>> moment when we rewrite bitmap directory in-place (as we drop autoclear
>> bit), so nothing will be checked.
>=20
> Is it clear, do you want to rephrase this somehow?
>=20

Oh, sorry, I didn't wind up having a better suggestion. Thanks for the pi=
ng.

Reviewed-by: John Snow <jsnow@redhat.com>

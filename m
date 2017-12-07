Received: from eggs.gnu.org ([2001:4830:134:3::10]:43260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eMzam-0005Vp-8d
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eMzaj-0004fE-3T
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:04:12 -0500
References: <20171130164750.47320-1-vsementsov@virtuozzo.com>
	<20171130164750.47320-2-vsementsov@virtuozzo.com>
	<2291b175-1d72-1c85-9767-bf8dbaeedef5@redhat.com>
	<2af21d5f-3ad9-3492-03ea-c720929c4e36@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ab7d113e-68b0-f4f4-c94b-42c5bb214d2f@redhat.com>
Date: Thu, 7 Dec 2017 12:03:55 -0500
MIME-Version: 1.0
In-Reply-To: <2af21d5f-3ad9-3492-03ea-c720929c4e36@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] qcow2: add overlap check
 for bitmap directory
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



On 12/07/2017 04:43 AM, Vladimir Sementsov-Ogievskiy wrote:
> 07.12.2017 01:56, John Snow wrote:
>>
>> On 11/30/2017 11:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>> =C2=A0 block/qcow2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 7 +++++--
>>> =C2=A0 block/qcow2-refcount.c | 12 ++++++++++++
>>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 6 ++++++
>>> =C2=A0 3 files changed, 23 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/qcow2.h b/block/qcow2.h
>>> index 6f0ff15dd0..8f226a3609 100644
>>> --- a/block/qcow2.h
>>> +++ b/block/qcow2.h
>>> @@ -98,6 +98,7 @@
>>> =C2=A0 #define QCOW2_OPT_OVERLAP_SNAPSHOT_TABLE
>>> "overlap-check.snapshot-table"
>>> =C2=A0 #define QCOW2_OPT_OVERLAP_INACTIVE_L1 "overlap-check.inactive-=
l1"
>>> =C2=A0 #define QCOW2_OPT_OVERLAP_INACTIVE_L2 "overlap-check.inactive-=
l2"
>>> +#define QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY
>>> "overlap-check.bitmap-directory"
>>> =C2=A0 #define QCOW2_OPT_CACHE_SIZE "cache-size"
>>> =C2=A0 #define QCOW2_OPT_L2_CACHE_SIZE "l2-cache-size"
>>> =C2=A0 #define QCOW2_OPT_REFCOUNT_CACHE_SIZE "refcount-cache-size"
>>> @@ -406,8 +407,9 @@ typedef enum QCow2MetadataOverlap {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_OL_SNAPSHOT_TABLE_BITNR =3D 5,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_OL_INACTIVE_L1_BITNR=C2=A0=C2=A0=
=C2=A0 =3D 6,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_OL_INACTIVE_L2_BITNR=C2=A0=C2=A0=
=C2=A0 =3D 7,
>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_BITMAP_DIRECTORY_BITNR =3D 8,
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 QCOW2_OL_MAX_BITNR=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 8,
>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_MAX_BITNR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 9,
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_OL_NONE=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_OL_MAIN_HEADER=C2=A0=C2=A0=C2=A0=
 =3D (1 << QCOW2_OL_MAIN_HEADER_BITNR),
>>> @@ -420,12 +422,13 @@ typedef enum QCow2MetadataOverlap {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* NOTE: Checking overlaps with inacti=
ve L2 tables will result
>>> in bdrv
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * reads. */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_OL_INACTIVE_L2=C2=A0=C2=A0=C2=A0=
 =3D (1 << QCOW2_OL_INACTIVE_L2_BITNR),
>>> +=C2=A0=C2=A0=C2=A0 QCOW2_OL_BITMAP_DIRECTORY =3D (1 << QCOW2_OL_BITM=
AP_DIRECTORY_BITNR),
>>> =C2=A0 } QCow2MetadataOverlap;
>>> =C2=A0 =C2=A0 /* Perform all overlap checks which can be done in cons=
tant time */
>>> =C2=A0 #define QCOW2_OL_CONSTANT \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (QCOW2_OL_MAIN_HEADER | QCOW2_OL_ACTIV=
E_L1 |
>>> QCOW2_OL_REFCOUNT_TABLE | \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_OL_SNAPSHOT_TABLE)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 QCOW2_OL_SNAPSHOT_TABLE | QCOW2_OL_BITMAP_D=
IRECTORY)
>>> =C2=A0 =C2=A0 /* Perform all overlap checks which don't require disk =
access */
>>> =C2=A0 #define QCOW2_OL_CACHED \
>>> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
>>> index 3de1ab51ba..a7a2703f26 100644
>>> --- a/block/qcow2-refcount.c
>>> +++ b/block/qcow2-refcount.c
>>> @@ -2585,6 +2585,18 @@ int
>>> qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t
>>> offset,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if ((chk & QCOW2_OL_BITMAP_DIRECTORY) &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (s->autoclear_features & =
QCOW2_AUTOCLEAR_BITMAPS))
>>> +=C2=A0=C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* update_ext_header_and_=
dir_in_place firstly drop autoclear
>>> flag,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * so it will not fa=
il */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (overlaps_with(s->bitm=
ap_directory_offset,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 s->bitmap_directory_size))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn QCOW2_OL_BITMAP_DIRECTORY;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>> Isn't the purpose of this function to test if a given offset conflicts
>> with known regions of the file? I don't see you actually utilize the
>> 'offset' parameter here, but maybe I don't understand what you're tryi=
ng
>> to accomplish.
>=20
> #define overlaps_with(ofs, sz) \
> =C2=A0=C2=A0=C2=A0 ranges_overlap(offset, size, ofs, sz)
>=20
> I've just copied one of similar blocks in qcow2_check_metadata_overlap(=
)
>=20

Sigh, I didn't realize that was a macro. I don't really like lowercase
macros, but you didn't add it.

Reviewed-by: John Snow <jsnow@redhat.com>

Carry on...

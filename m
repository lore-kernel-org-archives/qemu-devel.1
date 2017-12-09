Received: from eggs.gnu.org ([2001:4830:134:3::10]:36461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eNf9w-00086j-2R
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 08:27:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eNf9u-00071i-6x
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 08:27:15 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20171207203036.14993-1-eblake@redhat.com>
	<20171207203036.14993-2-eblake@redhat.com>
	<3b932b93-eb2a-8d71-9d0e-8bfbe40b10bf@virtuozzo.com>
Message-ID: <5c6b215f-c8c1-b500-41ff-5b5a769ceef4@virtuozzo.com>
Date: Sat, 9 Dec 2017 16:26:55 +0300
MIME-Version: 1.0
In-Reply-To: <3b932b93-eb2a-8d71-9d0e-8bfbe40b10bf@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v6 01/20] block: Add
 .bdrv_co_block_status() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

09.12.2017 13:15, Vladimir Sementsov-Ogievskiy wrote:
> 07.12.2017 23:30, Eric Blake wrote:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based. Now that the block layer exposes byte-based allocation,
>> it's time to tackle the drivers.=C2=A0 Add a new callback that operates
>> on as small as byte boundaries. Subsequent patches will then update
>> individual drivers, then finally remove .bdrv_co_get_block_status().
>>
>> The new code also passes through the 'want_zero' hint, which will
>> allow subsequent patches to further optimize callers that only care
>> about how much of the image is allocated (want_zero is false),
>> rather than full details about runs of zeroes and which offsets the
>> allocation actually maps to (want_zero is true).=C2=A0 As part of this
>> effort, fix another part of the documentation: the claim in commit
>> 4c41cb4 that BDRV_BLOCK_ALLOCATED is short for 'DATA || ZERO' is a
>> lie at the block layer (see commit e88ae2264), even though it is
>> how the bit is computed from the driver layer.=C2=A0 After all, there
>> are intentionally cases where we return ZERO but not ALLOCATED at
>> the block layer, when we know that a read sees zero because the
>> backing file is too short.=C2=A0 Note that the driver interface is thus
>> slightly different than the public interface with regards to which
>> bits will be set, and what guarantees are provided on input.
>>
>> We also add an assertion that any driver using the new callback will
>> make progress (the only time pnum will be 0 is if the block layer
>> already handled an out-of-bounds request, or if there is an error);
>> the old driver interface did not provide this guarantee, which
>> could lead to some inf-loops in drastic corner-case failures.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v6: drop now-useless rounding of mid-sector end-of-file hole [Kevin],
>> better documentation of 'want_zero' [Kevin]
>> v5: rebase to master, typo fix, document more block layer guarantees
>> v4: rebase to master
>> v3: no change
>> v2: improve alignment handling, ensure all iotests still pass
>> ---
>> =C2=A0 include/block/block.h=C2=A0=C2=A0=C2=A0=C2=A0 | 14 +++++++-------
>> =C2=A0 include/block/block_int.h | 20 +++++++++++++++-----
>> =C2=A0 block/io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 28 +++++++++++++++++++---------
>> =C2=A0 3 files changed, 41 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/block/block.h b/include/block/block.h
>> index c05cac57e5..afc9ece4d6 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>> @@ -128,19 +128,19 @@ typedef struct HDGeometry {
>> =C2=A0=C2=A0 * BDRV_BLOCK_ZERO: offset reads as zero
>> =C2=A0=C2=A0 * BDRV_BLOCK_OFFSET_VALID: an associated offset exists for=
=20
>> accessing raw data
>> =C2=A0=C2=A0 * BDRV_BLOCK_ALLOCATED: the content of the block is determi=
ned by=20
>> this
>> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 layer (shor=
t for DATA || ZERO), set by=20
>> block layer
>> - * BDRV_BLOCK_EOF: the returned pnum covers through end of file for=20
>> this layer
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 layer rathe=
r than any backing, set by block=20
>> layer
>> + * BDRV_BLOCK_EOF: the returned pnum covers through end of file for=20
>> this
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 layer, set by block layer
>> =C2=A0=C2=A0 *
>> =C2=A0=C2=A0 * Internal flag:
>> =C2=A0=C2=A0 * BDRV_BLOCK_RAW: for use by passthrough drivers, such as r=
aw, to=20
>> request
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 that the block layer recompute the =
answer from=20
>> the returned
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDS; must be accompanied by just=20
>> BDRV_BLOCK_OFFSET_VALID.
>> =C2=A0=C2=A0 *
>> - * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62=20
>> (BDRV_BLOCK_OFFSET_MASK) of
>> - * the return value (old interface) or the entire map parameter (new
>> - * interface) represent the offset in the returned BDS that is=20
>> allocated for
>> - * the corresponding raw data.=C2=A0 However, whether that offset actua=
lly
>> - * contains data also depends on BDRV_BLOCK_DATA, as follows:
>> + * If BDRV_BLOCK_OFFSET_VALID is set, the map parameter represents the
>> + * host offset within the returned BDS that is allocated for the
>> + * corresponding raw guest data.=C2=A0 However, whether that offset
>> + * actually contains data also depends on BDRV_BLOCK_DATA, as follows:
>> =C2=A0=C2=A0 *
>> =C2=A0=C2=A0 * DATA ZERO OFFSET_VALID
>> =C2=A0=C2=A0 *=C2=A0 t=C2=A0=C2=A0=C2=A0 t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sectors read as zero, re=
turned file is=20
>> zero at offset
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index a5482775ec..614197f208 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -204,15 +204,25 @@ struct BlockDriver {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Building block for bdrv_block_sta=
tus[_above] and
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_is_allocated[_above].=C2=A0 =
The driver should answer only
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * according to the current layer, and should n=
ot set
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * BDRV_BLOCK_ALLOCATED, but may set BDRV_BLOCK=
_RAW.=C2=A0 See block.h
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * for the meaning of _DATA, _ZERO, and _OFFSET=
_VALID.=C2=A0 The block
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * layer guarantees input aligned to request_al=
ignment, as well as
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * non-NULL pnum and file.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * according to the current layer, and should o=
nly need to set
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * BDRV_BLOCK_DATA, BDRV_BLOCK_ZERO, BDRV_BLOCK=
_OFFSET_VALID,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * and/or BDRV_BLOCK_RAW; if the current layer =
defers to a backing
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * layer, the result should be 0 (and not BDRV_=
BLOCK_ZERO).=C2=A0 See
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * block.h for the overall meaning of the bits.=
=C2=A0 As a hint, the
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * flag want_zero is true if the caller cares m=
ore about precise
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * mappings (favor accurate _OFFSET_VALID/_ZERO=
) or false for
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * overall allocation (favor larger *pnum, perh=
aps by reporting
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * _DATA instead of _ZERO).=C2=A0 The block lay=
er guarantees input
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * clamped to bdrv_getlength() and aligned to r=
equest_alignment,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * as well as non-NULL pnum, map, and file; in =
turn, the driver
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * must return an error or set pnum to an align=
ed non-zero value.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t coroutine_fn=20
>> (*bdrv_co_get_block_status)(BlockDriverState *bs,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t sector_nu=
m, int nb_sectors, int *pnum,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState =
**file);
>> +=C2=A0=C2=A0=C2=A0 int coroutine_fn (*bdrv_co_block_status)(BlockDriver=
State *bs,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool want_zero, int64_t offs=
et, int64_t bytes, int64_t *pnum,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t *map, BlockDriverSta=
te **file);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Invalidate any cached meta-data.
>> diff --git a/block/io.c b/block/io.c
>> index 6773926fc1..cbb6e6d073 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1829,10 +1829,10 @@ int64_t coroutine_fn=20
>> bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
>> =C2=A0=C2=A0 * Drivers not implementing the functionality are assumed to=
 not=20
>> support
>> =C2=A0=C2=A0 * backing files, hence all their sectors are reported as al=
located.
>> =C2=A0=C2=A0 *
>> - * If 'want_zero' is true, the caller is querying for mapping purposes,
>> - * and the result should include BDRV_BLOCK_OFFSET_VALID and
>> - * BDRV_BLOCK_ZERO where possible; otherwise, the result may omit those
>> - * bits particularly if it allows for a larger value in 'pnum'.
>> + * If 'want_zero' is true, the caller is querying for mapping
>> + * purposes, with a focus on valid BDRV_BLOCK_OFFSET_VALID, _DATA, and
>> + * _ZERO where possible; otherwise, the result favors larger 'pnum',
>> + * with a focus on accurate BDRV_BLOCK_ALLOCATED.
>> =C2=A0=C2=A0 *
>> =C2=A0=C2=A0 * If 'offset' is beyond the end of the disk image the retur=
n value is
>> =C2=A0=C2=A0 * BDRV_BLOCK_EOF and 'pnum' is set to 0.
>> @@ -1889,7 +1889,7 @@ static int coroutine_fn=20
>> bdrv_co_block_status(BlockDriverState *bs,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Must be non-NULL or bdrv_getlength() w=
ould have failed */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(bs->drv);
>> -=C2=A0=C2=A0=C2=A0 if (!bs->drv->bdrv_co_get_block_status) {
>> +=C2=A0=C2=A0=C2=A0 if (!bs->drv->bdrv_co_get_block_status &&=20
>> !bs->drv->bdrv_co_block_status) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *pnum =3D bytes;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D BDRV_BLOC=
K_DATA | BDRV_BLOCK_ALLOCATED;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (offset + byte=
s =3D=3D total_size) {
>> @@ -1906,13 +1906,14 @@ static int coroutine_fn=20
>> bdrv_co_block_status(BlockDriverState *bs,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_inc_in_flight(bs);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Round out to request_alignment boundar=
ies */
>> -=C2=A0=C2=A0=C2=A0 /* TODO: until we have a byte-based driver callback,=
 we also=20
>> have to
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * round out to sectors, even if that is bigger=
 than=20
>> request_alignment */
>> -=C2=A0=C2=A0=C2=A0 align =3D MAX(bs->bl.request_alignment, BDRV_SECTOR_=
SIZE);
>> +=C2=A0=C2=A0=C2=A0 align =3D bs->bl.request_alignment;
>> +=C2=A0=C2=A0=C2=A0 if (bs->drv->bdrv_co_get_block_status && align <=20
>> BDRV_SECTOR_SIZE) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 align =3D BDRV_SECTOR_SIZE;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aligned_offset =3D QEMU_ALIGN_DOWN(offset=
, align);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aligned_bytes =3D ROUND_UP(offset + bytes=
, align) - aligned_offset;
>>
>> -=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 if (bs->drv->bdrv_co_get_block_status) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int count; /* sec=
tors */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t longret;
>>
>> @@ -1937,6 +1938,15 @@ static int coroutine_fn=20
>> bdrv_co_block_status(BlockDriverState *bs,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D longret &=
 ~BDRV_BLOCK_OFFSET_MASK;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *pnum =3D count *=
 BDRV_SECTOR_SIZE;
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bs->drv->bdrv_co_blo=
ck_status(bs, want_zero,=20
>> aligned_offset,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aligned_bytes, pnum,=20
>> &local_map,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &local_file);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *pnu=
m =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(*pnum); /* The block =
driver must make progress */
>
> don't you want to assert alignment here too, to address your "or set=20
> pnum to an aligned non-zero value"

aha, which proves that I didn't look at the surrounding code, which has=20
corresponding assertion after else block.

>
> anyway,
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>
>


--=20
Best regards,
Vladimir

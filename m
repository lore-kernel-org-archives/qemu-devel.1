Received: from eggs.gnu.org ([2001:4830:134:3::10]:54609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzAUv-0000yV-F5
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 19:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzAUt-0003C3-CA
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 19:51:41 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-22-eblake@redhat.com>
	<2d443ce7-b533-cd70-0e60-1bba52ac6d69@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a7741050-a33c-c071-8649-33c6e896a7f3@redhat.com>
Date: Mon, 2 Oct 2017 18:51:21 -0500
MIME-Version: 1.0
In-Reply-To: <2d443ce7-b533-cd70-0e60-1bba52ac6d69@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="er43UmP2Bi7tLFkIDSFowbenmPxxueVF2"
Subject: Re: [Qemu-devel] [PATCH v4 21/23] block: Align block status requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--er43UmP2Bi7tLFkIDSFowbenmPxxueVF2
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <a7741050-a33c-c071-8649-33c6e896a7f3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 21/23] block: Align block status requests
References: <20170913160333.23622-1-eblake@redhat.com>
 <20170913160333.23622-22-eblake@redhat.com>
 <2d443ce7-b533-cd70-0e60-1bba52ac6d69@redhat.com>
In-Reply-To: <2d443ce7-b533-cd70-0e60-1bba52ac6d69@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 03:24 PM, John Snow wrote:
>=20
>=20
> On 09/13/2017 12:03 PM, Eric Blake wrote:
>> Any device that has request_alignment greater than 512 should be
>> unable to report status at a finer granularity; it may also be
>> simpler for such devices to be guaranteed that the block layer
>> has rounded things out to the granularity boundary (the way the
>> block layer already rounds all other I/O out).  Besides, getting
>> the code correct for super-sector alignment also benefits us
>> for the fact that our public interface now has byte granularity,
>> even though none of our drivers have byte-level callbacks.
>>
>> Add an assertion in blkdebug that proves that the block layer
>> never requests status of unaligned sections, similar to what it
>> does on other requests (while still keeping the generic helper
>> in place for when future patches add a throttle driver).  Note
>> that iotest 177 already covers this (it would fail if you use
>> just the blkdebug.c hunk without the io.c changes).  Meanwhile,
>> we can drop assertions in callers that no longer have to pass
>> in sector-aligned addresses.
>>
>> There is a mid-function scope added for 'int count', for a
>> couple of reasons: first, an upcoming patch will add an 'if'
>> statement that checks whether a driver has an old- or new-style
>> callback, and can conveniently use the same scope for less
>> indentation churn at that time.  Second, since we are trying
>> to get rid of sector-based computations, wrapping things in
>> a scope makes it easier to group and see what will be deleted
>> in a final cleanup patch once all drivers have been converted
>> to the new-style callback.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> @@ -1815,28 +1816,45 @@ static int64_t coroutine_fn bdrv_co_block_stat=
us(BlockDriverState *bs,
>>      }
>>
>>      bdrv_inc_in_flight(bs);
>> -    /*
>> -     * TODO: Rather than require aligned offsets, we could instead
>> -     * round to the driver's request_alignment here, then touch up
>> -     * count afterwards back to the caller's expectations.
>> -     */
>> -    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
>> -    bytes =3D MIN(bytes, BDRV_REQUEST_MAX_BYTES);
>> -    ret =3D bs->drv->bdrv_co_get_block_status(bs, offset >> BDRV_SECT=
OR_BITS,
>> -                                            bytes >> BDRV_SECTOR_BITS=
, &count,
>> -                                            &local_file);
>> -    if (ret < 0) {
>> -        *pnum =3D 0;
>> -        goto out;
>> +
>> +    /* Round out to request_alignment boundaries */
>> +    align =3D MAX(bs->bl.request_alignment, BDRV_SECTOR_SIZE);
>=20
> There's something funny to me about an alignment request getting itself=

> aligned...

Pre-patch, we are asserting that all callers are passing in
sector-aligned requests (even though we've switched the interface to
allow byte-based granularity, none of the callers are yet taking
advantage of that), then passing on sector-aligned requests to the
driver (regardless of whether the driver has 1-byte alignment, like
posix-file, or is using 4k alignment, like some block devices).
Post-patch, we are going with the larger of the driver's preferred
alignment, and our minimum of 512 (mainly because until series 4, we
have no way to pass byte values on to the driver, even if the driver
otherwise supports smaller alignments).  This MAX() disappears later in
series 4, once the driver callback is made byte-based, first by becoming
conditional on whether the driver is old sector-based or new byte-based
callback:
 https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03814.html
and then altogether when the sector-based is deleted:
 https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03833.html

So, this patch, coupled with the new driver callback in series 4, is
what lets us introduce clients that are able to finally pass in values
that are not sector-aligned; and the rounding up of alignment here is a
stop-gap measure to keep things working until the transition is complete.=


>=20
>> +    aligned_offset =3D QEMU_ALIGN_DOWN(offset, align);
>> +    aligned_bytes =3D ROUND_UP(offset + bytes, align) - aligned_offse=
t;
>> +
>> +    {
>> +        int count; /* sectors */
>> +
>> +        assert(QEMU_IS_ALIGNED(aligned_offset | aligned_bytes,
>> +                               BDRV_SECTOR_SIZE));
>> +        ret =3D bs->drv->bdrv_co_get_block_status(
>> +            bs, aligned_offset >> BDRV_SECTOR_BITS,
>> +            MIN(INT_MAX, aligned_bytes) >> BDRV_SECTOR_BITS, &count,
>=20
> I guess under the belief that INT_MAX will be strictly less than
> BDRV_REQUEST_MAX_BYTES, or some other reason I'm missing for the change=
?

INT_MAX is larger than BDRV_REQUEST_MAX_BYTES.  aligned_bytes, however,
may be larger than BDRV_REQUEST_MAX_BYTES (or even larger than INT_MAX).
 Once series 4 introduces the driver callback with a 64-bit length, then
we can pass in aligned_bytes as-is; but until then, while we are stuck
with a 32-bit sector length callback, we are artificially capping the
user's request to not exceed what we can reliably expect to work through
the driver callback.

It's not much of a real loss - our interface is already "tell me the
status of this offset, and of as many subsequent offsets that you can
easily check have the same status, up to my limit, and return the number
of like-typed offsets in pnum".  The caller can't tell the difference
between a driver that can give a full answer all the way to the
requested limit, and a driver that caps all answers at a single cluster
per call (we already document that a caller must be prepared to see the
same status for two subsequent calls in a row, rather than a single call
with a pnum covering both offsets).

>=20
>> +            &local_file);
>> +        if (ret < 0) {
>> +            *pnum =3D 0;
>> +            goto out;
>> +        }
>> +        *pnum =3D count * BDRV_SECTOR_SIZE;
>=20
> Is it asking for trouble to be updating pnum here before we undo our
> alignment corrections? For readability reasons and preventing an
> accidental context-based oopsy-daisy.

As in, write the code to make all calculations in a temporary, and then
assign *pnum only at the end?  I suppose I can tweak the code along
those lines, but I'm not sure it will make the end result any more legibl=
e.

>=20
>> +    }
>> +
>> +    /* Clamp pnum and ret to original request */
>> +    assert(QEMU_IS_ALIGNED(*pnum, align));
>=20
> Oh, do we guarantee this? I guess we do..

My overriding argument here is that a driver should never expose block
status that changes mid-alignment (for drivers that support an alignment
of 1, that's trivially true; but for drivers that refuse to read or
write anything smaller than 512 bytes at a time, it also stands to
reason that the driver won't report allocation status that differs
smaller than 512 bytes at a time).

>=20
>> +    *pnum -=3D offset - aligned_offset;
>=20
> can pnum prior to adjustment ever be less than offset - aligned_offset?=

> i.e., can this underflow?

No, underflow should not be possible.  The difference between offset and
aligned_offset is at most (align - 1), and we already argued that the
driver cannot be returning results that lie in the middle of 'align'.
We have the corner case of a caller requesting status on 0 bytes, but
that should already be handled at the front of the function before we
call the driver, so a driver should never be called with a limit smaller
than align, and should never return success unless pnum is at least align=
=2E

Maybe an assertion would help, though.

>=20
> (Can we fail to actually inquire about the range the caller was
> interested in by aligning down too much and observing a difference in
> allocation status between the alignment pre-range and the actual range?=
)

Again, the argument of alignment is that we are widening from the
caller's area of interest into the granularity supported by the driver;
since the driver can't report two different block status for different
portions of the granularity, we should never be in the situation where
aligning down too much sees the wrong status of the pre-range area that
differs from the status of the area in question.

>=20
>> +    if (aligned_offset >> BDRV_SECTOR_BITS !=3D offset >> BDRV_SECTOR=
_BITS &&
>> +        ret & BDRV_BLOCK_OFFSET_VALID) {
>> +        ret +=3D QEMU_ALIGN_DOWN(offset - aligned_offset, BDRV_SECTOR=
_SIZE);
>> +    }
>=20
> Alright, and if the starting sectors are different (Wait, why is it
> sectors now instead of the requested alignment? Is this safe for all
> formats?) we adjust the return value forward a little bit to match the
> difference.

The inherent problem with the bdrv_co_get_status() interface is that we
CANNOT report finer granularity than 512-byte mapping, even though we
now take byte offset/length input (we have only 64 bits to report an
answer, and those bits must include the upper 55 bits of the offset and
a lower 9 bits that are used as flags - we don't have the luxury of
reporting a full 64-bit mapping).  The solution is that we document that
the answer is an offset modulo 512: if we return an offset, it is the
offset of the start of the sector matching the byte in question.  (If I
ask for the status of byte 2, and the answer includes offset 0x1000,
then I know that I read offset 0x1002 to get the contents of the byte I
asked about)

So that answers what happens for sub-sector results.  The question then
is what do we do with drivers that require larger-than-512 alignment,
such as block devices that require 4k-byte allocation.

Pre-patch, we don't care about the driver's granularity - our question
was always 512-byte aligned, so our answer is also, and we don't have to
fudge anything back into place here in io.c (but we DO have to do the
fudging elsewhere; for example, qcow2.c:qcow2_co_get_block_status()
calls qcow2_get_cluster_offset on a number that is rounded down to a
cluster boundary, and has to 'cluster_offset |=3D (index_in_cluster <<
BDRV_SECTOR_BITS)' to get back to the right sector boundary).
Post-patch, because we know obey the driver's bs->bl.request_alignment,
a driver that requires 4k questions is in the same boat where we may
have rounded down, and then have to add back to the answer to get to the
right sector (the driver's answer already means we have pnum contiguous
bytes starting at the aligned offset).


>=20
>> +    if (*pnum > bytes) {
>> +        *pnum =3D bytes;
>>      }
>=20
> Assuming this clamps the aligned_bytes range down to the bytes range, i=
n
> case it's contiguous beyond what the caller asked for.
>=20
>> -    *pnum =3D count * BDRV_SECTOR_SIZE;
>>
>>      if (ret & BDRV_BLOCK_RAW) {
>>          assert(ret & BDRV_BLOCK_OFFSET_VALID && local_file);
>>          ret =3D bdrv_co_block_status(local_file, mapping,
>> -                                   ret & BDRV_BLOCK_OFFSET_MASK,
>> +                                   (ret & BDRV_BLOCK_OFFSET_MASK) |
>> +                                   (offset & ~BDRV_BLOCK_OFFSET_MASK)=
,
>>                                     *pnum, pnum, &local_file);
>> -        assert(QEMU_IS_ALIGNED(*pnum, BDRV_SECTOR_SIZE));
>>          goto out;
>>      }
>>
>> @@ -1860,7 +1878,8 @@ static int64_t coroutine_fn bdrv_co_block_status=
(BlockDriverState *bs,
>>          int64_t file_pnum;
>>
>>          ret2 =3D bdrv_co_block_status(local_file, mapping,
>> -                                    ret & BDRV_BLOCK_OFFSET_MASK,
>> +                                    (ret & BDRV_BLOCK_OFFSET_MASK) |
>> +                                    (offset & ~BDRV_BLOCK_OFFSET_MASK=
),
>>                                      *pnum, &file_pnum, NULL);
>>          if (ret2 >=3D 0) {
>>              /* Ignore errors.  This is just providing extra informati=
on, it
>> diff --git a/block/blkdebug.c b/block/blkdebug.c
>> index 46e53f2f09..f54fe33cae 100644
>> --- a/block/blkdebug.c
>> +++ b/block/blkdebug.c
>> @@ -628,6 +628,17 @@ static int coroutine_fn blkdebug_co_pdiscard(Bloc=
kDriverState *bs,
>>      return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
>>  }
>>
>> +static int64_t coroutine_fn blkdebug_co_get_block_status(
>> +    BlockDriverState *bs, int64_t sector_num, int nb_sectors, int *pn=
um,
>> +    BlockDriverState **file)
>> +{
>> +    assert(QEMU_IS_ALIGNED(sector_num | nb_sectors,
>> +                           DIV_ROUND_UP(bs->bl.request_alignment,
>> +                                        BDRV_SECTOR_SIZE)));
>> +    return bdrv_co_get_block_status_from_file(bs, sector_num, nb_sect=
ors,
>> +                                              pnum, file);
>> +}
>> +
>>  static void blkdebug_close(BlockDriverState *bs)
>>  {
>>      BDRVBlkdebugState *s =3D bs->opaque;
>> @@ -897,7 +908,7 @@ static BlockDriver bdrv_blkdebug =3D {
>>      .bdrv_co_flush_to_disk  =3D blkdebug_co_flush,
>>      .bdrv_co_pwrite_zeroes  =3D blkdebug_co_pwrite_zeroes,
>>      .bdrv_co_pdiscard       =3D blkdebug_co_pdiscard,
>> -    .bdrv_co_get_block_status =3D bdrv_co_get_block_status_from_file,=

>> +    .bdrv_co_get_block_status =3D blkdebug_co_get_block_status,
>>
>>      .bdrv_debug_event           =3D blkdebug_debug_event,
>>      .bdrv_debug_breakpoint      =3D blkdebug_debug_breakpoint,
>>
>=20
> Looks good overall but I have some comprehension issues in my own head
> about the adjustment math and why the various alignments are safe.

I may add a couple more asserts and/or comments in the next spin,
documenting what conditions hold each step along the way.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--er43UmP2Bi7tLFkIDSFowbenmPxxueVF2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnS0PkACgkQp6FrSiUn
Q2qjYggAiECn+FWtzly+UzJFbCNFbimw5TM2pkYqq/68TWORobfgtRdxqQRCBpQv
IcnnvppyyHeHi9UFLkWq0Id6FL7JTeyqoWNVEAAxPol55L/VImafPk1bLhI3CUam
aZ5TMa181iwS0yNfxuhWe0eKmGiXifNR+zdQ0CrxKBFY87Q481mL+syS6irog0gV
Ob3fJn/8YK9tQ96IeLPhyUbzn0cm7UH4sUB+i2Lx12tatvVp7Y4zGJeb8tvyXjyq
xOpvTiXh9LOXpnD9FQPYvYVpunMFf7bR71W5hL3DD47RfNZLAbfsKstTMWWEmbPs
ePGtHxAPXSL/4rBq3cPU09k0DOssww==
=/+Za
-----END PGP SIGNATURE-----

--er43UmP2Bi7tLFkIDSFowbenmPxxueVF2--

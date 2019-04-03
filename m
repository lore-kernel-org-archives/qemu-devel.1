Received: from eggs.gnu.org ([209.51.188.92]:60009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBgTl-0003VW-Da
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBgTg-0005Tu-Ka
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:03:01 -0400
References: <20190403030526.12258-1-eblake@redhat.com>
	<20190403030526.12258-6-eblake@redhat.com>
	<20190403130354.GA6108@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7482dbdf-6783-da65-0190-c62996936e40@redhat.com>
Date: Wed, 3 Apr 2019 09:02:23 -0500
MIME-Version: 1.0
In-Reply-To: <20190403130354.GA6108@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CWgHRHSlKFCO7uuf0OJFzUqY9MWPOCd2S"
Subject: Re: [Qemu-devel] [PATCH 5/7] block: Fix BDRV_BLOCK_RAW status to
 honor alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CWgHRHSlKFCO7uuf0OJFzUqY9MWPOCd2S
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>
Message-ID: <7482dbdf-6783-da65-0190-c62996936e40@redhat.com>
Subject: Re: [PATCH 5/7] block: Fix BDRV_BLOCK_RAW status to honor alignment
References: <20190403030526.12258-1-eblake@redhat.com>
 <20190403030526.12258-6-eblake@redhat.com>
 <20190403130354.GA6108@localhost.localdomain>
In-Reply-To: <20190403130354.GA6108@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/3/19 8:03 AM, Kevin Wolf wrote:
> Am 03.04.2019 um 05:05 hat Eric Blake geschrieben:
>> Previous patches mentioned how the blkdebug filter driver demonstrates=

>> a bug present in our NBD server; the bug is also present with the raw
>> format driver when probing occurs. Basically, if we specify a
>> particular alignment > 1, but defer the actual block status to the
>> underlying file, and the underlying file has a smaller alignment, then=

>> the use of BDRV_BLOCK_RAW to defer to the underlying file can end up
>> with status split at an alignment unacceptable to our layer.  Many
>> callers don't care, but NBD does - it is a violation of the NBD
>> protocol to send status or read results split on an unaligned boundary=

>> (we've taught our client to be tolerant of such violations because of
>> qemu 3.1; but we still need to fix our server for the sake of other
>> stricter clients).
>>
>> This patch lays the groundwork - it adjusts bdrv_block_status to
>> ensure that any time one layer defers to another via BDRV_BLOCK_RAW,
>> the deferral is either truncated down to an aligned boundary, or
>> multiple sub-aligned requests are coalesced into a single
>> representative answer (using an implicit hole beyond EOF as
>> needed). Iotest 241 exposes the effect (when format probing occurred,
>> we don't want block status to subdivide the initial sector, and thus
>> not any other sector either). Similarly, iotest 221 is a good
>> candidate to amend to specifically track the effects; a change to a
>> hole at EOF is not visible if an upper layer does not want alignment
>> smaller than 512. However, this patch alone is not a complete fix - it=

>> is still possible to have an active layer with large alignment
>> constraints backed by another layer with smaller constraints; so the
>> next patch will complete the task.

I should probably update this text to call out that the next patch
introduces some additional mutual recursion (that is, this patch in
isolation may appear to have dead paths, as the caller
bdrv_co_block_status always passes non-NULL 'map' and 'file'; but the
next patch adjusts bdrv_co_block_status_above to call this instead of
directly into bdrv_co_block_status, hence exposing those paths).

>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  block/io.c                 | 108 +++++++++++++++++++++++++++++++++++-=
-
>>  tests/qemu-iotests/221     |  10 ++++
>>  tests/qemu-iotests/221.out |   6 +++
>>  tests/qemu-iotests/241.out |   3 +-
>>  4 files changed, 122 insertions(+), 5 deletions(-)
>>

>> +/*
>> + * Returns an aligned allocation status of the specified sectors.
>> + * Wrapper around bdrv_co_block_status() which requires the initial
>> + * offset and count to be aligned, and guarantees the result will als=
o
>> + * be aligned (even if it requires piecing together multiple
>> + * sub-aligned queries into an appropriate coalesced answer).
>> + */
>=20
> I think this comment should specify the result of the operation when th=
e
> aligned region consists of multiple subregions with different status.

Good idea.

> Probably something like this:
>=20
> - BDRV_BLOCK_DATA is set if the flag is set for at least one subregion
> - BDRV_BLOCK_ZERO is set if the flag is set for all subregions
> - BDRV_BLOCK_OFFSET_VALID is set if the flag is set for all subregions,=

>   the provided offsets are contiguous and file is the same for all
>   subregions.

Correct.

> - BDRV_BLOCK_ALLOCATED is never set here (the caller sets it)

Not true, bdrv_co_block_status can set BDRV_BLOCK_ALLOCATED.

> - BDRV_BLOCK_EOF is set if the last subregion sets it; assert that it's=

>   not set for any other subregion

With the additional caveat that status beyond BDRV_BLOCK_EOF up to the
alignment boundary is treated as an implicit hole.

> - BDRV_BLOCK_RAW is never set

That should be true.

>=20
> - *map is only set if BDRV_BLOCK_OFFSET_VALID is set. It contains
>   the offset of the first subregion then.

Correct.  Since the subregions had to be contiguous, it is the correct
offset for the entire aligned region.

>=20
> - *file is also only set if BDRV_BLOCK_OFFSET_VALID is set. It contains=

>   the *file of the subregions, which must be the same for all of them
>   (otherwise, we wouldn't have set BDRV_BLOCK_OFFSET_VALID).
>=20
> - *pnum: The sum of all subregions

And is guaranteed to be aligned, as well as being non-zero unless
'bytes' was 0 on input or if the entire status request is beyond EOF.

>=20
>> +static int coroutine_fn bdrv_co_block_status_aligned(BlockDriverState=
 *bs,
>> +                                                     uint32_t align,
>> +                                                     bool want_zero,
>> +                                                     int64_t offset,
>> +                                                     int64_t bytes,
>> +                                                     int64_t *pnum,
>> +                                                     int64_t *map,
>> +                                                     BlockDriverState=
 **file)
>> +{
>> +    int ret;
>> +
>> +    assert(is_power_of_2(align) && QEMU_IS_ALIGNED(offset | bytes, al=
ign));
>> +    ret =3D bdrv_co_block_status(bs, want_zero, offset, bytes, pnum, =
map, file);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +    if (!*pnum) {
>> +        assert(!bytes || ret & BDRV_BLOCK_EOF);
>> +        return ret;
>> +    }
>> +    if (*pnum >=3D align) {
>> +        if (!QEMU_IS_ALIGNED(*pnum, align)) {
>> +            ret &=3D ~BDRV_BLOCK_EOF;
>> +            *pnum =3D QEMU_ALIGN_DOWN(*pnum, align);
>> +        }
>> +        return ret;
>> +    }
>=20
> So we decide to just shorten the function if we can return at least som=
e
> *pnum > 0. This means that is most cases, this function will have to be=

> called twice, once for the aligned part, and again for the misaligned
> rest.

Yes, that was my choice for ease of implementation this time around.

>=20
> We do save a little if the caller isn't actually interested in mapping
> the whole image, but just in a specific range before the misaligned
> part.
>=20
> So it depends on the use case whether this is an optimisation or a
> pessimisation.

Yeah, it looks like I should try harder for the BDRV_BLOCK_EOF case -
there, we KNOW that there is only one more subregion, and it will be a
hole; we also know that coalescing a hole with a hole is still a hole,
and coalescing a hole with data is data.  So special-casing
BDRV_BLOCK_EOF to widen out to alignment is probably better than splittin=
g.

For cases where BDRV_BLOCK_EOF is not set, we have no easy guarantees
about how many subregions the next BDS will provide, nor if those
subsequent subregions will always coalesce into the type of the first
subregion, so splitting early is still probably the smartest approach
for keeping that code sane.

Sounds like I should also try harder to capture some of these nuances in
iotests (I did capture the mid-sector hole due to EOF, but capturing a
blkdebug at 4k alignment wrapping a qcow2 with 512 alignment will cover
more of the interesting coalescing code).


>=20
>> +    /* Merge in status for the rest of align */
>> +    while (*pnum < align) {
>=20
> Okay, in any case, I can see it's a simplification. :-)
>=20
>> +        int ret2;
>> +        int64_t pnum2;
>> +        int64_t map2;
>> +        BlockDriverState *file2;
>> +
>> +        ret2 =3D bdrv_co_block_status(bs, want_zero, offset + *pnum,
>> +                                    align - *pnum, &pnum2,
>> +                                    map ? &map2 : NULL, file ? &file2=
 : NULL);
>> +        if (ret2 < 0) {
>> +            return ret2;
>> +        }
>> +        if (ret2 & BDRV_BLOCK_EOF) {
>> +            ret |=3D BDRV_BLOCK_EOF;
>> +            if (!pnum2) {
>> +                pnum2 =3D align - *pnum;
>> +                ret2 |=3D BDRV_BLOCK_ZERO;
>> +            }
>> +        } else {
>> +            assert(pnum2);
>> +        }
>> +        if (ret2 & BDRV_BLOCK_DATA) {
>> +            ret |=3D BDRV_BLOCK_DATA;
>> +        }
>> +        if (!(ret2 & BDRV_BLOCK_ZERO)) {
>> +            ret &=3D ~BDRV_BLOCK_ZERO;
>> +        }
>> +        if ((ret & BDRV_BLOCK_OFFSET_VALID) &&
>> +            (!(ret2 & BDRV_BLOCK_OFFSET_VALID) ||
>> +             (map && *map + *pnum !=3D map2) || (file && *file !=3D f=
ile2))) {
>> +            ret &=3D ~BDRV_BLOCK_OFFSET_VALID;
>> +            if (map) {
>> +                *map =3D 0;
>> +            }
>> +            if (file) {
>> +                *file =3D NULL;
>> +            }
>> +        }
>> +        if (ret2 & BDRV_BLOCK_ALLOCATED) {
>> +            ret |=3D BDRV_BLOCK_ALLOCATED;
>> +        }
>=20
> Hm, so if we have a region that consists of two subregion, one is
> unallocated and the other one is a zero cluster. The result will be
> DATA =3D=3D false, ZERO =3D=3D false, ALLOCATED =3D=3D true. This looks=
 a bit odd.

In the common case of 'DATA|ALLOCATED|EOF, ZERO' for the hole past EOF,
I think we want to prefer keeping ALLOCATED set. But you are asking
about '0, ZERO|ALLOCATED', where we cannot guarantee that the entire
region reads as zeroes, and we also know that the entire region is not
allocated but some of it is. Maybe this should pay attention to the
'want_zero' flag? We already state elsewhere that:

 * If 'want_zero' is true, the caller is querying for mapping
 * purposes, with a focus on valid BDRV_BLOCK_OFFSET_VALID, _DATA, and
 * _ZERO where possible; otherwise, the result favors larger 'pnum',
 * with a focus on accurate BDRV_BLOCK_ALLOCATED.

so that would mean that if want_zero is true, we treat the entire region
as unallocated if any subregion prior to EOF is unallocated (since we
can't report ZERO, and the caller didn't care about ALLOCATED); if
want_zero is false, we treat the entire region as allocated if any
subregion is allocated (since we know the caller cared about ALLOCATED,
and less about ZERO)?

Or does it mean we just have to audit all callers to see if any of them
would misbehave in one way or another depending on which way we set the
flag?

> Did you check this case and come to the conclusion that it's okay? If
> so, I think a comment would be good.
>=20
>> +        if (ret2 & BDRV_BLOCK_RAW) {
>> +            assert(ret & BDRV_BLOCK_RAW);
>> +            assert(ret & BDRV_BLOCK_OFFSET_VALID);
>> +        }
>=20
> Doesn't RAW mean that we need to recurse rather than returning the flag=
?
> Or actually, bdrv_co_block_status() shouldn't ever return the flag, so
> can't we assert that it's clear?

Yes, I think you are right that we can assert RAW is clear by this point.=


>=20
>> +        *pnum +=3D pnum2;
>> +    }
>> +    return ret;
>> +}
>=20
> Kevin
>=20

So since I have to do a v2, this is definitely slipping into 4.1.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--CWgHRHSlKFCO7uuf0OJFzUqY9MWPOCd2S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlykvO8ACgkQp6FrSiUn
Q2rK/ggAq1+cRBKxRlVNkej0ugkbDDmLF4MqMpDTIFFvCwAp7ranVTgLENiqyne2
XdakbH1MO/S4eGMkPKxm4qYC3uBryNarlL05yGIOQA7fMo2/CFX2GecohjexGa/i
t2yPjZpwrL4dOfdQmHwW1uqvb5KmL2f+nVf8SA6TJ+W/UFtrcaEGnkZj+Yq90AoG
R6DJ6WZyEiMvO6kH67egBbfsc5/ZVSeuqlFpW3arl4TmNBb9kAKZnIgy5t1QmNV5
pVUQd16xyNKWmv3szYb2JanzlVx5Hb5u456ur1zdvih0GczLJLLTPtbT/idOUyeJ
n1/xvpib4AYH0IoRgItTo2BScfbwTg==
=PsVN
-----END PGP SIGNATURE-----

--CWgHRHSlKFCO7uuf0OJFzUqY9MWPOCd2S--

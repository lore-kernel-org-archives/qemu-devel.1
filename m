Received: from eggs.gnu.org ([2001:4830:134:3::10]:47437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dOQn5-000529-Bx
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dOQn3-0007z2-6C
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:46:35 -0400
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
	<20170613121639.17853-4-pbutsykin@virtuozzo.com>
	<aed64e0e-61ed-12c9-8676-ad55795b6e62@redhat.com>
	<5fb63c73-ddc7-ba42-268f-bda160aebb6e@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d3c0c0c2-da7e-bfff-e3c6-2d419c1126b9@redhat.com>
Date: Fri, 23 Jun 2017 17:46:13 +0200
MIME-Version: 1.0
In-Reply-To: <5fb63c73-ddc7-ba42-268f-bda160aebb6e@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iAXGrVnknWgd6pOp5690v1bfikcATHojN"
Subject: Re: [Qemu-devel] [PATCH v2 3/4] qcow2: add shrink image support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iAXGrVnknWgd6pOp5690v1bfikcATHojN
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org
Message-ID: <d3c0c0c2-da7e-bfff-e3c6-2d419c1126b9@redhat.com>
Subject: Re: [PATCH v2 3/4] qcow2: add shrink image support
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
 <20170613121639.17853-4-pbutsykin@virtuozzo.com>
 <aed64e0e-61ed-12c9-8676-ad55795b6e62@redhat.com>
 <5fb63c73-ddc7-ba42-268f-bda160aebb6e@virtuozzo.com>
In-Reply-To: <5fb63c73-ddc7-ba42-268f-bda160aebb6e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-22 15:57, Pavel Butsykin wrote:
>=20
> On 22.06.2017 01:55, Max Reitz wrote:
>> On 2017-06-13 14:16, Pavel Butsykin wrote:
>>> This patch add shrinking of the image file for qcow2. As a result,
>>> this allows
>>> us to reduce the virtual image size and free up space on the disk
>>> without
>>> copying the image. Image can be fragmented and shrink is done by
>>> punching holes
>>> in the image file.
>>>
>>> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
>>> ---
>>>   block/qcow2-cluster.c  | 42 ++++++++++++++++++++++++++++++++
>>>   block/qcow2-refcount.c | 65
>>> ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   block/qcow2.c          | 40 +++++++++++++++++++++++--------
>>>   block/qcow2.h          |  2 ++
>>>   qapi/block-core.json   |  3 ++-
>>>   5 files changed, 141 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>>> index d779ea19cf..a84b7e607e 100644
>>> --- a/block/qcow2-cluster.c
>>> +++ b/block/qcow2-cluster.c
>>> @@ -32,6 +32,48 @@
>>>   #include "qemu/bswap.h"
>>>   #include "trace.h"
>>>   +int qcow2_shrink_l1_table(BlockDriverState *bs, uint64_t max_size)=

>>
>> It's not really a max_size but always an exact size. You don't want it=

>> to be any smaller than this.
>>
>>> +{
>>> +    BDRVQcow2State *s =3D bs->opaque;
>>> +    int new_l1_size, i, ret;
>>> +
>>> +    if (max_size >=3D s->l1_size) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    new_l1_size =3D max_size;
>>> +
>>> +#ifdef DEBUG_ALLOC2
>>> +    fprintf(stderr, "shrink l1_table from %d to %" PRId64 "\n",
>>> +            s->l1_size, new_l1_size);
>>
>> new_l1_size is of type int, not int64_t.
>>
>>> +#endif
>>> +
>>> +    BLKDBG_EVENT(bs->file, BLKDBG_L1_SHRINK_WRITE_TABLE);
>>> +    ret =3D bdrv_pwrite_zeroes(bs->file, s->l1_table_offset +
>>> +                                       sizeof(uint64_t) * new_l1_siz=
e,
>>> +                             (s->l1_size - new_l1_size) *
>>> sizeof(uint64_t), 0);
>>> +    if (ret < 0) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    ret =3D bdrv_flush(bs->file->bs);
>>> +    if (ret < 0) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    BLKDBG_EVENT(bs->file, BLKDBG_L1_SHRINK_FREE_L2_CLUSTERS);
>>> +    for (i =3D s->l1_size - 1; i > new_l1_size - 1; i--) {
>>> +        if ((s->l1_table[i] & L1E_OFFSET_MASK) =3D=3D 0) {
>>> +            continue;
>>> +        }
>>> +        qcow2_free_clusters(bs, s->l1_table[i] & L1E_OFFSET_MASK,
>>> +                            s->l2_size * sizeof(uint64_t),
>>
>> I'm more of a fan of s->cluster_size instead of s->l2_size *
>> sizeof(uint64_t) but it's not like it matters...
>>
>>> +                            QCOW2_DISCARD_ALWAYS);
>>> +        s->l1_table[i] =3D 0;
>>
>> I'd probably clear the overhanging s->l1_table entries before
>> bdrv_flush() (before you shouldn't really use them after
>> bdrv_pwrite_zeroes() has returned, even if bdrv_flush() has failed), b=
ut
>> it's not absolutely necessary. As long as they still have a refcount o=
f
>> at least one, writing to them will just be useless but not destroy any=

>> data.
>>
>=20
> You're right, but If it's not necessary, I would prefer to leave as is.=
=2E
> Just because overhanging s->l1_table entries used to release clusters :=
)

Hm, yes. The question is, how bad are useless writes?

So the worst case scenario is this: You invoke qmp_block_resize() to
shrink the image; the bdrv_flush() call fails somewhere in the middle
but the data is still kind of pending and basically in the image.

Now when you continue to use the image and write data beyond the
intended new end, that data basically ends up nowhere. You can still
read the data just fine and change it, but when you restart qemu, it
will all be gone. So that's weird.

Admittedly, though, bdrv_flush() isn't the only issue here;
bdrv_pwrite_zeroes() is, too. If that fails somewhere in the middle, we
basically have the same situation.

Now if we were to update s->l1_table before the bdrv_pwrite_zeroes()
call, we might end up with the opposite issue: The data appears to be
gone, but after reopening the image, it's back again. The main
difference is that in this case we'll have to allocate L2 tables anew
and this will require writes to the L1 table, so maybe we can actually
succeed in overwriting the old data then... But that's a big maybe.

So all in all we'll very likely get inconsistencies either way, so yes,
it doesn't actually matter. :-)

>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>>   int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
>>>                           bool exact_size)
>>>   {
>>> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
>>> index 576ab551d6..e98306acd8 100644
>>> --- a/block/qcow2-refcount.c
>>> +++ b/block/qcow2-refcount.c
>>> @@ -29,6 +29,7 @@
>>>   #include "block/qcow2.h"
>>>   #include "qemu/range.h"
>>>   #include "qemu/bswap.h"
>>> +#include "qemu/cutils.h"
>>>     static int64_t alloc_clusters_noref(BlockDriverState *bs,
>>> uint64_t size);
>>>   static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState=

>>> *bs,
>>> @@ -2936,3 +2937,67 @@ done:
>>>       qemu_vfree(new_refblock);
>>>       return ret;
>>>   }
>>> +
>>> +int qcow2_shrink_reftable(BlockDriverState *bs)
>>> +{
>>> +    BDRVQcow2State *s =3D bs->opaque;
>>> +    uint64_t *reftable_tmp =3D
>>> +        g_try_malloc(sizeof(uint64_t) * s->refcount_table_size);
>>> +    int i, ret;
>>> +
>>> +    if (s->refcount_table_size && reftable_tmp =3D=3D NULL) {
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    for (i =3D 0; i < s->refcount_table_size; i++) {
>>> +        int64_t refblock_offs =3D s->refcount_table[i] &
>>> REFT_OFFSET_MASK;
>>> +        void *refblock;
>>> +        bool unused_block;
>>> +
>>> +        if (refblock_offs =3D=3D 0) {
>>> +            reftable_tmp[i] =3D 0;
>>> +            continue;
>>> +        }
>>> +        ret =3D qcow2_cache_get(bs, s->refcount_block_cache,
>>> refblock_offs,
>>> +                              &refblock);
>>> +        if (ret < 0) {
>>> +            goto out;
>>> +        }
>>> +
>>> +        /* the refblock has own reference */
>>> +        if (i =3D=3D refblock_offs >> (s->refcount_block_bits +
>>> s->cluster_bits)) {
>>> +            uint64_t blk_index =3D (refblock_offs >> s->cluster_bits=
) &
>>> +                                 (s->refcount_block_size - 1);
>>> +            uint64_t refcount =3D s->get_refcount(refblock, blk_inde=
x);
>>> +
>>> +            s->set_refcount(refblock, blk_index, 0);
>>> +
>>> +            unused_block =3D buffer_is_zero(refblock,
>>> s->refcount_block_size);
>>
>> s/refcount_block_size/cluster_size/
>>
>>> +
>>> +            s->set_refcount(refblock, blk_index, refcount);
>>> +        } else {
>>> +            unused_block =3D buffer_is_zero(refblock,
>>> s->refcount_block_size);
>>
>> Same here.
>>
>>> +        }
>>> +        qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
>>> +
>>> +        reftable_tmp[i] =3D unused_block ? 0 :
>>> cpu_to_be64(s->refcount_table[i]);
>>> +    }
>>> +
>>> +    ret =3D bdrv_pwrite_sync(bs->file, s->refcount_table_offset,
>>> reftable_tmp,
>>> +                           sizeof(uint64_t) * s->refcount_table_size=
);
>>> +    if (ret < 0) {
>>> +        goto out;
>>> +    }
>>> +
>>> +    for (i =3D 0; i < s->refcount_table_size; i++) {
>>> +        if (s->refcount_table[i] && !reftable_tmp[i]) {
>>> +            qcow2_free_clusters(bs, s->refcount_table[i] &
>>> REFT_OFFSET_MASK,
>>> +                                s->cluster_size, QCOW2_DISCARD_ALWAY=
S);
>>
>> This doesn't feel like a very good idea. The bdrv_pwrite_sync() before=

>> has brought the on-disk refcount structures into a different state tha=
n
>> what we have cached.
>=20
> It is for this inside qcow2_free_clusters()->update_refcount() the cach=
e
> is discarded by qcow2_cache_discard().

This doesn't change the fact that the in-memory reftable is different
from the on-disk reftable and that qcow2_free_clusters() may trip up on
that; the main issue is the allocate_refcount_block() call before.

So we need a guarantee that update_refcount() won't touch the reftable
if the refcount is decreased. It will call alloc_refcount_block() and
that should definitely find the respective refblock to already exist
because of course it has a refcount already.

But here's an issue: It tries to read from s->refcount_table[], and you
are slowly overwriting it in the same loop here. So it may not actually
find the refcount (if a refblock is described by an earlier one).
(After more than an hour of debugging, I realized this is not true: You
will only zero reftable entries if the refblock describes nothing or
only themselves. So overwriting one reftable entry cannot have effects
on other refblocks. Or at least it should not.)

Another potential issue is that you're assuming s->refcount_table_size
to be constant. I cannot find a way for it not to be, but investigating
this is painful and I can't claim I know for sure that it is constant.
If it isn't, you may get overflows when accessing reftable_tmp[].

(Yes, it may be constant; but the reader of this code has to read
through qcow2_free_clusters(), allocate_refcount_block() and
update_refcount() to know (or at least to guess) that's the case.)

I don't really want to look deeper into this, but here's an image that I
produced while trying to somehow break all of this. It makes qemu-img
check pass but fails after qemu-img resize --shrink shrink.qcow2 32M:
https://xanclic.moe/shrink.qcow2

(The image has been created with cluster_size=3D512 and refcount_bits=3D6=
4;
then I filled the penultimate two entries of the reftable with pointers
to 0x1f0000 and 0x1f0200, respectively (so the first of these refblocks
would describe both), giving me this:
https://xanclic.moe/shrink-template.qcow2
I then put some data onto it with qemu-io -c 'write 0 1457K', which gave
me shrink.qcow2.)

Max

>> OTOH, the bdrv_pwrite_sync() has accessed only the reftable and this
>> should only access refblocks. So I cannot think of any way this might
>> actually do something bad. But I guess it'll be better for to revisit
>> this when it's not in the middle of the night (so on Friday).
>>
>>> +            s->refcount_table[i] =3D 0;
>>> +        }
>>> +    }
>>> +
>>> +out:
>>> +    g_free(reftable_tmp);
>>> +    return ret;
>>> +}
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index b3ba5daa93..0ad46d2776 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -2545,6 +2545,7 @@ static int qcow2_truncate(BlockDriverState *bs,=

>>> int64_t offset, Error **errp)
>>>   {
>>>       BDRVQcow2State *s =3D bs->opaque;
>>>       int64_t new_l1_size;
>>> +    uint64_t total_size;
>>>       int ret;
>>>         if (offset & 511) {
>>> @@ -2558,17 +2559,36 @@ static int qcow2_truncate(BlockDriverState
>>> *bs, int64_t offset, Error **errp)
>>>           return -ENOTSUP;
>>>       }
>>>   -    /* shrinking is currently not supported */
>>> -    if (offset < bs->total_sectors * 512) {
>>> -        error_setg(errp, "qcow2 doesn't support shrinking images yet=
");
>>> -        return -ENOTSUP;
>>> -    }
>>> -
>>>       new_l1_size =3D size_to_l1(s, offset);
>>> -    ret =3D qcow2_grow_l1_table(bs, new_l1_size, true);
>>> -    if (ret < 0) {
>>> -        error_setg_errno(errp, -ret, "Failed to grow the L1 table");=

>>> -        return ret;
>>> +    total_size =3D bs->total_sectors << BDRV_SECTOR_BITS;
>>> +
>>> +    if (offset < total_size) {
>>> +        ret =3D qcow2_cluster_discard(bs, ROUND_UP(offset,
>>> s->cluster_size),
>>> +                                    total_size - ROUND_UP(offset,
>>> +                                                        =20
>>> s->cluster_size),
>>> +                                    QCOW2_DISCARD_ALWAYS, true);
>>> +        if (ret < 0) {
>>> +            error_setg_errno(errp, -ret, "Failed to discard reduced
>>> clasters");
>>
>> s/clasters/clusters/
>>
>> And maybe "truncated", "stripped", or "cropped" instead of "reduced"?
>>
>>> +            return ret;
>>> +        }
>>> +
>>> +        ret =3D qcow2_shrink_l1_table(bs, new_l1_size);
>>> +        if (ret < 0) {
>>> +            error_setg_errno(errp, -ret, "Failed to reduce the L1
>>> table");
>>
>> s/reduce/shrink/ (or "truncate"; or "reduce the L1 table size")
>>
>> Also, to be fair, you're actually reducing the number of L2 tables, no=
t
>> the size of the L1 table. (But that's a nit pick)
>=20
> In the previous patch version, there really was reducing the L1 table
> size :) I think now it's better to fix the error message.
>=20
>>> +            return ret;
>>> +        }
>>> +
>>> +        ret =3D qcow2_shrink_reftable(bs);
>>> +        if (ret < 0) {
>>> +            error_setg_errno(errp, -ret, "Failed to shrink the
>>> refcount table");
>>
>> And this is not really shrinking the reftable but instead discarding
>> some refblocks (potentially). (This is a nit pick, too)
>>
>> Max
>>
>>> +            return ret;
>>> +        }
>>> +    } else {
>>> +        ret =3D qcow2_grow_l1_table(bs, new_l1_size, true);
>>> +        if (ret < 0) {
>>> +            error_setg_errno(errp, -ret, "Failed to grow the L1
>>> table");
>>> +            return ret;
>>> +        }
>>>       }
>>>         /* write updated header.size */
>>> diff --git a/block/qcow2.h b/block/qcow2.h
>>> index 07faa6dc78..600463bf8e 100644
>>> --- a/block/qcow2.h
>>> +++ b/block/qcow2.h
>>> @@ -531,10 +531,12 @@ int
>>> qcow2_pre_write_overlap_check(BlockDriverState *bs, int ign, int64_t
>>> offset,
>>>   int qcow2_change_refcount_order(BlockDriverState *bs, int
>>> refcount_order,
>>>                                   BlockDriverAmendStatusCB *status_cb=
,
>>>                                   void *cb_opaque, Error **errp);
>>> +int qcow2_shrink_reftable(BlockDriverState *bs);
>>>     /* qcow2-cluster.c functions */
>>>   int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
>>>                           bool exact_size);
>>> +int qcow2_shrink_l1_table(BlockDriverState *bs, uint64_t max_size);
>>>   int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index);
>>>   int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t
>>> cluster_offset);
>>>   int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index f85c2235c7..bcbffa3339 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -2372,7 +2372,8 @@
>>>               'cluster_alloc_bytes', 'cluster_free', 'flush_to_os',
>>>               'flush_to_disk', 'pwritev_rmw_head',
>>> 'pwritev_rmw_after_head',
>>>               'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev'=
,
>>> -            'pwritev_zero', 'pwritev_done', 'empty_image_prepare' ] =
}
>>> +            'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
>>> +            'l1_shrink_write_table', 'l1_shrink_free_l2_clusters' ] =
}
>>>     ##
>>>   # @BlkdebugInjectErrorOptions:
>>>
>>
>>



--iAXGrVnknWgd6pOp5690v1bfikcATHojN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZTTfFEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQEgf
CADBhDNZXHBjyiHR5G3b1vAXgX7SeBL6JQ/C24LwiNviBN10ShtgzTb32jS2mOsD
Kt//Pw/FJ2aVWYnwdWO0J85KY3EuQ388BWPeraHoYOZihYllfw86K6B6tvQeSMP2
rtEg1ZdmoSIyy/gvtJywEpqOSwG6Lbr0FPTzZLQ7YWU1qIjUrKonUo8poBSFtvtV
cF9DvUNpyLVpw5XV2aVsi2l88YnPWTtVS/UQ0HItG7MpRERVbbSCM/84295YyQFs
epHJo0HF1A5fOU9XtKJ+07D4Ku0Oo9yZwPMudCprc7P/cVLeVr5ROWQfXeaUbUzX
lYHW1isNbz2ZGMBzXZ568xMf
=7D5h
-----END PGP SIGNATURE-----

--iAXGrVnknWgd6pOp5690v1bfikcATHojN--

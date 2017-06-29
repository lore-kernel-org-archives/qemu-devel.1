Received: from eggs.gnu.org ([2001:4830:134:3::10]:40647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQTQ7-0000IT-Ot
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 02:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQTQ4-0004WV-Lx
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 02:59:19 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:25099 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dQTQ4-0004Vl-5F
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 02:59:16 -0400
References: <20170606162652.112122-1-vsementsov@virtuozzo.com>
	<20170606162652.112122-2-vsementsov@virtuozzo.com>
	<33cfc00b-1f19-6938-44a2-e2e08ea150e1@redhat.com>
	<5aa5283a-0a2a-7069-ec2a-3bb7f213c106@virtuozzo.com>
	<bee4ba0e-444a-3c88-5d2c-f978f2ef9ad9@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e3d7021b-4c71-50ea-87d3-66de1709161a@virtuozzo.com>
Date: Thu, 29 Jun 2017 09:59:04 +0300
MIME-Version: 1.0
In-Reply-To: <bee4ba0e-444a-3c88-5d2c-f978f2ef9ad9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 1/3] block: add
 bdrv_get_format_alloc_stat format interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org, Eric Blake <eblake@redhat.com>

29.06.2017 03:15, John Snow wrote:
>
> On 06/28/2017 11:59 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 27.06.2017 02:19, John Snow wrote:
>>> On 06/06/2017 12:26 PM, Vladimir Sementsov-Ogievskiy wrote:
>>>> The function should collect statistics, about used/unused by top-level
>>>> format driver space (in its .file) and allocation status
>>>> (data/zero/discarded/after-eof) of corresponding areas in this .file.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>    block.c                   | 16 ++++++++++++++
>>>>    include/block/block.h     |  3 +++
>>>>    include/block/block_int.h |  2 ++
>>>>    qapi/block-core.json      | 55
>>>> +++++++++++++++++++++++++++++++++++++++++++++++
>>>>    4 files changed, 76 insertions(+)
>>>>
>>>> diff --git a/block.c b/block.c
>>>> index 50ba264143..7d720ae0c2 100644
>>>> --- a/block.c
>>>> +++ b/block.c
>>>> @@ -3407,6 +3407,22 @@ int64_t
>>>> bdrv_get_allocated_file_size(BlockDriverState *bs)
>>>>    }
>>>>      /**
>>>> + * Collect format allocation info. See BlockFormatAllocInfo
>>>> definition in
>>>> + * qapi/block-core.json.
>>>> + */
>>>> +int bdrv_get_format_alloc_stat(BlockDriverState *bs,
>>>> BlockFormatAllocInfo *bfai)
>>>> +{
>>>> +    BlockDriver *drv = bs->drv;
>>>> +    if (!drv) {
>>>> +        return -ENOMEDIUM;
>>>> +    }
>>>> +    if (drv->bdrv_get_format_alloc_stat) {
>>>> +        return drv->bdrv_get_format_alloc_stat(bs, bfai);
>>>> +    }
>>>> +    return -ENOTSUP;
>>>> +}
>>>> +
>>>> +/**
>>>>     * Return number of sectors on success, -errno on error.
>>>>     */
>>>>    int64_t bdrv_nb_sectors(BlockDriverState *bs)
>>>> diff --git a/include/block/block.h b/include/block/block.h
>>>> index 9b355e92d8..646376a772 100644
>>>> --- a/include/block/block.h
>>>> +++ b/include/block/block.h
>>>> @@ -335,6 +335,9 @@ typedef enum {
>>>>      int bdrv_check(BlockDriverState *bs, BdrvCheckResult *res,
>>>> BdrvCheckMode fix);
>>>>    +int bdrv_get_format_alloc_stat(BlockDriverState *bs,
>>>> +                               BlockFormatAllocInfo *bfai);
>>>> +
>>>>    /* The units of offset and total_work_size may be chosen
>>>> arbitrarily by the
>>>>     * block driver; total_work_size may change during the course of
>>>> the amendment
>>>>     * operation */
>>>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>>>> index 8d3724cce6..458c715e99 100644
>>>> --- a/include/block/block_int.h
>>>> +++ b/include/block/block_int.h
>>>> @@ -208,6 +208,8 @@ struct BlockDriver {
>>>>        int64_t (*bdrv_getlength)(BlockDriverState *bs);
>>>>        bool has_variable_length;
>>>>        int64_t (*bdrv_get_allocated_file_size)(BlockDriverState *bs);
>>>> +    int (*bdrv_get_format_alloc_stat)(BlockDriverState *bs,
>>>> +                                      BlockFormatAllocInfo *bfai);
>>>>          int coroutine_fn
>>>> (*bdrv_co_pwritev_compressed)(BlockDriverState *bs,
>>>>            uint64_t offset, uint64_t bytes, QEMUIOVector *qiov);
>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>> index ea0b3e8b13..fd7b52bd69 100644
>>>> --- a/qapi/block-core.json
>>>> +++ b/qapi/block-core.json
>>>> @@ -139,6 +139,61 @@
>>>>               '*format-specific': 'ImageInfoSpecific' } }
>>>>      ##
>>>> +# @BlockFormatAllocInfo:
>>>> +#
>>> I apologize in advance, but I don't understand this patch very well. Let
>>> me ask some questions to get patch review rolling again, since you've
>>> been waiting a bit.
>>>
>>>> +#
>>>> +# Allocation relations between format file and underlying protocol
>>>> file.
>>>> +# All fields are in bytes.
>>>> +#
>>> The format file in this case would be ... what, the virtual file
>>> represented by the qcow2? and the underlying protocol file is the raw
>>> file that is the qcow2 itself?
>> yes
>>
>>>> +# There are two types of the format file portions: 'used' and
>>>> 'unused'. It's up
>>>> +# to the format how to interpret these types. For now the only
>>>> format supporting
>>>> +# the feature is Qcow2 and for this case 'used' are clusters with
>>>> positive
>>>> +# refcount and unused a clusters with zero refcount. Described
>>>> portions include
>>>> +# all format file allocations, not only virtual disk data (metadata,
>>>> internal
>>>> +# snapshots, etc. are included).
>>> I guess the semantic differentiation between "used" and "unused" is left
>>> to the individual fields, below.
>> hmm, I don't understand. differentiation is up to the format, and for
>> qcow2 it is described above
>>
>>>> +#
>>>> +# For the underlying file there are native block-status types of the
>>>> portions:
>>>> +#  - data: allocated data
>>>> +#  - zero: read-as-zero holes
>>>> +#  - discarded: not allocated
>>>> +# 4th additional type is 'overrun', which is for the format file
>>>> portions beyond
>>>> +# the end of the underlying file.
>>>> +#
>>>> +# So, the fields are:
>>>> +#
>>>> +# @used-data: used by the format file and backed by data in the
>>>> underlying file
>>>> +#
>>> I assume this is "defined and addressable data".
>>>
>>>> +# @used-zero: used by the format file and backed by a hole in the
>>>> underlying
>>>> +#             file
>>>> +#
>>> By a hole? Can you give me an example? Do you mean like a filesystem
>>> hole ala falloc()?
>> -zero, -data and -discarded are the block status of corresponding area
>> in underlying file.
>>
>> so, if underlying file is raw, yes, it should be a filesystem hole.
>>
>> example:
>> -------------------------
>> # ./qemu-img create -f qcow2 x 1G
>> Formatting 'x', fmt=qcow2 size=1073741824 encryption=off
>> cluster_size=65536 lazy_refcounts=off refcount_bits=16
>> # ./qemu-img check x
>> No errors were found on the image.
>> Image end offset: 262144
>> Format allocation info (including metadata):
>>                 data        zero   discarded   after-eof
>> used        192 KiB         0 B         0 B    63.5 KiB
>> unused          0 B         0 B         0 B
> OK, we create a 196624 byte file -- 3 clusters and a little bit of extra.
>
> 0: header
> 1: reftable
> 2: refcount block #0, accounting for clusters 0x0 - 0x7fff
> 3: l1_table, only partially allocated, and all zeroes
>
> So we've got 16 bytes defined for this l1 table, leaving most of a
> cluster defined but after EOF. I suppose your after-EOF counter there is
> probably rounding a bit to the nearest 512.
>
> So we've got three used clusters, and 99% of one cluster that's after
> EOF. Shouldn't data here be 192.5 in this case?
>
> Or Data: 192KiB; Zero 512 b?
>
> I guess the ".5" is just truncated or rounded.
>
>> # ./qemu-io -c 'write 0 100M' x
>> wrote 104857600/104857600 bytes at offset 0
>> 100 MiB, 1 ops; 0.7448 sec (134.263 MiB/sec and 1.3426 ops/sec)
>> # ./qemu-img check x
>> No errors were found on the image.
>> 1600/16384 = 9.77% allocated, 0.00% fragmented, 0.00% compressed clusters
>> Image end offset: 105185280
>> Format allocation info (including metadata):
>>                 data        zero   discarded   after-eof
>> used        100 MiB      60 KiB         0 B         0 B
>> unused          0 B         0 B         0 B
> Hmm, okay;
>
> now the image is 105185280 bytes; 102720 KiB; 1,605 clusters.
> 100MiB + 320KiB. Again, it doesn't entirely look like your summaries
> line up. Did we lose 256KiB to a rounding error under "100MiB" ?
>
>  From what I can now tell, the map looks like:
>
> == File Map ==
>
> 0x000000000 - 0x00004ffff [Metadata] (5 clusters)
> 0x000050000 - 0x00644ffff [Data] (1600 clusters)
>
> 1600 clusters at 64KiB each gives us 102400KiB / 100MiB of data.
> Then we've got five clusters of metadata (320KiB).
>
> Cluster 0: Header data. Data only occupies the first 512 bytes or so.
> Data: 512b
> Zeroes: 63.5KiB
>
> Cluster 1: Reftable. Data only occupies the first 8 bytes.
> Data: 512b
> Zeroes: 63.5KiB
>
> Cluster 2: Refcount Block #0. There are 0xC8A bytes, 3210/2 1605
> refcounts. Makes sense. That's 7 sectors of data.
> Data: 3.5KiB
> Zeroes: 60.5KiB
>
> Cluster 3: L1 table. One entry for L2 table. Takes 8 bytes.
> Data: 512B
> Zeroes: 63.5KiB
>
> Cluster 4: L2 table. 1,600 entries. Takes 5120 bytes, about 10 sectors.
> Data: 5KiB
> Zeroes: 59KiB
>
> Then clusters 5-1604 contain our data contiguously, the ascii byte 0xcd.
>
>> # ./qemu-io -c 'discard 0 1M' x
>> discard 1048576/1048576 bytes at offset 0
>> 1 MiB, 1 ops; 0.0002 sec (3.970 GiB/sec and 4065.0407 ops/sec)
>> # ./qemu-img check x
>> No errors were found on the image.
>> 1584/16384 = 9.67% allocated, 0.00% fragmented, 0.00% compressed clusters
>> Image end offset: 105185280
>> Format allocation info (including metadata):
>>                 data        zero   discarded   after-eof
>> used       99.3 MiB      60 KiB         0 B         0 B
>> unused          0 B       1 MiB         0 B
>> -------------------------
>>
>> - hmm, 60 KiB, don't know what is it. some preallocation may be..
>>
> x doesn't lose any filesize, but we have 1584 allocated clusters. We
> lost 16, corresponding to the discarded 1M.
>
> Map is now:
>
> 0x000000000 - 0x00004ffff [Metadata] (5 clusters)
> 0x000050000 - 0x00014ffff [Vacant] (16 clusters)
> 0x000150000 - 0x00644ffff [Data] (1584 clusters)
>
> OK.
>
> 0: Header. no change.
> Data: 512b
> Zeroes: 63.5KiB
>
> 1: Reftable. No change.
> Data: 512b
> Zeroes: 63.5KiB
>
> Cluster 2: Almost the same.... ref[5] (i.e. the sixth) through ref[20]
> have been decremented, but everything else remains at refcount of 01.
> Still takes up the same amount of space at the sector granularity level.
> Data: 3.5KiB
> Zeroes: 60.5KiB
>
> Cluster 3: L1 table. No change.
> Data: 512B
> Zeroes: 63.5KiB
>
> Cluster 4: L2 table
> Here, the first 16 data clusters have been modified to zero cluster
> pointers: 0x0000000000000001, everything else remains defined as it was.
> Data: 5KiB
> Zeroes: 59KiB
>
> Clusters 5-20 inclusive: non-zero data now discarded and considered
> unused. 1MiB. makes sense.
>
> Clusters 21-end: non-zero, used data. 1584 clusters; 101376KiB; 99MiB
>
> My Tallies:
>
> Metadata: 10KiB
> Metadata Zeroes: 310KiB
> Undefined Data: 1MiB
> Data: 99MiB
>
> Your Tallies:
> 'used-data': 99.3MiB (101683.2KiB)
> 'used-zeroes': 60KiB
> 'unused-data': 1MiB
>
> Subtracting out the 99MiB of data surely accounted for correctly here;
> you are counting about 0.3MiB + 60KiB of used data for presumably the
> metadata regions; ~367.2KiB.
>
> Looks like your counts are something like:
> metadata: 260KiB (0.25MiB ... ~0.3 with rounding, OK)
> metadata-zeroes: 60KiB
>
> So it's probably just counting what is and isn't zeroes a little less
> aggressively than I am doing. To what extent or how, I don't know. Maybe
> it depends on the underlying filesystem:
>
> jhuston@probe ~> qemu-img map -f raw X
> Offset          Length          Mapped to       File
> 0               0x31000         0               X
> 0x40000         0x10000         0x40000         X
> 0x150000        0x6300000       0x150000        X
>
> Looks like a hole from 0x31000 to 0x40000, 60KiB in the metadata region,
> so that's probably it.
>
> Then there's a hole from 0x50000 to 0x150000, 1MiB, so that's unused data.
>
> Hey, interesting, the discarded data that would be read as zeroes is
> still defined by the QCOW2 schema so that's "unused-zeroes" whereas the
> zero space in the metadata is only counted as such because of the sparse
> gap, so that's used-zero. OK, I think I'm starting to get what these
> numbers mean.
>
>>>> +# @used-discarded: used by the format file but actually unallocated
>>>> in the
>>>> +#                  underlying file
>>>> +#
>>> In what case do we have used data that is discarded/undefined, but not
>>> zero? Shouldn't discarded data be zero...?
>> may be discarded is bad name.. this if for unallocated block status of
>> underlying file.
>>
> Unallocated in what sense, exactly? Do you have an example for qcow2?
> I'm sorry that i still don't quite follow :\
>
>>>> +# @used-overrun: used by the format file beyond the end of the
>>>> underlying file
>>>> +#
>>> When does this occur?
>> I think it shoud be some kind of corruption.
>>
> Alright, let me see if I have this straight...
>
> used-data: Normal data. We are standing on terra-firma.
> used-zero: Data that is defined to be zeroes in some way.
>
> (Does not necessarily include data clusters if they were not actually
> zeroed out, I think. May not include regions that ARE zero, even if they
> are literally zero, because the driver may not especially recognize them
> as such. Anything marked as zero will DEFINITELY be zero, though. Yes?)
>
> used-discarded: I'm not actually sure in this case.
>
> used-overrun: Data that is defined to exist, but appears to fall outside
> of or beyond EOF. Appears to happen with qcow2 metadata before any
> writes occur.
>
> unused-data: Normal data, but not in-use by the schema anywhere. Leaked
> clusters and the like, effectively.
>
> unused-zero: Similar to the above, but definitely zeroes.
>
> unused-discarded: Not really sure.

yes, something like this. again, -data, -zero and -discarded are just 
corresponding to return value of bdrv_get_block_status(bs->file),

if status & BDRV_BLOCK_DATA
    it is  -data
else if status & BDRV_BLOCK_ZERO
    it is -zero (should be holes for raw)
else
    it is -discarded (impossible for raw)
end

>
>>>> +# @unused-data: allocated data in the underlying file not used by
>>>> the format
>>>> +#
>>> I assume this is an allocation gap in qcow2. Unused, but non-zero. Right?
>> or it may be some kind of error or due to underlying fs doesn't maintain
>> holes.
>>
>>>> +# @unused-zero: holes in the underlying file not used by the format
>>>> file
>>>> +#
>>> I assume this is similar to the above -- Unused, but zero.
>> Unused and underlying block status is ZERO. It is a "good" case for
>> unused areas.
>>
>>>> +# @unused-discarded: unallocated areas in the underlying file not
>>>> used by the
>>>> +#                    format file
>>>> +#
>>> Again I am unsure of what discarded but non-zero might mean.
>> looks like for raw format discarded is impossible, but to make a generic
>> tool, let's consider block status = unallocated too.
>>
>>>> +# Note: sum of 6 fields {used,unused}-{data,zero,discarded} is equal
>>>> to the
>>>> +#       length of the underlying file.
>>>> +#
>>>> +# Since: 2.10
>>>> +#
>>>> +##
>>>> +{ 'struct': 'BlockFormatAllocInfo',
>>>> +  'data': {'used-data':        'uint64',
>>>> +           'used-zero':        'uint64',
>>>> +           'used-discarded':   'uint64',
>>>> +           'used-overrun':     'uint64',
>>>> +           'unused-data':      'uint64',
>>>> +           'unused-zero':      'uint64',
>>>> +           'unused-discarded': 'uint64' } }
>>>> +
>>>> +##
>>>>    # @ImageCheck:
>>>>    #
>>>>    # Information about a QEMU image file check
>>>>
>>> Sorry for the dumb questions.
>> Don't worry)
>>
>>> --John
>>

-- 
Best regards,
Vladimir

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ebprk-0003UU-QE
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:43:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ebprf-0004XA-4h
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:43:04 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <b4f7c92c-4690-6b0e-1a24-e320d9a9dace@virtuozzo.com>
References: <cover.1513342045.git.berto@igalia.com>
	<192986ad741749064e855bc67916a11460911992.1513342045.git.berto@igalia.com>
	<b4f7c92c-4690-6b0e-1a24-e320d9a9dace@virtuozzo.com>
Date: Wed, 17 Jan 2018 16:42:56 +0100
Message-ID: <w51inc01ofz.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 16/32] qcow2: Update l2_allocate() to
 support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue 16 Jan 2018 05:52:36 PM CET, Anton Nefedov wrote:
>> @@ -299,42 +300,50 @@ static int l2_allocate(BlockDriverState *bs, int l1_index, uint64_t **table)
>>   
> [..]>
>> -    /* write the l2 table to the file */
>> -    BLKDBG_EVENT(bs->file, BLKDBG_L2_ALLOC_WRITE);
>> +        trace_qcow2_l2_allocate_write_l2(bs, l1_index);
>> +        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
>> +        ret = qcow2_cache_flush(bs, s->l2_table_cache);
>> +        if (ret < 0) {
>> +            goto fail;
>> +        }
>>   
>
> Might be an overoptimization but do we really have to flush each slice
> separately?
> Otherwise a number of write ops will remain the same but at least we
> would bdrv_flush() just once.

You're completely right, I'll fix that.

>>       } else {
>> +        uint64_t new_l2_offset;
>>           /* First allocate a new L2 table (and do COW if needed) */
>> -        ret = l2_allocate(bs, l1_index, &l2_table);
>> +        ret = l2_allocate(bs, l1_index);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>> +
>> +        /* Get the offset of the newly-allocated l2 table */
>> +        new_l2_offset = s->l1_table[l1_index] & L1E_OFFSET_MASK;
>> +        assert(offset_into_cluster(s, new_l2_offset) == 0);
>> +        /* Load the l2 table in memory */
>> +        ret = l2_load(bs, offset, new_l2_offset, &l2_table);
>
> Cosmetic: maybe this l2_load() better be merged with the copied L2 case?
> e.g.
>
>    if (!(l1_table[l1_index] & COPIED))
>      l2_allocate();
>    l2_load();

I'm not sure about that, since there's also the qcow2_free_clusters()
call afterwards, so the final code might be harder to follow.

Berto

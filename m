Received: from eggs.gnu.org ([2001:4830:134:3::10]:45451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evogF-0007Nw-7f
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evogC-0008Pw-3J
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:29:47 -0400
References: <20180313180320.339796-1-vsementsov@virtuozzo.com>
	<20180313180320.339796-12-vsementsov@virtuozzo.com>
	<20180313182208.GM3545@work-vm>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <14ad1e8a-4b08-7707-0a8f-d443c65abb22@virtuozzo.com>
Date: Tue, 13 Mar 2018 21:29:36 +0300
MIME-Version: 1.0
In-Reply-To: <20180313182208.GM3545@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v11 11/13] migration: add postcopy
 migration of dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

13.03.2018 21:22, Dr. David Alan Gilbert wrote:
> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
>> Postcopy migration of dirty bitmaps. Only named dirty bitmaps are migrated.
>>
>> If destination qemu is already containing a dirty bitmap with the same name
>> as a migrated bitmap (for the same node), then, if their granularities are
>> the same the migration will be done, otherwise the error will be generated.
>>
>> If destination qemu doesn't contain such bitmap it will be created.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---

[...]

>> +
>> +static int dirty_bitmap_load_bits(QEMUFile *f, DirtyBitmapLoadState *s)
>> +{
>> +    uint64_t first_byte = qemu_get_be64(f) << BDRV_SECTOR_BITS;
>> +    uint64_t nr_bytes = (uint64_t)qemu_get_be32(f) << BDRV_SECTOR_BITS;
>> +    trace_dirty_bitmap_load_bits_enter(first_byte >> BDRV_SECTOR_BITS,
>> +                                       nr_bytes >> BDRV_SECTOR_BITS);
>> +
>> +    if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
>> +        trace_dirty_bitmap_load_bits_zeroes();
>> +        bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte, nr_bytes,
>> +                                             false);
>> +    } else {
>> +        size_t ret;
>> +        uint8_t *buf;
>> +        uint64_t buf_size = qemu_get_be64(f);
>> +        uint64_t needed_size =
>> +            bdrv_dirty_bitmap_serialization_size(s->bitmap,
>> +                                                 first_byte, nr_bytes);
>> +
>> +        if (needed_size > buf_size ||
>> +            buf_size > QEMU_ALIGN_UP(needed_size, 4 + sizeof(long))
> I think you meant '4 * sizeof(long)';  other than that, from the
> migration side I'm OK, so with that fixed, and someone from the block
> side checking the block code:
>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>

Ohh, yes, 4 * sizeof(long).
Who will finally pull it? Should I respin, or you fix it inflight?

-- 
Best regards,
Vladimir

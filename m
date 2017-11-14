Received: from eggs.gnu.org ([2001:4830:134:3::10]:41293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEdIX-0000yV-5W
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEdIW-00043F-9W
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:38:49 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <b6811e30-abd5-5f91-7b2b-7f10bd7feba5@redhat.com>
References: <20171110203111.7666-1-mreitz@redhat.com>
	<20171110203111.7666-5-mreitz@redhat.com>
	<w511sl0299i.fsf@maestria.local.igalia.com>
	<b6811e30-abd5-5f91-7b2b-7f10bd7feba5@redhat.com>
Date: Tue, 14 Nov 2017 16:38:40 +0100
Message-ID: <w51po8kzx8f.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.11 4/5] qcow2: Add bounds check to
 get_refblock_offset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On Tue 14 Nov 2017 04:27:56 PM CET, Max Reitz wrote:
>>> +static int64_t get_refblock_offset(BlockDriverState *bs, uint64_t offset)
>>> +{
>>> +    BDRVQcow2State *s = bs->opaque;
>>> +    uint32_t index = offset_to_reftable_index(s, offset);
>>> +    int64_t covering_refblock_offset = 0;
>>> +
>>> +    if (index < s->refcount_table_size) {
>>> +        covering_refblock_offset = s->refcount_table[index] & REFT_OFFSET_MASK;
>>> +    }
>>> +    if (!covering_refblock_offset) {
>>> +        qcow2_signal_corruption(bs, true, -1, -1, "Refblock at %#" PRIx64 " is "
>>> +                                "not covered by the refcount structures",
>>> +                                offset);
>>> +        return -EIO;
>>> +    }
>>> +
>>> +    return covering_refblock_offset;
>>> +}
>> 
>> Isn't it simpler to do something like this instead?
>> 
>>    if (index >= s->refcount_table_size) {
>>        qcow2_signal_corruption(...);
>>        return -EIO;
>>    }
>>    return s->refcount_table[index] & REFT_OFFSET_MASK;
>
> But that doesn't cover the case were s->refcount_table[index] &
> REFT_OFFSET_MASK is 0.

Ah, you're right. That would be detected by the qcow2_cache_get() call
though, but it's fine to do the check here as well.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

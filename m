Received: from eggs.gnu.org ([2001:4830:134:3::10]:55282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ewqz9-0001JI-Al
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ewqz8-0006da-Bj
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:09:35 -0400
References: <1520849818-6915-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1520849818-6915-9-git-send-email-anton.nefedov@virtuozzo.com>
	<w51d104p1el.fsf@maestria.local.igalia.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <dcfa7d9b-2efd-dc2d-3e66-0a8d3331ce9e@virtuozzo.com>
Date: Fri, 16 Mar 2018 18:09:22 +0300
MIME-Version: 1.0
In-Reply-To: <w51d104p1el.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 8/9] qcow2: skip writing zero buffers to
 empty COW areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com



On 16/3/2018 4:58 PM, Alberto Garcia wrote:
> On Mon 12 Mar 2018 11:16:57 AM CET, Anton Nefedov wrote:
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2584,6 +2584,8 @@
>>   #
>>   # @cor_write: a write due to copy-on-read (since 2.11)
>>   #
>> +# @cluster_alloc_space: an allocation of a cluster file space (since 2.12)

now it's 2.13 I believe

> 
> That doesn't sound like correct English to me.
> 

how about
   "an allocation of file space for a cluster"

>> +static bool is_unallocated(BlockDriverState *bs, int64_t offset, int64_t bytes)
>> +{
>> +    int64_t nr;
>> +    return !bytes ||
>> +        (!bdrv_is_allocated_above(bs, NULL, offset, bytes, &nr) && nr == bytes);
>> +}
>> +
> 
> Is this really more efficient than the previous is_zero() call ?
> 
> It seems that in both cases the code ends up calling
> bdrv_common_block_status_above().
> 

the difference is that is_allocated passes 'want_zero = 0'.
It hints drivers to skip thorough seeks for zeroes (e.g. file-posix
returns (BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID) right away).
Moreover, bdrv_co_block_status() even skips the check in local_file
unless the protocol driver returned BDRV_BLOCK_RAW.

>> +static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
>> +{
>> +    /* content with false negatives, giving is_allocated() is faster than
>> +     * a proper zero detection with possible actual image seeks, which is
>> +     * performed by is_zero() */
> 
> It took me a bit to understand this sentence, maybe some native English
> speaker can suggest an alternate wording?
> 
>    "is_allocated() is not as accurate as is_zero() and can give us some
>     false negatives, but it is much more efficient so let's use it here"
> 

wording is the hardest part of it all :)
maybe:

   /* This check is designed for optimization shortcut so it must be
    * efficient.
    * Instead of is_zero(), use is_unallocated() as it is faster (but not
    * as accurate and can result in false negatives). */

>> +    return is_unallocated(bs, m->offset + m->cow_start.offset,
>> +                          m->cow_start.nb_bytes) &&
>> +           is_unallocated(bs, m->offset + m->cow_end.offset,
>> +                          m->cow_end.nb_bytes);
>> +}
> 
> Berto
> 

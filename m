Received: from eggs.gnu.org ([2001:4830:134:3::10]:59136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eb9Ni-0006cv-KC
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eb9Nh-000184-Ce
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:21:14 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
References: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1509551048-129830-9-git-send-email-anton.nefedov@virtuozzo.com>
	<w511sirt9ya.fsf@maestria.local.igalia.com>
Message-ID: <c4c78a3f-39c4-fe06-c151-db1e4f9009aa@virtuozzo.com>
Date: Mon, 15 Jan 2018 21:21:01 +0300
MIME-Version: 1.0
In-Reply-To: <w511sirt9ya.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 08/15] qcow2: skip writing zero buffers
 to empty COW areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com, anton.nefedov@virtuozzo.com



On 15/1/2018 6:31 PM, Alberto Garcia wrote:
> On Wed 01 Nov 2017 04:44:01 PM CET, Anton Nefedov wrote:
>> If COW areas of the newly allocated clusters are zeroes on the backing image,
>> efficient bdrv_write_zeroes(flags=BDRV_REQ_ALLOCATE) can be used on the whole
>> cluster instead of writing explicit zero buffers later in perform_cow().
>>
>> iotest 060:
>> write to the discarded cluster does not trigger COW anymore.
>> so, break on write_aio event instead, will work for the test
>> (but write won't fail anymore, so update reference output)
>>
>> iotest 066:
>> cluster-alignment areas that were not really COWed are now detected
>> as zeroes, hence the initial write has to be exactly the same size for
>> the maps to match
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>   block/qcow2.h              |  6 +++++
>>   block/qcow2-cluster.c      |  3 ++-
>>   block/qcow2.c              | 67 ++++++++++++++++++++++++++++++++++++++++++++--
>>   block/trace-events         |  1 +
>>   tests/qemu-iotests/060     |  2 +-
>>   tests/qemu-iotests/060.out |  3 ++-
>>   tests/qemu-iotests/066     |  2 +-
>>   tests/qemu-iotests/066.out |  4 +--
>>   8 files changed, 80 insertions(+), 8 deletions(-)
>>
>> diff --git a/block/qcow2.h b/block/qcow2.h
>> index 782a206..e312e48 100644
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -377,6 +377,12 @@ typedef struct QCowL2Meta
>>       Qcow2COWRegion cow_end;
>>   
>>       /**
>> +     * Indicates that both COW areas are empty (nb_bytes == 0)
>> +     * or filled with zeroes and do not require any more copying
>> +     */
>> +    bool zero_cow;
> 
> I think the terminology elsewhere is "COW regions".
> 

Hi Berto! thanks much for checking this series

Will fix 'areas' to 'regions'

> Also, in this patch that field doesn't really seem to track the case
> where both regions have nb_bytes == 0, or does it? It seems to be
> checked separately in all cases.
> 
> Example:
> 
>> -    if (start->nb_bytes == 0 && end->nb_bytes == 0) {
>> +    if ((start->nb_bytes == 0 && end->nb_bytes == 0) || m->zero_cow) {
>>           return 0;
>>       }
> 
> Here, 'if (m->zero_cow)' would suffice.
> 

The thing is, zero_cow is not assigned on some code paths,
e.g. !(bs->file->bs->supported_zero_flags & BDRV_REQ_ALLOCATE)
or when bs->encrypted.

but now thinking about this again; probably it should be - that will be
least confusing. I'll fix


>> +        /* If both COW regions are zeroes already, skip this too */
>> +        if (m->zero_cow) {
>> +            continue;
>> +        }
> 
> Same as above
> 

Yep.

>> +static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
>> +{
>> +    if (bs->encrypted) {
>> +        return false;
>> +    }
>> +
>> +    if (m->cow_start.nb_bytes != 0 &&
>> +        !is_zero(bs, m->offset + m->cow_start.offset, m->cow_start.nb_bytes))
>> +    {
>> +        return false;
>> +    }
>> +
>> +    if (m->cow_end.nb_bytes != 0 &&
>> +        !is_zero(bs, m->offset + m->cow_end.offset, m->cow_end.nb_bytes))
>> +    {
>> +        return false;
>> +    }
> 
> Why do you need to check that nb_bytes != 0? Doesn't is_zero() do that
> already?
> 

I really don't; I think previously is_zero() didn't have that check
and I didn't notice it introduced during a rebase.

Will fix

> Berto
> 

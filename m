Received: from eggs.gnu.org ([2001:4830:134:3::10]:57275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1db0aY-00041V-RN
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1db0aT-0007bl-OW
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:25:38 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:26510 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1db0aT-0007a2-7b
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:25:33 -0400
References: <20170606162652.112122-1-vsementsov@virtuozzo.com>
	<20170606162652.112122-2-vsementsov@virtuozzo.com>
	<50f19b1d-9736-b8b3-5616-67c3393336f3@redhat.com>
	<7c610bc7-a4f7-e6d6-2464-7bbb1b24002b@virtuozzo.com>
	<26ba2b60-5135-d509-b3bc-392152a8bf0a@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9aca0fd4-2916-2d41-8070-f53ae64f9357@virtuozzo.com>
Date: Fri, 28 Jul 2017 11:25:18 +0300
MIME-Version: 1.0
In-Reply-To: <26ba2b60-5135-d509-b3bc-392152a8bf0a@redhat.com>
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

28.07.2017 00:23, John Snow wrote:
>
>
> On 07/12/2017 11:18 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 30.06.2017 03:27, John Snow wrote:
>>>
>>> On 06/06/2017 12:26 PM, Vladimir Sementsov-Ogievskiy wrote:
>>>> The function should collect statistics, about used/unused by top-level
>>>> format driver space (in its .file) and allocation status
>>>> (data/zero/discarded/after-eof) of corresponding areas in this .file.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>   block.c                   | 16 ++++++++++++++
>>>>   include/block/block.h     |  3 +++
>>>>   include/block/block_int.h |  2 ++
>>>>   qapi/block-core.json      | 55 
>>>> +++++++++++++++++++++++++++++++++++++++++++++++
>>>>   4 files changed, 76 insertions(+)
>>>>
>>>> diff --git a/block.c b/block.c
>>>> index 50ba264143..7d720ae0c2 100644
>>>> --- a/block.c
>>>> +++ b/block.c
>>>> @@ -3407,6 +3407,22 @@ int64_t 
>>>> bdrv_get_allocated_file_size(BlockDriverState *bs)
>>>>   }
>>>>   /**
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
>>>>    * Return number of sectors on success, -errno on error.
>>>>    */
>>>>   int64_t bdrv_nb_sectors(BlockDriverState *bs)
>>>> diff --git a/include/block/block.h b/include/block/block.h
>>>> index 9b355e92d8..646376a772 100644
>>>> --- a/include/block/block.h
>>>> +++ b/include/block/block.h
>>>> @@ -335,6 +335,9 @@ typedef enum {
>>>>   int bdrv_check(BlockDriverState *bs, BdrvCheckResult *res, 
>>>> BdrvCheckMode fix);
>>>> +int bdrv_get_format_alloc_stat(BlockDriverState *bs,
>>>> +                               BlockFormatAllocInfo *bfai);
>>>> +
>>>>   /* The units of offset and total_work_size may be chosen 
>>>> arbitrarily by the
>>>>    * block driver; total_work_size may change during the course of 
>>>> the amendment
>>>>    * operation */
>>>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>>>> index 8d3724cce6..458c715e99 100644
>>>> --- a/include/block/block_int.h
>>>> +++ b/include/block/block_int.h
>>>> @@ -208,6 +208,8 @@ struct BlockDriver {
>>>>       int64_t (*bdrv_getlength)(BlockDriverState *bs);
>>>>       bool has_variable_length;
>>>>       int64_t (*bdrv_get_allocated_file_size)(BlockDriverState *bs);
>>>> +    int (*bdrv_get_format_alloc_stat)(BlockDriverState *bs,
>>>> +                                      BlockFormatAllocInfo *bfai);
>>>>       int coroutine_fn 
>>>> (*bdrv_co_pwritev_compressed)(BlockDriverState *bs,
>>>>           uint64_t offset, uint64_t bytes, QEMUIOVector *qiov);
>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>> index ea0b3e8b13..fd7b52bd69 100644
>>>> --- a/qapi/block-core.json
>>>> +++ b/qapi/block-core.json
>>>> @@ -139,6 +139,61 @@
>>>>              '*format-specific': 'ImageInfoSpecific' } }
>>>>   ##
>>>> +# @BlockFormatAllocInfo:
>>>> +#
>>>> +#
>>>> +# Allocation relations between format file and underlying protocol 
>>>> file.
>>>> +# All fields are in bytes.
>>>> +#
>>> I guess this is a relation in the sense that the format differentiates
>>> between used-unused and the protocol differentiates between
>>> data-zero-trim which gives us the 2D matrix, showing a relation between
>>> "two" files.
>>>
>>> I find the use of the word "file" here a bit of a misdirection, though,
>>> as qcow2 (or any other format) in this sense is not a file but rather a
>>> schema used for interpreting data, and the file itself belongs 
>>> solely to
>>> the protocol.
>>>
>>> I might suggest phrasing this as ...
>>>
>>> "Allocation information of an underlying protocol file, as partitioned
>>> by a format driver's utilization of said allocations."
>>>
>>> Maybe that's too wordy. Eric?
>>>
>>>> +# There are two types of the format file portions: 'used' and 
>>>> 'unused'. It's up
>>>> +# to the format how to interpret these types. For now the only 
>>>> format supporting
>>> "format file" seems misleading for similar reasons to my objection
>>> above, which is that the format doesn't have a file, exactly. It's an
>>> abstract schema.
>>>
>>> "It's up to the format how to interpret these types" is also a bit too
>>> vague to help inform readers what the types mean, IMO.
>>>
>>> Here's an attempt:
>>>
>>> "Allocations may be considered either used or unused by the format
>>> driver interpreting those allocations. It is at the discretion of the
>>> format driver (e.g. qcow2) which regions of its backing storage are
>>> considered in-use or not."
>>
>> So we are saying about "allocations". But unallocated data may be 
>> used/unused too, so,
>> can we call unallocated areas "allocations"?
>>
>
> You're right, "allocation" may imply something that is extant, but 
> these are more like regions ...
>
> Uh;
>
> "Regions" may be considered either used or unused?
>
> or
>
> "Regions of the underlying protocol file may be considered used or 
> unused by the format driver interpreting these regions."
>
> Something along these lines, perhaps?

This is OK I think.



-- 
Best regards,
Vladimir

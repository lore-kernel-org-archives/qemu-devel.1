Received: from eggs.gnu.org ([2001:4830:134:3::10]:40145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eFH30-0005Ga-TN
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eFH2w-0008El-SM
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:05:26 -0500
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510654613-47868-4-git-send-email-anton.nefedov@virtuozzo.com>
	<be9e3518-cca4-18b8-d56b-8e574fd782da@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <cdff6baa-ef4a-c0e5-3274-29075a58c0fa@virtuozzo.com>
Date: Thu, 16 Nov 2017 13:05:09 +0300
MIME-Version: 1.0
In-Reply-To: <be9e3518-cca4-18b8-d56b-8e574fd782da@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] block: support compressed write for
 copy-on-read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com


On 15/11/2017 9:49 PM, Max Reitz wrote:
> On 2017-11-14 11:16, Anton Nefedov wrote:
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>   block/io.c         | 30 ++++++++++++++++++++++++------
>>   block/trace-events |  2 +-
>>   2 files changed, 25 insertions(+), 7 deletions(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index 3d5ef2c..93c6b24 100644
>> --- a/block/io.c
>> +++ b/block/io.c
> 
> [...]
> 
>> @@ -1209,6 +1220,13 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
>>           return ret;
>>       }
>>   
>> +    /* write compressed only makes sense with copy on read */
>> +    if ((flags & BDRV_REQ_WRITE_COMPRESSED) &&
>> +        !(flags & BDRV_REQ_COPY_ON_READ))
>> +    {
>> +        return -EINVAL;
>> +    }
>> +
> 
> I think the assertion in bdrv_aligned_preadv() should be enough, but
> either way:
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 

Ok, and it will fail more loudly. Will remove.

>>       bdrv_inc_in_flight(bs);
>>   
>>       /* Don't do copy-on-read if we read data before write operation */
> 

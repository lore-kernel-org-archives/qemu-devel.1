Received: from eggs.gnu.org ([2001:4830:134:3::10]:47536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fk6YH-0005UV-C0
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 07:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fk6YG-0001Bf-Kw
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 07:41:25 -0400
References: <20180729212744.23709-1-lbloch@janustech.com>
	<20180729212744.23709-5-lbloch@janustech.com>
	<20180730094320.GB3775@localhost.localdomain>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <8d1a2a16-6fa6-1318-d278-ff0c8b45a6f5@janustech.com>
Date: Mon, 30 Jul 2018 14:41:02 +0300
MIME-Version: 1.0
In-Reply-To: <20180730094320.GB3775@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] qcow2: Update total_sectors when
 resizing the image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On 07/30/2018 12:43 PM, Kevin Wolf wrote:
> Am 29.07.2018 um 23:27 hat Leonid Bloch geschrieben:
>> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
>> ---
>>   block/qcow2.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index ec9e6238a0..223d351e40 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -3646,6 +3646,8 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>>           }
>>       }
>>   
>> +    bs->total_sectors = offset / 512;
>> +
>>       /* write updated header.size */
>>       offset = cpu_to_be64(offset);
>>       ret = bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, size),
> 
> This shouldn't be necessary, bdrv_co_truncate() already updates
> bs->total_sectors after calling the block driver.

It looks like without it the cache resize works only on the second resize.

> If this is needed by one of the following patches, we need a comment
> that explains why this seemingly superfluous assignment is actually
> necessary.
> 
> Also, 512 should be BDRV_SECTOR_SIZE.

I was surprised that it's not, but it's 512 also in two other places, 
including in qcow2_co_truncate itself. So I decided to keep that. 
Probably would be better if I'd repair it in the other places instead. :)

Thanks!
Leonid.

> Kevin
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1egUpM-0003jt-2N
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 07:16:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1egUpL-0000TC-2k
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 07:15:52 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-2-git-send-email-anton.nefedov@virtuozzo.com>
	<3f0a7d0a-cc3b-7d24-8539-74271c7b956d@redhat.com>
	<563acc14-1b0a-94d5-a12a-67640929e1ec@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <f591d261-108e-9e35-f021-b5934c278b23@virtuozzo.com>
Date: Tue, 30 Jan 2018 15:15:37 +0300
MIME-Version: 1.0
In-Reply-To: <563acc14-1b0a-94d5-a12a-67640929e1ec@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 1/9] mirror: inherit supported
 write/zero flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, den@virtuozzo.com, berto@igalia.com



On 29/1/2018 10:26 PM, Eric Blake wrote:
> On 01/29/2018 01:21 PM, Max Reitz wrote:
>> On 2018-01-18 18:48, Anton Nefedov wrote:
>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>>> ---
>>>   block/mirror.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/block/mirror.c b/block/mirror.c
>>> index c9badc1..d18ec65 100644
>>> --- a/block/mirror.c
>>> +++ b/block/mirror.c
>>> @@ -1064,6 +1064,11 @@ static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
>>>       bdrv_refresh_filename(bs->backing->bs);
>>>       pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
>>>               bs->backing->bs->filename);
>>> +    bs->supported_write_flags = BDRV_REQ_FUA &
>>> +        bs->backing->bs->supported_write_flags;
>>> +    bs->supported_zero_flags =
>>> +        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
>>> +        bs->backing->bs->supported_zero_flags;
>>>   }
>>>   
>>>   static void bdrv_mirror_top_close(BlockDriverState *bs)
>>
>> Fundamentally OK, but why is this in *_refresh_filename()?
> 
> Indeed, I missed that (or maybe it got moved during a botched rebase?).
> For comparison, blkdebug sets it during blkdebug_open(), and nbd sets it
> during nbd_client_init() (called during nbd_open()).
> 

We need a backing bs here and I believe it's not generally set at the 
time of .bdrv_open()

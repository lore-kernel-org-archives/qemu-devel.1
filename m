Received: from eggs.gnu.org ([2001:4830:134:3::10]:35736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fUwTk-0005mu-4T
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fUwTj-0001kv-7l
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:54:04 -0400
References: <1528461148-17925-1-git-send-email-ari@tuxera.com>
	<1528461148-17925-11-git-send-email-ari@tuxera.com>
	<w51d0wop0mr.fsf@maestria.local.igalia.com>
From: Ari Sundholm <ari@tuxera.com>
Message-ID: <911c007b-063f-d8ce-a8cb-618fee0eed27@tuxera.com>
Date: Mon, 18 Jun 2018 18:53:50 +0300
MIME-Version: 1.0
In-Reply-To: <w51d0wop0mr.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 10/10] block/blklogwrites:
 Use the block device logical sector size when logging writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:blklogwrites" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 06/18/2018 06:36 PM, Alberto Garcia wrote:
> On Fri 08 Jun 2018 02:32:28 PM CEST, Ari Sundholm wrote:
>> The guest OS may perform writes which are aligned to the logical
>> sector size instead of the physical one, so logging at this granularity
>> records the writes performed on the block device most faithfully.
>>
>> Signed-off-by: Ari Sundholm <ari@tuxera.com>
>> ---
>>   block/blklogwrites.c | 47 ++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 32 insertions(+), 15 deletions(-)
>>
>> diff --git a/block/blklogwrites.c b/block/blklogwrites.c
>> index 216367f..decf5e5 100644
>> --- a/block/blklogwrites.c
>> +++ b/block/blklogwrites.c
>> @@ -47,6 +47,8 @@ struct log_write_entry {
>>   
>>   typedef struct {
>>       BdrvChild *log_file;
>> +    uint32_t sectorsize;
>> +    uint32_t sectorbits;
>>       uint64_t cur_log_sector;
>>       uint64_t nr_entries;
>>   } BDRVBlkLogWritesState;
>> @@ -67,6 +69,8 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
>>           goto fail;
>>       }
>>   
>> +    s->sectorsize = BDRV_SECTOR_SIZE; /* May be updated later */
>> +    s->sectorbits = BDRV_SECTOR_BITS;
>>       s->cur_log_sector = 1;
>>       s->nr_entries = 0;
> 
> I haven't looked closely into this series so sorry if there's something
> that I'm overlooking, but this caught my attention: why do you have a
> patch that improves a driver that you introduced earlier in this same
> series?
> 

I guess there is no other real reason than that it reflects the 
development history of the driver more closely: the code by the original 
author did not contain proper support for non-512 sector sizes. I then 
added the parts needed for this.

The series could be restructured in the following manner if that makes 
it more reviewable (prerequisites first, then the entire driver):
- Patch 1: as before
- Patches 2-7: introduction of the mechanism to pass block 
configurations to drivers + changes to block device implementations to 
make them pass on this information (current patches 3-8)
- Patch 8: Introduction of the blklogwrites driver (current patches 2, 9 
and 10, squashed)

Does that sound like a good idea?

> Berto
> 

Thank you,
Ari Sundholm
ari@tuxera.com

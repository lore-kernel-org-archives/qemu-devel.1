Received: from eggs.gnu.org ([2001:4830:134:3::10]:35675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ely8I-0005bC-HS
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:34:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ely8F-000539-E6
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:34:02 -0500
References: <20180213202701.15858-1-eblake@redhat.com>
	<20180213202701.15858-9-eblake@redhat.com>
	<20180214115312.GA4766@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1301339a-7d74-3deb-0f9c-b765951aa546@redhat.com>
Date: Wed, 14 Feb 2018 08:33:30 -0600
MIME-Version: 1.0
In-Reply-To: <20180214115312.GA4766@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 08/21] iscsi: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>

On 02/14/2018 05:53 AM, Kevin Wolf wrote:
> Am 13.02.2018 um 21:26 hat Eric Blake geschrieben:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.  Update the iscsi driver accordingly.  In this case,
>> it is handy to teach iscsi_co_block_status() to handle a NULL map
>> and file parameter, even though the block layer passes non-NULL
>> values, because we also call the function directly.  For now, there
>> are no optimizations done based on the want_zero flag.

[1]

>>
>> We can also make the simplification of asserting that the block
>> layer passed in aligned values.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>

>>       /* default to all sectors allocated */
>> -    ret = BDRV_BLOCK_DATA;
>> -    ret |= (sector_num << BDRV_SECTOR_BITS) | BDRV_BLOCK_OFFSET_VALID;
>> -    *pnum = nb_sectors;
>> +    ret = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
>> +    if (map) {
>> +        *map = offset;
>> +    }
> 
> Can map ever be NULL? You didn't have that check in other drivers.

The documentation in block_int.h states that io.c never passes NULL for 
map.  However, see my commit message [1], and the code below [2], for 
why THIS driver has to check for NULL.


>> @@ -760,7 +758,7 @@ out:
>>       if (iTask.task != NULL) {
>>           scsi_free_scsi_task(iTask.task);
>>       }
>> -    if (ret > 0 && ret & BDRV_BLOCK_OFFSET_VALID) {
>> +    if (ret > 0 && ret & BDRV_BLOCK_OFFSET_VALID && file) {
>>           *file = bs;
>>       }
> 
> Can file ever be NULL?

Ditto.

> 
>>       return ret;
>> @@ -800,25 +798,24 @@ static int coroutine_fn iscsi_co_readv(BlockDriverState *bs,
>>                                    nb_sectors * BDRV_SECTOR_SIZE) &&
> 
> No iscsi_co_preadv() yet... :-(

Yeah, but that's for another day.

> 
>>           !iscsi_allocmap_is_allocated(iscsilun, sector_num * BDRV_SECTOR_SIZE,
>>                                        nb_sectors * BDRV_SECTOR_SIZE)) {
>> -        int pnum;
>> -        BlockDriverState *file;
>> +        int64_t pnum;
>>           /* check the block status from the beginning of the cluster
>>            * containing the start sector */
>> -        int cluster_sectors = iscsilun->cluster_size >> BDRV_SECTOR_BITS;
>> -        int head;
>> -        int64_t ret;
>> +        int64_t head;
>> +        int ret;
>>
>> -        assert(cluster_sectors);
>> -        head = sector_num % cluster_sectors;
>> -        ret = iscsi_co_get_block_status(bs, sector_num - head,
>> -                                        BDRV_REQUEST_MAX_SECTORS, &pnum,
>> -                                        &file);
>> +        assert(iscsilun->cluster_size);
>> +        head = (sector_num * BDRV_SECTOR_SIZE) % iscsilun->cluster_size;
>> +        ret = iscsi_co_block_status(bs, false,
>> +                                    sector_num * BDRV_SECTOR_SIZE - head,
>> +                                    BDRV_REQUEST_MAX_BYTES, &pnum, NULL, NULL);
> 

[2] This is the reason that THIS driver has to check for NULL, even 
though the block layer never passes NULL.

> It doesn't make a difference with your current implementation because it
> ignores want_zero, but consistent with your approach that
> want_zero=false returns just that everyhting is allocated for drivers
> without support for backing files, I think you want want_zero=true here.

Makes sense.  If that's the only tweak, can you make it while taking the 
series, or will I need to respin?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

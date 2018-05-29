Received: from eggs.gnu.org ([2001:4830:134:3::10]:45890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNgAH-0002Ek-Kb
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNgAG-0007AT-KM
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:03:57 -0400
References: <20180425183223.580566-1-eblake@redhat.com>
	<20180425183223.580566-4-eblake@redhat.com>
	<20180528110426.GE4580@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a37ef177-a4cf-c7b2-1846-a50f965d3af9@redhat.com>
Date: Tue, 29 May 2018 10:03:47 -0500
MIME-Version: 1.0
In-Reply-To: <20180528110426.GE4580@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/8] qcow: Switch qcow_co_readv to
 byte-based calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:qcow" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 05/28/2018 06:04 AM, Kevin Wolf wrote:
> Am 25.04.2018 um 20:32 hat Eric Blake geschrieben:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.  Make the change for the internals of the qcow
>> driver read function, by iterating over offset/bytes instead of
>> sector_num/nb_sectors, and repurposing index_in_cluster and n
>> to be bytes instead of sectors.
>>
>> A later patch will then switch the qcow driver as a whole over
>> to byte-based operation.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   block/qcow.c | 39 +++++++++++++++++++--------------------
>>   1 file changed, 19 insertions(+), 20 deletions(-)
>>
>> diff --git a/block/qcow.c b/block/qcow.c
>> index 32730a8dd91..bf9d80fd227 100644
>> --- a/block/qcow.c
>> +++ b/block/qcow.c
>> @@ -623,6 +623,8 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
>>       QEMUIOVector hd_qiov;
>>       uint8_t *buf;
>>       void *orig_buf;
>> +    int64_t offset = sector_num << BDRV_SECTOR_BITS;
>> +    int64_t bytes = nb_sectors << BDRV_SECTOR_BITS;
> 
> This should be okay because nb_sectors is limited to INT_MAX / 512, but
> I wouldn't be surprised if Coverity complained about a possible
> truncation here. Multiplying with BDRV_SECTOR_SIZE instead wouldn't be
> any less readable and would avoid the problem.

Sure, will fix.

> 
>>       if (qiov->niov > 1) {
>>           buf = orig_buf = qemu_try_blockalign(bs, qiov->size);
>> @@ -636,36 +638,36 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
>>
>>       qemu_co_mutex_lock(&s->lock);
>>
>> -    while (nb_sectors != 0) {
>> +    while (bytes != 0) {
>>           /* prepare next request */
>> -        ret = get_cluster_offset(bs, sector_num << 9,
>> +        ret = get_cluster_offset(bs, offset,
>>                                    0, 0, 0, 0, &cluster_offset);
> 
> This surely fits in a single line now?
> 
>>           if (ret < 0) {
>>               break;
>>           }
>> -        index_in_cluster = sector_num & (s->cluster_sectors - 1);
>> -        n = s->cluster_sectors - index_in_cluster;
>> -        if (n > nb_sectors) {
>> -            n = nb_sectors;
>> +        index_in_cluster = offset & (s->cluster_size - 1);
>> +        n = s->cluster_size - index_in_cluster;
>> +        if (n > bytes) {
>> +            n = bytes;
>>           }
> 
> "index" suggests that it refers to an object larger than a byte. qcow2
> renamed the variable to offset_in_cluster when the same change was made.
> A new name for a unit change would also make review a bit easier.

Will fix.

> 
> The logic looks correct, though.
> 
> Kevin
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

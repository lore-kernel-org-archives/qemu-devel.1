Received: from eggs.gnu.org ([2001:4830:134:3::10]:57163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gACah-0005zS-CC
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gACac-0006t2-Hy
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:23:47 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1fee9736-1e83-39bb-d0d6-7af09c6f73df@redhat.com>
References: <cover.1537367701.git.berto@igalia.com>
	<95addb261af316f49517069e1cce4d9c601d274b.1537367701.git.berto@igalia.com>
	<1fee9736-1e83-39bb-d0d6-7af09c6f73df@redhat.com>
Date: Wed, 10 Oct 2018 13:23:03 +0200
Message-ID: <w51lg76nizs.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 12/14] block: Clean up
 reopen_backing_file() in block/replication.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>

On Mon 08 Oct 2018 04:34:24 AM CEST, Max Reitz wrote:
>> This patch does the following changes:
>> 
>>   - Use an options QDict with the "read-only" option instead of
>>     passing the changes as flags only.
>> 
>>   - Simplify the code (it was unnecessarily complicated and verbose).
>> 
>>   - Fix a bug due to which the secondary disk was not being put back
>>     in read-only mode when writable=false (because in this case
>>     orig_secondary_flags always had the BDRV_O_RDWR flag set).
>> 
>>   - Stop clearing the BDRV_O_INACTIVE flag.
>
> Why?  Sorry, but I don't know much about replication.  Do you know
> this change is OK?  (Since the code deliberately clears it right now.)

I don't think the current code is ok, the BDRV_O_INACTIVE flag should be
cleared with bdrv_co_invalidate_cache() so I'm inclined to think that
it's a bug.

>> @@ -376,39 +377,32 @@ static void reopen_backing_file(BlockDriverState *bs, bool writable,
>>  {
>>      BDRVReplicationState *s = bs->opaque;
>>      BlockReopenQueue *reopen_queue = NULL;
>> -    int orig_hidden_flags, orig_secondary_flags;
>> -    int new_hidden_flags, new_secondary_flags;
>>      Error *local_err = NULL;
>>  
>>      if (writable) {
>
> I'd like to request a comment that "writable" is true the first time
> this function is called, and false the second time.  That'd make it
> clear why this rewrite makes sense.

Yes, I think it's probably a good idea to do that.

>> +        s->orig_hidden_read_only =
>> +            !(bdrv_get_flags(s->hidden_disk->bs) & BDRV_O_RDWR);
>> +        s->orig_secondary_read_only =
>> +            !(bdrv_get_flags(s->secondary_disk->bs) & BDRV_O_RDWR);
>
> Why not use bdrv_is_read_only()?

No reason, I overlooked this. I'll fix it.

Berto

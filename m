Received: from eggs.gnu.org ([2001:4830:134:3::10]:53305)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1eyH6y-0002ae-Mo
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1eyH6t-0000Ei-VS
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:15:32 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:37903 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1eyH6t-0000Cy-Ec
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:15:27 -0400
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:15:20 +0100
From: Peter Lieven <pl@kamp.de>
References: <1520507908-16743-1-git-send-email-pl@kamp.de>
	<1520507908-16743-5-git-send-email-pl@kamp.de>
	<87po4ed953.fsf@secure.laptop>
	<01963940-1438-3d10-8f3b-d400fcb24df9@kamp.de>
Message-ID: <ef8257bd-39d2-6c9d-5228-d37107595e38@kamp.de>
Date: Tue, 20 Mar 2018 14:15:21 +0100
MIME-Version: 1.0
In-Reply-To: <01963940-1438-3d10-8f3b-d400fcb24df9@kamp.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 4/5] migration/block: limit the number of
 parallel I/O requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, dgilbert@redhat.com, famz@redhat.com, stefanha@redhat.com

Am 08.03.2018 um 14:30 schrieb Peter Lieven:
> Am 08.03.2018 um 13:50 schrieb Juan Quintela:
>> Peter Lieven <pl@kamp.de> wrote:
>>> the current implementation submits up to 512 I/O requests in parallel
>>> which is much to high especially for a background task.
>>> This patch adds a maximum limit of 16 I/O requests that can
>>> be submitted in parallel to avoid monopolizing the I/O device.
>>>
>>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> This code is already a mess (TM).  It is difficult to understand what we
>> are doing, so not easy to see if your changes are better/worse than what
>> we have.
>>
>> I am not sure that your solution help to improve things here. Let's see
>> what I understand.
>>
>> We have three fields (without a single comment):
>>
>> - submitted: this is the number of blocks that we have asked the block
>>               device to read asynchronously to main memory, and that
>>               haven't yet read.  I.e. "blocks_read_pending" would be a
>>               better name?
>>
>> - read_done: this is the number of blocks that we have finished read
>>               asynchronously from this block device.  When we finish, we
>>               do a submitted -- and a read_done++. blocks_read_finished
>>               name?
>
> Correct. The names should be adjusted.
>
>>
>> - transferred: This is the number of blocks that we have transferred
>>                 since the beginning of migration.  At this point, we do a
>>                 read_done-- and a transferred++
>>
>> Note also that we do malloc()/free() for each block
>
> Yes, but that is a different story.
>
>>
>> So, now that we have defined what our fields mean, we need to know what
>> is our test.  block_save_pending():
>>
>>      get_remaining_dirty() + (submitted + read_done) * BLOCK_SIZE
>>
>> Looks good.
>>
>> But let's us see what test we do in block_save_iterate() (Yes, I have
>> been very liberal with reformatting and removal of struct names):
>>
>> (submitted + read_done) * BLOCK_SIZE < qemu_file_get_rate_limit(f) &&
>> (submitted + read_done) < MAX_INFLIGHT_IO
>>
>> The idea of that test is to make sure that we _don't send_ through the
>> QEMUFile more than qemu_file_get_rate_limit(f).  But there are several
>> things here:
>> - we have already issued a flush_blks() call before we enter the loop
>>    And it is inside possibility that we have already sent too much data at
>>    this point, but we enter the while loop anyways.
>>
>>    Notice that flush_blks() does the right thing and test in each loop if
>>    qemu_file_rate_limit() has been reached and stops sending more data if
>>    it returns true;
>>
>> - At this point, we *could* have sent all that can be sent for this
>>    round, but we enter the loop anyways.  And we test two things:
>>       - that we haven't read from block devices more than
>>         qemu_file_get_rate_limit() bytes (notice that this is the maximum
>>         that we could put through the migration channel, not really
>>         related  with what we read from block devices).
>>
>>       - that we haven't read in this round more than MAX_INFLIGHT_IO
>>         blocks.  That is 512 blocks, at BLOCK_SIZE bytes is 512MB. Why?
>>         Who knows.
>
> The idea behind this was only to limit the maximum memory that is allocated.
> That was not meant as a rate limit for the storage backend.
>
>>
>> - Now we exit the while loop, and we have pending blocks to send, the
>>      minimum between:
>>         - qemu_file_get_rate_limit()/BLOCK_SIZE, and
>>         - MAX_INFLIGHT_IO
>>
>> But not all of them are ready to send, only "read_done" blocks are
>> ready, the "submitted" ones are still waiting for read completion.
>
> Thats what I tried to address in patch 5.
>
>>
>> And we call back flush_blks() that will try to send all the "read_done"
>> blocks through the migration channel until we hit
>> qemu_file_rate_limit().
>>
>> So, looking at the problem from far away:
>>
>> - how many read requests are we have to have in flight at any moment, is
>>    that 16 from this series the right number? Notice that each request
>>    are 1MB, so this is 16MB (I have no clue what is the right value).
>
> I choosed that value because it helped to improved the stalls in the
> guest that I have been seeing. Stefan also said that 16 would be a good
> value for a background task. 512 is definetly too much.
>
>>
>> - how many blocks should we get on each round.  Notice that the reason
>>    for the 1st patch on this series is because the block layer is not
>>    sending enough blocks to prevent ram migration to start.  If there are
>>    enough dirty memory sent from the block layer, we shouldn't ever enter
>>    the ram stage.
>>    Notice how we register them in vl.c:
>>
>>      blk_mig_init();
>>      ram_mig_init();
>
> The idea of the 1st patch was to skip ram migration until we have completed
> the first round of block migration (aka bulk phase) as this will take a long time.
> After that we are only doing incremental updates. You are right this might still
> be too early, but it to start after the bulk phase was an easy choice without
> introducing another heuristic.
>
>>
>> So, after so long mail, do I have some suggestion?
>>
>> - should we make the MAX_PARALLEL_IO autotunig?  i.e. if we are not
>>    being able to get qemu_file_get_rate_limit()/BLOCK_SIZE read_blocks by
>>    iteration, we should increase MAX_PARALLEL_IO limit?
>
> We should not, if the bandwidth of the migration stream is high we would again
> monipolize the I/O device and get stalls in guest I/O.
>
>>
>> - should we "take" into account how many blocks have transferred the 1st
>>    call to flush_blks() and only wait for "read_blocks" until
>>    flush_blks() instead of for the whole set?
>
> We still have to avoid that we have too much parallel I/O. But I was also thinking that
> we need a time limit (as the ram migration has). We might sit in the while loop until
> 512MB have read if we have a fast source storage and a high migration bandwidth
> so that we never reach the rate limit.
>
> Peter

Hi,

any idea how we can continue with this? I can prepare a new series with a patch that adjusts
the naming of the variables and hope this makes things clearer.

Thanks,
Peter

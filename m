Received: from eggs.gnu.org ([2001:4830:134:3::10]:46598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGlG0-0003fb-5C
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 08:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGlFv-0003aC-6H
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 08:00:44 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:36658 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dGlFu-0003Yc-Q5
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 08:00:39 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20170531165541.47338-1-vsementsov@virtuozzo.com>
	<20170531165541.47338-2-vsementsov@virtuozzo.com>
	<70aa332e-c868-15ac-0c4c-23d41a777b6c@redhat.com>
	<76a74826-f9ed-825e-0d3d-3043943d636c@virtuozzo.com>
Message-ID: <8e900b35-65a9-789f-2cf4-9de6d16460a3@virtuozzo.com>
Date: Fri, 2 Jun 2017 15:00:34 +0300
MIME-Version: 1.0
In-Reply-To: <76a74826-f9ed-825e-0d3d-3043943d636c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 01/12] nbd: rename read_sync and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

01.06.2017 11:03, Sementsov-Ogievskiy Vladimir wrote:
>
>
> On 31.05.2017 21:46, Eric Blake wrote:
>> On 05/31/2017 11:55 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Rename
>>>    nbd_wr_syncv -> nbd_rwv
>>>    read_sync -> nbd_read
>>>    read_sync_eof -> nbd_read_eof
>>>    write_sync -> nbd_write
>>>    drop_sync -> nbd_drop
>>>
>>> 1. nbd_ prefix
>>>     read_sync and write_sync are already shared, so it is good to 
>>> have a
>>>     namespace prefix. drop_sync will be shared, and read_sync_eof is
>>>     related to read_sync, so let's rename them all.
>>>
>>> 2. _sync suffix
>>>     _sync is related to the fact, that nbd_wr_syncv doesn't return if
>> s/fact,/fact/
>>
>>>     write to socket returns EAGAIN. In first implementation 
>>> nbd_wr_syncv
>>>     just loops while getting EAGAIN, current implementation yields in
>>>     this case.
>> As mentioned in your followup, you may want to rewrite this to:
>>
>> _sync was originally used (back in commit 7a5ca864 when it was named
>> wr_sync) to indicate that we looped rather than returned on EAGAIN.  But
>> now we use qio_channel which yields on our behalf rather than giving us
>> EAGAIN.
>
> hmm, I like my wording (with adding note "... implementaion 
> nbd_wr_syncv (was wr_sync in 7a5ca8648b) just ...")  more, because:
> 1. not only nbd_wr_syncv has that suffix, so nbd_wr_syncv should be 
> mentioned (as we mention wr_sync)
> 2. I don't say about contrast between old and current, I say that they 
> are similar.
>

Finally, are you OK with my wording? If I reroll, can I add your r-b?

>
>>
>>>     Why to get rid of it:
>>>     - it is normal for r/w functions to be synchronous, so having
>>>       additional suffix for it looks redundant (contrariwise, we have
>>>       _aio suffix for async functions)
>>>     - _sync suffix in block layer is used when function does flush (so
>>>       using it for other thing is confusing a bit)
>>>     - keep function names short after adding nbd_ prefix
>>>
>>> 3. for nbd_wr_syncv let's use more common notation 'rw'
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>> The maintainer may be willing to tweak the commit message without
>> needing a v2.
>
> I hope for it)
>
>>
>>
>>> +++ b/nbd/nbd-internal.h
>>> @@ -94,14 +94,14 @@
>>>   #define NBD_ENOSPC     28
>>>   #define NBD_ESHUTDOWN  108
>>>   -/* read_sync_eof
>>> +/* nbd_read_eof
>>>    * Tries to read @size bytes from @ioc. Returns number of bytes 
>>> actually read.
>>>    * May return a value >= 0 and < size only on EOF, i.e. when 
>>> iteratively called
>>> - * qio_channel_readv() returns 0. So, there are no needs to call 
>>> read_sync_eof
>>> + * qio_channel_readv() returns 0. So, there are no needs to call 
>>> nbd_read_eof
>> As long as you are touching this:
>>
>> s/are no needs/is no need/
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>

-- 
Best regards,
Vladimir

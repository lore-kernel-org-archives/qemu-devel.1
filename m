Received: from eggs.gnu.org ([2001:4830:134:3::10]:45456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGn2e-0006nI-L3
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGn2a-0004Et-OQ
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:55:04 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:25529 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dGn2a-0004D6-CW
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:55:00 -0400
References: <20170531165541.47338-1-vsementsov@virtuozzo.com>
	<20170531165541.47338-2-vsementsov@virtuozzo.com>
	<70aa332e-c868-15ac-0c4c-23d41a777b6c@redhat.com>
	<76a74826-f9ed-825e-0d3d-3043943d636c@virtuozzo.com>
	<8e900b35-65a9-789f-2cf4-9de6d16460a3@virtuozzo.com>
	<40ed0b31-84b7-380f-65ce-bc79de780c04@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ec8e6b9b-29e5-dc07-17cb-bdcd2ad8fc14@virtuozzo.com>
Date: Fri, 2 Jun 2017 16:54:56 +0300
MIME-Version: 1.0
In-Reply-To: <40ed0b31-84b7-380f-65ce-bc79de780c04@redhat.com>
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

02.06.2017 16:49, Eric Blake wrote:
> On 06/02/2017 07:00 AM, Vladimir Sementsov-Ogievskiy wrote:
>
>>>>> 2. _sync suffix
>>>>>      _sync is related to the fact, that nbd_wr_syncv doesn't return if
>>>> s/fact,/fact/
>>>>
>>>>>      write to socket returns EAGAIN. In first implementation
>>>>> nbd_wr_syncv
>>>>>      just loops while getting EAGAIN, current implementation yields in
>>>>>      this case.
>>>> As mentioned in your followup, you may want to rewrite this to:
>>>>
>>>> _sync was originally used (back in commit 7a5ca864 when it was named
>>>> wr_sync) to indicate that we looped rather than returned on EAGAIN.  But
>>>> now we use qio_channel which yields on our behalf rather than giving us
>>>> EAGAIN.
>>> hmm, I like my wording (with adding note "... implementaion
>>> nbd_wr_syncv (was wr_sync in 7a5ca8648b) just ...")  more, because:
>>> 1. not only nbd_wr_syncv has that suffix, so nbd_wr_syncv should be
>>> mentioned (as we mention wr_sync)
>>> 2. I don't say about contrast between old and current, I say that they
>>> are similar.
>>>
>> Finally, are you OK with my wording? If I reroll, can I add your r-b?
> What final wording are you proposing (full paragraph, not a snippet)?

2. _sync suffix
    _sync is related to the fact that nbd_wr_syncv doesn't return if
    write to socket returns EAGAIN. In first implementation nbd_wr_syncv
    (was wr_sync in 7a5ca8648b) just loops while getting EAGAIN, current
    implementation yields in this case.
    Why to get rid of it:
    - it is normal for r/w functions to be synchronous, so having
      additional suffix for it looks redundant (contrariwise, we have
      _aio suffix for async functions)
    - _sync suffix in block layer is used when function does flush (so
      using it for other thing is confusing a bit)
    - keep function names short after adding nbd_ prefix

>
>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
> At any rate, I already gave R-b for the code, so finessing the commit
> message doesn't change that if the code remains unchanged.
>

-- 
Best regards,
Vladimir

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dG5rv-0002Lf-5Y
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:49:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dG5rr-0004px-3k
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:49:07 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:40930 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dG5rq-0004lL-Ni
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:49:03 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-2-vsementsov@virtuozzo.com>
	<874e184b-3727-3bbc-0169-1073db203736@redhat.com>
	<173a697e-274c-a2a7-63d2-f5dbf93f69e7@virtuozzo.com>
	<e5021317-ec3a-def9-71ea-3dbc947a6e20@redhat.com>
	<24d9876f-a555-773c-5277-af438bc45083@virtuozzo.com>
Message-ID: <1b2c1c3f-e528-4bd0-848e-d3cccef8fc6e@virtuozzo.com>
Date: Wed, 31 May 2017 18:48:59 +0300
MIME-Version: 1.0
In-Reply-To: <24d9876f-a555-773c-5277-af438bc45083@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 01/19] nbd/server: get rid of
 nbd_negotiate_read and friends
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

31.05.2017 17:56, Vladimir Sementsov-Ogievskiy wrote:
> 31.05.2017 17:39, Eric Blake wrote:
>> On 05/31/2017 08:12 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 30.05.2017 23:10, Eric Blake wrote:
>>>> On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Functions nbd_negotiate_{read,write,drop_sync} were introduced in
>>>>> 1a6245a5b, when nbd_wr_syncv was working through qemu_co_sendv_recvv,
>>>> There is no qemu_co_sendv_recvv. Did you mean 
>>>> qemu_co_recv/qemu_co_send?
>>> qemu_co_recv is a macro, qemu_co_sendv_recvv - is an actual function,
>>> which do something.
>> Oh. I see where I went wrong - I was grepping for 'nbd_co_sendv' and
>> coming up short.
>>
>>> #define qemu_co_recv(sockfd, buf, bytes) \
>>>    qemu_co_send_recv(sockfd, buf, bytes, false)
>>>
>>> ssize_t coroutine_fn
>>> qemu_co_send_recv(int sockfd, void *buf, size_t bytes, bool do_send)
>>> {
>>>      struct iovec iov = { .iov_base = buf, .iov_len = bytes };
>>>      return qemu_co_sendv_recvv(sockfd, &iov, 1, 0, bytes, do_send);
>>> }
>> The commit message still makes me chase through several layers of
>> indirection, so I still wonder if referring to qemu_co_recv/qemu_co_send
>
> I'll add a note like "(the path is nbd_wr_sync -> qemu_co_{recv/send} 
> -> qemu_co_send_recv -> qemu_co_sendv_recvv)',
> because I writing that qemu_co_recv yields will be confusing too.
>
>> (which is what is directly used in that older commit for nbd_wr_syncv)
>> is any better.  It is probably also worth referring back to commit
>> ff82911cd as the point in time where we switched to the qio_channel
>> code, thereby no longer needing to manage coroutine handlers quite as
>> directly as beforehand.
>
> OK
>
>>
>>
>>>>> +int drop_sync(QIOChannel *ioc, size_t size, Error **errp)
>>>> As part of moving it into nbd/common.c, please rename this function to
>>>> an nbd_ prefix, since non-static functions are more likely to collide
>>>> with the rest of the code base if not properly named. Better yet: 
>>>> do it
>>>> in multiple patches:
>>>> - rename the static functions and fallout to callers (all of
>>>> nbd_drop_sync, nbd_read_sync, and nbd_write_sync)
>> In fact, does the _sync name buy us anything any more, or can we just go
>> with the shorter nbd_drop(), nbd_read(), and nbd_write()?
>
> OK, good idea.

nbd_wr_syncv shoud be renamed then too.

As I understand, sync here is related to the fact that on EAGAIN from 
socket the function doesn't return. now it is also true (but instead of 
looping the function yields)..

On the other hand, it is normal for r/w functions to by synchronous, so 
having additional suffix for it looks redundant (contrariwise, we have
_aio suffix for async functions).

also, _sync suffix in block layer is used when function does flush (so 
using it for other thing is confusing a bit).
>
>>
>>>> - code motion (promote nbd_drop_sync from static in client.c to 
>>>> exported
>>>> in common.c)
>>>> - drop nbd_negotiate_ functions in favor of common nbd_*_sync 
>>>> functions
>>> OK
>>>
>>>> The idea makes sense, but I think there's too much going on in this 
>>>> one
>>>> commit.
>>>>
>

-- 
Best regards,
Vladimir

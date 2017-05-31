Received: from eggs.gnu.org ([2001:4830:134:3::10]:38145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dG3Qa-0002Xl-7K
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dG3QX-0004ur-Gp
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:12:44 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:43329 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dG3QX-0004tx-4Y
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:12:41 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-2-vsementsov@virtuozzo.com>
	<874e184b-3727-3bbc-0169-1073db203736@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <173a697e-274c-a2a7-63d2-f5dbf93f69e7@virtuozzo.com>
Date: Wed, 31 May 2017 16:12:36 +0300
MIME-Version: 1.0
In-Reply-To: <874e184b-3727-3bbc-0169-1073db203736@redhat.com>
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

30.05.2017 23:10, Eric Blake wrote:
> On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Functions nbd_negotiate_{read,write,drop_sync} were introduced in
>> 1a6245a5b, when nbd_wr_syncv was working through qemu_co_sendv_recvv,
> There is no qemu_co_sendv_recvv. Did you mean qemu_co_recv/qemu_co_send?

qemu_co_recv is a macro, qemu_co_sendv_recvv - is an actual function, 
which do something.

#define qemu_co_recv(sockfd, buf, bytes) \
   qemu_co_send_recv(sockfd, buf, bytes, false)

ssize_t coroutine_fn
qemu_co_send_recv(int sockfd, void *buf, size_t bytes, bool do_send)
{
     struct iovec iov = { .iov_base = buf, .iov_len = bytes };
     return qemu_co_sendv_recvv(sockfd, &iov, 1, 0, bytes, do_send);
}


>
>> which just yields, without setting any handlers. But now, nbd_wr_syncv
>> works through qio_channel_yield() which sets handlers, so watchers
>> are redundant in nbd_negotiate_{read,write,drop_sync}, then, let's just
>> use {read,write,drop}_sync functions.
> Makes sense to me.  Note that I have a pending patch that was also
> related to 1a6245a5, where we introduced an assertion failure (which
> later morphed into a segfault) if a client hangs up really early during
> negotiation:
>
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg06240.html
>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> +++ b/nbd/common.c
>> @@ -69,6 +69,32 @@ ssize_t nbd_wr_syncv(QIOChannel *ioc,
>>       return done;
>>   }
>>   
>> +/* Discard length bytes from channel.  Return -errno on failure and 0 on
>> + * success*/
> Space before */, if you don't mind (yes, I know this was just code
> motion, and that the old spot was wrong).
>
>> +int drop_sync(QIOChannel *ioc, size_t size, Error **errp)
> As part of moving it into nbd/common.c, please rename this function to
> an nbd_ prefix, since non-static functions are more likely to collide
> with the rest of the code base if not properly named.  Better yet: do it
> in multiple patches:
> - rename the static functions and fallout to callers (all of
> nbd_drop_sync, nbd_read_sync, and nbd_write_sync)
> - code motion (promote nbd_drop_sync from static in client.c to exported
> in common.c)
> - drop nbd_negotiate_ functions in favor of common nbd_*_sync functions

OK

>
> The idea makes sense, but I think there's too much going on in this one
> commit.
>

-- 
Best regards,
Vladimir

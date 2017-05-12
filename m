Received: from eggs.gnu.org ([2001:4830:134:3::10]:34107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d9DSz-0001vF-31
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d9DSv-00019F-Le
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:30:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d9DSv-00018R-Ex
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:30:53 -0400
References: <20170512141702.12423-1-vsementsov@virtuozzo.com>
	<8c231084-8eaa-fe66-43cd-4c85f1e45272@redhat.com>
	<005ea4a3-6565-6a56-75de-b6464bcae8fd@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0fcdd582-47d1-0206-1c66-d8db615f1174@redhat.com>
Date: Fri, 12 May 2017 18:30:47 +0200
MIME-Version: 1.0
In-Reply-To: <005ea4a3-6565-6a56-75de-b6464bcae8fd@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd: strict nbd_wr_syncv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@openvz.org



On 12/05/2017 17:57, Vladimir Sementsov-Ogievskiy wrote:
> 12.05.2017 18:46, Paolo Bonzini wrote:
>>
>> On 12/05/2017 16:17, Vladimir Sementsov-Ogievskiy wrote:
>>> nbd_wr_syncv is called either from coroutine or from client negotiation
>>> code, when socket is in blocking mode. So, -EAGAIN is impossible.
>>>
>>> Furthermore, EAGAIN is confusing, as, what to read/write again? With
>>> EAGAIN as a return code we don't know how much data is already
>>> read or written by the function, so in case of EAGAIN the whole
>>> communication is broken.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>
>>> Hi all!
>>>
>>> If I understand right, nbd_wr_syncv is called either from coroutine
>>> or from client negotiation code, when socket is in blocking mode.
>>> So, some thoughts
>>>
>>> 1. let's establish this with an assert, because returning EAGAIN is
>>>     confusing (see above)
>> Yes, this seems like a good idea.
>>
>>> 2. should we in case of non-coroutine context start this coroutine in
>>>     nbd_wr_syncv, like in bdrv_prwv_co, and use non-blocking mode?
>>> 3. is there any problems or disadvantages of moving  client negotiation
>>>     to coroutine too?
>> When you move code to coroutines you need to be aware of what code can
>> now run concurrently, for example the monitor.  I'm not sure that it's
>> possible to do this.
> 
> Hmm, can you please give some example of a problem? qcow2_open starts
> coroutines to read it's header, why nbd_open can't start
> coroutine/coroutines to read/write some negotiation data?

Ah, it's not a problem if you use synchronous I/O (aio_poll) within the
coroutines.  But then it's still blocking I/O in every way (except
you've fcntl-ed the descriptor to make it non-blocking); it's simply
hidden underneath coroutines and aio_poll.

Paolo

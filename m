Received: from eggs.gnu.org ([2001:4830:134:3::10]:38335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dlGzZ-0007NY-AN
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dlGzV-0003wP-Ap
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:57:53 -0400
References: <20170824153345.2244-1-stefanha@redhat.com>
	<20170824153345.2244-2-stefanha@redhat.com>
	<a839e5fa-0495-902c-5a20-6592ab07bb9e@redhat.com>
	<12b5540c-de00-ac37-f1f6-5ed423856541@redhat.com>
	<26fee110-ce53-6c54-275c-5550dab6d3c4@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d49450b1-9ef1-60ed-91e3-16ff163c6c80@virtuozzo.com>
Date: Fri, 25 Aug 2017 18:57:45 +0300
MIME-Version: 1.0
In-Reply-To: <26fee110-ce53-6c54-275c-5550dab6d3c4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] nbd-client: enter read_reply_co during
 init to avoid crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

24.08.2017 20:42, Paolo Bonzini wrote:
> On 24/08/2017 19:37, Eric Blake wrote:
>> On 08/24/2017 11:21 AM, Paolo Bonzini wrote:
>>> On 24/08/2017 17:33, Stefan Hajnoczi wrote:
>>>> This patch enters read_reply_co directly in
>>>> nbd_client_attach_aio_context().  This is safe because new_context i=
s
>>>> acquired by the caller.  This ensures that read_reply_co reaches its
>>>> first yield point and its ctx is set up.
>>> I'm not very confident with this patch.  aio_context_acquire/release =
is
>>> going to go away, and this then becomes possible
>>>
>>> 	main context			new_context
>>> 	qemu_aio_coroutine_enter
>>> 					send request
>>> 					wait for reply
>>> 	read first reply
>>> 	wake coroutine
>>>
>>> where the "wake coroutine" part thinks it's running in new_context, a=
nd
>>> thus simply enters the coroutine instead of using the bottom half.
>>>
>>> But blk_co_preadv() should need the read_reply_co itself, in order to=
 be
>>> woken up after reading the reply header.  The core issue here is that
>>> nbd_co_receive_reply was never called, I suspect.  And if it was neve=
r
>>> called, read_reply_co should not be woken up by nbd_coroutine_end.
>>>
>>> So the fix is:
>>>
>>> 1) assign NULL to s->recv_coroutine[i] when nbd_co_send_request fails
>>>
>>> 2) move this to nbd_co_receive_reply:
>>>
>>>      s->recv_coroutine[i] =3D NULL;
>>>
>>>      /* Kick the read_reply_co to get the next reply.  */
>>>      if (s->read_reply_co) {
>>>          aio_co_wake(s->read_reply_co);
>>>      }
>>>
>>> Does this make sense?  (Note that the read_reply_co idea actually cam=
e
>>> from you, or from my recollections of your proposed design :)).
>> How much of this overlaps with Vladimir's proposal?
>> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00846.html
> The above should be about 15 lines added, 10 removed. :)
>
> Paolo
>
>

I'll be on vocation for the next two weeks and will continue this work=20
after it.

I think we have a lot of conflicts already with my series after=20
different fixes,

so I'll rebase on them all, no problem.


PS: I think recent problems and bugs in nbd are related to not very good=20
separation between

block/nbd-client.c and nbd/client.c. Ideally, I think, block/nbd-client=20
should not

directly access the ioc, it should just call one or two high level=20
functions of

nbd/client. The big problem of this separation is CMD_READ reply - only=20
real client

knows, should we read a payload or not. I have two ideas on it:

1. We can add this information to request handle, then nbd/client will=20
now by handle,

 =C2=A0 that it should read the payload.. The length of payload should be=
 in=20
handle too. It looks

 =C2=A0possible, as handle is 64bit when request len is 32bit.

2. Move part of NBDClientSession to nbd/client, with NBDClientRequest=20
requests[MAX_NBD_REQUESTS];

 =C2=A0 to nbd/client, to implement one public function nbd_request(state=
,=20
*request, *reply), which will do all the

 =C2=A0work for block/nbd-client..


--=20
Best regards,
Vladimir

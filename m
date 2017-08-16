Received: from eggs.gnu.org ([2001:4830:134:3::10]:57742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dhx0B-0002lc-AV
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 08:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dhx06-0004MX-UX
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 08:00:47 -0400
References: <20170815150907.21495-1-eblake@redhat.com>
	<20170815150907.21495-8-eblake@redhat.com>
	<e0254924-0e90-4e56-f734-d74c8c2ea8ee@virtuozzo.com>
	<2d3ed7c8-f561-cdae-e7e5-411dff341dd8@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f4ca52b8-9ec7-bf99-dc19-dc732b994cd3@virtuozzo.com>
Date: Wed, 16 Aug 2017 15:00:35 +0300
MIME-Version: 1.0
In-Reply-To: <2d3ed7c8-f561-cdae-e7e5-411dff341dd8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PULL 7/7] nbd-client: Fix regression when server
 sends garbage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

15.08.2017 19:51, Eric Blake wrote:
> On 08/15/2017 10:50 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 15.08.2017 18:09, Eric Blake wrote:
>>> When we switched NBD to use coroutines for qemu 2.9 (in particular,
>>> commit a12a712a), we introduced a regression: if a server sends us
>>> garbage (such as a corrupted magic number), we quit the read loop
>>> but do not stop sending further queued commands, resulting in the
>>> client hanging when it never reads the response to those additional
>>> commands.  In qemu 2.8, we properly detected that the server is no
>>> longer reliable, and cancelled all existing pending commands with
>>> EIO, then tore down the socket so that all further command attempts
>>> get EPIPE.
>>>
>>> +++ b/block/nbd-client.c
>>> @@ -73,7 +73,7 @@ static coroutine_fn void nbd_read_reply_entry(void
>>> *opaque)
>>>        int ret;
>>>        Error *local_err = NULL;
>>>
>>> -    for (;;) {
>>> +    while (!s->quit) {
>>>            assert(s->reply.handle == 0);
>>>            ret = nbd_receive_reply(s->ioc, &s->reply, &local_err);
>>>            if (ret < 0) {
>> I think we should check quit here, if it is true, we should not continue
>> normal path of handling reply
> I don't think it matters.  If nbd_receive_reply() correctly got data off
> the wire for this particular coroutine's request, we might as well act
> on that data, regardless of what other coroutines have learned in the
> meantime.
>
> This is already in the pull request for -rc3, but if you can come up
> with a scenario that still behaves incorrectly, we can do a followup

it just don't correspond to your commit message:
"... therefore end all pending commands with EIO, and quit trying to 
send any further commands"

so, we should end this command (we read reply for it) with EIO, instead 
of continuing success path.

However, I think this don't leads to a scenario, leading to a hang or a 
crash of the client, it's OK for me to
handle it in my refactoring for 2.11.

> patch for -rc4 (although I'm hoping we don't have to change it any
> further for 2.10).  Otherwise, I'm fine if your refactoring work for
> 2.11 addresses the issue as part of making the code easier to read.
>
>>> @@ -154,6 +161,9 @@ static int nbd_co_send_request(BlockDriverState *bs,
>>>        } else {
>>>            rc = nbd_send_request(s->ioc, request);
>>>        }
>>> +    if (rc < 0) {
>>> +        s->quit = true;
>>> +    }
>>>        qemu_co_mutex_unlock(&s->send_mutex);
>> and here, if rc == 0 and quite is true, we should not return 0
>>
>>>        return rc;
> We don't - we return rc, which is negative.

I think it can be zero, while quit is set to true in other coroutine.

>
>>>    }
>>> @@ -168,8 +178,7 @@ static void nbd_co_receive_reply(NBDClientSession *s,
>>>        /* Wait until we're woken up by nbd_read_reply_entry.  */
>>>        qemu_coroutine_yield();
>>>        *reply = s->reply;
>>> -    if (reply->handle != request->handle ||
>>> -        !s->ioc) {
>>> +    if (reply->handle != request->handle || !s->ioc || s->quit) {
>>>            reply->error = EIO;
>> here, if s->quit is false, we should set it to inform other coroutines
> We can't get into nbd_co_receive_reply() unless the two handles were
> once equal, and the only code that changes them to be not equal is when
> we are shutting down.  Checking s->quit is a safety valve if some other
> coroutine detects corruption first, but this coroutine does not need to
> set s->quit because it is either already set, or we are already shutting
> down.

ok, and, as s->quit is set when we are shutting down, we can drop 
comparing handles here.

>
>>>        } else {
>>>            if (qiov && reply->error == 0) {
>> and here follows a call to nbd_rwv(), where s->quit should be
>> appropriately handled..
> Reading from a corrupt server is not as bad as writing to the corrupt
> server; the patch for 2.10 is solely focused on preventing writes where
> we need a followup read (because once we know the server is corrupt, we
> can't guarantee the followup reads will come).
>
> Again, if you can prove we have a scenario that is still buggy (client
> can crash or hang), then it is -rc4 material; if not, then this is all
> the more that 2.10 needs, and your refactoring work for 2.11 should
> clean up a lot of this mess in the first place as you make the
> coroutines easier to follow.

ok.

>

-- 
Best regards,
Vladimir

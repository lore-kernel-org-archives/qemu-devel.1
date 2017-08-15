Received: from eggs.gnu.org ([2001:4830:134:3::10]:33993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dhWFV-0006fX-I7
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dhWFU-0001tb-A0
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:26:49 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:33594 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dhWFT-0001rj-TY
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:26:48 -0400
References: <20170808152607.147691-1-vsementsov@virtuozzo.com>
	<6079e4c4-ae54-826f-8cb4-dbcd773ecf50@redhat.com>
	<561af6b4-ca21-7118-e44d-2f12da1b23b8@virtuozzo.com>
	<7ab0fcb2-b033-b67d-cec7-5a7470430a26@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ddc6199c-a20d-8c94-e285-ff08369c461f@virtuozzo.com>
Date: Tue, 15 Aug 2017 10:26:34 +0300
MIME-Version: 1.0
In-Reply-To: <7ab0fcb2-b033-b67d-cec7-5a7470430a26@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 for 2.10] block/nbd-client: always
 return EIO on and after the first io channel error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

14.08.2017 19:22, Eric Blake wrote:
> On 08/14/2017 02:39 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 12.08.2017 01:28, Eric Blake wrote:
>>> On 08/08/2017 10:26 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>
>>> Initial review, I'm still playing with this one, and will reply again on
>>> Monday.
>>>
>>>> Do not communicate after the first error to avoid communicating throught
>>> s/throught/through a/
>>>
>>>> broken channel. The only exclusion is try to send NBD_CMD_DISC anyway on
>>>> in nbd_client_close.
>>> I think the exclusion is wrong - if we detected the server sending us
>>> garbage, we're probably better off disconnecting entirely rather than
>>> trying to assume that the server will give us a clean disconnect via
>>> NBD_CMD_DISC.
>> But we assume nothing, just send NBD_CMD_DISC and then disconnect. May
>> be it'll help server a bit.
> The server is already broken.  Assuming that anything we send will help
> the broken server behave correctly is a waste in effort.  The only
> reason to keep sending NBD_CMD_DISC if we detect a broken server is if
> it is easier to maintain the code that way, and not out of concern for
> the server.
>
>> The only doubt: is it possible to hang on nbd_rwv because some fail in
>> connection or server?
> We _already_ have the bug that we are hanging in trying to talk to a
> broken server, which is a regression introduced in 2.9 and not present
> in 2.8.  And that's what I'm most worried about getting fixed before
> 2.10 is released.
>
> I don't think that sending any more data to the server is necessarily
> going to cause a hang, so much as trying to read data that is going to
> be sent in reply or failing to manipulate the coroutine handlers
> correctly (that is, our current hang is because even after we detect
> failure, we are still sending NBD_CMD_FLUSH but no longer have a
> coroutine in place to read the reply, so we no longer make progress to
> the point of sending NBD_CMD_DISC and closing the connection).

but we will not try to read.
However, I'm convinced, ok, let's send nothing to the broken server.

>
>>>> +++ b/block/nbd-client.h
>>>> @@ -29,6 +29,7 @@ typedef struct NBDClientSession {
>>>>          Coroutine *recv_coroutine[MAX_NBD_REQUESTS];
>>>>        NBDReply reply;
>>>> +    bool eio_to_all;
>>> Bikeshedding - I'm wondering if there is a better name; maybe 'error' or
>>> 'server_broken'?
>> current name also used for normal path shutdown, when reply read returns
>> 0 because of EOF.
> But my point is that we don't necessarily want to treat normal server
> shutdown the same as a buggy server.  Maybe we do as a minimal fix for
> 2.10 purposes, but I really want to understand the fix we are putting in
> for the regression, and making the fix minimal goes a long way towards
> that goal.
>
>>>>    @@ -107,6 +113,7 @@ static coroutine_fn void
>>>> nbd_read_reply_entry(void *opaque)
>>>>            qemu_coroutine_yield();
>>>>        }
>>>>    +    s->eio_to_all = true;
>>> I think this one should be guarded by 'if (ret < 0)' - we also break out
>>> of the for loop when ret == 0 (aka EOF because the server ended
>>> cleanly), which is not the same as the server sending us garbage.
>> but my idea was to use eio_to_all in this case too, so it is not called
>> server_error.
> But that's what I'm questioning - it's not obvious that forcing all
> existing coroutines to fail with EIO is correct when we got a normal
> EOF, as that is different than a server that is actively sending us garbage.

actually, we are not sure, is it a normal path or error: read from 
socket retuns EOF, that means that
server closed connection after sending last reply. If we really received 
all needed replies and sent
CMD_DISC that is ok, but if not - it's an error path.
Also, read of last reply can fail because of qio_channel_shutdown 
running in parallel, which is a normal
path actually.

>
>>>> +    if (s->eio_to_all) {
>>>>            qemu_co_mutex_unlock(&s->send_mutex);
>>>> -        return -EPIPE;
>>>> +        return -EIO;
>>>>        }
>>> I don't know if changing the errno is wise; maybe we want to keep both
>>> conditions (the !s->ioc and the s->eio_to_all) - especially if we only
>>> set eio_to_all on an actual detection of server garbage rather than on
>>> all exit paths.
>> I think it is ok for all exit paths, otherwise we should carefully
>> declare in which cases
>> we return EIO and in which EPIPE, and spread this difference to the
>> whole file.
> Losing the distinction between error codes generally has minimal impact
> to correctness (either way, you have an error, and know that your
> connection has dies), but can have drastic effects on ease of
> understanding error messages.
>

-- 
Best regards,
Vladimir

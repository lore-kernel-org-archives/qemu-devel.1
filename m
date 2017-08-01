Received: from eggs.gnu.org ([2001:4830:134:3::10]:52540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dcZX4-0000s0-8u
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dcZWz-0005jr-DT
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:56:30 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:10613 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dcZWz-0005e1-04
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:56:25 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-8-vsementsov@virtuozzo.com>
	<4dd0646d-dd08-0f39-a416-2cee0d6e409f@redhat.com>
	<fd1e53de-688f-4b90-fa58-62b8942d7f7b@virtuozzo.com>
Message-ID: <4ac186db-ae23-a745-55ea-e8ccebe4f1ff@virtuozzo.com>
Date: Tue, 1 Aug 2017 18:56:04 +0300
MIME-Version: 1.0
In-Reply-To: <fd1e53de-688f-4b90-fa58-62b8942d7f7b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 07/18] nbd: Minimal structured read for
 client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

01.08.2017 18:41, Vladimir Sementsov-Ogievskiy wrote:
> 07.02.2017 23:14, Eric Blake wrote:
>> On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Minimal implementation: always send DF flag, to not deal with 
>>> fragmented
>>> replies.
>> This works well with your minimal server implementation, but I worry
>> that it will cause us to fall over when talking to a fully-compliant
>> server that chooses to send EOVERFLOW errors for any request larger than
>> 64k when DF is set; it also makes it impossible to benefit from sparse
>> reads.  I guess that means we need to start thinking about followup
>> patches to flush out our implementation.  But maybe I can live with this
>> patch as is, since the goal of your series was not so much the full
>> power of structured reads, but getting to a point where we could use
>> structured reply for block status, even if it means your client can only
>> communicate with qemu-nbd as server for now, as long as we do get to the
>> rest of the patches for a full-blown structured read.
>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   block/nbd-client.c  |  47 +++++++++++----
>>>   block/nbd-client.h  |   2 +
>>>   include/block/nbd.h |  15 +++--
>>>   nbd/client.c        | 170 
>>> ++++++++++++++++++++++++++++++++++++++++++++++------
>>>   qemu-nbd.c          |   2 +-
>>>   5 files changed, 203 insertions(+), 33 deletions(-)
>> Hmm - no change to the testsuite. Structured reads seems like the sort
>> of thing that it would be nice to test with some canned server replies,
>> particularly with server behavior that is permitted by the NBD protocol
>> but does not happen by default in qemu-nbd.
>>
>>> diff --git a/block/nbd-client.c b/block/nbd-client.c
>>> index 3779c6c999..ff96bd1635 100644
>>> --- a/block/nbd-client.c
>>> +++ b/block/nbd-client.c
>>> @@ -180,13 +180,20 @@ static void 
>>> nbd_co_receive_reply(NBDClientSession *s,
>>>       *reply = s->reply;
>>>       if (reply->handle != request->handle ||
>>>           !s->ioc) {
>>> +        reply->simple = true;
>>>           reply->error = EIO;
>> I don't think this is quite right - by setting reply->simple to true,
>> you are forcing the caller to treat this as the final packet related to
>> this request->handle, even though that might not be the case.
>>
>> As it is, I wonder if this code is correct, even before your patch - the
>> server is allowed to give responses out-of-order (if we request multiple
>> reads without waiting for the first response) - I don't see how setting
>> reply->error to EIO if the request->handle indicates that we are
>> receiving an out-of-order response to some other packet, but that our
>> request is still awaiting traffic.
>
> Hmm, looks like it should initiate disconnect instead of just 
> reporting error to io operation caller.
>
>

Also, nbd_co_send_request errors are not handled but just returned to 
the caller. Shouldn't the first

error on socket io initiate disconnect? I think, only the io errors, 
transferred from nbd-export block device

should be just returned to bdrv_{io} caller. NBD-protocol related errors 
(invalid handles, etc.) should initiate

disconnect, so that current and all future bdrv_{io}'s from client 
return -EIO.


-- 
Best regards,
Vladimir

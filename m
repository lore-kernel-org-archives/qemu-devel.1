Received: from eggs.gnu.org ([2001:4830:134:3::10]:36743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duFMA-0005ac-RS
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duFM4-0001vs-TF
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:02:18 -0400
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
	<20170918135935.255591-4-vsementsov@virtuozzo.com>
	<d554b537-54da-2a70-66c7-722f2c27f4da@redhat.com>
	<577e29c4-5187-8c6f-aacc-c77282959fdd@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <26582eb0-1db3-3aac-3652-44e3fbb1e49c@redhat.com>
Date: Tue, 19 Sep 2017 12:01:55 +0200
MIME-Version: 1.0
In-Reply-To: <577e29c4-5187-8c6f-aacc-c77282959fdd@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/7] block/nbd-client: refactor reading
 reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, den@openvz.org

On 19/09/2017 11:25, Vladimir Sementsov-Ogievskiy wrote:
> 18.09.2017 18:43, Paolo Bonzini wrote:
>> On 18/09/2017 15:59, Vladimir Sementsov-Ogievskiy wrote:
>>> Read the whole reply in one place - in nbd_read_reply_entry.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   block/nbd-client.h |  1 +
>>>   block/nbd-client.c | 42 ++++++++++++++++++++++++------------------
>>>   2 files changed, 25 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/block/nbd-client.h b/block/nbd-client.h
>>> index b1900e6a6d..3f97d31013 100644
>>> --- a/block/nbd-client.h
>>> +++ b/block/nbd-client.h
>>> @@ -21,6 +21,7 @@ typedef struct {
>>>       Coroutine *coroutine;
>>>       bool receiving;         /* waiting for read_reply_co? */
>>>       NBDRequest *request;
>>> +    QEMUIOVector *qiov;
>>>   } NBDClientRequest;
>>>     typedef struct NBDClientSession {
>>> diff --git a/block/nbd-client.c b/block/nbd-client.c
>>> index 5f241ecc22..f7b642f079 100644
>>> --- a/block/nbd-client.c
>>> +++ b/block/nbd-client.c
>>> @@ -98,6 +98,21 @@ static coroutine_fn void nbd_read_reply_entry(void
>>> *opaque)
>>>               break;
>>>           }
>>>   +        if (s->reply.error == 0 &&
>>> +            s->requests[i].request->type == NBD_CMD_READ)
>>> +        {
>>> +            QEMUIOVector *qiov = s->requests[i].qiov;
>>> +            assert(qiov != NULL);
>>> +            assert(s->requests[i].request->len ==
>>> +                   iov_size(qiov->iov, qiov->niov));
>>> +            if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
>>> +                                      NULL) < 0)
>>> +            {
>>> +                s->reply.error = EIO;
>>> +                break;
>>> +            }
>>> +        }
>> I am not sure this is an improvement.  In principle you could have
>> commands that read replies a bit at a time without using a QEMUIOVector.
>>
>> Paolo
> 
> Hm, what do you mean? In this patch I don't change "how do we read it",
> I only move the reading code to one coroutine, to make it simple to
> extend it in future (block status, etc).

I disagree that it is easier to extend it in the future.  If some
commands in the future need a different "how do we read it" (e.g. for
structured reply), nbd_read_reply_entry may not have all the information
it needs anymore.

In fact, you're pushing knowledge of the commands from nbd_co_request to
nbd_read_reply_entry:

+        if (s->reply.error == 0 &&
+            s->requests[i].request->type == NBD_CMD_READ)

and knowledge of NBD_CMD_READ simply doesn't belong there.  So there is
an example of that right now, it is not some arbitrary bad thing that
could happen in the future.

Paolo


> nbd_read_reply_enty has all
> information it need (s->requests[i].request) to handle the whole reply..
> It's an improvement, because it leads to separating reply_entry
> coroutine - it don't need any synchronization (yield/wake) more with
> request coroutines.
> 
>>
>>>           /* We're woken up again by the request itself.  Note that
>>> there
>>>            * is no race between yielding and reentering
>>> read_reply_co.  This
>>>            * is because:
>>> @@ -118,6 +133,7 @@ static coroutine_fn void
>>> nbd_read_reply_entry(void *opaque)
>>>       s->read_reply_co = NULL;
>>>   }
>>>   +/* qiov should be provided for READ and WRITE */
>>>   static int nbd_co_send_request(BlockDriverState *bs,
>>>                                  NBDRequest *request,
>>>                                  QEMUIOVector *qiov)
>>> @@ -145,6 +161,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
>>>         request->handle = INDEX_TO_HANDLE(s, i);
>>>       s->requests[i].request = request;
>>> +    s->requests[i].qiov = qiov;
>>>         if (s->quit) {
>>>           rc = -EIO;
>>> @@ -155,7 +172,8 @@ static int nbd_co_send_request(BlockDriverState *bs,
>>>           goto err;
>>>       }
>>>   -    if (qiov) {
>>> +    if (s->requests[i].request->type == NBD_CMD_WRITE) {
>>> +        assert(qiov);
>>>           qio_channel_set_cork(s->ioc, true);
>>>           rc = nbd_send_request(s->ioc, request);
>>>           if (rc >= 0 && !s->quit) {
>>> @@ -181,9 +199,7 @@ err:
>>>       return rc;
>>>   }
>>>   -static int nbd_co_receive_reply(NBDClientSession *s,
>>> -                                NBDRequest *request,
>>> -                                QEMUIOVector *qiov)
>>> +static int nbd_co_receive_reply(NBDClientSession *s, NBDRequest
>>> *request)
>>>   {
>>>       int ret;
>>>       int i = HANDLE_TO_INDEX(s, request->handle);
>>> @@ -197,14 +213,6 @@ static int nbd_co_receive_reply(NBDClientSession
>>> *s,
>>>       } else {
>>>           assert(s->reply.handle == request->handle);
>>>           ret = -s->reply.error;
>>> -        if (qiov && s->reply.error == 0) {
>>> -            assert(request->len == iov_size(qiov->iov, qiov->niov));
>>> -            if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
>>> -                                      NULL) < 0) {
>>> -                ret = -EIO;
>>> -                s->quit = true;
>>> -            }
>>> -        }
>>>             /* Tell the read handler to read another header.  */
>>>           s->reply.handle = 0;
>>> @@ -232,16 +240,14 @@ static int nbd_co_request(BlockDriverState *bs,
>>>       NBDClientSession *client = nbd_get_client_session(bs);
>>>       int ret;
>>>   -    assert(!qiov || request->type == NBD_CMD_WRITE ||
>>> -           request->type == NBD_CMD_READ);
>>> -    ret = nbd_co_send_request(bs, request,
>>> -                              request->type == NBD_CMD_WRITE ? qiov
>>> : NULL);
>>> +    assert((qiov == NULL) !=
>>> +           (request->type == NBD_CMD_WRITE || request->type ==
>>> NBD_CMD_READ));
>>> +    ret = nbd_co_send_request(bs, request, qiov);
>>>       if (ret < 0) {
>>>           return ret;
>>>       }
>>>   -    return nbd_co_receive_reply(client, request,
>>> -                                request->type == NBD_CMD_READ ? qiov
>>> : NULL);
>>> +    return nbd_co_receive_reply(client, request);
>>>   }
>>>     int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
>>>
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2KLl-0001zC-Ul
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2KLk-0006sZ-2r
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:59:17 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:30755 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e2KLj-0006of-Li
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:59:16 -0400
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
	<20171009172723.190282-18-vsementsov@virtuozzo.com>
	<24bd15b7-8119-4bb4-85f4-b5187a0339e2@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <26ba75fe-b253-aed4-7eb4-893115b83e13@virtuozzo.com>
Date: Wed, 11 Oct 2017 19:59:01 +0300
MIME-Version: 1.0
In-Reply-To: <24bd15b7-8119-4bb4-85f4-b5187a0339e2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 10/10] nbd: Minimal structured read for
 client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, den@openvz.org

10.10.2017 11:02, Paolo Bonzini wrote:
> On 09/10/2017 19:27, Vladimir Sementsov-Ogievskiy wrote:
>> +    int ret = nbd_co_do_receive_one_chunk(s, handle, only_structured,
>> +                                          &request_ret, qiov, payload);
>> +
>> +    if (ret < 0) {
>> +        s->quit = true;
>> +    } else {
>> +        /* For assert at loop start in nbd_read_reply_entry */
>> +        if (reply) {
>> +            *reply = s->reply;
>> +        }
> reply is always non-NULL, right?
>
>> +        s->reply.handle = 0;
>> +        ret = request_ret;
>> +    }
>>   
> ...
>
>> +static int nbd_co_receive_return_code(NBDClientSession *s, uint64_t handle)
>> +{
>> +    int ret = 0;
>> +    int i = HANDLE_TO_INDEX(s, handle);
>> +    NBDReply reply;
>> +    bool only_structured = false;
>> +
>> +    do {
>> +        int rc = nbd_co_receive_one_chunk(s, handle, only_structured,
>> +                                          NULL, &reply, NULL);
> Is rc > 0 propagated correctly?
>
>> +        if (rc < 0 || nbd_reply_is_simple(&reply)) {
>> +            if (ret == 0) {
>> +                ret = rc;
>> +            }
>> +            only_structured = true;
>> +            continue;
>> +        }
>> +    } while (!s->quit && nbd_reply_is_structured(&s->reply) &&
>> +             !(s->reply.structured.flags & NBD_SREP_FLAG_DONE));
>> +
>> +    s->requests[i].coroutine = NULL;
>> +
>> +    qemu_co_mutex_lock(&s->send_mutex);
>> +    s->in_flight--;
>> +    qemu_co_queue_next(&s->free_sema);
>> +    qemu_co_mutex_unlock(&s->send_mutex);
> The code after the loop is duplicated.
>
> An idea could be to wrap nbd_co_receive_one_chunk with an iterator like
>
> typedef struct NBDReplyChunkIter {
>      int ret;
>      bool done, only_structured;
> } NBDReplyChunkIter;
>
> #define NBD_FOREACH_REPLY_CHUNK(s, handle, iter, qiov, reply, payload, \
>                                  structured)                            \
>      for (iter = (NBDReplyChunkIter) { .only_structured = structured }; \
>           nbd_reply_chunk_iter_receive(s, &iter, qiov, &reply, handle,  \
>                                        payload);;)
>
> bool coroutine_fn nbd_reply_chunk_iter_receive(...)
> {
>      if (s->quit) {
>          if (iter->ret == 0) {
>              iter->ret = -EIO;
>          }
>          goto break_loop;
>      }
>      /* Handle the end of the previous iteration.  */
>      if (iter->done) {
>          goto break_loop;
>      }
>
>      rc = nbd_co_receive_one_chunk(s, handle, iter->only_structured,
>                                    qiov, reply, payload);
>      if (rc < 0) {
>          assert(s->quit);
>          if (iter->ret == 0) {
>              iter->ret = rc;
>          }
>          goto break_loop;
>      }
>
>      /* No structured reply?  Do not execute the body of
>       * NBD_FOREACH_REPLY_CHUNK.
>       */
>      if (nbd_reply_is_simple(&s->reply) || s->quit) {
>          goto break_loop;
>      }
>
>      iter->only_structured = true;
>      if (s->reply.structured.flags & NBD_SREP_FLAG_DONE) {
>          iter->ret = rc;
>          iter->done = true;
>          /* Execute the loop body, but this iteration is the last.  */
>          return true;
>      }
>
>      /* An error reply must have NBD_SREP_FLAG_DONE set, otherwise it is
>       * a protocol error (FIXME: is this true?  but if not, how do you
>       * cope with multiple error replies?)

unfortunately it's not true, spec doesn't forbid several error replies 
on one request.
Furthermore, we have NBD_REPLY_TYPE_ERROR_OFFSET, which have ability of 
several error chunks it its nature.

>       */
>      if (rc > 0) {
>          s->quit = true;
>          iter->ret = -EIO;
>          goto break_loop;
>      }
>      return true;
>
> break_loop:
>      iter->done = true;
>
>      s->requests[HANDLE_TO_INDEX(s, handle)].coroutine = NULL;
>
>      qemu_co_mutex_lock(&s->send_mutex);
>      s->in_flight--;
>      qemu_co_queue_next(&s->free_sema);
>      qemu_co_mutex_unlock(&s->send_mutex);
>      return false;
> }
>
> so this loop could be written like
>
>      FOR_EACH_REPLY_CHUNK(s, handle, iter, NULL, &reply, NULL) {
>          if (reply.structured.type != NBD_SREP_TYPE_NONE) {
>              /* not allowed reply type */
>              s->quit = true;
>              break;
>          }
>      }
>      return iter.ret;
>
> and likewise for nbd_co_receive_cmdread_reply.  The iterator is a bit
> more complex, but it abstracts all the protocol handling and avoids lots
> of duplicated code.
>
> Paolo
>
>> +    return ret;
>> +}


-- 
Best regards,
Vladimir

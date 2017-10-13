Received: from eggs.gnu.org ([2001:4830:134:3::10]:41426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e32kq-00026v-ES
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e32ko-0005wW-O7
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:08 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:21585 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e32ko-0005uH-7W
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:06 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-10-vsementsov@virtuozzo.com>
	<46e3f2c3-695d-3fe2-eefb-fcbf4a2a0555@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f1ba1c6e-0976-ff56-aefb-1dc1315ce43f@virtuozzo.com>
Date: Fri, 13 Oct 2017 19:23:53 +0300
MIME-Version: 1.0
In-Reply-To: <46e3f2c3-695d-3fe2-eefb-fcbf4a2a0555@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 09/13] nbd: Minimal structured read for
 server
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

13.10.2017 19:00, Eric Blake wrote:
> On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Minimal implementation of structured read: one structured reply chunk,
>> no segmentation.
>> Minimal structured error implementation: no text message.
>> Support DF flag, but just ignore it, as there is no segmentation any
>> way.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---

[...]

>> Spurious whitespace change hunk.
>>
>> So, here's what I'm squashing, before adding:
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> diff --git i/include/block/nbd.h w/include/block/nbd.h
>> index dd261f66f0..f1b8c28f58 100644
>> --- i/include/block/nbd.h
>> +++ w/include/block/nbd.h
>> @@ -69,6 +69,7 @@ typedef struct NBDSimpleReply {
>>       uint64_t handle;
>>   } QEMU_PACKED NBDSimpleReply;
>>
>> +/* Header of all structured replies */
>>   typedef struct NBDStructuredReplyChunk {
>>       uint32_t magic;  /* NBD_STRUCTURED_REPLY_MAGIC */
>>       uint16_t flags;  /* combination of NBD_SREP_FLAG_* */
>> @@ -77,11 +78,13 @@ typedef struct NBDStructuredReplyChunk {
>>       uint32_t length; /* length of payload */
>>   } QEMU_PACKED NBDStructuredReplyChunk;
>>
>> +/* Header of NBD_SREP_TYPE_OFFSET_DATA, complete
>> NBD_SREP_TYPE_OFFSET_HOLE */
>>   typedef struct NBDStructuredRead {
>>       NBDStructuredReplyChunk h;
>>       uint64_t offset;
>>   } QEMU_PACKED NBDStructuredRead;
>>
>> +/* Header of all NBD_SREP_TYPE_ERROR* errors */
>>   typedef struct NBDStructuredError {
>>       NBDStructuredReplyChunk h;
>>       uint32_t error;
>> diff --git i/nbd/server.c w/nbd/server.c
>> index e55825cc91..b4966ed8b1 100644
>> --- i/nbd/server.c
>> +++ w/nbd/server.c
>> @@ -765,15 +765,18 @@ static int nbd_negotiate_options(NBDClient
>> *client, uint16_t myflags,
>>
>>               case NBD_OPT_STRUCTURED_REPLY:
>>                   if (client->structured_reply) {
>> -                    error_setg(errp, "Double negotiation of structured
>> reply");
>> -                    return -EINVAL;
>> +                    ret = nbd_negotiate_send_rep_err(
>> +                        client->ioc, NBD_REP_ERR_INVALID, option, errp,
>> +                        "structured reply already negotiated");
>> +                } else {
>> +                    ret = nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
>> +                                                 option, errp);
>>                   }
>> -                ret = nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
>> option,
>> -                                             errp);
>>                   if (ret < 0) {
>>                       return ret;
>>                   }
>>                   client->structured_reply = true;
>> +                myflags |= NBD_CMD_FLAG_DF;
>>                   break;
>>
>>               default:
>> @@ -1259,16 +1262,6 @@ static inline void
>> set_be_chunk(NBDStructuredReplyChunk *chunk, uint16_t flags,
>>       stl_be_p(&chunk->length, length);
>>   }
>>
>> -static inline int coroutine_fn nbd_co_send_buf(NBDClient *client, void
>> *buf,
>> -                                               size_t size, Error **errp)
>> -{
>> -    struct iovec iov[] = {
>> -        {.iov_base = buf, .iov_len = size}
>> -    };
>> -
>> -    return nbd_co_send_iov(client, iov, 1, errp);
>> -}
>> -
>>   static int coroutine_fn nbd_co_send_structured_read(NBDClient *client,
>>                                                       uint64_t handle,
>>                                                       uint64_t offset,
>> @@ -1282,6 +1275,7 @@ static int coroutine_fn
>> nbd_co_send_structured_read(NBDClient *client,
>>           {.iov_base = data, .iov_len = size}
>>       };
>>
>> +    trace_nbd_co_send_structured_read(handle, offset, data, size);
>>       set_be_chunk(&chunk.h, NBD_SREP_FLAG_DONE, NBD_SREP_TYPE_OFFSET_DATA,
>>                    handle, sizeof(chunk) - sizeof(chunk.h) + size);
>>       stq_be_p(&chunk.offset, offset);
>> @@ -1295,13 +1289,20 @@ static int coroutine_fn
>> nbd_co_send_structured_error(NBDClient *client,
>>                                                        Error **errp)
>>   {
>>       NBDStructuredError chunk;
>> +    int nbd_err = system_errno_to_nbd_errno(error);
>> +    struct iovec iov[] = {
>> +        {.iov_base = &chunk, .iov_len = sizeof(chunk)},
>> +        /* FIXME: Support human-readable error message */
>> +    };
>>
>> +    assert(nbd_err);
>> +    trace_nbd_co_send_structured_error(handle, nbd_err);
>>       set_be_chunk(&chunk.h, NBD_SREP_FLAG_DONE, NBD_SREP_TYPE_ERROR, handle,
>>                    sizeof(chunk) - sizeof(chunk.h));
>> -    stl_be_p(&chunk.error, error);
>> +    stl_be_p(&chunk.error, nbd_err);
>>       stw_be_p(&chunk.message_length, 0);
>>
>> -    return nbd_co_send_buf(client, &chunk, sizeof(chunk), errp);
>> +    return nbd_co_send_iov(client, iov, 1, errp);
>>   }
>>
>>   /* nbd_co_receive_request
>> @@ -1452,6 +1453,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>>           }
>>
>>           reply_data_len = request.len;
>> +
>>           break;
>>       case NBD_CMD_WRITE:
>>           if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
>> diff --git i/nbd/trace-events w/nbd/trace-events
>> index e27614f050..0d7c3b4887 100644
>> --- i/nbd/trace-events
>> +++ w/nbd/trace-events
>> @@ -54,6 +54,8 @@ nbd_receive_request(uint32_t magic, uint16_t flags,
>> uint16_t type, uint64_t from
>>   nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching
>> clients to AIO context %p\n"
>>   nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching
>> clients from AIO context %p\n"
>>   nbd_co_send_simple_reply(uint64_t handle, uint32_t error, int len)
>> "Send simple reply: handle = %" PRIu64 ", error = %" PRIu32 ", len = %d"
>> +nbd_co_send_structured_read(uint64_t handle, uint64_t offset, void
>> *data, size_t size) "Send structured read data reply: handle = %" PRIu64
>> ", offset = %" PRIu64 ", data = %p, len = %zu"
>> +nbd_co_send_structured_error(uint64_t handle, int err) "Send structured
>> error reply: handle = %" PRIu64 ", error = %d"
>>   nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type,
>> const char *name) "Decoding type: handle = %" PRIu64 ", type = %" PRIu16
>> " (%s)"
>>   nbd_co_receive_request_payload_received(uint64_t handle, uint32_t len)
>> "Payload received: handle = %" PRIu64 ", len = %" PRIu32
>>   nbd_co_receive_request_cmd_write(uint32_t len) "Reading %" PRIu32 "
>> byte(s)"
>>
>>
>>

Looks OK for me, thanks.

However, now I don't like _SREP_... It's not very obvious abbreviation. 
Simple and Structured are both with first symbol 'S')))
I don't remember, what was the reason to use it. (obviously to 
distinguish it with simple reply, but where are simple reply flags? 
there no intersection anyway)
So, I prefer s/_SREP_/_REPLY_/ for the whole series.

-- 
Best regards,
Vladimir

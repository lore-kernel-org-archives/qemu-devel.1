Received: from eggs.gnu.org ([2001:4830:134:3::10]:45785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e6bmJ-0006f6-MG
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e6bmG-0001Q9-Hw
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:24:23 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:38355 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e6bmG-0001NS-4r
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:24:20 -0400
References: <20171019222637.17890-1-eblake@redhat.com>
	<20171019222637.17890-12-eblake@redhat.com>
	<1ffafe3a-ecd0-74b0-ac76-3a93dee3fb6a@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <07fc7ff8-1d31-7fe4-b93e-3ddc407bc479@virtuozzo.com>
Date: Mon, 23 Oct 2017 15:24:10 +0300
MIME-Version: 1.0
In-Reply-To: <1ffafe3a-ecd0-74b0-ac76-3a93dee3fb6a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 11/11] nbd: Minimal structured read for
 client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, nbd list <nbd@other.debian.org>

23.10.2017 14:57, Eric Blake wrote:
> On 10/19/2017 05:26 PM, Eric Blake wrote:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Minimal implementation: for structured error only error_report error
>> message.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> +static int nbd_parse_offset_hole_payload(NBDStructuredReplyChunk *chunk,
>> +                                         uint8_t *payload, QEMUIOVector *qiov,
>> +                                         Error **errp)
>> +{
>> +    uint64_t offset;
>> +    uint32_t hole_size;
>> +
>> +    if (chunk->length != sizeof(offset) + sizeof(hole_size)) {
>> +        error_setg(errp, "Protocol error: invalid payload for "
>> +                         "NBD_REPLY_TYPE_OFFSET_HOLE");
>> +        return -EINVAL;
>> +    }
>> +
>> +    offset = payload_advance64(&payload);
>> +    hole_size = payload_advance32(&payload);
>> +
>> +    if (offset > qiov->size - hole_size) {
>> +        error_setg(errp, "Protocol error: server sent chunk exceeding requested"
>> +                         " region");
>> +        return -EINVAL;
>> +    }
>> +
>> +    qemu_iovec_memset(qiov, offset, 0, hole_size);
> Ouch. We have a discrepancy here, that needs clarification in the NBD
> spec (cc'd).  In your server implementation, you are returning the
> offset as sent by the client (that is, all offsets are absolute to the
> size of the export).  But in this client implementation, you are
> computing where to decode the zeroes by treating offset as though it
> were relative to the request, rather than absolute to the export.
>
> Or, in numbers, if I request a read of 2k starting at an offset of 4k,
> the server implementation returns an offset of 4k, and the client
> rejects the message because 4k is larger than the 2k request.
>
> I think that absolute numbers are better to work with than
> request-relative, but don't see anything in the proposed spec that
> states one way or the other, so this is your chance to agree with my
> preference or else argue why request-relative offsets are nicer, before
> wordsmithing a change to the spec to make it obvious which semantics are
> intended.  Then I can change either the server to match (if we want
> request-relative) or the client to remember the original offset it sent
> in order to turn absolute answers from the server back into
> request-relative offsets for where to place the zeroes (if we go with
> absolute offsets).
>

I am for absolute offsets too. Here is my mistake (hehe, terrible bug, 
good catch).

-- 
Best regards,
Vladimir

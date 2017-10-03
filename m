Received: from eggs.gnu.org ([2001:4830:134:3::10]:54693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dzMml-00011y-Lq
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dzMmg-0001ut-Sh
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:58:55 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:29760 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dzMmg-0001ry-DQ
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:58:50 -0400
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
	<20170925135801.144261-9-vsementsov@virtuozzo.com>
	<b8b01f1a-6e7b-342f-02b6-b7386bff1500@redhat.com>
	<a4fb096f-7995-ad85-64b7-68a124410e86@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cdec3d7e-04c9-a5e3-d0e7-293e2c7633c8@virtuozzo.com>
Date: Tue, 3 Oct 2017 15:58:42 +0300
MIME-Version: 1.0
In-Reply-To: <a4fb096f-7995-ad85-64b7-68a124410e86@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 8/8] nbd: Minimal structured
 read for client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com

03.10.2017 13:07, Paolo Bonzini wrote:
> On 26/09/2017 00:19, Eric Blake wrote:
>>> +    /* here we deal with successful structured reply */
>>> +    switch (s->reply.type) {
>>> +        QEMUIOVector sub_qiov;
>>> +    case NBD_SREP_TYPE_OFFSET_DATA:
>> This is putting a LOT of smarts directly into the receive routine.
>> Here's where I was previously wondering (and I think Paolo as well)
>> whether it might be better to split the efforts: the generic function
>> reads off the chunk information and any payload, but a per-command
>> callback function then parses the chunks.  Especially since the
>> definition of the chunks differs on a per-command basis (yes, the NBD
>> spec will try to not reuse an SREP chunk type across multiple commands
>> unless the semantics are similar, but that's a bit more fragile).  This
>> particularly matters given my statement above that you want a
>> discriminated union, rather than a struct that contains unused fields,
>> for handling different SREP chunk types.
> I think there should be two kinds of replies: 1) read directly into a
> QEMUIOVector, using structured replies only as an encapsulation of the
> payload; 2) read a chunk at a time into malloc-ed memory, yielding back
> to the calling coroutine after receiving one complete chunk.
>
> In the end this probably means that you have a read_chunk_header
> function and a read_chunk function.  READ has a loop that calls
> read_chunk_header followed by direct reading into the QEMUIOVector,
> while everyone else calls read_chunk.

accordingly to spec, we can receive several error reply chunks to any 
request,
so loop, receiving them should be common for all requests I think

>
> Maybe qio_channel_readv/writev_full could have "offset" and "bytes"
> arguments.  Most code in iov_send_recv could be cut-and-pasted.  (When
> sheepdog is converted to QIOChannel, iov_send_recv can go away).
>
> Paolo


-- 
Best regards,
Vladimir

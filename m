Received: from eggs.gnu.org ([2001:4830:134:3::10]:35443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dzK7U-0005tW-Mo
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dzK7P-0006Z8-0K
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:08:08 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:50766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dzK7O-0006Yn-PC
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:08:02 -0400
Received: by mail-wm0-f52.google.com with SMTP id u138so15502041wmu.5
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 03:08:02 -0700 (PDT)
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
	<20170925135801.144261-9-vsementsov@virtuozzo.com>
	<b8b01f1a-6e7b-342f-02b6-b7386bff1500@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a4fb096f-7995-ad85-64b7-68a124410e86@redhat.com>
Date: Tue, 3 Oct 2017 12:07:59 +0200
MIME-Version: 1.0
In-Reply-To: <b8b01f1a-6e7b-342f-02b6-b7386bff1500@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com

On 26/09/2017 00:19, Eric Blake wrote:
>> +    /* here we deal with successful structured reply */
>> +    switch (s->reply.type) {
>> +        QEMUIOVector sub_qiov;
>> +    case NBD_SREP_TYPE_OFFSET_DATA:
> This is putting a LOT of smarts directly into the receive routine.
> Here's where I was previously wondering (and I think Paolo as well)
> whether it might be better to split the efforts: the generic function
> reads off the chunk information and any payload, but a per-command
> callback function then parses the chunks.  Especially since the
> definition of the chunks differs on a per-command basis (yes, the NBD
> spec will try to not reuse an SREP chunk type across multiple commands
> unless the semantics are similar, but that's a bit more fragile).  This
> particularly matters given my statement above that you want a
> discriminated union, rather than a struct that contains unused fields,
> for handling different SREP chunk types.

I think there should be two kinds of replies: 1) read directly into a
QEMUIOVector, using structured replies only as an encapsulation of the
payload; 2) read a chunk at a time into malloc-ed memory, yielding back
to the calling coroutine after receiving one complete chunk.

In the end this probably means that you have a read_chunk_header
function and a read_chunk function.  READ has a loop that calls
read_chunk_header followed by direct reading into the QEMUIOVector,
while everyone else calls read_chunk.

Maybe qio_channel_readv/writev_full could have "offset" and "bytes"
arguments.  Most code in iov_send_recv could be cut-and-pasted.  (When
sheepdog is converted to QIOChannel, iov_send_recv can go away).

Paolo

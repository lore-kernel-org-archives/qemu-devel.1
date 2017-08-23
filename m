Received: from eggs.gnu.org ([2001:4830:134:3::10]:38140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dkWcF-00080N-Jt
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dkWc9-0002Cv-S9
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:26:43 -0400
MIME-Version: 1.0
In-Reply-To: <cbdf8d3f-8e30-bc18-a453-ba1529d850f5@redhat.com>
References: <20170822125113.5025-1-stefanha@redhat.com>
	<cbdf8d3f-8e30-bc18-a453-ba1529d850f5@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 23 Aug 2017 15:26:34 +0100
Message-ID: <CAJSP0QVWruvkQ9Q4=xcmf7yQME28aYDmZGriFVz3rhyxXi6qKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nbd-client: avoid spurious
 qio_channel_yield() re-entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu block <qemu-block@nongnu.org>

On Wed, Aug 23, 2017 at 3:20 PM, Eric Blake <eblake@redhat.com> wrote:
> On 08/22/2017 07:51 AM, Stefan Hajnoczi wrote:
>> The following scenario leads to an assertion failure in
>> qio_channel_yield():
>>
>> 1. Request coroutine calls qio_channel_yield() successfully when sending
>>    would block on the socket.  It is now yielded.
>> 2. nbd_read_reply_entry() calls nbd_recv_coroutines_enter_all() because
>>    nbd_receive_reply() failed.
>> 3. Request coroutine is entered and returns from qio_channel_yield().
>>    Note that the socket fd handler has not fired yet so
>>    ioc->write_coroutine is still set.
>> 4. Request coroutine attempts to send the request body with nbd_rwv()
>>    but the socket would still block.  qio_channel_yield() is called
>>    again and assert(!ioc->write_coroutine) is hit.
>>
>> The problem is that nbd_read_reply_entry() does not distinguish between
>> request coroutines that are waiting to receive a reply and those that
>> are not.
>>
>> This patch adds a per-request bool receiving flag so
>> nbd_read_reply_entry() can avoid spurious aio_wake() calls.
>>
>> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>> This should fix the issue that Dave is seeing but I'm concerned that
>> there are more problems in nbd-client.c.  We don't have good
>> abstractions for writing coroutine socket I/O code.  Something like Go's
>> channels would avoid manual low-level coroutine calls.  There is
>> currently no way to cancel qio_channel_yield() so requests doing I/O may
>> remain in-flight indefinitely and nbd-client.c doesn't join them...
>
> Is this patch needed for 2.10-rc4, or does Fam's series cover the issue?

Fam's series fixes non-shared storage migration.

This patch addresses the failure case when the server closes the
connection prematurely.

Stefan

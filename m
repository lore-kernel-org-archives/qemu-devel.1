Received: from eggs.gnu.org ([2001:4830:134:3::10]:40161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dlC2J-0003aE-RO
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:40:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dlC2J-00046o-1b
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:40:23 -0400
MIME-Version: 1.0
In-Reply-To: <a839e5fa-0495-902c-5a20-6592ab07bb9e@redhat.com>
References: <20170824153345.2244-1-stefanha@redhat.com>
	<20170824153345.2244-2-stefanha@redhat.com>
	<a839e5fa-0495-902c-5a20-6592ab07bb9e@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 25 Aug 2017 11:40:20 +0100
Message-ID: <CAJSP0QW-yX-cw0-Nhen6HTkpm6fATWCpyfsu8eokdg_9aMAuGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/3] nbd-client: enter
 read_reply_co during init to avoid crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>

On Thu, Aug 24, 2017 at 5:21 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 24/08/2017 17:33, Stefan Hajnoczi wrote:
>> This patch enters read_reply_co directly in
>> nbd_client_attach_aio_context().  This is safe because new_context is
>> acquired by the caller.  This ensures that read_reply_co reaches its
>> first yield point and its ctx is set up.
>
> I'm not very confident with this patch.  aio_context_acquire/release is
> going to go away, and this then becomes possible
>
>         main context                    new_context
>         qemu_aio_coroutine_enter
>                                         send request
>                                         wait for reply
>         read first reply
>         wake coroutine
>
> where the "wake coroutine" part thinks it's running in new_context, and
> thus simply enters the coroutine instead of using the bottom half.
>
> But blk_co_preadv() should need the read_reply_co itself, in order to be
> woken up after reading the reply header.  The core issue here is that
> nbd_co_receive_reply was never called, I suspect.  And if it was never
> called, read_reply_co should not be woken up by nbd_coroutine_end.
>
> So the fix is:
>
> 1) assign NULL to s->recv_coroutine[i] when nbd_co_send_request fails
>
> 2) move this to nbd_co_receive_reply:
>
>     s->recv_coroutine[i] = NULL;
>
>     /* Kick the read_reply_co to get the next reply.  */
>     if (s->read_reply_co) {
>         aio_co_wake(s->read_reply_co);
>     }
>
> Does this make sense?  (Note that the read_reply_co idea actually came
> from you, or from my recollections of your proposed design :)).

Yes, I think that would work.

Stefan

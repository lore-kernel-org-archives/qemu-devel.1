Received: from eggs.gnu.org ([2001:4830:134:3::10]:60168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cywxH-0006rT-M8
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cywxG-0006iZ-NW
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:51:47 -0400
MIME-Version: 1.0
In-Reply-To: <20170414080206.2301-1-famz@redhat.com>
References: <20170414080206.2301-1-famz@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 14 Apr 2017 09:51:44 +0100
Message-ID: <CAJSP0QVbYRW0VD_1zUqU0T6V48wr_g3co8Dxs_ndpfA70d4TkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.9-rc5 v2] block: Drain
 BH in bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Apr 14, 2017 at 9:02 AM, Fam Zheng <famz@redhat.com> wrote:
> @@ -398,11 +399,15 @@ void bdrv_drain_all(void);
>           */                                                \
>          assert(!bs_->wakeup);                              \
>          bs_->wakeup = true;                                \
> -        while ((cond)) {                                   \
> -            aio_context_release(ctx_);                     \
> -            aio_poll(qemu_get_aio_context(), true);        \
> -            aio_context_acquire(ctx_);                     \
> -            waited_ = true;                                \
> +        while (busy_) {                                    \
> +            if ((cond)) {                                  \
> +                waited_ = busy_ = true;                    \
> +                aio_context_release(ctx_);                 \
> +                aio_poll(qemu_get_aio_context(), true);    \
> +                aio_context_acquire(ctx_);                 \
> +            } else {                                       \
> +                busy_ = aio_poll(ctx_, false);             \
> +            }                                              \

Wait, I'm confused.  The current thread is not in the BDS AioContext.
We're not allowed to call aio_poll(ctx_, false).

Did you mean aio_poll(qemu_get_aio_context(), false) in order to
process defer to main loop BHs?

Stefan

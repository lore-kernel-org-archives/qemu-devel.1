Received: from eggs.gnu.org ([2001:4830:134:3::10]:59212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fmz1K-0003on-St
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fmz1K-0006bg-1y
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:15:18 -0400
References: <20180807091655.32472-1-famz@redhat.com>
	<20180807091655.32472-3-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3ca9cf3e-6b95-76f4-e729-8abdc9a2c0b8@redhat.com>
Date: Tue, 7 Aug 2018 12:15:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180807091655.32472-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] aio: Do aio_notify_accept only
 during blocking aio_poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, lersek@redhat.com, qemu-block@nongnu.org

On 07/08/2018 11:16, Fam Zheng wrote:
>     main thread                     IO Thread
>     ===============================================================
>     bdrv_drained_begin()
>       aio_disable_external(ctx)
>                                     aio_poll(ctx, true)
>                                       ctx->notify_me += 2
>                                       ppoll() /* blocked */
>     ...
>     bdrv_drained_end()
>       ...
>         aio_notify()
>     ...
>     bdrv_set_aio_context()
>       aio_poll(ctx, false)
> [1]     aio_notify_accept(ctx)
>                                       /* Hang! */

Should ppoll() rather be after [1]?  Otherwise the new commit message
and patches look great.

> aio_notify() only injects an event when ctx->notify_me is set,
> correspondingly aio_notify_accept() is only useful when ctx->notify_me
> _was_ set.

Very good point.

(Please Cc qemu-stable on the second patch too).

Paolo

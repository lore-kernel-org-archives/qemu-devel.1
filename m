Received: from eggs.gnu.org ([2001:4830:134:3::10]:38808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coY6g-0000RL-PY
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coY6f-0006qg-UA
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:18:30 -0400
References: <1489680169-7638-1-git-send-email-pl@kamp.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <94b6f30b-4e91-1336-bad4-d5de16131407@redhat.com>
Date: Thu, 16 Mar 2017 17:18:16 +0100
MIME-Version: 1.0
In-Reply-To: <1489680169-7638-1-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9] thread-pool: add missing
 qemu_bh_cancel in completion function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@gmail.com, berrange@redhat.com, qemu-stable@nongnu.org



On 16/03/2017 17:02, Peter Lieven wrote:
> commit 3c80ca15 fixed a deadlock scenarion with nested aio_poll invocations.
> 
> However, the rescheduling of the completion BH introcuded unnecessary spinning
> in the main-loop. On very fast file backends this can even lead to the
> "WARNING: I/O thread spun for 1000 iterations" message popping up.
> 
> Callgrind reports about 3-4% less instructions with this patch running
> qemu-img bench on a ramdisk based VMDK file.
> 
> Fixes: 3c80ca158c96ff902a30883a8933e755988948b1
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  util/thread-pool.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/util/thread-pool.c b/util/thread-pool.c
> index ce6cd30..610646d 100644
> --- a/util/thread-pool.c
> +++ b/util/thread-pool.c
> @@ -188,6 +188,13 @@ restart:
>              aio_context_release(pool->ctx);
>              elem->common.cb(elem->common.opaque, elem->ret);
>              aio_context_acquire(pool->ctx);
> +
> +            /* We can safely cancel the completion_bh here regardless of someone
> +             * else having scheduled it meanwhile because we reenter the
> +             * completion function anyway (goto restart).
> +             */
> +            qemu_bh_cancel(pool->completion_bh);
> +
>              qemu_aio_unref(elem);
>              goto restart;
>          } else {
> 

Right, this is the same thing that block/linux-aio.c does.

Paolo

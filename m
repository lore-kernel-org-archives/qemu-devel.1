Received: from eggs.gnu.org ([2001:4830:134:3::10]:53097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egZC5-0005Dm-8R
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egZC4-000616-7o
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:55:37 -0500
Date: Tue, 30 Jan 2018 17:54:56 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180130165456.GD4503@localhost.localdomain>
References: <20180130153835.7372-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130153835.7372-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vl: pause vcpus before stopping iothreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>

Am 30.01.2018 um 16:38 hat Stefan Hajnoczi geschrieben:
> Commit dce8921b2baaf95974af8176406881872067adfa ("iothread: Stop threads
> before main() quits") introduced iothread_stop_all() to avoid the
> following virtio-scsi assertion failure:
> 
>   assert(blk_get_aio_context(d->conf.blk) == s->ctx);
> 
> Back then the assertion failed because when bdrv_close_all() made
> d->conf.blk NULL, blk_get_aio_context() returned the global AioContext
> instead of s->ctx.
> 
> The same assertion can still fail today when vcpus submit new I/O
> requests after iothread_stop_all() has moved the BDS to the global
> AioContext.
> 
> This patch hardens the iothread_stop_all() approach by pausing vcpus
> before calling iothread_stop_all().
> 
> Note that the assertion failure is a race condition.  It is not possible
> to reproduce it reliably.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Does pausing the vcpus actually make sure that the iothread isn't active
any more, or do we still have a small window where the vcpu is already
stopped, but the iothread is still processing requests?

Essentially, I think the bdrv_set_aio_context() in iothread_stop_all()
does either not have any effect, or if it does have an effect, it's
wrong. You can't just force an in-use BDS into a different AioContext
when the user that set the AioContext is still there.

At the very least, do we need a blk_drain_all() before stopping the
iothreads? It would still just be a hack, the proper way seens to be
getting the virtio device out of dataplane mode so that the iothread is
actually unused and doesn't just happen to not process something at the
moment.

Kevin

>  vl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index e517a8d995..011f22ae20 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4765,10 +4765,10 @@ int main(int argc, char **argv, char **envp)
>      os_setup_post();
>  
>      main_loop();
> +
>      replay_disable_events();
> +    pause_all_vcpus();
>      iothread_stop_all();
> -
> -    pause_all_vcpus();
>      bdrv_close_all();
>      res_free();
>  
> -- 
> 2.14.3
> 

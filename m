Received: from eggs.gnu.org ([2001:4830:134:3::10]:47316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cxwrX-0002mX-KV
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cxwrW-0008BC-Hu
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:33:43 -0400
Date: Tue, 11 Apr 2017 16:33:30 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170411143330.6knvf35j4hecolkz@eukaryote>
References: <1491919733-21065-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491919733-21065-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] sheepdog: Fix crash in
 co_read_response()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, mreitz@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Tue, Apr 11, 2017 at 04:08:53PM +0200, Kevin Wolf wrote:
> This fixes a regression introduced in commit 9d456654.
> 
> aio_co_wake() can only be used to reenter a coroutine that was already
> previously entered, otherwise co->ctx is uninitialised and we access
> garbage. Using it immediately after qemu_coroutine_create() like in
> co_read_response() is wrong and causes segfaults.
> 
> Replace the call with aio_co_enter(), which gets an explicit AioContext
> parameter and works even for new coroutines.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Tested-by: Kashyap Chamarthy <kchamart@redhat.com>

Thanks. 

The test evidence was posted on IRC.  But just for archives' sake, I was
here (on Git) when I applied this patch:

    $ git describe
    v2.9.0-rc3-45-gaa388dd

And that was the specific test:

	$ qemu-img convert -t directsync \
		./cirros-0.3.5.qcow2 sheepdog:cirros0.3.5vm

After applying this patch, the segfault is gone, and the `qemu-img convert`
happens successfully.

That was my Sheepdog environment:
https://kashyapc.fedorapeople.org/virt/sheepdog-qemu-corosync.txt

> ---
>  block/sheepdog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index 1b71fc8..142eb4f 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -942,7 +942,7 @@ static void co_read_response(void *opaque)
>          s->co_recv = qemu_coroutine_create(aio_read_response, opaque);
>      }
>  
> -    aio_co_wake(s->co_recv);
> +    aio_co_enter(s->aio_context, s->co_recv);
>  }
>  
>  static void co_write_request(void *opaque)
> -- 
> 1.8.3.1
> 

-- 
/kashyap

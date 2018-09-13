Received: from eggs.gnu.org ([2001:4830:134:3::10]:35643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0TSM-0000nT-5c
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0TSI-0007vP-Q4
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:22:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g0TSI-0007v2-Gf
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:22:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so6345271wre.2
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 08:22:54 -0700 (PDT)
References: <20180905112334.26911-1-slp@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d1767bb-9e4b-5ae8-49c1-81dffbefe0d7@redhat.com>
Date: Thu, 13 Sep 2018 17:22:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180905112334.26911-1-slp@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/linux-aio: acquire
 AioContext before qemu_laio_process_completions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

On 05/09/2018 13:23, Sergio Lopez wrote:
> diff --git a/block/linux-aio.c b/block/linux-aio.c
> index 19eb922fdd..217ce60138 100644
> --- a/block/linux-aio.c
> +++ b/block/linux-aio.c
> @@ -234,9 +234,9 @@ static void qemu_laio_process_completions(LinuxAioState *s)
>  
>  static void qemu_laio_process_completions_and_submit(LinuxAioState *s)
>  {
> +    aio_context_acquire(s->aio_context);
>      qemu_laio_process_completions(s);
>  
> -    aio_context_acquire(s->aio_context);
>      if (!s->io_q.plugged && !QSIMPLEQ_EMPTY(&s->io_q.pending)) {
>          ioq_submit(s);
>      }
> 

The patch is correct, but I think it's papering over the real issue; as
Kevin pointed out recently, the sticking issue is calling aio_poll from
other threads---which right now we're only doing in bdrv_set_aio_context
and bdrv_drain_poll_top_level.

As to the call in bdrv_drain(), Kevin has just posted the series to
remove it.

For the other one, I think we can replace it with AIO_WAIT_WHILE or
BDRV_POLL_WHILE and do the aio_poll in the BlockDriverState's home iothread.

That said, I have nothing against applying it since all it does is move
a function call, that can be removed completely once the underlying root
cause is fixed (the AioContext lock will disappear).

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo

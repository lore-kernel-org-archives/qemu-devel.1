Received: from eggs.gnu.org ([2001:4830:134:3::10]:60045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fKgIO-0002tj-5L
	for qemu-devel@nongnu.org; Mon, 21 May 2018 04:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fKgIN-0004h7-CJ
	for qemu-devel@nongnu.org; Mon, 21 May 2018 04:35:56 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:32785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fKgIN-0004gx-6r
	for qemu-devel@nongnu.org; Mon, 21 May 2018 04:35:55 -0400
Received: by mail-oi0-x242.google.com with SMTP id k5-v6so12317521oiw.0
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 01:35:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180521063516.5479-1-famz@redhat.com>
References: <20180521063516.5479-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 May 2018 09:35:34 +0100
Message-ID: <CAFEAcA9oCa926wr=-GL0uEUv3kEs2-X0LGfheY95raji13ckBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] nvme: Make nvme_init error handling code
 more readable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 21 May 2018 at 07:35, Fam Zheng <famz@redhat.com> wrote:
> Coverity doesn't like the tests under fail label (report CID 1385847).
> Reset the fields so the clean up order is more apparent.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/nvme.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/block/nvme.c b/block/nvme.c
> index 6f71122bf5..8239b920c8 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -560,6 +560,13 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>      qemu_co_queue_init(&s->dma_flush_queue);
>      s->nsid = namespace;
>      s->aio_context = bdrv_get_aio_context(bs);
> +
> +    /* Fields we've not touched should be zero-initialized by block layer
> +     * already, but reset them anyway to make the error handling code easier to
> +     * reason. */
> +    s->regs = NULL;
> +    s->vfio = NULL;
> +
>      ret = event_notifier_init(&s->irq_notifier, 0);
>      if (ret) {
>          error_setg(errp, "Failed to init event notifier");

I suspect that either coverity or some compilers will complain that
the assignment to s->vfio here is redundant, because we'll either
return early without looking at it, or we'll get to the assignment
 s->vfio = qemu_vfio_open_pci(...)
which overrides it.

thanks
-- PMM

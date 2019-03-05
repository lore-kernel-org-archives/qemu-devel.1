Received: from eggs.gnu.org ([209.51.188.92]:43813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1CbC-0006MV-QS
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1CbB-00073m-Gz
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:07:22 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:45150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1CbB-0006uK-7E
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:07:21 -0500
Received: by mail-ot1-x32a.google.com with SMTP id i12so7856345otp.12
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:07:09 -0800 (PST)
MIME-Version: 1.0
References: <20190221173326.31874-1-mst@redhat.com>
	<20190214043916.22128-6-david@gibson.dropbear.id.au>
In-Reply-To: <20190214043916.22128-6-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2019 16:06:54 +0000
Message-ID: <CAFEAcA_Xc6A017YJNvxHReC_D2d0C4cJ_pbro+E3EEcGLfbhhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 23/26] virtio-balloon: Safely handle
 BALLOON_PAGE_SIZE < host page size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 22 Feb 2019 at 02:41, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: David Gibson <david@gibson.dropbear.id.au>
>
> The virtio-balloon always works in units of 4kiB (BALLOON_PAGE_SIZE), but
> we can only actually discard memory in units of the host page size.

Hi -- Coverity points out an issue in this patch (CID 1399146):

> +    /* Hard case
> +     *
> +     * We've put a piece of a larger host page into the balloon - we
> +     * need to keep track until we have a whole host page to
> +     * discard
> +     */
> +    warn_report_once(
> +"Balloon used with backing page size > 4kiB, this may not be reliable");
> +
> +    subpages = rb_page_size / BALLOON_PAGE_SIZE;
> +
> +    if (balloon->pbp
> +        && (rb != balloon->pbp->rb
> +            || host_page_base != balloon->pbp->base)) {
> +        /* We've partially ballooned part of a host page, but now
> +         * we're trying to balloon part of a different one.  Too hard,
> +         * give up on the old partial page */
> +        free(balloon->pbp);
> +        balloon->pbp = NULL;
>      }
>
> -    ram_block_discard_range(rb, ram_offset, rb_page_size);
> -    /* We ignore errors from ram_block_discard_range(), because it has
> -     * already reported them, and failing to discard a balloon page is
> -     * not fatal */
> +    if (!balloon->pbp) {
> +        /* Starting on a new host page */
> +        size_t bitlen = BITS_TO_LONGS(subpages) * sizeof(unsigned long);
> +        balloon->pbp = g_malloc0(sizeof(PartiallyBalloonedPage) + bitlen);


We allocate balloon->pbp with g_malloc0() here...

> +        balloon->pbp->rb = rb;
> +        balloon->pbp->base = host_page_base;
> +    }
> +
> +    bitmap_set(balloon->pbp->bitmap,
> +               (ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
> +               subpages);
> +
> +    if (bitmap_full(balloon->pbp->bitmap, subpages)) {
> +        /* We've accumulated a full host page, we can actually discard
> +         * it now */
> +
> +        ram_block_discard_range(rb, balloon->pbp->base, rb_page_size);
> +        /* We ignore errors from ram_block_discard_range(), because it
> +         * has already reported them, and failing to discard a balloon
> +         * page is not fatal */
> +
> +        free(balloon->pbp);

...but we free it (here and elsewhere) with free(), not g_free().


thanks
-- PMM

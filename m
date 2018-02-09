Received: from eggs.gnu.org ([2001:4830:134:3::10]:32799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ekBXU-0005ij-Pi
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:28:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ekBXP-00077K-TZ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:28:40 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ekBXP-00076x-MY
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:28:35 -0500
Received: by mail-wm0-f41.google.com with SMTP id r78so17371493wme.0
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 08:28:35 -0800 (PST)
References: <20180208171807.24267-1-stefanha@redhat.com>
	<20180208171807.24267-2-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea22850e-f1b3-bcdd-db48-b6060e468296@redhat.com>
Date: Fri, 9 Feb 2018 17:28:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180208171807.24267-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] block: add BlockBackend->in_flight
 counter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On 08/02/2018 18:18, Stefan Hajnoczi wrote:
> +    BlockDriverState *bs = blk_bs(blk);
> +
> +    if (bs) {
> +        bdrv_drained_begin(bs);
> +    }
> +
> +    /* We may have aio requests like -ENOMEDIUM in flight */
> +    while (atomic_mb_read(&blk->in_flight) > 0) {
> +        aio_poll(blk_get_aio_context(blk), true);
> +    }
> +
> +    if (bs) {
> +        bdrv_drained_end(bs);

This only works if you are in the default AioContext, otherwise you can
run handlers for one AioContexts in two threads.

bdrv_dec_in_flight uses bdrv_wakeup and BDRV_POLL_WHILE to ensure that
this doesn't happen, so there would be more code that you have to copy
into block-backend.c.

Paolo

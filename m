Received: from eggs.gnu.org ([2001:4830:134:3::10]:53639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUXWS-0007d7-QL
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUXWP-0008Br-Kd
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:10:40 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:34994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUXWP-0008Ab-8v
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:10:37 -0400
Received: by mail-wr0-f182.google.com with SMTP id k67so135625033wrc.2
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 05:10:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499687125-22948-1-git-send-email-kwolf@redhat.com>
References: <1499687125-22948-1-git-send-email-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2017 13:09:15 +0100
Message-ID: <CAFEAcA_2dB3rN6mJcwrxShPaEO8dEzoNU27dTkWC3jjnjRPC6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] commit: Add NULL check for overlay_bs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 10 July 2017 at 12:45, Kevin Wolf <kwolf@redhat.com> wrote:
> I can't see how overlay_bs could become NULL with the current code, but
> other code in this function already checks it and we can make Coverity
> happy with this check, so let's add it.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/commit.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/block/commit.c b/block/commit.c
> index 774a8a5..50e7950 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -90,7 +90,9 @@ static void commit_complete(BlockJob *job, void *opaque)
>
>      /* Make sure overlay_bs and top stay around until bdrv_set_backing_hd() */
>      bdrv_ref(top);
> -    bdrv_ref(overlay_bs);
> +    if (overlay_bs) {
> +        bdrv_ref(overlay_bs);
> +    }
>
>      /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
>       * the normal backing chain can be restored. */
> --
> 1.8.3.1

Commit 19ebd13ed45ad5d5f2 which added the bdrv_ref() call
was cc qemu-stable; should we cc this fix too, or are you
happy that it's definitely not actually triggerable in stable?

thanks
-- PMM

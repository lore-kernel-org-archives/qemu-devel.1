Received: from eggs.gnu.org ([209.51.188.92]:40746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guLRP-0003Sf-Pv
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guLRO-00008Y-VY
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:08:55 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guLRO-000081-QS
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:08:54 -0500
Received: by mail-ot1-x344.google.com with SMTP id v62so3239698otb.3
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 10:08:54 -0800 (PST)
MIME-Version: 1.0
References: <20190122173111.29821-1-dgilbert@redhat.com>
In-Reply-To: <20190122173111.29821-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 18:08:41 +0000
Message-ID: <CAFEAcA_1SMNULOgVkN2qmwkHt26WPC4o2+aRkjLwLwC5-hubpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] migration/rdma: unegister fd handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, jemmy858585@gmail.com, Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>

On Tue, 22 Jan 2019 at 19:08, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Unregister the fd handler before we destroy the channel,
> otherwise we've got a race where we might land in the
> fd handler just as we're closing the device.
>
> (The race is quite data dependent, you just have to have
> the right set of devices for it to trigger).
>
> Corresponds to RH bz: https://bugzilla.redhat.com/show_bug.cgi?id=1666601
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/rdma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 9b2e7e10aa..54a3c11540 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2321,6 +2321,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
>          rdma->connected = false;
>      }
>
> +    qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
>      g_free(rdma->dest_blocks);
>      rdma->dest_blocks = NULL;

Hi -- this patch makes coverity complain (CID 1398634),
because here we use rdma->channel without checking that it is NULL,
but later in the function we have an "if (rdma->channel)" test.
Should this code be conditional on rmda->channel being non-NULL,
or is the later test incorrect?

thanks
-- PMM

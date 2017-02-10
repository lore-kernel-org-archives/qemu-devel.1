Received: from eggs.gnu.org ([2001:4830:134:3::10]:33850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ccKKn-0005FR-Me
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 18:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ccKKm-0000XG-8Y
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 18:10:33 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:33279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ccKKm-0000XB-4Q
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 18:10:32 -0500
Received: by mail-ot0-x242.google.com with SMTP id f9so5256010otd.0
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 15:10:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170208064212.25307-3-ppandit@redhat.com>
References: <20170208064212.25307-1-ppandit@redhat.com>
	<20170208064212.25307-3-ppandit@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Feb 2017 15:10:00 -0800
Message-ID: <CAKmqyKPav7yy6mPDWLQLOSwYT0qgOss1DAhtNC_Yn9Cvrp7pYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 2/3] sd: sdhci: conditionally invoke
 multi block transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>

On Tue, Feb 7, 2017 at 10:42 PM, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> In sdhci_write invoke multi block transfer if it is enabled
> in the transfer mode register 's->trnmod'.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/sd/sdhci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index cf400c8..532ef87 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1022,7 +1022,11 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>          /* Writing to last byte of sdmasysad might trigger transfer */
>          if (!(mask & 0xFF000000) && TRANSFERRING_DATA(s->prnsts) && s->blkcnt &&
>                  s->blksize && SDHC_DMA_TYPE(s->hostctl) == SDHC_CTRL_SDMA) {
> -            sdhci_sdma_transfer_multi_blocks(s);
> +            if (!(s->trnmod & SDHC_TRNS_MULTI)) {

You should test if true first.

Thanks,

Alistair

> +                sdhci_sdma_transfer_single_block(s);
> +            } else {
> +                sdhci_sdma_transfer_multi_blocks(s);
> +            }
>          }
>          break;
>      case SDHC_BLKSIZE:
> --
> 2.9.3
>

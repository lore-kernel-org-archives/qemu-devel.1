Received: from eggs.gnu.org ([2001:4830:134:3::10]:44407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cbEzu-0005D1-VP
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:16:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cbEzt-0007MS-T5
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:16:30 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1cbEzt-0007LZ-OJ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:16:29 -0500
Received: by mail-oi0-x244.google.com with SMTP id u143so9948494oif.3
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 15:16:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170131122416.10284-3-ppandit@redhat.com>
References: <20170131122416.10284-1-ppandit@redhat.com>
	<20170131122416.10284-3-ppandit@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 7 Feb 2017 15:15:58 -0800
Message-ID: <CAKmqyKOJriCzL+bFN4Q=nAiUHCy0expryDW+EzfscW5gr8BjRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 2/2] sd: sdhci: block count enable not
 relevant in single block transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>

On Tue, Jan 31, 2017 at 4:24 AM, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> In SDHCI device emulation the 'Block count enable' bit

Can you say 'In the SDHCI protocol' instead of 'SDHCI device emulation'?

I feel like saying device emulation makes it sound like we are
behaving different then hardware.

Also maybe the title should be something more like:
sd: sdhci: Remove block count enable check in single block transfers
to make it clearer.

> of the Transfer Mode register is only relevant in multi block
> transfers. We need not check it in single block transfers.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

The functionality looks good to me.

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

> ---
>  hw/sd/sdhci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 150464f..d921423 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -570,7 +570,6 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
>  }
>
>  /* single block SDMA transfer */
> -
>  static void sdhci_sdma_transfer_single_block(SDHCIState *s)
>  {
>      int n;
> @@ -589,10 +588,7 @@ static void sdhci_sdma_transfer_single_block(SDHCIState *s)
>              sdbus_write_data(&s->sdbus, s->fifo_buffer[n]);
>          }
>      }
> -
> -    if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
> -        s->blkcnt--;
> -    }
> +    s->blkcnt--;
>
>      sdhci_end_transfer(s);
>  }
> --
> 2.9.3
>
>

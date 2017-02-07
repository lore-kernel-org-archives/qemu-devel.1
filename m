Received: from eggs.gnu.org ([2001:4830:134:3::10]:52371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cbDmO-0001Wm-2X
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 16:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cbDmN-00032H-2B
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 16:58:28 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1cbDmM-00031x-U2
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 16:58:26 -0500
Received: by mail-ot0-x241.google.com with SMTP id 73so15794196otj.1
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 13:58:25 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <alpine.LFD.2.20.1702080036340.11236@wniryva>
References: <20170131122416.10284-1-ppandit@redhat.com>
	<CAFEAcA_GoD3h2tfM7R5mBQPV9V4bCkA5oKL9EYXiaGq2Gbd3DQ@mail.gmail.com>
	<alpine.LFD.2.20.1702080036340.11236@wniryva>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 7 Feb 2017 13:57:54 -0800
Message-ID: <CAKmqyKO4naDbnYVV8eBkXJ+TBxxjwCTUN8D=VqAu3e2K=Zre6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 0/2] sd: sdhci: correct transfer mode
 register usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, Jiang Xin <jiangxin1@huawei.com>, Qemu Developers <qemu-devel@nongnu.org>, Wjjzhang <wjjzhang@tencent.com>

On Tue, Feb 7, 2017 at 11:12 AM, P J P <ppandit@redhat.com> wrote:
> +-- On Tue, 7 Feb 2017, Peter Maydell wrote --+
> | On 31 January 2017 at 12:24, P J P <ppandit@redhat.com> wrote:
> | > In SDHCI emulation, the 'Block Count Enable' bit of the Transfer Mode
> | > register is used to control 's->blkcnt' value. One, this bit is not
> | > relevant in single block transfers. Second, Transfer Mode register
> | > value could be set such that 's->blkcnt' would not see an update
> | > during multi block transfers. Thus leading to an infinite loop.
> | >
> | > This patch set attempts to correct 'Block Count Enable' bit usage.
> |
> | Edgar, Alistair: the zynq models are our major SDHCI user -- would
> | you like to have a look at this patchset, please?

Yeah, I'll have a look.

>
> I suspect following patch would also be required along with the two in this
> series, not sure.
>
> ===
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index d921423..7f3d547 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1019,7 +1019,11 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val,
> unsigned size)
>          /* Writing to last byte of sdmasysad might trigger transfer */
>          if (!(mask & 0xFF000000) && TRANSFERRING_DATA(s->prnsts) && s->blkcnt
> &&
>                  s->blksize && SDHC_DMA_TYPE(s->hostctl) == SDHC_CTRL_SDMA) {
> -            sdhci_sdma_transfer_multi_blocks(s);
> +            if (!(s->trnmod & SDHC_TRNS_MULTI)) {
> +                sdhci_sdma_transfer_single_block(s);
> +            } else {
> +                sdhci_sdma_transfer_multi_blocks(s);
> +            }
>          }
>          break;
>      case SDHC_BLKSIZE:
> ===
>
> Could you please have a look this one too?

Sorry I'm confused. Should this be a third patch or is this in a
different series?

Thanks,

Alistair

>
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
>

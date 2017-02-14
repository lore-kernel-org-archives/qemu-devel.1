Received: from eggs.gnu.org ([2001:4830:134:3::10]:35743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cdiWv-0003Hc-6M
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:12:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cdiWt-0001ZX-Dc
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:12:49 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1cdiWt-0001ZE-8p
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:12:47 -0500
Received: by mail-oi0-x244.google.com with SMTP id j15so1964121oih.0
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 11:12:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170214185225.7994-2-ppandit@redhat.com>
References: <20170214185225.7994-1-ppandit@redhat.com>
	<20170214185225.7994-2-ppandit@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 Feb 2017 11:12:16 -0800
Message-ID: <CAKmqyKMRi3kyo5h0sfiZo9MeiH+CyAvk_bjwDipjBQ69XiJwyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v4 1/4] sd: sdhci: mask transfer mode
 register value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

On Tue, Feb 14, 2017 at 10:52 AM, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> In SDHCI protocol, the transfer mode register is defined
> to be of 6 bits. Mask its value with '0x0037' so that an
> invalid value could not be assigned.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

> ---
>  hw/sd/sdhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Update per: use macro for the mask value
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02774.html
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 5bd5ab6..cf647fa 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -119,6 +119,7 @@
>      (SDHC_CAPAB_BASECLKFREQ << 8) | (SDHC_CAPAB_TOUNIT << 7) | \
>      (SDHC_CAPAB_TOCLKFREQ))
>
> +#define MASK_TRNMOD     0x0037
>  #define MASKED_WRITE(reg, mask, val)  (reg = (reg & (mask)) | (val))
>
>  static uint8_t sdhci_slotint(SDHCIState *s)
> @@ -1050,7 +1051,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>          if (!(s->capareg & SDHC_CAN_DO_DMA)) {
>              value &= ~SDHC_TRNS_DMA;
>          }
> -        MASKED_WRITE(s->trnmod, mask, value);
> +        MASKED_WRITE(s->trnmod, mask, value & MASK_TRNMOD);
>          MASKED_WRITE(s->cmdreg, mask >> 16, value >> 16);
>
>          /* Writing to the upper byte of CMDREG triggers SD command generation */
> --
> 2.9.3

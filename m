Received: from eggs.gnu.org ([2001:4830:134:3::10]:43883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cdMgV-0001UJ-H5
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cdMgU-0005TH-0n
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:53:15 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:34002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1cdMgT-0005Sh-SF
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:53:13 -0500
Received: by mail-oi0-x242.google.com with SMTP id w144so492185oiw.1
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 11:53:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170211150701.23391-3-ppandit@redhat.com>
References: <20170211150701.23391-1-ppandit@redhat.com>
	<20170211150701.23391-3-ppandit@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Feb 2017 11:52:40 -0800
Message-ID: <CAKmqyKPAFKfe8e56d5D302tzHKm5mppOwCe5fUWU2vLAWuyBfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 2/4] sd: sdhci: mask transfer mode
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

On Sat, Feb 11, 2017 at 7:06 AM, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> In SDHCI protocol, the transfer mode register is defined
> to be of 6 bits. Mask its value with '0x0037' so that an
> invalid value couldn't be assigned.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/sd/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Update: mask s->trnmod register value
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02354.html
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index a9c744b..0307b8c 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1050,7 +1050,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>          if (!(s->capareg & SDHC_CAN_DO_DMA)) {
>              value &= ~SDHC_TRNS_DMA;
>          }
> -        MASKED_WRITE(s->trnmod, mask, value);
> +        MASKED_WRITE(s->trnmod, mask, value & 0x0037);

This looks good.

Can you use a macro for the value so then it is explained and easier
to change in the future?

Once you have done that:

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

>          MASKED_WRITE(s->cmdreg, mask >> 16, value >> 16);
>
>          /* Writing to the upper byte of CMDREG triggers SD command generation */
> --
> 2.9.3
>

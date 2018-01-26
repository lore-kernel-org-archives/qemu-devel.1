Received: from eggs.gnu.org ([2001:4830:134:3::10]:40995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef6zw-0005xe-6o
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef6zv-0001ae-9R
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:37:04 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:37943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ef6zv-0001Zy-3n
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:37:03 -0500
Received: by mail-oi0-x241.google.com with SMTP id 5so682749oip.5
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 08:37:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5A6B5091.8030601@hisilicon.com>
References: <5A6B5091.8030601@hisilicon.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2018 16:36:41 +0000
Message-ID: <CAFEAcA_39SgDKFnkrcVePs89kYUMHvqqAdnkFhrCa=GYTu0Kpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] pl011: do not put into fifo
 before enabled the interruption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Xu <xuwei5@hisilicon.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>, Rob Herring <rob.herring@linaro.org>, Daode Huang <huangdaode@hisilicon.com>, "Chenxin (Charles)" <charles.chenxin@huawei.com>, Zhangyi ac <zhangyi.ac@huawei.com>, "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>, tiantao6@huawei.com

On 26 January 2018 at 16:00, Wei Xu <xuwei5@hisilicon.com> wrote:
> If the user pressed some keys in the console during the guest booting,
> the console will be hanged after entering the shell.
> Because in the above case the pl011_can_receive will return 0 that
> the pl011_receive will not be called. That means no interruption will
> be injected in to the kernel and the pl011 state could not be driven
> further.
>
> This patch fixed that issue by checking the interruption is enabled or
> not before putting into the fifo.
>
> Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
> ---
>  hw/char/pl011.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 2aa277fc4f..6296de9527 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -229,6 +229,8 @@ static int pl011_can_receive(void *opaque)
>      PL011State *s = (PL011State *)opaque;
>      int r;
>
> +    if (!s->int_enabled)
> +       return 0;
>      if (s->lcr & 0x10) {
>          r = s->read_count < 16;
>      } else {
> --

This doesn't look right. You should be able to use the PL011
in a strictly polling mode, without ever enabling interrupts.
Returning false in can_receive if interrupts are disabled
would break that.

If the user presses keys before interrupts are enabled,
what ought to happen is:
 * we put the key in the FIFO, and update the int_level flags
 * when the FIFO is full, can_receive starts returning 0 and
   QEMU stops passing us new characters
 * when the guest driver for the pl011 initializes the
   device and enables interrupts then either:
    (a) it does something that clears the FIFO, which will
    mean can_receive starts allowing new chars again, or
    (b) it leaves the FIFO as it is, and we should thus
    immediately raise an interrupt for the characters still
    in the FIFO; when the guest handles this interrupt and
    gets the characters, can_receive will permit new ones

What is happening in your situation that means this is not
working as expected ?

thanks
-- PMM

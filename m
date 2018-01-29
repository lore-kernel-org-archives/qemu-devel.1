Received: from eggs.gnu.org ([2001:4830:134:3::10]:33433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eg9cG-0003w0-Eb
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eg9cF-0002AY-D6
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:36:56 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:32780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eg9cF-000298-7N
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:36:55 -0500
Received: by mail-ot0-x241.google.com with SMTP id d7so6543271oti.0
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 05:36:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5A6F10F8.7000904@hisilicon.com>
References: <5A6B5091.8030601@hisilicon.com>
	<CAFEAcA_39SgDKFnkrcVePs89kYUMHvqqAdnkFhrCa=GYTu0Kpw@mail.gmail.com>
	<5A6B5FCA.2080009@hisilicon.com>
	<CAFEAcA-N-pjHwqrStf-qK+EOmGYyR-4dfY=sL5kLzeodgYUiRw@mail.gmail.com>
	<5A6B6671.8070408@hisilicon.com>
	<CAFEAcA-_vYgDYofx61rmCL7sZKOVSBHfw0k3us1=SHzD+TEnGw@mail.gmail.com>
	<5A6F10F8.7000904@hisilicon.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2018 13:36:33 +0000
Message-ID: <CAFEAcA8fi5VgY4KZqG0_7BXjY81Qg+bGdyf8dcvUMy9wRZtvag@mail.gmail.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>, Rob Herring <rob.herring@linaro.org>, Daode Huang <huangdaode@hisilicon.com>, "Chenxin (Charles)" <charles.chenxin@huawei.com>, Zhangyi ac <zhangyi.ac@huawei.com>, "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>, tiantao6@huawei.com, Marc Zyngier <marc.zyngier@arm.com>

On 29 January 2018 at 12:18, Wei Xu <xuwei5@hisilicon.com> wrote:
> On 2018/1/26 18:01, Peter Maydell wrote:
>> No, that's not right either. int_level should already have the
>> RX bit set, because pl011_put_fifo() sets that bit when it gets a
>> character from QEMU and puts it into the FIFO.
>>
>> Does something else clear the int_level between the character
>> going into the FIFO from QEMU and the guest enabling
>> interrupts?
>
> Yes. When the guest enabling the interrupts, the pl011 driver in
> the kernel will clear the RX interrupts[1].
> And pasted the code below to make it easy to read.
>
>         static void pl011_enable_interrupts(struct uart_amba_port *uap)
>         {
>                 spin_lock_irq(&uap->port.lock);
>
>                 /* Clear out any spuriously appearing RX interrupts */
>                 pl011_write(UART011_RTIS | UART011_RXIS, uap, REG_ICR);
>                 uap->im = UART011_RTIM;
>                 if (!pl011_dma_rx_running(uap))
>                 uap->im |= UART011_RXIM;
>                 pl011_write(uap->im, uap, REG_IMSC);
>                 spin_unlock_irq(&uap->port.lock);
>         }
>

This seems at first glance like a kernel driver bug to me -- if it is
explicitly killing off the pending interrupt without handling
it then it's naturally going to get stuck if characters come
in in the window before it does that.

(It wouldn't surprise me if there's something in the driver
init sequence that has the effect of clearing the FIFO on
real hardware but not QEMU, which would mean that on real
h/w the window where this can happen would be small, but it's
still there.)

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xuwei5@huawei.com>) id 1eg8Oc-00051N-Kz
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xuwei5@huawei.com>) id 1eg8OY-0001Sn-8t
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:18:46 -0500
References: <5A6B5091.8030601@hisilicon.com>
	<CAFEAcA_39SgDKFnkrcVePs89kYUMHvqqAdnkFhrCa=GYTu0Kpw@mail.gmail.com>
	<5A6B5FCA.2080009@hisilicon.com>
	<CAFEAcA-N-pjHwqrStf-qK+EOmGYyR-4dfY=sL5kLzeodgYUiRw@mail.gmail.com>
	<5A6B6671.8070408@hisilicon.com>
	<CAFEAcA-_vYgDYofx61rmCL7sZKOVSBHfw0k3us1=SHzD+TEnGw@mail.gmail.com>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5A6F10F8.7000904@hisilicon.com>
Date: Mon, 29 Jan 2018 12:18:00 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-_vYgDYofx61rmCL7sZKOVSBHfw0k3us1=SHzD+TEnGw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>, Rob Herring <rob.herring@linaro.org>, Daode Huang <huangdaode@hisilicon.com>, "Chenxin (Charles)" <charles.chenxin@huawei.com>, Zhangyi ac <zhangyi.ac@huawei.com>, "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>, tiantao6@huawei.com, Marc Zyngier <marc.zyngier@arm.com>

Hi Peter,

On 2018/1/26 18:01, Peter Maydell wrote:
> On 26 January 2018 at 17:33, Wei Xu <xuwei5@hisilicon.com> wrote:
>> On 2018/1/26 17:15, Peter Maydell wrote:
>>> The pl011 code should call qemu_set_irq(..., 1) when the
>>> guest enables interrupts on the device by writing to the int_enabled
>>> (UARTIMSC) register. That will be a 0-to-1 level change and the KVM
>>> VGIC should report the interrupt to the guest.
>>>
>>
>> Yes.
>> And in the pl011_update, the irq level is set by s->int_level & s->int_enabled.
>> When writing to the int_enabled, not sure why the int_level is set to
>> 0x20(PL011_INT_TX) but int_enabled is 0x50.
>>
>> It still call qemu_set_irq(..., 0).
>>
>> I added "s->int_level |= PL011_INT_RX" before calling pl011_update
>> when writing to the int_enabled and tested it also works.
> 
> No, that's not right either. int_level should already have the
> RX bit set, because pl011_put_fifo() sets that bit when it gets a
> character from QEMU and puts it into the FIFO.
> 
> Does something else clear the int_level between the character
> going into the FIFO from QEMU and the guest enabling
> interrupts?

Yes. When the guest enabling the interrupts, the pl011 driver in
the kernel will clear the RX interrupts[1].
And pasted the code below to make it easy to read.

	static void pl011_enable_interrupts(struct uart_amba_port *uap)
	{
		spin_lock_irq(&uap->port.lock);

		/* Clear out any spuriously appearing RX interrupts */
		pl011_write(UART011_RTIS | UART011_RXIS, uap, REG_ICR);
		uap->im = UART011_RTIM;
		if (!pl011_dma_rx_running(uap))
		uap->im |= UART011_RXIM;
		pl011_write(uap->im, uap, REG_IMSC);
		spin_unlock_irq(&uap->port.lock);
	}

I tried kept the RXIS in the kernel side to test and found the issue is still there.
A little confused now :(

[1]: https://elixir.free-electrons.com/linux/latest/source/drivers/tty/serial/amba-pl011.c#L1732

Best Regards,
Wei

> 
> thanks
> -- PMM
> 
> .
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef8K3-0006oS-GM
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:01:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef8K2-0004W7-Ml
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:01:55 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:39234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ef8K2-0004Vl-IO
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:01:54 -0500
Received: by mail-ot0-x235.google.com with SMTP id d9so1125668oth.6
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 10:01:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5A6B6671.8070408@hisilicon.com>
References: <5A6B5091.8030601@hisilicon.com>
	<CAFEAcA_39SgDKFnkrcVePs89kYUMHvqqAdnkFhrCa=GYTu0Kpw@mail.gmail.com>
	<5A6B5FCA.2080009@hisilicon.com>
	<CAFEAcA-N-pjHwqrStf-qK+EOmGYyR-4dfY=sL5kLzeodgYUiRw@mail.gmail.com>
	<5A6B6671.8070408@hisilicon.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2018 18:01:33 +0000
Message-ID: <CAFEAcA-_vYgDYofx61rmCL7sZKOVSBHfw0k3us1=SHzD+TEnGw@mail.gmail.com>
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

On 26 January 2018 at 17:33, Wei Xu <xuwei5@hisilicon.com> wrote:
> On 2018/1/26 17:15, Peter Maydell wrote:
>> The pl011 code should call qemu_set_irq(..., 1) when the
>> guest enables interrupts on the device by writing to the int_enabled
>> (UARTIMSC) register. That will be a 0-to-1 level change and the KVM
>> VGIC should report the interrupt to the guest.
>>
>
> Yes.
> And in the pl011_update, the irq level is set by s->int_level & s->int_enabled.
> When writing to the int_enabled, not sure why the int_level is set to
> 0x20(PL011_INT_TX) but int_enabled is 0x50.
>
> It still call qemu_set_irq(..., 0).
>
> I added "s->int_level |= PL011_INT_RX" before calling pl011_update
> when writing to the int_enabled and tested it also works.

No, that's not right either. int_level should already have the
RX bit set, because pl011_put_fifo() sets that bit when it gets a
character from QEMU and puts it into the FIFO.

Does something else clear the int_level between the character
going into the FIFO from QEMU and the guest enabling
interrupts?

thanks
-- PMM

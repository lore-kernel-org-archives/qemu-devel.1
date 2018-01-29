Received: from eggs.gnu.org ([2001:4830:134:3::10]:57246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eg7Kv-0004in-2w
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eg7Kt-0004Ir-R3
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:10:53 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:33711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eg7Kt-0004Hv-LK
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:10:51 -0500
Received: by mail-ot0-x242.google.com with SMTP id d7so6171910oti.0
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 03:10:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180129102917.3olxduibcwdqgqls@hawk.localdomain>
References: <5A6B5091.8030601@hisilicon.com>
	<CAFEAcA_39SgDKFnkrcVePs89kYUMHvqqAdnkFhrCa=GYTu0Kpw@mail.gmail.com>
	<5A6B5FCA.2080009@hisilicon.com>
	<CAFEAcA-N-pjHwqrStf-qK+EOmGYyR-4dfY=sL5kLzeodgYUiRw@mail.gmail.com>
	<5A6B6671.8070408@hisilicon.com>
	<CAFEAcA-_vYgDYofx61rmCL7sZKOVSBHfw0k3us1=SHzD+TEnGw@mail.gmail.com>
	<20180129102917.3olxduibcwdqgqls@hawk.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2018 11:10:30 +0000
Message-ID: <CAFEAcA9y=T0Pd_Zv5zSjT0ZhiKmD__zrS+fP7AU0AC5j_v6c+g@mail.gmail.com>
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
To: Andrew Jones <drjones@redhat.com>
Cc: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <rob.herring@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, "Chenxin (Charles)" <charles.chenxin@huawei.com>, tiantao6@huawei.com, QEMU Developers <qemu-devel@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Linuxarm <linuxarm@huawei.com>, "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>, qemu-arm <qemu-arm@nongnu.org>, Daode Huang <huangdaode@hisilicon.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>, Zhangyi ac <zhangyi.ac@huawei.com>

On 29 January 2018 at 10:29, Andrew Jones <drjones@redhat.com> wrote:
> On Fri, Jan 26, 2018 at 06:01:33PM +0000, Peter Maydell wrote:
>> On 26 January 2018 at 17:33, Wei Xu <xuwei5@hisilicon.com> wrote:
>> > On 2018/1/26 17:15, Peter Maydell wrote:
>> >> The pl011 code should call qemu_set_irq(..., 1) when the
>> >> guest enables interrupts on the device by writing to the int_enabled
>> >> (UARTIMSC) register. That will be a 0-to-1 level change and the KVM
>> >> VGIC should report the interrupt to the guest.
>> >>
>> >
>> > Yes.
>> > And in the pl011_update, the irq level is set by s->int_level & s->int_enabled.
>> > When writing to the int_enabled, not sure why the int_level is set to
>> > 0x20(PL011_INT_TX) but int_enabled is 0x50.
>> >
>> > It still call qemu_set_irq(..., 0).
>> >
>> > I added "s->int_level |= PL011_INT_RX" before calling pl011_update
>> > when writing to the int_enabled and tested it also works.
>>
>> No, that's not right either. int_level should already have the
>> RX bit set, because pl011_put_fifo() sets that bit when it gets a
>> character from QEMU and puts it into the FIFO.
>>
>> Does something else clear the int_level between the character
>> going into the FIFO from QEMU and the guest enabling
>> interrupts?
>
> As part of the boot process Linux restarts the UART a few times. When
> Linux drives the PL011 with the SBSA driver then the FIFO doesn't get
> reset prior to being used again, as the SBSA doesn't specify a way to
> do that.

Right, but the FIFO not being cleared shouldn't be a problem --
if the FIFO is still full then the int_level should still
indicate that so that when the Linux driver enables interrupts
it takes an interrupt (and the handler should then drain the
FIFO by reading characters from it).

It seems likely that there's a bug in QEMU's pl011 model (this doesn't
happen with real hardware PL011s, I assume) -- but we need to find
out what the divergence from the hardware is, rather than making
changes which happen to fix the symptoms without having first
nailed down what the underlying cause is.

thanks
-- PMM

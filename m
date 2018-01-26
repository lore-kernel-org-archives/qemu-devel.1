Received: from eggs.gnu.org ([2001:4830:134:3::10]:60768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xuwei5@huawei.com>) id 1ef7tA-0001l8-AF
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:34:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xuwei5@huawei.com>) id 1ef7t9-0007Bj-Am
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:34:08 -0500
References: <5A6B5091.8030601@hisilicon.com>
	<CAFEAcA_39SgDKFnkrcVePs89kYUMHvqqAdnkFhrCa=GYTu0Kpw@mail.gmail.com>
	<5A6B5FCA.2080009@hisilicon.com>
	<CAFEAcA-N-pjHwqrStf-qK+EOmGYyR-4dfY=sL5kLzeodgYUiRw@mail.gmail.com>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5A6B6671.8070408@hisilicon.com>
Date: Fri, 26 Jan 2018 17:33:37 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-N-pjHwqrStf-qK+EOmGYyR-4dfY=sL5kLzeodgYUiRw@mail.gmail.com>
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

On 2018/1/26 17:15, Peter Maydell wrote:
> On 26 January 2018 at 17:05, Wei Xu <xuwei5@hisilicon.com> wrote:
>> On 2018/1/26 16:36, Peter Maydell wrote:
>>> If the user presses keys before interrupts are enabled,
>>> what ought to happen is:
>>>  * we put the key in the FIFO, and update the int_level flags
>>>  * when the FIFO is full, can_receive starts returning 0 and
>>>    QEMU stops passing us new characters
>>>  * when the guest driver for the pl011 initializes the
>>>    device and enables interrupts then either:
>>>     (a) it does something that clears the FIFO, which will
>>>     mean can_receive starts allowing new chars again, or
>>>     (b) it leaves the FIFO as it is, and we should thus
>>>     immediately raise an interrupt for the characters still
>>>     in the FIFO; when the guest handles this interrupt and
>>>     gets the characters, can_receive will permit new ones
>>>
>>
>> Yes, now it is handled like b.
>>
>>> What is happening in your situation that means this is not
>>> working as expected ?
>>
>> But in the kernel side, the pll011 is triggered as a level interruption.
>> During the booting, if any key is pressed ,the call stack is as below:
>> QEMU side:
>> pl011_update
>> -->qemu_set_irq(level as 0)
>> ---->kvm_arm_gic_set_irq
>>
>> Kernel side:
>> kvm_vm_ioctl_irq_line
>> -->kvm_vgic_inject_irq
>> ---->vgic_validate_injection (if level did not change, return)
>> ---->vgic_queue_irq_unlock
>>
>> Without above changes, in the vgic_validate_injection, because the
>> interruption level is always 0, this irq will not be queued into vgic.
>> And the guest will not read the pl011 fifo.
> 
> The pl011 code should call qemu_set_irq(..., 1) when the
> guest enables interrupts on the device by writing to the int_enabled
> (UARTIMSC) register. That will be a 0-to-1 level change and the KVM
> VGIC should report the interrupt to the guest.
> 

Yes.
And in the pl011_update, the irq level is set by s->int_level & s->int_enabled.
When writing to the int_enabled, not sure why the int_level is set to
0x20(PL011_INT_TX) but int_enabled is 0x50.
It still call qemu_set_irq(..., 0).

I added "s->int_level |= PL011_INT_RX" before calling pl011_update
when writing to the int_enabled and tested it also works.
How do you think about like that?
Thanks!

Best Regards,
Wei

> thanks
> -- PMM
> 
> .
> 

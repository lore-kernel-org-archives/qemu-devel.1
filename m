Received: from eggs.gnu.org ([2001:4830:134:3::10]:47240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eg6h5-0004Oo-5H
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eg6gv-00073U-LI
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:29:43 -0500
Date: Mon, 29 Jan 2018 11:29:17 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180129102917.3olxduibcwdqgqls@hawk.localdomain>
References: <5A6B5091.8030601@hisilicon.com>
	<CAFEAcA_39SgDKFnkrcVePs89kYUMHvqqAdnkFhrCa=GYTu0Kpw@mail.gmail.com>
	<5A6B5FCA.2080009@hisilicon.com>
	<CAFEAcA-N-pjHwqrStf-qK+EOmGYyR-4dfY=sL5kLzeodgYUiRw@mail.gmail.com>
	<5A6B6671.8070408@hisilicon.com>
	<CAFEAcA-_vYgDYofx61rmCL7sZKOVSBHfw0k3us1=SHzD+TEnGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-_vYgDYofx61rmCL7sZKOVSBHfw0k3us1=SHzD+TEnGw@mail.gmail.com>
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
Cc: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <rob.herring@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, "Chenxin (Charles)" <charles.chenxin@huawei.com>, tiantao6@huawei.com, QEMU Developers <qemu-devel@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Linuxarm <linuxarm@huawei.com>, "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>, qemu-arm <qemu-arm@nongnu.org>, Daode Huang <huangdaode@hisilicon.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>, Zhangyi ac <zhangyi.ac@huawei.com>

On Fri, Jan 26, 2018 at 06:01:33PM +0000, Peter Maydell wrote:
> On 26 January 2018 at 17:33, Wei Xu <xuwei5@hisilicon.com> wrote:
> > On 2018/1/26 17:15, Peter Maydell wrote:
> >> The pl011 code should call qemu_set_irq(..., 1) when the
> >> guest enables interrupts on the device by writing to the int_enabled
> >> (UARTIMSC) register. That will be a 0-to-1 level change and the KVM
> >> VGIC should report the interrupt to the guest.
> >>
> >
> > Yes.
> > And in the pl011_update, the irq level is set by s->int_level & s->int_enabled.
> > When writing to the int_enabled, not sure why the int_level is set to
> > 0x20(PL011_INT_TX) but int_enabled is 0x50.
> >
> > It still call qemu_set_irq(..., 0).
> >
> > I added "s->int_level |= PL011_INT_RX" before calling pl011_update
> > when writing to the int_enabled and tested it also works.
> 
> No, that's not right either. int_level should already have the
> RX bit set, because pl011_put_fifo() sets that bit when it gets a
> character from QEMU and puts it into the FIFO.
> 
> Does something else clear the int_level between the character
> going into the FIFO from QEMU and the guest enabling
> interrupts?

As part of the boot process Linux restarts the UART a few times. When
Linux drives the PL011 with the SBSA driver then the FIFO doesn't get
reset prior to being used again, as the SBSA doesn't specify a way to
do that. I'm not sure if this issue is due to the SBSA attempting to
be overly simple, or something the Linux driver can deal with. See
this thread for a discussion I started once.

https://www.spinics.net/lists/linux-serial/msg23163.html

Wei,

I assume you're using UEFI/ACPI when booting, as I don't recall this
problem occurring with the Linux PL011 driver which would be used
when booting with DT.

Thanks,
drew

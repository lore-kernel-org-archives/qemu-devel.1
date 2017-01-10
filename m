Received: from eggs.gnu.org ([2001:4830:134:3::10]:36692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cR03K-0006F3-AN
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:17:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cR03J-00045l-Cx
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:17:42 -0500
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:34032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cR03J-00045W-93
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:17:41 -0500
Received: by mail-ua0-x236.google.com with SMTP id 35so57821466uak.1
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:17:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170110164235.GT14990@toto>
References: <1483977924-14522-1-git-send-email-peter.maydell@linaro.org>
	<1483977924-14522-5-git-send-email-peter.maydell@linaro.org>
	<20170110164235.GT14990@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jan 2017 17:17:20 +0000
Message-ID: <CAFEAcA_8p_OBHEYn=Rr9p-e=GFHz3h1kxK8JRSv6oozTzyvQ2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 04/18] hw/arm/virt: Wire VIRQ, VFIQ,
 maintenance irq lines from GIC to CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>

On 10 January 2017 at 16:42, Edgar E. Iglesias
<edgar.iglesias@xilinx.com> wrote:
> On Mon, Jan 09, 2017 at 04:05:10PM +0000, Peter Maydell wrote:
>> @@ -571,9 +571,17 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>>                                                     ppibase + timer_irq[irq]));
>>          }
>>
>> +        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0,
>> +                                    qdev_get_gpio_in(gicdev, ppibase
>> +                                                     + ARCH_GICV3_MAINT_IRQ));
>> +
>>          sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
>>          sysbus_connect_irq(gicbusdev, i + smp_cpus,
>>                             qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
>> +        sysbus_connect_irq(gicbusdev, i + 2 * smp_cpus,
>> +                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
>> +        sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
>
> I thought there was an error here first (i.e i * smp_cpus + 3).
> The code is correct but could have perhaps been more readable with named irqs.

Yeah, all the GIC interfacing predates named IRQs and we haven't
got round to trying to convert it (it would be a fairly tedious
job given all the boards that wire up GICs these days).

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:52309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gELEN-0002kQ-36
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 17:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gELEM-0006kt-5W
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 17:25:50 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gELEL-0006jw-Jr
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 17:25:49 -0400
Received: by mail-oi1-x243.google.com with SMTP id a203-v6so30683759oib.0
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 14:25:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181021192457.GG4229@toto>
References: <20181017213932.19973-1-edgar.iglesias@gmail.com>
	<20181017213932.19973-4-edgar.iglesias@gmail.com>
	<CAFEAcA9Dd3=52zReFVMgitYFeQsRA=guYsVMxy=0zHsLJ_+z_g@mail.gmail.com>
	<20181021192457.GG4229@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 21 Oct 2018 22:25:28 +0100
Message-ID: <CAFEAcA_URiHwcu1k-MYGpw704y_t4RuUFHGrpa4XA9GTKBb8aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 3/4] hw/arm: versal: Add a model of
 Xilinx Versal SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

On 21 October 2018 at 20:24, Edgar E. Iglesias
<edgar.iglesias@xilinx.com> wrote:
> On Fri, Oct 19, 2018 at 03:18:24PM +0100, Peter Maydell wrote:
>> On 17 October 2018 at 22:39, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
>> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>> >
>> > Add a model of Xilinx Versal SoC.
>> >
>> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>> > ---
>> >  default-configs/aarch64-softmmu.mak |   1 +
>> >  hw/arm/Makefile.objs                |   1 +
>> >  hw/arm/xlnx-versal.c                | 324 ++++++++++++++++++++++++++++
>> >  include/hw/arm/xlnx-versal.h        | 122 +++++++++++
>> >  4 files changed, 448 insertions(+)
>> >  create mode 100644 hw/arm/xlnx-versal.c
>> >  create mode 100644 include/hw/arm/xlnx-versal.h
>>
>> > +    if (!kvm_irqchip_in_kernel()) {
>> > +        qdev_prop_set_bit(gicdev, "has-security-extensions", true);
>> > +    }
>>
>> Do you really support KVM for this board/SoC ?
>>
>
>
> I haven't tried yet, so probably not, but KVM is something we'd like to support further down the road...
> If you prefer, we can remove this kvm specific check for now though.

I think there's other things you need to do to support KVM
(for instance, you need to disable EL2 and EL3 on all the CPUs,
and you need to either handle a GICv2 or error out properly
if the host system doesn't have a GICv3), so maybe it would
be better to add support properly later. This isn't a subtle
check we'll forget to add in later either -- if you set
has-security-extensions on a KVM GICv3 then the device will
fail its 'realize' method with a suitable error.

...which leads me to notice that here:

+    object_property_set_bool(OBJECT(&s->fpd.apu.gic), true, "realized", errp);

we capture the possible error from realize in errp, but we
don't actually check whether it failed, so the rest of the
function will plough ahead and try to wire up IRQs and
MemoryRegions that won't have been created.

thanks
-- PMM

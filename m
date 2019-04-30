Received: from eggs.gnu.org ([209.51.188.92]:53024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZVT-0002ST-7m
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZNH-0007om-3F
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:29:12 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:35839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hLZNG-0007nC-PO
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:29:11 -0400
Received: by mail-lj1-x241.google.com with SMTP id z26so14057795ljj.2
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 13:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556515687.git.alistair@alistair23.me>
	<PSXP216MB02771957D4B9C5A15914D05FDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
	<CAFEAcA86i3aZx-h2ys5kmc35AMqzd6k=JrfVXObdbcppnn-J8w@mail.gmail.com>
In-Reply-To: <CAFEAcA86i3aZx-h2ys5kmc35AMqzd6k=JrfVXObdbcppnn-J8w@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Apr 2019 13:27:15 -0700
Message-ID: <CAKmqyKMM0QHgdS3Z9Fd13XjeFsiG1UnZYz5brdjJgnbHXmxBrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 5/5] hw/arm: Add the Netduino Plus 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, Apr 30, 2019 at 9:02 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 29 Apr 2019 at 06:39, Alistair Francis <alistair@alistair23.me> wrote:
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  MAINTAINERS                     |  6 +++
> >  default-configs/arm-softmmu.mak |  1 +
> >  hw/arm/Kconfig                  |  3 ++
> >  hw/arm/Makefile.objs            |  1 +
> >  hw/arm/netduinoplus2.c          | 77 +++++++++++++++++++++++++++++++++
> >  5 files changed, 88 insertions(+)
> >  create mode 100644 hw/arm/netduinoplus2.c
> >
>
> > +typedef struct ARMV7MResetArgs {
> > +    ARMCPU *cpu;
> > +    uint32_t reset_sp;
> > +    uint32_t reset_pc;
> > +} ARMV7MResetArgs;
> > +
> > +static void armv7m_reset(void *opaque)
> > +{
> > +    ARMV7MResetArgs *args = opaque;
> > +
> > +    cpu_reset(CPU(args->cpu));
> > +
> > +    args->cpu->env.regs[13] = args->reset_sp & 0xFFFFFFFC;
> > +    args->cpu->env.thumb = args->reset_pc & 1;
> > +    args->cpu->env.regs[15] = args->reset_pc & ~1;
> > +}
> > +
> > +static void netduinoplus2_init(MachineState *machine)
> > +{
> > +    DeviceState *dev;
> > +    ARMV7MResetArgs reset_args;
> > +    uint64_t entry;
> > +
> > +    dev = qdev_create(NULL, TYPE_STM32F405_SOC);
> > +    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
> > +    object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
> > +
> > +    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> > +                       FLASH_SIZE, &entry);
> > +
> > +    reset_args = (ARMV7MResetArgs) {
> > +        .cpu = ARM_CPU(first_cpu),
> > +        .reset_pc = entry,
> > +        .reset_sp = (SRAM_BASE_ADDRESS + (SRAM_SIZE * 2) / 3),
> > +    };
> > +    qemu_register_reset(armv7m_reset,
> > +                        g_memdup(&reset_args, sizeof(reset_args)));
> > +}
>
> Can you explain the purpose of the reset code? None of the other
> v7m boards seem to need to do a manual qemu_register_reset().

The reset code allows the machine to work with the -kernel option.
Without the reset override using -kernel results in the guest starting
at the wrong address. We can use the -device loader option without the
reset code though.

I don't have examples infront of me, I can run it when I'm home and
include the addresses if you want.

Alistair

>
> thanks
> -- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fCwWp-000846-80
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 20:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fCwWn-0005l9-H2
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 20:18:51 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:46811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fCwWn-0005kU-9d
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 20:18:49 -0400
Received: by mail-oi0-x241.google.com with SMTP id y15-v6so6123381oia.13
	for <qemu-devel@nongnu.org>; Sun, 29 Apr 2018 17:18:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9PQU3EFi2OwZ9=tzj3-59yzGuCrWomUKqCEcuqYP+Z9A@mail.gmail.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-19-git-send-email-mjc@sifive.com>
	<CAFEAcA9PQU3EFi2OwZ9=tzj3-59yzGuCrWomUKqCEcuqYP+Z9A@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Mon, 30 Apr 2018 12:18:48 +1200
Message-ID: <CAHNT7Nuv9p9Bdxc+zUuF_sii+gzZgk5SMAeg+7XHi0Q3X=ympg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 18/23] RISC-V VirtIO Machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <Alistair.Francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Sat, Apr 28, 2018 at 2:17 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 2 March 2018 at 13:51, Michael Clark <mjc@sifive.com> wrote:
> > RISC-V machine with device-tree, 16550a UART and VirtIO MMIO.
> > The following machine is implemented:
> >
> > - 'virt'; CLINT, PLIC, 16550A UART, VirtIO MMIO, device-tree
> >
> > Acked-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> > Signed-off-by: Michael Clark <mjc@sifive.com>
>
> Hi; Coverity spots (CID 1390606) that in this function you
> leak a little bit of memory:
>
> > +static void riscv_virt_board_init(MachineState *machine)
> > +{
>
> > +    /* create PLIC hart topology configuration string */
> > +    plic_hart_config_len = (strlen(VIRT_PLIC_HART_CONFIG) + 1) *
> smp_cpus;
> > +    plic_hart_config = g_malloc0(plic_hart_config_len);
>
> Here we allocate memory into plic_hart_config...
>
> > +    for (i = 0; i < smp_cpus; i++) {
> > +        if (i != 0) {
> > +            strncat(plic_hart_config, ",", plic_hart_config_len);
> > +        }
> > +        strncat(plic_hart_config, VIRT_PLIC_HART_CONFIG,
> plic_hart_config_len);
> > +        plic_hart_config_len -= (strlen(VIRT_PLIC_HART_CONFIG) + 1);
> > +    }
> > +
> > +    /* MMIO */
> > +    s->plic = sifive_plic_create(memmap[VIRT_PLIC].base,
> > +        plic_hart_config,
>
> (and this function doesn't take ownership of the string)
>
> > +        VIRT_PLIC_NUM_SOURCES,
> > +        VIRT_PLIC_NUM_PRIORITIES,
> > +        VIRT_PLIC_PRIORITY_BASE,
> > +        VIRT_PLIC_PENDING_BASE,
> > +        VIRT_PLIC_ENABLE_BASE,
> > +        VIRT_PLIC_ENABLE_STRIDE,
> > +        VIRT_PLIC_CONTEXT_BASE,
> > +        VIRT_PLIC_CONTEXT_STRIDE,
> > +        memmap[VIRT_PLIC].size);
> > +    sifive_clint_create(memmap[VIRT_CLINT].base,
> > +        memmap[VIRT_CLINT].size, smp_cpus,
> > +        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
> > +    sifive_test_create(memmap[VIRT_TEST].base);
> > +
> > +    for (i = 0; i < VIRTIO_COUNT; i++) {
> > +        sysbus_create_simple("virtio-mmio",
> > +            memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size,
> > +            SIFIVE_PLIC(s->plic)->irqs[VIRTIO_IRQ + i]);
> > +    }
> > +
> > +    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
> > +        0, SIFIVE_PLIC(s->plic)->irqs[UART0_IRQ], 399193,
> > +        serial_hds[0], DEVICE_LITTLE_ENDIAN);
>
> ...but we don't free the memory before leaving.
>
> > +}
>
> Not a big deal since this function is only run once, but adding
> in the necessary g_free(plic_hart_config) will placate Coverity.
>
>
Didn't mean to go off list. I'm adding Alastair as he is looking at
refactoring the machines to use QOM for an SOC holding the devices,
separate from the machine state structure.

Quite a bit of our initialization code in several QOM classes allocate
memory that is not freed. e.g. the PLIC. Usually these functions are only
run once, but ideally all of the code should be memory clean. i.e. exit
without leaks. Many programs don't bother with this but I think it is a
good practice.

Should we use dc->unrealize to point to an unrelalize function that calls
g_free? Is unrealize the QOM destructor?

As an aside, for Alastair's sake. We intend to implement and generalize ISA
string parsing so that RISCVHartArray is indeed heterogeneous and the PLIC
can figure out its dimensions from RISCVHartArray. Once the CPUs are
realized, we can derive the modes that a CPU/hart supports from 'misa'. The
RTL designers for the SiFive PLIC made a decision to save address space
versus using 2-bits in the interrupt configuration address space to encode
mode (with reserved areas for unsupported modes). With the current compact
address space layout, we need to know which modes a hart (hardware thread)
supports to see how much address space it uses in the PLIC configuration
aperture, and each CPU can have a variable sized aperture depending on the
modes it supports. This complicates dynamic address decode as we can't
simply use ranges of bits to get mode and hart. The RTL generates the
address decode statically from the core complex configuration so it's not
an issue in hardware, although one would wonder whether it might use more
comparators in its address decode logic. Also of note, is that we may add
an option to the PLIC that inverts the dimensions from { hart, mode } to {
mode, hart } so that M mode can use PMP to protect its interrupt routing
configuration. Presently the modes are interleaved instead of having per
per mode apertures (which is required for virtualization of the PLIC). That
requirement (dimension order) would dictate a more regular address space
layout.

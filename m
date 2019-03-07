Received: from eggs.gnu.org ([209.51.188.92]:53792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1uT3-0003xS-AS
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:57:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1uSy-00084N-8W
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:57:50 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1uSt-0007zl-Oa
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:57:45 -0500
Received: by mail-oi1-x243.google.com with SMTP id b4so13103265oif.6
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 06:57:42 -0800 (PST)
MIME-Version: 1.0
References: <1550029560-30530-1-git-send-email-sandra@codesourcery.com>
	<1550029560-30530-2-git-send-email-sandra@codesourcery.com>
In-Reply-To: <1550029560-30530-2-git-send-email-sandra@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2019 14:57:30 +0000
Message-ID: <CAFEAcA8p9rSYEJQ7jPFvM9Q+UXi6r7Vr8voWQ_fhzzFX1=uVzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 1/2] Add generic Nios II board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sandra Loosemore <sandra@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marek Vasut <marex@denx.de>

On Wed, 13 Feb 2019 at 04:04, Sandra Loosemore <sandra@codesourcery.com> wrote:
>
> This patch adds support for a generic MMU-less Nios II board that can
> be used e.g. for bare-metal compiler testing.  Nios II booting is also
> tweaked so that bare-metal binaries start executing in RAM starting at
> 0x00000000, rather than an alias at 0xc0000000, which allows features
> such as unwinding to work when binaries are linked to start at the
> beginning of the address space.

I should start this review by saying that I know nothing at all
about the Nios II architecture, so I'm just going on general
principles. Some of my comments might be confused or wrong as
a result...

> The generic_nommu.c parts are by Andrew Jenner, based on code by Marek
> Vasut.

> Originally by Marek Vasut and Andrew Jenner.
>
> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
> Signed-off-by: Julian Brown <julian@codesourcery.com>
> Signed-off-by: Andrew Jenner <andrew@codesourcery.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
>  default-configs/nios2-softmmu.mak |   1 +
>  hw/nios2/Makefile.objs            |   1 +
>  hw/nios2/boot.c                   |   5 +-
>  hw/nios2/generic_nommu.c          | 130 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 136 insertions(+), 1 deletion(-)
>  create mode 100644 hw/nios2/generic_nommu.c
>
> diff --git a/default-configs/nios2-softmmu.mak b/default-configs/nios2-softmmu.mak
> index ab42d0f..95ed1c2 100644
> --- a/default-configs/nios2-softmmu.mak
> +++ b/default-configs/nios2-softmmu.mak
> @@ -5,3 +5,4 @@ CONFIG_SERIAL=y
>  CONFIG_PTIMER=y
>  CONFIG_ALTERA_TIMER=y
>  CONFIG_NIOS2_10M50=y
> +CONFIG_NIOS2_GENERIC_NOMMU=y
> diff --git a/hw/nios2/Makefile.objs b/hw/nios2/Makefile.objs
> index 89a419a..3e01798 100644
> --- a/hw/nios2/Makefile.objs
> +++ b/hw/nios2/Makefile.objs
> @@ -1,2 +1,3 @@
>  obj-y = boot.o cpu_pic.o
>  obj-$(CONFIG_NIOS2_10M50) += 10m50_devboard.o
> +obj-$(CONFIG_NIOS2_GENERIC_NOMMU) += generic_nommu.o
> diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
> index 5f0ab2f..c697047 100644
> --- a/hw/nios2/boot.c
> +++ b/hw/nios2/boot.c
> @@ -140,6 +140,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
>          uint64_t entry, low, high;
>          uint32_t base32;
>          int big_endian = 0;
> +        int kernel_space = 0;
>
>  #ifdef TARGET_WORDS_BIGENDIAN
>          big_endian = 1;
> @@ -155,10 +156,12 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
>                                     translate_kernel_address, NULL,
>                                     &entry, NULL, NULL,
>                                     big_endian, EM_ALTERA_NIOS2, 0, 0);
> +            kernel_space = 1;
>          }
>
>          /* Always boot into physical ram. */
> -        boot_info.bootstrap_pc = ddr_base + 0xc0000000 + (entry & 0x07ffffff);
> +        boot_info.bootstrap_pc = ddr_base + (kernel_space ? 0xc0000000 : 0)
> +                                 + (entry & 0x07ffffff);

It's not clear to me what's going on here, or why an
entry address of 0xc000_0000 is special, but I don't
know anything about NiosII -- maybe it's clear if you do?

Why isn't the bootstrap_pc just always the entry address ?
Some comments on what is being done here and the use cases
being addressed might assist. I wasn't able to work out what
the remarks in the commit message meant, I'm afraid.

Looking at the code, I don't think that the second call to
load_elf() will return a different entry address to the first
one (ie translate_kernel_address() is not applied to &entry).
That means that kernel_space is only true if entry == 0xc0000000,
and
  (kernel_space ? 0xc0000000 : 0) + (entry & 0x07ffffff);
is almost the same thing as just 'entry'.

> +static void nios2_generic_nommu_init(MachineState *machine)
> +{
> +    Nios2CPU *cpu;
> +    DeviceState *dev;
> +    MemoryRegion *address_space_mem = get_system_memory();
> +    MemoryRegion *phys_tcm = g_new(MemoryRegion, 1);
> +    MemoryRegion *phys_tcm_alias = g_new(MemoryRegion, 1);
> +    MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
> +    MemoryRegion *phys_ram_alias = g_new(MemoryRegion, 1);
> +    ram_addr_t tcm_base = 0x0;
> +    ram_addr_t tcm_size = 0x1000;    /* 1 kiB, but QEMU limit is 4 kiB */
> +    ram_addr_t ram_base = 0x10000000;
> +    ram_addr_t ram_size = 0x08000000;
> +    qemu_irq *cpu_irq, irq[32];
> +    int i;

The description says this is "generic", but it appears to
be almost identical to the existing 10M50 board model,
including having exactly the same devices at the same
apparently arbitrary addresses.

Could we instead add a machine parameter to the existing
board so you could say "-machine 10m50-ghrd,mmu=no"
(and drop the other changes -- it's not clear what they're
needed for) ?

If it really ought to be a separate board model, perhaps
it should be in the same source file and share the common
code.

thanks
-- PMM

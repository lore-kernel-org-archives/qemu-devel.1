Received: from eggs.gnu.org ([2001:4830:134:3::10]:43142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFkfT-0001ER-8u
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 14:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFkfP-0006zk-CM
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 14:47:38 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gFkfK-0006u9-Cv
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 14:47:33 -0400
Received: by mail-oi1-x244.google.com with SMTP id 22-v6so7593558oiz.2
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 11:47:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <727db304cd3676f89da0f2f9c5ba12e65795683c.1538683492.git.alistair.francis@wdc.com>
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<727db304cd3676f89da0f2f9c5ba12e65795683c.1538683492.git.alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Oct 2018 19:47:04 +0100
Message-ID: <CAFEAcA_o0_Yq130modYZ9L3WSq6GaLhdVOwicefz9xgFE+mi2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 2/5] hw/riscv/virt: Connect the gpex PCIe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "palmer@sifive.com" <palmer@sifive.com>, "stephen@eideticom.com" <stephen@eideticom.com>

On 4 October 2018 at 21:06, Alistair Francis <Alistair.Francis@wdc.com> wrote:
> Connect the gpex PCIe device based on the device tree included in the
> HiFive Unleashed ROM.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  default-configs/riscv32-softmmu.mak |  6 ++-
>  default-configs/riscv64-softmmu.mak |  6 ++-
>  hw/riscv/virt.c                     | 58 +++++++++++++++++++++++++++++
>  include/hw/riscv/virt.h             |  4 +-
>  4 files changed, 71 insertions(+), 3 deletions(-)

> +static inline DeviceState *
> +gpex_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
> +                 hwaddr cfg_base, uint64_t cfg_size,
> +                 hwaddr mmio_base, uint64_t mmio_size,
> +                 qemu_irq irq, bool link_up)
> +{
> +    DeviceState *dev;
> +    MemoryRegion *cfg, *mmio;
> +
> +    dev = qdev_create(NULL, TYPE_GPEX_HOST);
> +
> +    qdev_init_nofail(dev);
> +
> +    cfg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_add_subregion_overlap(sys_mem, cfg_base, cfg, 0);
> +
> +    mmio = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +    memory_region_add_subregion_overlap(sys_mem, 0, mmio, 0);

You probably also want to map the gpex's mmio region 2,
which is the PCI IO BAR window. Otherwise PCI devices
with IO BARs won't work right.

> +
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);

GPEX has 4 interrupt lines, corresponding to classic PCI
IRQs A, B, C, D. You need to wire them all up, or only the
first PCI device plugged in will have a working interrupt.
You also don't look to have the bit of device-tree generation
that sets up the interrupt-map, which tells the guest about
the mapping from PCI devfns (ie, which slot the card is in) to
IRQ lines.

> +
> +    return dev;
> +}
> +
>  static void riscv_virt_board_init(MachineState *machine)
>  {
>      const struct MemmapEntry *memmap = virt_memmap;
> @@ -382,6 +436,10 @@ static void riscv_virt_board_init(MachineState *machine)
>              qdev_get_gpio_in(DEVICE(s->plic), VIRTIO_IRQ + i));
>      }
>
> +    gpex_pcie_init(system_memory, 0, memmap[VIRT_PCIE].base,
> +                           memmap[VIRT_PCIE].size, 0x40000000, 0x20000000,

You could put the MMIO BAR window base and size in your memmap[] too...

> +                           qdev_get_gpio_in(DEVICE(s->plic), PCIE_IRQ), true);

thanks
-- PMM

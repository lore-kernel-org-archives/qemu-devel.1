Received: from eggs.gnu.org ([2001:4830:134:3::10]:47214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGpYa-0001qI-53
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGpYY-0007TM-PJ
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:40:44 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fGpYY-0007QT-EW
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:40:42 -0400
Received: by mail-lf0-x243.google.com with SMTP id t129-v6so4138836lff.3
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 10:40:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <66d0552d-5017-e89c-7d40-d5ff8e02ce23@amsat.org>
References: <cover.1525464177.git.alistair.francis@wdc.com>
	<6634a98e5558a060369ac365e8ea2fd960af5b81.1525464177.git.alistair.francis@wdc.com>
	<66d0552d-5017-e89c-7d40-d5ff8e02ce23@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 10 May 2018 10:40:10 -0700
Message-ID: <CAKmqyKMfyYkT1gvQ3ZRRYH_+XeCs7_njZaMX-RUoPFCsHd+3Dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/4] hw/riscv/sifive_plic: Use gpios
 instead of irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>

On Wed, May 9, 2018 at 7:33 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Hi Alistair,
>
> On 05/04/2018 05:13 PM, Alistair Francis wrote:
>> Instead of creating the interrupt in lines with qemu_allocate_irq() use
>> qdev_init_gpio_in() as this gives us the ability to use the qdev*gpio*()
>> helpers later on.
>
> This is a good idea, but your patch is incomplete:
> The devices previously using plic->irqs[] now need to use those
> qdev*gpio*() helpers.
>
>>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>  hw/riscv/sifive_plic.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
>> index a4ac910ca9..81b6b5245b 100644
>> --- a/hw/riscv/sifive_plic.c
>> +++ b/hw/riscv/sifive_plic.c
>> @@ -431,7 +431,6 @@ static void sifive_plic_irq_request(void *opaque, in=
t irq, int level)
>>  static void sifive_plic_realize(DeviceState *dev, Error **errp)
>>  {
>>      SiFivePLICState *plic =3D SIFIVE_PLIC(dev);
>> -    int i;
>>
>>      memory_region_init_io(&plic->mmio, OBJECT(dev), &sifive_plic_ops, p=
lic,
>>                            TYPE_SIFIVE_PLIC, plic->aperture_size);
>> @@ -444,9 +443,7 @@ static void sifive_plic_realize(DeviceState *dev, Er=
ror **errp)
>>      plic->enable =3D g_new0(uint32_t, plic->bitfield_words * plic->num_=
addrs);
>>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &plic->mmio);
>>      plic->irqs =3D g_new0(qemu_irq, plic->num_sources + 1);
>> -    for (i =3D 0; i <=3D plic->num_sources; i++) {
>> -        plic->irqs[i] =3D qemu_allocate_irq(sifive_plic_irq_request, pl=
ic, i);
>> -    }
>> +    qdev_init_gpio_in(dev, sifive_plic_irq_request, plic->num_sources);
>>  }
>>
>>  static void sifive_plic_class_init(ObjectClass *klass, void *data)
>>
>
> The following patch completes yours:
>
> - access the irqs with qdev_get_gpio_in()
> - remove plic->irqs[] alloc in sifive_plic_realize()
> - remove plic->irqs[] from SiFivePLICState struct

Thanks for that.

I realised the same thing. This series is also missing some device
tree changes that are required. I'll fix all of that in the next
version.

Alistair

>
> -- >8 --
>  include/hw/riscv/sifive_plic.h | 1 -
>  hw/riscv/sifive_e.c            | 2 +-
>  hw/riscv/sifive_plic.c         | 1 -
>  hw/riscv/sifive_u.c            | 2 +-
>  hw/riscv/virt.c                | 4 ++--
>  5 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/include/hw/riscv/sifive_plic.h b/include/hw/riscv/sifive_pli=
c.h
> index 11a5a98df1..2f2af7e686 100644
> --- a/include/hw/riscv/sifive_plic.h
> +++ b/include/hw/riscv/sifive_plic.h
> @@ -56,7 +56,6 @@ typedef struct SiFivePLICState {
>      uint32_t *claimed;
>      uint32_t *enable;
>      QemuMutex lock;
> -    qemu_irq *irqs;
>
>      /* config */
>      char *hart_config;
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 0ab5e3ca45..7b4f04adcf 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -190,7 +190,7 @@ static void riscv_sifive_e31_realize(DeviceState
> *dev, Error **errp)
>      sifive_mmio_emulate(sys_mem, "riscv.sifive.e.gpio0",
>          memmap[SIFIVE_E_GPIO0].base, memmap[SIFIVE_E_GPIO0].size);
>      sifive_uart_create(sys_mem, memmap[SIFIVE_E_UART0].base,
> -        serial_hd(0), SIFIVE_PLIC(s->plic)->irqs[SIFIVE_E_UART0_IRQ]);
> +        serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic),
> SIFIVE_E_UART0_IRQ));
>      sifive_mmio_emulate(sys_mem, "riscv.sifive.e.qspi0",
>          memmap[SIFIVE_E_QSPI0].base, memmap[SIFIVE_E_QSPI0].size);
>      sifive_mmio_emulate(sys_mem, "riscv.sifive.e.pwm0",
> diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
> index c6ad17057d..a91aeb97ab 100644
> --- a/hw/riscv/sifive_plic.c
> +++ b/hw/riscv/sifive_plic.c
> @@ -447,7 +447,6 @@ static void sifive_plic_realize(DeviceState *dev,
> Error **errp)
>      plic->claimed =3D g_new0(uint32_t, plic->bitfield_words);
>      plic->enable =3D g_new0(uint32_t, plic->bitfield_words *
> plic->num_addrs);
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &plic->mmio);
> -    plic->irqs =3D g_new0(qemu_irq, plic->num_sources + 1);
>      qdev_init_gpio_in(dev, sifive_plic_irq_request, plic->num_sources);
>  }
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 54f33c39ae..b7936dcec5 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -330,7 +330,7 @@ static void riscv_sifive_u54_realize(DeviceState
> *dev, Error **errp)
>          SIFIVE_U_PLIC_CONTEXT_STRIDE,
>          memmap[SIFIVE_U_PLIC].size);
>      sifive_uart_create(system_memory, memmap[SIFIVE_U_UART0].base,
> -        serial_hd(0), SIFIVE_PLIC(s->plic)->irqs[SIFIVE_U_UART0_IRQ]);
> +        serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic),
> SIFIVE_U_UART0_IRQ));
>      /* sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
>          serial_hd(1), SIFIVE_PLIC(s->plic)->irqs[SIFIVE_U_UART1_IRQ]); *=
/
>      sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ad03113e0f..bdd75722eb 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -379,11 +379,11 @@ static void riscv_virt_board_init(MachineState
> *machine)
>      for (i =3D 0; i < VIRTIO_COUNT; i++) {
>          sysbus_create_simple("virtio-mmio",
>              memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size,
> -            SIFIVE_PLIC(s->plic)->irqs[VIRTIO_IRQ + i]);
> +            qdev_get_gpio_in(DEVICE(s->plic), VIRTIO_IRQ + i));
>      }
>
>      serial_mm_init(system_memory, memmap[VIRT_UART0].base,
> -        0, SIFIVE_PLIC(s->plic)->irqs[UART0_IRQ], 399193,
> +        0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
>          serial_hd(0), DEVICE_LITTLE_ENDIAN);
>  }
>
> --
>
> Regards,
>
> Phil.
>

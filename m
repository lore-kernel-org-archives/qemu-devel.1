Received: from eggs.gnu.org ([2001:4830:134:3::10]:59030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fJUsH-0000JV-LC
	for qemu-devel@nongnu.org; Thu, 17 May 2018 22:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fJUsF-0007Qz-VR
	for qemu-devel@nongnu.org; Thu, 17 May 2018 22:12:05 -0400
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:40166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fJUsF-0007Qr-NX
	for qemu-devel@nongnu.org; Thu, 17 May 2018 22:12:03 -0400
Received: by mail-ot0-x22e.google.com with SMTP id n1-v6so7359033otf.7
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 19:12:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <52767d6fcda555df477512b350f168d0de557b7a.1526342674.git.alistair.francis@wdc.com>
References: <cover.1526342674.git.alistair.francis@wdc.com>
	<52767d6fcda555df477512b350f168d0de557b7a.1526342674.git.alistair.francis@wdc.com>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 18 May 2018 14:12:02 +1200
Message-ID: <CAHNT7NvFEYhK_ZX-5dRV5y+hwgDgpp3k+PBAHVWRiLZXp58z7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 2/7] hw/riscv/sifive_e: Create a SiFive
 E SoC object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>

On Tue, May 15, 2018 at 12:07 PM, Alistair Francis <alistair.francis@wdc.com
> wrote:

> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>

Reviewed-by: Michael Clark <mjc@sifive.com>


> ---
>  hw/riscv/sifive_e.c         | 97 +++++++++++++++++++++++++++----------
>  include/hw/riscv/sifive_e.h | 16 +++++-
>  2 files changed, 86 insertions(+), 27 deletions(-)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index e4ecb7aa4b..384b456540 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -102,18 +102,12 @@ static void riscv_sifive_e_init(MachineState
> *machine)
>      SiFiveEState *s = g_new0(SiFiveEState, 1);
>      MemoryRegion *sys_mem = get_system_memory();
>      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
> -    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> -    MemoryRegion *xip_mem = g_new(MemoryRegion, 1);
>      int i;
>
> -    /* Initialize SOC */
> -    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
> +    /* Initialize SoC */
> +    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_E_SOC);
>      object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
>                                &error_abort);
> -    object_property_set_str(OBJECT(&s->soc), SIFIVE_E_CPU, "cpu-type",
> -                            &error_abort);
> -    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
> -                            &error_abort);
>      object_property_set_bool(OBJECT(&s->soc), true, "realized",
>                              &error_abort);
>
> @@ -123,11 +117,57 @@ static void riscv_sifive_e_init(MachineState
> *machine)
>      memory_region_add_subregion(sys_mem,
>          memmap[SIFIVE_E_DTIM].base, main_mem);
>
> +    /* Mask ROM reset vector */
> +    uint32_t reset_vec[2] = {
> +        0x204002b7,        /* 0x1000: lui     t0,0x20400 */
> +        0x00028067,        /* 0x1004: jr      t0 */
> +    };
> +
> +    /* copy in the reset vector in little_endian byte order */
> +    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> +        reset_vec[i] = cpu_to_le32(reset_vec[i]);
> +    }
> +    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
> +                          memmap[SIFIVE_E_MROM].base,
> &address_space_memory);
> +
> +    if (machine->kernel_filename) {
> +        load_kernel(machine->kernel_filename);
> +    }
> +}
> +
> +static void riscv_sifive_e_soc_init(Object *obj)
> +{
> +    const struct MemmapEntry *memmap = sifive_e_memmap;
> +
> +    SiFiveESoCState *s = RISCV_E_SOC(obj);
> +    MemoryRegion *sys_mem = get_system_memory();
> +    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> +
> +    object_initialize(&s->cpus, sizeof(s->cpus), TYPE_RISCV_HART_ARRAY);
> +    object_property_add_child(obj, "cpus", OBJECT(&s->cpus),
> +                              &error_abort);
> +    object_property_set_str(OBJECT(&s->cpus), SIFIVE_E_CPU, "cpu-type",
> +                            &error_abort);
> +    object_property_set_int(OBJECT(&s->cpus), smp_cpus, "num-harts",
> +                            &error_abort);
> +
>      /* Mask ROM */
>      memory_region_init_rom(mask_rom, NULL, "riscv.sifive.e.mrom",
>          memmap[SIFIVE_E_MROM].size, &error_fatal);
>      memory_region_add_subregion(sys_mem,
>          memmap[SIFIVE_E_MROM].base, mask_rom);
> +}
> +
> +static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
> +{
> +    const struct MemmapEntry *memmap = sifive_e_memmap;
> +
> +    SiFiveESoCState *s = RISCV_E_SOC(dev);
> +    MemoryRegion *sys_mem = get_system_memory();
> +    MemoryRegion *xip_mem = g_new(MemoryRegion, 1);
> +
> +    object_property_set_bool(OBJECT(&s->cpus), true, "realized",
> +                            &error_abort);
>
>      /* MMIO */
>      s->plic = sifive_plic_create(memmap[SIFIVE_E_PLIC].base,
> @@ -171,23 +211,6 @@ static void riscv_sifive_e_init(MachineState
> *machine)
>          memmap[SIFIVE_E_XIP].size, &error_fatal);
>      memory_region_set_readonly(xip_mem, true);
>      memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base,
> xip_mem);
> -
> -    /* Mask ROM reset vector */
> -    uint32_t reset_vec[2] = {
> -        0x204002b7,        /* 0x1000: lui     t0,0x20400 */
> -        0x00028067,        /* 0x1004: jr      t0 */
> -    };
> -
> -    /* copy in the reset vector in little_endian byte order */
> -    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> -        reset_vec[i] = cpu_to_le32(reset_vec[i]);
> -    }
> -    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
> -                          memmap[SIFIVE_E_MROM].base,
> &address_space_memory);
> -
> -    if (machine->kernel_filename) {
> -        load_kernel(machine->kernel_filename);
> -    }
>  }
>
>  static void riscv_sifive_e_machine_init(MachineClass *mc)
> @@ -198,3 +221,27 @@ static void riscv_sifive_e_machine_init(MachineClass
> *mc)
>  }
>
>  DEFINE_MACHINE("sifive_e", riscv_sifive_e_machine_init)
> +
> +static void riscv_sifive_e_soc_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    dc->realize = riscv_sifive_e_soc_realize;
> +    /* Reason: Uses serial_hds in realize function, thus can't be used
> twice */
> +    dc->user_creatable = false;
> +}
> +
> +static const TypeInfo riscv_sifive_e_soc_type_info = {
> +    .name = TYPE_RISCV_E_SOC,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(SiFiveESoCState),
> +    .instance_init = riscv_sifive_e_soc_init,
> +    .class_init = riscv_sifive_e_soc_class_init,
> +};
> +
> +static void riscv_sifive_e_soc_register_types(void)
> +{
> +    type_register_static(&riscv_sifive_e_soc_type_info);
> +}
> +
> +type_init(riscv_sifive_e_soc_register_types)
> diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
> index 12ad6d2ebb..7b6d8aed96 100644
> --- a/include/hw/riscv/sifive_e.h
> +++ b/include/hw/riscv/sifive_e.h
> @@ -19,13 +19,25 @@
>  #ifndef HW_SIFIVE_E_H
>  #define HW_SIFIVE_E_H
>
> -typedef struct SiFiveEState {
> +#define TYPE_RISCV_E_SOC "riscv.sifive.e.soc"
> +#define RISCV_E_SOC(obj) \
> +    OBJECT_CHECK(SiFiveESoCState, (obj), TYPE_RISCV_E_SOC)
> +
> +typedef struct SiFiveESoCState {
>      /*< private >*/
>      SysBusDevice parent_obj;
>
>      /*< public >*/
> -    RISCVHartArrayState soc;
> +    RISCVHartArrayState cpus;
>      DeviceState *plic;
> +} SiFiveESoCState;
> +
> +typedef struct SiFiveEState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    SiFiveESoCState soc;
>  } SiFiveEState;
>
>  enum {
> --
> 2.17.0
>
>

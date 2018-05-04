Received: from eggs.gnu.org ([2001:4830:134:3::10]:52724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEkO0-0007e3-SY
	for qemu-devel@nongnu.org; Fri, 04 May 2018 19:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEkNx-000651-4a
	for qemu-devel@nongnu.org; Fri, 04 May 2018 19:45:12 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fEkNw-00063e-MZ
	for qemu-devel@nongnu.org; Fri, 04 May 2018 19:45:09 -0400
Received: by mail-lf0-x242.google.com with SMTP id h4-v6so33167697lfc.1
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 16:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<1524699938-6764-12-git-send-email-mjc@sifive.com>
	<CAKmqyKMuc9tAaxtCBEn3MSUiuCdhgR0D0=TY=R-8VXhfG_Z+zA@mail.gmail.com>
	<CAHNT7NvCpM7woViXm=D3sDzZh5_wFj_4gB_5N2SF2FW+ZrHOLA@mail.gmail.com>
	<CAHNT7NtAGjJuV9WG-wfuB6tt5u0OHT_bEXYrTNkxjPmUcDRzjw@mail.gmail.com>
	<CAKmqyKOvKtV9ygXVCksWU9xOskm+KNH+amBA=1c3KQc-rkvbGQ@mail.gmail.com>
	<CAHNT7NvQ5aXvJofPBcL3iaEsBD=W7CTSuyJ5oo54XL9bnjNS+w@mail.gmail.com>
In-Reply-To: <CAHNT7NvQ5aXvJofPBcL3iaEsBD=W7CTSuyJ5oo54XL9bnjNS+w@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 04 May 2018 23:44:41 +0000
Message-ID: <CAKmqyKOe3xEuMNttQOuu=Dn2_tf4qHK39k0Mn-ZE0tQ5B-+N_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 11/35] RISC-V: Mark ROM read-only after
 copying in code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, palmer@sifive.com, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>

On Thu, May 3, 2018 at 6:45 PM Michael Clark <mjc@sifive.com> wrote:



> On Sat, Apr 28, 2018 at 4:17 AM, Alistair Francis <alistair23@gmail.com>
wrote:

>> On Thu, Apr 26, 2018 at 10:34 PM Michael Clark <mjc@sifive.com> wrote:



>> > On Fri, Apr 27, 2018 at 5:22 PM, Michael Clark <mjc@sifive.com> wrote:



>> >> On Fri, Apr 27, 2018 at 4:48 AM, Alistair Francis <
alistair23@gmail.com>
>> wrote:

>> >>> On Wed, Apr 25, 2018 at 5:03 PM Michael Clark <mjc@sifive.com> wrote:

>> >>> > The sifive_u machine already marks its ROM readonly. This fixes
>> >>> > the remaining boards. This commit also makes all boards use
>> >>> > mask_rom as the variable name for the ROM. This change also
>> >>> > makes space for the maximum device tree size size and adds
>> >>> > an explicit bounds check and error message.

>> >>> > Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
>> >>> > Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>> >>> > Cc: Palmer Dabbelt <palmer@sifive.com>
>> >>> > Cc: Alistair Francis <Alistair.Francis@wdc.com>
>> >>> > Signed-off-by: Michael Clark <mjc@sifive.com>
>> >>> > ---
>> >>> >   hw/riscv/sifive_e.c     | 20 +++++++---------
>> >>> >   hw/riscv/sifive_u.c     | 46 ++++++++++++++++++-----------------
>> >>> >   hw/riscv/spike.c        | 64
>> >>> ++++++++++++++++++++++++++++---------------------
>> >>> >   hw/riscv/virt.c         | 38 +++++++++++++++--------------
>> >>> >   include/hw/riscv/virt.h |  4 ++++
>> >>> >   5 files changed, 93 insertions(+), 79 deletions(-)

>> >>> > diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
>> >>> > index 39e4cb4..0c8b8e9 100644
>> >>> > --- a/hw/riscv/sifive_e.c
>> >>> > +++ b/hw/riscv/sifive_e.c
>> >>> > @@ -74,14 +74,6 @@ static const struct MemmapEntry {
>> >>> >       [SIFIVE_E_DTIM] =     { 0x80000000,     0x4000 }
>> >>> >   };

>> >>> > -static void copy_le32_to_phys(hwaddr pa, uint32_t *rom, size_t
len)
>> >>> > -{
>> >>> > -    int i;
>> >>> > -    for (i = 0; i < (len >> 2); i++) {
>> >>> > -        stl_phys(&address_space_memory, pa + (i << 2), rom[i]);
>> >>> > -    }
>> >>> > -}
>> >>> > -
>> >>> >   static uint64_t load_kernel(const char *kernel_filename)
>> >>> >   {
>> >>> >       uint64_t kernel_entry, kernel_high;
>> >>> > @@ -112,6 +104,7 @@ static void riscv_sifive_e_init(MachineState
>> *machine)
>> >>> >       MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>> >>> >       MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>> >>> >       MemoryRegion *xip_mem = g_new(MemoryRegion, 1);
>> >>> > +    int i;

>> >>> >       /* Initialize SOC */
>> >>> >       object_initialize(&s->soc, sizeof(s->soc),
>> TYPE_RISCV_HART_ARRAY);
>> >>> > @@ -131,7 +124,7 @@ static void riscv_sifive_e_init(MachineState
>> *machine)
>> >>> >           memmap[SIFIVE_E_DTIM].base, main_mem);

>> >>> >       /* Mask ROM */
>> >>> > -    memory_region_init_ram(mask_rom, NULL, "riscv.sifive.e.mrom",
>> >>> > +    memory_region_init_rom(mask_rom, NULL, "riscv.sifive.e.mrom",
>> >>> >           memmap[SIFIVE_E_MROM].size, &error_fatal);
>> >>> >       memory_region_add_subregion(sys_mem,
>> >>> >           memmap[SIFIVE_E_MROM].base, mask_rom);
>> >>> > @@ -185,9 +178,12 @@ static void riscv_sifive_e_init(MachineState
>> >>> *machine)
>> >>> >           0x00028067,        /* 0x1004: jr      t0 */
>> >>> >       };

>> >>> > -    /* copy in the reset vector */
>> >>> > -    copy_le32_to_phys(memmap[SIFIVE_E_MROM].base, reset_vec,
>> >>> sizeof(reset_vec));
>> >>> > -    memory_region_set_readonly(mask_rom, true);
>> >>> > +    /* copy in the reset vector in little_endian byte order */
>> >>> > +    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
>> >>> > +        reset_vec[i] = cpu_to_le32(reset_vec[i]);
>> >>> > +    }
>> >>> > +    rom_add_blob_fixed_as("mrom.reset", reset_vec,
sizeof(reset_vec),
>> >>> > +                          memmap[SIFIVE_E_MROM].base,
>> >>> &address_space_memory);

>> >>> >       if (machine->kernel_filename) {
>> >>> >           load_kernel(machine->kernel_filename);
>> >>> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
>> >>> > index 115618b..11ba4c3 100644
>> >>> > --- a/hw/riscv/sifive_u.c
>> >>> > +++ b/hw/riscv/sifive_u.c
>> >>> > @@ -52,7 +52,7 @@ static const struct MemmapEntry {
>> >>> >       hwaddr size;
>> >>> >   } sifive_u_memmap[] = {
>> >>> >       [SIFIVE_U_DEBUG] =    {        0x0,      0x100 },
>> >>> > -    [SIFIVE_U_MROM] =     {     0x1000,     0x2000 },
>> >>> > +    [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
>> >>> >       [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
>> >>> >       [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
>> >>> >       [SIFIVE_U_UART0] =    { 0x10013000,     0x1000 },
>> >>> > @@ -60,14 +60,6 @@ static const struct MemmapEntry {
>> >>> >       [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
>> >>> >   };

>> >>> > -static void copy_le32_to_phys(hwaddr pa, uint32_t *rom, size_t
len)
>> >>> > -{
>> >>> > -    int i;
>> >>> > -    for (i = 0; i < (len >> 2); i++) {
>> >>> > -        stl_phys(&address_space_memory, pa + (i << 2), rom[i]);
>> >>> > -    }
>> >>> > -}
>> >>> > -
>> >>> >   static uint64_t load_kernel(const char *kernel_filename)
>> >>> >   {
>> >>> >       uint64_t kernel_entry, kernel_high;
>> >>> > @@ -221,9 +213,10 @@ static void riscv_sifive_u_init(MachineState
>> >>> *machine)
>> >>> >       const struct MemmapEntry *memmap = sifive_u_memmap;

>> >>> >       SiFiveUState *s = g_new0(SiFiveUState, 1);
>> >>> > -    MemoryRegion *sys_memory = get_system_memory();
>> >>> > +    MemoryRegion *system_memory = get_system_memory();
>> >>> >       MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>> >>> > -    MemoryRegion *boot_rom = g_new(MemoryRegion, 1);
>> >>> > +    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>> >>> > +    int i;

>> >>> >       /* Initialize SOC */
>> >>> >       object_initialize(&s->soc, sizeof(s->soc),
>> TYPE_RISCV_HART_ARRAY);
>> >>> > @@ -239,17 +232,17 @@ static void riscv_sifive_u_init(MachineState
>> >>> *machine)
>> >>> >       /* register RAM */
>> >>> >       memory_region_init_ram(main_mem, NULL, "riscv.sifive.u.ram",
>> >>> >                              machine->ram_size, &error_fatal);
>> >>> > -    memory_region_add_subregion(sys_memory,
>> memmap[SIFIVE_U_DRAM].base,
>> >>> > +    memory_region_add_subregion(system_memory,
>> >>> memmap[SIFIVE_U_DRAM].base,
>> >>> >           main_mem);

>> >>> >       /* create device tree */
>> >>> >       create_fdt(s, memmap, machine->ram_size,
>> machine->kernel_cmdline);

>> >>> >       /* boot rom */
>> >>> > -    memory_region_init_ram(boot_rom, NULL, "riscv.sifive.u.mrom",
>> >>> > -                           memmap[SIFIVE_U_MROM].base,
&error_fatal);
>> >>> > -    memory_region_set_readonly(boot_rom, true);
>> >>> > -    memory_region_add_subregion(sys_memory, 0x0, boot_rom);
>> >>> > +    memory_region_init_rom(mask_rom, NULL, "riscv.sifive.u.mrom",
>> >>> > +                           memmap[SIFIVE_U_MROM].size,
&error_fatal);
>> >>> > +    memory_region_add_subregion(system_memory,
>> >>> memmap[SIFIVE_U_MROM].base,
>> >>> > +                                mask_rom);

>> >>> >       if (machine->kernel_filename) {
>> >>> >           load_kernel(machine->kernel_filename);
>> >>> > @@ -272,13 +265,22 @@ static void riscv_sifive_u_init(MachineState
>> >>> *machine)
>> >>> >                                          /* dtb: */
>> >>> >       };

>> >>> > -    /* copy in the reset vector */
>> >>> > -    copy_le32_to_phys(memmap[SIFIVE_U_MROM].base, reset_vec,
>> >>> sizeof(reset_vec));
>> >>> > +    /* copy in the reset vector in little_endian byte order */
>> >>> > +    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
>> >>> > +        reset_vec[i] = cpu_to_le32(reset_vec[i]);
>> >>> > +    }
>> >>> > +    rom_add_blob_fixed_as("mrom.reset", reset_vec,
sizeof(reset_vec),
>> >>> > +                          memmap[SIFIVE_U_MROM].base,
>> >>> &address_space_memory);

>> >>> >       /* copy in the device tree */
>> >>> > +    if (s->fdt_size >= memmap[SIFIVE_U_MROM].size -
>> sizeof(reset_vec)) {
>> >>> > +        error_report("qemu: not enough space to store
device-tree");
>> >>> > +        exit(1);
>> >>> > +    }
>> >>> >       qemu_fdt_dumpdtb(s->fdt, s->fdt_size);
>> >>> > -    cpu_physical_memory_write(memmap[SIFIVE_U_MROM].base +
>> >>> > -        sizeof(reset_vec), s->fdt, s->fdt_size);
>> >>> > +    rom_add_blob_fixed_as("mrom.fdt", s->fdt, s->fdt_size,
>> >>> > +                          memmap[SIFIVE_U_MROM].base +
>> sizeof(reset_vec),
>> >>> > +                          &address_space_memory);

>> >>> >       /* MMIO */
>> >>> >       s->plic = sifive_plic_create(memmap[SIFIVE_U_PLIC].base,
>> >>> > @@ -292,9 +294,9 @@ static void riscv_sifive_u_init(MachineState
>> *machine)
>> >>> >           SIFIVE_U_PLIC_CONTEXT_BASE,
>> >>> >           SIFIVE_U_PLIC_CONTEXT_STRIDE,
>> >>> >           memmap[SIFIVE_U_PLIC].size);
>> >>> > -    sifive_uart_create(sys_memory, memmap[SIFIVE_U_UART0].base,
>> >>> > +    sifive_uart_create(system_memory, memmap[SIFIVE_U_UART0].base,
>> >>> >           serial_hds[0],
>> SIFIVE_PLIC(s->plic)->irqs[SIFIVE_U_UART0_IRQ]);
>> >>> > -    /* sifive_uart_create(sys_memory, memmap[SIFIVE_U_UART1].base,
>> >>> > +    /* sifive_uart_create(system_memory,
memmap[SIFIVE_U_UART1].base,
>> >>> >           serial_hds[1],
>> SIFIVE_PLIC(s->plic)->irqs[SIFIVE_U_UART1_IRQ]);
>> >>> */
>> >>> >       sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
>> >>> >           memmap[SIFIVE_U_CLINT].size, smp_cpus,
>> >>> > diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
>> >>> > index 3f6bd0a..d1dbe6b 100644
>> >>> > --- a/hw/riscv/spike.c
>> >>> > +++ b/hw/riscv/spike.c
>> >>> > @@ -46,19 +46,11 @@ static const struct MemmapEntry {
>> >>> >       hwaddr base;
>> >>> >       hwaddr size;
>> >>> >   } spike_memmap[] = {
>> >>> > -    [SPIKE_MROM] =     {     0x1000,     0x2000 },
>> >>> > +    [SPIKE_MROM] =     {     0x1000,    0x11000 },
>> >>> >       [SPIKE_CLINT] =    {  0x2000000,    0x10000 },
>> >>> >       [SPIKE_DRAM] =     { 0x80000000,        0x0 },
>> >>> >   };

>> >>> > -static void copy_le32_to_phys(hwaddr pa, uint32_t *rom, size_t
len)
>> >>> > -{
>> >>> > -    int i;
>> >>> > -    for (i = 0; i < (len >> 2); i++) {
>> >>> > -        stl_phys(&address_space_memory, pa + (i << 2), rom[i]);
>> >>> > -    }
>> >>> > -}
>> >>> > -
>> >>> >   static uint64_t load_kernel(const char *kernel_filename)
>> >>> >   {
>> >>> >       uint64_t kernel_entry, kernel_high;
>> >>> > @@ -173,7 +165,8 @@ static void
spike_v1_10_0_board_init(MachineState
>> >>> *machine)
>> >>> >       SpikeState *s = g_new0(SpikeState, 1);
>> >>> >       MemoryRegion *system_memory = get_system_memory();
>> >>> >       MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>> >>> > -    MemoryRegion *boot_rom = g_new(MemoryRegion, 1);
>> >>> > +    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>> >>> > +    int i;

>> >>> >       /* Initialize SOC */
>> >>> >       object_initialize(&s->soc, sizeof(s->soc),
>> TYPE_RISCV_HART_ARRAY);
>> >>> > @@ -196,9 +189,10 @@ static void
spike_v1_10_0_board_init(MachineState
>> >>> *machine)
>> >>> >       create_fdt(s, memmap, machine->ram_size,
>> machine->kernel_cmdline);

>> >>> >       /* boot rom */
>> >>> > -    memory_region_init_ram(boot_rom, NULL, "riscv.spike.bootrom",
>> >>> > -                           s->fdt_size + 0x2000, &error_fatal);
>> >>> > -    memory_region_add_subregion(system_memory, 0x0, boot_rom);
>> >>> > +    memory_region_init_rom(mask_rom, NULL, "riscv.spike.mrom",
>> >>> > +                           memmap[SPIKE_MROM].size, &error_fatal);
>> >>> > +    memory_region_add_subregion(system_memory,
>> memmap[SPIKE_MROM].base,
>> >>> > +                                mask_rom);

>> >>> >       if (machine->kernel_filename) {
>> >>> >           load_kernel(machine->kernel_filename);
>> >>> > @@ -221,16 +215,25 @@ static void
>> spike_v1_10_0_board_init(MachineState
>> >>> *machine)
>> >>> >                                        /* dtb: */
>> >>> >       };

>> >>> > -    /* copy in the reset vector */
>> >>> > -    copy_le32_to_phys(memmap[SPIKE_MROM].base, reset_vec,
>> >>> sizeof(reset_vec));
>> >>> > +    /* copy in the reset vector in little_endian byte order */
>> >>> > +    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
>> >>> > +        reset_vec[i] = cpu_to_le32(reset_vec[i]);
>> >>> > +    }
>> >>> > +    rom_add_blob_fixed_as("mrom.reset", reset_vec,
sizeof(reset_vec),
>> >>> > +                          memmap[SPIKE_MROM].base,
>> >>> &address_space_memory);

>> >>> >       /* copy in the device tree */
>> >>> > +    if (s->fdt_size >= memmap[SPIKE_MROM].size -
sizeof(reset_vec)) {
>> >>> > +        error_report("qemu: not enough space to store
device-tree");
>> >>> > +        exit(1);
>> >>> > +    }
>> >>> >       qemu_fdt_dumpdtb(s->fdt, s->fdt_size);
>> >>> > -    cpu_physical_memory_write(memmap[SPIKE_MROM].base +
>> >>> sizeof(reset_vec),
>> >>> > -        s->fdt, s->fdt_size);
>> >>> > +    rom_add_blob_fixed_as("mrom.fdt", s->fdt, s->fdt_size,
>> >>> > +                          memmap[SPIKE_MROM].base +
>> sizeof(reset_vec),
>> >>> > +                          &address_space_memory);

>> >>> >       /* initialize HTIF using symbols found in load_kernel */
>> >>> > -    htif_mm_init(system_memory, boot_rom, &s->soc.harts[0].env,
>> >>> serial_hds[0]);
>> >>> > +    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env,
>> >>> serial_hds[0]);

>> >>> >       /* Core Local Interruptor (timer and IPI) */
>> >>> >       sifive_clint_create(memmap[SPIKE_CLINT].base,
>> >>> memmap[SPIKE_CLINT].size,
>> >>> > @@ -244,7 +247,8 @@ static void
spike_v1_09_1_board_init(MachineState
>> >>> *machine)
>> >>> >       SpikeState *s = g_new0(SpikeState, 1);
>> >>> >       MemoryRegion *system_memory = get_system_memory();
>> >>> >       MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>> >>> > -    MemoryRegion *boot_rom = g_new(MemoryRegion, 1);
>> >>> > +    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>> >>> > +    int i;

>> >>> >       /* Initialize SOC */
>> >>> >       object_initialize(&s->soc, sizeof(s->soc),
>> TYPE_RISCV_HART_ARRAY);
>> >>> > @@ -264,9 +268,10 @@ static void
spike_v1_09_1_board_init(MachineState
>> >>> *machine)
>> >>> >           main_mem);

>> >>> >       /* boot rom */
>> >>> > -    memory_region_init_ram(boot_rom, NULL, "riscv.spike.bootrom",
>> >>> > -                           0x40000, &error_fatal);
>> >>> > -    memory_region_add_subregion(system_memory, 0x0, boot_rom);
>> >>> > +    memory_region_init_rom(mask_rom, NULL, "riscv.spike.mrom",
>> >>> > +                           memmap[SPIKE_MROM].size, &error_fatal);
>> >>> > +    memory_region_add_subregion(system_memory,
>> memmap[SPIKE_MROM].base,
>> >>> > +                                mask_rom);

>> >>> >       if (machine->kernel_filename) {
>> >>> >           load_kernel(machine->kernel_filename);
>> >>> > @@ -319,15 +324,20 @@ static void
>> spike_v1_09_1_board_init(MachineState
>> >>> *machine)
>> >>> >       g_free(isa);
>> >>> >       size_t config_string_len = strlen(config_string);

>> >>> > -    /* copy in the reset vector */
>> >>> > -    copy_le32_to_phys(memmap[SPIKE_MROM].base, reset_vec,
>> >>> sizeof(reset_vec));
>> >>> > +    /* copy in the reset vector in little_endian byte order */
>> >>> > +    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
>> >>> > +        reset_vec[i] = cpu_to_le32(reset_vec[i]);
>> >>> > +    }
>> >>> > +    rom_add_blob_fixed_as("mrom.reset", reset_vec,
sizeof(reset_vec),
>> >>> > +                          memmap[SPIKE_MROM].base,
>> >>> &address_space_memory);

>> >>> >       /* copy in the config string */
>> >>> > -    cpu_physical_memory_write(memmap[SPIKE_MROM].base +
>> >>> sizeof(reset_vec),
>> >>> > -        config_string, config_string_len);
>> >>> > +    rom_add_blob_fixed_as("mrom.reset", config_string,
>> config_string_len,
>> >>> > +                          memmap[SPIKE_MROM].base +
>> sizeof(reset_vec),
>> >>> > +                          &address_space_memory);

>> >>> >       /* initialize HTIF using symbols found in load_kernel */
>> >>> > -    htif_mm_init(system_memory, boot_rom, &s->soc.harts[0].env,
>> >>> serial_hds[0]);
>> >>> > +    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env,
>> >>> serial_hds[0]);

>> >>> >       /* Core Local Interruptor (timer and IPI) */
>> >>> >       sifive_clint_create(memmap[SPIKE_CLINT].base,
>> >>> memmap[SPIKE_CLINT].size,
>> >>> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> >>> > index 090befe..20c509d 100644
>> >>> > --- a/hw/riscv/virt.c
>> >>> > +++ b/hw/riscv/virt.c
>> >>> > @@ -45,8 +45,8 @@ static const struct MemmapEntry {
>> >>> >       hwaddr size;
>> >>> >   } virt_memmap[] = {
>> >>> >       [VIRT_DEBUG] =    {        0x0,      0x100 },
>> >>> > -    [VIRT_MROM] =     {     0x1000,     0x2000 },
>> >>> > -    [VIRT_TEST] =     {     0x4000,     0x1000 },
>> >>> > +    [VIRT_MROM] =     {     0x1000,    0x11000 },
>> >>> > +    [VIRT_TEST] =     {   0x100000,     0x1000 },
>> >>> >       [VIRT_CLINT] =    {  0x2000000,    0x10000 },
>> >>> >       [VIRT_PLIC] =     {  0xc000000,  0x4000000 },
>> >>> >       [VIRT_UART0] =    { 0x10000000,      0x100 },
>> >>> > @@ -54,14 +54,6 @@ static const struct MemmapEntry {
>> >>> >       [VIRT_DRAM] =     { 0x80000000,        0x0 },
>> >>> >   };

>> >>> > -static void copy_le32_to_phys(hwaddr pa, uint32_t *rom, size_t
len)
>> >>> > -{
>> >>> > -    int i;
>> >>> > -    for (i = 0; i < (len >> 2); i++) {
>> >>> > -        stl_phys(&address_space_memory, pa + (i << 2), rom[i]);
>> >>> > -    }
>> >>> > -}
>> >>> > -
>> >>> >   static uint64_t load_kernel(const char *kernel_filename)
>> >>> >   {
>> >>> >       uint64_t kernel_entry, kernel_high;
>> >>> > @@ -272,7 +264,7 @@ static void riscv_virt_board_init(MachineState
>> >>> *machine)
>> >>> >       RISCVVirtState *s = g_new0(RISCVVirtState, 1);
>> >>> >       MemoryRegion *system_memory = get_system_memory();
>> >>> >       MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>> >>> > -    MemoryRegion *boot_rom = g_new(MemoryRegion, 1);
>> >>> > +    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>> >>> >       char *plic_hart_config;
>> >>> >       size_t plic_hart_config_len;
>> >>> >       int i;
>> >>> > @@ -299,9 +291,10 @@ static void riscv_virt_board_init(MachineState
>> >>> *machine)
>> >>> >       fdt = create_fdt(s, memmap, machine->ram_size,
>> >>> machine->kernel_cmdline);

>> >>> >       /* boot rom */
>> >>> > -    memory_region_init_ram(boot_rom, NULL,
>> "riscv_virt_board.bootrom",
>> >>> > -                           s->fdt_size + 0x2000, &error_fatal);
>> >>> > -    memory_region_add_subregion(system_memory, 0x0, boot_rom);
>> >>> > +    memory_region_init_rom(mask_rom, NULL,
"riscv_virt_board.mrom",
>> >>> > +                           memmap[VIRT_MROM].size, &error_fatal);
>> >>> > +    memory_region_add_subregion(system_memory,
>> memmap[VIRT_MROM].base,
>> >>> > +                                mask_rom);

>> >>> >       if (machine->kernel_filename) {
>> >>> >           uint64_t kernel_entry =
>> load_kernel(machine->kernel_filename);
>> >>> > @@ -335,13 +328,22 @@ static void
riscv_virt_board_init(MachineState
>> >>> *machine)
>> >>> >                                        /* dtb: */
>> >>> >       };

>> >>> > -    /* copy in the reset vector */
>> >>> > -    copy_le32_to_phys(memmap[VIRT_MROM].base, reset_vec,
>> >>> sizeof(reset_vec));
>> >>> > +    /* copy in the reset vector in little_endian byte order */
>> >>> > +    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
>> >>> > +        reset_vec[i] = cpu_to_le32(reset_vec[i]);
>> >>> > +    }
>> >>> > +    rom_add_blob_fixed_as("mrom.reset", reset_vec,
sizeof(reset_vec),
>> >>> > +                          memmap[VIRT_MROM].base,
>> &address_space_memory);

>> >>> >       /* copy in the device tree */
>> >>> > +    if (s->fdt_size >= memmap[VIRT_MROM].size -
sizeof(reset_vec)) {
>> >>> > +        error_report("qemu: not enough space to store
device-tree");
>> >>> > +        exit(1);
>> >>> > +    }
>> >>> >       qemu_fdt_dumpdtb(s->fdt, s->fdt_size);
>> >>> > -    cpu_physical_memory_write(memmap[VIRT_MROM].base +
>> sizeof(reset_vec),
>> >>> > -        s->fdt, s->fdt_size);
>> >>> > +    rom_add_blob_fixed_as("mrom.fdt", s->fdt, s->fdt_size,
>> >>> > +                          memmap[VIRT_MROM].base +
sizeof(reset_vec),
>> >>> > +                          &address_space_memory);

>> >>> >       /* create PLIC hart topology configuration string */
>> >>> >       plic_hart_config_len = (strlen(VIRT_PLIC_HART_CONFIG) + 1) *
>> >>> smp_cpus;
>> >>> > diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
>> >>> > index 91163d6..6f2668e 100644
>> >>> > --- a/include/hw/riscv/virt.h
>> >>> > +++ b/include/hw/riscv/virt.h
>> >>> > @@ -19,6 +19,10 @@
>> >>> >   #ifndef HW_RISCV_VIRT_H
>> >>> >   #define HW_RISCV_VIRT_H

>> >>> > +#define TYPE_RISCV_VIRT_BOARD "riscv.virt"
>> >>> > +#define VIRT(obj) \
>> >>> > +    OBJECT_CHECK(RISCVVirtState, (obj), TYPE_RISCV_VIRT_BOARD)
>> >>> > +

>> >>> This should be in a seperate patch.


>> >> I'll shift that chunk into "Remove unused class definitions".


>> > Actually we to need to drop this chunk as the unused check macros were
>> removed from machine state structs in "Remove unused class definitions".
>> Somehow the chunk made it into this patch. Likely a rebase issue.

>> > It's probably best that we add what we need back in the QOM SOC
refactor
>> on-top of the this series, or at least after the first set of patches are
>> merged...

>> > I think that's what you were planning to do anyway.

>> Yeah, that works. So just remove it from this series.


> After rebasing I had to change this patch because of this patch which
increases the default device tree size to 1MiB. This is not controllable by
the user and we don't know how big the resultant device-tree is. It could
be < 8KiB in our case.

> -
https://git.qemu.org/?p=qemu.git;a=commit;h=14ec3cbd7c1e31dca4d23f028100c8f43e156573

> I studied ftd and used public interfaces and a mechanism consistent with
the fdt resize functions to calculate the size. As far as I can tell it is
accurate and covers exactly to the end of the uint32 terminator. I needed
this because our ROMs are currently small.

> Peter, this is the patch that changes our ROMs from RAM to ROM using
memory_region_init_rom and rom_add_blob_fixed_as (as per hw/arm/boot.c),
and it also adds a truncation warning, so that we actually know what size
the device-tree is, given our ROMs are currently much smaller than 1MiB.
That is why we needed a method that tells us how big the device tree
actually is.

> BTW I'm actually suspicious of 'fdt_resize' here:

> -
https://git.qemu.org/?p=dtc.git;a=blob;f=libfdt/fdt_sw.c;h=6d33cc29d0224d9fc6307607ef7563df944da2d3

> as it doesn't check that 'bufsize' has enough space for the header and
terminator, although that's potentially a dtc bug. I read dtc to make sure
the method we use to calculate the size was accurate. There probably should
be a method in dtc as we rely on some implementation details, however they
are quite simple and we can get: sizeof(header) + sizeof(structs) +
sizeof(strings) + terminator using public APIs and basic knowledge of the
serialised device-tree form.

> Anyway, here is the rebased version of this patch using the new
'qemu_fdt_totalsize' method in the patch I just sent.

> -
https://github.com/riscv/riscv-qemu/commit/a65f6e0447d6e32d75f64ba31df5f20d529d0489

> I have a feeling this is the patch that fixes sifive_u. Did you bisect
which patch in the series fixed sifive_u?

I agree, I think this is the patch.

No, I havent' bisected it. I didn't think there was much point, but if we
want patches backported to stable I guess there is. I'll dig into it.


> I have to send a pull for the reviewed patches which I can do today, but
this is one of the patches that is early in the series that does not yet
have Reviewed-by. When I split the series this patch would be in a second
series that i'll have to link to the pull in patchew (using the method
Peter mentioned) or wait until the pull is accepted.

Great, let's get the first part of the series merged. It'd be nice to send
out the next version of the second part while the PR is being merged.

Alistair


> Michael.

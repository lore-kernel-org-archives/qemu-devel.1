Received: from eggs.gnu.org ([2001:4830:134:3::10]:39802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fc3YF-0000WF-Rq
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 02:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fc3YD-000653-Rv
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 02:52:07 -0400
References: <20180627232334.14142-1-laurent@vivier.eu>
	<20180627232334.14142-11-laurent@vivier.eu>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <151b05fa-3798-d33b-49ee-fdfc0ad07bc1@tuxfamily.org>
Date: Sun, 8 Jul 2018 08:51:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180627232334.14142-11-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [C v2 10/10] hw/m68k: define Macintosh Quadra 800
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 28.06.2018 01:23, Laurent Vivier wrote:
> From: Laurent Vivier <Laurent@Vivier.EU>
> 
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  MAINTAINERS                      |  19 ++
>  default-configs/m68k-softmmu.mak |  14 ++
>  hw/intc/Makefile.objs            |   1 +
>  hw/intc/q800_irq.c               |  73 ++++++++
>  hw/m68k/Makefile.objs            |   6 +-
>  hw/m68k/bootinfo.h               | 100 ++++++++++
>  hw/m68k/q800.c                   | 385 +++++++++++++++++++++++++++++++++++++++
>  include/hw/intc/q800_irq.h       |  39 ++++
>  tests/qom-test.c                 |   5 +
>  tests/test-hmp.c                 |   3 +-
>  10 files changed, 642 insertions(+), 3 deletions(-)
>  create mode 100644 hw/intc/q800_irq.c
>  create mode 100644 hw/m68k/bootinfo.h
>  create mode 100644 hw/m68k/q800.c
>  create mode 100644 include/hw/intc/q800_irq.h
[...]
> diff --git a/hw/m68k/bootinfo.h b/hw/m68k/bootinfo.h
> new file mode 100644
> index 0000000000..6584775f6d
> --- /dev/null
> +++ b/hw/m68k/bootinfo.h
> @@ -0,0 +1,100 @@

Please add a comment with copyright information, and maybe also some
proper header guards.

Maybe it would also be better to rename this file to "mac-bootinfo.h" or
so, to make it clear that it is not related to coldfire or other 68k boards?

> +struct bi_record {
> +    uint16_t tag;        /* tag ID */
> +    uint16_t size;       /* size of record */
> +    uint32_t data[0];    /* data */
> +};
> +
> +/* machine independent tags */
> +
> +#define BI_LAST         0x0000 /* last record */
> +#define BI_MACHTYPE     0x0001 /* machine type (u_long) */
> +#define BI_CPUTYPE      0x0002 /* cpu type (u_long) */
> +#define BI_FPUTYPE      0x0003 /* fpu type (u_long) */
> +#define BI_MMUTYPE      0x0004 /* mmu type (u_long) */
> +#define BI_MEMCHUNK     0x0005 /* memory chunk address and size */
> +                               /* (struct mem_info) */
> +#define BI_RAMDISK      0x0006 /* ramdisk address and size */
> +                               /* (struct mem_info) */
> +#define BI_COMMAND_LINE 0x0007 /* kernel command line parameters */
> +                               /* (string) */
> +
> +/*  Macintosh-specific tags (all u_long) */
> +
> +#define BI_MAC_MODEL    0x8000  /* Mac Gestalt ID (model type) */
> +#define BI_MAC_VADDR    0x8001  /* Mac video base address */
> +#define BI_MAC_VDEPTH   0x8002  /* Mac video depth */
> +#define BI_MAC_VROW     0x8003  /* Mac video rowbytes */
> +#define BI_MAC_VDIM     0x8004  /* Mac video dimensions */
> +#define BI_MAC_VLOGICAL 0x8005  /* Mac video logical base */
> +#define BI_MAC_SCCBASE  0x8006  /* Mac SCC base address */
> +#define BI_MAC_BTIME    0x8007  /* Mac boot time */
> +#define BI_MAC_GMTBIAS  0x8008  /* Mac GMT timezone offset */
> +#define BI_MAC_MEMSIZE  0x8009  /* Mac RAM size (sanity check) */
> +#define BI_MAC_CPUID    0x800a  /* Mac CPU type (sanity check) */
> +#define BI_MAC_ROMBASE  0x800b  /* Mac system ROM base address */
> +
> +/*  Macintosh hardware profile data */
> +
> +#define BI_MAC_VIA1BASE 0x8010  /* Mac VIA1 base address (always present) */
> +#define BI_MAC_VIA2BASE 0x8011  /* Mac VIA2 base address (type varies) */
> +#define BI_MAC_VIA2TYPE 0x8012  /* Mac VIA2 type (VIA, RBV, OSS) */
> +#define BI_MAC_ADBTYPE  0x8013  /* Mac ADB interface type */
> +#define BI_MAC_ASCBASE  0x8014  /* Mac Apple Sound Chip base address */
> +#define BI_MAC_SCSI5380 0x8015  /* Mac NCR 5380 SCSI (base address, multi) */
> +#define BI_MAC_SCSIDMA  0x8016  /* Mac SCSI DMA (base address) */
> +#define BI_MAC_SCSI5396 0x8017  /* Mac NCR 53C96 SCSI (base address, multi) */
> +#define BI_MAC_IDETYPE  0x8018  /* Mac IDE interface type */
> +#define BI_MAC_IDEBASE  0x8019  /* Mac IDE interface base address */
> +#define BI_MAC_NUBUS    0x801a  /* Mac Nubus type (none, regular, pseudo) */
> +#define BI_MAC_SLOTMASK 0x801b  /* Mac Nubus slots present */
> +#define BI_MAC_SCCTYPE  0x801c  /* Mac SCC serial type (normal, IOP) */
> +#define BI_MAC_ETHTYPE  0x801d  /* Mac builtin ethernet type (Sonic, MACE */
> +#define BI_MAC_ETHBASE  0x801e  /* Mac builtin ethernet base address */
> +#define BI_MAC_PMU      0x801f  /* Mac power management / poweroff hardware */
> +#define BI_MAC_IOP_SWIM 0x8020  /* Mac SWIM floppy IOP */
> +#define BI_MAC_IOP_ADB  0x8021  /* Mac ADB IOP */
> +
> +#define BOOTINFO0(as, base, id) \
> +    do { \
> +        stw_phys(as, base, id); \
> +        base += 2; \
> +        stw_phys(as, base, sizeof(struct bi_record)); \
> +        base += 2; \
> +    } while (0)
> +
> +#define BOOTINFO1(as, base, id, value) \
> +    do { \
> +        stw_phys(as, base, id); \
> +        base += 2; \
> +        stw_phys(as, base, sizeof(struct bi_record) + 4); \
> +        base += 2; \
> +        stl_phys(as, base, value); \
> +        base += 4; \
> +    } while (0)
> +
> +#define BOOTINFO2(as, base, id, value1, value2) \
> +    do { \
> +        stw_phys(as, base, id); \
> +        base += 2; \
> +        stw_phys(as, base, sizeof(struct bi_record) + 8); \
> +        base += 2; \
> +        stl_phys(as, base, value1); \
> +        base += 4; \
> +        stl_phys(as, base, value2); \
> +        base += 4; \
> +    } while (0)
> +
> +#define BOOTINFOSTR(as, base, id, string) \
> +    do { \
> +        int i; \
> +        stw_phys(as, base, id); \
> +        base += 2; \
> +        stw_phys(as, base, \
> +                 (sizeof(struct bi_record) + strlen(string) + 2) & ~1); \
> +        base += 2; \
> +        for (i = 0; string[i]; i++) { \
> +            stb_phys(as, base++, string[i]); \
> +        } \
> +        stb_phys(as, base++, 0); \
> +        base = (parameters_base + 1) & ~1; \
> +    } while (0)
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> new file mode 100644
> index 0000000000..51ad3c6c76
> --- /dev/null
> +++ b/hw/m68k/q800.c
> @@ -0,0 +1,385 @@
[...]
> +static void q800_init(MachineState *machine)
> +{
> +    M68kCPU *cpu = NULL;
> +    int linux_boot;
> +    int32_t kernel_size;
> +    uint64_t elf_entry;
> +    char *filename;
> +    int bios_size;
> +    ram_addr_t initrd_base;
> +    int32_t initrd_size;
> +    MemoryRegion *rom;
> +    MemoryRegion *ram;
> +    ram_addr_t ram_size = machine->ram_size;
> +    const char *kernel_filename = machine->kernel_filename;
> +    const char *initrd_filename = machine->initrd_filename;
> +    const char *kernel_cmdline = machine->kernel_cmdline;
> +    hwaddr parameters_base;
> +    CPUState *cs;
> +    DeviceState *dev;
> +    DeviceState *via_dev, *pic_dev;
> +    SysBusESPState *sysbus_esp;
> +    ESPState *esp;
> +    SysBusDevice *sysbus;
> +    BusState *adb_bus;
> +    NubusBus *nubus;
> +    DriveInfo *fds[2];
> +
> +    linux_boot = (kernel_filename != NULL);
> +
> +    /* init CPUs */
> +    cpu = M68K_CPU(cpu_create(machine->cpu_type));
> +    if (!cpu) {
> +            hw_error("qemu: unable to find m68k CPU definition\n");
> +            exit(1);
> +    }

I think the check for !cpu is not necessary anymore since
4482e05cbbb7e50e476f6a9500cf0b38913bd939 ... anyway, please don't use
hw_error() for error reporting here, but rather use error_report() instead.

> +    qemu_register_reset(main_cpu_reset, cpu);
> +
> +    ram = g_malloc(sizeof(*ram));
> +    memory_region_init_ram(ram, NULL, "m68k_mac.ram", ram_size, &error_abort);
> +    memory_region_add_subregion(get_system_memory(), 0, ram);
> +
> +    /* IRQ controller */
> +
> +    pic_dev = qdev_create(NULL, TYPE_Q800_IRQC);
> +    object_property_set_link(OBJECT(pic_dev), OBJECT(cpu), "cpu",
> +                             &error_abort);
> +    qdev_init_nofail(pic_dev);
> +
> +    /* VIA */
> +
> +    via_dev = qdev_create(NULL, TYPE_MAC_VIA);
> +    qdev_init_nofail(via_dev);
> +    sysbus = SYS_BUS_DEVICE(via_dev);
> +    sysbus_mmio_map(sysbus, 0, VIA_BASE);
> +    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 0,
> +                                qdev_get_gpio_in(pic_dev, 0));
> +    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 1,
> +                                qdev_get_gpio_in(pic_dev, 1));
> +
> +    adb_bus = qdev_get_child_bus(via_dev, "adb.0");
> +    dev = qdev_create(adb_bus, TYPE_ADB_KEYBOARD);
> +    qdev_init_nofail(dev);
> +    dev = qdev_create(adb_bus, TYPE_ADB_MOUSE);
> +    qdev_init_nofail(dev);
> +
> +    /* MACSONIC */
> +
> +    if (nb_nics != 1) {
> +        hw_error("Q800 needs a dp83932 ethernet interfaces");

That error message is certainly wrong, and please don't use hw_error()
for non-cpu related errors. Maybe rather:

 if (nb_nics > 1) {
   error_report("Q800 can only have one ethernet interface");
   exit(1);
 }

?

Also please make sure that your code can run with --nodefaults, too.
(The NIC can be created but simply not be connected in that case)

> +    }
> +    if (!nd_table[0].model) {
> +        nd_table[0].model = g_strdup("dp83932");
> +    }
> +    if (strcmp(nd_table[0].model, "dp83932") != 0) {
> +        hw_error("Q800 needs a dp83932 ethernet interfaces");

Simply rely on the qemu_check_nic_model() below instead?

> +    } else {
> +        /* MacSonic driver needs an Apple MAC address
> +         * Valid prefix are:
> +         * 00:05:02 Apple
> +         * 00:80:19 Dayna Communications, Inc.
> +         * 00:A0:40 Apple
> +         * 08:00:07 Apple
> +         * (Q800 use the last one)
> +         */
> +        nd_table[0].macaddr.a[0] = 0x08;
> +        nd_table[0].macaddr.a[1] = 0x00;
> +        nd_table[0].macaddr.a[2] = 0x07;
> +    }
> +    qemu_check_nic_model(&nd_table[0], "dp83932");
> +    dev = qdev_create(NULL, "dp8393x");
> +    qdev_set_nic_properties(dev, &nd_table[0]);
[...]
> +    /* SWIM floppy controller */
> +
> +    if (drive_get_max_bus(IF_FLOPPY) >= 2) {
> +        fprintf(stderr, "qemu: too many floppy drives\n");

error_report() please.

> +        exit(1);
> +    }
> +    fds[0] = drive_get(IF_FLOPPY, 0, 0);
> +    fds[1] = drive_get(IF_FLOPPY, 0, 1);
[...]
> +        /* load initrd */
> +        if (initrd_filename) {
> +            initrd_size = get_image_size(initrd_filename);
> +            if (initrd_size < 0) {
> +                hw_error("qemu: could not load initial ram disk '%s'\n",
> +                         initrd_filename);

error_report() please.

> +                exit(1);
> +            }
> +
> +            initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
> +            load_image_targphys(initrd_filename, initrd_base,
> +                                ram_size - initrd_base);
> +            BOOTINFO2(cs->as, parameters_base, BI_RAMDISK, initrd_base,
> +                      initrd_size);
> +        } else {
> +            initrd_base = 0;
> +            initrd_size = 0;
> +        }
> +        BOOTINFO0(cs->as, parameters_base, BI_LAST);
> +    } else {
> +        uint8_t *ptr;
> +        /* allocate and load BIOS */
> +        rom = g_malloc(sizeof(*rom));
> +        memory_region_init_ram(rom, NULL, "m68k_mac.rom", MACROM_SIZE,
> +                               &error_abort);
> +        if (bios_name == NULL) {
> +            bios_name = MACROM_FILENAME;
> +        }
> +        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +        memory_region_set_readonly(rom, true);
> +        memory_region_add_subregion(get_system_memory(), MACROM_ADDR, rom);
> +
> +        /* Load MacROM binary */
> +        if (filename) {
> +            bios_size = load_image_targphys(filename, MACROM_ADDR, MACROM_SIZE);
> +            g_free(filename);
> +        } else {
> +            bios_size = -1;
> +        }
> +        if (bios_size < 0 || bios_size > MACROM_SIZE) {
> +            hw_error("qemu: could not load MacROM '%s'\n", bios_name);

error_report() please.

> +            exit(1);
> +        }
> +        ptr = rom_ptr(MACROM_ADDR);
> +        stl_phys(cs->as, 0, ldl_p(ptr));    /* reset initial SP */
> +        stl_phys(cs->as, 4,
> +                 MACROM_ADDR + ldl_p(ptr + 4)); /* reset initial PC */
> +    }
> +}
[...]
> diff --git a/tests/qom-test.c b/tests/qom-test.c
> index e6f712cbd3..373699fda4 100644
> --- a/tests/qom-test.c
> +++ b/tests/qom-test.c
> @@ -19,12 +19,17 @@ static const char *blacklist_x86[] = {
>      "xenfv", "xenpv", NULL
>  };
>  
> +static const char *blacklist_m68k[] = {
> +    "q800", NULL
> +};
> +
>  static const struct {
>      const char *arch;
>      const char **machine;
>  } blacklists[] = {
>      { "i386", blacklist_x86 },
>      { "x86_64", blacklist_x86 },
> +    { "m68k", blacklist_m68k },
>  };
>  
>  static bool is_blacklisted(const char *arch, const char *mach)
> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> index 5352c9c088..f3b79d5bdf 100644
> --- a/tests/test-hmp.c
> +++ b/tests/test-hmp.c
> @@ -139,7 +139,8 @@ static void add_machine_test_case(const char *mname)
>      char *path;
>  
>      /* Ignore blacklisted machines that have known problems */
> -    if (!strcmp("xenfv", mname) || !strcmp("xenpv", mname)) {
> +    if (!strcmp("xenfv", mname) || !strcmp("xenpv", mname) ||
> +        !strcmp("q800", mname)) {
>          return;
>      }

Introducing a new machine and immediately black-listing it in the tests
is super ugly. What's the problem here, and why can't you fix them? You
need at least to elaborate on that topic in the patch description.

 Thomas

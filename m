Received: from eggs.gnu.org ([2001:4830:134:3::10]:46149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eqhQo-0001Dc-GO
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:44:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eqhQj-0006c7-0M
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:44:42 -0500
Date: Tue, 27 Feb 2018 16:44:24 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180227164424.21db3095@redhat.com>
In-Reply-To: <68d715a4-34f9-3900-1e1f-be94e16a871a@redhat.com>
References: <1519303376-92875-1-git-send-email-imammedo@redhat.com>
	<1519303376-92875-6-git-send-email-imammedo@redhat.com>
	<68d715a4-34f9-3900-1e1f-be94e16a871a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/9] pc: acpi: isolate FADT specific data
 into AcpiFadtData structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, 27 Feb 2018 14:47:16 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Igor,
> 
> On 22/02/18 13:42, Igor Mammedov wrote:
> > move FADT data initialization out of fadt_setup() into dedicated
> > init_fadt_data() that will set common for pc/q35 values in
> > AcpiFadtData structure and acpi_get_pm_info() will complement
> > it with pc/q35 specific values initialization.  
> acpi_get_pm_info only adds reset stuff + version info on top of
> previously initialized common data, right?
yep

> > That will allow to get rid of fadt_setup() and generalize
> > build_fadt() so it could be easily extended for rev5 and
> > reused by ARM target.
> > 
> > While at it also move facs/dsdt/xdsdt offsets from build_fadt()
> > arg list into AcpiFadtData, as they belong to the same dataset.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/hw/acpi/acpi-defs.h |  28 ++++++
> >  hw/i386/acpi-build.c        | 204 ++++++++++++++++++++++++--------------------
> >  2 files changed, 138 insertions(+), 94 deletions(-)
> > 
> > diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> > index 9942bc5..e0accc4 100644
> > --- a/include/hw/acpi/acpi-defs.h
> > +++ b/include/hw/acpi/acpi-defs.h
> > @@ -175,6 +175,34 @@ struct AcpiFadtDescriptorRev5_1 {
> >  
> >  typedef struct AcpiFadtDescriptorRev5_1 AcpiFadtDescriptorRev5_1;
> >  
> > +typedef struct AcpiFadtData {
> > +    struct AcpiGenericAddress pm1_cnt;   /* PM1a_CNT_BLK */  
> Any reason why we don't use the same field names as in
> AcpiFadtDescriptorRev3?
I'll amend it on respin as you suggest.

> 
> for instance pm1a_cnt?
> > +    struct AcpiGenericAddress pm1_evt;   /* PM1a_EVT_BLK */  
> pm1a_evt?
> > +    struct AcpiGenericAddress pm_tmr;    /* PM_TMR_BLK */
> > +    struct AcpiGenericAddress gpe0_blk;  /* GPE0_BLK */
> > +    struct AcpiGenericAddress reset_reg; /* RESET_REG */
> > +    uint8_t reset_val;         /* RESET_VALUE */
> > +    uint8_t  rev;              /* Revision */
> > +    uint32_t flags;            /* Flags */
> > +    uint32_t smi_cmd;          /* SMI_CMD */
> > +    uint16_t sci_int;          /* SCI_INT */
> > +    uint8_t  int_model;        /* INT_MODEL */
> > +    uint8_t  acpi_enable_cmd;  /* ACPI_ENABLE */
> > +    uint8_t  acpi_disable_cmd; /* ACPI_DISABLE */
> > +    uint8_t  rtc_century;      /* CENTURY */
> > +    uint16_t c2_latency;       /* P_LVL2_LAT */  
> same?
> > +    uint16_t c3_latency;       /* P_LVL3_LAT */
> > +
> > +    /*
> > +     * respective tables offsets within ACPI_BUILD_TABLE_FILE,
> > +     * NULL if table doesn't exist (in that case field's value
> > +     * won't be patched by linker and will be kept set to 0)
> > +     */
> > +    unsigned *facs_tbl_offset; /* FACS offset in */
> > +    unsigned *dsdt_tbl_offset;
> > +    unsigned *xdsdt_tbl_offset;
> > +} AcpiFadtData;
> > +
> >  #define ACPI_FADT_ARM_PSCI_COMPLIANT  (1 << 0)
> >  #define ACPI_FADT_ARM_PSCI_USE_HVC    (1 << 1)
> >  
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index b85fefe..706ba35 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -91,17 +91,11 @@ typedef struct AcpiMcfgInfo {
> >  } AcpiMcfgInfo;
> >  
> >  typedef struct AcpiPmInfo {
> > -    bool force_rev1_fadt;
> >      bool s3_disabled;
> >      bool s4_disabled;
> >      bool pcihp_bridge_en;
> >      uint8_t s4_val;
> > -    uint16_t sci_int;
> > -    uint8_t acpi_enable_cmd;
> > -    uint8_t acpi_disable_cmd;
> > -    uint32_t gpe0_blk;
> > -    uint32_t gpe0_blk_len;
> > -    uint32_t io_base;
> > +    AcpiFadtData fadt;
> >      uint16_t cpu_hp_io_base;
> >      uint16_t pcihp_io_base;
> >      uint16_t pcihp_io_len;
> > @@ -124,20 +118,60 @@ typedef struct AcpiBuildPciBusHotplugState {
> >      bool pcihp_bridge_en;
> >  } AcpiBuildPciBusHotplugState;
> >  
> > +#define ACPI_PORT_SMI_CMD           0x00b2 /* TODO: this is APM_CNT_IOPORT */  
> Can't we take benefit of this series to move that define in hw/isa/apm.h?
> > +
> > +static void init_fadt_data(Object *o, AcpiFadtData *data)
> > +{
> > +    uint32_t io = object_property_get_uint(o, ACPI_PM_PROP_PM_IO_BASE, NULL);
> > +    AmlAddressSpace as = AML_AS_SYSTEM_IO;
> > +    AcpiFadtData fadt = {
> > +        .rev = 3,
> > +        .flags =
> > +            (1 << ACPI_FADT_F_WBINVD) |
> > +            (1 << ACPI_FADT_F_PROC_C1) |
> > +            (1 << ACPI_FADT_F_SLP_BUTTON) |
> > +            (1 << ACPI_FADT_F_RTC_S4) |
> > +            (1 << ACPI_FADT_F_USE_PLATFORM_CLOCK) |
> > +            /* APIC destination mode ("Flat Logical") has an upper limit of 8
> > +             * CPUs for more than 8 CPUs, "Clustered Logical" mode has to be
> > +             * used
> > +             */
> > +            ((max_cpus > 8) ? (1 << ACPI_FADT_F_FORCE_APIC_CLUSTER_MODEL) : 0),
> > +        .int_model = 1 /* Multiple APIC */,
> > +        .rtc_century = RTC_CENTURY,
> > +        .c2_latency = 0xfff /* C2 state not supported */,
> > +        .c3_latency = 0xfff /* C3 state not supported */,
> > +        .smi_cmd = ACPI_PORT_SMI_CMD,
> > +        .sci_int = object_property_get_uint(o, ACPI_PM_PROP_SCI_INT, NULL),
> > +        .acpi_enable_cmd =
> > +            object_property_get_uint(o, ACPI_PM_PROP_ACPI_ENABLE_CMD, NULL),
> > +        .acpi_disable_cmd =
> > +            object_property_get_uint(o, ACPI_PM_PROP_ACPI_DISABLE_CMD, NULL),
> > +        .pm1_evt = { .space_id = as, .bit_width = 4 * 8, .address = io },
> > +        .pm1_cnt = { .space_id = as, .bit_width = 2 * 8, .address = io + 0x04 },
> > +        .pm_tmr = { .space_id = as, .bit_width = 4 * 8, .address = io + 0x08 },
> > +        .gpe0_blk = { .space_id = as, .bit_width =
> > +            object_property_get_uint(o, ACPI_PM_PROP_GPE0_BLK_LEN, NULL) * 8,
> > +            .address = object_property_get_uint(o, ACPI_PM_PROP_GPE0_BLK, NULL)
> > +        },
> > +    };
> > +    *data = fadt;
> > +}
> > +
> >  static void acpi_get_pm_info(AcpiPmInfo *pm)
> >  {
> >      Object *piix = piix4_pm_find();
> >      Object *lpc = ich9_lpc_find();
> >      Object *obj = piix ? piix : lpc;
> >      QObject *o;
> > -
> > -    pm->force_rev1_fadt = false;
> >      pm->cpu_hp_io_base = 0;
> >      pm->pcihp_io_base = 0;
> >      pm->pcihp_io_len = 0;
> > +
> > +    init_fadt_data(obj, &pm->fadt);
> >      if (piix) {
> >          /* w2k requires FADT(rev1) or it won't boot, keep PC compatible */
> > -        pm->force_rev1_fadt = true;
> > +        pm->fadt.rev = 1;
> >          pm->cpu_hp_io_base = PIIX4_CPU_HOTPLUG_IO_BASE;
> >          pm->pcihp_io_base =
> >              object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
> > @@ -145,10 +179,19 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
> >              object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
> >      }
> >      if (lpc) {
> > +        struct AcpiGenericAddress r = { .space_id = AML_AS_SYSTEM_IO,
> > +            .bit_width = 8, .address = ICH9_RST_CNT_IOPORT };
> > +        pm->fadt.reset_reg = r;
> > +        pm->fadt.reset_val = 0xf;
> > +        pm->fadt.flags |= 1 << ACPI_FADT_F_RESET_REG_SUP;
> >          pm->cpu_hp_io_base = ICH9_CPU_HOTPLUG_IO_BASE;  
> Wouldn't it be possible to pass an other parameter to init_fadt_data()
> to tell whether we are in pc or q35 or the target rev and do those
> initializations there?
It's possible but I wanted to keep pc/q35 specific pieces explicitly
split from common data initialization as personally for me this way
it's easier to see difference (i.e. there is no need to jump into init_fadt_data()).

Perhaps I should rename init_fadt_data() to init_common_fadt_data().


> >      }
> >      assert(obj);
> >  
> > +    /* The above need not be conditional on machine type because the reset port
> > +     * happens to be the same on PIIX (pc) and ICH9 (q35). */
> > +    QEMU_BUILD_BUG_ON(ICH9_RST_CNT_IOPORT != RCR_IOPORT);
> > +
> >      /* Fill in optional s3/s4 related properties */
> >      o = object_property_get_qobject(obj, ACPI_PM_PROP_S3_DISABLED, NULL);
> >      if (o) {
> > @@ -172,22 +215,6 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
> >      }
> >      qobject_decref(o);
> >  
> > -    /* Fill in mandatory properties */
> > -    pm->sci_int = object_property_get_uint(obj, ACPI_PM_PROP_SCI_INT, NULL);
> > -
> > -    pm->acpi_enable_cmd = object_property_get_uint(obj,
> > -                                                   ACPI_PM_PROP_ACPI_ENABLE_CMD,
> > -                                                   NULL);
> > -    pm->acpi_disable_cmd =
> > -        object_property_get_uint(obj,
> > -                                 ACPI_PM_PROP_ACPI_DISABLE_CMD,
> > -                                 NULL);
> > -    pm->io_base = object_property_get_uint(obj, ACPI_PM_PROP_PM_IO_BASE,
> > -                                           NULL);
> > -    pm->gpe0_blk = object_property_get_uint(obj, ACPI_PM_PROP_GPE0_BLK,
> > -                                            NULL);
> > -    pm->gpe0_blk_len = object_property_get_uint(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
> > -                                                NULL);
> >      pm->pcihp_bridge_en =
> >          object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
> >                                   NULL);
> > @@ -255,8 +282,6 @@ static void acpi_get_pci_holes(Range *hole, Range *hole64)
> >                                                 NULL));
> >  }
> >  
> > -#define ACPI_PORT_SMI_CMD           0x00b2 /* TODO: this is APM_CNT_IOPORT */
> > -
> >  static void acpi_align_size(GArray *blob, unsigned align)
> >  {
> >      /* Align size to multiple of given size. This reduces the chance
> > @@ -275,73 +300,53 @@ build_facs(GArray *table_data, BIOSLinker *linker)
> >  }
> >  
> >  /* Load chipset information in FADT */
> > -static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm)
> > +static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiFadtData f)
> >  {
> > -    fadt->model = 1;
> > +    fadt->model = f.int_model;
> >      fadt->reserved1 = 0;
> > -    fadt->sci_int = cpu_to_le16(pm->sci_int);
> > -    fadt->smi_cmd = cpu_to_le32(ACPI_PORT_SMI_CMD);
> > -    fadt->acpi_enable = pm->acpi_enable_cmd;
> > -    fadt->acpi_disable = pm->acpi_disable_cmd;
> > +    fadt->sci_int = cpu_to_le16(f.sci_int);
> > +    fadt->smi_cmd = cpu_to_le32(f.smi_cmd);
> > +    fadt->acpi_enable = f.acpi_enable_cmd;
> > +    fadt->acpi_disable = f.acpi_disable_cmd;
> >      /* EVT, CNT, TMR offset matches hw/acpi/core.c */
> > -    fadt->pm1a_evt_blk = cpu_to_le32(pm->io_base);
> > -    fadt->pm1a_cnt_blk = cpu_to_le32(pm->io_base + 0x04);
> > -    fadt->pm_tmr_blk = cpu_to_le32(pm->io_base + 0x08);
> > -    fadt->gpe0_blk = cpu_to_le32(pm->gpe0_blk);
> > +    fadt->pm1a_evt_blk = cpu_to_le32(f.pm1_evt.address);
> > +    fadt->pm1a_cnt_blk = cpu_to_le32(f.pm1_cnt.address);
> > +    fadt->pm_tmr_blk = cpu_to_le32(f.pm_tmr.address);
> > +    fadt->gpe0_blk = cpu_to_le32(f.gpe0_blk.address);
> >      /* EVT, CNT, TMR length matches hw/acpi/core.c */
> > -    fadt->pm1_evt_len = 4;
> > -    fadt->pm1_cnt_len = 2;
> > -    fadt->pm_tmr_len = 4;
> > -    fadt->gpe0_blk_len = pm->gpe0_blk_len;
> > -    fadt->plvl2_lat = cpu_to_le16(0xfff); /* C2 state not supported */
> > -    fadt->plvl3_lat = cpu_to_le16(0xfff); /* C3 state not supported */
> > -    fadt->flags = cpu_to_le32((1 << ACPI_FADT_F_WBINVD) |
> > -                              (1 << ACPI_FADT_F_PROC_C1) |
> > -                              (1 << ACPI_FADT_F_SLP_BUTTON) |
> > -                              (1 << ACPI_FADT_F_RTC_S4));
> > -    fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_USE_PLATFORM_CLOCK);
> > -    /* APIC destination mode ("Flat Logical") has an upper limit of 8 CPUs
> > -     * For more than 8 CPUs, "Clustered Logical" mode has to be used
> > -     */
> > -    if (max_cpus > 8) {
> > -        fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_FORCE_APIC_CLUSTER_MODEL);
> > -    }
> > -    fadt->century = RTC_CENTURY;
> > -    if (pm->force_rev1_fadt) {
> > +    fadt->pm1_evt_len = f.pm1_evt.bit_width / 8;
> > +    fadt->pm1_cnt_len = f.pm1_cnt.bit_width / 8;
> > +    fadt->pm_tmr_len = f.pm_tmr.bit_width / 8;
> > +    fadt->gpe0_blk_len = f.gpe0_blk.bit_width / 8;
> > +    fadt->plvl2_lat = cpu_to_le16(f.c2_latency);
> > +    fadt->plvl3_lat = cpu_to_le16(f.c3_latency);
> > +    fadt->flags = cpu_to_le32(f.flags);
> > +    fadt->century = f.rtc_century;
> > +    if (f.rev == 1) {
> >          return;
> >      }
> >  
> > -    fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_RESET_REG_SUP);
> > -    fadt->reset_value = 0xf;
> > -    fadt->reset_register.space_id = AML_SYSTEM_IO;
> > -    fadt->reset_register.bit_width = 8;
> > -    fadt->reset_register.address = cpu_to_le64(ICH9_RST_CNT_IOPORT);
> > -    /* The above need not be conditional on machine type because the reset port
> > -     * happens to be the same on PIIX (pc) and ICH9 (q35). */
> > -    QEMU_BUILD_BUG_ON(ICH9_RST_CNT_IOPORT != RCR_IOPORT);
> > +    fadt->reset_value = f.reset_val;
> > +    fadt->reset_register = f.reset_reg;
> > +    fadt->reset_register.address = cpu_to_le64(f.reset_reg.address);
> >  
> > -    fadt->xpm1a_event_block.space_id = AML_SYSTEM_IO;
> > -    fadt->xpm1a_event_block.bit_width = fadt->pm1_evt_len * 8;
> > -    fadt->xpm1a_event_block.address = cpu_to_le64(pm->io_base);
> > +    fadt->xpm1a_event_block = f.pm1_evt;
> > +    fadt->xpm1a_event_block.address = cpu_to_le64(f.pm1_evt.address);
> >  
> > -    fadt->xpm1a_control_block.space_id = AML_SYSTEM_IO;
> > -    fadt->xpm1a_control_block.bit_width = fadt->pm1_cnt_len * 8;
> > -    fadt->xpm1a_control_block.address = cpu_to_le64(pm->io_base + 0x4);
> > +    fadt->xpm1a_control_block = f.pm1_cnt;
> > +    fadt->xpm1a_control_block.address = cpu_to_le64(f.pm1_cnt.address);
> >  
> > -    fadt->xpm_timer_block.space_id = AML_SYSTEM_IO;
> > -    fadt->xpm_timer_block.bit_width = fadt->pm_tmr_len * 8;
> > -    fadt->xpm_timer_block.address = cpu_to_le64(pm->io_base + 0x8);
> > +    fadt->xpm_timer_block = f.pm_tmr;
> > +    fadt->xpm_timer_block.address = cpu_to_le64(f.pm_tmr.address);
> >  
> > -    fadt->xgpe0_block.space_id = AML_SYSTEM_IO;
> > -    fadt->xgpe0_block.bit_width = pm->gpe0_blk_len * 8;
> > -    fadt->xgpe0_block.address = cpu_to_le64(pm->gpe0_blk);
> > +    fadt->xgpe0_block = f.gpe0_blk;
> > +    fadt->xgpe0_block.address = cpu_to_le64(f.gpe0_blk.address);
> >  }
> >  
> >  
> >  /* FADT */
> >  static void
> > -build_fadt(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
> > -           unsigned facs_tbl_offset, unsigned dsdt_tbl_offset,
> > +build_fadt(GArray *table_data, BIOSLinker *linker, AcpiFadtData *f,
> >             const char *oem_id, const char *oem_table_id)
> >  {
> >      AcpiFadtDescriptorRev3 *fadt = acpi_data_push(table_data, sizeof(*fadt));
> > @@ -349,29 +354,32 @@ build_fadt(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
> >      unsigned dsdt_entry_offset = (char *)&fadt->dsdt - table_data->data;
> >      unsigned xdsdt_entry_offset = (char *)&fadt->x_dsdt - table_data->data;
> >      int fadt_size = sizeof(*fadt);
> > -    int rev = 3;
> >  
> >      /* FACS address to be filled by Guest linker */
> > -    bios_linker_loader_add_pointer(linker,
> > -        ACPI_BUILD_TABLE_FILE, fw_ctrl_offset, sizeof(fadt->firmware_ctrl),
> > -        ACPI_BUILD_TABLE_FILE, facs_tbl_offset);
> > +    if (f->facs_tbl_offset) {  
> this test was not there originally. How does it relate to above changes?

[...]
> > +    if (f->dsdt_tbl_offset) {  
> same
I guess it is sort of slipped in from (7/9) patch,
as this fields can be 0 and don't need dynamic patching.

Theoretically facs/dsdt could be 0 for x86 too if we drop support
for 32bit guests (which isn't going to happen).

I can move it to 7/9 which moves build_fadt into generic code from x86 specific,
which is more appropriate place for it.


> > +        bios_linker_loader_add_pointer(linker,
> > +            ACPI_BUILD_TABLE_FILE, dsdt_entry_offset, sizeof(fadt->dsdt),
> > +            ACPI_BUILD_TABLE_FILE, *f->dsdt_tbl_offset);
> > +    }
> > +    if (f->rev == 1) {
> >          fadt_size = offsetof(typeof(*fadt), reset_register);
> > -    } else {
> > +    } else if (f->xdsdt_tbl_offset) {
> >          bios_linker_loader_add_pointer(linker,
> >              ACPI_BUILD_TABLE_FILE, xdsdt_entry_offset, sizeof(fadt->x_dsdt),
> > -            ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
> > +            ACPI_BUILD_TABLE_FILE, *f->xdsdt_tbl_offset);
> >      }
> >  
> >      build_header(linker, table_data,
> > -                 (void *)fadt, "FACP", fadt_size, rev, oem_id, oem_table_id);
> > +                (void *)fadt, "FACP", fadt_size, f->rev,
> > +                oem_id, oem_table_id);
> >  }
> >  
> >  void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
> > @@ -2051,7 +2059,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >      aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
> >      crs = aml_resource_template();
> >      aml_append(crs,
> > -        aml_io(AML_DECODE16, pm->gpe0_blk, pm->gpe0_blk, 1, pm->gpe0_blk_len)
> > +        aml_io(
> > +               AML_DECODE16,
> > +               pm->fadt.gpe0_blk.address,
> > +               pm->fadt.gpe0_blk.address,
> > +               1,
> > +               pm->fadt.gpe0_blk.bit_width / 8)
> >      );
> >      aml_append(dev, aml_name_decl("_CRS", crs));
> >      aml_append(scope, dev);
> > @@ -2698,7 +2711,10 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
> >      /* ACPI tables pointed to by RSDT */
> >      fadt = tables_blob->len;
> >      acpi_add_table(table_offsets, tables_blob);
> > -    build_fadt(tables_blob, tables->linker, &pm, facs, dsdt,
> > +    pm.fadt.facs_tbl_offset = &facs;
> > +    pm.fadt.dsdt_tbl_offset = &dsdt;
> > +    pm.fadt.xdsdt_tbl_offset = &dsdt;
> > +    build_fadt(tables_blob, tables->linker, &pm.fadt,
> >                 slic_oem.id, slic_oem.table_id);
> >      aml_len += tables_blob->len - fadt;
> >  
> >   
> Otherwise looks good to me.
> 
> Thanks
> 
> Eric

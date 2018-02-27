Received: from eggs.gnu.org ([2001:4830:134:3::10]:47106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eqhVf-0005LY-HF
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eqhVe-0001gl-6u
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:49:43 -0500
Date: Tue, 27 Feb 2018 16:49:20 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180227164920.047b4885@redhat.com>
In-Reply-To: <9277c150-6830-8fb1-0092-4bdfd6ba0486@redhat.com>
References: <1519303376-92875-1-git-send-email-imammedo@redhat.com>
	<1519303376-92875-9-git-send-email-imammedo@redhat.com>
	<9277c150-6830-8fb1-0092-4bdfd6ba0486@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 8/9] virt_arm: acpi: reuse common
 build_fadt()
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

On Tue, 27 Feb 2018 16:07:49 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Igor,
> On 22/02/18 13:42, Igor Mammedov wrote:
> > Extend generic build_fadt() to support rev5.1 FADT
> > and reuse it for 'virt' board, it would allow to
> > phase out usage of AcpiFadtDescriptorRev5_1 and
> > later ACPI_FADT_COMMON_DEF.  
> Oups sorry sent the R-b to fast. Some small comments below.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/hw/acpi/acpi-defs.h | 12 ++----------
> >  hw/acpi/aml-build.c         | 21 ++++++++++++++++++++-
> >  hw/arm/virt-acpi-build.c    | 33 ++++++++++++---------------------
> >  3 files changed, 34 insertions(+), 32 deletions(-)
> > 
> > diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> > index e0accc4..34e49dc 100644
> > --- a/include/hw/acpi/acpi-defs.h
> > +++ b/include/hw/acpi/acpi-defs.h
> > @@ -165,16 +165,6 @@ struct AcpiFadtDescriptorRev3 {
> >  } QEMU_PACKED;
> >  typedef struct AcpiFadtDescriptorRev3 AcpiFadtDescriptorRev3;
> >  
> > -struct AcpiFadtDescriptorRev5_1 {
> > -    ACPI_FADT_COMMON_DEF
> > -    /* 64-bit Sleep Control register (ACPI 5.0) */
> > -    struct AcpiGenericAddress sleep_control;
> > -    /* 64-bit Sleep Status register (ACPI 5.0) */
> > -    struct AcpiGenericAddress sleep_status;
> > -} QEMU_PACKED;
> > -
> > -typedef struct AcpiFadtDescriptorRev5_1 AcpiFadtDescriptorRev5_1;
> > -
> >  typedef struct AcpiFadtData {
> >      struct AcpiGenericAddress pm1_cnt;   /* PM1a_CNT_BLK */
> >      struct AcpiGenericAddress pm1_evt;   /* PM1a_EVT_BLK */
> > @@ -192,6 +182,8 @@ typedef struct AcpiFadtData {
> >      uint8_t  rtc_century;      /* CENTURY */
> >      uint16_t c2_latency;       /* P_LVL2_LAT */
> >      uint16_t c3_latency;       /* P_LVL3_LAT */
> > +    uint16_t arm_boot_arch;    /* ARM_BOOT_ARCH */
> > +    uint8_t minor_ver;         /* FADT Minor Version */
> >  
> >      /*
> >       * respective tables offsets within ACPI_BUILD_TABLE_FILE,
> > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > index 17fb71b..5a33cd0 100644
> > --- a/hw/acpi/aml-build.c
> > +++ b/hw/acpi/aml-build.c  
> 
> nit: comment above needs to be extended to rev5.1 support
Thanks, I'll fix it up on respin.

> > @@ -1755,7 +1755,14 @@ void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
> >  
> >      build_append_gas_from_struct(tbl, &f->reset_reg); /* RESET_REG */
> >      build_append_int_noprefix(tbl, f->reset_val, 1); /* RESET_VALUE */
> > -    build_append_int_noprefix(tbl, 0, 3); /* Reserved, ACPI 3.0 */
> > +    /* Since ACPI 5.1 */
> > +    if ((f->rev >= 6) || ((f->rev == 5) && f->minor_ver > 0)) {
> > +        build_append_int_noprefix(tbl, f->arm_boot_arch, 2); /* ARM_BOOT_ARCH */
> > +        /* FADT Minor Version */
> > +        build_append_int_noprefix(tbl, f->minor_ver, 1);
> > +    } else {
> > +        build_append_int_noprefix(tbl, 0, 3); /* Reserved upto ACPI 5.0 */
> > +    }
> >      build_append_int_noprefix(tbl, 0, 8); /* X_FIRMWARE_CTRL */
> >  
> >      /* XDSDT address to be filled by Guest linker at runtime */
> > @@ -1779,6 +1786,18 @@ void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
> >      build_append_gas_from_struct(tbl, &f->gpe0_blk); /* X_GPE0_BLK */
> >      build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0); /* X_GPE1_BLK */
> >  
> > +    if (f->rev <= 4) {
> > +        goto build_hdr;
> > +    }
> > +
> > +    /* SLEEP_CONTROL_REG */
> > +    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);
> > +    /* SLEEP_STATUS_REG */
> > +    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);  
> 
> what about Hypervisor Vendor Identity field (8 byte) in version 6.0?
not supported yet, hence assert below.
When it's added we should update assert to the next supported revision.

> > +
> > +    /* TODO: extra fields need to be added to support revisions above rev5 */
> > +    assert(f->rev == 5);  
> OK so can't we assert before the (f->rev >= 6) check above?
> 
> Thanks
> 
> Eric
> > +
> >  build_hdr:
> >      build_header(linker, tbl, (void *)(tbl->data + fadt_start),
> >                   "FACP", tbl->len - fadt_start, f->rev, oem_id, oem_table_id);
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index b644da9..c7c6a57 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -654,39 +654,30 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >  static void build_fadt_rev5(GArray *table_data, BIOSLinker *linker,
> >                              VirtMachineState *vms, unsigned dsdt_tbl_offset)
> >  {
> > -    int fadt_start = table_data->len;
> > -    AcpiFadtDescriptorRev5_1 *fadt = acpi_data_push(table_data, sizeof(*fadt));
> > -    unsigned xdsdt_entry_offset = (char *)&fadt->x_dsdt - table_data->data;
> > -    uint16_t bootflags;
> > +    /* ACPI v5.1 */
> > +    AcpiFadtData fadt = {
> > +        .rev = 5,
> > +        .minor_ver = 1,
> > +        .flags = 1 << ACPI_FADT_F_HW_REDUCED_ACPI,
> > +        .xdsdt_tbl_offset = &dsdt_tbl_offset,
> > +    };
> >  
> >      switch (vms->psci_conduit) {
> >      case QEMU_PSCI_CONDUIT_DISABLED:
> > -        bootflags = 0;
> > +        fadt.arm_boot_arch = 0;
> >          break;
> >      case QEMU_PSCI_CONDUIT_HVC:
> > -        bootflags = ACPI_FADT_ARM_PSCI_COMPLIANT | ACPI_FADT_ARM_PSCI_USE_HVC;
> > +        fadt.arm_boot_arch = ACPI_FADT_ARM_PSCI_COMPLIANT |
> > +                             ACPI_FADT_ARM_PSCI_USE_HVC;
> >          break;
> >      case QEMU_PSCI_CONDUIT_SMC:
> > -        bootflags = ACPI_FADT_ARM_PSCI_COMPLIANT;
> > +        fadt.arm_boot_arch = ACPI_FADT_ARM_PSCI_COMPLIANT;
> >          break;
> >      default:
> >          g_assert_not_reached();
> >      }
> >  
> > -    /* Hardware Reduced = 1 and use PSCI 0.2+ */
> > -    fadt->flags = cpu_to_le32(1 << ACPI_FADT_F_HW_REDUCED_ACPI);
> > -    fadt->arm_boot_flags = cpu_to_le16(bootflags);
> > -
> > -    /* ACPI v5.1 (fadt->revision.fadt->minor_revision) */
> > -    fadt->minor_revision = 0x1;
> > -
> > -    /* DSDT address to be filled by Guest linker */
> > -    bios_linker_loader_add_pointer(linker,
> > -        ACPI_BUILD_TABLE_FILE, xdsdt_entry_offset, sizeof(fadt->x_dsdt),
> > -        ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
> > -
> > -    build_header(linker, table_data, (void *)(table_data->data + fadt_start),
> > -                 "FACP", table_data->len - fadt_start, 5, NULL, NULL);
> > +    build_fadt(table_data, linker, &fadt, NULL, NULL);
> >  }
> >  
> >  /* DSDT */
> >   

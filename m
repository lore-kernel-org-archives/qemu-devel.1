Received: from eggs.gnu.org ([2001:4830:134:3::10]:41212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gRgDg-0006ST-9T
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:28:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gRgDf-0003y0-7P
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:28:16 -0500
Date: Tue, 27 Nov 2018 17:27:49 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181127172749.75a036b4@redhat.com>
In-Reply-To: <20181127154218.GA5677@caravaggio>
References: <20181126162942.21258-1-sameo@linux.intel.com>
	<20181126162942.21258-5-sameo@linux.intel.com>
	<20181127162551.29608eeb@redhat.com>
	<20181127154218.GA5677@caravaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/8] hw: arm: Carry RSDP specific data
 through AcpiRsdpData
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Ben Warren <ben@skyportsystems.com>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, 27 Nov 2018 16:42:18 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> Hi Igor,
> 
> On Tue, Nov 27, 2018 at 04:25:51PM +0100, Igor Mammedov wrote:
> > On Mon, 26 Nov 2018 17:29:37 +0100
> > Samuel Ortiz <sameo@linux.intel.com> wrote:
> >   
> > > That will allow us to generalize the ARM build_rsdp() routine to support
> > > both legacy RSDP (The current i386 implementation) and extended RSDP
> > > (The ARM implementation).
> > > 
> > > Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> > > ---
> > >  include/hw/acpi/acpi-defs.h | 11 +++++++++++
> > >  hw/arm/virt-acpi-build.c    | 27 ++++++++++++++++++++++-----
> > >  2 files changed, 33 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> > > index af8e023968..e7fd24c6c5 100644
> > > --- a/include/hw/acpi/acpi-defs.h
> > > +++ b/include/hw/acpi/acpi-defs.h
> > > @@ -53,6 +53,17 @@ struct AcpiRsdpDescriptor {        /* Root System Descriptor Pointer */
> > >  } QEMU_PACKED;
> > >  typedef struct AcpiRsdpDescriptor AcpiRsdpDescriptor;
> > >  
> > > +typedef struct AcpiRsdpData {
> > > +    uint8_t oem_id[6]; /* OEM identification */
> > > +    uint8_t revision;  /* Must be 0 for 1.0, 2 for 2.0 */
> > > +
> > > +    unsigned *rsdt_tbl_offset;
> > > +    unsigned *xsdt_tbl_offset;
> > > +} AcpiRsdpData;
> > > +  
> >   
> > > +#define ACPI_RSDP_REV_1 0
> > > +#define ACPI_RSDP_REV_2 2  
> > it's one time used spec defined values so just use values directly
> > in place with a comment, so reader won't have to jump around code
> > when comparing to spec.  
> It's also used in the ACPI tests fix patch.
it's better to use in test it's own version (we just opencode them there)
see fadt_fetch_facs_and_dsdt_ptrs()/sanitize_fadt_ptrs()
same applies for length.
that way if we break it in qemu's code test would catch the thing

> Also the 0 for revision 1 is a little confusing, I feel the above
> definition is clearer.
that's confusion is in the spec, so we just mimic it, no need to add more on top

> 
> 
> > > +
> > >  /* Table structure from Linux kernel (the ACPI tables are under the
> > >     BSD license) */
> > >  
> > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > index 0835900052..2dad465ecf 100644
> > > --- a/hw/arm/virt-acpi-build.c
> > > +++ b/hw/arm/virt-acpi-build.c
> > > @@ -368,7 +368,7 @@ static void acpi_dsdt_add_power_button(Aml *scope)
> > >  
> > >  /* RSDP */
> > >  static void
> > > -build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
> > > +build_rsdp(GArray *rsdp_table, BIOSLinker *linker, AcpiRsdpData *rsdp_data)
> > >  {
> > >      AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
> > >      unsigned xsdt_pa_size = sizeof(rsdp->xsdt_physical_address);
> > > @@ -379,14 +379,14 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
> > >                               true /* fseg memory */);
> > >  
> > >      memcpy(&rsdp->signature, "RSD PTR ", sizeof(rsdp->signature));
> > > -    memcpy(rsdp->oem_id, ACPI_BUILD_APPNAME6, sizeof(rsdp->oem_id));
> > > +    memcpy(rsdp->oem_id, rsdp_data->oem_id, sizeof(rsdp->oem_id));
> > >      rsdp->length = cpu_to_le32(sizeof(*rsdp));
> > > -    rsdp->revision = 0x02;
> > > +    rsdp->revision = rsdp_data->revision;
> > >  
> > >      /* Address to be filled by Guest linker */
> > >      bios_linker_loader_add_pointer(linker,
> > >          ACPI_BUILD_RSDP_FILE, xsdt_pa_offset, xsdt_pa_size,
> > > -        ACPI_BUILD_TABLE_FILE, xsdt_tbl_offset);
> > > +        ACPI_BUILD_TABLE_FILE, *rsdp_data->xsdt_tbl_offset);
> > >  
> > >      /* Checksum to be filled by Guest linker */
> > >      bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> > > @@ -399,6 +399,20 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
> > >          (char *)&rsdp->extended_checksum - rsdp_table->data);
> > >  }
> > >  
> > > +static void
> > > +init_rsdp_data(AcpiRsdpData *data, const char *oem_id, uint8_t revision,
> > > +               unsigned *rsdt_offset, unsigned *xsdt_offset)
> > > +{
> > > +    /* Caller must provide an OEM ID */
> > > +    g_assert(oem_id);
> > > +    g_assert(strlen(oem_id) >= 6);
> > > +
> > > +    memcpy(data->oem_id, oem_id, 6);
> > > +    data->revision = revision;
> > > +    data->rsdt_tbl_offset = rsdt_offset;
> > > +    data->xsdt_tbl_offset = xsdt_offset;
> > > +}
> > > +
> > >  static void
> > >  build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> > >  {
> > > @@ -810,6 +824,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
> > >      GArray *table_offsets;
> > >      unsigned dsdt, xsdt;
> > >      GArray *tables_blob = tables->table_data;
> > > +    AcpiRsdpData rsdp;  
> > s/rsdp/rsdp_info/
> >   
> > >  
> > >      table_offsets = g_array_new(false, true /* clear */,
> > >                                          sizeof(uint32_t));
> > > @@ -857,7 +872,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
> > >      build_xsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);
> > >  
> > >      /* RSDP is in FSEG memory, so allocate it separately */
> > > -    build_rsdp(tables->rsdp, tables->linker, xsdt);
> > > +    init_rsdp_data(&rsdp, ACPI_BUILD_APPNAME6, ACPI_RSDP_REV_2,
> > > +                   NULL, &xsdt);  
> > It would be more concise to use declarative style without extra clutter:
> > 
> > -    init_rsdp_data(&rsdp, ACPI_BUILD_APPNAME6, ACPI_RSDP_REV_2,
> > -                   NULL, &xsdt);
> > -    build_rsdp(tables->rsdp, tables->linker, &rsdp);
> > +    {
> > +       AcpiRsdpData rsdp = {
> > +           .revision = 2,
> > +           .oem_id = ACPI_BUILD_APPNAME6,
> > +           .xsdt_tbl_offset = &xsdt,
> > +           .rsdt_tbl_offset = NULL,
> > +       };
> > +       build_rsdp(tables->rsdp, tables->linker, &rsdp);
> > +    }  
> 2 things here, imo:
> 
> - This is not more concise.
with function, one have to jump to it's definition/body to find out what
each argument is, with declaration + initialization inplace it's clear
what values mean as you see fields right there as well.

If it's simple structure it is clearer to use initializer, instead of
wrapper helper. With complex structure it could be other way around.

> - It's code duplication as almost the same snippet is going to be used
>   for i386/acpi-build.c
the same goes for init_rsdp_data(...), the only difference
the declaration isn't folded in 2 lines to be more readable and there is
boiler plate helper function adds.

> 
> Cheers,
> Samuel.

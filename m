Received: from eggs.gnu.org ([2001:4830:134:3::10]:57929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gSjsq-00088Q-MJ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:35:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gSjsk-0005x6-Nw
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:35:08 -0500
Date: Fri, 30 Nov 2018 15:34:40 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181130143440.m63yjvjqnt32kiy2@kamzik.brq.redhat.com>
References: <20181129132428.333-1-sameo@linux.intel.com>
	<20181129132428.333-5-sameo@linux.intel.com>
	<20181129140932.2yl75vsq2ohmuzx6@kamzik.brq.redhat.com>
	<20181129142627.GA4691@caravaggio>
	<20181130082621.6afb2d0a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130082621.6afb2d0a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/8] hw: arm: Carry RSDP specific data
 through AcpiRsdpData
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Nov 30, 2018 at 08:26:21AM +0100, Igor Mammedov wrote:
> On Thu, 29 Nov 2018 15:26:27 +0100
> Samuel Ortiz <sameo@linux.intel.com> wrote:
> 
> > On Thu, Nov 29, 2018 at 03:09:32PM +0100, Andrew Jones wrote:
> > > On Thu, Nov 29, 2018 at 02:24:24PM +0100, Samuel Ortiz wrote:  
> > > > That will allow us to generalize the ARM build_rsdp() routine to support
> > > > both legacy RSDP (The current i386 implementation) and extended RSDP
> > > > (The ARM implementation).
> > > > 
> > > > Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> > > > ---
> > > >  include/hw/acpi/acpi-defs.h |  8 ++++++++
> > > >  hw/arm/virt-acpi-build.c    | 18 +++++++++++++-----
> > > >  2 files changed, 21 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> > > > index af8e023968..8425ecb8c6 100644
> > > > --- a/include/hw/acpi/acpi-defs.h
> > > > +++ b/include/hw/acpi/acpi-defs.h
> > > > @@ -53,6 +53,14 @@ struct AcpiRsdpDescriptor {        /* Root System Descriptor Pointer */
> > > >  } QEMU_PACKED;
> > > >  typedef struct AcpiRsdpDescriptor AcpiRsdpDescriptor;
> > > >  
> > > > +typedef struct AcpiRsdpData {
> > > > +    uint8_t oem_id[6]; /* OEM identification */
> > > > +    uint8_t revision;  /* Must be 0 for 1.0, 2 for 2.0 */
> > > > +
> > > > +    unsigned *rsdt_tbl_offset;
> > > > +    unsigned *xsdt_tbl_offset;  
> > > 
> > > Why use pointers?  
> > Mostly to be consistent with the FADT data structure (AcpiFadtData).
> My guess would be that's for detecting an optional field and
> skipping setting it in build_rsdp(). But it's mostly for
> consistence with current code.
> 
> > 
> > > > +} AcpiRsdpData;
> > > > +
> > > >  /* Table structure from Linux kernel (the ACPI tables are under the
> > > >     BSD license) */
> > > >  
> > > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > > index 0835900052..ce8bfa5a37 100644
> > > > --- a/hw/arm/virt-acpi-build.c
> > > > +++ b/hw/arm/virt-acpi-build.c
> > > > @@ -368,7 +368,7 @@ static void acpi_dsdt_add_power_button(Aml *scope)
> > > >  
> > > >  /* RSDP */
> > > >  static void
> > > > -build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
> > > > +build_rsdp(GArray *rsdp_table, BIOSLinker *linker, AcpiRsdpData *rsdp_data)
> > > >  {
> > > >      AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
> > > >      unsigned xsdt_pa_size = sizeof(rsdp->xsdt_physical_address);
> > > > @@ -379,14 +379,14 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
> > > >                               true /* fseg memory */);
> > > >  
> > > >      memcpy(&rsdp->signature, "RSD PTR ", sizeof(rsdp->signature));
> > > > -    memcpy(rsdp->oem_id, ACPI_BUILD_APPNAME6, sizeof(rsdp->oem_id));
> > > > +    memcpy(rsdp->oem_id, rsdp_data->oem_id, sizeof(rsdp->oem_id));  
> > > 
> > > sizeof(rsdp_data->oem_id)  
> > Which is the same thing. Note that this piece of code eventually gets
> > removed later in the serie.
> > 
> > 
> > 
> > > >      rsdp->length = cpu_to_le32(sizeof(*rsdp));
> > > > -    rsdp->revision = 0x02;
> > > > +    rsdp->revision = rsdp_data->revision;
> > > >  
> > > >      /* Address to be filled by Guest linker */
> > > >      bios_linker_loader_add_pointer(linker,
> > > >          ACPI_BUILD_RSDP_FILE, xsdt_pa_offset, xsdt_pa_size,
> > > > -        ACPI_BUILD_TABLE_FILE, xsdt_tbl_offset);
> > > > +        ACPI_BUILD_TABLE_FILE, *rsdp_data->xsdt_tbl_offset);
> > > >  
> > > >      /* Checksum to be filled by Guest linker */
> > > >      bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> > > > @@ -857,7 +857,15 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
> > > >      build_xsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);
> > > >  
> > > >      /* RSDP is in FSEG memory, so allocate it separately */
> > > > -    build_rsdp(tables->rsdp, tables->linker, xsdt);
> > > > +    {
> > > > +        AcpiRsdpData rsdp_data = {
> > > > +            .revision = 2,
> > > > +            .oem_id = ACPI_BUILD_APPNAME6,
> > > > +            .xsdt_tbl_offset = &xsdt,
> > > > +            .rsdt_tbl_offset = NULL,  
> > > 
> > > nit: no need for this explicit NULLing  
> then one would get random junk from the stack this variable is allocate from
> in this field.

Not when you initialize the structure with = { ... }. All uninitialized
pointers will be NULL and all uninitialized arithmetic types will be zero.
Of course explicitly setting it to NULL is fine too, which is why this is
only a "nit".

> 
> > Unfortunately, yes.
> > 
> > Cheers,
> > Samuel.
> 
> 

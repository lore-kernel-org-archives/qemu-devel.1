Received: from eggs.gnu.org ([2001:4830:134:3::10]:33598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gYtI3-00081W-VD
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gYtI2-00030l-N6
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:50:35 -0500
Date: Mon, 17 Dec 2018 14:49:59 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181217134959.GB4456@caravaggio>
References: <20181217104838.18957-1-sameo@linux.intel.com>
	<20181217104838.18957-8-sameo@linux.intel.com>
	<20181217132028.4e387d2d@Igors-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181217132028.4e387d2d@Igors-MacBook-Pro.local>
Subject: Re: [Qemu-devel] [PATCH v4 7/8] hw: acpi: Export and share the ARM
 RSDP build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Dec 17, 2018 at 01:20:28PM +0100, Igor Mammedov wrote:
> On Mon, 17 Dec 2018 11:48:37 +0100
> Samuel Ortiz <sameo@linux.intel.com> wrote:
> 
> > Now that build_rsdp() supports building both legacy and current RSDP
> > tables, we can move it to a generic folder (hw/acpi) and have the i386
> > ACPI code reuse it in order to reduce code duplication.
> > 
> > Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > Reviewed-by: Andrew Jones <drjones@redhat.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> for future reference, if one changes patch in a significant way,
> one is supposed to drop Tested/Reviewed-by tags so that reviewers
> would look at it again and we by mistake won't merge not actually
> reviewed changes.
> 
> [...]
> 
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index fb877648ac..846cb6d755 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -2547,35 +2547,6 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
> >                   "IVRS", table_data->len - iommu_start, 1, NULL, NULL);
> >  }
> >  
> > -static void
> > -build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
> > -{
> > -    /* AcpiRsdpDescriptor describes revision 2 RSDP table and as result we
> > -     * allocate extra 16 bytes for pc/q35 RSDP rev1 as well. Keep extra 16 bytes
> > -     * wasted to make sure we won't breake migration for machine types older
> > -     * than 2.3 due to size mismatch.
> > -     */
> > -    AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
> > -    unsigned rsdt_pa_size = sizeof(rsdp->rsdt_physical_address);
> > -    unsigned rsdt_pa_offset =
> > -        (char *)&rsdp->rsdt_physical_address - rsdp_table->data;
> > -
> > -    bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, rsdp_table, 16,
> > -                             true /* fseg memory */);
> > -
> > -    memcpy(&rsdp->signature, "RSD PTR ", 8);
> > -    memcpy(rsdp->oem_id, ACPI_BUILD_APPNAME6, 6);
> > -    /* Address to be filled by Guest linker */
> > -    bios_linker_loader_add_pointer(linker,
> > -        ACPI_BUILD_RSDP_FILE, rsdt_pa_offset, rsdt_pa_size,
> > -        ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset);
> > -
> > -    /* Checksum to be filled by Guest linker */
> > -    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> > -        (char *)rsdp - rsdp_table->data, 20 /* ACPI rev 1.0 RSDP size */,
> > -        (char *)&rsdp->checksum - rsdp_table->data);
> > -}
> > -
> >  typedef
> >  struct AcpiBuildState {
> >      /* Copy of table in RAM (for patching). */
> > @@ -2732,7 +2703,25 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
> >                 slic_oem.id, slic_oem.table_id);
> >  
> >      /* RSDP is in FSEG memory, so allocate it separately */
> > -    build_rsdp(tables->rsdp, tables->linker, rsdt);
> > +    {
> > +        AcpiRsdpData rsdp_data = {
> > +            .revision = 0,
> > +            .oem_id = ACPI_BUILD_APPNAME6,
> > +            .xsdt_tbl_offset = NULL,
> > +            .rsdt_tbl_offset = &rsdt,
> > +        };
> > +        build_rsdp(tables->rsdp, tables->linker, &rsdp_data);
> > +        if (!pcmc->rsdp_in_ram) {
> > +            /*
> > +             * Legacy machine types (2.2 and older) expect to get a complete
> > +             * revision 2 RSDP table, even though they only look at the
> not true, rev is set to 0 for pc machines,
Rev is set to 0 but they effectively expect to get a structure which
size is the rev 2 one. That's what I meant.

> the point of the original comment was
> that we allocate extra 16 bytes but not actually using them and why it's bad
> to drop it suddenly.
>
> > +             * revision 0 fields (xsdt pointer is not set). So in order to
> > +             * not break migration to those machine types we waste 16 bytes
> > +             * that we amend to the RSDP revision 0 structure.
>                           ^^^ added
> > +             */
> Perhaps amended original comment would be clearer:
> 
>    /* We used to allocate extra space for RSDP rev 2 but used only space for
>     * legacy RSDP and extra bytes were zeroed out. Keep wasting extra 16 bytes
>     * to make sure we won't breake migration for machine types 2.2 and older
>     * due to RSDP blob size mismatch.
>     */
> 
> > +            build_append_int_noprefix(tables->rsdp, 0, 16);
> > +        }
> > +    }
> >  
> >      /* We'll expose it all to Guest so we want to reduce
> >       * chance of size changes.
> 
> With comment fixed:
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
> since it's minor fixup and doesn't affect applying remaining patches you can post
> v5 7/8 as reply to v4 7/8
I'll do that.
Since I assume the 16 bytes addition is a significant change, I'll also remove all
reviewed-by/tested-by tags from this patch, except yours.

Cheers,
Samuel.

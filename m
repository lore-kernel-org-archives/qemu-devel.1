Received: from eggs.gnu.org ([2001:4830:134:3::10]:55582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gP1Jn-0007jH-NS
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gP1Jm-0000PX-Pa
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:23:35 -0500
Date: Tue, 20 Nov 2018 09:23:18 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181120092318.48f69fa4@redhat.com>
In-Reply-To: <20181119131625-mutt-send-email-mst@kernel.org>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-6-sameo@linux.intel.com>
	<20181108151623.4de26ecb@redhat.com>
	<20181119131625-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 05/24] hw: acpi: Implement XSDT support
 for RSDP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, 19 Nov 2018 13:27:14 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Nov 08, 2018 at 03:16:23PM +0100, Igor Mammedov wrote:
> > On Mon,  5 Nov 2018 02:40:28 +0100
> > Samuel Ortiz <sameo@linux.intel.com> wrote:
> >   
> > > XSDT is the 64-bit version of the legacy ACPI RSDT (Root System
> > > Description Table). RSDT only allow for 32-bit addressses and have thus
> > > been deprecated. Since ACPI version 2.0, RSDPs should point at XSDTs and
> > > no longer RSDTs, although RSDTs are still supported for backward
> > > compatibility.
> > > 
> > > Since version 2.0, RSDPs should add an extended checksum, a complete table
> > > length and a version field to the table.  
> > 
> > This patch re-implements what arm/virt board already does
> > and fixes checksum bug in the later and at the same time
> > without a user (within the patch).
> > 
> > I'd suggest redo it a way similar to FADT refactoring
> >   patch 1: fix checksum bug in virt/arm
> >   patch 2: update reference tables in test
> >   patch 3: introduce AcpiRsdpData similar to commit 937d1b587
> >              (both arm and x86) wich stores all data in hos byte order
> >   patch 4: convert arm's impl. to build_append_int_noprefix() API (commit 5d7a334f7)
> >            ... move out to aml-build.c
> >   patch 5: reuse generalized arm's build_rsdp() for x86, dropping x86 specific one
> >       amending it to generate rev1 variant defined by revision in AcpiRsdpData
> >       (commit dd1b2037a)
> > 
> >   'make check V=1' shouldn't observe any ACPI tables changes after patch 2.  
> 
> And your next suggestion is to add patch 6.  I guess it's doable but
> this will make a single patch a 6 patch series. At this rate this series
> will be at 200 patches easily.
> 
> Automated checks are cool but hey it's easy to see what changed in a
> disassembled table, and we do not update them blindly. So just note in
> the comment that there's a table change for ARM and expected files need
> to be updated and we should be fine IMHO.
Point was to move patches that change tables content first,
where we would pay extra attentions to changes in tables and
then refactoring which shouldn't cause any changes will be mostly
automatic  (at least at that point we won't have to worry about 
tables correctness)


> > > Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> > > ---
> > >  include/hw/acpi/aml-build.h |  3 +++
> > >  hw/acpi/aml-build.c         | 37 +++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 40 insertions(+)
> > > 
> > > diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> > > index c9bcb32d81..3580d0ce90 100644
> > > --- a/include/hw/acpi/aml-build.h
> > > +++ b/include/hw/acpi/aml-build.h
> > > @@ -393,6 +393,9 @@ void
> > >  build_rsdp(GArray *table_data,
> > >             BIOSLinker *linker, unsigned rsdt_tbl_offset);
> > >  void
> > > +build_rsdp_xsdt(GArray *table_data,
> > > +                BIOSLinker *linker, unsigned xsdt_tbl_offset);
> > > +void
> > >  build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
> > >             const char *oem_id, const char *oem_table_id);
> > >  void
> > > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > > index 51b608432f..a030d40674 100644
> > > --- a/hw/acpi/aml-build.c
> > > +++ b/hw/acpi/aml-build.c
> > > @@ -1651,6 +1651,43 @@ build_xsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
> > >                   (void *)xsdt, "XSDT", xsdt_len, 1, oem_id, oem_table_id);
> > >  }
> > >  
> > > +/* RSDP pointing at an XSDT */
> > > +void
> > > +build_rsdp_xsdt(GArray *rsdp_table,
> > > +                BIOSLinker *linker, unsigned xsdt_tbl_offset)
> > > +{
> > > +    AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
> > > +    unsigned xsdt_pa_size = sizeof(rsdp->xsdt_physical_address);
> > > +    unsigned xsdt_pa_offset =
> > > +        (char *)&rsdp->xsdt_physical_address - rsdp_table->data;
> > > +    unsigned xsdt_offset =
> > > +        (char *)&rsdp->length - rsdp_table->data;  
> 
> There's a cleaner way to get at the offsets than pointer math:
> 1. save rsdp_table length before you push
> 2. add offset_of for fields
> 
> If switching to build_append_int_noprefix then it's even
> easier - just save length before you append the int
> you intend to patch.
> 
> 
> > > +
> > > +    bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, rsdp_table, 16,
> > > +                             true /* fseg memory */);
> > > +
> > > +    memcpy(&rsdp->signature, "RSD PTR ", 8);
> > > +    memcpy(rsdp->oem_id, ACPI_BUILD_APPNAME6, 6);
> > > +    rsdp->length = cpu_to_le32(sizeof(*rsdp));
> > > +    /* version 2, we will use the XSDT pointer */
> > > +    rsdp->revision = 0x02;
> > > +
> > > +    /* Address to be filled by Guest linker */
> > > +    bios_linker_loader_add_pointer(linker,
> > > +        ACPI_BUILD_RSDP_FILE, xsdt_pa_offset, xsdt_pa_size,
> > > +        ACPI_BUILD_TABLE_FILE, xsdt_tbl_offset);
> > > +
> > > +    /* Legacy checksum to be filled by Guest linker */
> > > +    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> > > +        (char *)rsdp - rsdp_table->data, xsdt_offset,
> > > +        (char *)&rsdp->checksum - rsdp_table->data);
> > > +
> > > +    /* Extended checksum to be filled by Guest linker */
> > > +    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> > > +        (char *)rsdp - rsdp_table->data, sizeof *rsdp,
> > > +        (char *)&rsdp->extended_checksum - rsdp_table->data);
> > > +}
> > > +
> > >  void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
> > >                         uint64_t len, int node, MemoryAffinityFlags flags)
> > >  {  

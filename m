Received: from eggs.gnu.org ([2001:4830:134:3::10]:60706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gQ9Ce-0006JA-3j
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 06:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gQ9CX-0001S9-HL
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 06:00:52 -0500
Date: Fri, 23 Nov 2018 11:55:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181123115533.0d2c37c3@redhat.com>
In-Reply-To: <20181121154312.GI4426@caravaggio>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-11-sameo@linux.intel.com>
	<20181113165918.5cc2b2b5@redhat.com>
	<20181121154312.GI4426@caravaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 10/24] hw: acpi: Export the PCI host and
 holes getters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On Wed, 21 Nov 2018 16:43:12 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> On Tue, Nov 13, 2018 at 04:59:18PM +0100, Igor Mammedov wrote:
> > On Mon,  5 Nov 2018 02:40:33 +0100
> > Samuel Ortiz <sameo@linux.intel.com> wrote:
> >   
> > > This is going to be needed by the hardware reduced implementation, so
> > > let's export it.
> > > Once the ACPI builder methods and getters will be implemented, the
> > > acpi_get_pci_host() implementation will become hardware agnostic.
> > > 
> > > Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> > > ---
> > >  include/hw/acpi/aml-build.h |  2 ++
> > >  hw/acpi/aml-build.c         | 43 +++++++++++++++++++++++++++++++++
> > >  hw/i386/acpi-build.c        | 47 ++-----------------------------------
> > >  3 files changed, 47 insertions(+), 45 deletions(-)
> > > 
> > > diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> > > index c27c0935ae..fde2785b9a 100644
> > > --- a/include/hw/acpi/aml-build.h
> > > +++ b/include/hw/acpi/aml-build.h
> > > @@ -400,6 +400,8 @@ build_header(BIOSLinker *linker, GArray *table_data,
> > >               const char *oem_id, const char *oem_table_id);
> > >  void *acpi_data_push(GArray *table_data, unsigned size);
> > >  unsigned acpi_data_len(GArray *table);
> > > +Object *acpi_get_pci_host(void);
> > > +void acpi_get_pci_holes(Range *hole, Range *hole64);
> > >  /* Align AML blob size to a multiple of 'align' */
> > >  void acpi_align_size(GArray *blob, unsigned align);
> > >  void acpi_add_table(GArray *table_offsets, GArray *table_data);
> > > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > > index 2b9a636e75..b8e32f15f7 100644
> > > --- a/hw/acpi/aml-build.c
> > > +++ b/hw/acpi/aml-build.c
> > > @@ -1601,6 +1601,49 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
> > >      g_array_free(tables->vmgenid, mfre);
> > >  }  
> >   
> > > +/*
> > > + * Because of the PXB hosts we cannot simply query TYPE_PCI_HOST_BRIDGE.
> > > + */
> > > +Object *acpi_get_pci_host(void)
> > > +{
> > > +    PCIHostState *host;
> > > +
> > > +    host = OBJECT_CHECK(PCIHostState,
> > > +                        object_resolve_path("/machine/i440fx", NULL),
> > > +                        TYPE_PCI_HOST_BRIDGE);
> > > +    if (!host) {
> > > +        host = OBJECT_CHECK(PCIHostState,
> > > +                            object_resolve_path("/machine/q35", NULL),
> > > +                            TYPE_PCI_HOST_BRIDGE);
> > > +    }
> > > +
> > > +    return OBJECT(host);
> > > +}  
> > in general aml-build.c is a place to put ACPI spec primitives,
> > so I'd suggest to move it somewhere else.
> > 
> > Considering it's x86 code (so far), maybe move it to something like
> > hw/i386/acpi-pci.c
> > 
> > Also it might be good to get rid of acpi_get_pci_host() and pass
> > a pointer to pci_host as acpi_setup() an argument, since it's static
> > for life of boar we can keep it in AcpiBuildState, and reuse for
> > mfg/pci_hole/pci bus accesses.  
> That's what I'm trying to do with patches #23 and 24, but through the
> ACPI configuration structure. I could try using the build state instead,
> as it's platform agnostic as well.
May be it will work.
Note:
try not to pass whole build_state to concrete tables builders and use
arguments/dedicated structures to pass data needed for that concrete
table.

> 
> Cheers,
> Samuel.
> 

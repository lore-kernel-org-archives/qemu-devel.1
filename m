Received: from eggs.gnu.org ([2001:4830:134:3::10]:33791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gQ9G6-000875-By
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 06:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gQ9G1-0005tk-Bp
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 06:04:26 -0500
Date: Fri, 23 Nov 2018 12:04:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181123120405.4b94a220@redhat.com>
In-Reply-To: <20181121231217.GA4450@caravaggio>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-12-sameo@linux.intel.com>
	<20181114115537.3357921b@redhat.com>
	<20181121231217.GA4450@caravaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 11/24] hw: acpi: Export and generalize
 the PCI host AML API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, Rob Bradford <robert.bradford@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On Thu, 22 Nov 2018 00:12:17 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> Hi Igor,
> 
> On Wed, Nov 14, 2018 at 11:55:37AM +0100, Igor Mammedov wrote:
> > On Mon,  5 Nov 2018 02:40:34 +0100
> > Samuel Ortiz <sameo@linux.intel.com> wrote:
> >   
> > > From: Yang Zhong <yang.zhong@intel.com>
> > > 
> > > The AML build routines for the PCI host bridge and the corresponding
> > > DSDT addition are neither x86 nor PC machine type specific.
> > > We can move them to the architecture agnostic hw/acpi folder, and by
> > > carrying all the needed information through a new AcpiPciBus structure,
> > > we can make them PC machine type independent.  
> > 
> > I'm don't know anything about PCI, but functional changes doesn't look
> > correct to me.
> >
> > See more detailed comments below.
> > 
> > Marcel,
> > could you take a look on this patch (in particular main csr changes), pls?
> >   
> > > 
> > > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > > Signed-off-by: Rob Bradford <robert.bradford@intel.com>
> > > Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> > > ---
> > >  include/hw/acpi/aml-build.h |   8 ++
> > >  hw/acpi/aml-build.c         | 157 ++++++++++++++++++++++++++++++++++++
> > >  hw/i386/acpi-build.c        | 115 ++------------------------
> > >  3 files changed, 173 insertions(+), 107 deletions(-)
> > > 
> > > diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> > > index fde2785b9a..1861e37ebf 100644
> > > --- a/include/hw/acpi/aml-build.h
> > > +++ b/include/hw/acpi/aml-build.h
> > > @@ -229,6 +229,12 @@ typedef struct AcpiMcfgInfo {
> > >      uint32_t mcfg_size;
> > >  } AcpiMcfgInfo;
> > >  
> > > +typedef struct AcpiPciBus {
> > > +    PCIBus *pci_bus;
> > > +    Range *pci_hole;
> > > +    Range *pci_hole64;
> > > +} AcpiPciBus;  
> > Again, this and all below is not aml-build material.
> > Consider adding/using pci specific acpi file for it.
> > 
> > Also even though pci AML in arm/virt is to a large degree a subset
> > of x86 target and it would be much better to unify ARM part with x86,
> > it probably will be to big/complex of a change if we take on it in
> > one go.
> > 
> > So not to derail you from the goal too much, we probably should
> > generalize this a little bit less, limiting refactoring to x86
> > target for now.  
> So keeping it under i386 means it won't be accessible through hw/acpi/,
> which means we won't be able to have a generic hw/acpi/reduced.c
> implementation. From our perspective, this is the problem with keeping
> things under i386 because we're not sure yet how much generic it is: It
> still won't be shareable for a generic hardware-reduced ACPI
> implementation which means we'll have to temporarily have yet another
> hardware-reduced ACPI implementation under hw/i386 this time.
> I guess this is what Michael meant by keeping some parts of the code
> duplicated for now.
> 
> I feel it'd be easier to move those APIs under a shareable location, to
> make it easier for ARM to consume it even if it's not entirely generic yet.
> But you guys are the maintainers and if you think we should restric the
> generalization to x86 only for now, we can go for it.
If code is generic (you can reuse it with arm/virt in the same series)
then place it in hw/acpi otherwise if it's semi-generic put to hw/i386.
If it would be a separate file it would be easier to move it to generic
place when we are able to resuse it with arm/virt.

 
> Cheers,
> Samuel.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gRdp3-0005Ed-UD
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:54:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gRdp2-0008OX-Da
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:54:41 -0500
Date: Tue, 27 Nov 2018 14:54:15 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181127145415.17b49d64@redhat.com>
In-Reply-To: <20181121232106.GB4450@caravaggio>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-13-sameo@linux.intel.com>
	<20181115133658.2cdbd918@redhat.com>
	<20181121232106.GB4450@caravaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 12/24] hw: acpi: Export the MCFG getter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On Thu, 22 Nov 2018 00:21:06 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> Hi Igor,
> 
> On Thu, Nov 15, 2018 at 01:36:58PM +0100, Igor Mammedov wrote:
> > On Mon,  5 Nov 2018 02:40:35 +0100
> > Samuel Ortiz <sameo@linux.intel.com> wrote:
> >   
> > > From: Yang Zhong <yang.zhong@intel.com>
> > > 
> > > The ACPI MCFG getter is not x86 specific and could be called from
> > > anywhere within generic ACPI API, so let's export it.  
> > So far it's x86 or more exactly q35 specific thing,  
> It's property based, and it's using a generic PCIE property afaict.
> So it's up to each machine type to define those properties.
> I'm curious here: What's the idiomatic way to define a machine
> setting/attribute/property, let each instance define it or not, and
> make it available at run time?
> Would you be getting the PCI host pointer from the ACPI build state and
> getting that information back from there?

Cleaner way would be make arm/virt board set PCIE_HOST_MCFG_BASE/
PCIE_HOST_MCFG_SIZE properties and then use common build_mcfg()(in aml-build.c).
Something like this:
  acpi_setup_reduced()
     AcpiMcfgInfo mcfg_info = {
       .base = object_property_get_uint(pcie, PCIE_HOST_MCFG_BASE, NULL),
       .size = object_property_get_uint(pcie, PCIE_HOST_MCFG_SIZE, NULL)
     };
     acpi_build() {
         build_mcfg("MCFG", &info);
     }
  }
and for legacy q35
  acpi_build() {
     if (pcie) {
        AcpiMcfgInfo mcfg_info = {
          .base = object_property_get_uint(pcie, PCIE_HOST_MCFG_BASE, NULL),
          .size = object_property_get_uint(pcie, PCIE_HOST_MCFG_SIZE, NULL)
        };
        if (mcfg_info.base != PCIE_BASE_ADDR_UNMAPPED)
            build_mcfg("MCFG", &info);
        else
            /* move comment here why we are doing it */
            build_mcfg("QEMU", &info);
     }
  }

The thing I don't like about acpi_get_mcfg() is that it
does lookup acpi_get_i386_pci_host() each time it's called
and judges if it's PCI-E host by presence of properties.

I'd rather be explicit where PCI host be fetched once somewhere
in acpi_setup() or possibly passed down from the board as an argument
and board telling to i386/acpi_setup() if it's PCI or PCI-E host
so we don't have to guess it in acpi code.


> Cheers,
> Samuel.

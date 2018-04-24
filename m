Received: from eggs.gnu.org ([2001:4830:134:3::10]:54798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fAylg-0008Ch-JA
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fAyla-0003eP-Qn
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:18:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46170 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1fAyla-0003dh-Kk
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:17:58 -0400
Date: Tue, 24 Apr 2018 16:17:46 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180424141746.pagolvh3v232my5z@kamzik.brq.redhat.com>
References: <3301c5bc-7b47-1b0e-8ce4-30435057a276@web.de>
	<CAFEAcA9KSUppGGom-ipX+N49j0gDJH3KDY8oyqT8cVOU0Mn8Rw@mail.gmail.com>
	<20180424141258.cuenuefdtkefikr6@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424141258.cuenuefdtkefikr6@kamzik.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: Add linux, pci-domain property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jan Kiszka <jan.kiszka@web.de>, qemu-devel <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>

On Tue, Apr 24, 2018 at 04:12:58PM +0200, Andrew Jones wrote:
> On Mon, Apr 23, 2018 at 02:11:40PM +0100, Peter Maydell wrote:
> > On 23 April 2018 at 06:18, Jan Kiszka <jan.kiszka@web.de> wrote:
> > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > >
> > > This allows to pin the host controller in the Linux PCI domain space.
> > > Linux requires that property to be available consistently or not at all,
> > > in which case the domain number becomes unstable on additions/removals.
> > > Adding it here won't make a difference in practice for most setups as we
> > > only expose one controller.
> > >
> > > However, enabling Jailhouse on top may introduce another controller, and
> > > that one would like to have stable address as well. So the property is
> > > needed for the first controller as well.
> > 
> > Am I right in thinking that for ACPI the PCI domain number is
> > communicated via the _SEG method? If so, looks like we already
> > set that, and we set it to 0, which matches what we're doing here
> > in the DT, so that's good.
> 
> _SEG and linux,pci-domain are similar in definition, but don't appear to
> be equivalent, as the same _SEG number is permitted across multiple host
> bridges, but linux,pci-domain must be unique for each host bridge. I
> think the (_SEG, _BBN) pair may form the equivalent. We also set _BBN
> to zero, so I think we're fine anyway.
> 
> > 
> > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > ---
> > >  hw/arm/virt.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > index 94dcb125d3..943371b75e 100644
> > > --- a/hw/arm/virt.c
> > > +++ b/hw/arm/virt.c
> > > @@ -1023,6 +1023,7 @@ static void create_pcie(const VirtMachineState *vms, qemu_irq *pic)
> > >      qemu_fdt_setprop_string(vms->fdt, nodename, "device_type", "pci");
> > >      qemu_fdt_setprop_cell(vms->fdt, nodename, "#address-cells", 3);
> > >      qemu_fdt_setprop_cell(vms->fdt, nodename, "#size-cells", 2);
> > > +    qemu_fdt_setprop_cell(vms->fdt, nodename, "linux,pci-domain", 0);
> > >      qemu_fdt_setprop_cells(vms->fdt, nodename, "bus-range", 0,
> > >                             nr_pcie_buses - 1);
> > >      qemu_fdt_setprop(vms->fdt, nodename, "dma-coherent", NULL, 0);
> > > --
> > 
> > Drew -- is minor changes to the DTC something we can do without
> > having to condition it on machine version? I forget...
> 
> Yes, and even less minor changes than this one can be made to ACPI and DT
> generation, per the "if a firwmare update could change it, then don't
> worry about it" policy.
> 
> (I've CC'ed Igor in case he wants to chime in to correct anything I've
>  said.)

Eh, now I've CC'ed him...

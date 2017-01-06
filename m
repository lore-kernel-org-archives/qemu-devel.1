Received: from eggs.gnu.org ([2001:4830:134:3::10]:41737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cPaOZ-0008Qg-F5
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 14:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cPaOW-0003GI-Pa
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 14:41:47 -0500
Date: Fri, 6 Jan 2017 21:41:41 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170106214052-mutt-send-email-mst@kernel.org>
References: <20170106050451.11793-1-david@gibson.dropbear.id.au>
	<53dcb2da-fa15-63b0-5849-325b6edcac83@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53dcb2da-fa15-63b0-5849-325b6edcac83@redhat.com>
Subject: Re: [Qemu-devel] [RFC] pxb: Restrict to x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, ehabkost@redhat.com, thuth@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Fri, Jan 06, 2017 at 08:13:11AM +0200, Marcel Apfelbaum wrote:
> On 01/06/2017 07:04 AM, David Gibson wrote:
> > The PCI Expander Bridge (PXB) device is essentially a hack to allow
> > different PCIe devices to be assigned to different NUMA nodes on x86.  Each
> > PXB is sort-of a separate PCI host bridge, except that its config space
> > is shared with the config space of the main PCI host bridge, rather than
> > being independent.
> > 
> 
> Hi David,
> 
> > This is only necessary if the platform doesn't (easily) allow truly
> > independent PCI host bridges.  AFAIK that's just x86.
> > 
> 
> Indeed, it is possible to support independent PCI host bridges on x86 by
> using a separate MMCONFIG space for each one and enable separate PCI domains.
> We simply didn't need this until now, but maybe will be implemented it in the future.

In fact I would say that's the cleanest way to do this on q35.

> > This patch makes it possible to configure PXB out of the build, and adjusts
> > the default configs so it's only included on x86 targets.
> > 
> 
> Makes sense
> 
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> 
> Thanks,
> Marcel
> 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  default-configs/i386-softmmu.mak   | 1 +
> >  default-configs/x86_64-softmmu.mak | 1 +
> >  hw/pci-bridge/Makefile.objs        | 2 +-
> >  3 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> > index 0b51360..6c52d26 100644
> > --- a/default-configs/i386-softmmu.mak
> > +++ b/default-configs/i386-softmmu.mak
> > @@ -56,3 +56,4 @@ CONFIG_IOH3420=y
> >  CONFIG_I82801B11=y
> >  CONFIG_SMBIOS=y
> >  CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
> > +CONFIG_PXB=y
> > diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
> > index 7f89503..2d0341c 100644
> > --- a/default-configs/x86_64-softmmu.mak
> > +++ b/default-configs/x86_64-softmmu.mak
> > @@ -56,3 +56,4 @@ CONFIG_IOH3420=y
> >  CONFIG_I82801B11=y
> >  CONFIG_SMBIOS=y
> >  CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
> > +CONFIG_PXB=y
> > diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
> > index f2adfe3..5612bd7 100644
> > --- a/hw/pci-bridge/Makefile.objs
> > +++ b/hw/pci-bridge/Makefile.objs
> > @@ -1,5 +1,5 @@
> >  common-obj-y += pci_bridge_dev.o
> > -common-obj-y += pci_expander_bridge.o
> > +common-obj-$(CONFIG_PXB) += pci_expander_bridge.o
> >  common-obj-$(CONFIG_XIO3130) += xio3130_upstream.o xio3130_downstream.o
> >  common-obj-$(CONFIG_IOH3420) += ioh3420.o
> >  common-obj-$(CONFIG_I82801B11) += i82801b11.o
> > 

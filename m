Received: from eggs.gnu.org ([209.51.188.92]:52343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmrob-0003oo-G7
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 22:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmrbY-0004wg-EU
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 21:52:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:34413)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmrbY-0004vT-5o
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 21:52:28 -0500
Date: Fri, 25 Jan 2019 10:48:43 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190125024843.GA26929@yangzhon-Virtual>
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-30-yang.zhong@intel.com>
	<20190123092224-mutt-send-email-mst@kernel.org>
	<20190125021053.GA26802@yangzhon-Virtual>
	<20190124214330-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124214330-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [RFC PATCH v4 29/44] hw/pci/Makefile.objs: make
 pcie configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com, yang.zhong@intel.com

On Thu, Jan 24, 2019 at 09:43:44PM -0500, Michael S. Tsirkin wrote:
> On Fri, Jan 25, 2019 at 10:10:53AM +0800, Yang Zhong wrote:
> > On Wed, Jan 23, 2019 at 09:23:49AM -0500, Michael S. Tsirkin wrote:
> > > On Wed, Jan 23, 2019 at 02:56:03PM +0800, Yang Zhong wrote:
> > > > Make pcie splited from pci and make it configurable.
> > > > 
> > > > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > > > ---
> > > >  default-configs/pci.mak | 1 +
> > > >  hw/pci/Kconfig          | 3 +++
> > > >  hw/pci/Makefile.objs    | 5 +++--
> > > >  3 files changed, 7 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/default-configs/pci.mak b/default-configs/pci.mak
> > > > index f7b3690bbd..b17b456b1e 100644
> > > > --- a/default-configs/pci.mak
> > > > +++ b/default-configs/pci.mak
> > > > @@ -1,4 +1,5 @@
> > > >  CONFIG_PCI=y
> > > > +CONFIG_PCI_EXPRESS=y
> > > >  # For now, CONFIG_IDE_CORE requires ISA, so we enable it here
> > > >  CONFIG_ISA_BUS=y
> > > >  CONFIG_VIRTIO_PCI=y
> > > > diff --git a/hw/pci/Kconfig b/hw/pci/Kconfig
> > > > index d3d2205577..81533b9dc0 100644
> > > > --- a/hw/pci/Kconfig
> > > > +++ b/hw/pci/Kconfig
> > > > @@ -1,2 +1,5 @@
> > > >  config PCI
> > > >      bool
> > > > +
> > > > +config PCI_EXPRESS
> > > > +    bool
> > > 
> > > Hmm this allows PCIE without PCI.
> > > Should PCI_EXPRESS select PCI?
> > > 
> > > It's selected itself so can't depend on PCI.
> > >
> >   Hello Michael,
> > 
> >   I did this in patch 30 as below:
> >   
> >   diff --git a/hw/pci/Kconfig b/hw/pci/Kconfig
> >   index 81533b9dc0..4ca2537980 100644
> >   --- a/hw/pci/Kconfig
> >   +++ b/hw/pci/Kconfig
> >   @@ -3,3 +3,4 @@ config PCI
> > 
> >   config PCI_EXPRESS
> >      bool
> > +    select PCI
> > 
> >    Regards,
> > 
> >    Yang
> 
> Maybe squash this into patch 29 then.
> 
> > >
  Okay, i will do it in next version, thanks Michael, Yang.
 
> > > > diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
> > > > index 9f905e6344..d30eb32cbb 100644
> > > > --- a/hw/pci/Makefile.objs
> > > > +++ b/hw/pci/Makefile.objs
> > > > @@ -2,8 +2,9 @@ common-obj-$(CONFIG_PCI) += pci.o pci_bridge.o
> > > >  common-obj-$(CONFIG_PCI) += msix.o msi.o
> > > >  common-obj-$(CONFIG_PCI) += shpc.o
> > > >  common-obj-$(CONFIG_PCI) += slotid_cap.o
> > > > -common-obj-$(CONFIG_PCI) += pci_host.o pcie_host.o
> > > > -common-obj-$(CONFIG_PCI) += pcie.o pcie_aer.o pcie_port.o
> > > > +common-obj-$(CONFIG_PCI) += pci_host.o
> > > > +common-obj-$(CONFIG_PCI_EXPRESS) += pcie.o pcie_aer.o
> > > > +common-obj-$(CONFIG_PCI_EXPRESS) += pcie_port.o pcie_host.o
> > > >  
> > > >  common-obj-$(call lnot,$(CONFIG_PCI)) += pci-stub.o
> > > >  common-obj-$(CONFIG_ALL) += pci-stub.o
> > > > -- 
> > > > 2.17.1

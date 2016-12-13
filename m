Received: from eggs.gnu.org ([2001:4830:134:3::10]:46897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGlmj-0003fh-Mx
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:02:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGlme-0004zg-Pa
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:02:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cGlme-0004zV-IV
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:02:12 -0500
Date: Tue, 13 Dec 2016 10:02:08 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161213120208.GM3808@thinpad.lan.raisama.net>
References: <20161209203954.GW4027@thinpad.lan.raisama.net>
	<584E36CD.50405@cn.fujitsu.com>
	<20161212172915.GP4074@stefanha-x1.localdomain>
	<20161212202617-mutt-send-email-mst@kernel.org>
	<20161212185730.GG3808@thinpad.lan.raisama.net>
	<20161213000816-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161213000816-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] Reproducible crash on PCIe hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Cao jin <caoj.fnst@cn.fujitsu.com>

On Tue, Dec 13, 2016 at 12:09:33AM +0200, Michael S. Tsirkin wrote:
> On Mon, Dec 12, 2016 at 04:57:30PM -0200, Eduardo Habkost wrote:
> > On Mon, Dec 12, 2016 at 08:41:41PM +0200, Michael S. Tsirkin wrote:
> > > On Mon, Dec 12, 2016 at 05:29:15PM +0000, Stefan Hajnoczi wrote:
> > > > On Mon, Dec 12, 2016 at 01:34:05PM +0800, Cao jin wrote:
> > > > > 
> > > > > 
> > > > > On 12/10/2016 04:39 AM, Eduardo Habkost wrote:
> > > > > > Using latest qemu.git master:
> > > > > > 
> > > > > >   $ qemu-system-x86_64 -machine q35 -readconfig docs/q35-chipset.cfg -monitor stdio
> > > > > >   QEMU 2.7.93 monitor - type 'help' for more information
> > > > > >   (qemu) device_add e1000e,bus=ich9-pcie-port-4,addr=00
> > > > > >   (qemu) device_add e1000e,bus=ich9-pcie-port-4,addr=08
> > > > > >   Segmentation fault (core dumped)
> > > > > > 
> > > > > > It crashes at:
> > > > > > 
> > > > > >   #7  0x000055555598d7dc in do_pci_register_device (errp=0x7fffffffbfd0, devfn=64, name=0x5555565df340 "e1000e", bus=0x555558487380, pci_dev=0x5555589cd000)
> > > > > >       at /home/ehabkost/rh/proj/virt/qemu/hw/pci/pci.c:983
> > > > > >   983             error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
> > > > > >   (gdb) l
> > > > > >   978                        PCI_SLOT(devfn), PCI_FUNC(devfn), name,
> > > > > >   979                        bus->devices[devfn]->name);
> > > > > >   980             return NULL;
> > > > > >   981         } else if (dev->hotplugged &&
> > > > > >   982                    pci_get_function_0(pci_dev)) {
> > > > > >   983             error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
> > > > > >   984                        " new func %s cannot be exposed to guest.",
> > > > > >   985                        PCI_SLOT(devfn),
> > > > > >   986                        bus->devices[PCI_DEVFN(PCI_SLOT(devfn), 0)]->name,
> > > > > >   987                        name);
> > > > > > 
> > > > > 
> > > > > Thanks for informing me. I am kind of busy for now, so I suppose I will
> > > > > investigate it after 2.8 release.
> > > > 
> > > > Please let me know if this should be considered a release blocker.
> > > > 
> > > > The proposed QEMU 2.8 release date is tomorrow (December 13th)!
> > > > 
> > > > Stefan
> > > 
> > > I don't see how it's a blocker, it's an illegal configuration.
> > > Here's the fix. It's a rather obvious one.
> > > I'll target the fix for 2.9.
> > > Eduardo, I'd appreciate a tested-by tag.
> > 
> > I confirm the patch fixes the crash, but the error message seems
> > incorrect: the existing e1000e device is on slot 0 function 0,
> > not slot 8.
> > 
> >   $ ./x86-kvm-build/x86_64-softmmu/qemu-system-x86_64 -machine q35 -readconfig docs/q35-chipset.cfg -monitor stdio
> >   QEMU 2.7.93 monitor - type 'help' for more information
> >   (qemu) device_add e1000e,bus=ich9-pcie-port-4,addr=00
> >   (qemu) device_add e1000e,bus=ich9-pcie-port-4,addr=08
> >   PCI: slot 8 function 0 already ocuppied by e1000e, new func e1000e cannot be exposed to guest.
> >            ^^^
> > 
> > 
> > > 
> > > -->
> > > 
> > > pci: fix error message for express slots
> > > 
> > > PCI Express downstream slot has a single PCI slot
> > > behind it, using PCI_DEVFN(PCI_SLOT(devfn), 0)
> > > does not give you function 0 in cases such as ARI
> > > as well as some error cases.
> > > 
> > > This is exactly what we are hitting:
> > >    $ qemu-system-x86_64 -machine q35 -readconfig docs/q35-chipset.cfg -monitor stdio
> > >    (qemu) device_add e1000e,bus=ich9-pcie-port-4,addr=00
> > >    (qemu) device_add e1000e,bus=ich9-pcie-port-4,addr=08
> > >    Segmentation fault (core dumped)
> > > 
> > > The fix is to use the pci_get_function_0 API.
> > > 
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > > 
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index 24fae16..339c531 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -983,7 +983,7 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
> > >          error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
> > >                     " new func %s cannot be exposed to guest.",
> > >                     PCI_SLOT(devfn),
> > > -                   bus->devices[PCI_DEVFN(PCI_SLOT(devfn), 0)]->name,
> > > +                   pci_get_function_0(pci_dev)->name,
> > >                     name);
> > >  
> > >         return NULL;
> > > 
> > > -- 
> > > MST
> > 
> > -- 
> 
> 
> 
> this then?
> 
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 339c531..637d545 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -982,7 +982,7 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>                 pci_get_function_0(pci_dev)) {
>          error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
>                     " new func %s cannot be exposed to guest.",
> -                   PCI_SLOT(devfn),
> +                   PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
>                     pci_get_function_0(pci_dev)->name,
>                     name);

Works for me. Thanks!

Tested-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo

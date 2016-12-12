Received: from eggs.gnu.org ([2001:4830:134:3::10]:43032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGUSO-00043c-BH
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 12:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGUSL-0000q6-4y
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 12:32:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cGUSK-0000pg-Ve
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 12:32:05 -0500
Date: Mon, 12 Dec 2016 15:32:01 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161212173201.GC3808@thinpad.lan.raisama.net>
References: <20161209203954.GW4027@thinpad.lan.raisama.net>
	<584E36CD.50405@cn.fujitsu.com>
	<20161212172915.GP4074@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161212172915.GP4074@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] Reproducible crash on PCIe hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cao jin <caoj.fnst@cn.fujitsu.com>

On Mon, Dec 12, 2016 at 05:29:15PM +0000, Stefan Hajnoczi wrote:
> On Mon, Dec 12, 2016 at 01:34:05PM +0800, Cao jin wrote:
> > 
> > 
> > On 12/10/2016 04:39 AM, Eduardo Habkost wrote:
> > > Using latest qemu.git master:
> > > 
> > >   $ qemu-system-x86_64 -machine q35 -readconfig docs/q35-chipset.cfg -monitor stdio
> > >   QEMU 2.7.93 monitor - type 'help' for more information
> > >   (qemu) device_add e1000e,bus=ich9-pcie-port-4,addr=00
> > >   (qemu) device_add e1000e,bus=ich9-pcie-port-4,addr=08
> > >   Segmentation fault (core dumped)
> > > 
> > > It crashes at:
> > > 
> > >   #7  0x000055555598d7dc in do_pci_register_device (errp=0x7fffffffbfd0, devfn=64, name=0x5555565df340 "e1000e", bus=0x555558487380, pci_dev=0x5555589cd000)
> > >       at /home/ehabkost/rh/proj/virt/qemu/hw/pci/pci.c:983
> > >   983             error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
> > >   (gdb) l
> > >   978                        PCI_SLOT(devfn), PCI_FUNC(devfn), name,
> > >   979                        bus->devices[devfn]->name);
> > >   980             return NULL;
> > >   981         } else if (dev->hotplugged &&
> > >   982                    pci_get_function_0(pci_dev)) {
> > >   983             error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
> > >   984                        " new func %s cannot be exposed to guest.",
> > >   985                        PCI_SLOT(devfn),
> > >   986                        bus->devices[PCI_DEVFN(PCI_SLOT(devfn), 0)]->name,
> > >   987                        name);
> > > 
> > 
> > Thanks for informing me. I am kind of busy for now, so I suppose I will
> > investigate it after 2.8 release.
> 
> Please let me know if this should be considered a release blocker.
> 
> The proposed QEMU 2.8 release date is tomorrow (December 13th)!

The bug went undetected since QEMU 2.5, and the crash happens
only on cases where hotplug was already going to return an error.
I don't think it should be a release blocker.

-- 
Eduardo

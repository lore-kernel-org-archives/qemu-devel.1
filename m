Received: from eggs.gnu.org ([209.51.188.92]:43393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ggXi0-00014m-66
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ggXhy-0006Gk-Vy
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:25:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ggXhy-0006GS-Mi
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:24:58 -0500
Date: Mon, 7 Jan 2019 11:24:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190107112301-mutt-send-email-mst@kernel.org>
References: <20181210130650-mutt-send-email-mst@kernel.org>
	<7CECC2DFC21538489F72729DF5EFB4D908AC78EE@DGGEMM501-MBX.china.huawei.com>
	<20181210205229-mutt-send-email-mst@kernel.org>
	<7CECC2DFC21538489F72729DF5EFB4D908AC7980@DGGEMM501-MBX.china.huawei.com>
	<20181210223128-mutt-send-email-mst@kernel.org>
	<7CECC2DFC21538489F72729DF5EFB4D908AC7A04@DGGEMM501-MBX.china.huawei.com>
	<20181210232256-mutt-send-email-mst@kernel.org>
	<7CECC2DFC21538489F72729DF5EFB4D908AE9096@dggemm521-mbs.china.huawei.com>
	<20190107095414-mutt-send-email-mst@kernel.org>
	<7CECC2DFC21538489F72729DF5EFB4D908AE91FB@dggemm521-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7CECC2DFC21538489F72729DF5EFB4D908AE91FB@dggemm521-mbs.china.huawei.com>
Subject: Re: [Qemu-devel] [BUG]Unassigned mem write during pci device
 hot-plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xuyandong <xuyandong2@huawei.com>
Cc: "marcel@redhat.com" <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>

On Mon, Jan 07, 2019 at 03:28:36PM +0000, xuyandong wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Monday, January 07, 2019 11:06 PM
> > To: xuyandong <xuyandong2@huawei.com>
> > Cc: marcel@redhat.com; Paolo Bonzini <pbonzini@redhat.com>; qemu-
> > devel@nongnu.org; Zhanghailiang <zhang.zhanghailiang@huawei.com>;
> > wangxin (U) <wangxinxin.wang@huawei.com>; Huangweidong (C)
> > <weidong.huang@huawei.com>
> > Subject: Re: [BUG]Unassigned mem write during pci device hot-plug
> > 
> > On Mon, Jan 07, 2019 at 02:37:17PM +0000, xuyandong wrote:
> > > > > > > > > > > > > Hi all,
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > In our test, we configured VM with several
> > > > > > > > > > > > > pci-bridges and a virtio-net nic been attached
> > > > > > > > > > > > > with bus 4,
> > > > > > > > > > > > >
> > > > > > > > > > > > > After VM is startup, We ping this nic from host to
> > > > > > > > > > > > > judge if it is working normally. Then, we hot add
> > > > > > > > > > > > > pci devices to this VM with bus
> > > > > > > > 0.
> > > > > > > > > > > > >
> > > > > > > > > > > > > We  found the virtio-net NIC in bus 4 is not
> > > > > > > > > > > > > working (can not
> > > > > > > > > > > > > connect) occasionally, as it kick virtio backend
> > > > > > > > > > > > > failure with error
> > >
> > > > > > > But I have another question, if we only fix this problem in
> > > > > > > the kernel, the Linux version that has been released does not
> > > > > > > work well on the
> > > > > > virtualization platform.
> > > > > > > Is there a way to fix this problem in the backend?
> > >
> > > Hi Michael,
> > >
> > > If we want to fix this problem on the backend, it is not enough to
> > > consider only PCI device hot plugging, because I found that if we use
> > > a command like "echo 1 > /sys/bus/pci/rescan" in guest, this problem is very
> > easy to reproduce.
> > >
> > > From the perspective of device emulation, when guest writes 0xffffffff
> > > to the BAR, guest just want to get the size of the region but not really
> > updating the address space.
> > > So I made the following patch to avoid  update pci mapping.
> > >
> > > Do you think this make sense?
> > >
> > > [PATCH] pci: avoid update pci mapping when writing 0xFFFF FFFF to BAR
> > >
> > > When guest writes 0xffffffff to the BAR, guest just want to get the
> > > size of the region but not really updating the address space.
> > > So when guest writes 0xffffffff to BAR, we need avoid
> > > pci_update_mappings or pci_bridge_update_mappings.
> > >
> > > Signed-off-by: xuyandong <xuyandong2@huawei.com>
> > 
> > I see how that will address the common case however there are a bunch of
> > issues here.  First of all it's easy to trigger the update by some other action like
> > VM migration.  More importantly it's just possible that guest actually does want
> > to set the low 32 bit of the address to all ones.  For example, that is clearly
> > listed as a way to disable all devices behind the bridge in the pci to pci bridge
> > spec.
> 
> Ok, I see. If I only skip upate when guest writing 0xFFFFFFFF to Prefetcable Base Upper 32 Bits
> to meet the kernel double check problem.
> Do you think there is still risk?

Well it's non zero since spec says such a write should disable all
accesses. Just an idea: why not add an option to disable upper 32 bit?
That is ugly and limits space but spec compliant.

> > 
> > Given upstream is dragging it's feet I'm open to adding a flag that will help
> > keep guests going as a temporary measure.
> > We will need to think about ways to restrict this as much as we can.
> > 
> > 
> > > ---
> > >  hw/pci/pci.c        | 6 ++++--
> > >  hw/pci/pci_bridge.c | 8 +++++---
> > >  2 files changed, 9 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c index 56b13b3..ef368e1 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -1361,6 +1361,7 @@ void pci_default_write_config(PCIDevice *d,
> > > uint32_t addr, uint32_t val_in, int  {
> > >      int i, was_irq_disabled = pci_irq_disabled(d);
> > >      uint32_t val = val_in;
> > > +    uint64_t barmask = (1 << l*8) - 1;
> > >
> > >      for (i = 0; i < l; val >>= 8, ++i) {
> > >          uint8_t wmask = d->wmask[addr + i]; @@ -1369,9 +1370,10 @@
> > > void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in,
> > int
> > >          d->config[addr + i] = (d->config[addr + i] & ~wmask) | (val & wmask);
> > >          d->config[addr + i] &= ~(val & w1cmask); /* W1C: Write 1 to Clear */
> > >      }
> > > -    if (ranges_overlap(addr, l, PCI_BASE_ADDRESS_0, 24) ||
> > > +    if ((val_in != barmask &&
> > > +	(ranges_overlap(addr, l, PCI_BASE_ADDRESS_0, 24) ||
> > >          ranges_overlap(addr, l, PCI_ROM_ADDRESS, 4) ||
> > > -        ranges_overlap(addr, l, PCI_ROM_ADDRESS1, 4) ||
> > > +        ranges_overlap(addr, l, PCI_ROM_ADDRESS1, 4))) ||
> > >          range_covers_byte(addr, l, PCI_COMMAND))
> > >          pci_update_mappings(d);
> > >
> > > diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c index
> > > ee9dff2..f2bad79 100644
> > > --- a/hw/pci/pci_bridge.c
> > > +++ b/hw/pci/pci_bridge.c
> > > @@ -253,17 +253,19 @@ void pci_bridge_write_config(PCIDevice *d,
> > >      PCIBridge *s = PCI_BRIDGE(d);
> > >      uint16_t oldctl = pci_get_word(d->config + PCI_BRIDGE_CONTROL);
> > >      uint16_t newctl;
> > > +    uint64_t barmask = (1 << len * 8) - 1;
> > >
> > >      pci_default_write_config(d, address, val, len);
> > >
> > >      if (ranges_overlap(address, len, PCI_COMMAND, 2) ||
> > >
> > > -        /* io base/limit */
> > > -        ranges_overlap(address, len, PCI_IO_BASE, 2) ||
> > > +        (val != barmask &&
> > > +	/* io base/limit */
> > > +        (ranges_overlap(address, len, PCI_IO_BASE, 2) ||
> > >
> > >          /* memory base/limit, prefetchable base/limit and
> > >             io base/limit upper 16 */
> > > -        ranges_overlap(address, len, PCI_MEMORY_BASE, 20) ||
> > > +        ranges_overlap(address, len, PCI_MEMORY_BASE, 20))) ||
> > >
> > >          /* vga enable */
> > >          ranges_overlap(address, len, PCI_BRIDGE_CONTROL, 2)) {
> > > --
> > > 1.8.3.1
> > >
> > >
> > >

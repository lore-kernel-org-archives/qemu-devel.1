Received: from eggs.gnu.org ([2001:4830:134:3::10]:51829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dbEcC-00048M-Vr
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dbEc8-0006pq-Pt
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:24:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dbEc8-0006oh-Gr
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:24:12 -0400
Date: Sat, 29 Jul 2017 02:24:06 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170729021537-mutt-send-email-mst@kernel.org>
References: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
	<1500761743-1669-6-git-send-email-zuban32s@gmail.com>
	<20170723055006-mutt-send-email-mst@kernel.org>
	<b566a69d-a977-bf9f-d567-b742d400b288@redhat.com>
	<20170724234353-mutt-send-email-mst@kernel.org>
	<CAKSfGUAs8Ru-wuuHXK-mHir0_Hj8NenoKxuXyDqVt1YXOZUHAw@mail.gmail.com>
	<20170725005027-mutt-send-email-mst@kernel.org>
	<b36116e5-15fe-ffdd-7e4f-0f35078f95e9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b36116e5-15fe-ffdd-7e4f-0f35078f95e9@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 5/6] hw/pci: add bus_reserve
 property to pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Alexander Bezzubikov <zuban32s@gmail.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, seabios@seabios.org

On Tue, Jul 25, 2017 at 02:49:49PM +0300, Marcel Apfelbaum wrote:
> On 25/07/2017 0:58, Michael S. Tsirkin wrote:
> > On Tue, Jul 25, 2017 at 12:41:12AM +0300, Alexander Bezzubikov wrote:
> > > 2017-07-24 23:46 GMT+03:00 Michael S. Tsirkin <mst@redhat.com>:
> > > > On Sun, Jul 23, 2017 at 05:13:11PM +0300, Marcel Apfelbaum wrote:
> > > > > On 23/07/2017 15:22, Michael S. Tsirkin wrote:
> > > > > > On Sun, Jul 23, 2017 at 01:15:42AM +0300, Aleksandr Bezzubikov wrote:
> > > > > > > To enable hotplugging of a newly created pcie-pci-bridge,
> > > > > > > we need to tell firmware (SeaBIOS in this case)
> > > > > > 
> > > > > 
> > > > > Hi Michael,
> > > > > 
> > > > > > Presumably, EFI would need to support this too?
> > > > > > 
> > > > > 
> > > > > Sure, Eduardo added to CC, but he is in PTO now.
> > > > > 
> > > > > > > to reserve
> > > > > > > additional buses for pcie-root-port, that allows us to
> > > > > > > hotplug pcie-pci-bridge into this root port.
> > > > > > > The number of buses to reserve is provided to the device via a corresponding
> > > > > > > property, and to the firmware via new PCI capability (next patch).
> > > > > > > The property's default value is 1 as we want to hotplug at least 1 bridge.
> > > > > > 
> > > > > > If so you should just teach firmware to allocate one bus #
> > > > > > unconditionally.
> > > > > > 
> > > > > 
> > > > > That would be a problem for the PCIe machines, since each PCIe
> > > > > devices is plugged in a different bus and we are already
> > > > > limited to 256 PCIe devices. Allocating an extra-bus always
> > > > > would really limit the PCIe devices we can use.
> > > > 
> > > > But this is exactly what this patch does as the property is added to all
> > > > buses and default to 1 (1 extra bus).
> > > > 
> > > > > > But why would that be so? What's wrong with a device
> > > > > > directly in the root port?
> > > > > > 
> > > > > 
> > > > > First, plugging a legacy PCI device into a PCIe Root Port
> > > > > looks strange at least, and it can;t be done on real HW anyway.
> > > > > (incompatible slots)
> > > > 
> > > > You can still plug in PCIe devices there.
> > > > 
> > > > > Second (and more important), if we want 2 or more PCI
> > > > > devices we would loose both IO ports space and bus numbers.
> > > > 
> > > > What I am saying is maybe default should not be 1.
> > > 
> 
> Hi Michael, Alexander
> 
> > > The only sensible variant left is 0.
> > > But as we want pcie-pci-bridge to be used for every legacy PCI device
> > > on q35 machine, every time one hotplugs the bridge into the root port,
> > > he must be sure rp's prop value >0 (for Linux). I'm not sure
> > > that it is a very convenient way to utilize the bridge - always remember
> > > to set property.
> > 
> 
> Is not for Linux only, is for all guest OSes.
> I also think setting the property is OK, libvirt can always
> add a single PCIe Root Port port with this property set,
> while upper layers can create flavors (if the feature needed
> or not for the current setup)

If you are going to always do this, it kind of looks like
Laszlo's idea of always cold-plugging a pci bridge.

> > That's what I'm saying then - if in your opinion default is >0 anyway,
> > tweak firmware to do it by default.
> > 
> 
> Default should be 0 for sure - because of the hard limitation
> on the number of PCIe devices for single PCI domain (the same
> as the number of buses, 256).
> 
> For a positive value we will should add a property "buses-reserve = x".

So value here is borderline but if it includes other resources
then value seems clearer.

> > > Another way - we can set this to 0 by default, and to 1 for pcie-root-port,
> > > and recommend to use it for hotplugging of the pcie-pci-bridge itself.
> > 
> > I wonder about something: imagine hotplugging a hierarchy of bridges
> > below a root port. It seems that nothing prevents guest from finding a
> > free range of buses to cover this hierarchy and setting that as
> > secondary/subordinate bus for this bridge.
> >  > This does need support on QEMU side to hotplug a hierarchy at once,
> > and might need some fixes in Linux, on the plus side you can defer
> > management decision on how many are needed until you are actually
> > adding something, and you don't need vendor specific patches.
> > 
> 
> We can teach Linux kernel, that's for sure (OK, almost sure...)
> but what we don't want is to be dependent on specific guest Operating
> Systems. For example, most configurations are not supported
> by Windows guests.

If you fix Linux then windows will not want to be left behind
and will implement this too.

> Also is a great opportunity adding PCI IO resources hints
> to guest FW, something we wanted to do for some time.
> 
> Thanks,
> Marcel

I agree, it's a good reason to add this capability.

> > 
> > > > 
> > > > > > 
> > > > > > > 
> > > > > > > Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> > > > > > > ---
> > > > > > >    hw/pci-bridge/pcie_root_port.c | 1 +
> > > > > > >    include/hw/pci/pcie_port.h     | 3 +++
> > > > > > >    2 files changed, 4 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
> > > > > > > index 4d588cb..b0e49e1 100644
> > > > > > > --- a/hw/pci-bridge/pcie_root_port.c
> > > > > > > +++ b/hw/pci-bridge/pcie_root_port.c
> > > > > > > @@ -137,6 +137,7 @@ static void rp_exit(PCIDevice *d)
> > > > > > >    static Property rp_props[] = {
> > > > > > >        DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
> > > > > > >                        QEMU_PCIE_SLTCAP_PCP_BITNR, true),
> > > > > > > +    DEFINE_PROP_UINT8("bus_reserve", PCIEPort, bus_reserve, 1),
> > > > > > >        DEFINE_PROP_END_OF_LIST()
> > > > > > >    };
> > > > > > > diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
> > > > > > > index 1333266..1b2dd1f 100644
> > > > > > > --- a/include/hw/pci/pcie_port.h
> > > > > > > +++ b/include/hw/pci/pcie_port.h
> > > > > > > @@ -34,6 +34,9 @@ struct PCIEPort {
> > > > > > >        /* pci express switch port */
> > > > > > >        uint8_t     port;
> > > > > > > +
> > > > > > > +    /* additional buses to reserve on firmware init */
> > > > > > > +    uint8_t     bus_reserve;
> > > > > > >    };
> > > > > > >    void pcie_port_init_reg(PCIDevice *d);
> > > > > > 
> > > > > > So here is a property and it does not do anything.
> > > > > > It makes it easier to work on series maybe, but review
> > > > > > is harder since we do not see what it does at all.
> > > > > > Please do not split up patches like this - you can maintain
> > > > > > it split up in your branch if you like and merge before sending.
> > > > > > 
> > > > > 
> > > > > Agreed, Alexandr please merge patches 4-5-6 for your next submission.
> > > > > 
> > > > > Thanks,
> > > > > Marcel
> > > > > 
> > > > > 
> > > > > > > --
> > > > > > > 2.7.4
> > > 
> > > 
> > > 
> > > -- 
> > > Alexander Bezzubikov

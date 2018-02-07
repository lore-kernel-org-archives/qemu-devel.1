Received: from eggs.gnu.org ([2001:4830:134:3::10]:42138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ejMSq-0000c4-C2
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 04:56:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ejMSl-0000nq-Cp
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 04:56:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56022 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ejMSl-0000mr-67
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 04:56:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 71CD08182D04
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 09:56:19 +0000 (UTC)
Date: Wed, 7 Feb 2018 09:56:04 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180207095603.GA2665@work-vm>
References: <20180206073933.4071-1-peterx@redhat.com>
	<20180206230447-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206230447-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v2] pci/bus: let it has higher migration
 priority
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, eric.auger@redhat.com
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Tue, Feb 06, 2018 at 03:39:33PM +0800, Peter Xu wrote:
> > In the past, we prioritized IOMMU migration so that we have such a
> > priority order:
> > 
> >     IOMMU > PCI Devices
> > 
> > When migrating a guest with both vIOMMU and a pcie-root-port, we'll
> > always migrate vIOMMU first, since pci buses will be seen to have the
> > same priority of general PCI devices.
> > 
> > That's problematic.
> > 
> > The thing is that PCI bus number information is stored in the root port,
> > and that is needed by vIOMMU during post_load(), e.g., to figure out
> > context entry for a device.  If we don't have correct bus numbers for
> > devices, we won't be able to recover device state of the DMAR memory
> > regions, and things will be messed up.
> > 
> > So let's boost the PCIe root ports to be even with higher priority:
> > 
> >    PCIe Root Port > IOMMU > PCI Devices
> > 
> > A smoke test shows that this patch fixes bug 1538953.
> > 
> > Also, apply this rule to all the PCI bus/bridge devices: ioh3420,
> > xio3130_downstream, xio3130_upstream, pcie_pci_bridge, pci-pci bridge,
> > i82801b11.
> > 
> > I noted that we set pcie_pci_bridge_dev_vmstate twice.  Clean that up
> > together.
> > 
> > CC: Alex Williamson <alex.williamson@redhat.com>
> > CC: Marcel Apfelbaum <marcel@redhat.com>
> > CC: Michael S. Tsirkin <mst@redhat.com>
> > CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > CC: Juan Quintela <quintela@redhat.com>
> > CC: Laurent Vivier <lvivier@redhat.com>
> > Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1538953
> > Reported-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> dgilbert, could you pls confirm this looks like a sane approach to you?

Yes it does, although a couple of (minor) thoughts:
    a) I'm a little confused whether this needs to apply to all PCI
busses (and hence why it's MIG_PRI_PCI_BUS) or only the root ports
    b) It's probably worth getting one of the Arm [e[;e tp check the
order relative to the GICV3 entries; cc'ing Eric.

Dave


> > ---
> > v2:
> > - add more devices that Marcel mentioned
> > - rename to MIG_PRI_PCI_BUS
> > - remove one useless line in existing code
> > ---
> >  hw/pci-bridge/gen_pcie_root_port.c | 1 +
> >  hw/pci-bridge/i82801b11.c          | 1 +
> >  hw/pci-bridge/ioh3420.c            | 1 +
> >  hw/pci-bridge/pci_bridge_dev.c     | 1 +
> >  hw/pci-bridge/pcie_pci_bridge.c    | 2 +-
> >  hw/pci-bridge/xio3130_downstream.c | 1 +
> >  hw/pci-bridge/xio3130_upstream.c   | 1 +
> >  include/migration/vmstate.h        | 1 +
> >  8 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> > index 0e2f2e8bf1..435fbaa60e 100644
> > --- a/hw/pci-bridge/gen_pcie_root_port.c
> > +++ b/hw/pci-bridge/gen_pcie_root_port.c
> > @@ -101,6 +101,7 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
> >  
> >  static const VMStateDescription vmstate_rp_dev = {
> >      .name = "pcie-root-port",
> > +    .priority = MIG_PRI_PCI_BUS,
> >      .version_id = 1,
> >      .minimum_version_id = 1,
> >      .post_load = pcie_cap_slot_post_load,
> > diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
> > index cb522bf30c..60df9b2c96 100644
> > --- a/hw/pci-bridge/i82801b11.c
> > +++ b/hw/pci-bridge/i82801b11.c
> > @@ -80,6 +80,7 @@ err_bridge:
> >  
> >  static const VMStateDescription i82801b11_bridge_dev_vmstate = {
> >      .name = "i82801b11_bridge",
> > +    .priority = MIG_PRI_PCI_BUS,
> >      .fields = (VMStateField[]) {
> >          VMSTATE_PCI_DEVICE(parent_obj, PCIBridge),
> >          VMSTATE_END_OF_LIST()
> > diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
> > index 5f56a2feb6..a7bfbdd238 100644
> > --- a/hw/pci-bridge/ioh3420.c
> > +++ b/hw/pci-bridge/ioh3420.c
> > @@ -83,6 +83,7 @@ static void ioh3420_interrupts_uninit(PCIDevice *d)
> >  
> >  static const VMStateDescription vmstate_ioh3420 = {
> >      .name = "ioh-3240-express-root-port",
> > +    .priority = MIG_PRI_PCI_BUS,
> >      .version_id = 1,
> >      .minimum_version_id = 1,
> >      .post_load = pcie_cap_slot_post_load,
> > diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
> > index d56f6638c2..b2d861d216 100644
> > --- a/hw/pci-bridge/pci_bridge_dev.c
> > +++ b/hw/pci-bridge/pci_bridge_dev.c
> > @@ -174,6 +174,7 @@ static bool pci_device_shpc_present(void *opaque, int version_id)
> >  
> >  static const VMStateDescription pci_bridge_dev_vmstate = {
> >      .name = "pci_bridge",
> > +    .priority = MIG_PRI_PCI_BUS,
> >      .fields = (VMStateField[]) {
> >          VMSTATE_PCI_DEVICE(parent_obj, PCIBridge),
> >          SHPC_VMSTATE(shpc, PCIDevice, pci_device_shpc_present),
> > diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
> > index a4d827c99d..e5ac7974cf 100644
> > --- a/hw/pci-bridge/pcie_pci_bridge.c
> > +++ b/hw/pci-bridge/pcie_pci_bridge.c
> > @@ -129,6 +129,7 @@ static Property pcie_pci_bridge_dev_properties[] = {
> >  
> >  static const VMStateDescription pcie_pci_bridge_dev_vmstate = {
> >          .name = TYPE_PCIE_PCI_BRIDGE_DEV,
> > +        .priority = MIG_PRI_PCI_BUS,
> >          .fields = (VMStateField[]) {
> >              VMSTATE_PCI_DEVICE(parent_obj, PCIBridge),
> >              SHPC_VMSTATE(shpc, PCIDevice, NULL),
> > @@ -178,7 +179,6 @@ static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
> >      k->config_write = pcie_pci_bridge_write_config;
> >      dc->vmsd = &pcie_pci_bridge_dev_vmstate;
> >      dc->props = pcie_pci_bridge_dev_properties;
> > -    dc->vmsd = &pcie_pci_bridge_dev_vmstate;
> >      dc->reset = &pcie_pci_bridge_reset;
> >      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> >      hc->plug = pcie_pci_bridge_hotplug_cb;
> > diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> > index 1e09d2afb7..4dd2e65118 100644
> > --- a/hw/pci-bridge/xio3130_downstream.c
> > +++ b/hw/pci-bridge/xio3130_downstream.c
> > @@ -161,6 +161,7 @@ static Property xio3130_downstream_props[] = {
> >  
> >  static const VMStateDescription vmstate_xio3130_downstream = {
> >      .name = "xio3130-express-downstream-port",
> > +    .priority = MIG_PRI_PCI_BUS,
> >      .version_id = 1,
> >      .minimum_version_id = 1,
> >      .post_load = pcie_cap_slot_post_load,
> > diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
> > index 227997ce46..c5f02a6ee8 100644
> > --- a/hw/pci-bridge/xio3130_upstream.c
> > +++ b/hw/pci-bridge/xio3130_upstream.c
> > @@ -133,6 +133,7 @@ PCIEPort *xio3130_upstream_init(PCIBus *bus, int devfn, bool multifunction,
> >  
> >  static const VMStateDescription vmstate_xio3130_upstream = {
> >      .name = "xio3130-express-upstream-port",
> > +    .priority = MIG_PRI_PCI_BUS,
> >      .version_id = 1,
> >      .minimum_version_id = 1,
> >      .fields = (VMStateField[]) {
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index 8c3889433c..df463fd33d 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -148,6 +148,7 @@ enum VMStateFlags {
> >  typedef enum {
> >      MIG_PRI_DEFAULT = 0,
> >      MIG_PRI_IOMMU,              /* Must happen before PCI devices */
> > +    MIG_PRI_PCI_BUS,            /* Must happen before IOMMU */
> >      MIG_PRI_GICV3_ITS,          /* Must happen before PCI devices */
> >      MIG_PRI_GICV3,              /* Must happen before the ITS */
> >      MIG_PRI_MAX,
> > -- 
> > 2.14.3
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

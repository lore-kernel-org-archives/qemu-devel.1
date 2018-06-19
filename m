Received: from eggs.gnu.org ([2001:4830:134:3::10]:48374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fVLUU-0000Ir-0p
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fVLUQ-00075l-02
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:36:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1fVLUP-000745-MF
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:36:25 -0400
Date: Tue, 19 Jun 2018 13:36:17 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
Message-ID: <20180619183617.GA14746@lt>
References: <20180619163228.13790-1-venu.busireddy@oracle.com>
	<20180619163228.13790-3-venu.busireddy@oracle.com>
	<20180619202118-mutt-send-email-mst@kernel.org>
	<20180619181406.GA14456@lt>
	<20180619211709-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619211709-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH 2/3] Add "Group
 Identifier" support to PCIe bridges.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On 2018-06-19 21:21:23 +0300, Michael S. Tsirkin wrote:
> On Tue, Jun 19, 2018 at 01:14:06PM -0500, Venu Busireddy wrote:
> > On 2018-06-19 20:24:12 +0300, Michael S. Tsirkin wrote:
> > > On Tue, Jun 19, 2018 at 11:32:26AM -0500, Venu Busireddy wrote:
> > > > Add a "Vendor-Specific" capability to the PCIe bridge, to contain the
> > > > "Group Identifier" (UUID) that will be used to pair a virtio device with
> > > > the passthrough device attached to that bridge.
> > > > 
> > > > This capability is added to the bridge iff the "uuid" option is specified
> > > > for the bridge device, via the qemu command line. Also, the bridge's
> > > > Device ID is changed to PCI_VENDOR_ID_REDHAT, and Vendor ID is changed
> > > > to PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE (from the default values), when the
> > > > "uuid" option is present.
> > > > 
> > > > Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
> > > 
> > > I don't see why we should add it to all bridges.
> > > Let's just add it to ones that already have the RH vendor ID?
> > 
> > No. I am not adding the capability to all bridges.
> > 
> > In the earlier discussions, we agreed that the bridge be left as
> > Intel bridge if we do not intend to use it for storing the pairing
> > information. If we do intend to store the pairing information in the
> > bridge, we wanted to change the bridge's Vendor ID to RH Vendor ID to
> > avoid confusion. In other words, bridge's with RH Vendor ID come into
> > existence only when there is an intent to store the pairing information
> > in the bridge.
> > 
> > Accordingly, if the "uuid" option is specified for the bridge, it
> > is assumed that the user intends to use the bridge for storing the
> > pairing information, and hence, the capability is added to the bridge,
> > and the Vendor ID is changed to RH Vendor ID. If the "uuid" option
> > is not specified, the bridge remains as Intel bridge, and without the
> > vendor-specific capability.
> > 
> > Venu
> 
> Yes but the way to do it is not to tweak the vendor and device ID,
> instead, just add the UUID property to bridges that already have the
> correct vendor and device id.

I was using ioh3420 as the bridge device, because that is what is
recommended here:

  https://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/pcie.txt;hb=HEAD

ioh3420 defaults to the Intel Vendor ID. Hence the tweak to change the
Vendor ID to RH Vendor ID.

Is there another bridge device other than ioh3420 that I should use?
what device do you suggest? 

Thanks,

Venu

> 
> 
> > > 
> > > 
> > > > ---
> > > >  hw/pci-bridge/ioh3420.c        |  2 ++
> > > >  hw/pci-bridge/pcie_root_port.c |  7 +++++++
> > > >  hw/pci/pci_bridge.c            | 32 ++++++++++++++++++++++++++++++++
> > > >  include/hw/pci/pci.h           |  2 ++
> > > >  include/hw/pci/pcie.h          |  1 +
> > > >  include/hw/pci/pcie_port.h     |  1 +
> > > >  6 files changed, 45 insertions(+)
> > > > 
> > > > diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
> > > > index a451d74ee6..b6b9ebc726 100644
> > > > --- a/hw/pci-bridge/ioh3420.c
> > > > +++ b/hw/pci-bridge/ioh3420.c
> > > > @@ -35,6 +35,7 @@
> > > >  #define IOH_EP_MSI_SUPPORTED_FLAGS      PCI_MSI_FLAGS_MASKBIT
> > > >  #define IOH_EP_MSI_NR_VECTOR            2
> > > >  #define IOH_EP_EXP_OFFSET               0x90
> > > > +#define IOH_EP_VENDOR_OFFSET            0xCC
> > > >  #define IOH_EP_AER_OFFSET               0x100
> > > >  
> > > >  /*
> > > > @@ -111,6 +112,7 @@ static void ioh3420_class_init(ObjectClass *klass, void *data)
> > > >      rpc->exp_offset = IOH_EP_EXP_OFFSET;
> > > >      rpc->aer_offset = IOH_EP_AER_OFFSET;
> > > >      rpc->ssvid_offset = IOH_EP_SSVID_OFFSET;
> > > > +    rpc->vendor_offset = IOH_EP_VENDOR_OFFSET;
> > > >      rpc->ssid = IOH_EP_SSVID_SSID;
> > > >  }
> > > >  
> > > > diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
> > > > index 45f9e8cd4a..ba470c7fda 100644
> > > > --- a/hw/pci-bridge/pcie_root_port.c
> > > > +++ b/hw/pci-bridge/pcie_root_port.c
> > > > @@ -71,6 +71,12 @@ static void rp_realize(PCIDevice *d, Error **errp)
> > > >          goto err_bridge;
> > > >      }
> > > >  
> > > > +    rc = pci_bridge_vendor_init(d, rpc->vendor_offset, errp);
> > > > +    if (rc < 0) {
> > > > +        error_append_hint(errp, "Can't init group ID, error %d\n", rc);
> > > > +        goto err_bridge;
> > > > +    }
> > > > +
> > > >      if (rpc->interrupts_init) {
> > > >          rc = rpc->interrupts_init(d, errp);
> > > >          if (rc < 0) {
> > > > @@ -137,6 +143,7 @@ static void rp_exit(PCIDevice *d)
> > > >  static Property rp_props[] = {
> > > >      DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
> > > >                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
> > > > +    DEFINE_PROP_UUID(COMPAT_PROP_UUID, PCIDevice, uuid, false),
> > > >      DEFINE_PROP_END_OF_LIST()
> > > >  };
> > > >  
> > > > diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> > > > index 40a39f57cb..c63bc439f7 100644
> > > > --- a/hw/pci/pci_bridge.c
> > > > +++ b/hw/pci/pci_bridge.c
> > > > @@ -34,12 +34,17 @@
> > > >  #include "hw/pci/pci_bus.h"
> > > >  #include "qemu/range.h"
> > > >  #include "qapi/error.h"
> > > > +#include "qemu/uuid.h"
> > > >  
> > > >  /* PCI bridge subsystem vendor ID helper functions */
> > > >  #define PCI_SSVID_SIZEOF        8
> > > >  #define PCI_SSVID_SVID          4
> > > >  #define PCI_SSVID_SSID          6
> > > >  
> > > > +#define PCI_VENDOR_SIZEOF             20
> > > > +#define PCI_VENDOR_CAP_LEN_OFFSET      2
> > > > +#define PCI_VENDOR_GROUP_ID_OFFSET     4
> > > > +
> > > >  int pci_bridge_ssvid_init(PCIDevice *dev, uint8_t offset,
> > > >                            uint16_t svid, uint16_t ssid,
> > > >                            Error **errp)
> > > > @@ -57,6 +62,33 @@ int pci_bridge_ssvid_init(PCIDevice *dev, uint8_t offset,
> > > >      return pos;
> > > >  }
> > > >  
> > > > +int pci_bridge_vendor_init(PCIDevice *d, uint8_t offset, Error **errp)
> > > > +{
> > > > +    int pos;
> > > > +    PCIDeviceClass *dc = PCI_DEVICE_GET_CLASS(d);
> > > > +
> > > > +    if (qemu_uuid_is_null(&d->uuid)) {
> > > > +        return 0;
> > > > +    }
> > > > +
> > > > +    pos = pci_add_capability(d, PCI_CAP_ID_VNDR, offset, PCI_VENDOR_SIZEOF,
> > > > +            errp);
> > > > +    if (pos < 0) {
> > > > +        return pos;
> > > > +    }
> > > > +
> > > > +    dc->vendor_id = PCI_VENDOR_ID_REDHAT;
> > > > +    dc->device_id = PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE;
> > > > +    pci_set_word(d->config + PCI_VENDOR_ID, PCI_VENDOR_ID_REDHAT);
> > > > +    pci_set_word(d->config + PCI_DEVICE_ID, PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE);
> > > > +
> > > > +    pci_set_word(d->config + pos + PCI_VENDOR_CAP_LEN_OFFSET,
> > > > +            PCI_VENDOR_SIZEOF);
> > > > +    memcpy(d->config + offset + PCI_VENDOR_GROUP_ID_OFFSET, &d->uuid,
> > > > +            sizeof(QemuUUID));
> > > > +    return pos;
> > > > +}
> > > > +
> > > >  /* Accessor function to get parent bridge device from pci bus. */
> > > >  PCIDevice *pci_bridge_get_device(PCIBus *bus)
> > > >  {
> > > > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > > > index 990d6fcbde..ee234c5a6f 100644
> > > > --- a/include/hw/pci/pci.h
> > > > +++ b/include/hw/pci/pci.h
> > > > @@ -4,6 +4,7 @@
> > > >  #include "hw/qdev.h"
> > > >  #include "exec/memory.h"
> > > >  #include "sysemu/dma.h"
> > > > +#include "qemu/uuid.h"
> > > >  
> > > >  /* PCI includes legacy ISA access.  */
> > > >  #include "hw/isa/isa.h"
> > > > @@ -343,6 +344,7 @@ struct PCIDevice {
> > > >      bool has_rom;
> > > >      MemoryRegion rom;
> > > >      uint32_t rom_bar;
> > > > +    QemuUUID uuid;
> > > >  
> > > >      /* INTx routing notifier */
> > > >      PCIINTxRoutingNotifier intx_routing_notifier;
> > > > diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> > > > index b71e369703..b4189d0ce3 100644
> > > > --- a/include/hw/pci/pcie.h
> > > > +++ b/include/hw/pci/pcie.h
> > > > @@ -82,6 +82,7 @@ struct PCIExpressDevice {
> > > >  };
> > > >  
> > > >  #define COMPAT_PROP_PCP "power_controller_present"
> > > > +#define COMPAT_PROP_UUID "uuid"
> > > >  
> > > >  /* PCI express capability helper functions */
> > > >  int pcie_cap_init(PCIDevice *dev, uint8_t offset, uint8_t type,
> > > > diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
> > > > index 0736014bfd..40db6dbbe7 100644
> > > > --- a/include/hw/pci/pcie_port.h
> > > > +++ b/include/hw/pci/pcie_port.h
> > > > @@ -74,6 +74,7 @@ typedef struct PCIERootPortClass {
> > > >      int exp_offset;
> > > >      int aer_offset;
> > > >      int ssvid_offset;
> > > > +    int vendor_offset;
> > > >      int ssid;
> > > >  } PCIERootPortClass;
> > > >  
> > > 
> > > ---------------------------------------------------------------------
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > > 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fYS0Z-0004nB-Sb
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fYS0Y-0001KM-0u
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:10:27 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:38790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <loseweigh@gmail.com>) id 1fYS0X-0001Jv-Qg
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:10:25 -0400
Received: by mail-it0-x242.google.com with SMTP id v83-v6so11231949itc.3
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 01:10:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180628045539-mutt-send-email-mst@kernel.org>
References: <20180627034935.20276-1-venu.busireddy@oracle.com>
	<20180627034935.20276-4-venu.busireddy@oracle.com>
	<20180627065943-mutt-send-email-mst@kernel.org>
	<20180627040812.GA20446@troi> <20180627230758.GA14856@vbusired-vm>
	<20180628045539-mutt-send-email-mst@kernel.org>
From: Siwei Liu <loseweigh@gmail.com>
Date: Thu, 28 Jun 2018 01:10:24 -0700
Message-ID: <CADGSJ23AV1p39Wfid1MWUbq=puZz2r_2ScXko0GDuJ3Y8Gm=Gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v2 3/4] Add "Group
 Identifier" support to Red Hat PCI bridge.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Wed, Jun 27, 2018 at 7:14 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Jun 27, 2018 at 06:07:59PM -0500, Venu Busireddy wrote:
>> On 2018-06-26 23:08:12 -0500, Venu Busireddy wrote:
>> > On 2018-06-27 07:02:36 +0300, Michael S. Tsirkin wrote:
>> > > On Tue, Jun 26, 2018 at 10:49:33PM -0500, Venu Busireddy wrote:
>> > > > Add the "Vendor-Specific" capability to the Red Hat PCI bridge device
>> > > > "pci-bridge", to contain the "Group Identifier" (UUID) that will be
>> > > > used to pair a virtio device with the passthrough device attached to
>> > > > that bridge.
>> > > >
>> > > > This capability is added to the bridge iff the "uuid" option is specified
>> > > > for the bridge.
>> > >
>> > > I think the name should be more explicit. How about "failover-group-id"?
>> >
>> > I can change it. But don't you think it is bit long?
>> >
>> > > >
>> > > > Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
>> > >
>> > > I'd like to also tweak the device id in this case,
>> > > to make it easier for guests to know it's a grouping bridge.
>> >
>> > Could you please recommend a name for the new ID'd definition? Something
>> > in lines of PCI_DEVICE_ID_REDHAT_<blah blah>.
>>
>> How about these names and values for the device IDs?
>>
>>   PCI_DEVICE_ID_REDHAT_PCI_BRIDGE_GRP (0x0010) for pci-bridge, and
>
> You do not need the second PCI, and group is one of the
> functions of bridge anyway.
>
> PCI_DEVICE_ID_REDHAT_BRIDGE_FAILOVER?
>
>
>>   PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE_GRP (0x0011) for pcie-downstream
>>
>> Thanks,
>>
>> Venu
>
> PCI_DEVICE_ID_REDHAT_DOWNPORT_FAILOVER?
>
>
> It's becoming annoying though - we'll need one for each type :(
>
> Ideas/options:
> - use revision ID to distinguish from regular bridge
> - use device serial # cap for the bridge when it's an express device
>
IMO, from guest implementation point of view, it would be the best to
use a single consistent mechanism all across. The serial number cap is
too PCIE specific.

-Siwei

>
>> > > > ---
>> > > >  hw/pci-bridge/pci_bridge_dev.c |  8 ++++++++
>> > > >  hw/pci/pci_bridge.c            | 26 ++++++++++++++++++++++++++
>> > > >  include/hw/pci/pcie.h          |  1 +
>> > > >  3 files changed, 35 insertions(+)
>> > > >
>> > > > diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
>> > > > index b2d861d216..bbbc6fa1c6 100644
>> > > > --- a/hw/pci-bridge/pci_bridge_dev.c
>> > > > +++ b/hw/pci-bridge/pci_bridge_dev.c
>> > > > @@ -71,6 +71,12 @@ static void pci_bridge_dev_realize(PCIDevice *dev, Error **errp)
>> > > >          bridge_dev->msi = ON_OFF_AUTO_OFF;
>> > > >      }
>> > > >
>> > > > +    err = pci_bridge_vendor_init(dev, 0, errp);
>> > > > +    if (err < 0) {
>> > > > +        error_append_hint(errp, "Can't init group ID, error %d\n", err);
>> > > > +        goto vendor_cap_err;
>> > > > +    }
>> > > > +
>> > > >      err = slotid_cap_init(dev, 0, bridge_dev->chassis_nr, 0, errp);
>> > > >      if (err) {
>> > > >          goto slotid_error;
>> > > > @@ -109,6 +115,7 @@ slotid_error:
>> > > >      if (shpc_present(dev)) {
>> > > >          shpc_cleanup(dev, &bridge_dev->bar);
>> > > >      }
>> > > > +vendor_cap_err:
>> > > >  shpc_error:
>> > > >      pci_bridge_exitfn(dev);
>> > > >  }
>> > > > @@ -162,6 +169,7 @@ static Property pci_bridge_dev_properties[] = {
>> > > >                              ON_OFF_AUTO_AUTO),
>> > > >      DEFINE_PROP_BIT(PCI_BRIDGE_DEV_PROP_SHPC, PCIBridgeDev, flags,
>> > > >                      PCI_BRIDGE_DEV_F_SHPC_REQ, true),
>> > > > +    DEFINE_PROP_UUID(COMPAT_PROP_UUID, PCIDevice, uuid, false),
>> > > >      DEFINE_PROP_END_OF_LIST(),
>> > > >  };
>> > > >
>> > > > diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
>> > > > index 40a39f57cb..cb8b3dad2a 100644
>> > > > --- a/hw/pci/pci_bridge.c
>> > > > +++ b/hw/pci/pci_bridge.c
>> > > > @@ -34,12 +34,17 @@
>> > > >  #include "hw/pci/pci_bus.h"
>> > > >  #include "qemu/range.h"
>> > > >  #include "qapi/error.h"
>> > > > +#include "qemu/uuid.h"
>> > > >
>> > > >  /* PCI bridge subsystem vendor ID helper functions */
>> > > >  #define PCI_SSVID_SIZEOF        8
>> > > >  #define PCI_SSVID_SVID          4
>> > > >  #define PCI_SSVID_SSID          6
>> > > >
>> > > > +#define PCI_VENDOR_SIZEOF             20
>> > > > +#define PCI_VENDOR_CAP_LEN_OFFSET      2
>> > > > +#define PCI_VENDOR_GROUP_ID_OFFSET     4
>> > > > +
>> > > >  int pci_bridge_ssvid_init(PCIDevice *dev, uint8_t offset,
>> > > >                            uint16_t svid, uint16_t ssid,
>> > > >                            Error **errp)
>> > > > @@ -57,6 +62,27 @@ int pci_bridge_ssvid_init(PCIDevice *dev, uint8_t offset,
>> > > >      return pos;
>> > > >  }
>> > > >
>> > > > +int pci_bridge_vendor_init(PCIDevice *d, uint8_t offset, Error **errp)
>> > > > +{
>> > > > +    int pos;
>> > > > +
>> > > > +    if (qemu_uuid_is_null(&d->uuid)) {
>> > > > +        return 0;
>> > > > +    }
>> > > > +
>> > > > +    pos = pci_add_capability(d, PCI_CAP_ID_VNDR, offset, PCI_VENDOR_SIZEOF,
>> > > > +            errp);
>> > > > +    if (pos < 0) {
>> > > > +        return pos;
>> > > > +    }
>> > > > +
>> > > > +    pci_set_word(d->config + pos + PCI_VENDOR_CAP_LEN_OFFSET,
>> > > > +            PCI_VENDOR_SIZEOF);
>> > > > +    memcpy(d->config + pos + PCI_VENDOR_GROUP_ID_OFFSET, &d->uuid,
>> > > > +            sizeof(QemuUUID));
>> > > > +    return pos;
>> > > > +}
>> > > > +
>> > > >  /* Accessor function to get parent bridge device from pci bus. */
>> > > >  PCIDevice *pci_bridge_get_device(PCIBus *bus)
>> > > >  {
>> > > > diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
>> > > > index b71e369703..b4189d0ce3 100644
>> > > > --- a/include/hw/pci/pcie.h
>> > > > +++ b/include/hw/pci/pcie.h
>> > > > @@ -82,6 +82,7 @@ struct PCIExpressDevice {
>> > > >  };
>> > > >
>> > > >  #define COMPAT_PROP_PCP "power_controller_present"
>> > > > +#define COMPAT_PROP_UUID "uuid"
>> > > >
>> > > >  /* PCI express capability helper functions */
>> > > >  int pcie_cap_init(PCIDevice *dev, uint8_t offset, uint8_t type,
>> > >
>> > > ---------------------------------------------------------------------
>> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>> > >
>> >
>> > ---------------------------------------------------------------------
>> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>> >
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

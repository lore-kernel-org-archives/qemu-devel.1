Received: from eggs.gnu.org ([2001:4830:134:3::10]:45016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cRlkd-0007on-FM
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cRlkZ-00035S-Kz
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:13:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cRlkZ-00034o-BA
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:13:31 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BC8D80F8F
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 20:13:31 +0000 (UTC)
Date: Thu, 12 Jan 2017 22:13:30 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170112220552-mutt-send-email-mst@kernel.org>
References: <20161214195829.18241-1-dgilbert@redhat.com>
	<20161216011806-mutt-send-email-mst@kernel.org>
	<20161216093527.GB2642@work-vm>
	<20170110053420-mutt-send-email-mst@kernel.org>
	<20170112172739.GF2513@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170112172739.GF2513@work-vm>
Subject: Re: [Qemu-devel] [RFC] PCI/migration merge vmstate_pci_device and
 vmstate_pcie_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, quintela@redhat.com, amit.shah@redhat.com

On Thu, Jan 12, 2017 at 05:27:40PM +0000, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Fri, Dec 16, 2016 at 09:35:28AM +0000, Dr. David Alan Gilbert wrote:
> > > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > > On Wed, Dec 14, 2016 at 07:58:29PM +0000, Dr. David Alan Gilbert (git) wrote:
> > > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > > 
> > > > > The vmstate_pci_device and vmstate_pcie_devices differ
> > > > > just in the size of one buffer; combine the two using a _TEST
> > > > > macro.
> > > > > 
> > > > > I think this is safe as long as everywhere which currently
> > > > > uses either of these two uses the right type.
> > > > > 
> > > > > One thing that concerns me is that some places use pci_device_load/save
> > > > > which does some irq mangling, but others just use the VMSTATE_PCI_DEVICE
> > > > > macro - how are they getting the same irq mangling?
> > > > > 
> > > > > This passes a smoke test migrate of:
> > > > > ./x86_64-softmmu/qemu-system-x86_64 -M pc,accel=kvm -m 1024
> > > > > ./littlefed20.img -device e1000e -device virtio-net -device
> > > > > e1000 -device virtio-rng -device megasas -device megasas-gen2 -device
> > > > > ioh3420 -device nec-usb-xhci
> > > > > 
> > > > > to an unmodified qemu.
> > > > > 
> > > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > 
> > > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > > 
> > > > feel free to merge through migration tree.
> > > 
> > > Thanks!
> > > What about my related question about the difference between pci_device_load/save
> > > with respect to the irq mangling it does?
> > > 
> > > Dave
> > 
> > Do you mean pci_update_irq_status?
> > 
> > All this saving/clearing is for compatibility with
> > old code which didn't set/clear it properly.
> > I would not be too surprised if that compatibility
> > just got broken at some point ...
> 
> Yes, there's pci_update_irq_status in both pci_device_save and pci_device_load,
> but also the commented code in pci_device_save that does:
>    s->config[PCI_STATUS] &= ~PCI_STATUS_INTERRUPT;
> 
> when is it safe to replace a pci_device_load/save by the use
> of the VMSTATE_PCI_DEVICE macro?
> I see the save only in virtio-pci.c,
> all the other files that use it only use it in compatibility code.
> 
> Dave

Basically if you don't care about compatilibity with
qemu before f9bf77dd1f838b0061172fe41709b221956da2f5
(that is 0.11 and 0.10) then you can use it.

You need pci_update_irq_status on load and
s->config[PCI_STATUS] &= ~PCI_STATUS_INTERRUPT on save
for 0.11 and 0.10 machine types.

Maybe just teach VMSTATE_PCI_DEVICE about these old
machine types?

> > 
> > 
> > > > > ---
> > > > >  hw/net/e1000e.c                    |  2 +-
> > > > >  hw/net/vmxnet3.c                   |  2 +-
> > > > >  hw/pci-bridge/ioh3420.c            |  2 +-
> > > > >  hw/pci-bridge/xio3130_downstream.c |  2 +-
> > > > >  hw/pci-bridge/xio3130_upstream.c   |  2 +-
> > > > >  hw/pci/pci.c                       | 41 +++++++++++++++++---------------------
> > > > >  hw/scsi/megasas.c                  |  2 +-
> > > > >  hw/scsi/vmw_pvscsi.c               |  2 +-
> > > > >  hw/usb/hcd-xhci.c                  |  2 +-
> > > > >  include/hw/pci/pcie.h              | 10 ----------
> > > > >  10 files changed, 26 insertions(+), 41 deletions(-)
> > > > > 
> > > > > diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> > > > > index 4994e1c..463ac9b 100644
> > > > > --- a/hw/net/e1000e.c
> > > > > +++ b/hw/net/e1000e.c
> > > > > @@ -592,7 +592,7 @@ static const VMStateDescription e1000e_vmstate = {
> > > > >      .pre_save = e1000e_pre_save,
> > > > >      .post_load = e1000e_post_load,
> > > > >      .fields = (VMStateField[]) {
> > > > > -        VMSTATE_PCIE_DEVICE(parent_obj, E1000EState),
> > > > > +        VMSTATE_PCI_DEVICE(parent_obj, E1000EState),
> > > > >          VMSTATE_MSIX(parent_obj, E1000EState),
> > > > >  
> > > > >          VMSTATE_UINT32(ioaddr, E1000EState),
> > > > > diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> > > > > index bbb898b..86cded9 100644
> > > > > --- a/hw/net/vmxnet3.c
> > > > > +++ b/hw/net/vmxnet3.c
> > > > > @@ -2538,7 +2538,7 @@ static const VMStateDescription vmstate_vmxnet3_pcie_device = {
> > > > >      .minimum_version_id = 1,
> > > > >      .needed = vmxnet3_vmstate_need_pcie_device,
> > > > >      .fields = (VMStateField[]) {
> > > > > -        VMSTATE_PCIE_DEVICE(parent_obj, VMXNET3State),
> > > > > +        VMSTATE_PCI_DEVICE(parent_obj, VMXNET3State),
> > > > >          VMSTATE_END_OF_LIST()
> > > > >      }
> > > > >  };
> > > > > diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
> > > > > index c8b5ac4..98114e1 100644
> > > > > --- a/hw/pci-bridge/ioh3420.c
> > > > > +++ b/hw/pci-bridge/ioh3420.c
> > > > > @@ -178,7 +178,7 @@ static const VMStateDescription vmstate_ioh3420 = {
> > > > >      .minimum_version_id = 1,
> > > > >      .post_load = pcie_cap_slot_post_load,
> > > > >      .fields = (VMStateField[]) {
> > > > > -        VMSTATE_PCIE_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
> > > > > +        VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
> > > > >          VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
> > > > >                         PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
> > > > >          VMSTATE_END_OF_LIST()
> > > > > diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> > > > > index cef6e13..4c54301 100644
> > > > > --- a/hw/pci-bridge/xio3130_downstream.c
> > > > > +++ b/hw/pci-bridge/xio3130_downstream.c
> > > > > @@ -164,7 +164,7 @@ static const VMStateDescription vmstate_xio3130_downstream = {
> > > > >      .minimum_version_id = 1,
> > > > >      .post_load = pcie_cap_slot_post_load,
> > > > >      .fields = (VMStateField[]) {
> > > > > -        VMSTATE_PCIE_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
> > > > > +        VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
> > > > >          VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
> > > > >                         PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
> > > > >          VMSTATE_END_OF_LIST()
> > > > > diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
> > > > > index 4ad0440..45dbd1c 100644
> > > > > --- a/hw/pci-bridge/xio3130_upstream.c
> > > > > +++ b/hw/pci-bridge/xio3130_upstream.c
> > > > > @@ -136,7 +136,7 @@ static const VMStateDescription vmstate_xio3130_upstream = {
> > > > >      .version_id = 1,
> > > > >      .minimum_version_id = 1,
> > > > >      .fields = (VMStateField[]) {
> > > > > -        VMSTATE_PCIE_DEVICE(parent_obj.parent_obj, PCIEPort),
> > > > > +        VMSTATE_PCI_DEVICE(parent_obj.parent_obj, PCIEPort),
> > > > >          VMSTATE_STRUCT(parent_obj.parent_obj.exp.aer_log, PCIEPort, 0,
> > > > >                         vmstate_pcie_aer_log, PCIEAERLog),
> > > > >          VMSTATE_END_OF_LIST()
> > > > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > > > index 16df188..8e4226b 100644
> > > > > --- a/hw/pci/pci.c
> > > > > +++ b/hw/pci/pci.c
> > > > > @@ -542,30 +542,29 @@ static VMStateInfo vmstate_info_pci_irq_state = {
> > > > >      .put  = put_pci_irq_state,
> > > > >  };
> > > > >  
> > > > > +static bool migrate_is_pcie(void *opaque, int version_id)
> > > > > +{
> > > > > +    return pci_is_express((PCIDevice *)opaque);
> > > > > +}
> > > > > +
> > > > > +static bool migrate_is_not_pcie(void *opaque, int version_id)
> > > > > +{
> > > > > +    return !pci_is_express((PCIDevice *)opaque);
> > > > > +}
> > > > > +
> > > > >  const VMStateDescription vmstate_pci_device = {
> > > > >      .name = "PCIDevice",
> > > > >      .version_id = 2,
> > > > >      .minimum_version_id = 1,
> > > > >      .fields = (VMStateField[]) {
> > > > >          VMSTATE_INT32_POSITIVE_LE(version_id, PCIDevice),
> > > > > -        VMSTATE_BUFFER_UNSAFE_INFO(config, PCIDevice, 0,
> > > > > -                                   vmstate_info_pci_config,
> > > > > +        VMSTATE_BUFFER_UNSAFE_INFO_TEST(config, PCIDevice,
> > > > > +                                   migrate_is_not_pcie,
> > > > > +                                   0, vmstate_info_pci_config,
> > > > >                                     PCI_CONFIG_SPACE_SIZE),
> > > > > -        VMSTATE_BUFFER_UNSAFE_INFO(irq_state, PCIDevice, 2,
> > > > > -				   vmstate_info_pci_irq_state,
> > > > > -				   PCI_NUM_PINS * sizeof(int32_t)),
> > > > > -        VMSTATE_END_OF_LIST()
> > > > > -    }
> > > > > -};
> > > > > -
> > > > > -const VMStateDescription vmstate_pcie_device = {
> > > > > -    .name = "PCIEDevice",
> > > > > -    .version_id = 2,
> > > > > -    .minimum_version_id = 1,
> > > > > -    .fields = (VMStateField[]) {
> > > > > -        VMSTATE_INT32_POSITIVE_LE(version_id, PCIDevice),
> > > > > -        VMSTATE_BUFFER_UNSAFE_INFO(config, PCIDevice, 0,
> > > > > -                                   vmstate_info_pci_config,
> > > > > +        VMSTATE_BUFFER_UNSAFE_INFO_TEST(config, PCIDevice,
> > > > > +                                   migrate_is_pcie,
> > > > > +                                   0, vmstate_info_pci_config,
> > > > >                                     PCIE_CONFIG_SPACE_SIZE),
> > > > >          VMSTATE_BUFFER_UNSAFE_INFO(irq_state, PCIDevice, 2,
> > > > >  				   vmstate_info_pci_irq_state,
> > > > > @@ -574,10 +573,6 @@ const VMStateDescription vmstate_pcie_device = {
> > > > >      }
> > > > >  };
> > > > >  
> > > > > -static inline const VMStateDescription *pci_get_vmstate(PCIDevice *s)
> > > > > -{
> > > > > -    return pci_is_express(s) ? &vmstate_pcie_device : &vmstate_pci_device;
> > > > > -}
> > > > >  
> > > > >  void pci_device_save(PCIDevice *s, QEMUFile *f)
> > > > >  {
> > > > > @@ -586,7 +581,7 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
> > > > >       * This makes us compatible with old devices
> > > > >       * which never set or clear this bit. */
> > > > >      s->config[PCI_STATUS] &= ~PCI_STATUS_INTERRUPT;
> > > > > -    vmstate_save_state(f, pci_get_vmstate(s), s, NULL);
> > > > > +    vmstate_save_state(f, &vmstate_pci_device, s, NULL);
> > > > >      /* Restore the interrupt status bit. */
> > > > >      pci_update_irq_status(s);
> > > > >  }
> > > > > @@ -594,7 +589,7 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
> > > > >  int pci_device_load(PCIDevice *s, QEMUFile *f)
> > > > >  {
> > > > >      int ret;
> > > > > -    ret = vmstate_load_state(f, pci_get_vmstate(s), s, s->version_id);
> > > > > +    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id);
> > > > >      /* Restore the interrupt status bit. */
> > > > >      pci_update_irq_status(s);
> > > > >      return ret;
> > > > > diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> > > > > index 67fc1e7..adc0c4b 100644
> > > > > --- a/hw/scsi/megasas.c
> > > > > +++ b/hw/scsi/megasas.c
> > > > > @@ -2288,7 +2288,7 @@ static const VMStateDescription vmstate_megasas_gen2 = {
> > > > >      .minimum_version_id = 0,
> > > > >      .minimum_version_id_old = 0,
> > > > >      .fields      = (VMStateField[]) {
> > > > > -        VMSTATE_PCIE_DEVICE(parent_obj, MegasasState),
> > > > > +        VMSTATE_PCI_DEVICE(parent_obj, MegasasState),
> > > > >          VMSTATE_MSIX(parent_obj, MegasasState),
> > > > >  
> > > > >          VMSTATE_INT32(fw_state, MegasasState),
> > > > > diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> > > > > index a5ce7de..7557546 100644
> > > > > --- a/hw/scsi/vmw_pvscsi.c
> > > > > +++ b/hw/scsi/vmw_pvscsi.c
> > > > > @@ -1207,7 +1207,7 @@ static const VMStateDescription vmstate_pvscsi_pcie_device = {
> > > > >      .name = "pvscsi/pcie",
> > > > >      .needed = pvscsi_vmstate_need_pcie_device,
> > > > >      .fields = (VMStateField[]) {
> > > > > -        VMSTATE_PCIE_DEVICE(parent_obj, PVSCSIState),
> > > > > +        VMSTATE_PCI_DEVICE(parent_obj, PVSCSIState),
> > > > >          VMSTATE_END_OF_LIST()
> > > > >      }
> > > > >  };
> > > > > diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> > > > > index 4acf0c6..e0b5169 100644
> > > > > --- a/hw/usb/hcd-xhci.c
> > > > > +++ b/hw/usb/hcd-xhci.c
> > > > > @@ -3894,7 +3894,7 @@ static const VMStateDescription vmstate_xhci = {
> > > > >      .version_id = 1,
> > > > >      .post_load = usb_xhci_post_load,
> > > > >      .fields = (VMStateField[]) {
> > > > > -        VMSTATE_PCIE_DEVICE(parent_obj, XHCIState),
> > > > > +        VMSTATE_PCI_DEVICE(parent_obj, XHCIState),
> > > > >          VMSTATE_MSIX(parent_obj, XHCIState),
> > > > >  
> > > > >          VMSTATE_STRUCT_VARRAY_UINT32(ports, XHCIState, numports, 1,
> > > > > diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> > > > > index 056d25e..894262e 100644
> > > > > --- a/include/hw/pci/pcie.h
> > > > > +++ b/include/hw/pci/pcie.h
> > > > > @@ -121,16 +121,6 @@ void pcie_add_capability(PCIDevice *dev,
> > > > >  void pcie_ari_init(PCIDevice *dev, uint16_t offset, uint16_t nextfn);
> > > > >  void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
> > > > >  
> > > > > -extern const VMStateDescription vmstate_pcie_device;
> > > > > -
> > > > > -#define VMSTATE_PCIE_DEVICE(_field, _state) {                        \
> > > > > -    .name       = (stringify(_field)),                               \
> > > > > -    .size       = sizeof(PCIDevice),                                 \
> > > > > -    .vmsd       = &vmstate_pcie_device,                              \
> > > > > -    .flags      = VMS_STRUCT,                                        \
> > > > > -    .offset     = vmstate_offset_value(_state, _field, PCIDevice),   \
> > > > > -}
> > > > > -
> > > > >  void pcie_cap_slot_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> > > > >                                Error **errp);
> > > > >  void pcie_cap_slot_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
> > > > > -- 
> > > > > 2.9.3
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

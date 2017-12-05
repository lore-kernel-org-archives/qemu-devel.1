Received: from eggs.gnu.org ([2001:4830:134:3::10]:37563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1eMGNt-0000j5-9s
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:47:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1eMGNp-0005IU-9W
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:47:53 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:45713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ybettan@redhat.com>) id 1eMGNo-0005Hn-W8
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:47:49 -0500
Received: by mail-wm0-f67.google.com with SMTP id 9so2483420wme.4
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 08:47:48 -0800 (PST)
References: <20171204101828.24453-1-ybettan@redhat.com>
	<f54387fd-af21-3caa-f16f-7ed313ea137c@amsat.org>
From: Yoni Bettan <ybettan@redhat.com>
Message-ID: <2b6d2f62-117e-8770-ef48-5a8e7a9523cc@redhat.com>
Date: Tue, 5 Dec 2017 18:47:43 +0200
MIME-Version: 1.0
In-Reply-To: <f54387fd-af21-3caa-f16f-7ed313ea137c@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2] pci: removed the is_express field since
 a uniform interface was inserted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Hannes Reinecke <hare@suse.com>, "open list:nvme" <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Dmitry Fleytman <dmitry@daynix.com>, Paul Burton <paul.burton@mips.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>



On 12/04/2017 09:46 PM, Philippe Mathieu-Daudé wrote:
> Hi Yoni, Eduardo, Markus,
>
> On 12/04/2017 07:18 AM, Yoni Bettan wrote:
>>          * according to Eduardo Habkost's commit
>>            fd3b02c8896d597dd8b9e053dec579cf0386aee1
>>
>>          * since all PCIEs now implement INTERFACE_PCIE_DEVICE we
>>            don't need this field anymore
>>
>>          * Devices that where only INTERFACE_PCIE_DEVICE (is_express == 1)
>>            or
>>            devices that where only INTERFACE_CONVENTIONAL_PCI_DEVICE (is_express == 0)
>>            where not affected by the change
>>
>>            The only devices that were affected are those that are hybrid and also
>>            had (is_express == 1) - therefor only:
>>              - hw/vfio/pci.c
>>              - hw/usb/hcd-xhci.c
>>
>>            For both i made sure that pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS
>>
>> Signed-off-by: Yoni Bettan <ybettan@redhat.com>
>> ---
>>   docs/pcie_pci_bridge.txt           |  2 +-
>>   hw/block/nvme.c                    |  1 -
>>   hw/net/e1000e.c                    |  1 -
>>   hw/pci-bridge/pcie_pci_bridge.c    |  1 -
>>   hw/pci-bridge/pcie_root_port.c     |  1 -
>>   hw/pci-bridge/xio3130_downstream.c |  1 -
>>   hw/pci-bridge/xio3130_upstream.c   |  1 -
>>   hw/pci-host/xilinx-pcie.c          |  1 -
>>   hw/pci/pci.c                       |  4 +++-
>>   hw/scsi/megasas.c                  |  4 ----
>>   hw/usb/hcd-xhci.c                  | 28 ++++++++++++++++++++++++++--
>>   hw/vfio/pci.c                      | 37 +++++++++++++++++++++++++++++++------
>>   include/hw/pci/pci.h               |  3 ---
>>   include/hw/usb.h                   |  1 +
>>   14 files changed, 62 insertions(+), 24 deletions(-)
>>
>> diff --git a/docs/pcie_pci_bridge.txt b/docs/pcie_pci_bridge.txt
>> index 5a4203f97c..55f833ec10 100644
>> --- a/docs/pcie_pci_bridge.txt
>> +++ b/docs/pcie_pci_bridge.txt
>> @@ -110,5 +110,5 @@ To enable device hot-plug into the bridge on Linux there're 3 ways:
>>   Implementation
>>   ==============
>>   The PCIE-PCI bridge is based on PCI-PCI bridge, but also accumulates PCI Express
>> -features as a PCI Express device (is_express=1).
>> +features as a PCI Express device (pci_dev->cap_present & QEMU_PCI_CAP_EXPRESS != 0).
>>   
>> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
>> index 441e21ed1f..9325bc0911 100644
>> --- a/hw/block/nvme.c
>> +++ b/hw/block/nvme.c
>> @@ -1087,7 +1087,6 @@ static void nvme_class_init(ObjectClass *oc, void *data)
>>       pc->vendor_id = PCI_VENDOR_ID_INTEL;
>>       pc->device_id = 0x5845;
>>       pc->revision = 2;
>> -    pc->is_express = 1;
>>   
>>       set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>>       dc->desc = "Non-Volatile Memory Express";
>> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
>> index f1af279e8d..c360f0d8c9 100644
>> --- a/hw/net/e1000e.c
>> +++ b/hw/net/e1000e.c
>> @@ -675,7 +675,6 @@ static void e1000e_class_init(ObjectClass *class, void *data)
>>       c->revision = 0;
>>       c->romfile = "efi-e1000e.rom";
>>       c->class_id = PCI_CLASS_NETWORK_ETHERNET;
>> -    c->is_express = 1;
>>   
>>       dc->desc = "Intel 82574L GbE Controller";
>>       dc->reset = e1000e_qdev_reset;
>> diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
>> index a4d827c99d..b7d9ebbec2 100644
>> --- a/hw/pci-bridge/pcie_pci_bridge.c
>> +++ b/hw/pci-bridge/pcie_pci_bridge.c
>> @@ -169,7 +169,6 @@ static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>       HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
>>   
>> -    k->is_express = 1;
>>       k->is_bridge = 1;
>>       k->vendor_id = PCI_VENDOR_ID_REDHAT;
>>       k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE;
>> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
>> index 9b6e4ce512..45f9e8cd4a 100644
>> --- a/hw/pci-bridge/pcie_root_port.c
>> +++ b/hw/pci-bridge/pcie_root_port.c
>> @@ -145,7 +145,6 @@ static void rp_class_init(ObjectClass *klass, void *data)
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>>   
>> -    k->is_express = 1;
>>       k->is_bridge = 1;
>>       k->config_write = rp_write_config;
>>       k->realize = rp_realize;
>> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
>> index 1e09d2afb7..613a0d6bb7 100644
>> --- a/hw/pci-bridge/xio3130_downstream.c
>> +++ b/hw/pci-bridge/xio3130_downstream.c
>> @@ -177,7 +177,6 @@ static void xio3130_downstream_class_init(ObjectClass *klass, void *data)
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>>   
>> -    k->is_express = 1;
>>       k->is_bridge = 1;
>>       k->config_write = xio3130_downstream_write_config;
>>       k->realize = xio3130_downstream_realize;
>> diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
>> index 227997ce46..d4645bddee 100644
>> --- a/hw/pci-bridge/xio3130_upstream.c
>> +++ b/hw/pci-bridge/xio3130_upstream.c
>> @@ -148,7 +148,6 @@ static void xio3130_upstream_class_init(ObjectClass *klass, void *data)
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>>   
>> -    k->is_express = 1;
>>       k->is_bridge = 1;
>>       k->config_write = xio3130_upstream_write_config;
>>       k->realize = xio3130_upstream_realize;
>> diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
>> index 7659253090..a4ca3ba30f 100644
>> --- a/hw/pci-host/xilinx-pcie.c
>> +++ b/hw/pci-host/xilinx-pcie.c
>> @@ -298,7 +298,6 @@ static void xilinx_pcie_root_class_init(ObjectClass *klass, void *data)
>>       k->device_id = 0x7021;
>>       k->revision = 0;
>>       k->class_id = PCI_CLASS_BRIDGE_HOST;
>> -    k->is_express = true;
>>       k->is_bridge = true;
>>       k->init = xilinx_pcie_root_init;
>>       k->exit = pci_bridge_exitfn;
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index b2d139bd9a..6b5676b0f4 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -2014,12 +2014,14 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>>   {
>>       PCIDevice *pci_dev = (PCIDevice *)qdev;
>>       PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
>> +    ObjectClass *klass = OBJECT_CLASS(pc);
>>       Error *local_err = NULL;
>>       PCIBus *bus;
>>       bool is_default_rom;
>>   
>>       /* initialize cap_present for pci_is_express() and pci_config_size() */
>> -    if (pc->is_express) {
>> +    if (object_class_dynamic_cast(klass, INTERFACE_PCIE_DEVICE) &&
>> +       !object_class_dynamic_cast(klass, INTERFACE_CONVENTIONAL_PCI_DEVICE)) {
>>           pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
> Isn't this the interface-dependent content of the instance_post_init()
> function?
> Such:
>
> static void pcie_device_post_init(Object *obj)
> {
>      PCI_DEVICE(obj)->cap_present |= QEMU_PCI_CAP_EXPRESS;
> }
>
> static const TypeInfo pcie_interface_info = {
>      .name               = INTERFACE_PCIE_DEVICE,
>      .parent             = TYPE_INTERFACE,
>      .instance_post_init = pcie_device_post_init,
> };

Ohh nice! I didn't noticed the post_init function...
I think that in this  case changing the interface will lead to bug since
we have PCI devices that are hybrid but have is_express = 0
It means that since we made hybrid devices let the INTERFACE_PCIE_DEVICE
stay off by default, those devices won't need to do anything...
But it gave me the idea to simply put this piece of code into 
instance_init()
function instead to make it much simpler...

Thanks for reviewing
Yoni
>
>>       }
>>   
>> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
>> index d5eae6239a..ee51feda59 100644
>> --- a/hw/scsi/megasas.c
>> +++ b/hw/scsi/megasas.c
>> @@ -2447,7 +2447,6 @@ typedef struct MegasasInfo {
>>       uint16_t subsystem_id;
>>       int ioport_bar;
>>       int mmio_bar;
>> -    bool is_express;
>>       int osts;
>>       const VMStateDescription *vmsd;
>>       Property *props;
>> @@ -2465,7 +2464,6 @@ static struct MegasasInfo megasas_devices[] = {
>>           .ioport_bar = 2,
>>           .mmio_bar = 0,
>>           .osts = MFI_1078_RM | 1,
>> -        .is_express = false,
>>           .vmsd = &vmstate_megasas_gen1,
>>           .props = megasas_properties_gen1,
>>           .interfaces = (InterfaceInfo[]) {
>> @@ -2482,7 +2480,6 @@ static struct MegasasInfo megasas_devices[] = {
>>           .ioport_bar = 0,
>>           .mmio_bar = 1,
>>           .osts = MFI_GEN2_RM,
>> -        .is_express = true,
>>           .vmsd = &vmstate_megasas_gen2,
>>           .props = megasas_properties_gen2,
>>           .interfaces = (InterfaceInfo[]) {
>> @@ -2506,7 +2503,6 @@ static void megasas_class_init(ObjectClass *oc, void *data)
>>       pc->subsystem_vendor_id = PCI_VENDOR_ID_LSI_LOGIC;
>>       pc->subsystem_id = info->subsystem_id;
>>       pc->class_id = PCI_CLASS_STORAGE_RAID;
>> -    pc->is_express = info->is_express;
>>       e->mmio_bar = info->mmio_bar;
>>       e->ioport_bar = info->ioport_bar;
>>       e->osts = info->osts;
>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>> index af3a9d88de..1524745b3b 100644
>> --- a/hw/usb/hcd-xhci.c
>> +++ b/hw/usb/hcd-xhci.c
>> @@ -131,6 +131,17 @@
>>   
>>   #define ERDP_EHB        (1<<3)
>>   
>> +typedef struct XHCIClass {
>> +    PCIDeviceClass parent_class;
>> +    DeviceRealize parent_dc_realize;
>> +} XHCIClass;
>> +
>> +#define XHCI_DEVICE_CLASS(klass) \
>> +    OBJECT_CLASS_CHECK(XHCIClass, (klass), TYPE_XHCI)
>> +#define XHCI_DEVICE_GET_CLASS(obj) \
>> +    OBJECT_GET_CLASS(XHCIClass, (obj), TYPE_XHCI)
>> +
>> +
>>   #define TRB_SIZE 16
>>   typedef struct XHCITRB {
>>       uint64_t parameter;
>> @@ -3649,11 +3660,24 @@ static Property xhci_properties[] = {
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   
>> +static void before_usb_xhci_realize(DeviceState *qdev, Error **errp)
>> +{
>> +    XHCIClass *vc = XHCI_DEVICE_GET_CLASS(qdev);
>> +    PCIDevice *pci_dev = PCI_DEVICE(qdev);
>> +
>> +    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
> Ditto (and 'before_func' doesn't sound correct)
>
>> +
>> +    vc->parent_dc_realize(qdev, errp);
>> +}
>> +
>>   static void xhci_class_init(ObjectClass *klass, void *data)
>>   {
>> -    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>> +    XHCIClass *vc = XHCI_DEVICE_CLASS(klass);
>>   
>> +    vc->parent_dc_realize = dc->realize;
>> +    dc->realize = before_usb_xhci_realize;
>>       dc->vmsd    = &vmstate_xhci;
>>       dc->props   = xhci_properties;
>>       dc->reset   = xhci_reset;
>> @@ -3661,12 +3685,12 @@ static void xhci_class_init(ObjectClass *klass, void *data)
>>       k->realize      = usb_xhci_realize;
>>       k->exit         = usb_xhci_exit;
>>       k->class_id     = PCI_CLASS_SERIAL_USB;
>> -    k->is_express   = 1;
>>   }
>>   
>>   static const TypeInfo xhci_info = {
>>       .name          = TYPE_XHCI,
>>       .parent        = TYPE_PCI_DEVICE,
>> +    .class_size    = sizeof(XHCIClass),
>>       .instance_size = sizeof(XHCIState),
>>       .class_init    = xhci_class_init,
>>       .abstract      = true,
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index c977ee327f..e330f2c462 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -35,6 +35,18 @@
>>   
>>   #define MSIX_CAP_LENGTH 12
>>   
>> +typedef struct VFIOClass {
>> +    PCIDeviceClass parent_class;
>> +    DeviceRealize parent_dc_realize;
>> +} VFIOClass;
>> +
>> +#define TYPE_VFIOPCI "vfio-pci"
>> +
>> +#define VFIO_DEVICE_CLASS(klass) \
>> +    OBJECT_CLASS_CHECK(VFIOClass, (klass), TYPE_VFIOPCI)
>> +#define VFIO_DEVICE_GET_CLASS(obj) \
>> +    OBJECT_GET_CLASS(VFIOClass, (obj), TYPE_VFIOPCI)
>> +
>>   static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>>   static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>>   
>> @@ -3012,26 +3024,39 @@ static const VMStateDescription vfio_pci_vmstate = {
>>       .unmigratable = 1,
>>   };
>>   
>> +static void before_vfio_realize(DeviceState *qdev, Error **errp)
>> +{
>> +    VFIOClass *vc = VFIO_DEVICE_GET_CLASS(qdev);
>> +    PCIDevice *pci_dev = PCI_DEVICE(qdev);
>> +
>> +    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
> Ditto
>
>> +
>> +    vc->parent_dc_realize(qdev, errp);
>> +}
>> +
>>   static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>> -    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
>> +    PCIDeviceClass *c = PCI_DEVICE_CLASS(klass);
>> +    VFIOClass *vc = VFIO_DEVICE_CLASS(klass);
>>   
>> +    vc->parent_dc_realize = dc->realize;
>> +    dc->realize = before_vfio_realize;
>>       dc->reset = vfio_pci_reset;
>>       dc->props = vfio_pci_dev_properties;
>>       dc->vmsd = &vfio_pci_vmstate;
>>       dc->desc = "VFIO-based PCI device assignment";
>>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>> -    pdc->realize = vfio_realize;
>> -    pdc->exit = vfio_exitfn;
>> -    pdc->config_read = vfio_pci_read_config;
>> -    pdc->config_write = vfio_pci_write_config;
>> -    pdc->is_express = 1; /* We might be */
>> +    c->realize = vfio_realize;
>> +    c->exit = vfio_exitfn;
>> +    c->config_read = vfio_pci_read_config;
>> +    c->config_write = vfio_pci_write_config;
>>   }
>>   
>>   static const TypeInfo vfio_pci_dev_info = {
>>       .name = "vfio-pci",
>>       .parent = TYPE_PCI_DEVICE,
>> +    .class_size = sizeof(VFIOClass),
>>       .instance_size = sizeof(VFIOPCIDevice),
>>       .class_init = vfio_pci_dev_class_init,
>>       .instance_init = vfio_instance_init,
>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>> index 8d02a0a383..a27be85111 100644
>> --- a/include/hw/pci/pci.h
>> +++ b/include/hw/pci/pci.h
>> @@ -236,9 +236,6 @@ typedef struct PCIDeviceClass {
>>        */
>>       int is_bridge;
>>   
>> -    /* pcie stuff */
>> -    int is_express;   /* is this device pci express? */
>> -
>>       /* rom bar */
>>       const char *romfile;
>>   } PCIDeviceClass;
>> diff --git a/include/hw/usb.h b/include/hw/usb.h
>> index eb28655270..60238bcc32 100644
>> --- a/include/hw/usb.h
>> +++ b/include/hw/usb.h
>> @@ -275,6 +275,7 @@ typedef void (*USBDeviceUnrealize)(USBDevice *dev, Error **errp);
>>   
>>   typedef struct USBDeviceClass {
>>       DeviceClass parent_class;
>> +    DeviceRealize parent_dc_realize;
>>   
>>       USBDeviceRealize realize;
>>       USBDeviceUnrealize unrealize;
>>

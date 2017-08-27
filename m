Received: from eggs.gnu.org ([2001:4830:134:3::10]:51650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dlt16-00061q-0e
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 04:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dlt12-00042i-Si
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 04:34:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dlt12-00042P-K6
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 04:33:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2FDD181DEB
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 08:33:55 +0000 (UTC)
References: <20170823221445.15243-1-ehabkost@redhat.com>
	<20170823221445.15243-3-ehabkost@redhat.com>
	<20170825191858.GK27715@localhost.localdomain>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <291e006c-0fac-caa8-041a-3b2991c7171e@redhat.com>
Date: Sun, 27 Aug 2017 11:33:46 +0300
MIME-Version: 1.0
In-Reply-To: <20170825191858.GK27715@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] pci: Add interface names to hybrid PCI
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Laine Stump <laine@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Hi Eduardo,

On 25/08/2017 22:18, Eduardo Habkost wrote:
> On Wed, Aug 23, 2017 at 07:14:42PM -0300, Eduardo Habkost wrote:
>> The following devices support both PCIe and legacy PCI, by
>> including special code to handle the QEMU_PCI_CAP_EXPRESS flag:
>>
>> * vfio-pci (is_express=1, but legacy PCI handled by
>>    vfio_populate_device())
>> * vmxnet3 (is_express=0, but PCIe handled by vmxnet3_realize())
>> * pvscsi (is_express=0, but PCIe handled by pvscsi_realize())
>> * virtio-pci (is_express=0, but PCIe handled by
>>    virtio_pci_dc_realize(), and additional legacy PCI code at
>>    virtio_pci_realize())
> 
> Oh, the rules are even messier than that: QEMU_PCI_CAP_EXPRESS
> controls _some_ of the code that makes a device become a PCI
> Express device, but not every case.
> 
> In addition to vmxnet3, pvscsi and virtio-pci, PCIe caps
> initialization is conditional on hcd-xhci (see below).
> 
> This means xhci is also a hybrid device.  But it doesn't seem to
> clear QEMU_PCI_CAP_EXPRESS.  Doesn't it mean pci_config_size() is
> broken if xhci is plugged to a legacy PCI bus?  How does it
> affect migration?
> 

If this is the case we reserve more config space than needed.
Other than wasted space it should be OK, including migration.

Thanks,
Marcel

> Full list of pci_endpoint_cap*_init() calls:
> 
> hw/usb/hcd-xhci.c-    if (pci_bus_is_express(dev->bus) ||
> hw/usb/hcd-xhci.c-        xhci_get_flag(xhci, XHCI_FLAG_FORCE_PCIE_ENDCAP)) {
> hw/usb/hcd-xhci.c:        ret = pcie_endpoint_cap_init(dev, 0xa0);
> 
> hw/net/vmxnet3.c-    if (pci_is_express(pci_dev)) {
> hw/net/vmxnet3.c-        if (pci_bus_is_express(pci_dev->bus)) {
> hw/net/vmxnet3.c:            pcie_endpoint_cap_init(pci_dev, VMXNET3_EXP_EP_OFFSET);
> hw/net/vmxnet3.c-        }
> 
> hw/scsi/megasas.c-    if (pci_is_express(dev)) {
> hw/scsi/megasas.c:        pcie_endpoint_cap_init(dev, 0xa0);
> hw/scsi/megasas.c-    }
> 
> hw/scsi/vmw_pvscsi.c-    if (pci_is_express(pci_dev) && pci_bus_is_express(pci_dev->bus)) {
> hw/scsi/vmw_pvscsi.c:        pcie_endpoint_cap_init(pci_dev, PVSCSI_EXP_EP_OFFSET);
> hw/scsi/vmw_pvscsi.c-    }
> 
> hw/virtio/virtio-pci.c-    if (pcie_port && pci_is_express(pci_dev)) {
> hw/virtio/virtio-pci.c-        int pos;
> hw/virtio/virtio-pci.c-
> hw/virtio/virtio-pci.c:        pos = pcie_endpoint_cap_init(pci_dev, 0);
> 
> 
> Note: on megasas, pci_endpoitn_cap_init() is conditional on
> pci_is_express(), but pci_is_express() will never be false on
> megasas-gen2 (because QEMU_PCI_CAP_EXPRESS is always set).
> 
> 
> Full list of unconditional pci_endpoint_cap*init() calls:
> 
> hw/block/nvme.c:    pcie_endpoint_cap_init(&n->parent_obj, 0x80);
> 
> hw/net/e1000e.c:    if (pcie_endpoint_cap_v1_init(pci_dev, e1000e_pcie_offset) < 0) {
> 
> hw/pci-bridge/pcie_root_port.c:    rc = pcie_cap_init(d, rpc->exp_offset, PCI_EXP_TYPE_ROOT_PORT,
> hw/pci-bridge/pcie_root_port.c-                       p->port, errp);
> 
> hw/pci-bridge/xio3130_downstream.c:    rc = pcie_cap_init(d, XIO3130_EXP_OFFSET, PCI_EXP_TYPE_DOWNSTREAM,
> hw/pci-bridge/xio3130_downstream.c-                       p->port, errp);
> 
> hw/pci-bridge/xio3130_upstream.c:    rc = pcie_cap_init(d, XIO3130_EXP_OFFSET, PCI_EXP_TYPE_UPSTREAM,
> hw/pci-bridge/xio3130_upstream.c-                       p->port, errp);
> 
> hw/pci-host/xilinx-pcie.c:    if (pcie_endpoint_cap_v1_init(dev, 0x80) < 0) {
> 
> 
> 
>>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>>   hw/net/vmxnet3.c       | 5 +++++
>>   hw/scsi/vmw_pvscsi.c   | 2 ++
>>   hw/vfio/pci.c          | 5 +++++
>>   hw/virtio/virtio-pci.c | 5 +++++
>>   4 files changed, 17 insertions(+)
>>
>> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
>> index a19a7a3..61feacf 100644
>> --- a/hw/net/vmxnet3.c
>> +++ b/hw/net/vmxnet3.c
>> @@ -2651,6 +2651,11 @@ static const TypeInfo vmxnet3_info = {
>>       .instance_size = sizeof(VMXNET3State),
>>       .class_init    = vmxnet3_class_init,
>>       .instance_init = vmxnet3_instance_init,
>> +    .interfaces = (InterfaceInfo[]) {
>> +        { INTERFACE_PCIE_DEVICE },
>> +        { INTERFACE_LEGACY_PCI_DEVICE },
>> +        { }
>> +    },
>>   };
>>   
>>   static void vmxnet3_register_types(void)
>> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
>> index 77d8b6f..40dfffa 100644
>> --- a/hw/scsi/vmw_pvscsi.c
>> +++ b/hw/scsi/vmw_pvscsi.c
>> @@ -1300,6 +1300,8 @@ static const TypeInfo pvscsi_info = {
>>       .class_init    = pvscsi_class_init,
>>       .interfaces = (InterfaceInfo[]) {
>>           { TYPE_HOTPLUG_HANDLER },
>> +        { INTERFACE_PCIE_DEVICE },
>> +        { INTERFACE_LEGACY_PCI_DEVICE },
>>           { }
>>       }
>>   };
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 31e1edf..2b21391 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3023,6 +3023,11 @@ static const TypeInfo vfio_pci_dev_info = {
>>       .class_init = vfio_pci_dev_class_init,
>>       .instance_init = vfio_instance_init,
>>       .instance_finalize = vfio_instance_finalize,
>> +    .interfaces = (InterfaceInfo[]) {
>> +        { INTERFACE_PCIE_DEVICE },
>> +        { INTERFACE_LEGACY_PCI_DEVICE },
>> +        { }
>> +    },
>>   };
>>   
>>   static void register_vfio_pci_dev_type(void)
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index 8b0d6b6..8c0b6bf 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -1958,6 +1958,11 @@ static const TypeInfo virtio_pci_info = {
>>       .class_init    = virtio_pci_class_init,
>>       .class_size    = sizeof(VirtioPCIClass),
>>       .abstract      = true,
>> +    .interfaces = (InterfaceInfo[]) {
>> +        { INTERFACE_PCIE_DEVICE },
>> +        { INTERFACE_LEGACY_PCI_DEVICE },
>> +        { }
>> +    },
>>   };
>>   
>>   /* virtio-blk-pci */
>> -- 
>> 2.9.4
>>
>>
> 

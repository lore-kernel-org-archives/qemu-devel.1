Received: from eggs.gnu.org ([2001:4830:134:3::10]:48720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dlsKP-0006yy-7e
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 03:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dlsKM-0003Uh-4j
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 03:49:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dlsKL-0003T9-Ro
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 03:49:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C158D81DEB
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 07:49:48 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
References: <20170823221445.15243-1-ehabkost@redhat.com>
	<20170823221445.15243-3-ehabkost@redhat.com>
	<60103c6b-ba81-1e30-2171-1d4a3537afe0@redhat.com>
Message-ID: <aaf94fe7-8df6-2f0d-5481-afa3d40e2589@redhat.com>
Date: Sun, 27 Aug 2017 10:49:53 +0300
MIME-Version: 1.0
In-Reply-To: <60103c6b-ba81-1e30-2171-1d4a3537afe0@redhat.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Laine Stump <laine@redhat.com>

On 27/08/2017 10:48, Marcel Apfelbaum wrote:
> On 24/08/2017 1:14, Eduardo Habkost wrote:
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
>>
> 
> Hi Eduardo,
> 
> We also have a "hybrid" USB controller (not sure which one :)).
> 

Please disregard the comment, I saw you are taking it into account.

Thanks,
Marcel

> Thanks,
> Marcel
> 
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
>>   /* virtio-blk-pci */
>>
> 

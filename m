Received: from eggs.gnu.org ([2001:4830:134:3::10]:37661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gKTbX-0003Nl-WA
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:35:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gKTbT-0003Vs-F7
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:35:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44340
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gKTbR-0003Sy-Rx
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:35:02 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA7JXrd3015581
	for <qemu-devel@nongnu.org>; Wed, 7 Nov 2018 14:35:01 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2nm4a7w6mc-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 14:35:00 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Wed, 7 Nov 2018 19:35:00 -0000
References: <20181105110313.29312-1-david@redhat.com>
	<20181105110313.29312-4-david@redhat.com>
	<228ec0b2-cd30-b33b-8120-bb28e3f83e66@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Wed, 7 Nov 2018 14:34:53 -0500
MIME-Version: 1.0
In-Reply-To: <228ec0b2-cd30-b33b-8120-bb28e3f83e66@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <723f6454-8cac-08ed-bdb6-afddc4ed7ad1@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 3/4] s390x/zpci: move some
 hotplug checks to the pre_plug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 11/5/18 6:50 AM, David Hildenbrand wrote:
> On 05.11.18 12:03, David Hildenbrand wrote:
>> Let's move most of the checks to the new pre_plug handler. As a PCI
>> bridge is just a PCI device, we can simplify the code.
>>
>> Notes: We cannot yet move the MSIX check or device ID creation +
>> zPCI device creation to the pre_plug handler as both parts are not
>> fixed before actual device realization (and therefore after pre_plug and
>> before plug). Once that part is factored out, we can move these parts to
>> the pre_plug handler, too and therefore remove all possible errors from
>> the plug handler.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/s390x/s390-pci-bus.c | 43 +++++++++++++++++++++++++----------------
>>  1 file changed, 26 insertions(+), 17 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 68660eac74..1849f9d334 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -806,11 +806,31 @@ static bool s390_pci_alloc_idx(S390pciState *s, S390PCIBusDevice *pbdev)
>>      }
>>  
>>      pbdev->idx = idx;
>> -    s->next_idx = (idx + 1) & FH_MASK_INDEX;
>> -
>>      return true;
>>  }
>>  
>> +static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>> +                                   Error **errp)
>> +{
>> +    S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>> +
>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>> +        PCIDevice *pdev = PCI_DEVICE(dev);
>> +
>> +        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
>> +            error_setg(errp, "multifunction not supported in s390");
>> +            return;
>> +        }
>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
>> +        S390PCIBusDevice *pbdev = S390_PCI_DEVICE(dev);
>> +
>> +        if (!s390_pci_alloc_idx(s, pbdev)) {
>> +            error_setg(errp, "no slot for plugging zpci device");
>> +            return;
>> +        }
>> +    }
>> +}
>> +
>>  static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>                                Error **errp)
>>  {
>> @@ -823,11 +843,6 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,>>          PCIBridge *pb = PCI_BRIDGE(dev);
>>          PCIDevice *pdev = PCI_DEVICE(dev);
>>  
>> -        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
>> -            error_setg(errp, "multifunction not supported in s390");
>> -            return;
>> -        }
>> -
>>          pci_bridge_map_irq(pb, dev->id, s390_pci_map_irq);
>>          pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, s);
>>  
>> @@ -847,11 +862,6 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>>          pdev = PCI_DEVICE(dev);
>>  
>> -        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
>> -            error_setg(errp, "multifunction not supported in s390");
>> -            return;
>> -        }
>> -
>>          if (!dev->id) {
>>              /* In the case the PCI device does not define an id */
>>              /* we generate one based on the PCI address         */
>> @@ -883,7 +893,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>  
>>          if (s390_pci_msix_init(pbdev)) {
>>              error_setg(errp, "MSI-X support is mandatory "
>> -                       "in the S390 architecture");
>> +                             "in the S390 architecture");
> 
> I will drop this unrelated change.
> 
>>              return;
>>          }
>>  
>> @@ -894,10 +904,8 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
>>          pbdev = S390_PCI_DEVICE(dev);
>>  
>> -        if (!s390_pci_alloc_idx(s, pbdev)) {
>> -            error_setg(errp, "no slot for plugging zpci device");
>> -            return;
>> -        }
>> +        /* the allocated idx is actually getting used */
>> +        s->next_idx = (pbdev->idx + 1) & FH_MASK_INDEX;
>>          pbdev->fh = pbdev->idx;
>>          QTAILQ_INSERT_TAIL(&s->zpci_devs, pbdev, link);
>>          g_hash_table_insert(s->zpci_table, &pbdev->idx, pbdev);
>> @@ -1030,6 +1038,7 @@ static void s390_pcihost_class_init(ObjectClass *klass, void *data)
>>  
>>      dc->reset = s390_pcihost_reset;
>>      dc->realize = s390_pcihost_realize;
>> +    hc->pre_plug = s390_pcihost_pre_plug;
>>      hc->plug = s390_pcihost_plug;
>>      hc->unplug = s390_pcihost_unplug;
>>      msi_nonbroken = true;
>>

When did these function names drop the *_hot_plug postfix? Latest master does not reflect this change for me.
Just figured I'd mention it now in case merging becomes a pain later ;)

> 
> 

The above concerns do not relate to any functionality of the code, so with them addressed, then:

Reviewed-by: Collin Walling <walling@linux.ibm.com>

-- 
Respectfully,
- Collin Walling

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gJdFL-0001zW-15
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gJdFH-0002n5-GD
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:40:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gJdFG-0008I6-Ps
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:40:39 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA5BckXJ142949
	for <qemu-devel@nongnu.org>; Mon, 5 Nov 2018 06:40:25 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2njk9vnd2m-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 06:40:25 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 5 Nov 2018 11:40:23 -0000
References: <20181105110313.29312-1-david@redhat.com>
	<20181105110313.29312-3-david@redhat.com>
	<20181105122148.2eae5288.cohuck@redhat.com>
	<3ba91b23-fbea-edce-3f2e-d3405cb3b4f7@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 5 Nov 2018 12:40:16 +0100
MIME-Version: 1.0
In-Reply-To: <3ba91b23-fbea-edce-3f2e-d3405cb3b4f7@redhat.com>
Content-Language: en-US
Message-Id: <a836fc7f-ab55-a51e-26ed-4d0dfd721737@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/4] s390x/zpci: use hotplug_dev instead
 of looking up the host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, =Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>



On 11/05/2018 12:37 PM, David Hildenbrand wrote:
> On 05.11.18 12:21, Cornelia Huck wrote:
>> On Mon,  5 Nov 2018 12:03:11 +0100
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> We directly have it in our hands.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  hw/s390x/s390-pci-bus.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>> index 1eaae3aca6..68660eac74 100644
>>> --- a/hw/s390x/s390-pci-bus.c
>>> +++ b/hw/s390x/s390-pci-bus.c
>>> @@ -814,9 +814,9 @@ static bool s390_pci_alloc_idx(S390pciState *s, S390PCIBusDevice *pbdev)
>>>  static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>                                Error **errp)
>>>  {
>>> +    S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>>>      PCIDevice *pdev = NULL;
>>>      S390PCIBusDevice *pbdev = NULL;
>>> -    S390pciState *s = s390_get_phb();
>>>  
>>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
>>>          BusState *bus;
>>> @@ -924,11 +924,11 @@ static void s390_pcihost_timer_cb(void *opaque)
>>>  static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>                                  Error **errp)
>>>  {
>>> +    S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>>>      PCIDevice *pci_dev = NULL;
>>>      PCIBus *bus;
>>>      int32_t devfn;
>>>      S390PCIBusDevice *pbdev = NULL;
>>> -    S390pciState *s = s390_get_phb();
>>>  
>>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
>>>          error_setg(errp, "PCI bridge hot unplug currently not supported");
>>
>> Not sure whether that is an improvement (s390_get_phb() caches the
>> value, and is called from multiple other places as well.)
>>
> 
> Looking up a variable that is directly passed as an argument doesn't
> look clean to me.

I think there was a reason for this caching, namely that qom resolution can
be quite expensive. For the hotplug case this obviously does not matter but
for all the other cases it might. So do we really want to have different 
places use different methods?

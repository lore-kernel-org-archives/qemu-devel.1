Received: from eggs.gnu.org ([2001:4830:134:3::10]:33048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gKUfG-0005x9-6q
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 15:43:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gKURO-0003W8-QI
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 15:28:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49048
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gKURM-0003TT-Qx
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 15:28:42 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA7KOL8E063012
	for <qemu-devel@nongnu.org>; Wed, 7 Nov 2018 15:28:38 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nm4bvy009-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 15:28:38 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Wed, 7 Nov 2018 20:28:37 -0000
References: <20181105110313.29312-1-david@redhat.com>
	<20181105110313.29312-3-david@redhat.com>
	<20181105122148.2eae5288.cohuck@redhat.com>
	<3ba91b23-fbea-edce-3f2e-d3405cb3b4f7@redhat.com>
	<a836fc7f-ab55-a51e-26ed-4d0dfd721737@de.ibm.com>
	<a7da29b4-68ff-ae8b-5c0e-e025a7939102@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Wed, 7 Nov 2018 15:28:31 -0500
MIME-Version: 1.0
In-Reply-To: <a7da29b4-68ff-ae8b-5c0e-e025a7939102@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c2c3c667-e04e-9498-c4d7-05eaeedf0a26@linux.ibm.com>
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
To: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 11/5/18 6:50 AM, David Hildenbrand wrote:
> On 05.11.18 12:40, Christian Borntraeger wrote:
>>
>>
>> On 11/05/2018 12:37 PM, David Hildenbrand wrote:
>>> On 05.11.18 12:21, Cornelia Huck wrote:
>>>> On Mon,  5 Nov 2018 12:03:11 +0100
>>>> David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>>> We directly have it in our hands.
>>>>>
>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>> ---
>>>>>  hw/s390x/s390-pci-bus.c | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>>>> index 1eaae3aca6..68660eac74 100644
>>>>> --- a/hw/s390x/s390-pci-bus.c
>>>>> +++ b/hw/s390x/s390-pci-bus.c
>>>>> @@ -814,9 +814,9 @@ static bool s390_pci_alloc_idx(S390pciState *s, S390PCIBusDevice *pbdev)
>>>>>  static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>>>                                Error **errp)
>>>>>  {
>>>>> +    S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>>>>>      PCIDevice *pdev = NULL;
>>>>>      S390PCIBusDevice *pbdev = NULL;
>>>>> -    S390pciState *s = s390_get_phb();
>>>>>  
>>>>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
>>>>>          BusState *bus;
>>>>> @@ -924,11 +924,11 @@ static void s390_pcihost_timer_cb(void *opaque)
>>>>>  static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>>>                                  Error **errp)
>>>>>  {
>>>>> +    S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>>>>>      PCIDevice *pci_dev = NULL;
>>>>>      PCIBus *bus;
>>>>>      int32_t devfn;
>>>>>      S390PCIBusDevice *pbdev = NULL;
>>>>> -    S390pciState *s = s390_get_phb();
>>>>>  
>>>>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
>>>>>          error_setg(errp, "PCI bridge hot unplug currently not supported");
>>>>
>>>> Not sure whether that is an improvement (s390_get_phb() caches the
>>>> value, and is called from multiple other places as well.)
>>>>
>>>
>>> Looking up a variable that is directly passed as an argument doesn't
>>> look clean to me.
>>
>> I think there was a reason for this caching, namely that qom resolution can
>> be quite expensive. For the hotplug case this obviously does not matter but
>> for all the other cases it might. So do we really want to have different 
>> places use different methods?
>>
> 
> Caching resolution is fine (as that is expensive), caching a downcast is
> as far as I remember not necessary. Especially, as you said, for hotplug
> handlers.
> 
> Anyhow, if there are strong feelings to this change, I can drop this
> patch. There are certainly more important things to do in zPCI hotplug code.
> 
> 

Truthfully, I'm not in favor of one over the other. As long as the device handlers
are consistent, I think either is fine.

However, it would be nice if at some point during plug we cache the PHB somewhere.
That would be some sort of best-of-both-worlds approach.

-- 
Respectfully,
- Collin Walling

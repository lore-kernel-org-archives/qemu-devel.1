Received: from eggs.gnu.org ([209.51.188.92]:37247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gm0ul-0004EW-KR
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gm0uk-0007kG-Dw
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:36:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gm0uk-0007jX-2y
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:36:46 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0MEoYwN124514
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:03:17 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q63g85shn-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:03:17 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 22 Jan 2019 15:03:14 -0000
References: <20190122094143.8857-1-david@redhat.com>
	<20190122134457.212a60f3.cohuck@redhat.com>
	<ae4f687e-ab41-fe9c-18be-ee678e3c9941@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 22 Jan 2019 16:03:09 +0100
MIME-Version: 1.0
In-Reply-To: <ae4f687e-ab41-fe9c-18be-ee678e3c9941@redhat.com>
Content-Language: en-US
Message-Id: <0fa341f4-0c37-f793-ee14-277e085d0159@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/pci: Warn when adding PCI devices
 without the 'zpci' feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>



On 22.01.2019 13:52, David Hildenbrand wrote:
> On 22.01.19 13:44, Cornelia Huck wrote:
>> On Tue, 22 Jan 2019 10:41:43 +0100
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> We decided to always create the PCI host bridge, even if 'zpci' is not
>>> enabled (due to migration compatibility). This however right now allows
>>> to add zPCI/PCI devices to a VM although the guest will never actually see
>>> them, confusing people that are using a simple CPU model that has no
>>> 'zpci' enabled - "Why isn't this working" (David Hildenbrand)
>>>
>>> Let's check for 'zpci' and at least print a warning that this will not
>>> work as expected. We could also bail out, however that might break
>>> existing QEMU commandlines.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  hw/s390x/s390-pci-bus.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>> index b86a8bdcd4..e7d4f49611 100644
>>> --- a/hw/s390x/s390-pci-bus.c
>>> +++ b/hw/s390x/s390-pci-bus.c
>>> @@ -863,6 +863,11 @@ static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>  {
>>>      S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>>>  
>>> +    if (!s390_has_feat(S390_FEAT_ZPCI)) {
>>> +        warn_report("Adding PCI or zPCI devices without the 'zpci' CPU feature."
>>> +                    " The guest will not be able to see/use these devices.");
>>> +    }
>>> +
>>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>>>          PCIDevice *pdev = PCI_DEVICE(dev);
>>>  
>>
>> That's hotplug only, isn't it? IIRC coldplugging already fails?
>>
> 
> No, applies also to coldplugging.

Back then we made this a conscious decision, because removing the bridge triggered a
lot of issues regarding migration. And the current behaviour actually is a good
match to the real hardware, there are PCI devices in the system that can not be used
by guests. I understand that this is kind of surprising, so I am fine with the warn_report
but I do not want to have a hard error right now.

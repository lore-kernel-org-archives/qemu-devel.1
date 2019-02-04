Received: from eggs.gnu.org ([209.51.188.92]:54927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gqeLp-0000wj-Ct
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gqeLo-0008EK-3L
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:31:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gqeLn-000885-Kt
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:31:51 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x14DPWgJ091154
	for <qemu-devel@nongnu.org>; Mon, 4 Feb 2019 08:31:48 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qenupsnnf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 08:31:48 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 4 Feb 2019 13:31:45 -0000
References: <20190122094143.8857-1-david@redhat.com>
	<20190122134457.212a60f3.cohuck@redhat.com>
	<ae4f687e-ab41-fe9c-18be-ee678e3c9941@redhat.com>
	<0fa341f4-0c37-f793-ee14-277e085d0159@de.ibm.com>
	<98167131-5d68-269c-671a-1378aac9ac45@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 4 Feb 2019 14:31:40 +0100
MIME-Version: 1.0
In-Reply-To: <98167131-5d68-269c-671a-1378aac9ac45@redhat.com>
Content-Language: en-US
Message-Id: <6c7a3dcd-0547-3a1d-eec4-4157deca4ab6@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1] s390x/pci: Warn when
 adding PCI devices without the 'zpci' feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Richard Henderson <rth@twiddle.net>



On 22.01.2019 16:11, David Hildenbrand wrote:
> On 22.01.19 16:03, Christian Borntraeger wrote:
>>
>>
>> On 22.01.2019 13:52, David Hildenbrand wrote:
>>> On 22.01.19 13:44, Cornelia Huck wrote:
>>>> On Tue, 22 Jan 2019 10:41:43 +0100
>>>> David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>>> We decided to always create the PCI host bridge, even if 'zpci' is not
>>>>> enabled (due to migration compatibility). This however right now allows
>>>>> to add zPCI/PCI devices to a VM although the guest will never actually see
>>>>> them, confusing people that are using a simple CPU model that has no
>>>>> 'zpci' enabled - "Why isn't this working" (David Hildenbrand)
>>>>>
>>>>> Let's check for 'zpci' and at least print a warning that this will not
>>>>> work as expected. We could also bail out, however that might break
>>>>> existing QEMU commandlines.
>>>>>
>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>> ---
>>>>>  hw/s390x/s390-pci-bus.c | 5 +++++
>>>>>  1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>>>> index b86a8bdcd4..e7d4f49611 100644
>>>>> --- a/hw/s390x/s390-pci-bus.c
>>>>> +++ b/hw/s390x/s390-pci-bus.c
>>>>> @@ -863,6 +863,11 @@ static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>>>  {
>>>>>      S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>>>>>  
>>>>> +    if (!s390_has_feat(S390_FEAT_ZPCI)) {
>>>>> +        warn_report("Adding PCI or zPCI devices without the 'zpci' CPU feature."
>>>>> +                    " The guest will not be able to see/use these devices.");
>>>>> +    }
>>>>> +
>>>>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>>>>>          PCIDevice *pdev = PCI_DEVICE(dev);
>>>>>  
>>>>
>>>> That's hotplug only, isn't it? IIRC coldplugging already fails?
>>>>
>>>
>>> No, applies also to coldplugging.
>>
>> Back then we made this a conscious decision, because removing the bridge triggered a
>> lot of issues regarding migration. And the current behaviour actually is a good
>> match to the real hardware, there are PCI devices in the system that can not be used
>> by guests. I understand that this is kind of surprising, so I am fine with the warn_report
>> but I do not want to have a hard error right now.
>>
> 
> So you agree to this patch, unmodified, correct? Thanks!

Sorry, somehow lost this mail. Yes.

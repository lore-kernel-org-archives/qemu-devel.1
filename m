Received: from eggs.gnu.org ([209.51.188.92]:42736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gqn9r-0005x8-Ve
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gqmwM-0008Dy-1r
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:42:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45868
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gqmwL-00087j-QF
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:42:09 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x14MYe3V083517
	for <qemu-devel@nongnu.org>; Mon, 4 Feb 2019 17:42:07 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qewmn9nj7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 17:42:07 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Mon, 4 Feb 2019 22:42:06 -0000
References: <20190130155733.32742-1-david@redhat.com>
	<20190130155733.32742-4-david@redhat.com>
	<80dae41f-f3f0-1acd-1fd6-8e7473712802@linux.ibm.com>
	<5c81b64a-7de0-210f-adb9-bf7f1ad10622@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Mon, 4 Feb 2019 17:42:02 -0500
MIME-Version: 1.0
In-Reply-To: <5c81b64a-7de0-210f-adb9-bf7f1ad10622@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <810ede3a-7d69-8cff-7058-9e2bb002fff9@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 3/6] s390x/pci: Warn when
 adding PCI devices without the 'zpci' feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 2/4/19 4:54 PM, David Hildenbrand wrote:
> On 04.02.19 21:19, Collin Walling wrote:
>> On 1/30/19 10:57 AM, David Hildenbrand wrote:
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
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>    hw/s390x/s390-pci-bus.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>> index 9b5c5fff60..2efd9186c2 100644
>>> --- a/hw/s390x/s390-pci-bus.c
>>> +++ b/hw/s390x/s390-pci-bus.c
>>> @@ -826,6 +826,11 @@ static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>    {
>>>        S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>>>    
>>> +    if (!s390_has_feat(S390_FEAT_ZPCI)) {
>>> +        warn_report("PCI/zPCI device without the 'zpci' CPU feature."
>>> +                    " The guest will not be able to see/use this device");
>>> +    }
>>> +
>>>        if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>>>            PCIDevice *pdev = PCI_DEVICE(dev);
>>>    
>>>
>>
>> I wonder if someone might misconstrue this as "the _PCI device_ needs
>> the zpci feature." I think "'zpci' CPU feature required to support
>> PCI/zPCI devices." reads better. The last sentence is fine to me.
>>
> 
> Well, the guest needs the 'zpci' feature to see the device. And that's
> what that message says in my opinion. Not that a device needs to have a
> feature (I added "CPU feature" for this reason).
> 
> "required to support" does it not make very clear what we actually want
> to say.
> 
> Thanks!
> 

I see your point. We can still plug in the device without the CPU
feature, but the device will ultimately be useless to the guest. Thanks
for clearing that up.

Still, the wording reads strangely to me. I read it as the PCI device
itself requires a "zpci CPU feature" which of course does not make sense
(and I fully understand that's not what you mean here).

What do you think about:

"PCI/zPCI device plugging without 'zpci' CPU feature enabled." along
with your second sentence, of course.

Either way you decide, it's still a good idea to have this warning in
here. I'm really just debating syntax and not semantics, so it's not
really important. I won't impede this patch over a differing opinion of
a small rewording. :)

Reviewed-by: Collin Walling <walling@linux.ibm.com>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1frwak-0000DB-Dt
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 22:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1frwah-0006BV-8n
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 22:40:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:24579)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1frwag-000682-W5
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 22:40:19 -0400
References: <1534411696-6454-1-git-send-email-jing2.liu@linux.intel.com>
	<1534411696-6454-3-git-send-email-jing2.liu@linux.intel.com>
	<bf7fbbe7-0bc0-12a7-c0c2-cf3249df75a9@gmail.com>
	<391049bb-eb92-7c47-18cd-d8bdb6ddf27c@linux.intel.com>
	<e314ee5b-4838-8e20-e5a1-7cc1834ef00a@gmail.com>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <07baf16a-22fb-34d5-e38c-222f6e42fd96@linux.intel.com>
Date: Tue, 21 Aug 2018 10:39:53 +0800
MIME-Version: 1.0
In-Reply-To: <e314ee5b-4838-8e20-e5a1-7cc1834ef00a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] hw/pci: add teardown function for
 PCI resource reserve capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anthony.xu@intel.com, lersek@redhat.com, mst@redhat.com


Hi Marcel,

On 8/20/2018 9:38 PM, Marcel Apfelbaum wrote:
> Hi Jing,
> 
> On 08/20/2018 05:58 AM, Liu, Jing2 wrote:
>> Hi Marcel,
>>
>> On 8/18/2018 12:10 AM, Marcel Apfelbaum wrote:
>>> Hi Jing,
>>>
>>> On 08/16/2018 12:28 PM, Jing Liu wrote:
>>>> Clean up the PCI config space of resource reserve capability.
>>>>
>>>> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
>>>> ---
>>>>   hw/pci/pci_bridge.c         | 9 +++++++++
>>>>   include/hw/pci/pci_bridge.h | 1 +
>>>>   2 files changed, 10 insertions(+)
>>>>
>>>> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
>>>> index 15b055e..dbcee90 100644
>>>> --- a/hw/pci/pci_bridge.c
>>>> +++ b/hw/pci/pci_bridge.c
>>>> @@ -465,6 +465,15 @@ int pci_bridge_qemu_reserve_cap_init(PCIDevice 
>>>> *dev, int cap_offset,
>>>>       return 0;
>>>>   }
>>>> +void pci_bridge_qemu_reserve_cap_uninit(PCIDevice *dev)
>>>> +{
>>>> +    uint8_t pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
>>>> +
>>>> +    pci_del_capability(dev, PCI_CAP_ID_VNDR, 
>>>> sizeof(PCIBridgeQemuCap));
>>>
>>> I think that you only need to call pci_del_capability,
>>>
>>>> +    memset(dev->config + pos + PCI_CAP_FLAGS, 0,
>>>> +           sizeof(PCIBridgeQemuCap) - PCI_CAP_FLAGS);
>>>> +}
>>>
>>> ... no need for the above line. The reason is pci_del_capability
>>> will "unlink" the capability, and even if the data remains in
>>> the configuration space array, it will not be used.
>>>
>> I think I got it: pci_del_capability "unlink" by set the tag
>> pdev->config[PCI_STATUS] &= ~PCI_STATUS_CAP_LIST;
>> so that pdev->config will not be used, right?
> 
> If is the latest capability in the list, yes.
> Otherwise it will simply link 'prev' with 'next' using config array 
> offsets.
I got it! Thanks very much for the details!

Jing

> 
> Thanks,
> Marcel
> 
>>
>>> Do you agree? If yes, just call pci_del_capability and you don't need
>>> this patch.
>>>
>> Yup, I agree with you. And let me remove this patch in next version.
>>
>> Thanks,
>> Jing
>>
>>>
>>> Thanks,
>>> Marcel
>>>
>>
>> [...]
> 

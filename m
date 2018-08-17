Received: from eggs.gnu.org ([2001:4830:134:3::10]:58718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqgkB-0002zw-7y
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqgk7-000670-Ou
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:32:55 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:37455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fqgk6-00065p-Sx
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:32:51 -0400
Received: by mail-wm0-x243.google.com with SMTP id n11-v6so7716461wmc.2
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 08:32:50 -0700 (PDT)
References: <1533625449-14989-1-git-send-email-jing2.liu@linux.intel.com>
	<893d9264-7908-4e2c-ae1d-7e46eed6e6a0@redhat.com>
	<e06b10e0-d0b6-d190-6673-f97199bebb72@redhat.com>
	<efc99631-454d-4377-8551-0594fc763c94@gmail.com>
	<4e3d237c-8fb0-47aa-22e0-da25ba071c23@linux.intel.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <d1ddaa0d-2431-774e-62fe-186e0f6a58a9@gmail.com>
Date: Fri, 17 Aug 2018 18:32:47 +0300
MIME-Version: 1.0
In-Reply-To: <4e3d237c-8fb0-47aa-22e0-da25ba071c23@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] hw/pci: add pci capability to pci-pci
 bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Jing2" <jing2.liu@linux.intel.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anthony.xu@intel.com, mst@redhat.com



On 08/14/2018 12:15 PM, Liu, Jing2 wrote:
> Hi Marcel,
>
> On 8/12/2018 3:11 PM, Marcel Apfelbaum wrote:
>> Hi Laszlo,
>>
> [...]
>>>>>   hw/pci-bridge/pci_bridge_dev.c | 20 ++++++++++++++++++++
>>>>>   1 file changed, 20 insertions(+)
>>>>> +cap_error:
>>>>> +    msi_uninit(dev);
>>>> (4) This error handler doesn't look entirely correct; we can reach it
>>>> without having initialized MSI. (MSI setup is conditional; and even if
>>>> we attempt it, it is permitted to fail with "msi=auto".) Therefore,
>>>> msi_uninit() should be wrapped into "if (msi_present())", same as you
>>>> see in pci_bridge_dev_exitfn().
>>
>> You are right.  msi_present should be checked.
>
> I looked at the codes calling this function. It need be added to be 
> strong.
> But could I ask why we need check twice? msi_unint() help check again.

You are right, no need to check again. Sorry for misleading you.

>>
>>>>
>>>>>   msi_error:
>>>>>       slotid_cap_cleanup(dev);
>>>>>   slotid_error:
>>> I tried to understand the error handling a bit better. I'm confused.
>>>
> [...]
>>> Second, msi_uninit() and shpc_cleanup() are internally inconsistent
>>> between each other. The former removes the respective capability from
>>> config space -- with pci_del_capability() --,
>>
>> Right
>>
>>>   but the latter only has a
>>> comment, "/* TODO: cleanup config space changes? */".
>>
>> But also disables the QEMU_PCI_CAP_SLOTID (but no code checks it anyway)
>> I agree it should call pci_del_capability to delete the SHPC capability,
>> maybe is some "debt" from early development stages.
>>
>>>   The same comment
>>> is present in the slotid_cap_cleanup() function. Given this
>>> inconsistency,
>>
>> Here we also miss a call to pci_del_capability.
>>
>>> I don't know what to suggest for the new capability's
>>> teardown, in pci_bridge_dev_exitfn() 
> Aha, yes, the teardown needs to be added here.
> Will add that in next version.
>
> -- should we just ignore it (as
>>> suggested by this patch)?
>>
>> No, we should remove it properly.
>>
>> I think it is not considered a "big" issue since adding/removing PCI 
>> capabilities
>> is not an operation that deals with resources, we only edit an array 
>> (the config space)
>> that will not be used anyway if the device init sequence failed.
>>
>> That does not mean the code should not be clean.
> Do we need set up another serial patches (separated from this
> one) to add pci_del_capability() for slotid_cap_cleanup() and 
> shpc_cleanup()?
>

It would be nice, but as you pointed out, it doesn't have to be part
of this series.

Thanks,
Marcel

> Thanks,
> Jing
>
> [...]

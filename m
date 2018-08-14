Received: from eggs.gnu.org ([2001:4830:134:3::10]:52747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fpVQD-00064b-N3
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 05:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fpVQA-0005BE-Hr
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 05:15:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:19751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1fpVQA-0005Ah-8F
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 05:15:22 -0400
References: <1533625449-14989-1-git-send-email-jing2.liu@linux.intel.com>
	<893d9264-7908-4e2c-ae1d-7e46eed6e6a0@redhat.com>
	<e06b10e0-d0b6-d190-6673-f97199bebb72@redhat.com>
	<efc99631-454d-4377-8551-0594fc763c94@gmail.com>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <4e3d237c-8fb0-47aa-22e0-da25ba071c23@linux.intel.com>
Date: Tue, 14 Aug 2018 17:15:16 +0800
MIME-Version: 1.0
In-Reply-To: <efc99631-454d-4377-8551-0594fc763c94@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anthony.xu@intel.com, mst@redhat.com

Hi Marcel,

On 8/12/2018 3:11 PM, Marcel Apfelbaum wrote:
> Hi Laszlo,
> 
[...]
>>>>   hw/pci-bridge/pci_bridge_dev.c | 20 ++++++++++++++++++++
>>>>   1 file changed, 20 insertions(+)
>>>> +cap_error:
>>>> +    msi_uninit(dev);
>>> (4) This error handler doesn't look entirely correct; we can reach it
>>> without having initialized MSI. (MSI setup is conditional; and even if
>>> we attempt it, it is permitted to fail with "msi=auto".) Therefore,
>>> msi_uninit() should be wrapped into "if (msi_present())", same as you
>>> see in pci_bridge_dev_exitfn().
> 
> You are right.  msi_present should be checked.

I looked at the codes calling this function. It need be added to be strong.
But could I ask why we need check twice? msi_unint() help check again.
> 
>>>
>>>>   msi_error:
>>>>       slotid_cap_cleanup(dev);
>>>>   slotid_error:
>> I tried to understand the error handling a bit better. I'm confused.
>>
[...]
>> Second, msi_uninit() and shpc_cleanup() are internally inconsistent
>> between each other. The former removes the respective capability from
>> config space -- with pci_del_capability() --,
> 
> Right
> 
>>   but the latter only has a
>> comment, "/* TODO: cleanup config space changes? */".
> 
> But also disables the QEMU_PCI_CAP_SLOTID (but no code checks it anyway)
> I agree it should call pci_del_capability to delete the SHPC capability,
> maybe is some "debt" from early development stages.
> 
>>   The same comment
>> is present in the slotid_cap_cleanup() function. Given this
>> inconsistency,
> 
> Here we also miss a call to pci_del_capability.
> 
>> I don't know what to suggest for the new capability's
>> teardown, in pci_bridge_dev_exitfn()  
Aha, yes, the teardown needs to be added here.
Will add that in next version.

-- should we just ignore it (as
>> suggested by this patch)?
> 
> No, we should remove it properly.
> 
> I think it is not considered a "big" issue since adding/removing PCI 
> capabilities
> is not an operation that deals with resources, we only edit an array 
> (the config space)
> that will not be used anyway if the device init sequence failed.
> 
> That does not mean the code should not be clean.
Do we need set up another serial patches (separated from this
one) to add pci_del_capability() for slotid_cap_cleanup() and 
shpc_cleanup()?

Thanks,
Jing

[...]

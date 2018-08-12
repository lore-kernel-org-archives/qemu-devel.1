Received: from eggs.gnu.org ([2001:4830:134:3::10]:38196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fokWx-0005oY-Cb
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 03:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fokWu-0001Ta-6s
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 03:11:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fokWt-0001TJ-Vg
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 03:11:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id e7-v6so11558847wrs.9
	for <qemu-devel@nongnu.org>; Sun, 12 Aug 2018 00:11:11 -0700 (PDT)
References: <1533625449-14989-1-git-send-email-jing2.liu@linux.intel.com>
	<893d9264-7908-4e2c-ae1d-7e46eed6e6a0@redhat.com>
	<e06b10e0-d0b6-d190-6673-f97199bebb72@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <efc99631-454d-4377-8551-0594fc763c94@gmail.com>
Date: Sun, 12 Aug 2018 10:11:07 +0300
MIME-Version: 1.0
In-Reply-To: <e06b10e0-d0b6-d190-6673-f97199bebb72@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>, Jing Liu <jing2.liu@linux.intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anthony.xu@intel.com, mst@redhat.com

Hi Laszlo,

On 08/07/2018 06:59 PM, Laszlo Ersek wrote:
> On 08/07/18 14:19, Laszlo Ersek wrote:
>> On 08/07/18 09:04, Jing Liu wrote:
>>> Add hint to firmware (e.g. SeaBIOS) to reserve addtional
>>> IO/MEM/PREF spaces for legacy pci-pci bridge, to enable
>>> some pci devices hotplugging whose IO/MEM/PREF spaces
>>> requests are larger than the ones in pci-pci bridge set
>>> by firmware.
>>>
>>> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
>>> ---
>>>   hw/pci-bridge/pci_bridge_dev.c | 20 ++++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>> +cap_error:
>>> +    msi_uninit(dev);
>> (4) This error handler doesn't look entirely correct; we can reach it
>> without having initialized MSI. (MSI setup is conditional; and even if
>> we attempt it, it is permitted to fail with "msi=auto".) Therefore,
>> msi_uninit() should be wrapped into "if (msi_present())", same as you
>> see in pci_bridge_dev_exitfn().

You are right.  msi_present should be checked.

>>
>>>   msi_error:
>>>       slotid_cap_cleanup(dev);
>>>   slotid_error:
> I tried to understand the error handling a bit better. I'm confused.
>
> First, under the label "shpc_error", we call pci_bridge_exitfn(), which
> seems to clean up everything (checking individually for each thing to
> clean up). Given this, I wonder why we introduced the "slotid_error" and
> "msi_error" labels at all. Cascading teardown on the error path, and
> invkoing a function that checks everything individually and then tears
> it all down, are usually mutually exclusive.

I think is possible you miss-interpreted pci_bridge_dev_exitfn
with pci_bridge_exitfn. The first one is the "catch all", the second
one that is used in the error path is for the bridge specific cleanup.

> Second, msi_uninit() and shpc_cleanup() are internally inconsistent
> between each other. The former removes the respective capability from
> config space -- with pci_del_capability() --,

Right

>   but the latter only has a
> comment, "/* TODO: cleanup config space changes? */".

But also disables the QEMU_PCI_CAP_SLOTID (but no code checks it anyway)
I agree it should call pci_del_capability to delete the SHPC capability,
maybe is some "debt" from early development stages.

>   The same comment
> is present in the slotid_cap_cleanup() function. Given this
> inconsistency,

Here we also miss a call to pci_del_capability.

> I don't know what to suggest for the new capability's
> teardown, in pci_bridge_dev_exitfn()  -- should we just ignore it (as
> suggested by this patch)?

No, we should remove it properly.

I think it is not considered a "big" issue since adding/removing PCI 
capabilities
is not an operation that deals with resources, we only edit an array  
(the config space)
that will not be used anyway if the device init sequence failed.

That does not mean the code should not be clean.

Thanks,
Marcel

>
> Thanks
> Laszlo
>

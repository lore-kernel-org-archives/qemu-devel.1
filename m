Received: from eggs.gnu.org ([2001:4830:134:3::10]:34686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dxTI1-00036w-J7
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 03:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dxTHw-00010y-PI
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 03:31:21 -0400
Received: from chuckie.co.uk ([82.165.15.123]:44645
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dxTHw-0000xW-IW
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 03:31:16 -0400
References: <1506082711-16004-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<905d94b3-291b-0e55-e234-97fc2c85b6a6@redhat.com>
	<4a9754d9-e73b-8e67-427e-9624d0486c91@ilande.co.uk>
	<26f60ea0-199e-f9ec-5b1d-d7023d60bb03@redhat.com>
	<20170925081140.GA2656@work-vm>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <c0055753-30ba-7cd0-cf64-94e1679678ef@ilande.co.uk>
Date: Thu, 28 Sep 2017 08:31:05 +0100
MIME-Version: 1.0
In-Reply-To: <20170925081140.GA2656@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] pci: allow 32-bit PCI IO accesses to pass
 through the PCI bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com

On 25/09/17 09:11, Dr. David Alan Gilbert wrote:

> * Marcel Apfelbaum (marcel@redhat.com) wrote:
>> On 23/09/2017 11:23, Mark Cave-Ayland wrote:
>>> On 22/09/17 23:18, Laszlo Ersek wrote:
>>>
>>>> On 09/22/17 14:18, Mark Cave-Ayland wrote:
>>>>> Whilst the underlying PCI bridge implementation supports 32-bit PCI IO
>>>>> accesses, unfortunately they are truncated at the legacy 64K limit.
>>>>>
>>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>> ---
>>>>>   hw/pci/pci_bridge.c |    3 ++-
>>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
>>>>> index 17feae5..a47d257 100644
>>>>> --- a/hw/pci/pci_bridge.c
>>>>> +++ b/hw/pci/pci_bridge.c
>>>>> @@ -379,7 +379,8 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
>>>>>       sec_bus->address_space_mem = &br->address_space_mem;
>>>>>       memory_region_init(&br->address_space_mem, OBJECT(br), "pci_bridge_pci", UINT64_MAX);
>>>>>       sec_bus->address_space_io = &br->address_space_io;
>>>>> -    memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io", 65536);
>>>>> +    memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io",
>>>>> +                       UINT32_MAX);
>>>>>       br->windows = pci_bridge_region_init(br);
>>>>>       QLIST_INIT(&sec_bus->child);
>>>>>       QLIST_INSERT_HEAD(&parent->child, sec_bus, sibling);
>>>>>
>>>>
>>
>> Hi Mark,
>>
>>>> Based on the commit message, I assume this change is guest-visible. If
>>>> so, should it be made dependent on a compat property, so that it doesn't
>>>> cause problems with migration?
>>>
>>> In order to enable 32-bit IO accesses the PCI bridge needs to set bit 0
>>> in the IO_LIMIT and IO_BASE registers - this bit is read-only to guests,
>>> so unless a PCI bridge has this bit set then it's impossible for this
>>> change to be guest visible.
>>>
>>> I did a grep for PCI_IO_RANGE_TYPE_32 and didn't see any existing users
>>> (other than an upcoming patchset from me!), so this combined with the
>>> fact that without this patch the feature is broken makes me think that I
>>> am the first user and so existing guests won't have a problem.
>>>
>>
>> (adding Dave for his expertise)
>>
>> Do you know how the migration code will behave if it will have
>> a 65k address space on source and MAX UINT on destination?
>> (and the other way around for rolling back)
> 
> Hmm not sure; we don't migrate regions explicitly; just RAMBlocks
> and devices that back them.  If the change is visible in the IO
> addresses allocated to the PCI devices or in the config space then
> it might fail.

For reference here is the link to the sun4u patch I posted yesterday
that requires this fix if anyone else would like to test:
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg07355.html.

Other than that are there any further objections to this patch?


ATB,

Mark.

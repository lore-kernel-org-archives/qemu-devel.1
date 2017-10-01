Received: from eggs.gnu.org ([2001:4830:134:3::10]:38022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dym7f-0008WK-Tz
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 17:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dym7b-0001L9-5v
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 17:50:03 -0400
Received: from chuckie.co.uk ([82.165.15.123]:38614
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dym7a-0001Kl-VE
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 17:49:59 -0400
References: <1506082711-16004-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<905d94b3-291b-0e55-e234-97fc2c85b6a6@redhat.com>
	<4a9754d9-e73b-8e67-427e-9624d0486c91@ilande.co.uk>
	<26f60ea0-199e-f9ec-5b1d-d7023d60bb03@redhat.com>
	<20170925081140.GA2656@work-vm>
	<c0055753-30ba-7cd0-cf64-94e1679678ef@ilande.co.uk>
	<f1353944-8a03-ed58-f4d1-beda8465ed5b@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <35a7ef49-423c-adcb-f958-4b86378da1ee@ilande.co.uk>
Date: Sun, 1 Oct 2017 22:49:47 +0100
MIME-Version: 1.0
In-Reply-To: <f1353944-8a03-ed58-f4d1-beda8465ed5b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] pci: allow 32-bit PCI IO accesses to pass
 through the PCI bridge
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com
List-ID: <qemu-devel.nongnu.org>

On 28/09/17 10:19, Marcel Apfelbaum wrote:

> On 28/09/2017 10:31, Mark Cave-Ayland wrote:
>> On 25/09/17 09:11, Dr. David Alan Gilbert wrote:
>>
>>> * Marcel Apfelbaum (marcel@redhat.com) wrote:
>>>> On 23/09/2017 11:23, Mark Cave-Ayland wrote:
>>>>> On 22/09/17 23:18, Laszlo Ersek wrote:
>>>>>
>>>>>> On 09/22/17 14:18, Mark Cave-Ayland wrote:
>>>>>>> Whilst the underlying PCI bridge implementation supports 32-bit
>>>>>>> PCI IO
>>>>>>> accesses, unfortunately they are truncated at the legacy 64K limit.
>>>>>>>
>>>>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>>>> ---
>>>>>>>    hw/pci/pci_bridge.c |    3 ++-
>>>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
>>>>>>> index 17feae5..a47d257 100644
>>>>>>> --- a/hw/pci/pci_bridge.c
>>>>>>> +++ b/hw/pci/pci_bridge.c
>>>>>>> @@ -379,7 +379,8 @@ void pci_bridge_initfn(PCIDevice *dev, const
>>>>>>> char *typename)
>>>>>>>        sec_bus->address_space_mem = &br->address_space_mem;
>>>>>>>        memory_region_init(&br->address_space_mem, OBJECT(br),
>>>>>>> "pci_bridge_pci", UINT64_MAX);
>>>>>>>        sec_bus->address_space_io = &br->address_space_io;
>>>>>>> -    memory_region_init(&br->address_space_io, OBJECT(br),
>>>>>>> "pci_bridge_io", 65536);
>>>>>>> +    memory_region_init(&br->address_space_io, OBJECT(br),
>>>>>>> "pci_bridge_io",
>>>>>>> +                       UINT32_MAX);
>>>>>>>        br->windows = pci_bridge_region_init(br);
>>>>>>>        QLIST_INIT(&sec_bus->child);
>>>>>>>        QLIST_INSERT_HEAD(&parent->child, sec_bus, sibling);
>>>>>>>
>>>>>>
>>>>
>>>> Hi Mark,
>>>>
>>>>>> Based on the commit message, I assume this change is
>>>>>> guest-visible. If
>>>>>> so, should it be made dependent on a compat property, so that it
>>>>>> doesn't
>>>>>> cause problems with migration?
>>>>>
>>>>> In order to enable 32-bit IO accesses the PCI bridge needs to set
>>>>> bit 0
>>>>> in the IO_LIMIT and IO_BASE registers - this bit is read-only to
>>>>> guests,
>>>>> so unless a PCI bridge has this bit set then it's impossible for this
>>>>> change to be guest visible.
>>>>>
>>>>> I did a grep for PCI_IO_RANGE_TYPE_32 and didn't see any existing
>>>>> users
>>>>> (other than an upcoming patchset from me!), so this combined with the
>>>>> fact that without this patch the feature is broken makes me think
>>>>> that I
>>>>> am the first user and so existing guests won't have a problem.
>>>>>
>>>>
>>>> (adding Dave for his expertise)
>>>>
>>>> Do you know how the migration code will behave if it will have
>>>> a 65k address space on source and MAX UINT on destination?
>>>> (and the other way around for rolling back)
>>>
>>> Hmm not sure; we don't migrate regions explicitly; just RAMBlocks
>>> and devices that back them.  If the change is visible in the IO
>>> addresses allocated to the PCI devices or in the config space then
>>> it might fail.
>>
>> For reference here is the link to the sun4u patch I posted yesterday
>> that requires this fix if anyone else would like to test:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg07355.html.
>>
>> Other than that are there any further objections to this patch?
>>
> 
> Since we don't support 32-bit IO accesses (yet) in x86
> and the address space is not visible to guest, it should be OK.
> I'll run a simple migration test to be sure, I'll let you
> know if something goes wrong.

Fantastic! In that case I'll assume that no news is good news :)  Do you
know approximately how long it will be before the patch gets merged? I'm
just trying to get a feel for when I can send the pull request for the
sun4u changes which I'd like to do soon if possible given that it's such
a large change.


ATB,

Mark.

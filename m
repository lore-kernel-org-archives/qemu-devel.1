Received: from eggs.gnu.org ([2001:4830:134:3::10]:59821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dfOfg-0004nc-1Y
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dfOfc-00019D-N9
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:57:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dfOfc-00018Z-ER
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:57:00 -0400
References: <743158bc-15e4-46fe-38cb-161397b5b240@linaro.org>
	<3685aed3-735f-ae62-73a9-8f4a5c7cd459@redhat.com>
	<9be585e2-4641-329e-f442-69ae05faadba@redhat.com>
	<ea6acc7c-09a6-70ed-9ff0-865bd45a47f3@redhat.com>
	<24fa9f25-912e-8903-920e-b28feba492d2@redhat.com>
	<0f748b72-69de-1122-767d-b36dadad46fc@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c03faf70-9bad-aea7-00ed-8825e8770d03@redhat.com>
Date: Wed, 9 Aug 2017 12:56:53 +0200
MIME-Version: 1.0
In-Reply-To: <0f748b72-69de-1122-767d-b36dadad46fc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Qemu and 32 PCIe devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Drew Jones <drjones@redhat.com>, Christoffer Dall <cdall@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Gema Gomez-Solano <gema.gomez-solano@linaro.org>, Marc Zygnier <marc.zyngier@arm.com>

On 08/09/17 12:16, Paolo Bonzini wrote:
> On 09/08/2017 12:00, Laszlo Ersek wrote:
>> On 08/09/17 09:26, Paolo Bonzini wrote:
>>> On 09/08/2017 03:06, Laszlo Ersek wrote:
>>>>>   20.14%  qemu-system-x86_64                  [.] render_memory_region
>>>>>   17.14%  qemu-system-x86_64                  [.] subpage_register
>>>>>   10.31%  qemu-system-x86_64                  [.] int128_add
>>>>>    7.86%  qemu-system-x86_64                  [.] addrrange_end
>>>>>    7.30%  qemu-system-x86_64                  [.] int128_ge
>>>>>    4.89%  qemu-system-x86_64                  [.] int128_nz
>>>>>    3.94%  qemu-system-x86_64                  [.] phys_page_compact
>>>>>    2.73%  qemu-system-x86_64                  [.] phys_map_node_alloc
>>>
>>> Yes, this is the O(n^3) thing.  An optimized build should be faster
>>> because int128 operations will be inlined and become much more efficient.
>>>
>>>> With this patch, I only tested the "93 devices" case, as the slowdown
>>>> became visible to the naked eye from the trace messages, as the firmware
>>>> enabled more and more BARs / command registers (and inversely, the
>>>> speedup was perceivable when the firmware disabled more and more BARs /
>>>> command registers).
>>>
>>> This is an interesting observation, and it's expected.  Looking at the
>>> O(n^3) complexity more in detail you have N operations, where the "i"th
>>> operates on "i" DMA address spaces, all of which have at least "i"
>>> memory regions (at least 1 BAR per device).
>>
>> - Can you please give me a pointer to the code where the "i"th operation
>> works on "i" DMA address spaces? (Not that I dream about patching *that*
>> code, wherever it may live :) )
> 
> It's all driven by actions of the guest.
> 
> Simply, by the time you get to the "i"th command register, you have
> enabled bus-master DMA on "i" devices (so that "i" DMA address spaces
> are non-empty) and you have enabled BARs on "i" devices (so that their
> BARs are included in the address spaces).
> 
>> - You mentioned that changing this is on the ToDo list. I couldn't find
>> it under <https://wiki.qemu.org/index.php/ToDo>. Is it tracked somewhere
>> else?
> 
> I've added it to https://wiki.qemu.org/index.php/ToDo/MemoryAPI (thanks
> for the nudge).

Thank you!

Allow me one last question -- why (and since when) does each device have
its own separate address space? Is that related to the virtual IOMMU?

Now that I look at the "info mtree" monitor output of a random VM, I see
the following "address-space"s:
- memory
- I/O
- cpu-memory
- bunch of nameless ones, with top level regions called
  "bus master container"
- several named "virtio-pci-cfg-as"
- KVM-SMRAM

I (sort of) understand MemoryRegions and aliases, but:
- I don't know why "memory" and "cpu-memory" exist separately, for example,
- I seem to remember that the "bunch of nameless ones" has not always
been there? (I could be totally wrong, of course.)

... There is one address_space_init() call in "hw/pci/pci.c", and it
comes (most recently) from commit 3716d5902d74 ("pci: introduce a bus
master container", 2017-03-13). The earliest commit that added it seems
to be 817dcc536898 ("pci: give each device its own address space",
2012-10-03). The commit messages do mention IOMMUs.

Thanks!
Laszlo

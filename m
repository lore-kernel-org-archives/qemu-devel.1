Received: from eggs.gnu.org ([2001:4830:134:3::10]:48578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dfV27-0002Zk-V9
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 13:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dfV24-0002lD-02
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 13:44:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dfV23-0002kq-N8
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 13:44:35 -0400
References: <1501964858-5159-1-git-send-email-zuban32s@gmail.com>
	<1501964858-5159-6-git-send-email-zuban32s@gmail.com>
	<87e569e6-e1ec-4238-e073-38c0e136af0d@redhat.com>
	<CAKSfGUD3cy7hMxT6PQULk21PO16e=s3A5jq_fZfR_J6rk325eg@mail.gmail.com>
	<888c4489-5603-0361-2a42-a4fbc3c70779@redhat.com>
	<CAKSfGUC2Tu=xswSK_nUSt1F7Qs0rCw0a1TW3Wn0mg56kSWTerA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8ad4ca96-1837-bb2e-c6bc-c11c70ba88fb@redhat.com>
Date: Wed, 9 Aug 2017 19:44:24 +0200
MIME-Version: 1.0
In-Reply-To: <CAKSfGUC2Tu=xswSK_nUSt1F7Qs0rCw0a1TW3Wn0mg56kSWTerA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 5/5] docs: update documentation
 considering PCIE-PCI bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, seabios@seabios.org, Kevin OConnor <kevin@koconnor.net>, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net

On 08/09/17 18:52, Aleksandr Bezzubikov wrote:
> 2017-08-09 13:18 GMT+03:00 Laszlo Ersek <lersek@redhat.com>:
>> On 08/08/17 21:21, Aleksandr Bezzubikov wrote:
>>> 2017-08-08 18:11 GMT+03:00 Laszlo Ersek <lersek@redhat.com>:
>>>> one comment below
>>>>
>>>> On 08/05/17 22:27, Aleksandr Bezzubikov wrote:
>>>>
>>>>> +Capability layout (defined in include/hw/pci/pci_bridge.h):
>>>>> +
>>>>> +    uint8_t id;     Standard PCI capability header field
>>>>> +    uint8_t next;   Standard PCI capability header field
>>>>> +    uint8_t len;    Standard PCI vendor-specific capability header field
>>>>> +
>>>>> +    uint8_t type;   Red Hat vendor-specific capability type
>>>>> +                    List of currently existing types:
>>>>> +                        QEMU_RESERVE = 1
>>>>> +
>>>>> +
>>>>> +    uint32_t bus_res;   Minimum number of buses to reserve
>>>>> +
>>>>> +    uint64_t io;        IO space to reserve
>>>>> +    uint64_t mem        Non-prefetchable memory to reserve
>>>>> +    uint64_t mem_pref;  Prefetchable memory to reserve
>>>>
>>>> (I apologize if I missed any concrete points from the past messages
>>>> regarding this structure.)
>>>>
>>>> How is the firmware supposed to know whether the prefetchable MMIO
>>>> reservation should be made in 32-bit or 64-bit address space? If we
>>>> reserve prefetchable MMIO outside of the 32-bit address space, then
>>>> hot-plugging a device without 64-bit MMIO support could fail.
>>>>
>>>> My earlier request, to distinguish "prefetchable_32" from
>>>> "prefetchable_64" (mutually exclusively), was so that firmware would
>>>> know whether to restrict the MMIO reservation to 32-bit address
>>>> space.
>>>
>>> IIUC now (in SeaBIOS at least) we just assign this PREF registers
>>> unconditionally,
>>> so the decision about the mode can be made basing on !=0
>>> UPPER_PREF_LIMIT register.
>>> My idea was the same - we can just check if the value doesn't fit into
>>> 16-bit (PREF_LIMIT reg size, 32-bit MMIO). Do we really need separate
>>> fields for that?
>>
>> The PciBusDxe driver in edk2 tracks 32-bit and 64-bit MMIO resources
>> separately from each other, and other (independent) logic exists in it
>> that, on some conditions, allocates 64-bit MMIO BARs from 32-bit address
>> space. This is just to say that the distinction is intentional in
>> PciBusDxe.
>>
>> Furthermore, the Platform Init spec v1.6 says the following (this is
>> what OVMF will have to comply with, in the "platform hook" called by
>> PciBusDxe):
>>
>>> 12.6 PCI Hot Plug PCI Initialization Protocol
>>> EFI_PCI_HOT_PLUG_INIT_PROTOCOL.GetResourcePadding()
>>> ...
>>> Padding  The amount of resource padding that is required by the PCI
>>>          bus under the control of the specified HPC. Because the
>>>          caller does not know the size of this buffer, this buffer is
>>>          allocated by the callee and freed by the caller.
>>> ...
>>> The padding is returned in the form of ACPI (2.0 & 3.0) resource
>>> descriptors. The exact definition of each of the fields is the same as
>>> in the
>>> EFI_PCI_HOST_BRIDGE_RESOURCE_ALLOCATION_PROTOCOL.SubmitResources()
>>> function. See the section 10.8 for the definition of this function.
>>
>> Following that pointer:
>>
>>> 10.8 PCI HostBridge Code Definitions
>>> 10.8.2 PCI Host Bridge Resource Allocation Protocol
>>>
>>> Table 8. ACPI 2.0 & 3.0 QWORD Address Space Descriptor Usage
>>>
>>> Byte    Byte    Data  Description
>>> Offset  Length
>>> ...
>>> 0x03    0x01          Resource type:
>>>                         0: Memory range
>>>                         1: I/O range
>>>                         2: Bus number range
>>> ...
>>> 0x05    0x01          Type-specific flags. Ignored except as defined
>>>                       in Table 3-3 and Table 3-4 below.
>>>
>>> 0x06    0x08          Address Space Granularity. Used to differentiate
>>>                       between a 32-bit memory request and a 64-bit
>>>                       memory request. For a 32-bit memory request,
>>>                       this field should be set to 32. For a 64-bit
>>>                       memory request, this field should be set to 64.
>>>                       Ignored for I/O and bus resource requests.
>>>                       Ignored during GetProposedResources().
>>
>> The "Table 3-3" and "Table 3-4" references under "Type-specific flags"
>> are out of date (spec bug); in reality those are:
>> - Table 10. I/O Resource Flag (Resource Type = 1) Usage,
>> - Table 11. Memory Resource Flag (Resource Type = 0) Usage.
>>
>> The latter is relevant here:
>>
>>> Table 11. Memory Resource Flag (Resource Type = 0) Usage
>>>
>>> Bits      Meaning
>>> ...
>>> Bit[2:1]  _MEM. Memory attributes.
>>>           Value and Meaning:
>>>             0 The memory is nonprefetchable.
>>>             1 Invalid.
>>>             2 Invalid.
>>>             3 The memory is prefetchable.
>>>           Note: The interpretation of these bits is somewhat different
>>>           from the ACPI Specification. According to the ACPI
>>>           Specification, a value of 0 implies noncacheable memory and
>>>           the value of 3 indicates prefetchable and cacheable memory.
>>
>> So whatever OVMF sees in the capability, it must be able to translate to
>> the above representation.
> 
> OK, I got it.
> Then I suggest this part of the cap look like
> 
> uint64_t mem_pref_32;
> uint64_t mem_pref_64;
> 
> 'mem_pref_32' field can be uint32_t, but this will require 4-byte padding,
> so what looks more preferable here - uint64_t for 32-bit value or
> 4-byte padding in the middle
> of the capapbility?

The last field before this part is "uint64_t io", and it is naturally
aligned. So, how about:

- uint32_t mem;         /* non-prefetchable, 32-bit only */
- uint32_t mem_pref_32; /* prefetchable, 32-bit,
                         * mutually exclusive with mem_pref_64
                         */
- uint64_t mem_pref_64; /* prefetchable, 64-bit,
                         * mutually exclusive with mem_pref_32
                         */

Again, the comments to the right come from the email that I got earlier
from Alex Williamson (which he wrote "according to Table 3-2 in the
PCI-to-PCI bridge spec rev 1.2").

IOW, "mem" need not be uint64_t, it can be uint32_t just as well, and
then we don't need padding for "mem_pref_32" either.

(I also think "uint64_t io" is overkill, but I care precious little
about IO reservation, beyond *disabling* it :) I intend to implement
"io" as well, of course.)

Thanks!
Laszlo

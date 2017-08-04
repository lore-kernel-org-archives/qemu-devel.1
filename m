Received: from eggs.gnu.org ([2001:4830:134:3::10]:36991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1ddhoj-0001lD-HW
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 14:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1ddhoi-0005lB-8l
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 14:59:25 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1ddhoh-0005jw-WA
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 14:59:24 -0400
Received: by mail-pf0-x242.google.com with SMTP id t83so2611095pfj.3
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 11:59:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKSfGUBXxbpv6Jmr+ir5xrssJxtKUrrOSnNWCd=RiKup04VJsw@mail.gmail.com>
References: <1501284872-2078-1-git-send-email-zuban32s@gmail.com>
	<1501284872-2078-3-git-send-email-zuban32s@gmail.com>
	<20170731165717-mutt-send-email-mst@kernel.org>
	<362df6d1-b5f8-fd37-13f4-836eb5e86da7@redhat.com>
	<CAKSfGUBdyy9p0S=TEEbOVcBaKXTyG9VNhWSfNUvirAus=Yi+Cg@mail.gmail.com>
	<20170731215618-mutt-send-email-mst@kernel.org>
	<CAKSfGUB=wSZ1eeu8QuHyNCvBEYWMo3m_rsJWVRZcPs2649RZvw@mail.gmail.com>
	<b5380d93-f250-e5a8-2a92-46c902d793fc@redhat.com>
	<CAKSfGUBXxbpv6Jmr+ir5xrssJxtKUrrOSnNWCd=RiKup04VJsw@mail.gmail.com>
From: Alexander Bezzubikov <zuban32s@gmail.com>
Date: Fri, 4 Aug 2017 21:59:20 +0300
Message-ID: <CAKSfGUCj-a+zU4c28vGPF5OFsNrD4waqQh-iYCnUL+TWiq=OZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 2/3] pci: add QEMU-specific PCI
 capability structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, seabios@seabios.org, Kevin OConnor <kevin@koconnor.net>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

2017-08-01 20:28 GMT+03:00 Alexander Bezzubikov <zuban32s@gmail.com>:
> 2017-08-01 16:38 GMT+03:00 Marcel Apfelbaum <marcel@redhat.com>:
>> On 31/07/2017 22:01, Alexander Bezzubikov wrote:
>>>
>>> 2017-07-31 21:57 GMT+03:00 Michael S. Tsirkin <mst@redhat.com>:
>>>>
>>>> On Mon, Jul 31, 2017 at 09:54:55PM +0300, Alexander Bezzubikov wrote:
>>>>>
>>>>> 2017-07-31 17:09 GMT+03:00 Marcel Apfelbaum <marcel@redhat.com>:
>>>>>>
>>>>>> On 31/07/2017 17:00, Michael S. Tsirkin wrote:
>>>>>>>
>>>>>>>
>>>>>>> On Sat, Jul 29, 2017 at 02:34:31AM +0300, Aleksandr Bezzubikov wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On PCI init PCI bridge devices may need some
>>>>>>>> extra info about bus number to reserve, IO, memory and
>>>>>>>> prefetchable memory limits. QEMU can provide this
>>>>>>>> with special vendor-specific PCI capability.
>>>>>>>>
>>>>>>>> This capability is intended to be used only
>>>>>>>> for Red Hat PCI bridges, i.e. QEMU cooperation.
>>>>>>>>
>>>>>>>> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
>>>>>>>> ---
>>>>>>>>    src/fw/dev-pci.h | 62
>>>>>>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>    1 file changed, 62 insertions(+)
>>>>>>>>    create mode 100644 src/fw/dev-pci.h
>>>>>>>>
>>>>>>>> diff --git a/src/fw/dev-pci.h b/src/fw/dev-pci.h
>>>>>>>> new file mode 100644
>>>>>>>> index 0000000..fbd49ed
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/src/fw/dev-pci.h
>>>>>>>> @@ -0,0 +1,62 @@
>>>>>>>> +#ifndef _PCI_CAP_H
>>>>>>>> +#define _PCI_CAP_H
>>>>>>>> +
>>>>>>>> +#include "types.h"
>>>>>>>> +
>>>>>>>> +/*
>>>>>>>> +
>>>>>>>> +QEMU-specific vendor(Red Hat)-specific capability.
>>>>>>>> +It's intended to provide some hints for firmware to init PCI
>>>>>>>> devices.
>>>>>>>> +
>>>>>>>> +Its is shown below:
>>>>>>>> +
>>>>>>>> +Header:
>>>>>>>> +
>>>>>>>> +u8 id;       Standard PCI Capability Header field
>>>>>>>> +u8 next;     Standard PCI Capability Header field
>>>>>>>> +u8 len;      Standard PCI Capability Header field
>>>>>>>> +u8 type;     Red Hat vendor-specific capability type:
>>>>>>>> +               now only REDHAT_QEMU_CAP 1 exists
>>>>>>>> +Data:
>>>>>>>> +
>>>>>>>> +u16 non_prefetchable_16;     non-prefetchable memory limit
>>>>>>>> +
>>>>>>>> +u8 bus_res;  minimum bus number to reserve;
>>>>>>>> +             this is necessary for PCI Express Root Ports
>>>>>>>> +             to support PCIE-to-PCI bridge hotplug
>>>>>>>> +
>>>>>>>> +u8 io_8;     IO limit in case of 8-bit limit value
>>>>>>>> +u32 io_32;   IO limit in case of 16-bit limit value
>>>>>>>> +             io_8 and io_16 are mutually exclusive, in other words,
>>>>>>>> +             they can't be non-zero simultaneously
>>>>>>>> +
>>>>>>>> +u32 prefetchable_32;         non-prefetchable memory limit
>>>>>>>> +                             in case of 32-bit limit value
>>>>>>>> +u64 prefetchable_64;         non-prefetchable memory limit
>>>>>>>> +                             in case of 64-bit limit value
>>>>>>>> +                             prefetachable_32 and prefetchable_64
>>>>>>>> are
>>>>>>>> +                             mutually exclusive, in other words,
>>>>>>>> +                             they can't be non-zero simultaneously
>>>>>>>> +If any field in Data section is 0,
>>>>>>>> +it means that such kind of reservation
>>>>>>>> +is not needed.
>>>>>
>>>>>
>>>>> I really don't like this 'mutually exclusive' fields approach because
>>>>> IMHO it increases confusion level when undertanding this capability
>>>>> structure.
>>>>> But - if we came to consensus on that, then IO fields should be used
>>>>> in the same way,
>>>>> because as I understand, this 'mutual exclusivity' serves to distinguish
>>>>> cases
>>>>> when we employ only *_LIMIT register and both *_LIMIT an UPPER_*_LIMIT
>>>>> registers.
>>>>> And this is how both IO and PREFETCHABLE works, isn't it?
>>>>
>>>>
>>>> I would just use simeple 64 bit registers. PCI spec has an ugly format
>>>> with fields spread all over the place but that is because of
>>>> compatibility concerns. It makes not sense to spend cycles just
>>>> to be similarly messy.
>>>
>>>
>>> Then I suggest to use exactly one field of a maximum possible size
>>> for each reserving object, and get rid of mutually exclusive fields.
>>> Then it can be something like that (order and names can be changed):
>>> u8 bus;
>>> u16 non_pref;
>>> u32 io;
>>> u64 pref;
>>>
>>
>> I think Michael suggested:
>>
>>     u64 bus_res;
>>     u64 mem_res;
>>     u64 io_res;
>>     u64 mem_pref_res;
>>
>> OR:
>>     u32 bus_res;
>>     u32 mem_res;
>>     u32 io_res;
>>     u64 mem_pref_res;
>>
>>
>> We can use 0XFFF..F as "not-set" value "merging" Gerd's and Michael's
>> requests.
>
> Let's dwell on the second option (with -1 as 'ignore' sign), if no new
> objections.
>

BTW, talking about limit values provided in the capability - do we
want to completely override
existing PCI resources allocation mechanism being used in SeaBIOS, I
mean, to assign capability
values hardly, not taking into consideration any existing checks,
or somehow make this process soft (not an obvious way, can lead to
another big discussion)?

In other words, how do we plan to use IO/MEM/PREF limits provided in
this capability
in application to the PCIE Root Port, what result is this supposed to achieve?

>>
>> Thanks,
>> Marcel
>>
>>
>>>
>>>>
>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Hi Michael,
>>>>>>
>>>>>>> We also want a way to say "no hint for this type".
>>>>>>>
>>>>>>> One way to achive this would be to have instead multiple
>>>>>>> vendor specific capabilities, one for each of
>>>>>>> bus#/io/mem/prefetch. 0 would mean do not reserve anything,
>>>>>>> absence of capability would mean "no info, up to firmware".
>>>>>>>
>>>>>>
>>>>>> First version of the series was implemented exactly like you propose,
>>>>>> however Gerd preferred only one capability with multiple fields.
>>>>>>
>>>>>> I personally like the simplicity of vendor cap per io/mem/bus,
>>>>>> even if it is on the expense of the limited PCI Config space.
>>>>>>
>>>>>
>>>>> Personally I agree with Marcel since all this fields express
>>>>> reservations of some objects.
>>>>>
>>>>>> We need a consensus here :)
>>>>>>
>>>>>
>>>>> Absolutely :)
>>>>>
>>>>>> Thanks,
>>>>>> Marcel
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>> +
>>>>>>>> +*/
>>>>>>>> +
>>>>>>>> +/* Offset of vendor-specific capability type field */
>>>>>>>> +#define PCI_CAP_VNDR_SPEC_TYPE  3
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> This is a QEMU specific thing. Please name it as such.
>>>>>>>
>>>>>>>> +
>>>>>>>> +/* List of valid Red Hat vendor-specific capability types */
>>>>>>>> +#define REDHAT_CAP_TYPE_QEMU    1
>>>>>>>> +
>>>>>>>> +
>>>>>>>> +/* Offsets of QEMU capability fields */
>>>>>>>> +#define QEMU_PCI_CAP_NON_PREF   4
>>>>>>>> +#define QEMU_PCI_CAP_BUS_RES    6
>>>>>>>> +#define QEMU_PCI_CAP_IO_8       7
>>>>>>>> +#define QEMU_PCI_CAP_IO_32      8
>>>>>>>> +#define QEMU_PCI_CAP_PREF_32    12
>>>>>>>> +#define QEMU_PCI_CAP_PREF_64    16
>>>>>>>> +#define QEMU_PCI_CAP_SIZE       24
>>>>>>>> +
>>>>>>>> +#endif /* _PCI_CAP_H */
>>>>>>>> --
>>>>>>>> 2.7.4
>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> Alexander Bezzubikov
>>>
>>>
>>>
>>>
>>
>
>
>
> --
> Aleksandr Bezzubikov



-- 
Aleksandr Bezzubikov

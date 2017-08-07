Received: from eggs.gnu.org ([2001:4830:134:3::10]:35079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dekUR-00005x-Je
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dekUM-0004AL-K7
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:02:47 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:37807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dekUM-000491-Dj
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:02:42 -0400
Received: by mail-pf0-x243.google.com with SMTP id p13so771762pfd.4
	for <qemu-devel@nongnu.org>; Mon, 07 Aug 2017 09:02:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5d72a8a3-5990-4b9c-8d29-3a09fec9ad22@redhat.com>
References: <1501964994-5257-1-git-send-email-zuban32s@gmail.com>
	<1501964994-5257-3-git-send-email-zuban32s@gmail.com>
	<5d72a8a3-5990-4b9c-8d29-3a09fec9ad22@redhat.com>
From: Alexander Bezzubikov <zuban32s@gmail.com>
Date: Mon, 7 Aug 2017 19:02:38 +0300
Message-ID: <CAKSfGUDnpSnkfBC-cCwdjh--HY3MqbccZVfJV5qGFC_hTiz0kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 2/3] pci: add QEMU-specific PCI
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
Cc: seabios@seabios.org, "Michael S. Tsirkin" <mst@redhat.com>, Kevin OConnor <kevin@koconnor.net>, Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

2017-08-07 18:52 GMT+03:00 Marcel Apfelbaum <marcel@redhat.com>:
> On 05/08/2017 23:29, Aleksandr Bezzubikov wrote:
>>
>> On PCI init PCI bridge devices may need some
>> extra info about bus number to reserve, IO, memory and
>> prefetchable memory limits. QEMU can provide this
>> with special vendor-specific PCI capability.
>>
>> This capability is intended to be used only
>> for Red Hat PCI bridges, i.e. QEMU cooperation.
>>
>> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
>> ---
>>   src/fw/dev-pci.h | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>   create mode 100644 src/fw/dev-pci.h
>>
>> diff --git a/src/fw/dev-pci.h b/src/fw/dev-pci.h
>> new file mode 100644
>> index 0000000..2c8ddb0
>
>
> Hi Aleksandr,
>

Hi Marcel,

>> --- /dev/null
>> +++ b/src/fw/dev-pci.h
>> @@ -0,0 +1,50 @@
>> +#ifndef _PCI_CAP_H
>> +#define _PCI_CAP_H
>> +
>> +#include "types.h"
>> +
>> +/*
>> +
>
>
> Please use the standard comment:
>
> /*
>  *
>  *
>  */
>
>
>> +QEMU-specific vendor(Red Hat)-specific capability.
>> +It's intended to provide some hints for firmware to init PCI devices.
>> +
>> +Its structure is shown below:
>> +
>> +Header:
>> +
>> +u8 id;       Standard PCI Capability Header field
>> +u8 next;     Standard PCI Capability Header field
>> +u8 len;      Standard PCI Capability Header field
>> +u8 type;     Red Hat vendor-specific capability type:
>> +               now only REDHAT_CAP_TYP_QEMU=1 exists
>
>
> Typo o the line before, but I think you don't need it there.
>
>> +Data:
>> +
>> +u32 bus_res;            minimum bus number to reserve;
>> +                        this is necessary for PCI Express Root Ports
>> +                        to support PCIE-to-PCI bridge hotplug
>
>
> I would add a broader class of usage:
>      necessary for nesting PCI bridges hotplug.
>
>> +u64 io;                 IO space to reserve
>> +u64 mem;                non-prefetchable memory space to reserve
>> +u64 prefetchable_mem;   prefetchable memory space to reserve
>> +
>
>
> Layout looks good to me.
>
>> +If any field value in Data section is -1,
>> +it means that such kind of reservation
>> +is not needed and must be ignored.
>> +
>
>
> -1 is not a valid value for unsigned fields, you may
> want to say 0xff..f or some other way.

I meant cast to unsigned here (because we still use unsigned types),
but if it can mislead someone I will change this.

>
>> +*/
>> +
>> +/* Offset of vendor-specific capability type field */
>> +#define PCI_CAP_REDHAT_TYPE  3
>
>
> May I ask why why '3'? I am not against it, I just
> want to understand the number.
>

This is actually an offset to this field

>> +
>> +/* List of valid Red Hat vendor-specific capability types */
>> +#define REDHAT_CAP_TYPE_QEMU    1
>
>
> I think I pointed this in another thread, the name is
> too vague, please change it to something like:
>    REDHAT_CAP_RES_RESERVE_QEMU
> that narrows down the intend.
>

What does the first 'RES' mean?

>> +
>> +
>> +/* Offsets of QEMU capability fields */
>> +#define QEMU_PCI_CAP_BUS_RES        4
>> +#define QEMU_PCI_CAP_LIMITS_OFFSET  8
>> +#define QEMU_PCI_CAP_IO             8
>> +#define QEMU_PCI_CAP_MEM            16
>> +#define QEMU_PCI_CAP_PREF_MEM       24
>> +#define QEMU_PCI_CAP_SIZE           32
>> +
>> +#endif /* _PCI_CAP_H */
>>
>
> The layout looks good to me.
>
> Thanks,
> Marcel



-- 
Aleksandr Bezzubikov

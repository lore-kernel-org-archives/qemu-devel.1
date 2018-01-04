Received: from eggs.gnu.org ([2001:4830:134:3::10]:58679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eXCVg-00026r-MK
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 15:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eXCVd-0003CL-VG
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 15:53:08 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:39256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eXCVd-0003Ao-Kv
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 15:53:05 -0500
References: <20171229142922.31701-1-hpoussin@reactos.org>
	<20171229142922.31701-7-hpoussin@reactos.org>
	<f888dde1-6b46-b9f5-f819-6fb8d48019de@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <0bb8add8-6d5e-244d-6a88-8ea3f3cf5c91@reactos.org>
Date: Thu, 4 Jan 2018 21:53:01 +0100
MIME-Version: 1.0
In-Reply-To: <f888dde1-6b46-b9f5-f819-6fb8d48019de@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 06/16] piix4: add Reset Control Register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Le 04/01/2018 à 16:50, Marcel Apfelbaum a écrit :
> On 29/12/2017 16:29, Hervé Poussineau wrote:
>> The RCR I/O port (0xcf9) is used to generate a hard reset or a soft reset.
>>
>> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
>> ---
>>   hw/isa/piix4.c | 35 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
>> index 4f476dc7e6..7c83e7c23d 100644
>> --- a/hw/isa/piix4.c
>> +++ b/hw/isa/piix4.c
>> @@ -2,6 +2,7 @@
>>    * QEMU PIIX4 PCI Bridge Emulation
>>    *
>>    * Copyright (c) 2006 Fabrice Bellard
>> + * Copyright (c) 2016 Hervé Poussineau
> 
> I think 2018 :)

Oops :) Initial work was already done 2 years ago...

> 
>>    *
>>    * Permission is hereby granted, free of charge, to any person obtaining a copy
>>    * of this software and associated documentation files (the "Software"), to deal
>> @@ -33,6 +34,10 @@ PCIDevice *piix4_dev;
>>   typedef struct PIIX4State {
>>       PCIDevice dev;
>> +
>> +    /* Reset Control Register */
>> +    MemoryRegion rcr_mem;
>> +    uint8_t rcr;
>>   } PIIX4State;
>>   #define TYPE_PIIX4_PCI_DEVICE "PIIX4"
>> @@ -87,6 +92,30 @@ static const VMStateDescription vmstate_piix4 = {
>>       }
>>   };
>> +static void piix4_rcr_write(void *opaque, hwaddr addr, uint64_t val,
>> +                            unsigned int len)
>> +{
>> +    PIIX4State *s = opaque;
>> +
>> +    if (val & 4) {
>> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>> +        return;
>> +    }
>> +    s->rcr = val & 2; /* keep System Reset type only */
> 
> How does it work? When do we reset the value?

The value is never reset. According to datasheet:
- bits 7:3 and 0 are reserved. We don't keep those bits in s->rcr.
- bit 2 ("Reset CPU") resets the system when transitioning from 0 to 1. It is never read as 0, so we don't keep it in s->rcr.
- bit 1 ("System Reset") tells if we need to do a hard reset (1) or a soft reset (0). This bit is kept accross reboots.

Note that piix3 also does the same thing in hw/pci-host/piix.c in rcr_write()

> 
>> +}
>> +
>> +static uint64_t piix4_rcr_read(void *opaque, hwaddr addr, unsigned int len)
>> +{
>> +    PIIX4State *s = opaque;
>> +    return s->rcr;
>> +}
>> +
>> +static const MemoryRegionOps piix4_rcr_ops = {
>> +    .read = piix4_rcr_read,
>> +    .write = piix4_rcr_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN
> 
> Maybe we need to specify the access_size.
> Something like:
> .impl = {
>          .min_access_size = 1,
>          .max_access_size = 1,
>      },
> 

Not a problem, I will add it.

> Thanks,
> Marcel
> 
>> +};
>> +
>>   static void piix4_realize(PCIDevice *pci, Error **errp)
>>   {
>>       DeviceState *dev = DEVICE(pci);
>> @@ -96,6 +125,12 @@ static void piix4_realize(PCIDevice *pci, Error **errp)
>>                        pci_address_space_io(pci), errp)) {
>>           return;
>>       }
>> +
>> +    memory_region_init_io(&s->rcr_mem, OBJECT(dev), &piix4_rcr_ops, s,
>> +                          "reset-control", 1);
>> +    memory_region_add_subregion_overlap(pci_address_space_io(pci), 0xcf9,
>> +                                        &s->rcr_mem, 1);
>> +
>>       piix4_dev = pci;
>>       qemu_register_reset(piix4_reset, s);
>>   }
>>
> 
> 

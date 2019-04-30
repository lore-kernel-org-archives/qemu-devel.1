Received: from eggs.gnu.org ([209.51.188.92]:60120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLPWv-0004ie-JB
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLPWt-000712-Da
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:58:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLPWt-0006yb-3a
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:58:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id w15so3136694wmc.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 02:58:24 -0700 (PDT)
References: <20190422195020.1494-1-philmd@redhat.com>
	<20190422195020.1494-6-philmd@redhat.com>
	<ccbc2340-1f33-000f-0f7e-051b67337a85@redhat.com>
	<7064b823-3016-142f-5b1b-28a46fd6272a@redhat.com>
	<45ec325e-a245-56da-aeb3-405851c0764d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a7aebc7d-faf7-feed-5d5a-0182ca26292b@redhat.com>
Date: Tue, 30 Apr 2019 11:58:21 +0200
MIME-Version: 1.0
In-Reply-To: <45ec325e-a245-56da-aeb3-405851c0764d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 5/7] hw/ppc: Implement
 fw_cfg_arch_key_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

On 4/30/19 11:41 AM, Laszlo Ersek wrote:
> On 04/29/19 18:01, Philippe Mathieu-Daudé wrote:
>> Hi Laszlo,
>>
>> On 4/23/19 9:02 PM, Laszlo Ersek wrote:
>>> On 04/22/19 21:50, Philippe Mathieu-Daudé wrote:
>>>> Implement fw_cfg_arch_key_name(), which returns the name of a
>>>> ppc-specific key.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> ---
>>>>  hw/ppc/Makefile.objs |  2 +-
>>>>  hw/ppc/fw_cfg.c      | 45 ++++++++++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 46 insertions(+), 1 deletion(-)
>>>>  create mode 100644 hw/ppc/fw_cfg.c
>>>>
>>>> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
>>>> index 1111b218a04..ae940981553 100644
>>>> --- a/hw/ppc/Makefile.objs
>>>> +++ b/hw/ppc/Makefile.objs
>>>> @@ -1,5 +1,5 @@
>>>>  # shared objects
>>>> -obj-y += ppc.o ppc_booke.o fdt.o
>>>> +obj-y += ppc.o ppc_booke.o fdt.o fw_cfg.o
>>>>  # IBM pSeries (sPAPR)
>>>>  obj-$(CONFIG_PSERIES) += spapr.o spapr_caps.o spapr_vio.o spapr_events.o
>>>>  obj-$(CONFIG_PSERIES) += spapr_hcall.o spapr_iommu.o spapr_rtas.o
>>>> diff --git a/hw/ppc/fw_cfg.c b/hw/ppc/fw_cfg.c
>>>> new file mode 100644
>>>> index 00000000000..a88b5c4bde2
>>>> --- /dev/null
>>>> +++ b/hw/ppc/fw_cfg.c
>>>> @@ -0,0 +1,45 @@
>>>> +/*
>>>> + * fw_cfg helpers (PPC specific)
>>>> + *
>>>> + * Copyright (c) 2019 Red Hat, Inc.
>>>> + *
>>>> + * Author:
>>>> + *   Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> + *
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + *
>>>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>>>> + * See the COPYING file in the top-level directory.
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "hw/ppc/ppc.h"
>>>> +#include "hw/nvram/fw_cfg.h"
>>>> +
>>>> +const char *fw_cfg_arch_key_name(uint16_t key)
>>>> +{
>>>> +    static const struct {
>>>> +        uint16_t key;
>>>> +        const char *name;
>>>> +    } fw_cfg_arch_wellknown_keys[] = {
>>>> +        {FW_CFG_PPC_WIDTH, "width"},
>>>> +        {FW_CFG_PPC_HEIGHT, "height"},
>>>> +        {FW_CFG_PPC_DEPTH, "depth"},
>>>> +        {FW_CFG_PPC_TBFREQ, "tbfreq"},
>>>> +        {FW_CFG_PPC_CLOCKFREQ, "clockfreq"},
>>>> +        {FW_CFG_PPC_IS_KVM, "is_kvm"},
>>>> +        {FW_CFG_PPC_KVM_HC, "kvm_hc"},
>>>> +        {FW_CFG_PPC_KVM_PID, "pid"},
>>>> +        {FW_CFG_PPC_NVRAM_ADDR, "nvram_addr"},
>>>> +        {FW_CFG_PPC_BUSFREQ, "busfreq"},
>>>> +        {FW_CFG_PPC_NVRAM_FLAT, "nvram_flat"},
>>>> +        {FW_CFG_PPC_VIACONFIG, "viaconfig"},
>>>> +    };
>>>> +
>>>> +    for (size_t i = 0; i < ARRAY_SIZE(fw_cfg_arch_wellknown_keys); i++) {
>>>> +        if (fw_cfg_arch_wellknown_keys[i].key == key) {
>>>> +            return fw_cfg_arch_wellknown_keys[i].name;
>>>> +        }
>>>> +    }
>>>> +    return NULL;
>>>> +}
>>>>
>>>
>>> (1) Have you considered extracting the struct type, and the linear
>>> search, to code that's shared between the arches?
>>>
>>> It might suffice to make only the "fw_cfg_arch_wellknown_keys" array
>>> target-specific.
>>
>> Yes, I tried different ways:
>>
>> 1/ Declare as extern
>>
>> If we declare the array as 'extern const', we can no more use the
>> ARRAY_SIZE() macro, so we have to use an 'extern const size_t' too.
>> (No need to use a getter() since the array is *const*).
>>
>> I personally try to avoid extern variables when possible, I find them
>> bug prone.
>>
>> 2/ Add a macro in the header, use it in each source
>>
>> The macro is ugly to read, the result looked worse to me.
>>
>> 3/ I don't expect new keys to be added often, and adding them will be
>> trivial 1-line patch each key.
>>
>> I might be unaware of better ways to deduplicate this, so if you have
>> suggestions I'm happy to learn :)
> 
> In the loop condition, you could replace ARRAY_SIZE with a terminator
> element check, and you could terminate the arrays with an
> 
>   { FW_CFG_INVALID, NULL }
> 
> element. Then the loop could be extracted, and you wouldn't need further
> size_t globals, for replacing ARRAY_SIZE.

Clever, I forgot this way :>

> 
> But, again, it's not that important.
> 
> Thanks,
> Laszlo
> 
>>> (It's not complex code so I don't mind if you opt for the code duplication.)
>>>
>>> (2) PPC highlights my question#2 from under "v3 3/7". Namely, we
>>> extracted the x86 constants into "hw/i386/fw_cfg.h". But the PPC
>>> constants already exist in "include/hw/ppc/ppc.h". (My point being the
>>> difference in the "include/" pathname prefix.) Should we be consistent?
>>
>> I'd like to be consistent :)
>>
>> So far only machines set fw_cfg keys.
>>
>> I don't see arch-specific devices accessing arch-specific fw_cfg keys,
>> so we might move arch-specific key definitions in hw/$ARCH/fw_cfg.h (not
>> include/hw/$ARCH/fw_cfg.h).
>>
>>> If you decide to stick with this variant:
>>>
>>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>>
>> Thanks!
>>
>>>
>>> Thanks
>>> Laszlo
>>>
> 

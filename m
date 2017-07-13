Received: from eggs.gnu.org ([2001:4830:134:3::10]:48577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dVg7g-0004lO-OL
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dVg7f-0007ie-MA
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:33:48 -0400
References: <1499825297-20335-1-git-send-email-gengdongjiu@huawei.com>
	<1499825297-20335-2-git-send-email-gengdongjiu@huawei.com>
	<74ac9b79-0225-0cab-559f-6204754de5f0@redhat.com>
	<47cc803a-d1d9-da3b-43f9-31a54ce290e2@huawei.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ca0eaafd-21b7-9cf8-91aa-8c4e2c5d95e3@redhat.com>
Date: Thu, 13 Jul 2017 17:33:30 +0200
MIME-Version: 1.0
In-Reply-To: <47cc803a-d1d9-da3b-43f9-31a54ce290e2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/3] ACPI: Add new ACPI structures and
 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>, mst@redhat.com, imammedo@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, zhaoshenglong@huawei.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, james.morse@arm.com, zhengqiang10@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, Gaozhihui <zhihui.gao@huawei.com>

On 07/13/17 14:00, gengdongjiu wrote:
> Laszlo,
>   Thank you for your review and comments.
> 
> 
> On 2017/7/13 18:33, Laszlo Ersek wrote:
>> On 07/12/17 04:08, Dongjiu Geng wrote:

[snip]

>>> --- a/include/qemu/uuid.h
>>> +++ b/include/qemu/uuid.h
>>> @@ -44,6 +44,17 @@ typedef struct {
>>>  
>>>  #define UUID_NONE "00000000-0000-0000-0000-000000000000"
>>>  
>>> +#define UUID_BE(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)        \
>>> +{{{ ((a) >> 24) & 0xff, ((a) >> 16) & 0xff, ((a) >> 8) & 0xff, (a) & 0xff, \
>>> +   ((b) >> 8) & 0xff, (b) & 0xff,                   \
>>> +    ((c) >> 8) & 0xff, (c) & 0xff,                    \
>>> +    (d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7) } } }
>>> +
>>> +/* Platform Memory, this is from UEFI 2.6 N.2.2 Section Descriptor */
>>> +#define UEFI_CPER_SEC_PLATFORM_MEM                   \
>>> +    UUID_BE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
>>> +    0xED, 0x7C, 0x83, 0xB1)
>>> +
>>>  void qemu_uuid_generate(QemuUUID *out);
>>>  
>>>  int qemu_uuid_is_null(const QemuUUID *uu);
>>>
>>
>> (e) I think the addition of UUID_BE should be split out to a separate
>> patch; it adds a general facility. It should likely be the very first
>> patch in the series.
>   Ok.
> 
>>
>> (f) While I think it is justified to have UUID_BE() in "qemu/uuid.h", I
>> think UEFI_CPER_SEC_PLATFORM_MEM is too specific to have here.
>>
>> If UEFI_CPER_SEC_PLATFORM_MEM were *not* a standardized UUID, I would
>> suggest moving it to the implementation ("include/hw/acpi/hest_ghes.h"
>> -- which in turn should be moved to patch #2, see my remark (d)), *plus*
>> I would suggest eliminating the new #include from "acpi-defs.h", see my
>> remark (b).
>   understand your idea.
> 
>>
>> However, given that this UUID *is* standard, I suggest keeping the (b)
>> #include as you currently propose, and to move the definition of
>> UEFI_CPER_SEC_PLATFORM_MEM to "acpi-defs.h".
>   I agree with you.
> 
>>
>> I vaguely recall that Michael commented on this previously, but I don't
>> remember what he said. Michael, are you OK with my suggestion?
>    Laszlo, I pasted Michael's comments here, as shown below. Michael said the definition
> should use build_append_int_noprefix to add data. but I think it may not good, becuase
> the section "UEFI_CPER_SEC_PLATFORM_MEM" is runtime recorded as CPER, not a ACPI/HEST
> table member, so it is not generated when system boot up.

I agree: the UUID in question is not placed into the ACPI payload /
fw_cfg blobs, it is written into guest memory at runtime, into the
firmware-allocated area, if and when there is a hardware error to report.

Thanks
Laszlo

> On the other hand,UEFI_CPER_SEC_PLATFORM_MEM
> definition is from UEFI spec 2.6, N.2.2 Section Descriptor: {0xA5BC1114, 0x6F64, 0x4EDE, {0xB8, 0x63, 0x3E, 0x83, 0xED, 0x7C, 0x83, 0xB1}}.
> if use  build_append_int_noprefix to add, may confuse others.
> 
> -----------------------------------------------------------------
> -----------------------------------------------------------------
> There's no reason to define these messy one-time use macros.
> They just make it hard to look things up in the spec.
> 
> 
> You can use build_append_int_noprefix to add data of
> any length in LE format.
> -----------------------------------------------------------------
> -----------------------------------------------------------------
> 
> Hi  Michael,
>   what is your suggestion about it? do you agree with Laszlo?

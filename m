Received: from eggs.gnu.org ([2001:4830:134:3::10]:58059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dFN8o-0004ga-PG
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dFN8k-0006Wt-Qa
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:03:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dFN8k-0006WP-HV
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:03:30 -0400
References: <0184EA26B2509940AA629AE1405DD7F2014105CD@DGGEMA503-MBS.china.huawei.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3a791060-170d-9eb7-b2c4-f1cdbb55501f@redhat.com>
Date: Mon, 29 May 2017 18:03:20 +0200
MIME-Version: 1.0
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F2014105CD@DGGEMA503-MBS.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/4] ACPI: Add APEI GHES Table
 Generation support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Zhaoshenglong <zhaoshenglong@huawei.com>, James Morse <james.morse@arm.com>, Christoffer Dall <cdall@linaro.org>, Xiexiuqi <xiexiuqi@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "andre.przywara@arm.com" <andre.przywara@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "vladimir.murzin@arm.com" <vladimir.murzin@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>, Wuquanming <wuquanming@huawei.com>, Huangshaoyu <huangshaoyu@huawei.com>, "Leif.Lindholm@linaro.com" <Leif.Lindholm@linaro.com>"nd@arm.com" <nd@arm.com>, Michael Tsirkin <mtsirkin@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Hi,

did you remove me from the To: / Cc: list intentionally, or was that an
oversight? I caught your message in my list folders only by luck.

Some followup below:

On 05/29/17 17:27, gengdongjiu wrote:

>> (46) What is "physical_addr" good for? Below I can only see an 
>> assignment to it, in ghes_update_guest(). Where is the field read?

> this "physical_addr" address is the physical error address in the
> CPER. such as the physical address that happen hwpoison, this address
> is delivered by the KVM and QEMU transfer this address to physical.
I understand that in the ghes_update_guest() function, you accept a
parameter called "physical_address", and you pass it on to
ghes_generate_cper_record(). That makes sense, yes.

However, you also assign the same value to "ges.physical_addr". And that
structure field is never read. So my point is that the
"GhesErrorState.physical_addr" field is superfluous and should be removed.

I checked the other three patches in the series and they don't seem to
read that structure member either. Correct me if I'm wrong.

>> (55) What happens if you run out of the preallocated memory?

> if it run out of the preallocated memory. it will overwrite other 
> error source. every block's size is fixed. so it does not easy
> dynamically extend the size if it is overflow. Anyway I will add a
> error report if it happens overwrite.
I understand (and agree) that dynamic allocation is not possible here.

But that doesn't justify overwriting the error status data block that
belongs to a different data source. (Worse, if this happens with the
last error status data block, for error source 10, you could overwrite
memory that belongs to the OS.)

If an error status data block becomes full, then we should either wrap
back to the start of the same data block, or else stop forwarding errors
for that error source.

Does the ACPI spec say anything about this? I.e., about the case when
the system runs out of the memory that was reserved for recording
hardware errors?

>>>> +
>>>> +    mem_err = (struct cper_sec_mem_err *) (gdata + 1);
>>>> +
>>>> +    /* In order to simplify simulation, hardcode the CPER section to memory
>>>> +     * section.
>>>> +     */
>>>> +    mem_err->validation_bits |= CPER_MEM_VALID_ERROR_TYPE;
>>>> +    mem_err->error_type = 3;
>>
>> (58) Is this supposed to stand for "Multi-bit ECC" (from "N.2.5 Memory 
>> Error Section" in UEFI 2.6)? Should we have a macro for that?

> Yes, it is. What do you mean a macro?

A #define for the integer value 3.

> For all the errors that happen in the guest OS, in order to simulate
> easy, I abstract all the error section to memory section, even though
> the error section is processor or other section.
Why is that a valid thing to do? (I'm not doubting it is valid, I'm just
asking.) Will that not confuse the ACPI subsystem of the guest OS?

> I do not know whether do you have some suggestion for that.
Well I would have thought (without any expertise on the subject) that
hardware errors from the host side should be mapped to the guest more or
less "type correct". IOW, it looks strange that, say, a CPU error is
reported as a memory error. But this is just an uneducated guess.

>>>> +    mem_err->validation_bits |= CPER_MEM_VALID_CARD | CPER_MEM_VALID_MODULE |
>>>> +            CPER_MEM_VALID_BANK | CPER_MEM_VALID_ROW |
>>>> +            CPER_MEM_VALID_COLUMN | CPER_MEM_VALID_BIT_POSITION;
>>>> +    mem_err->card = 1;
>>>> +    mem_err->module = 2;
>>>> +    mem_err->bank = 3;
>>>> +    mem_err->row = 1;
>>>> +    mem_err->column = 2;
>>>> +    mem_err->bit_pos = 5;
>>
>> (60) I have no idea where these values come from.

> For all the errors that happen in the guest OS, in order to simulate
> easy, I abstract all the error section to memory section, and hard
> code the memory section error value as above.
Sure, but why is that safe? Will the guest OS not want to do something
about these error details? If we are feeding the guest OS invalid error
details, will that not lead to confusion?

>> (64) What does "reqr" stand for?
> It stand for the request size.
Can you please call it "req_size" or something similar? The English
expression

  request size

contains only one "r" letter, so it's hard to understand where the
second "r" in "reqr" comes from.

Thanks,
Laszlo

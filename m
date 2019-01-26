Received: from eggs.gnu.org ([209.51.188.92]:47040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnU8E-0002Rv-Ai
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 15:00:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnU8C-0008Ub-Sj
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 15:00:46 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnU8C-0008S9-MU
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 15:00:44 -0500
Received: by mail-ot1-x344.google.com with SMTP id s13so11546525otq.4
	for <qemu-devel@nongnu.org>; Sat, 26 Jan 2019 12:00:43 -0800 (PST)
References: <1648289.tQCHxfjYn9@basile.remlab.net>
	<20190125214926.3204-1-remi@remlab.net>
	<02a680e1-c20c-2ecb-2926-6250fddf9e76@linaro.org>
	<1738864.GFcTaivyIR@basile.remlab.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <50c441e3-84da-01a8-c1c6-d76a64412cc6@linaro.org>
Date: Sat, 26 Jan 2019 12:00:38 -0800
MIME-Version: 1.0
In-Reply-To: <1738864.GFcTaivyIR@basile.remlab.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/3] target/arm: fix AArch64
 virtual address space size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?R=c3=a9mi_Denis-Courmont?= <remi@remlab.net>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org

On 1/25/19 10:36 PM, Rémi Denis-Courmont wrote:
> 	Hi,
> 
> Le lauantaina 26. tammikuuta 2019, 1.29.27 EET Richard Henderson a écrit :
>> On 1/25/19 1:49 PM, Rémi Denis-Courmont wrote:
>>> From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
>>>
>>> Since QEMU does not support the ARMv8.2-LVA, Large Virtual Address,
>>> extension (yet), the VA address space is signed 48-bits. User mode can
>>> only handle the positive half of the address space, so that makes a
>>> limit of 47 bits.
>>>
>>> (With LVA, it would be 52 and 51 bits respectively.)
>>>
>>> The incorrectly large address space conflicts with PAuth instructions,
>>> which bits 48-54 and 56-63 for the pointer authentication code. This
>>> also conflicts with (as yet unsupported by QEMU) data tagging and with
>>> the ARMv8.5-MTE extension.
>>>
>>> Signed-off-by: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
>>> ---
>>>
>>>  target/arm/cpu.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>>> index ff81db420d..2ccd04b8f7 100644
>>> --- a/target/arm/cpu.h
>>> +++ b/target/arm/cpu.h
>>> @@ -2503,7 +2503,7 @@ bool write_cpustate_to_list(ARMCPU *cpu);
>>>
>>>  #if defined(TARGET_AARCH64)
>>>  #  define TARGET_PHYS_ADDR_SPACE_BITS 48
>>>
>>> -#  define TARGET_VIRT_ADDR_SPACE_BITS 64
>>> +#  define TARGET_VIRT_ADDR_SPACE_BITS 47
>>>
>>>  #else
>>>  #  define TARGET_PHYS_ADDR_SPACE_BITS 40
>>>  #  define TARGET_VIRT_ADDR_SPACE_BITS 32
>>
>> This doesn't really conflict, as this doesn't affect much besides the sizing
>> of the PageDesc for page_find.
> 
> Uh, that value controls the range of target virtual addresses user mode maps 
> to host virtual addresses. Without this patch, AFAICT, there are no 
> guarantees, only chance, that emulated system calls such as mmap() will not 
> allocate architecturally invalid addresses.

Well, that's the theory, yes.

On the plus side, the host platform that virtually everyone uses, x86_64, also
uses a 48-bit virtual address space, so there's no chance of such an invalid
address.

On the minus side, the code within target_mmap is not sufficient to ensure that
mmap will not produce invalid addresses.

See 76393642ae6, where I extended target/alpha TARGET_VIRT_ADDR_SPACE_BITS to
63 to work around exactly this problem.  To wit: target_mmap loops forever
asking the kernel for an address below 2**40, which the kernel refused to provide.

So changing this value for target/arm runs the risk of causing
aarch64-linux-user to fail on a ppc64/s390x/sparc64 host.  For all of the tens
of people around the world that care about such a configuration.


r~

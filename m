Received: from eggs.gnu.org ([2001:4830:134:3::10]:37094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ewTyl-0003uX-8Y
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ewTyh-0007Zi-9w
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:35:39 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:51137)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ewTyh-0007Y1-0V
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:35:35 -0400
References: <20180314153121.23838-1-james.cowgill@mips.com>
	<46dbae6e-4ff6-5003-e8e6-175bf0fbd51f@vivier.eu>
	<20e6165d-70b2-d1ec-1c46-7ede39a8d816@mips.com>
	<fbbc625b-1bcc-ab60-8998-b2b1653105fd@vivier.eu>
	<74331770-2eac-4af7-dc4b-b4dc20fbba46@mips.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <6447da5d-a0eb-ee28-ffa3-72f75c625faa@vivier.eu>
Date: Thu, 15 Mar 2018 15:35:10 +0100
MIME-Version: 1.0
In-Reply-To: <74331770-2eac-4af7-dc4b-b4dc20fbba46@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: implement HWCAP bits on MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Cowgill <james.cowgill@mips.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Le 15/03/2018 à 15:19, James Cowgill a écrit :
> Hi,
> 
> On 15/03/18 13:00, Laurent Vivier wrote:
>> Le 15/03/2018 à 11:52, James Cowgill a écrit :
>>> Hi,
>>>
>>> On 14/03/18 16:13, Laurent Vivier wrote:
>>>> Le 14/03/2018 à 16:31, James Cowgill a écrit :
>>>>> +enum {
>>>>> +    HWCAP_MIPS_R6           = (1 << 0),
>>>>> +    HWCAP_MIPS_MSA          = (1 << 1),
>>>>> +};
>>>>
>>>> We have this for ARM only in elfload.c since:
>>>>
>>>>     afce2927aa Arm AT_HWCAP AUXV entry (Paul Brook) [2005]
>>>>
>>>> but they have been added in include/elf.h since:
>>>>
>>>>     41d9ea80ac tcg-arm: Use qemu_getauxval [Richard Henderson, 2013]
>>>>
>>>> and I think we should remove them (they are prefixed by ARM_)
>>>>
>>>> So the MIPS ones should be in include/elf.h (with the #define form).
>>>
>>> I can do that, although I think it's a bit unusual. The HWCAP bits are
>>> specific to the Linux kernel and not to "the MIPS ELF format" so it
>>> doesn't make sense to me to put them in elf.h.
>>
>> In fact, in a system, they come with the glibc <sys/auxv.h>. auxv.h
>> includes <elf.h> and <bits/hwcap.h>. They are both part of glibc.
> 
> None of the headers you mention contain hwcap bits. They are usually
> provided in an arch specific kernel header - on MIPS they are in
> <asm/hwcap.h> which must be included separately.
> 
>> They can be used with qemu_getauxval() so it's better to have them in a
>> header file. elfoad.c or elf.h, it's in both cases an ELF file.
> 
> I agree with that.
> 
> I tried to move them to elf.h but hit a slight problem. In elfload.c,
> elf.h is included after all the target specific stuff so the
> get_elf_hwcap function cannot use anything from elf.h. I think this has
> lead to all architectures replicating the list of hwcap bits in both
> elf.h and elfload.c. You mentioned arm before, but I can also see
> aarch64, powerpc and sh4 do this. Some of these architectures also have
> their bits (with different constant names) in elf.h and some do not.

OK, you're right. That's sad to have duplicated values...

So your patch is correct. Perhaps just fix the typo in the path name for
hwcap.h.

Thanks,
Laurent

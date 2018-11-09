Received: from eggs.gnu.org ([2001:4830:134:3::10]:36080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhijianx.li@intel.com>) id 1gL74h-0007ew-Kx
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhijianx.li@intel.com>) id 1gL74e-0003Tr-CZ
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:43:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:20644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhijianx.li@intel.com>)
	id 1gL74d-0003LB-VW
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:43:48 -0500
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
	<CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
	<c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
	<20181109072015.GA86700@gmail.com>
	<38905d35-29af-b522-1629-b13e98a47a42@intel.com>
	<d30b404d-624e-0497-879a-2d5df2eb9f31@suse.com>
From: Li Zhijian <zhijianx.li@intel.com>
Message-ID: <b7b608dc-1743-5e1f-3b88-94d784c4cab2@intel.com>
Date: Fri, 9 Nov 2018 21:40:36 +0800
MIME-Version: 1.0
In-Reply-To: <d30b404d-624e-0497-879a-2d5df2eb9f31@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 1/3] i386: set initrd_max to 4G - 1
 to allow up to 4G initrd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, x86@kernel.org, hpa@zytor.com, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, QEMU Developers <qemu-devel@nongnu.org>, Philip Li <philip.li@intel.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Kees Cook <keescook@chromium.org>

Just noticed that there is a field xloadflags at recent protocol
   60 Protocol 2.12:  (Kernel 3.8) Added the xloadflags field and extension fields
   61                 to struct boot_params for loading bzImage and ramdisk
   62                 above 4G in 64bit.
[snip]
  617 Field name:     xloadflags
  618 Type:           read
  619 Offset/size:    0x236/2
  620 Protocol:       2.12+
  621
  622   This field is a bitmask.
  623
  624   Bit 0 (read): XLF_KERNEL_64
  625         - If 1, this kernel has the legacy 64-bit entry point at 0x200.
  626
  627   Bit 1 (read): XLF_CAN_BE_LOADED_ABOVE_4G
  628         - If 1, kernel/boot_params/cmdline/ramdisk can be above 4G.
  629

maybe we can reuse this field and append a new Bit 5 XLF_INITRD_MAX_SIZE_4G and increase header version.
For the old protocol version 2.12+, if  XLF_CAN_BE_LOADED_ABOVE_4G is set, we can also realize ~4GB initrd is allowed.

bootloader side:
if protocol >= 2.15
    if XLF_INITRD_LOAD_BELOW_4G
       support ~4G initrd
    fi
else if protocol >=2.12
    if XLF_CAN_BE_LOADED_ABOVE_4G
     support ~4G initrd
    fi
fi

thanks
Zhijian

  

On 11/9/2018 6:04 PM, Juergen Gross wrote:
> On 09/11/2018 10:57, Li Zhijian wrote:
>> On 11/9/2018 3:20 PM, Ingo Molnar wrote:
>>> * Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>>>
>>>>> If the kernel initrd creation process creates an initrd which
>>>>> is larger than 2GB and also claims that it can't be placed
>>>>> with any part of it above 2GB, then that sounds like a bug
>>>>> in the initrd creation process...
>>>> Exactly, it's a real problem.
>>>>
>>>> Add x86 maintainers and LKML:
>>>>
>>>> The background is that QEMU want to support up to 4G initrd. but
>>>> linux header (
>>>> initrd_addr_max field) only allow 2G-1.
>>>> Is one of the below approaches reasonable:
>>>> 1) change initrd_addr_max to 4G-1 directly
>>>> simply(arch/x86/boot/header.S)?
>>>> 2) lie QEMU bootloader the initrd_addr_max is 4G-1 even though header
>>>> said 2G-1
>>>> 3) any else
>>> A 10 years old comment from hpa says:
>>>
>>>     initrd_addr_max: .long 0x7fffffff
>>>                                           # (Header version 0x0203 or
>>> later)
>>>                                           # The highest safe address for
>>>                                           # the contents of an initrd
>>>                                           # The current kernel allows
>>> up to 4 GB,
>>>                                           # but leave it at 2 GB to avoid
>>>                                           # possible bootloader bugs.
>>>
>>> To avoid the potential of bugs lurking in dozens of major and hundreds of
>>> minor iterations of various Linux bootloaders I'd prefer a real solution
>>> and extend it - because if there's a 2GB initrd for some weird reason
>>> today there might be a 4GB one in two years.
>> thank a lots. that's amazing.
>>
>>
>>> The real solution would be to:
>>>
>>>    - Extend the boot protocol with a 64-bit field, named initrd_addr64_max
>>>      or such.
>>>    - We don't change the old field - but if the new field is set by new
>>>      kernels then new bootloaders can use that as a new initrd_addr64_max
>>>      value. (or reject to load the kernel if the address is too high.)
>>>
>>>    - The kernel build should also emit a warning when building larger than
>>>      2GB initrds, with a list of bootloaders that support the new
>>> protocol.
>> Actually i just knew QEMU(Seabios + optionrom(linuxboot_dma.bin)) can
>> support ~4GB initrd so far.
>>
>> i just drafted at patch to add this field. could you have a look.
>> another patch which is to document initrd_addr64_max is ongoing.
>>
>> commit db463ac9c1975f115d1ce2acb82d530c2b63b888
>> Author: Li Zhijian <lizhijian@cn.fujitsu.com>
>> Date:   Fri Nov 9 17:24:14 2018 +0800
>>
>>      x86: Add header field initrd_addr64_max
>>          Years ago, kernel had support load ~4GB initrd. But for some
>> weird reasons (
>>      avoid possible bootloader bugs), it only allow leave initrd under
>> 2GB address
>>      space(see initrd_addr_max fild at arch/x86/boot/header.S).
>>          So modern bootloaders have not chance to load >=2G initrd
>> previously.
>>          To avoid the potential of bugs lurking in dozens of major and
>> hundreds of
>>      minor iterations of various Linux bootloaders. Ingo suggests to add
>> a new field
>>      initrd_addr64_max. If bootloader believes that it can load initrd to
>>> =2G
>>      address space, it can use initrd_addr64_max as the maximum loading
>> address in
>>      stead of the old field initrd_addr_max.
>>
>> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
>> index 4c881c8..5fc3ebe 100644
>> --- a/arch/x86/boot/header.S
>> +++ b/arch/x86/boot/header.S
>> @@ -300,7 +300,7 @@ _start:
>>          # Part 2 of the header, from the old setup.S
>>   
>>                  .ascii  "HdrS"          # header signature
>> -               .word   0x020e          # header version number (>= 0x0105)
>> +               .word   0x020f          # header version number (>= 0x0105)
>>                                          # or else old loadlin-1.5 will
>> fail)
>>                  .globl realmode_swtch
>>   realmode_swtch:        .word   0, 0            # default_switch, SETUPSEG
>> @@ -562,6 +562,12 @@ acpi_rsdp_addr:            .quad 0
>> # 64-bit physical pointer to the
>>                                                  # ACPI RSDP table, added
>> with
>>                                                  # version 2.14
>>   
>> +#ifdef CONFIG_INITRD_SIZE_4GB
>> +initrd_addr64_max:     .quad 0xffffffff        # allow ~4G initrd since
>> 2.15
>> +#else
>> +initrd_addr64_max:     .quad 0
> Shouldn't this be 0x7fffffff?
>
> And please update Documentation/x86/boot.txt
>
>
> Juergen

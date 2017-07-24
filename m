Received: from eggs.gnu.org ([2001:4830:134:3::10]:60981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZbwY-0007rl-S5
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZbwX-0005vj-Ur
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:54:34 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:36566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZbwX-0005un-NK
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:54:33 -0400
Received: by mail-wm0-x22d.google.com with SMTP id t201so16603874wmt.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 04:54:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPTzt1DDFomJ-c57_e5HXGUH3L=pR6jEGwkap6Wsr4Z04SmMjg@mail.gmail.com>
References: <CAPTzt1Ai9x4OiHMH4HrDzj=vNbqhNnkmdDQ7wBLxYTJ-kcNM_w@mail.gmail.com>
	<CAFEAcA_TYFbv9EeafV8FZ=HEXx=kArVb2OYiC3mGQiP7_N1-UA@mail.gmail.com>
	<CAPTzt1ACBuwkY0YSjhMLrv+1OJyCLEM7xQZqTGKbxxsLfqVN=g@mail.gmail.com>
	<CAFEAcA9TUxr0ZfpNBuSc+jaz2e6mHtQwdo-s-DK=HjJe7bAFXA@mail.gmail.com>
	<CAPTzt1CYxudRK_TUVk2_=H0GHZxK5GDSaVzhQE9Pyw+=Jy-ajg@mail.gmail.com>
	<CAFEAcA8yzFNr1sGLgDq=u0naYhst5EstJxMje_8OvUN8CJ1AEg@mail.gmail.com>
	<CAPTzt1DDFomJ-c57_e5HXGUH3L=pR6jEGwkap6Wsr4Z04SmMjg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 12:54:11 +0100
Message-ID: <CAFEAcA8QnUN6ZRYSUR1GBMU_yfW0a3rWd5H8kmerrNhQ5rwbkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/core/loader: do not check for regions
 overlap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hua Yanghao <huayanghao@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 24 July 2017 at 12:42, Hua Yanghao <huayanghao@gmail.com> wrote:

>> If you're hitting this error case then I think the
>> affected segments must both be of type PT_LOAD.
>> (If you're not sure you can post here the output
>> of running 'objdump -p' on the binary or otherwise
>> show us the program header.)
>
> Here is the objdump -p:
> hua@grass:~/git/usw $ arm-none-eabi-objdump -p
> output/qemu_arm_vexpress/qemu_arm
>                               _vexpress.elf
>
> output/qemu_arm_vexpress/qemu_arm_vexpress.elf:     file format elf32-littlearm
>
> Program Header:
> 0x70000001 off    0x00076e6c vaddr 0x60076d8c paddr 0x60076d8c align 2**2
>          filesz 0x00000008 memsz 0x00000008 flags r--
>     LOAD off    0x000000e0 vaddr 0x60000000 paddr 0x60000000 align 2**5
>          filesz 0x0007773c memsz 0x00077c00 flags rwx
>     LOAD off    0x00077820 vaddr 0x70000000 paddr 0x60077740 align 2**3
>          filesz 0x00000038 memsz 0x00000038 flags r-x
>     LOAD off    0x00077858 vaddr 0x70080000 paddr 0x60077780 align 2**3
>          filesz 0x00000038 memsz 0x00000038 flags r-x
>     LOAD off    0x00077890 vaddr 0x70090000 paddr 0x600777c0 align 2**3
>          filesz 0x00000038 memsz 0x00000038 flags r-x
> private flags = 5000200: [Version5 EABI] [soft-float ABI]

> rom: requested regions overlap (rom phdr #2:
> output/qemu_arm_vexpress/qemu_arm_vexpress.elf.
> free=0x0000000060077c00, addr=0x0000000060077740)

Yep, this is complaining because you have two LOAD
segments which overlap:
     LOAD off    0x000000e0 vaddr 0x60000000 paddr 0x60000000 align 2**5
          filesz 0x0007773c memsz 0x00077c00 flags rwx

which goes from 0x60000000 up to 0x600077bff, and

     LOAD off    0x00077820 vaddr 0x70000000 paddr 0x60077740 align 2**3
          filesz 0x00000038 memsz 0x00000038 flags r-x

which starts at 0x60077740, in the middle of the previous one.
So should the loader honour the first of these segment
definitions (which says "fill it with zeroes", because the
memsz is greater than the filesz), or the second (which says
"fill it with data from the file") ?
Also, it has different rwx flags -- so are you asking for the
memory to be rwx or r-x ?  (This kind of inconsistency is why
overlapping segments are weird.)

>> PS: you're consistently saying "section", but in the
>> ELF format "section" and "segment" are two different
>> things. QEMU doesn't actually look at the section table.
>> In an ELF file, sections are used by the linker, but a
>> program loader like QEMU (or the Linux kernel)
>> looks only at the segment table in the program header.
> Yes I am looking from the "section" perspective.
> As I intentionally want two sections to overlap (.bss and the lmu
> section starting from LMA _lmu0_load_start).
> I know loaders only care about segments. :-)

Right, but QEMU only cares about segments and the check
you're trying to disable is a *segment* overlap check,
not a section overlap check. You can overlap sections
all you want as long as you don't end up with a final
ELF file with overlapping segments...

thanks
-- PMM

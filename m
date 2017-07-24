Received: from eggs.gnu.org ([2001:4830:134:3::10]:59517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <huayanghao@gmail.com>) id 1dZblA-0004gH-JE
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <huayanghao@gmail.com>) id 1dZbl9-0001UG-Ee
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:42:48 -0400
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:36234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <huayanghao@gmail.com>)
	id 1dZbl9-0001Td-8U
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:42:47 -0400
Received: by mail-yw0-x243.google.com with SMTP id i6so1594113ywb.3
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 04:42:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8yzFNr1sGLgDq=u0naYhst5EstJxMje_8OvUN8CJ1AEg@mail.gmail.com>
References: <CAPTzt1Ai9x4OiHMH4HrDzj=vNbqhNnkmdDQ7wBLxYTJ-kcNM_w@mail.gmail.com>
	<CAFEAcA_TYFbv9EeafV8FZ=HEXx=kArVb2OYiC3mGQiP7_N1-UA@mail.gmail.com>
	<CAPTzt1ACBuwkY0YSjhMLrv+1OJyCLEM7xQZqTGKbxxsLfqVN=g@mail.gmail.com>
	<CAFEAcA9TUxr0ZfpNBuSc+jaz2e6mHtQwdo-s-DK=HjJe7bAFXA@mail.gmail.com>
	<CAPTzt1CYxudRK_TUVk2_=H0GHZxK5GDSaVzhQE9Pyw+=Jy-ajg@mail.gmail.com>
	<CAFEAcA8yzFNr1sGLgDq=u0naYhst5EstJxMje_8OvUN8CJ1AEg@mail.gmail.com>
From: Hua Yanghao <huayanghao@gmail.com>
Date: Mon, 24 Jul 2017 13:42:46 +0200
Message-ID: <CAPTzt1DDFomJ-c57_e5HXGUH3L=pR6jEGwkap6Wsr4Z04SmMjg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

> I have seen ELF files which have this overlap and
> where both segments are PT_LOAD. (I think in the cases
> I've seen the contents in both segments agree rather than
> being different data, but a loader is not going to be
> expected to do a comparison of the file data.)
Hmm ... OK. there are definitely things I haven't seen :-)

>> So for me just ignore NOLOAD section would do the trick.
>
> We already ignore all the ELF segments which are not
> of type PT_LOAD:
> http://git.qemu.org/?p=qemu.git;a=blob;f=include/hw/elf_ops.h;h=a172a6068a48e233dd802043b3304a9e0a5d3be6;hb=HEAD#l353
>
> If you're hitting this error case then I think the
> affected segments must both be of type PT_LOAD.
> (If you're not sure you can post here the output
> of running 'objdump -p' on the binary or otherwise
> show us the program header.)

Here is the objdump -p:
hua@grass:~/git/usw $ arm-none-eabi-objdump -p
output/qemu_arm_vexpress/qemu_arm
                              _vexpress.elf

output/qemu_arm_vexpress/qemu_arm_vexpress.elf:     file format elf32-littlearm

Program Header:
0x70000001 off    0x00076e6c vaddr 0x60076d8c paddr 0x60076d8c align 2**2
         filesz 0x00000008 memsz 0x00000008 flags r--
    LOAD off    0x000000e0 vaddr 0x60000000 paddr 0x60000000 align 2**5
         filesz 0x0007773c memsz 0x00077c00 flags rwx
    LOAD off    0x00077820 vaddr 0x70000000 paddr 0x60077740 align 2**3
         filesz 0x00000038 memsz 0x00000038 flags r-x
    LOAD off    0x00077858 vaddr 0x70080000 paddr 0x60077780 align 2**3
         filesz 0x00000038 memsz 0x00000038 flags r-x
    LOAD off    0x00077890 vaddr 0x70090000 paddr 0x600777c0 align 2**3
         filesz 0x00000038 memsz 0x00000038 flags r-x
private flags = 5000200: [Version5 EABI] [soft-float ABI]

hua@grass:~/git/usw $ nm output/^C
hua@grass:~/git/usw $ arm-none-eabi-nm
output/qemu_arm_vexpress/qemu_arm_vexpress.elf | sort | grep bss
60077738 B __bss_start
60077c00 B __bss_end
hua@grass:~/git/usw $ configs/qemu_arm_vexpress.py run
Note: you must have a locally modified qemu-system-arm to work with this build!
Please contact Hua Yanghao for more details!
echo "==> Ctrl-A X to exit"; export QEMU_AUDIO_DRV="none";
qemu-system-arm -M vexpress-a9 -m 512M -smp cpus=1 -nographic -kernel
output/qemu_arm_vexpress/qemu_arm_vexpress.elf
==> Ctrl-A X to exit
rom: requested regions overlap (rom phdr #2:
output/qemu_arm_vexpress/qemu_arm_vexpress.elf.
free=0x0000000060077c00, addr=0x0000000060077740)
qemu-system-arm: rom check and register reset failed
hua@grass:~/git/usw $ arm-none-eabi-nm
output/qemu_arm_vexpress/qemu_arm_vexpress.elf | sort | grep 60077c00
60077c00 B __bss_end
60077c00 B _heap_low
hua@grass:~/git/usw $ arm-none-eabi-nm
output/qemu_arm_vexpress/qemu_arm_vexpress.elf | sort | grep 60077740
60077740 T _lmu0_load_start
60077740 T _lmu_load_start
hua@grass:~/git/usw $ arm-none-eabi-nm
output/qemu_arm_vexpress/qemu_arm_vexpress.elf | sort | grep lmu0
6006a458 t __lmu0_veneer
60077740 T _lmu0_load_start
60077778 T _lmu0_load_end
70000000 t lmu0
70000000 T _lmu0_start
70000038 T _lmu0_end
hua@grass:~/git/usw $


> PS: you're consistently saying "section", but in the
> ELF format "section" and "segment" are two different
> things. QEMU doesn't actually look at the section table.
> In an ELF file, sections are used by the linker, but a
> program loader like QEMU (or the Linux kernel)
> looks only at the segment table in the program header.
Yes I am looking from the "section" perspective.
As I intentionally want two sections to overlap (.bss and the lmu
section starting from LMA _lmu0_load_start).
I know loaders only care about segments. :-)

BR, Yanghao

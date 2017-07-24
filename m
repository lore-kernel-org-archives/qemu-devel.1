Received: from eggs.gnu.org ([2001:4830:134:3::10]:38581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <huayanghao@gmail.com>) id 1dZcAy-0002hc-Em
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <huayanghao@gmail.com>) id 1dZcAx-0004Vk-4M
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:09:28 -0400
Received: from mail-yw0-x230.google.com ([2607:f8b0:4002:c05::230]:36202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <huayanghao@gmail.com>)
	id 1dZcAw-0004Va-Vw
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:09:27 -0400
Received: by mail-yw0-x230.google.com with SMTP id a12so47012310ywh.3
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 05:09:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8QnUN6ZRYSUR1GBMU_yfW0a3rWd5H8kmerrNhQ5rwbkg@mail.gmail.com>
References: <CAPTzt1Ai9x4OiHMH4HrDzj=vNbqhNnkmdDQ7wBLxYTJ-kcNM_w@mail.gmail.com>
	<CAFEAcA_TYFbv9EeafV8FZ=HEXx=kArVb2OYiC3mGQiP7_N1-UA@mail.gmail.com>
	<CAPTzt1ACBuwkY0YSjhMLrv+1OJyCLEM7xQZqTGKbxxsLfqVN=g@mail.gmail.com>
	<CAFEAcA9TUxr0ZfpNBuSc+jaz2e6mHtQwdo-s-DK=HjJe7bAFXA@mail.gmail.com>
	<CAPTzt1CYxudRK_TUVk2_=H0GHZxK5GDSaVzhQE9Pyw+=Jy-ajg@mail.gmail.com>
	<CAFEAcA8yzFNr1sGLgDq=u0naYhst5EstJxMje_8OvUN8CJ1AEg@mail.gmail.com>
	<CAPTzt1DDFomJ-c57_e5HXGUH3L=pR6jEGwkap6Wsr4Z04SmMjg@mail.gmail.com>
	<CAFEAcA8QnUN6ZRYSUR1GBMU_yfW0a3rWd5H8kmerrNhQ5rwbkg@mail.gmail.com>
From: Hua Yanghao <huayanghao@gmail.com>
Date: Mon, 24 Jul 2017 14:09:25 +0200
Message-ID: <CAPTzt1COW1yQs-1LE5TnUXf_v10jKvAU0wq=-7jK7S=fpuKh9Q@mail.gmail.com>
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

> Yep, this is complaining because you have two LOAD
> segments which overlap:
>      LOAD off    0x000000e0 vaddr 0x60000000 paddr 0x60000000 align 2**5
>           filesz 0x0007773c memsz 0x00077c00 flags rwx
>
> which goes from 0x60000000 up to 0x600077bff, and
>
>      LOAD off    0x00077820 vaddr 0x70000000 paddr 0x60077740 align 2**3
>           filesz 0x00000038 memsz 0x00000038 flags r-x
>
> which starts at 0x60077740, in the middle of the previous one.
> So should the loader honour the first of these segment
> definitions (which says "fill it with zeroes", because the
> memsz is greater than the filesz), or the second (which says
> "fill it with data from the file") ?
> Also, it has different rwx flags -- so are you asking for the
> memory to be rwx or r-x ?  (This kind of inconsistency is why
> overlapping segments are weird.)

I don't quite understand how those load segments are created.
Bear with me, from section point of view, 0x600077740 is both
the .bss (which is NOLOAD) and the .lmu0 section. Why this bss
section could end up in a loadable segments? I don't understand
how those rwx/r-x permission are created from my linker script all
memory regions share the same rwx attribute:

 11 MEMORY
 12 {
 13     dram (rwx) : ORIGIN = CONFIG_DRAM_START, LENGTH = CONFIG_DRAM_SIZE
 14     lmu0 (rwx) : ORIGIN = CONFIG_LMU0_START, LENGTH = CONFIG_LMU0_SIZE
 15     lmu1 (rwx) : ORIGIN = CONFIG_LMU1_START, LENGTH = CONFIG_LMU1_SIZE
 16     lmu2 (rwx) : ORIGIN = CONFIG_LMU2_START, LENGTH = CONFIG_LMU2_SIZE
 17 }

output/qemu_arm_vexpress/qemu_arm_vexpress.elf | sort | grep bss
60077738 B __bss_start
60077c00 B __bss_end

from this link: http://nairobi-embedded.org/040_elf_sec_seg_vma_mappings.html
It seems segments do consider NOLOAD .bss sections as part of loadable
data segments.
Does the loader needs to consider more things from the segments table
to distinguish that
the .bss section actually does not need to be touched?

BR, Yanghao

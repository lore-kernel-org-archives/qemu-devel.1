Received: from eggs.gnu.org ([2001:4830:134:3::10]:33168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZNkK-000602-UB
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 16:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZNkJ-0007vC-VD
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 16:45:01 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZNkJ-0007tG-NX
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 16:44:59 -0400
Received: by mail-wm0-x22b.google.com with SMTP id m85so3124349wma.1
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 13:44:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPTzt1Ai9x4OiHMH4HrDzj=vNbqhNnkmdDQ7wBLxYTJ-kcNM_w@mail.gmail.com>
References: <CAPTzt1Ai9x4OiHMH4HrDzj=vNbqhNnkmdDQ7wBLxYTJ-kcNM_w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 23 Jul 2017 21:44:37 +0100
Message-ID: <CAFEAcA_TYFbv9EeafV8FZ=HEXx=kArVb2OYiC3mGQiP7_N1-UA@mail.gmail.com>
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

On 23 July 2017 at 21:04, Hua Yanghao <huayanghao@gmail.com> wrote:
> From 84f25a8e4269f44255a8037837fdaa6e5404b76e Mon Sep 17 00:00:00 2001
> From: Hua Yanghao <yanghao.hua@intel.com>
> Date: Sun, 23 Jul 2017 21:48:21 +0200
> Subject: [PATCH] hw/core/loader: do not check for regions overlap
>
> There is a use case where regions are overlapped on purpose.
> It should be up to the linker to check for regions overlap and qemu should
> better not to do so.
>
> For example:
> SECTIONS
> {
>     ...... /* the normal text/data */
>     _on_chip_ram_load_start = .;
>     . = . + SIZEOF(.on_chip_ram_section);
>     _on_chip_ram_load_end = .;
>
>     .bss (NOLOAD) {
>         *(.bss*)
>         *(COM*)
>     }
>     ...... /* other things */
> }

(I'm not sure why you end up with overlapping
program segments here since the bss segment ought
to be marked NOLOAD and ignored by QEMU. But I've
definitely seen overlapping segments myself where
the segments overlapping both are marked as LOAD.)

> with current hw/core/loader implementation, .bss section consumes no LMU address
> space as .bss is not a loadable section, it is only useful for VMA at runtime.
> Where the .on_chip_ram_section is told to be loaded (LMA) from the VMA of .bss
> section. And qemu complains and exits. This patch fixes the issue and tested
> running fine for the above scenario.
> ---

Oddly enough, I just ran into this scenario with an
ELF file myself the other day, and worked around it
with pretty much the same kind of local hack as this.
I agree that since this kind of ELF file with overlapping
segments seems to be quite common we should load it,
rather than complaining.

But...

(1) does this change give the right behaviour for
which of the two overlapping segment is honoured?
(I *think* the correct answer is that the second
segment in the program header table should be
loaded second, ie its definition of the memory
contents is used, not that of the first segment)

(2) should we allow the overlap only for ELF files but
retain the complain for overlapping ROMs of other types?
(eg by having the elf loader create "rom"s which
don't overlap by trimming the overlap itself)

Does anybody know (a) what the ELF spec mandates
for overlapping segments and (b) what the history
and rationale for QEMU's overlapping-roms check is?

thanks
-- PMM

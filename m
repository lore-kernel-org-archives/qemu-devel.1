Received: from eggs.gnu.org ([2001:4830:134:3::10]:34662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <huayanghao@gmail.com>) id 1dZNx2-0001E6-RJ
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 16:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <huayanghao@gmail.com>) id 1dZNx2-0004Zj-2p
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 16:58:08 -0400
Received: from mail-yb0-x241.google.com ([2607:f8b0:4002:c09::241]:34964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <huayanghao@gmail.com>)
	id 1dZNx1-0004ZO-T9
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 16:58:08 -0400
Received: by mail-yb0-x241.google.com with SMTP id f135so2966414yba.2
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 13:58:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_TYFbv9EeafV8FZ=HEXx=kArVb2OYiC3mGQiP7_N1-UA@mail.gmail.com>
References: <CAPTzt1Ai9x4OiHMH4HrDzj=vNbqhNnkmdDQ7wBLxYTJ-kcNM_w@mail.gmail.com>
	<CAFEAcA_TYFbv9EeafV8FZ=HEXx=kArVb2OYiC3mGQiP7_N1-UA@mail.gmail.com>
From: Hua Yanghao <huayanghao@gmail.com>
Date: Sun, 23 Jul 2017 22:58:06 +0200
Message-ID: <CAPTzt1ACBuwkY0YSjhMLrv+1OJyCLEM7xQZqTGKbxxsLfqVN=g@mail.gmail.com>
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

> (I'm not sure why you end up with overlapping
> program segments here since the bss segment ought
> to be marked NOLOAD and ignored by QEMU. But I've
> definitely seen overlapping segments myself where
> the segments overlapping both are marked as LOAD.)
Looks like qemu is not ignoring NOLOAD seciton check and used its VMA
as if it is LMA ...
If I remove the NOLOAD then .bss consumesthe LMA addresss and
everything is working fine.

> Oddly enough, I just ran into this scenario with an
> ELF file myself the other day, and worked around it
> with pretty much the same kind of local hack as this.
> I agree that since this kind of ELF file with overlapping
> segments seems to be quite common we should load it,
> rather than complaining.
Good to know I am not the only one who hit this issue ;-)

> But...
>
> (1) does this change give the right behaviour for
> which of the two overlapping segment is honoured?
> (I *think* the correct answer is that the second
> segment in the program header table should be
> loaded second, ie its definition of the memory
> contents is used, not that of the first segment)
I am not sure if I understood this point. linker will check for
section overlaps and if linker
did not complain why should qemu complain. qemu should simply follow
the LMA for each
section and ignore NOLOAD section for me this is the sane behavior.

> (2) should we allow the overlap only for ELF files but
> retain the complain for overlapping ROMs of other types?
> (eg by having the elf loader create "rom"s which
> don't overlap by trimming the overlap itself)
I think this should only apply for ELF files. (this is the only thing
I care or understood so far,
so not touching other types of input binaries ... however I am not
sure if I am capable to provide
a right patch to handle the ROM files properly, I only looked into
qemu code starting today ...)

> Does anybody know (a) what the ELF spec mandates
> for overlapping segments and (b) what the history
> and rationale for QEMU's overlapping-roms check is?
>
> thanks
> -- PMM

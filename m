Received: from eggs.gnu.org ([2001:4830:134:3::10]:45142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZcTg-0004JT-2Z
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZcTf-0006PW-8e
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:28:48 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:37532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZcTe-0006Ov-Vw
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:28:47 -0400
Received: by mail-wr0-x22a.google.com with SMTP id 33so48992519wrz.4
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 05:28:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPTzt1CatyAKdeGdr1jp0xsudgrjKETA1MULj1oEcHkkyG99DA@mail.gmail.com>
References: <CAPTzt1Ai9x4OiHMH4HrDzj=vNbqhNnkmdDQ7wBLxYTJ-kcNM_w@mail.gmail.com>
	<CAFEAcA_TYFbv9EeafV8FZ=HEXx=kArVb2OYiC3mGQiP7_N1-UA@mail.gmail.com>
	<CAPTzt1ACBuwkY0YSjhMLrv+1OJyCLEM7xQZqTGKbxxsLfqVN=g@mail.gmail.com>
	<CAFEAcA9TUxr0ZfpNBuSc+jaz2e6mHtQwdo-s-DK=HjJe7bAFXA@mail.gmail.com>
	<CAPTzt1CYxudRK_TUVk2_=H0GHZxK5GDSaVzhQE9Pyw+=Jy-ajg@mail.gmail.com>
	<CAFEAcA8yzFNr1sGLgDq=u0naYhst5EstJxMje_8OvUN8CJ1AEg@mail.gmail.com>
	<CAPTzt1DDFomJ-c57_e5HXGUH3L=pR6jEGwkap6Wsr4Z04SmMjg@mail.gmail.com>
	<CAFEAcA8QnUN6ZRYSUR1GBMU_yfW0a3rWd5H8kmerrNhQ5rwbkg@mail.gmail.com>
	<CAPTzt1COW1yQs-1LE5TnUXf_v10jKvAU0wq=-7jK7S=fpuKh9Q@mail.gmail.com>
	<CAPTzt1CatyAKdeGdr1jp0xsudgrjKETA1MULj1oEcHkkyG99DA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 13:28:25 +0100
Message-ID: <CAFEAcA_teDg34FbzWYsC05utw8cx9S6=Xy1rZ=sQfuJr5CHedQ@mail.gmail.com>
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

On 24 July 2017 at 13:21, Hua Yanghao <huayanghao@gmail.com> wrote:
> I think I got where qemu went wrong, it should pick filesz instead of
> memsz, right? ;-)
>
> You see here the filesz does not actually include the bss section
> where if you only check the memsz then it overlaps.
>
>     LOAD off    0x000000e0 vaddr 0x60000000 paddr 0x60000000 align 2**5
>          filesz 0x0007773c memsz 0x00077c00 flags rwx
>
> -----
> PT_LOAD
>
> The array element specifies a loadable segment, described by p_filesz
> and p_memsz. The bytes from the file are mapped to the beginning of
> the memory segment. If the segment's memory size (p_memsz) is larger
> than the file size (p_filesz), the "extra" bytes are defined to hold
> the value 0 and to follow the segment's initialized area. The file
> size may not be larger than the memory size. Loadable segment entries
> in the program header table appear in ascending order,
>
> sorted on the p_vaddr member.
> -----

In the bit of the spec you quote it says how p_memsz > p_filesz
should be handled: "the 'extra' bytes are defined to hold the
value 0". The segment itself is still p_memsz in size and the
header defines that it has zeroes at the end of it. QEMU's loader
needs to arrange that those zeroes are loaded.

thanks
-- PMM
